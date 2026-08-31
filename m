Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAAA3DAABD
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167252; cv=none; b=bT1BS9xWRkZnjM6iA3hNvuxz/0bWXC9IQZypTArHZCTPkAdKT1DY9zYhIMflL3m4wJxGGiNjgnb4vXXy0XHO1k78ZTgu/xhnU7i3F1fgB4ppHPB6PmRkHUzLM5nGPkJ/I2OLARg/DG7rZZlhTDpjRtaZbZ1Kt5JxIIVRBia2ZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167252; c=relaxed/simple;
	bh=BoR45k3q5o9YVGWscqsIDD+1+IXZyCFZRlspz+0cFnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEE7F+XQswOSaLB/LE7xuVIcdCBkWiqFbJb4PXdnV1xerTU22cWm4FysXOeO3lyyu3PmHgGho6sYCfNZEGZWgcYSnHrUS2lXuhjnmQVqLwsCEGtK+IA7wBrF72geMg0oinKZ4ZxVcz2QJePjB01FXKrhSUCzZ+TV0bx3BT/FCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bF7Fhoh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF7Fhoh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmriJ188EVhFMk186iDx29M8MLeYCr/PiV4RJlqkkHY=;
	b=bF7Fhoh1rywumngXe8DnbfUOHHCdONscZt92KgpmXOPxMMQpJvhTNGmfNMY6TnJn9PgSPw
	AQHaoogtmbsZ01Jfj5v+k8fDYJvm1cMMHpmRHbH9/x3Xqa9whJsI0oJEhhbngHz0rP+RV+
	GTtxa1G6alO9JhueBOqTneFI3dWnuDg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-oK-3V-ahPoqgv8U9FD-oMw-1; Mon,
 31 Aug 2026 05:07:25 -0400
X-MC-Unique: oK-3V-ahPoqgv8U9FD-oMw-1
X-Mimecast-MFC-AGG-ID: oK-3V-ahPoqgv8U9FD-oMw_1788167244
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4274A19539B6;
	Mon, 31 Aug 2026 09:07:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03EA718005BD;
	Mon, 31 Aug 2026 09:07:20 +0000 (UTC)
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
Subject: [RFC PATCH 07/20] rv: Add reactors support to BPF monitors
Date: Mon, 31 Aug 2026 11:05:11 +0200
Message-ID: <20260831090524.106845-8-gmonaco@redhat.com>
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

The struct_ops system allows BPF monitors to be assigned reactors
transparently, but calling rv_react() is something the monitors should
do and BPF monitors cannot, as well as they cannot easily get a pointer
to the rv_monitor structure.

Add a bpf_rv_react kfunc that finds the monitor pointer given its name
and triggers a reaction. Since variadic functions are complicated in
BPF, this kfunc receives a plain string, that should be populated by the
caller with some sort of sprintf().

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv_bpf.c | 62 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/rv/rv_bpf.c b/kernel/trace/rv/rv_bpf.c
index 0450bcaf1b79..90ac7af1edff 100644
--- a/kernel/trace/rv/rv_bpf.c
+++ b/kernel/trace/rv/rv_bpf.c
@@ -13,7 +13,9 @@
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/filter.h>
+#include <linux/uaccess.h>
 #include <linux/rv.h>
+#include "rv.h"
 
 static int bpf_rv_monitor_init(struct btf *btf)
 {
@@ -111,8 +113,62 @@ static struct bpf_struct_ops bpf_rv_monitor_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int __init bpf_rv_monitor_init_ops(void)
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_rv_react - trigger a reactor from BPF
+ * @name: monitor name
+ * @msg: pre-formatted message string
+ * @msg__sz: size of the msg buffer
+ *
+ * This kfunc allows BPF monitors to trigger reactors with a message.
+ * The message should be pre-formatted by the BPF program using bpf_snprintf.
+ */
+__bpf_kfunc void bpf_rv_react(char *name__str, char *msg, u32 msg__sz)
+{
+	struct rv_monitor *monitor;
+	char safe_msg[256];
+
+	if (msg__sz == 0)
+		return;
+	msg__sz = min_t(u32, msg__sz, sizeof(safe_msg));
+	if (strncpy_from_kernel_nofault(safe_msg, msg, msg__sz) < 0)
+		return;
+	safe_msg[msg__sz - 1] = '\0';
+
+	guard(rcu)();
+	monitor = rv_get_monitor_by_name(name__str);
+
+	if (monitor)
+		rv_react(monitor, "%s", safe_msg);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(rv_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_rv_react)
+BTF_KFUNCS_END(rv_kfunc_set_ids)
+
+static const struct btf_kfunc_id_set rv_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &rv_kfunc_set_ids,
+};
+
+static int __init rv_monitor_init_bpf(void)
 {
-	return register_bpf_struct_ops(&bpf_rv_monitor_ops, rv_monitor);
+	int ret;
+
+	ret = register_bpf_struct_ops(&bpf_rv_monitor_ops, rv_monitor);
+	if (ret) {
+		pr_err("rv: Failed to register struct_ops (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &rv_kfunc_set);
+	if (ret) {
+		pr_err("rv: Failed to register reactor kfunc (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+	return 0;
 }
-late_initcall(bpf_rv_monitor_init_ops);
+late_initcall(rv_monitor_init_bpf);
-- 
2.55.0

