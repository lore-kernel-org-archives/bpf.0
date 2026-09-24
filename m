Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DB438484
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238402; cv=none; b=h9oiGjqRyh24+VHPui437BiLVV8cDSjycSfczaYiIvnZZ2rGiTlcAN+CtyDmJDrOpdA4djYKYvIRggAJtpuRNSMGmzR+ZebjxriIZCvM/lq4Ub2Yl6+RnYzCeGVEeX3O++IwdjMb+2jgPObbKW9t9zHJllgF7SG74Ch0YbjsW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238402; c=relaxed/simple;
	bh=eoLAhL3KmS8nZNL87+OS8vzX9m1boxAZzTQHOUiuxfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFytfibBqe+9llCMrh61vDprScaBStzm6K4OzVoiFw0Wd56TvGm0byj/2Qc08baStKtZSOtRWFJib2s46XJlMmwpwYBQSJzau4XrNLaG9XG2B+QzDFeewWCmCE4fElnvNJDt43ocv8h7FSmtfYfvdQnd99LxoLDLqLkQBcREW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLdBu7CS; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLdBu7CS"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe4ca1052so2120215e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238398; x=1790843198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ld1Np0e4gwJbuICP8NEYq+0CTk3oCY6IxG8OiHNqrNE=;
        b=WLdBu7CSYSNkSa/0RQs4kjn44WqWl2Wzp6KUyb6to8bgJxwlfOxUW1RF+s1gm3cEkZ
         ymUoMC3Iu6a+a6Foxoe8rkutctwI9w9RZMCKgdsywicB4pJqtATzS3AbsZXLPjhtAid7
         mTaKSjQuCl8eVwfS2Nl45FVezm7hzSxrogHh4qaWgIVS99ozBskW69ILINlM2OOyTm6a
         t4PCLyxAQT4uBhW7vsQdiNaRe9jSFmFIvY3XODBggAIvmsyGHT69FpoNIhUXhhkS2KU2
         y3XYLTjJmaB3a83zDu0lD9Oz0Fa69p6xArpECEwPLzq65rhB3h9853PkAKtPF+2d9Z4D
         tlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238398; x=1790843198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ld1Np0e4gwJbuICP8NEYq+0CTk3oCY6IxG8OiHNqrNE=;
        b=qP7rJPNMOinAqiOLXpBARxvgcaTVf546RamxDElQil3RTLhYwX6QNKk9IiE/s+J5AW
         nQGgk5qTNeru0VFe9L4UOHlUGdhLgLNhbWZ5VX8aULPxuuhTVkhGb/lgplCdf5o6EZao
         U1zBnDcBxx7avUXOUzx86hsFaCwaFWh3DyTCGGURNrUfMCVR0nuh00LvHYPZBlHDDOUg
         BC72T83QjN/kssN0lnNG3Lq8kSQFnVYDqlizNb+OP55QxUJSymNBKQv4T1yToaQCmhOi
         fpdyxUnZpGT88uzySILpxWtKzjLEN0meo5gq/m0zSRzSnxn+viULUSa+Sy42RklmIbcX
         V/Aw==
X-Gm-Message-State: AFuF++lzXA1a3oQfvpqng+jEXrYxutcuNqBNLWwUc5YwA8Nl+C2tud1N
	14NBTuiRuGdgItojsmyjO53rTtN62/mRb38IJPp0eP12R9n4tBc2PY8cJSAWOj20
X-Gm-Gg: AYBFou2qu64ByQUTwe1WOvG2jXlg0Ksb01xcZ6FkV4GCtQ7AuSfOWuq8r8Bb7Q8TFXx
	7SlnFpMBqgDvdcbxFOELaPTkzCAVsfgTqvzmBMP3VFvMj70SjtZCSxHZs904fSoIaF/pivUr/vJ
	IK20My4PfMqNJ8rU0dVHe68QIKHkyz3GGqTk9Qj2ipLCQGecJC0VVXqxIDdQQ7i7Qxq3hsLGLc2
	xBJZkgS6CHSR7ODD28fOdhDM3xaJhc27gEZztf5RDk3Xvq72B1axs2gEH6MH/NsJlERWo+rQJVh
	wJ1Q+a++WzDIALcohRPf/+aoOBuk0FI2JSBQtd4kHI+KEbSvAW0XaW5vit4iLBGUYADkqeeAeQ9
	12p8/+W9xO9GItGc25qxgNG5fGDnhK+J+HPZpPIWAjBjE98u9KIr2c/UMnrRbp2clR8WPIOuiF9
	awTrZTQZztEAuIcJoR1Q228XOIEzFL3aVxSn9rFoLXRHylwLUIzOj+33mFZmL9wk6LsJof8EoKN
	wel1BfCLDTbrzKfjvBxKkZf6gnjahQafqdEwku+JKsDAR6dTeace44pZQObzuO/jYpOag5/z0/f
	dIaQOro0QsHc9Q3p1UBqj5uajHHdoGS+qZLvAQ==
