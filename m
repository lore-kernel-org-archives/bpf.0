Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519317;
	b=cPkPK3O5U+yHjurnx9RCnU583vh4R9M8TmbeAf1r3XAbWdjYTUX9zFPdwtIJIlH3qnS/
	 d5SbxTFdrXezKWzQLwUaMrGPathZMhk9/LzHFXDVMkMSk94K5OXIpkvxp3Q+Q7A8pQti/
	 ZDSh9Tv2hpXH5slkLvImYG8giUoZ+wYQQLCWFtOtLLOSmDut+UdL4SSQb6kP1xv1vcHXG
	 lSxL00/fsIWrovm8mvT7mdW35Nsba1+lBmAViDWBX9Jc9DjgYW2RfCgf5CT/HaIlj2UEO
	 nzhbaopH38LFpnXkoYjAfNovvoKy1dS0WCtYJrFParJkTOW9Tq36kSu9MS4nI6dtI0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=6ZUCia9ia6e2mqfT46eKB4laCt/UmDd8w+KY5874Ukk=;
	b=FT5PUiCbiC8XaK44mcHTurRdP29tmhs7sFJpNASImPwi7X5aF6Bq8muaq+5D7avqjStj
	 Dv7xu7CCbPpI5yz14gjvHwlxu5352KU6O84V1gKNCe4KlwXjo4G888VbSEYDBOWvvQTtK
	 gTFEErVJbHsdDSyJskXiPHm3quH6Qbr9Y6YN3W3GA7/231xNQ5b7bdsUCCdqeJ3TTzu13
	 SC7hp/wouIsg0xmWqCyMJPg2Y8oxz/zsLnWuBqttQbLlTeSm1jKzaMf9iZ0r3v7pH4oyr
	 zEZwWihh8lF8bWz31LdqyGmFMxcG2M6w/hGzWDd2cm3+SlQJWLP6YCXGknr24N8W9vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Gowd/AGU";
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10679606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10679606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gowd/AGU
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4a16dfb8fa6so15883385e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519315; x=1793124115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZUCia9ia6e2mqfT46eKB4laCt/UmDd8w+KY5874Ukk=;
        b=Gowd/AGUXGloE7wftU8xpYGjTmc2W6yUb5dP1ReF1x3oM5F3zO2jg18kL+G6Jfn90D
         Vwq5xEW8pgcJXLgdcpt93DvvVmRP4wsr7qxKXamB4TAlGx39ZLQYIc6pYg+n6J2ZLAk+
         LTrF652+7CLsb7FBY0QzQdIS9SaXFo40yIYJZAWnkXwxbpB4ryzvvOF60WWQsmuT+QMw
         9g+MF4urCtR0hqPSjXwzaNuY44Myogdm+RBnZQOy3ZgsIUk4L5jwd6Sasxctsfzcqboq
         pF1XbydgZdjSZcxltXcdPjKpGS+kanJLKEFcIDNalC5xkrDSDNewV3xb6aKMcZUXia4h
         c9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519315; x=1793124115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ZUCia9ia6e2mqfT46eKB4laCt/UmDd8w+KY5874Ukk=;
        b=2ZngeScC2zRch9L7ddY9KHjoajPgpdjsT1rLYJyQsEhmYsddv7JkafKsX5zeuk3xct
         k5D7CXUZycRQOBZ93rcbbYpWB25pPXjw8JMJhCHWrhyH4YwR82kRiRuJE5pyOAoMCMwQ
         X+P2RpJJ8sJk+TEpLTxrHS9SzQ57ZcgD1DaJ0uuMF45dAWSBaH0Wr0fz236GeG//C4AU
         +erNWntHHQWOtQl0UtfwQe1aKNUEXQs2N98VpeDky6lAQfWbb4BwPWvofiRlv+s9g+Oi
         RSeJudMzQ9cfonDMVvd5pls+RIfYvp1HdEUz4mPuOhWUQk7Kl6hmmgDhY4Dn/M+mfP3+
         HKGA==
