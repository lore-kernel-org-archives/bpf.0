Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896003C1D4F
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167249; cv=none; b=tTbz8/E947zRbLnRdsGBZHit2eeoRi6ty672Yn85HyFCXfx1aS7ckVpIGsYU/hQoJPtmn02Ssg32YMHHYea/bpokTXKjc9KmSjSHpO6+IUwesKDAN0HmUa+Bnnhrn/WoyHdhAJi4O61XLGzmMYWHSL/nXZB44bQccPKCkk3pop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167249; c=relaxed/simple;
	bh=mjHNhB0GKsScSXsL5mV9BTT34DJUyPOPTHw7o+N3oqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy2crd+bq2eLTQwQ4ijXMwNjZCI5gkWmZDusuwlTmRoQoqUiyJuKnfEv95DpvoKA9Ig3opM7tn3QLauAK+vxG32/eyxfEwOBn0T+8fBbJ1R4OLmCyI9MhvUkcnePpZzOwsh9MQFM3yaOwq0BUPPrSMdbHBwMVnb96yuc9J3SvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwihV5y3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwihV5y3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osC9YIvYCLoTIMz23HH8P7/BrPk8KQ6tK0BnBySim50=;
	b=ZwihV5y33rBQhgJh+pFlLeG19m7ufHJe8NiJ3rB2DZzqXlJx+eJ1rix9ShpmxvqtK7WHPe
	ace40N8/+L3lhFzvMqVqSZEgJwfX8gzLD86iuzaLy1h0TDegM27XEmlNzKdFq0VTRa/oYD
	bbJhXx9AAj+cYZ/0ZfQPN4KutbmtviA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-dQ_XbCmQM3KVg3QZ7779DQ-1; Mon,
 31 Aug 2026 05:07:21 -0400
X-MC-Unique: dQ_XbCmQM3KVg3QZ7779DQ-1
X-Mimecast-MFC-AGG-ID: dQ_XbCmQM3KVg3QZ7779DQ_1788167240
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E32A1977534;
	Mon, 31 Aug 2026 09:07:20 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8CA5180034F;
	Mon, 31 Aug 2026 09:07:16 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 06/20] rv: Add rv_get_monitor_by_name()
Date: Mon, 31 Aug 2026 11:05:10 +0200
Message-ID: <20260831090524.106845-7-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a helper function to get the rv_monitor pointer for a registered
monitor given its name and add its first user in rv_register_monitor().

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv.c | 28 +++++++++++++++++++---------
 kernel/trace/rv/rv.h |  1 +
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index f77c5865f41a..33919c5fbd6a 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -142,6 +142,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/rculist.h>
 
 #ifdef CONFIG_RV_MON_EVENTS
 #define CREATE_TRACE_POINTS
@@ -229,6 +230,18 @@ bool rv_is_container_monitor(struct rv_monitor *mon)
 	return next->parent == mon || !mon->enable;
 }
 
+struct rv_monitor *rv_get_monitor_by_name(const char *name)
+{
+	struct rv_monitor *m;
+
+	list_for_each_entry_rcu(m, &rv_monitors_list, list,
+				lockdep_is_held(&rv_interface_lock)) {
+		if (strcmp(name, m->name) == 0)
+			return m;
+	}
+	return NULL;
+}
+
 /*
  * This section collects the monitor/ files and folders.
  */
@@ -753,7 +766,6 @@ static void destroy_monitor_dir(struct rv_monitor *mon)
  */
 int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 {
-	struct rv_monitor *r;
 	int retval = 0;
 
 	if (strnlen(monitor->name, MAX_RV_MONITOR_NAME_SIZE) == MAX_RV_MONITOR_NAME_SIZE) {
@@ -764,11 +776,9 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 
 	guard(mutex)(&rv_interface_lock);
 
-	list_for_each_entry(r, &rv_monitors_list, list) {
-		if (strcmp(monitor->name, r->name) == 0) {
-			pr_info("Monitor %s is already registered\n", monitor->name);
-			return -EEXIST;
-		}
+	if (rv_get_monitor_by_name(monitor->name)) {
+		pr_info("Monitor %s is already registered\n", monitor->name);
+		return -EEXIST;
 	}
 
 	if (parent && rv_is_nested_monitor(parent)) {
@@ -785,9 +795,9 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 
 	/* keep children close to the parent for easier visualisation */
 	if (parent)
-		list_add(&monitor->list, &parent->list);
+		list_add_rcu(&monitor->list, &parent->list);
 	else
-		list_add_tail(&monitor->list, &rv_monitors_list);
+		list_add_tail_rcu(&monitor->list, &rv_monitors_list);
 
 	return 0;
 }
@@ -803,7 +813,7 @@ int rv_unregister_monitor(struct rv_monitor *monitor)
 	guard(mutex)(&rv_interface_lock);
 
 	rv_disable_monitor(monitor);
-	list_del(&monitor->list);
+	list_del_rcu(&monitor->list);
 	destroy_monitor_dir(monitor);
 
 	return 0;
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 07512046e5cc..4d2c9cb284c9 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -27,6 +27,7 @@ int rv_disable_monitor(struct rv_monitor *mon);
 int rv_enable_monitor(struct rv_monitor *mon);
 bool rv_is_container_monitor(struct rv_monitor *mon);
 bool rv_is_nested_monitor(struct rv_monitor *mon);
+struct rv_monitor *rv_get_monitor_by_name(const char *name);
 
 #ifdef CONFIG_RV_REACTORS
 int reactor_populate_monitor(struct rv_monitor *mon, struct dentry *root);
-- 
2.55.0