X-Received: by 2002:a05:600c:4f86:b0:49c:f504:2af5 with SMTP id 5b1f17b1804b1-49fe66c3765mr26474165e9.1.1790238398360;
        Thu, 24 Sep 2026 01:26:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de187asm47827485e9.7.2026.09.24.01.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 16/18] bpf, x86: Allow programs 2 KiB of stack
Date: Thu, 24 Sep 2026 10:25:52 +0200
Message-ID: <20260924082607.2695649-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888; i=memxor@gmail.com; h=from:subject; bh=eoLAhL3KmS8nZNL87+OS8vzX9m1boxAZzTQHOUiuxfE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvbTYxX8eHOPi4hGcu0gmbIbXb69DLtblyyPdqnr3G GwTeRbdUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkEBDEyHLjLL7DgmeQC1uOV izJVJj1UzylIM/w28+O0SStcgx053jD8Ff2+uuTtpaILHGG33c0+7Pp3fdJqt5bqOVHrvr9W3v0 /lg8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The x86-64 JIT encodes frame sizes as 32-bit immediates in its
prologue, epilogue and tail call sequences, a tail call pops the frame
of the program making it and lands in the target's prologue before the
target allocates its own frame, and private stacks are allocated from
each program's depth, so nothing in it depends on frames staying within
512 bytes. Report bpf_jit_supports_large_stack(), which raises the
budget of JITed programs to MAX_BPF_STACK_JIT: 2 KiB combined over a
call chain, or per frame on a private stack, with no separate limit on
a single frame. Interpreted programs keep 512 bytes.

The worst case kernel stack use of a chain of tail calls grows
accordingly: the callers of a tail call may still leave at most 256
bytes on the stack, so 33 programs can accumulate 8 KiB of dead frames
below the last one, which may now use 2 KiB instead of 512 bytes, for
a little over 10 KiB in total on a 16 KiB kernel stack. The per-cpu
memory behind a private stack grows in proportion to the frames a
program asks for, up to 2 KiB plus guards per frame.

The budget does not depend on the privileges of the loader: an
unprivileged program cannot call other BPF functions, so a tail call
from one leaves no frame behind and its worst case is a single 2 KiB
frame. Programs nested through helpers or attach points, such as a
tracing program entered from a helper of a networking program, are not
accounted against each other before or after this change; each level
of nesting may now add up to 1.5 KiB more.

The verifier state of a frame grows with the stack it uses, up to four
times as many stack slots as before; the allocation is on demand, so
only programs using deep frames pay for them.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/bpf_design_QA.rst | 10 +++++++---
 arch/x86/net/bpf_jit_comp.c         | 12 ++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index eb19c945f4d5..be5fc4ac00d6 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -221,9 +221,13 @@ newer kernels. BPF programs need to change accordingly when this happens.
 
 Q: How much stack space a BPF program uses?
 -------------------------------------------
-A: Currently all program types are limited to 512 bytes of stack
-space, but the verifier computes the actual amount of stack used
-and both interpreter and most JITed code consume necessary amount.
+A: A program may use up to 2 KiB of stack, combined over its call
+chain, when the JIT of the architecture reports support for large
+stacks (currently x86-64); a single function may use all of it, and
+every frame of a program running on a private stack gets the whole
+amount. Elsewhere, and whenever the interpreter is used, the limit is
+512 bytes. The verifier computes the actual amount of stack used and
+both interpreter and most JITed code consume necessary amount.
 
 Q: Can BPF be offloaded to HW?
 ------------------------------
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9fbef7504e51..e2e531dd1e0b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -4520,6 +4520,18 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+/*
+ * Frame sizes are 32-bit immediates in the prologue, epilogue and tail call
+ * sequences, a tail call pops the caller's frame and lands in the target's
+ * prologue before the target allocates its own, and private stacks are
+ * allocated from the program's own depth, so MAX_BPF_STACK_JIT frames need
+ * nothing special.
+ */
+bool bpf_jit_supports_large_stack(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_percpu_insn(void)
 {
 	return true;
-- 
2.53.0

