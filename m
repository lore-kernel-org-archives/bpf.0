Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043F3DDAED
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167260; cv=none; b=FftdMX44+FchzUhnd6t0zRTQis/iy4DVExmPkJASB3KEU3dUajzalsVJGrf/thRsHID1jQYafSriWs3KzRxumHnqforyKI2QBPbVonalDhie0Vk4K9LQgBgwpYJUDlYQSbm4ERPukQJ45RoV1SpQxlQAuozqPi5jizp9lp4NLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167260; c=relaxed/simple;
	bh=+qV67Ar596nvxR1LzpkF9oPPwr0qUM+QM87yOpwM8ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci6RK58dKWwO3+4Vmd0lbAcdIlgD0H83sydEAkKg+Ifw3qDpnxGNWGopm19gA3gY9sYfnAvwr80Ok797IleXYSKfUrongIB5b9B4wWIVzEbzr7bojT+Shpw9TZrQNnwCn0YjGrsKymLztzfX9tA6fZSNjGWCcxRq6yjJ0AaLfyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f32K+CRj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f32K+CRj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cjis/B05Scr88Nzqwwo6UIDqHak36kTaKJ2jA+vrqPA=;
	b=f32K+CRjOgtqYyEaGZbsWIw3JQbS5IjInOdOkLs6zpzsQdw6AOlPO2sGSW1lPUy1P1JsV1
	mhvFDi/faW5bPTbG8bU+7bNBEBPLxY7iR0STW/gub5IvqAorfnhcWKE4Mv/Qs78qE+XFNh
	9TbvCrw9JCEPStWQZAwoF4LC4YHZjC4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-cfPM8NB5NN6Ue5h7KqYHQw-1; Mon,
 31 Aug 2026 05:07:34 -0400
X-MC-Unique: cfPM8NB5NN6Ue5h7KqYHQw-1
X-Mimecast-MFC-AGG-ID: cfPM8NB5NN6Ue5h7KqYHQw_1788167252
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECEE1977503;
	Mon, 31 Aug 2026 09:07:32 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42F0A18005BB;
	Mon, 31 Aug 2026 09:07:29 +0000 (UTC)
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
Subject: [RFC PATCH 09/20] rv: Handle unregistered monitors safely in tracefs
Date: Mon, 31 Aug 2026 11:05:13 +0200
Message-ID: <20260831090524.106845-10-gmonaco@redhat.com>
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

With the introduction of pluggable BPF monitors, a monitor can be
dynamically unregistered while its tracefs files are still open by a
userspace process. This leaves a dangling pointer in the tracefs file
descriptor's private_data.

Validate that the monitor pointer still exists in the rv_monitors_list
before dereferencing it during read/write operations and return an error
otherwise.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv.c          | 32 +++++++++++++++++++++++++++++---
 kernel/trace/rv/rv.h          |  1 +
 kernel/trace/rv/rv_reactors.c |  6 ++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 33919c5fbd6a..6ddd3b92da1d 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -245,13 +245,31 @@ struct rv_monitor *rv_get_monitor_by_name(const char *name)
 /*
  * This section collects the monitor/ files and folders.
  */
+
+bool rv_is_monitor_registered(struct rv_monitor *mon)
+{
+	struct rv_monitor *m;
+
+	list_for_each_entry_rcu(m, &rv_monitors_list, list,
+				lockdep_is_held(&rv_interface_lock)) {
+		if (m == mon)
+			return true;
+	}
+	return false;
+}
+
 static ssize_t monitor_enable_read_data(struct file *filp, char __user *user_buf, size_t count,
 					loff_t *ppos)
 {
 	struct rv_monitor *mon = filp->private_data;
 	const char *buff;
 
-	buff = mon->enabled ? "1\n" : "0\n";
+	scoped_guard(rcu) {
+		if (!rv_is_monitor_registered(mon))
+			return -ENODEV;
+
+		buff = mon->enabled ? "1\n" : "0\n";
+	}
 
 	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
 }
@@ -384,6 +402,9 @@ static ssize_t monitor_enable_write_data(struct file *filp, const char __user *u
 
 	guard(mutex)(&rv_interface_lock);
 
+	if (!rv_is_monitor_registered(mon))
+		return -ENODEV;
+
 	if (val)
 		retval = rv_enable_monitor(mon);
 	else
@@ -407,9 +428,14 @@ static ssize_t monitor_desc_read_data(struct file *filp, char __user *user_buf,
 	struct rv_monitor *mon = filp->private_data;
 	char buff[MAX_RV_DESCRIPTION_SIZE + 2];
 
-	memset(buff, 0, sizeof(buff));
+	scoped_guard(rcu) {
+		if (!rv_is_monitor_registered(mon))
+			return -ENODEV;
 
-	snprintf(buff, sizeof(buff), "%.*s\n", MAX_RV_DESCRIPTION_SIZE, mon->description);
+		memset(buff, 0, sizeof(buff));
+		snprintf(buff, sizeof(buff), "%.*s\n", MAX_RV_DESCRIPTION_SIZE,
+			 mon->description);
+	}
 
 	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
 }
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 4d2c9cb284c9..6650ee9de308 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -28,6 +28,7 @@ int rv_enable_monitor(struct rv_monitor *mon);
 bool rv_is_container_monitor(struct rv_monitor *mon);
 bool rv_is_nested_monitor(struct rv_monitor *mon);
 struct rv_monitor *rv_get_monitor_by_name(const char *name);
+bool rv_is_monitor_registered(struct rv_monitor *mon);
 
 #ifdef CONFIG_RV_REACTORS
 int reactor_populate_monitor(struct rv_monitor *mon, struct dentry *root);
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 2f5fc8d18dea..e23e0b5cc0ca 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -142,6 +142,9 @@ static int monitor_reactor_show(struct seq_file *m, void *p)
 	struct rv_monitor *mon = m->private;
 	struct rv_reactor *reactor = container_of(p, struct rv_reactor, list);
 
+	if (!rv_is_monitor_registered(mon))
+		return -ENODEV;
+
 	if (mon->reactor == reactor)
 		seq_printf(m, "[%s]\n", reactor->name);
 	else
@@ -235,6 +238,9 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 
 	guard(mutex)(&rv_interface_lock);
 
+	if (!rv_is_monitor_registered(mon))
+		return -ENODEV;
+
 	list_for_each_entry(reactor, &rv_reactors_list, list) {
 		if (strcmp(ptr, reactor->name) != 0)
 			continue;
-- 
2.55.0

