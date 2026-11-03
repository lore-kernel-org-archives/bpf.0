Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747981;
	b=IHTqRWrhNihI4TZM58sLhRtRneH5VwpZgy5X6N1irVpm1ExeZJbv4gtcCkPVDhQct6rC
	 dI0dlTQvnnFK/kMEycGFhJ906E4djBFAvwcdb+vcYkOIURjES1otPq778syZlZCIn0Ww7
	 v3sZdqvFgkEhW/ngRtygY5ioxazRuiu5blCabh2KK2nj9pCStBhb62/hnqJXutApVcLdy
	 U27u/dgsShabA6OoXT1eaU1frUPTNoVA7fFMYhruZ6WkdIy2ICMS3nF2VgK6BY6tmo9QU
	 t9ZFUD28Sh3h1DNDW+7nTITbeKALhJF2Y48Tq9RvT1qugWWZK9gP30iR6uIyo1V91FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f0oQQ0yMTAYvezyb/Pzen2+sUGmfcLyDrKtjB9PlgfY=;
	b=fpqMH/L2mrq/m+o11+WZmWIH/s2emrHR3aUAZz3HK+2rhO13Ic4i1tA2JLCU/A07GCjB
	 Z6QyxjzjloqS3e60I7DHmZ4Nv5TtkMgrAwdz0lPdAGSdCrp/07wV/0ie0Ea9/zNDPL/iS
	 fjyacYVgxnhJ+W1avbZ9l0wAehXbT/euoEsSagkMCOrVwzpnq3TvSDIn+QL+gHRONxaUL
	 cqbkfLsDInQmsqaYpAylWQqvR4seFp6hVqkOTkC0x29WWmDde9zTjz1djAdjclL4MiQvB
	 UrbZEOtj5H+PBBczH2EMV3kUSeu/gL8iGJVRKMJ7hKph8bNoo3ohnIqMsbopiw+Rm6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFgFdmSw;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59078606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59078606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFgFdmSw
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd69954c755so95201a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793747980; x=1794352780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0oQQ0yMTAYvezyb/Pzen2+sUGmfcLyDrKtjB9PlgfY=;
        b=eFgFdmSwHB8wByJe2shGJTrrfgMkQVyhlNM5OoYNx+8TdpGWVpumI8gSxHgpuiUBAK
         3zrWE1rkvVANa9sv2rFaBzXi3NDcqkoH0Gj1AXnBdB5cs9hee0/QD4TM9UQRUTFivnDB
         dydWaIMXeZmZdUUdeOenE/feZL42ZBAEk/OpOBON8fRL+r+vqT1c9o00w3p1s8xbDRiU
         J3e1oT9xCDjr/e3TPUgId9GhHQ7GxEO/XHxh45D/gCmvP1dktgn4PRBdIGVSBysSMZpS
         AI7wpKswcVxTI02u7Ti0cUM69LipJnNUZUyk/Z97PmzFUkwBpWFAx8Ok3WvECuAzTyUC
         1HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747980; x=1794352780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0oQQ0yMTAYvezyb/Pzen2+sUGmfcLyDrKtjB9PlgfY=;
        b=Qq7UxgTIdvnHajW30b8R1N3gSUEtQmEVsrkczFIlzB4xOyYhT8A2qCCrMEcAhcgOop
         pwamB178Y9mmlGGkd8EekfMqewWHwmPKaTAK9fHm9QOJ0lmWFnZlyCW15/0/gszyGZ7a
         YoE0lIcoBFEXJeYyVq4iY7Nk2ziIUr87FFpZfzxivcZG+ptbfWU0EURdNVS/efZnO8jt
         omvhZSl9gHXcg2nDGLldqhwA0XrGA7ncSpNwFVlEAx0FHP4QUJGXwQCqzjcVffDsshrl
         QwB7iHEinImHmWgvPmub3XrCXibjbWnbfnZP/qxH0jpUphxsZGd2BOMoFyo+EgftGlDg
         yi1Q==
X-Gm-Message-State: APuU4Z+U+rJWDiYy7aecLbVwW5U3hs7RbmHAFxdkKJhJjm/GyUtfyDRY
	w3GEd55WjB9DYP8eqLEQSLSO6Uta3WMoFJfsTeWZgPBCtb3S6IM9OkVL0yiirQ==
X-Gm-Gg: AYBFou0o67ND/uwoFwktRuz2/W8i5xOdJU0iEsZLzsU5E37J/gZMEuCH1SuD8JokbJ/
	NjPnZ5TiXMmMR0m9LEiyTve3Inbb/L2jyP8mqeH7x+awNF8WRSgtSIvpjBTzHzorVJp/YsHlI7T
	0wtXlrl+RQ3URVajUugfkqJ2K5LyuMbKI/lBr45jA3Ea/uFLuo4qKss0t/ctMo336hrT/7xDo0Z
	52BAO6ZEF/8lMLw5TAHTqfJ4Vr1Du4hYloHgxzE97HfSAHe9NkGYThACELyWavP5I/kVtcylDGG
	7mUKrPvFkbNw8hLLPG1sdII0s74lZMa9IKLkDyJXqXu5SoO4z+U7xE7vQorIGsa4RGUwwE/iYWE
	WWCJiXatpYN1IzvArzluzP215UCurKtpbUqWuSabaC5o5q0rLuda7EesOvDMUDpu3Px/DUe3Yvq
	iNOuMDaojN7QRVWwSH75qPhiMdo7YO744evcREss907F/5/IgtcA4AEz+b+7m8FKrCRNxz2TMgF
	WspJyLe72JQ0AmkkJJoxglbLAiSxdUo9TtnKpgZGJ4NKsfj6bXDhAryzw4em5xI6oF8t1iTpG54
	itTTghh5o+ROIndjvp1mcgLoVh78h9CJpa4b41YIoJcMkiOeIEgXYIg+b/g4sZXN3vzm6UFzI+1
	lHLyKWi39zPLWhkwY0d9/TIpcKxnwnTMyV0TnzifMOShOoT8SiJUqquqH/KhtIO0l+OtkwBvf9w
	==
