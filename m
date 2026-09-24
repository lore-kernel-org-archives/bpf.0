Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6844A92CD
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269094; cv=none; b=vAUwo5dleDfpGlZnpIcA9jtSh4Pgvu2A0STCcv40dffpJn0BmucD5Fd66gs4nN3AohZ4mVjXVXOJKFVzyOaLjriSiuJeGOn5T7FV6fXMMFinzHyl+0p1t2dcy0qzKwf4cpdzvdI3/AUa5b73lVxWsBNo9tygPMhjJOd+vsW9U/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269094; c=relaxed/simple;
	bh=W4RRDR4YWPIU74MfUi8DWR0v9/aTvVfwjKIvCLkvZiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYjONrRoSHsPLUnT1tFHklhg4oSMq79OLaeGEg36621N4KBc7hFIKlaMtbuqCT+c9HuHygdmtgZomUrCNTk9DaH6gVDQZnaeR4IBVqG8yDVdbZEnDNtZdr/A+25PFEyXjxNEtUfWK2jWlfeor1C5znSASy+NRFFsSfMj/HEQjn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhsrZE3G; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhsrZE3G"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so166985e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269090; x=1790873890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJun+8vNtKJWH8E0VzNnl0taFjyUTcjZ14T5SYWywBY=;
        b=YhsrZE3GlT6I1vIt7Ie8hUq2GvR9F1KwmvhKE3sJXXh8HWAvI1XGrmHMX/kp9hIlRT
         yPAjNM89HRrclF5/Hcc0IbSKT2+VvgMIgutBAIJSVRG31MFWisr2ERODvLRbqMY4i9Vs
         +9rF4GvpjN1Q2oowNzGmACVLZaYiatsNNacPILjqPuVjCbiJF9O5/xXWinFug+BDXbIS
         cFkSL807I5xuVFtrxuKkkR5aS2wfw7IsFfq3app/5nE3kUuXfi9r3yYXIj0Bcql022AZ
         uCDc1Lr6FirluCeb3UIzzbhiDjm/PePZS25+f57OCex7yDYzfQLogHRvx1wRAkVYuSzy
         Zg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269090; x=1790873890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJun+8vNtKJWH8E0VzNnl0taFjyUTcjZ14T5SYWywBY=;
        b=ykUvXHTDju3fGOwIfIPAE+Yr7iyxkaeXuSj8zWiMPkPosu8hbVSLvlwnHYw/dIDrM3
         /1UivarDvOWZuis+CzmB33tvvQfl55H9gBsJjx/04IN97n9RYmyvM9t6y5hsgDqNbcHu
         Xmk2RNeBUW11gPfiz9MfJts8eEONdb1lCjojd6i+darurPM2n3I6FxG8owwotf022wtb
         FuE/UVXg1SEXBWuInPxs+/p2/NvGJHWqYXP9DqFckHkGqoC+9+j6OYsi+y3S/3UQ5fJS
         yyq3WSDmV1OF1rfK6513oY5n/XQcyIvtwikire4UndWb5pSIHh8EQe7gSIVvowIMyQvH
         2MSQ==
X-Gm-Message-State: AFuF++kqX7p1+H90pmMMB29LboMLp+/vWV/pedi/aoJ+SZzHiwCjTk08
	tGkzNGfOwR+k2DGf+g1GL5HjqTSp254PrDi9T4JpvaRRZknxW2MQaJkqKMibep12
X-Gm-Gg: AYBFou2IZsK3wvK4TdGphFSmgycPT/w9Qd4mhcZ0FMv0i5xgIS7Ame+jhDCddB48fdS
	8TXTcF9een45OKte7phAafapuBVMzHirRUPEidNNrnQNdxh1f84omK54frm/zn5asL4rBc/u+SX
	P5o4WemALFL2oWMTOfcQsMxEffll11q6INnKSndLtefyGkvf6WWz33IhSBzSpQc2rM6mLhO0pvc
	yw5ikFktUak65SbSjrzCtUgY1BQdT9bYNNGN1W1ZyDUrESNndaFsvdI79L9gyVg4Zsb6Iicwvt5
	s8Zzr4Iw/1/fSLGgEcwe2fJIk362cWYCaA2YXNcJZzJqIZjlVGVjmdk2Qki7pV1HU6epTXhvvno
	QxVDe8JGYnRFG7nb9xilrH+voFBRtnOd5WHLEmoG+IwRTBccCkF6P+Ol/aJyMEemk0053Nw0HfN
	QhrMCcW1jr5VJTu5Hy+fwN3/eAHKfeojmk92QgYDNpCPDtN5HuTB3wK7cguGx259NIqs4OwsMBb
	ik9fY4/WPSRc1P5NzkhMActIsDdgDK8qxOiXhzv0P1TXjHTorBKuBrZF6QOBdRzrPErNBLkzGAG
	q+6NTl0bejjGAiWix5BNL1kwu1HopBfBjp1bfA==
X-Received: by 2002:a05:600c:8b22:b0:49f:bbab:aa10 with SMTP id 5b1f17b1804b1-49fe66f13f6mr56054535e9.20.1790269090359;
        Thu, 24 Sep 2026 09:58:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5debbf4sm96137315e9.9.2026.09.24.09.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:58:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 16/18] bpf, x86: Allow programs 2 KiB of stack
Date: Thu, 24 Sep 2026 18:57:17 +0200
Message-ID: <20260924165740.2146806-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=memxor@gmail.com; h=from:subject; bh=W4RRDR4YWPIU74MfUi8DWR0v9/aTvVfwjKIvCLkvZiI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraHH1pLdMop1VAjVq7dtPrp+5d/cJDX9m++JHByMXF Gx3vHu3o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5v4qR4d8sl/PV5YdqjK+2 WnT/bxY+rKTnqdlbV22ycbKGue9dL0aGiX278w5lHff/2bf9eN77C0159/6weYrqVkvmu6buO7K ECwA=
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
of nesting may now add up to 1.5 KiB more. The one nesting a program
can force on itself, bpf_clone_redirect() to its own device, keeps that
program at 512 bytes.

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