X-Gm-Message-State: AFq9FYJSIFRiNersxgFd9+OUr4pA4Wxx+b50YmSxbIZLycKDo3cv6jaZ
	y0jShII3fs93l/eNfTsx4853abKaOj7K1si4HklPBdgF2yWMDFl9DGNvQJE3zvEI
X-Gm-Gg: AYBFou0Csi+j0TkbMkrCG6zgjEodjKVaknOhGu+P1IA6X2nlkGNRCr8WDGuVQPd+O9f
	q/4VyhC6l4nNxNkbzk+3VfS9hs9iYyOcryN5hrAShcWRL2TAVRdSTZBdO7RooKH9FNt/6a6rSBP
	bltRhuf6EqObiRClV4omVfjbPu2qFUEvi3tkiK2fq4FkqRm2eDtKY+xx2IdH+y3EKUW93x7bj+T
	BCCLTrohCQIBhs6HyBD4y4joyksUl734mnunmA2VRDgwK8z+qJext136Cs7CxwiDb5u2dIE3GaG
	cFl+7BfYFhm0jhCaWpF68p9efA+qrwhGTsnr3pLhowKyPczS3BAdzH7cpni8TjWWo5GqZvb1BlK
	ZCM8FpW4yJxUkL7o06ybKAwXb7m6SlgQ9K3C01ixCqNwASHDPXZU6FimuOJiVrfK2LLDgKwMVoH
	OuQat+iH4ahNaWWaTR/rvSTmqXlKarWOl+6yE+0CQR4gomg0gF3HfZ8namF4Xy8cn6bcO5/Q/ga
	qiuz8qttVrFM2cuBA3PlYcfTsLue9xb7WaOXC+Z78V50Lsw/BW9oJWSejcgzuClzAt451U0U9SQ
	TcXQ2ZHgUpZwVOa4Z6aaxrXAfvOalwknFcpDTw==
X-Received: by 2002:a05:600c:34cc:b0:4a1:dec1:4e1 with SMTP id 5b1f17b1804b1-4a1dec1097amr211127535e9.22.1792519315181;
        Tue, 20 Oct 2026 11:01:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2e8daffsm96873895e9.4.2026.10.20.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:01:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/6] bpf: Add bpf_throw_unwind() and a hook for bpf_throw() entry
Date: Tue, 20 Oct 2026 20:01:39 +0200
Message-ID: <20261020180147.1769873-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020180147.1769873-1-memxor@gmail.com>
References: <20261020180147.1769873-1-memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5795; i=memxor@gmail.com; h=from:subject; bh=sn4a9u8F7k3U9vjbHCfuWIIWUPb+cKfym0jN7oeAmjE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIev6iofLtukdfqFc+P3wK/n8jz78/NuCHuyP/fp1U0yIw eqY1+cPdpSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAi/gcYGaaJ/RSTZHsjfGY+ v9KbEKbdmw3W8qox37x4Kf34upxfl18xMuzc2CGpySp6MOEmA8ukDzXbjmTdKWLY/VeXZeuan/W mBVwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_throw() walks the stack to the frame of the main program and calls
its exception callback, which resets the stack to that frame and returns
from the program. Restoring the callee-saved registers of the frames the
walk discards needs their values at the throw site, and by the time C
code runs, the compiler may have clobbered them.

Move the body of bpf_throw() into bpf_throw_unwind(), which takes the
callee-saved registers of the throw site, R6..R9, along with the cookie.
An architecture that provides a native entry for the kfunc captures them
before calling it. bpf_arch_throw_entry() returns that entry, and the
verifier retargets the call to bpf_throw() there when it specializes the
kfunc, so the JIT keeps finding the function model of the call through
the specialized descriptor. Without an entry, bpf_throw() calls the
unwinder with NULL, as before. Nothing consumes the registers yet.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h       |  1 +
 include/linux/bpf_throw.h | 33 +++++++++++++++++++++++++++++++++
 kernel/bpf/core.c         |  9 +++++++++
 kernel/bpf/helpers.c      | 16 +++++++++++++---
 kernel/bpf/verifier.c     |  5 +++++
 5 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/bpf_throw.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 010f14bb6c77..839c28d3743f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -7,6 +7,7 @@
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/filter.h>
 #include <linux/bpf_defs.h>