X-Received: by 2002:a05:6a20:244e:b0:3e2:3c7:7754 with SMTP id adf61e73a8af0-3e928a7e407mr13741669637.65.1793747979521;
        Tue, 03 Nov 2026 15:19:39 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09ba51accsm151184b3a.49.2026.11.03.15.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:19:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/3] bpf: Force BPF_JIT_ALWAYS_ON on x86-64 and arm64
Date: Tue,  3 Nov 2026 23:19:29 +0000
Message-ID: <20261103231931.89739-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103231931.89739-1-alexei.starovoitov@gmail.com>
References: <20261103231931.89739-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The interpreter is a second implementation of the BPF run time. A check
that a JIT emits on its own has to be made once more for the
interpreter, or it is missing there. BPF CI doesn't see the difference:
the selftests configs of x86-64 and arm64 set CONFIG_BPF_JIT_ALWAYS_ON=y.
The interpreter is also a ready-made gadget for speculative execution
attacks, which is why this option was added.

Let an arch select ARCH_WANT_BPF_JIT_ALWAYS_ON. It turns
CONFIG_BPF_JIT_ALWAYS_ON on and hides its prompt. Select it on x86-64
and arm64.

For a kernel with CONFIG_BPF_SYSCALL=y and CONFIG_BPF_JIT=y that had the
option off:
- net.core.bpf_jit_enable is 1 and can't be changed.
- A prog that the JIT fails to compile is refused with -ENOTSUPP. It
  used to fall back to the interpreter. This includes classic socket and
  seccomp filters.

A kernel with CONFIG_BPF_JIT=n keeps the interpreter. 32-bit x86 keeps
the choice, because its JIT doesn't support all insns.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/admin-guide/sysctl/net.rst |  3 +++
 Documentation/networking/filter.rst      |  3 ++-
 arch/arm64/Kconfig                       |  1 +
 arch/x86/Kconfig                         |  1 +
 kernel/bpf/Kconfig                       | 10 +++++++++-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index fe43e8595958..1d408e7e8c0c 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -90,6 +90,9 @@ Values:
 	- 1 - enable the JIT
 	- 2 - enable the JIT and ask the compiler to emit traces on kernel log.
 
+With CONFIG_BPF_JIT_ALWAYS_ON the value is 1 and cannot be changed. x86_64 and
+arm64 always enable this option.
+
 bpf_jit_harden
 --------------
 
diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 7f95c3199748..7b90cfc009de 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -404,7 +404,8 @@ Example output from dmesg::
     [ 3389.935852] JIT code: 00000040: eb 02 31 c0 c9 c3
 
 When CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently set to 1 and
-setting any other value than that will return in failure. This is even the case for
+setting any other value than that will return in failure. x86_64 and arm64 always
+enable it. This is even the case for
 setting bpf_jit_enable to 2, since dumping the final JIT image into the kernel log
 is discouraged and introspection through bpftool (under tools/bpf/bpftool/) is the
 generally recommended approach instead.
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1075bc661833..8cb2e2609eaa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -88,6 +88,7 @@ config ARM64
 	select ARCH_SUPPORTS_SCHED_CLUSTER
 	select ARCH_SUPPORTS_SCHED_MC
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+	select ARCH_WANT_BPF_JIT_ALWAYS_ON
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b66179..695a77bb261a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -140,6 +140,7 @@ config X86
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+	select ARCH_WANT_BPF_JIT_ALWAYS_ON	if X86_64
 	select ARCH_WANT_DEFAULT_BPF_JIT	if X86_64
 	select ARCH_WANTS_CLOCKSOURCE_READ_INLINE	if X86_64
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 98493e32db2a..2b7bbb9bd5f8 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -26,6 +26,11 @@ config HAVE_EBPF_JIT_KASAN
 config ARCH_WANT_DEFAULT_BPF_JIT
 	bool
 
+# Used by archs to tell that kernels that were compiled with BPF JIT support
+# have no BPF interpreter.
+config ARCH_WANT_BPF_JIT_ALWAYS_ON
+	bool
+
 menu "BPF subsystem"
 
 config BPF_SYSCALL
@@ -60,7 +65,8 @@ config BPF_JIT
 	  /proc/sys/net/core/bpf_jit_kallsyms (optional)
 
 config BPF_JIT_ALWAYS_ON
-	bool "Permanently enable BPF JIT and remove BPF interpreter"
+	bool "Permanently enable BPF JIT and remove BPF interpreter" if !ARCH_WANT_BPF_JIT_ALWAYS_ON
+	default ARCH_WANT_BPF_JIT_ALWAYS_ON
 	depends on BPF_SYSCALL && HAVE_EBPF_JIT && BPF_JIT
 	help
 	  Enables BPF JIT and removes BPF interpreter to avoid speculative
@@ -70,6 +76,8 @@ config BPF_JIT_ALWAYS_ON
 	  is permanently set to 1 and setting any other value than that will
 	  return failure.
 
+	  x86-64 and arm64 always enable this option.
+
 config BPF_JIT_DEFAULT_ON
 	def_bool ARCH_WANT_DEFAULT_BPF_JIT || BPF_JIT_ALWAYS_ON
 	depends on HAVE_EBPF_JIT && BPF_JIT
-- 
2.55.0

