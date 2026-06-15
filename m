Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F932404BD9
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540482; cv=none; b=oLAyt/HEcOmnWd8WXID0F5cf1sTrjLREKFH3R5Tezx5eOq+G8QbW7LHof7jBVLa3ZD22Uv78xZS8TpTIZstc7I0/Z8lA3+XLB08gqMsPWg2Tmg96mXgWoeQOJwDEaTjAdSIBypgFOvYo4O+Rv3rtyqU7sDn8nEliONIUEYJcvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540482; c=relaxed/simple;
	bh=V7VQBMRCG3n+5KbwQ4WA4eo6vXtqN3VP5WzwN1N6Nwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/2S6TgvyhQvWyXo9t9oa2Y7wqS9IO9M6vsM7tt6eZGZ5yxtjD6aCCHBYm72ufia3chm7hWR65bYhXoAXgP1ooiBwcrJbmwiXjbqdAyizRzgVTZHtMYUAAxshqcaeablAc3Lea3RLzRAdildwQYFAvDmjpQ5kH/KDZyJ5bDYGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxP7TfCn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxP7TfCn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso46080685e9.2
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540480; x=1782145280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKEer4gBBGrFHXrJco8eoo8egEvzRsputvCEQwG6CjY=;
        b=fxP7TfCnvICBVPZgI5bEL0rDq92MLrSkXRFefHxPN1XylOSzsDnLPDn5T46zFnJsvI
         U9w3KUW8RMDLAP7cueKtJEqvAf/9iQMk2GKMJwc/wS2dPhUsxbTQBX5yHOVqMw/MIfcb
         /N2O/OCwO/BjZzd0VT3DRWspNiD084gIuycWpNnA5hFvnaTqaPzdsSx7TLTXgXh1ThuR
         E2upEqkaZ0Y1pvXm3heklbEacjbqTxy1zxBuAGJuq5nH+Wlm99dHza2UfdDehacc6J7A
         QEz/2fB1ouBrHCiZyYgCG58ElBDTMSDT1HbKalEW2OhgV43i5+v0x5xbnFHPCC78kc9i
         mfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540480; x=1782145280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KKEer4gBBGrFHXrJco8eoo8egEvzRsputvCEQwG6CjY=;
        b=CZWEiPQc4iRptJ0Ysrixp+PT7YoGBi4Jktgo3dCCQpGls78wjciCx9fPu9IOzHn/Nl
         dEcOpzMgNNya07T8IKAKXjnuDKJ35eWCMKFvNFgo3rX/PrKmyy5XupznZ3k1npNFWZXp
         0focH9s0C08lvIMr5otHc19iZlZI7mqhHDVJaNgAWwF2kgfaoMigI8PXcDJHmQcu+5n3
         UkCNgzIfYNsofE22hV3yY4tCmWVHTtiDsIomW0uLZmJ5D7kF8q167RoyDF8lpNdlEuaa
         B68W/LT9lRm4XqgIW6FjyWSACbz3H1E43wJSKk4QR8euasRipXp0N63L4zZX+gT20zZk
         jupQ==
X-Forwarded-Encrypted: i=1; AFNElJ+czyoBBT0q0Vqnh1JUOqV7R3VWmISvC1zXWvibrdDmYeMPlDu82EJ+XJWEho1kM2gn9Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQj0EGUgttJzFoEwuuj/yxSvhGwX795kl7r5pXlinh7iGHAmyP
	Ds1TU/tSU3Ao4sBJAXplzlB4dTotKuFnCEQ1Qgs4GnOky5eQgWRYme2n
X-Gm-Gg: Acq92OFOrzND5LsKLQzb8WSk04HNgsCaP7v96SA+E0bBdd9ppq0l1z9Sq1CNSN1GVdj
	x1UamxodhISJKU4XBZv+c0ZTb5wskfIKkk1ubcWWBWcM36cBCZIz91wQ5PTTRnKuVbbx+jygxF9
	caG7fGF1MBBD8EqNBiQBEct1+hRkQ/KzyXokj3GMh9Jk8mNA6m/pqpalfGfB8QDmqso0J0eCPFu
	k4OmioSSM1ZdHC9NkTwCZe52gt8DROcBZ2XZ29GATUJsuGPX8bvBmLGs03o32uTdvgKgk2SFeUe
	TzrQTbAMMNz+kHrpzMmhAWI/wVaukXLIBhDxqaGZZFff2znX4gaZtJW/r7MYEeazUx6o3RmkNSA
	+D3ggxlJ4QbSgZHpf5Y7faQF7hWBAEHYzW+p4F58MYF9NIbPfaO9RuZaNvdojNG/E/CPBWJhuN8
	6jUCkct2rXcKO0+SX7AIOVs2MHyV7E7OxD+l75FBem6Y3LFEDIQZUuBZBEf/M5/sc=
