Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401856;
	b=sBuHGsh+jO28mL6b5evWnyHIm3BBoy3u3VP/Gpi8JwImtAvw5gE/AD1Mnp5PF33Gk0+y
	 bLdigniFTCDTEcUi0HmfFUjYMqCxIZCdLcVkP5eZPEovxix8l8ty0tH30plGBAxqO8iER
	 nEUxVXfKM/LlKNBLsfkT8kSnDT+fXZcrkQ2sDx5bdXZsf8Rn0mykvu/q0Jfhv4yM8HVOs
	 K3auytj4wSwMzxuNtNRFHVF3+ujDqvwso/7AI/qdCDm2COasUK7N7HG3eGc1i3W3yQVjG
	 M/r+ky8461zibHKb0gIjrY2vfSzKoyShnsVinpWJqjaEna0Bk1yKpATaPjfylrb7rZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=dXlcPxhwTQERB0NwLk4I8j0eGOFIuVVtNPKKYwAznSI=;
	b=rQ0hX+bT9oDwmz+Vs7KvFuBlg7H2U2mdRiWhOoDXAax7+owpzETtHC27pvx+DJmaGazX
	 eXNhajwbU1WlGGWwUGNHNJ4fQl5WG3H+HaUw2wana4OXbl0Tq8pq6HOtT3ZK43t0ZCWd2
	 5KgTK+X9GA+HHiGv5+cQGUfWwhmI3SoaooAnsHc8jpYMr8WCOHVBs9PKU8CyQylXyuVOt
	 PyPlaAwPjlfd3/73I2xZZLF/oVhe6t3TMJz8lhplUQxMPiGDWl6c/6CNEcIF/SMYsdxZ/
	 XC7QWi+aNbuowNxFIaKp9r1tJUcuvdABuetswfFcHvMVz5znOC6qMIuVhVMYSTeItqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BpRJoeMN;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD25606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD25606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BpRJoeMN
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48fd1deda37so1175584f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401855; x=1795006655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXlcPxhwTQERB0NwLk4I8j0eGOFIuVVtNPKKYwAznSI=;
        b=BpRJoeMN/M1GXyoK+LQyRCaKjbsCrr0lIk8oODt3hROvEbzEGDoLdaB/0gmJKQr71g
         2Bl7KN0sNO2V9zE+EAqux+c0LYLVRjEdNW9QsH6PZIirhYlTRQRxybLu90DluoFEqm0m
         8PFR7uyy/QJ8ClcpRKYTuTzZo0ABrF5yXK20yDAAyNmLaQocC3KeuwiQAC9dCUTxFY+r
         kGub872NgKKcJcDzUIe/zZFCtq1oGCRzQwuIpMVu5ozFs/fVj1zDbK0KoYOGIIOTH2Ye
         D9ox3Rj8dZqbXswo2q25UwwQw/JoQqyt9AP85wp3HOh6xC1KEuH+l93KF1i/HsuObhER
         /61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401855; x=1795006655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXlcPxhwTQERB0NwLk4I8j0eGOFIuVVtNPKKYwAznSI=;
        b=n4eEyuDaf0UwFiNbzt1DEcggGiS4EGT13VCOhRFuCiyvHOii2gcUx4bR1bXS45jBBd
         JVw/7kSjrt5+6BjuIflhrIK5kciOviyg3dF9h/EAxoo/lVExmdIwpnP7cQyAsygvgWhN
         Vfoxh8TCEbZ8xRHjs3sENpln4zXLIUmNKwQ7xI7clQtQO/TZ+Fi77KtMmOtpluWoNORH
         438uDchuzwhI2SoNZPLgT0juOyFex/WY0NXjPkeIbcQz9RLbRSmERniNl7gaQ8q9k1vf
         X5rynddeClgOo1yWSqANaFE18fM+sfctuVgazru4vunOtyN8NV473M2HG8PEEJBRgDXW
         WDpg==
