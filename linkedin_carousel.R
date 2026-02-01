library(ggplot2)
library(dplyr)
library(tidyr)
library(forcats)
library(scales)
library(grid)
library(gridExtra)

# --- Load and prepare data ---
setwd("/Users/logio/Desktop/Data analyst Google/AnalisiIrlanda")
irish_rent_raw <- read.csv("irish_rent_by_county.csv")

irish_rent <- irish_rent_raw %>%
  filter(is_county_aggregate == "True") %>%
  select(rent_euro, year, county, province) %>%
  rename(Rent = rent_euro, Year = year, County = county, Province = province) %>%
  mutate(Year = as.integer(Year), Rent = as.numeric(Rent)) %>%
  group_by(County, Year, Province) %>%
  summarise(Rent = mean(Rent, na.rm = TRUE), .groups = "drop") %>%
  arrange(Year, County)

risultati <- irish_rent %>%
  filter(Year %in% c(2020, 2025)) %>%
  pivot_wider(names_from = Year, values_from = Rent, id_cols = c(County, Province)) %>%
  filter(!is.na(`2020`), !is.na(`2025`)) %>%
  mutate(
    Aumento_perc = ((`2025` - `2020`) / `2020`) * 100,
    Differenza_euro = `2025` - `2020`
  ) %>%
  arrange(desc(Aumento_perc)) %>%
  rename(Rent_2020 = `2020`, Rent_2025 = `2025`)

avg_increase <- round(mean(risultati$Aumento_perc), 1)
max_increase <- round(max(risultati$Aumento_perc), 1)
min_increase <- round(min(risultati$Aumento_perc), 1)
top_county <- risultati$County[1]

# --- Theme ---
bg_color <- "#0A1628"
text_color <- "#FFFFFF"
accent_color <- "#00D4AA"
accent2_color <- "#FF6B6B"
subtle_color <- "#8899AA"
card_color <- "#132039"

theme_slide <- theme_void() +
  theme(
    plot.background = element_rect(fill = bg_color, color = NA),
    panel.background = element_rect(fill = bg_color, color = NA),
    plot.margin = margin(40, 40, 40, 40)
  )

# --- PDF ---
pdf("linkedin_carousel.pdf", width = 10, height = 10)

# ===== SLIDE 1: Cover =====
grid.newpage()
grid.rect(gp = gpar(fill = bg_color, col = NA))
grid.text("I Analyzed 5 Years\nof Rent Data\nin Ireland", x = 0.5, y = 0.6,
          gp = gpar(col = text_color, fontsize = 44, fontface = "bold", lineheight = 1.2),
          just = "center")
grid.text("Here's what I found.", x = 0.5, y = 0.35,
          gp = gpar(col = accent_color, fontsize = 28, fontface = "italic"))
grid.text("2020 - 2025  |  26 Counties  |  Real Data", x = 0.5, y = 0.22,
          gp = gpar(col = subtle_color, fontsize = 16))
grid.text("Swipe >>", x = 0.5, y = 0.08,
          gp = gpar(col = subtle_color, fontsize = 14))

# ===== SLIDE 2: The Context =====
grid.newpage()
grid.rect(gp = gpar(fill = bg_color, col = NA))
grid.text("The Context", x = 0.5, y = 0.85,
          gp = gpar(col = accent_color, fontsize = 36, fontface = "bold"))
grid.text(
  "Ireland is facing one of the worst\nhousing crises in Europe.\n\nI analyzed official rent data across\nall 26 counties from 2020 to 2025\nto understand how much rents\nhave actually increased.",
  x = 0.5, y = 0.55,
  gp = gpar(col = text_color, fontsize = 22, lineheight = 1.4),
  just = "center")
grid.text("Dataset: Irish Rent by County (semi-annual, aggregated yearly)",
          x = 0.5, y = 0.15,
          gp = gpar(col = subtle_color, fontsize = 14))

# ===== SLIDE 3: The Key Number =====
grid.newpage()
grid.rect(gp = gpar(fill = bg_color, col = NA))
grid.text("Average Rent Increase", x = 0.5, y = 0.78,
          gp = gpar(col = subtle_color, fontsize = 22))
grid.text(paste0("+", avg_increase, "%"), x = 0.5, y = 0.55,
          gp = gpar(col = accent2_color, fontsize = 120, fontface = "bold"))
grid.text("across all 26 counties\nin just 5 years", x = 0.5, y = 0.30,
          gp = gpar(col = text_color, fontsize = 24, lineheight = 1.3), just = "center")
grid.text(paste0("Highest: ", top_county, " (+", max_increase, "%)  |  Lowest: +", min_increase, "%"),
          x = 0.5, y = 0.12,
          gp = gpar(col = subtle_color, fontsize = 16))

# ===== SLIDE 4: Top 10 Counties Bar Chart =====
top10 <- risultati %>%
  slice_max(Aumento_perc, n = 10) %>%
  mutate(County = fct_reorder(County, Aumento_perc))