X-Received: by 2002:a05:600c:3e0d:b0:490:b629:286c with SMTP id 5b1f17b1804b1-49220075ef1mr142731015e9.12.1781540479742;
        Mon, 15 Jun 2026 09:21:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922f9cd140sm4320745e9.0.2026.06.15.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:21:19 -0700 (PDT)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Date: Mon, 15 Jun 2026 17:20:21 +0100
Subject: [PATCH v2 1/3] seccomp: Store death as a separate field
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-seccomp-combined-v2-1-41687a943ae0@hill-daniel.co.uk>
References: <20260615-seccomp-combined-v2-0-41687a943ae0@hill-daniel.co.uk>
In-Reply-To: <20260615-seccomp-combined-v2-0-41687a943ae0@hill-daniel.co.uk>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, will@willsroot.io, 
 Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781540478; l=3015;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=V7VQBMRCG3n+5KbwQ4WA4eo6vXtqN3VP5WzwN1N6Nwc=;
 b=agy5kyS7kDTwfqFeeW40QGrGtjoIrKPqouKgTLXhGHSyGX7lMof1JmKbldgkUXL4Kvnlv9y00
 2Mj94FIFUVTAfwgjVXTdjud6wu0umDR6e+FJnv0JzNWdZoKug9KF10Y
X-Developer-Key: i=jamie@hill-daniel.co.uk; a=ed25519;
 pk=ovqCXSlFUjrT82WuRtIuXB13U5n1yfxM6o0M5O5J2tA=

Remove SECCOMP_MODE_DEAD and store this instead in a new field
in struct seccomp. This means that mode can be used to strictly store
the current mode which is exposed to userspace.
---
 include/linux/seccomp_types.h |  4 +++-
 kernel/seccomp.c              | 19 +++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/seccomp_types.h b/include/linux/seccomp_types.h
index cf0a0355024f..67ab25d7540a 100644
--- a/include/linux/seccomp_types.h
+++ b/include/linux/seccomp_types.h
@@ -12,6 +12,7 @@ struct seccomp_filter;
  *
  * @mode:  indicates one of the valid values above for controlled
  *         system calls available to a process.
+ * @dead:  indicates that the process should be killed as a result of seccomp
  * @filter_count: number of seccomp filters
  * @filter: must always point to a valid seccomp-filter or NULL as it is
  *          accessed without locking during system call entry.
@@ -20,7 +21,8 @@ struct seccomp_filter;
  *          is no read locking.
  */
 struct seccomp {
-	int mode;
+	unsigned int mode : 2;
+	unsigned int dead : 1;
 	atomic_t filter_count;
 	struct seccomp_filter *filter;
 };
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 25f62867a16d..8f5903f72d54 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -31,9 +31,6 @@
 
 #include <asm/syscall.h>
 
-/* Not exposed in headers: strictly internal use only. */
-#define SECCOMP_MODE_DEAD	(SECCOMP_MODE_FILTER + 1)
-
 #ifdef CONFIG_SECCOMP_FILTER
 #include <linux/file.h>
 #include <linux/filter.h>
@@ -1079,7 +1076,7 @@ static void __secure_computing_strict(int this_syscall)
 #ifdef SECCOMP_DEBUG
 	dump_stack();
 #endif
-	current->seccomp.mode = SECCOMP_MODE_DEAD;
+	current->seccomp.dead = 1;
 	seccomp_log(this_syscall, SIGKILL, SECCOMP_RET_KILL_THREAD, true);
 	do_exit(SIGKILL);
 }
@@ -1355,7 +1352,7 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 	case SECCOMP_RET_KILL_THREAD:
 	case SECCOMP_RET_KILL_PROCESS:
 	default:
-		current->seccomp.mode = SECCOMP_MODE_DEAD;
+		current->seccomp.dead = 1;
 		seccomp_log(this_syscall, SIGSYS, action, true);
 		/* Dump core only if this is the last remaining thread. */
 		if (action != SECCOMP_RET_KILL_THREAD ||
@@ -1396,17 +1393,19 @@ int __secure_computing(void)
 
 	this_syscall = syscall_get_nr(current, current_pt_regs());
 
+	/* Surviving SECCOMP_RET_KILL_* must be proactively impossible. */
+	if (unlikely(current->seccomp.dead)) {
+		WARN_ON_ONCE(1);
+		do_exit(SIGKILL);
+		return -1;
+	}
+
 	switch (mode) {
 	case SECCOMP_MODE_STRICT:
 		__secure_computing_strict(this_syscall);  /* may call do_exit */
 		return 0;
 	case SECCOMP_MODE_FILTER:
 		return __seccomp_filter(this_syscall, false);
-	/* Surviving SECCOMP_RET_KILL_* must be proactively impossible. */
-	case SECCOMP_MODE_DEAD:
-		WARN_ON_ONCE(1);
-		do_exit(SIGKILL);
-		return -1;
 	default:
 		BUG();
 	}

-- 
2.54.0