X-Gm-Message-State: APuU4Z+TvZfiQIA0hnVPK35bXPG/k3EmkSUF5dkr9iEzDPVawlWpL0Rt
	qIXa4bT2WgB1uvK+OcaLIF+347m2mHD5XwRou/+Otz7qQMK9SW9NkA9b77uJ5vaz3BI=
X-Gm-Gg: AYBFou0PNXO68FUfQwfi1OQC5ui/IJfFR4AXR12oLHDvMozZDq8ezHr7LojzDnQpQqA
	xwEZexbdpVwm1NJ+3WiXzJIuu+lfTjKamj72YpTtbo760HnOvgEW/EF7Xh3qfCroq+NjaPAk5fg
	mL2rcNKL3U9MOb7jX9XCdoWCRwfQ0qCRYQiT8VTvLF4uEQKpZHh1Uw+ew/TUHDBSZxDGIG8wjKe
	UnQkpzokyXU5i7jH5iEi+r8Xkdf1s2fYk/43iCpUv6fx6krcS3CvxfoM5teOrFx9ZQcglaqzhdB
	hwiAdC4Cv7bS0r/UJ/llZASxlZxasH1ge1Pe5lzd+KWNOxZ9b/xC5R7bQ9puXIPAbc9F+U4pduc
	3/CaXgLvqF9DQhYUMwjqlDSDu8+iSQ2lXq/3VK6GwC+dmMbhAAama4YDL/YLP7ecbTrGR0xC9t7
	W9wKWnPVgGoxpCtvcNLQt01rWgeRvCFycBoyKj3suMpmS6fwv7nqKqtSe4QEFoUrFwlEowOhTAf
	EAHgN0EkfN4M48mVpEt8q1GqMdPcwHNcMczumU669hV6b8RfAa+4CjG4iYzuF2Fuw/UNCZok6NV
	BoR3BetCpAxq4Mw7PDfkCpyUQF1QE2JPCCRRCNOhok2E8FNCdev/sCNF0q32Aq1HTSED+1vAWb7
	IXyCxS/ESIySwbIN/vM4QlCaopemsT13QU0UGz9qF7USINZ75eH3ItEKul2M+9uLKT6p2
X-Received: by 2002:a05:6000:603:b0:48b:e50:714e with SMTP id ffacd0b85a97d-499c7649685mr3835963f8f.36.1794401854719;
        Wed, 11 Nov 2026 04:57:34 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365ccbccsm11218345f8f.44.2026.11.11.04.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:34 -0800 (PST)
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
Subject: [PATCH bpf-next v1 02/29] bpf: Add bpf_throw_unwind() and an arch entry hook
Date: Wed, 11 Nov 2026 13:57:00 +0100
Message-ID: <7b56a21a5f2750a8325154d741318a1d451c21ed.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8273; i=memxor@gmail.com; h=from:subject:message-id; bh=7lUzMCft9IFlB8SfkZU124oVy7ikLIXnfGp1q+xxxRc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzJxt25yT99/Q/TLVXFWlvjdwAefELVYcDTVSV97yG nSGrrrYUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIl4b2X4X/lgy7LO/dMsA+tj j96w2nS7lfOKo+MBo2+FIVciRfz8Ghn+6aj9in6tk9mu98ZHU5E7qdql2/qucNdmqwPMnknt9j7 MAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently bpf_throw() is a C function. It walks the stack to the frame of
the main program and calls its exception callback, which resets the stack
to that frame and returns from the program. To restore the callee-saved
registers of the frames it discards, the unwinder needs their values at
the throw site. By the time C code runs, the compiler may have clobbered
them.

Move the body of bpf_throw() into bpf_throw_unwind(), which takes the
callee-saved registers of the throw site, R6-R9, along with the cookie:

 - An architecture can provide a native entry for the kfunc, which
   captures the registers and then calls bpf_throw_unwind().
   bpf_arch_throw_entry() returns that entry.
 - The verifier redirects a call to bpf_throw() to the entry when it
   specializes the kfunc. The JIT still finds the function model of the
   call through the specialized descriptor.
 - Without an entry, bpf_throw() calls bpf_throw_unwind() with NULL, as
   before.

