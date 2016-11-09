Deface::Override.new(:virtual_path => "spree/admin/shared/sub_menu/_configuration",
                     :name => "subscribe_admin_configurations_menu",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                     :text => "<%= configurations_sidebar_menu_item t(:subscriptions_config_label), admin_subscription_intervals_url %>",
                     :disabled => false)