+#include <linux/bpf_throw.h>
 
 #include <crypto/sha2.h>
 #include <linux/workqueue.h>
diff --git a/include/linux/bpf_throw.h b/include/linux/bpf_throw.h
new file mode 100644
index 000000000000..663776715b33
--- /dev/null
+++ b/include/linux/bpf_throw.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The interface between the architecture entries of bpf_throw() and the
+ * generic unwinder.
+ */
+#ifndef _LINUX_BPF_THROW_H
+#define _LINUX_BPF_THROW_H
+
+/* The callee-saved registers the unwinder tracks: R6..R9. */
+#define BPF_THROW_NR_CALLEE_SAVED	4
+/* The size of struct bpf_throw_regs, for the entries. */
+#define BPF_THROW_REGS_SIZE		(8 * BPF_THROW_NR_CALLEE_SAVED)
+
+#ifndef __ASSEMBLER__
+#include <linux/build_bug.h>
+#include <linux/types.h>
+
+/*
+ * The callee-saved registers captured at a throw site, indexed like
+ * bpf_prog_aux::callee_reg_off.
+ */
+struct bpf_throw_regs {
+	u64 saved[BPF_THROW_NR_CALLEE_SAVED];
+};
+static_assert(sizeof(struct bpf_throw_regs) == BPF_THROW_REGS_SIZE);
+
+void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie);
+/* The native entry of bpf_throw(), on an architecture that has one. */
+void bpf_throw_entry(void);
+void *bpf_arch_throw_entry(void);
+#endif /* __ASSEMBLER__ */
+
+#endif /* _LINUX_BPF_THROW_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fc22d66d194a..0205a687e1b5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3601,6 +3601,15 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp,
 {
 }
 
+/*
+ * The native entry of bpf_throw(), which captures the BPF register file of
+ * the throw site, or NULL when the architecture calls the kfunc directly.
+ */
+void * __weak bpf_arch_throw_entry(void)
+{
+	return NULL;
+}
+
 bool __weak bpf_jit_supports_timed_may_goto(void)
 {
 	return false;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..7c78630e4dd3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3427,7 +3427,12 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	return false;
 }
 
-__bpf_kfunc void bpf_throw(u64 cookie)
+/*
+ * Unwind the stack to the exception callback of the main program. @regs holds
+ * the callee-saved registers of the throw site, or is NULL when the
+ * architecture has no native entry and the kfunc was called directly.
+ */
+void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
 {
 	struct bpf_throw_ctx ctx = {};
 
@@ -3439,8 +3444,8 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN_ON_ONCE(!ctx.cnt);
 	/*
 	 * Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
-	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
-	 * which skips compiler generated instrumentation to do the same. Some
+	 * deeper stack depths than ctx.sp as we do not return from here, which
+	 * skips compiler generated instrumentation to do the same. Some
 	 * architectures cannot recover sp while unwinding, so fall back to bp.
 	 */
 	kasan_unpoison_task_stack_below((void *)(long)(ctx.sp ?: ctx.bp));
@@ -3448,6 +3453,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+__bpf_kfunc void bpf_throw(u64 cookie)
+{
+	bpf_throw_unwind(NULL, cookie);
+}
+
 __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map, unsigned int flags)
 {
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01434e1d23b5..d980530e58bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23162,6 +23162,11 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_arena_free_pages]) {
 		if (env->insn_aux_data[insn_idx].non_sleepable)
 			addr = (unsigned long)bpf_arena_free_pages_non_sleepable;
+	} else if (func_id == special_kfunc_list[KF_bpf_throw]) {
+		void *entry = bpf_arch_throw_entry();
+
+		if (entry)
+			addr = (unsigned long)entry;
 	}
 	desc->addr = addr;
 	return 0;
-- 
2.53.0

