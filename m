Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8673DA5DC
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167241; cv=none; b=Ak8KXh+I1vl7yKE72m7sGEAl0js+mkOSbuCOVMCnU+ZGKanICy3offymzznS4xri2sSsqzRmMuKXfaYL01E19QmXC+jF/leRmHYyJeRNmp/KPFtFa9a8zsFeW3IZjiURbXNkwce1ciXcpPqdlu7LvXWHqCFEDNh12WvHFiLyThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167241; c=relaxed/simple;
	bh=sR4VZB6nBWpqoyNmrzumziJWaNPWT5Ta+6UmJ+pF3Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ngm7Us+YAbHK9SgKleudyzRhwkldExoDqaL5HgBt/M4RjhCQLKm9R0rvA55RUvksmLfjHwafbX87hKYeFYZda1gc3a2r11rSsgqRv2mb57Hw/Q0zik7b6wFX/tlfzAeDrh9IJX4fYJKVrhvqfQE8X/XeMwlajGQfa9TCh9O4OdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLiYwJDU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLiYwJDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/qS+nPc8j5i0RQhS+DSJfHNaI4k+rZzA7++z5urrbw=;
	b=dLiYwJDUAIclQSauT8/eG3JVgCHCcUuwFlZg7CYh6Fb/V/4J2AXZQ7QCfU4RNm1U28E+PK
	Zq8DKbweTuedMt54ZTqFHG7v0eAkMTtJkRyJ2OHDO/fCnXU0PwQgMYUAHs34we3LPPzs+W
	SrM2L3J87/VsNmme2ufSjy8Ffvo5rGk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-8FoS0nPAPu-kKNCjQSpZaA-1; Mon,
 31 Aug 2026 05:07:12 -0400
X-MC-Unique: 8FoS0nPAPu-kKNCjQSpZaA-1
X-Mimecast-MFC-AGG-ID: 8FoS0nPAPu-kKNCjQSpZaA_1788167231
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A404193E88D;
	Mon, 31 Aug 2026 09:07:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2536D18005BD;
	Mon, 31 Aug 2026 09:07:07 +0000 (UTC)
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
Subject: [RFC PATCH 04/20] rv: Use static arrays for rv_monitor name and description
Date: Mon, 31 Aug 2026 11:05:08 +0200
Message-ID: <20260831090524.106845-5-gmonaco@redhat.com>
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

Name and description in struct rv_monitor are currently defined as
pointers, which are assigned during initialisation. This means they are
not clearly in the structure and this can be a problem if the struct
needs to be reused in other contexts (like BPF's struct_opts).

Make the fields static arrays with defined size, limit the description
to 128 bytes (much longer than any current description). This slightly
increases the kernel size as the full space for the strings is reserved,
but that's a minor increase as each monitor has a single instance of
struct rv_monitor, total increase around 100B per monitor, uncompressed.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h   |  9 ++++++---
 kernel/trace/rv/rv.c | 10 +++++-----
 kernel/trace/rv/rv.h |  3 ---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 541ba404926a..a3a332b49747 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -7,7 +7,10 @@
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
 
-#define MAX_DA_NAME_LEN			32
+#define MAX_RV_MONITOR_NAME_SIZE	32
+#define MAX_RV_REACTOR_NAME_SIZE	32
+#define MAX_RV_DESCRIPTION_SIZE		128
+
 #define MAX_DA_RETRY_RACING_EVENTS	3
 
 #define RV_MON_GLOBAL   0
@@ -137,8 +140,8 @@ struct rv_reactor {
 #endif
 
 struct rv_monitor {
-	const char		*name;
-	const char		*description;
+	char			name[MAX_RV_MONITOR_NAME_SIZE];
+	char			description[MAX_RV_DESCRIPTION_SIZE];
 	bool			enabled;
 	int			(*enable)(void);
 	void			(*disable)(void);
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 29f155c6968b..f77c5865f41a 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -392,11 +392,11 @@ static ssize_t monitor_desc_read_data(struct file *filp, char __user *user_buf,
 				      loff_t *ppos)
 {
 	struct rv_monitor *mon = filp->private_data;
-	char buff[256];
+	char buff[MAX_RV_DESCRIPTION_SIZE + 2];
 
 	memset(buff, 0, sizeof(buff));
 
-	snprintf(buff, sizeof(buff), "%s\n", mon->description);
+	snprintf(buff, sizeof(buff), "%.*s\n", MAX_RV_DESCRIPTION_SIZE, mon->description);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
 }
@@ -756,9 +756,9 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 	struct rv_monitor *r;
 	int retval = 0;
 
-	if (strlen(monitor->name) >= MAX_RV_MONITOR_NAME_SIZE) {
-		pr_info("Monitor %s has a name longer than %d\n", monitor->name,
-			MAX_RV_MONITOR_NAME_SIZE);
+	if (strnlen(monitor->name, MAX_RV_MONITOR_NAME_SIZE) == MAX_RV_MONITOR_NAME_SIZE) {
+		pr_info("Monitor %.*s has a name longer than %d\n", MAX_RV_MONITOR_NAME_SIZE,
+			monitor->name, MAX_RV_MONITOR_NAME_SIZE);
 		return -EINVAL;
 	}
 
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 2c0f51ff9d5c..07512046e5cc 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -19,9 +19,6 @@ struct rv_interface {
 
 DEFINE_FREE(rv_remove, struct dentry *, if (_T) rv_remove(_T));
 
-#define MAX_RV_MONITOR_NAME_SIZE	32
-#define MAX_RV_REACTOR_NAME_SIZE	32
-
 extern struct mutex rv_interface_lock;
 extern struct list_head rv_monitors_list;
 
-- 
2.55.0

