include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "adset.view"
include: "fivetran_base.view"

explore: ad {
  hidden: yes

  join: adset {
    type: left_outer
    sql_on: ${ad.adset_id} = ${adset.id} ;;
    relationship: many_to_one
  }

  join: campaign {
    type: left_outer
    sql_on: ${adset.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }
}

view: ad {
  extends: [fivetran_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.ad ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: adset_id {
    hidden: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }
}
