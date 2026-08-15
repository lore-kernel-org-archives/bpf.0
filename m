Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BD3A6B8F
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786792850; cv=none; b=YJxqeDsv8dL65gS030E8CtiOKbZdLwk8Hkbho47VZgMwIKts+f+FVxPVZX4elpd8wM3wiIn5x7A5853iqVcJx6x6YxM3ejAmrfJsOJYFvgHFP8Obw5jxp3pltFZGMg0EiP3Gd5gWqhy+Yy5k2hD2k25BaaSopzNrw2mG9horCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786792850; c=relaxed/simple;
	bh=XyDeqj2fD+0+G3mRSLG62bdrTVlYw2OMacrjdWijgkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAUDNPLdalAwCTf6sSJSjSviwD23AYG6Jdtf+uca8LL9ajYJeSBrT+0kumYjiikIwYigVP/+6xtxTNKUupNSjHSP/zOxj4bz8/cNxXGo0y9b838zanXL86C7xIUYgttDGaQIGo1Iq/iHYt2/D4M6RiDs+Vaka8HMkhCFhuHWMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBdXc3uX; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBdXc3uX"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66b3803ef19so3276170d50.2
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786792848; x=1787397648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pj7Fxr4MHKxBNNl7rVyxiVL6srT0xXkYcTtb3hLd+N0=;
        b=oBdXc3uXB5KSDW8gAAIZW3cd0PbRUAb6Rg5NRyioLs/34ZgbPnZYjj6kdjbiWr0C2b
         T5IzLPLD5WyZLVcu53eBpvSTZ3HUZwKsuCU/npWEonWqRBgbqtBuPEjxnTnub81tzbax
         RYSWuPLWMZtknIKoJAwvfeyBAv/nIyloxrrxWUmAYIF2NwFmohpyUK+wxS6KpT/HQc+U
         qaLhlgYAw8hsOZ2yeYfceLcjCm+8HWL7oEWa6cuAgPaK0C1Ae7s0HBit7E8beIREf2fG
         DIWL2GT2oDnBqNBdedXmr6AEDYhIPhjbYvYCIlo+59GTTjKNo35F23lrkVaHDPywioRw
         Ethg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786792848; x=1787397648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pj7Fxr4MHKxBNNl7rVyxiVL6srT0xXkYcTtb3hLd+N0=;
        b=W2ixGRZ4Gjuhmf6cr9+vQzvJWK3nfO0qqxbGUUeHjbo0oH65FlB/sFCpHIzNTjGrEv
         88junnN4XeRDVsjxwML7T74kvv+hWAUGmXs/Q7+mD+vPf7Oy2CaCwa5uRYUIHiHJ43br
         e6a7iLPm7zcTZN7NOLAyAKn/2JUoZJDTOG66QlquZbkns0KRVMRrGb31NvN9yo/xSWyj
         ygqLAluBbRF2f27pWcMpIp//jhonUjDUExxxEfvvdjYDwvi96xHCsv/4ZT4gWShc1Ylk
         +zAjD2vzGf43Q5Xc3G74rA45cBWZXJPnEJexerxiYpGOhX8c/Nhwo6bvMuhUnFwU3TFS
         hNmw==
X-Forwarded-Encrypted: i=1; AHgh+RpLNqJkoD+saKt/U2gLZ4nuvmOBoqujThND5YeqzwHKO5lV7fGBqkYacsNYOUoIJsyrMwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGhXnt9RXipmu4+H4b8WlWygpSdmiwXY0kC8pnbLExNvMQKmm
	YL/ukzVBfQkbGxxwNr4iQNQM2PjD1vBjaoWeCkegd+EWrP6UyXyF3Nqy
X-Gm-Gg: AR+sD12ssVnFxlLK0DL6Wnt0lm+eLNk3WRcHNLvD7w/9RNWhd46CjhQSBIGkSLbyI8U
	pswmpcY7hRZrQoNAYs4qFpc/g1XXUN9d/tq/aiqzKXHQABTQWb4F+cgD3/uGe7mJzWtoc5WpY5u
	UmaYKUJspUEnSSnxNrckIuuFtqaJvIsNwwZOp84zCSRembWLvAg2mrLth3/geIk/moPeU5WP+S2
	+JB2doCAFOdaUjG/RDyD7r+3+JMMmhgdamOjZZ2VlTtJ065hWO9t/RkmTzUW5DnVuOjdjlDMKEN
	nQ6agh8hRnDH8ovc1Z+Rh/bdSX8IXMsLRmAwZg6+uoufNQO6V8wz00wBQ6X2VreuGDQwT5NhcBj
	GgvubPqgZ5/tvBnPsa5eQlEAGsUO+CO++v/QIlRjER2yyYCdEJj3+zcHq6asc+zCswXgRjJklsM
	0xX47bs+m68pQC6bOxV5npiTeW2gk+UZfOM9OZ6i/ftBqvrApP7y2C2QmN2mI6QniIlf1tbtU1Q
	KHBQ+855MqyBBwwaTeaYvg=