p4 <- ggplot(top10, aes(x = Aumento_perc, y = County, fill = Aumento_perc)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0("+", round(Aumento_perc, 1), "%")),
            hjust = -0.1, color = text_color, size = 5, fontface = "bold") +
  scale_fill_gradient(low = "#FF6B6B", high = "#FF2D2D", guide = "none") +
  scale_x_continuous(expand = expansion(mult = c(0, 0.25))) +
  labs(title = "Top 10 Counties by Rent Increase (2020-2025)",
       x = NULL, y = NULL) +
  theme_slide +
  theme(
    plot.title = element_text(color = accent_color, size = 20, face = "bold",
                              margin = margin(b = 20)),
    axis.text.y = element_text(color = text_color, size = 14),
    axis.text.x = element_blank(),
    panel.grid = element_blank()
  )
print(p4)

# ===== SLIDE 5: Trend Lines Top 10 =====
top_counties <- risultati %>%
  slice_max(Aumento_perc, n = 10) %>%
  pull(County)

trend_data <- irish_rent %>% filter(County %in% top_counties)

p5 <- ggplot(trend_data, aes(x = Year, y = Rent, color = County, group = County)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2.5) +
  scale_y_continuous(labels = label_currency(prefix = "EUR ")) +
  scale_x_continuous(breaks = 2020:2025) +
  scale_color_viridis_d(option = "turbo") +
  labs(title = "Rent Evolution - Top 10 Counties (2020-2025)",
       x = NULL, y = "Average Annual Rent (EUR)", color = NULL) +
  theme_slide +
  theme(
    plot.title = element_text(color = accent_color, size = 20, face = "bold",
                              margin = margin(b = 15)),
    axis.text = element_text(color = text_color, size = 12),
    axis.title.y = element_text(color = subtle_color, size = 13, margin = margin(r = 10)),
    legend.text = element_text(color = text_color, size = 11),
    legend.position = "bottom",
    legend.key = element_rect(fill = bg_color, color = NA),
    panel.grid.major = element_line(color = "#1a2d4a", linewidth = 0.3),
    panel.grid.minor = element_blank()
  ) +
  guides(color = guide_legend(nrow = 2))
print(p5)

# ===== SLIDE 6: Province Analysis =====
prov_stats <- risultati %>%
  group_by(Province) %>%
  summarise(avg_inc = mean(Aumento_perc), .groups = "drop") %>%
  mutate(Province = fct_reorder(Province, avg_inc))

p6 <- ggplot(prov_stats, aes(x = avg_inc, y = Province, fill = avg_inc)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0("+", round(avg_inc, 1), "%")),
            hjust = -0.1, color = text_color, size = 6, fontface = "bold") +
  scale_fill_gradient(low = "#3498db", high = "#FF6B6B", guide = "none") +
  scale_x_continuous(expand = expansion(mult = c(0, 0.3))) +
  labs(title = "Average Rent Increase by Province",
       x = NULL, y = NULL) +
  theme_slide +
  theme(
    plot.title = element_text(color = accent_color, size = 22, face = "bold",
                              margin = margin(b = 25)),
    axis.text.y = element_text(color = text_color, size = 18),
    axis.text.x = element_blank(),
    panel.grid = element_blank()
  )
print(p6)

# ===== SLIDE 7: Key Takeaways =====
grid.newpage()
grid.rect(gp = gpar(fill = bg_color, col = NA))
grid.text("Key Takeaways", x = 0.5, y = 0.88,
          gp = gpar(col = accent_color, fontsize = 36, fontface = "bold"))
grid.text(
  paste0(
    ">  Every single county saw rent increases\n\n",
    ">  The average increase was +", avg_increase, "% in 5 years\n\n",
    ">  ", top_county, " had the highest jump (+", max_increase, "%)\n\n",
    ">  Urban areas were hit harder than rural ones\n\n",
    ">  Leinster leads as the most expensive province"
  ),
  x = 0.12, y = 0.52,
  gp = gpar(col = text_color, fontsize = 21, lineheight = 1.5),
  just = c("left", "center"))

# ===== SLIDE 8: About Me / CTA =====
grid.newpage()
grid.rect(gp = gpar(fill = bg_color, col = NA))
grid.text("Giorgio Vernarecci", x = 0.5, y = 0.72,
          gp = gpar(col = text_color, fontsize = 38, fontface = "bold"))
grid.text("Data Analyst", x = 0.5, y = 0.62,
          gp = gpar(col = accent_color, fontsize = 26))
grid.text(
  "SQL  |  R  |  Python  |  Tableau  |  n8n",
  x = 0.5, y = 0.52,
  gp = gpar(col = subtle_color, fontsize = 18))
grid.text(
  "I turn raw data into clear,\nactionable insights.",
  x = 0.5, y = 0.38,
  gp = gpar(col = text_color, fontsize = 22, lineheight = 1.3),
  just = "center")
grid.text("Let's connect - follow me for more data stories.",
          x = 0.5, y = 0.20,
          gp = gpar(col = accent_color, fontsize = 18, fontface = "italic"))
grid.text("Analysis made with R  |  Full code on GitHub",
          x = 0.5, y = 0.08,
          gp = gpar(col = subtle_color, fontsize = 14))

dev.off()
cat("\n✓ Carousel PDF created: linkedin_carousel.pdf\n")