Nothing uses the registers yet.

bpf_throw_unwind() never returns. It transfers to a JITed callback, which
returns to the kernel code that called the program. On arm64 with a
shadow call stack, the function's prologue would push a return address
that is never popped. The caller of the program would then pop it instead
of its own return address, and trap when it returns. So:

 - Mark the function __noscs, which keeps a static shadow call stack out
   of it.
 - A dynamic shadow call stack is patched in at boot, in place of the
   pointer authentication instructions of each function. Under
   CONFIG_DYNAMIC_SCS, build the function without pointer authentication
   but with branch target identification, as drivers/misc/lkdtm/cfi.c
   does for the same reason.

The function loses nothing by this, since it never returns through its
return address.

For the same reason, mark bpf_throw_unwind() notrace, and add it and
bpf_throw() to the functions that an fexit program cannot attach to: a
function that does not return never leaves the trampoline.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h       |  1 +
 include/linux/bpf_throw.h | 52 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c         |  9 +++++++
 kernel/bpf/helpers.c      | 17 ++++++++++---
 kernel/bpf/verifier.c     |  7 ++++++
 5 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/bpf_throw.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index da42dbd32fd4..b01820e67795 100644
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
index 000000000000..57d974458750
--- /dev/null
+++ b/include/linux/bpf_throw.h
@@ -0,0 +1,52 @@
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
+/*
+ * bpf_throw_unwind() never returns: it transfers to a JITed callback, which
+ * returns to the kernel code that called the program. With a shadow call
+ * stack the return address its prologue pushed would never be popped, and the
+ * program's caller would pop it in place of its own. __noscs keeps a static
+ * shadow call stack out of the function. A dynamic one is patched in at boot
+ * in place of the pointer authentication of every function that has it, see
+ * UNWIND_PATCH_PAC_INTO_SCS, so the function has to do without that as well,
+ * which costs it nothing, as it never returns through it; the branch target
+ * identification stays.
+ */
+#if defined(CONFIG_DYNAMIC_SCS) && defined(CONFIG_ARM64_BTI_KERNEL)
+#define __bpf_unwind_entry	__noscs __attribute__((__target__("branch-protection=bti")))
+#elif defined(CONFIG_DYNAMIC_SCS)
+#define __bpf_unwind_entry	__noscs __attribute__((__target__("branch-protection=none")))
+#else
+#define __bpf_unwind_entry	__noscs
+#endif
+
+void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie);
+/* The native entry of bpf_throw(), on an architecture that has one. */
+void bpf_throw_entry(void);
+void *bpf_arch_throw_entry(void);
+#endif /* __ASSEMBLER__ */
+
+#endif /* _LINUX_BPF_THROW_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f88a1c041a7a..7a25d1cb2c30 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3930,6 +3930,15 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp,
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
index 937a0d7d6839..de31fdd18411 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3460,7 +3460,13 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	return false;
 }
 
-__bpf_kfunc void bpf_throw(u64 cookie)
+/*
+ * Unwind the stack to the exception callback of the main program. @regs holds
+ * the callee-saved registers of the throw site, or is NULL when the
+ * architecture has no native entry and the kfunc was called directly.
+ */
+__bpf_unwind_entry
+notrace void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
 {
 	struct bpf_throw_ctx ctx = {};
 
@@ -3472,8 +3478,8 @@ __bpf_kfunc void bpf_throw(u64 cookie)
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
@@ -3481,6 +3487,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
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
index 20b1b9ff574c..c5b4025ee222 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24434,6 +24434,8 @@ BTF_ID(func, do_exit)
 BTF_ID(func, do_group_exit)
 BTF_ID(func, kthread_complete_and_exit)
 BTF_ID(func, make_task_dead)
+BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_throw_unwind)
 BTF_SET_END(noreturn_deny)
 
 static bool can_be_sleepable(struct bpf_prog *prog)
@@ -24793,6 +24795,11 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
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