X-Received: by 2002:a05:690e:1247:b0:66a:f513:5053 with SMTP id 956f58d0204a3-66c72b1bd27mr4460525d50.10.1786792847796;
        Sat, 15 Aug 2026 04:20:47 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:31f0:efe0:f2d8:ae44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c36a84d9sm24388037b3.46.2026.08.15.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:20:47 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 1/2] lsm: add bpf_security_locked_down() kfunc
Date: Sat, 15 Aug 2026 07:20:40 -0400
Message-ID: <20260815112041.1248855-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260815112041.1248855-1-utilityemal77@gmail.com>
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new kfunc bpf_security_locked_down, which calls
security_locked_down and returns the result.

Create a new file security/lsm_kfuncs.c for LSM framework kfuncs.

Reject reasons outside (LOCKDOWN_NONE, LOCKDOWN_CONFIDENTIALITY_MAX)
with -EINVAL before dispatching the hook. Limit the kfunc to
BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL programs, and refuse it
to programs attached to the locked_down hook itself, which would
recurse into the dispatch.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/Makefile     |  1 +
 security/lsm_kfuncs.c | 84 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 security/lsm_kfuncs.c

diff --git a/security/Makefile b/security/Makefile
index 4601230ba442..dee8ff218548 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o lsm_init.o
+obj-$(CONFIG_BPF_SYSCALL)		+= lsm_kfuncs.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/lsm_kfuncs.c b/security/lsm_kfuncs.c
new file mode 100644
index 000000000000..a324e7d978ca
--- /dev/null
+++ b/security/lsm_kfuncs.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kfuncs exposing LSM interfaces to BPF programs.
+ *
+ * Copyright (C) 2026 Justin Suess
+ */
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/init.h>
+#include <linux/security.h>
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_security_locked_down - Call the security_locked_down() LSM hook
+ * @what: lockdown reason to query
+ *
+ * Return: 0 if @what is not locked down, -EPERM if it is, or -EINVAL if
+ * @what is outside (LOCKDOWN_NONE, LOCKDOWN_CONFIDENTIALITY_MAX).
+ */
+__bpf_kfunc int bpf_security_locked_down(enum lockdown_reason what)
+{
+	if (what <= LOCKDOWN_NONE || what >= LOCKDOWN_CONFIDENTIALITY_MAX)
+		return -EINVAL;
+	return security_locked_down(what);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(lsm_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_security_locked_down)
+BTF_KFUNCS_END(lsm_kfunc_ids)
+
+#ifdef CONFIG_BPF_LSM
+BTF_ID_LIST_SINGLE(lsm_locked_down_hook_id, func, bpf_lsm_locked_down)
+#endif
+
+static int lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	/* Filters run for every kfunc resolved through the hook. */
+	if (!btf_id_set8_contains(&lsm_kfunc_ids, kfunc_id))
+		return 0;
+
+	/*
+	 * Raw prog->type: keep out the rest of the shared tracing kfunc
+	 * set (incl. perf/NMI) and extension programs.
+	 */
+	switch (prog->type) {
+	case BPF_PROG_TYPE_SYSCALL:
+		return 0;
+#ifdef CONFIG_BPF_LSM
+	case BPF_PROG_TYPE_LSM:
+		/*
+		 * A locked_down program calling this kfunc would recurse.
+		 * Match on attach_btf_id: attach_func_name is not yet set
+		 * when the filter runs from check_cfg.
+		 */
+		if (prog->aux->attach_btf_id == lsm_locked_down_hook_id[0])
+			return -EACCES;
+		return 0;
+#endif
+	default:
+		return -EACCES;
+	}
+}
+
+static const struct btf_kfunc_id_set lsm_kfunc_set = {
+	.owner  = THIS_MODULE,
+	.set    = &lsm_kfunc_ids,
+	.filter = lsm_kfunc_filter,
+};
+
+static int __init lsm_kfuncs_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &lsm_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &lsm_kfunc_set);
+	if (err)
+		pr_warn("lsm_kfuncs: kfunc registration failed: %d\n", err);
+	return err;
+}
+late_initcall(lsm_kfuncs_init);
-- 
2.54.0

