Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E25409281
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267539; cv=none; b=gtjhqFhHxParMh/HgRXf261et7KBo12YtwsWlAew5Uzkl6w5f4fqETv0gD2zBr/QuDYHcD+buxru6QYSTJe7TPmDNPYFXIhOPdjH8hj3usc4MfDmXUkfvzArV1NZVXdE9tvBfLBxXqrqdyUGyZbDi+XrJ9bcPzJW6JU6jzvzjs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267539; c=relaxed/simple;
	bh=W4RRDR4YWPIU74MfUi8DWR0v9/aTvVfwjKIvCLkvZiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbygmFnCL6atygh1iJEOLKU6iKWcUoeuRxlCvClVYaYOCNIJmbaEZTO23y0EDF29vU7kMbP9Ot4qH3+WU4GDu4wVQAtqV45aIB67wqjo7ALwfVBUSihRHQapYRxNyDy4l6tKg02tGhibgmE8IfGDYh1vrrJRvn99nvV6numZeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrktE/lo; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrktE/lo"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-486e4e15deaso1547f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267536; x=1790872336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJun+8vNtKJWH8E0VzNnl0taFjyUTcjZ14T5SYWywBY=;
        b=KrktE/loQrfmiLK/AryXYDRRI5KgXrmDsP1726O8cwVKnfMK6WkO6kwV5RnRF5/lPM
         JbuLS/TtlCegn5+hfuDVFZ9y/NVvD2ZFYAGMeSLWE7zYUUEhA1YwR1ewAF9MN2WNW40y
         gi+YmMBaPavlhRAxWhKyC/kuxVEl3YGUlKMqmviVS1/r/ZlDrUXRhCSObddycR0HP0T4
         PVUYx90O0h0suV2OvyviyFEvNoaKx/nub6DckrSuwvjeBh+32oYxWN1wm/yz3cBQqRxJ
         cIa2mGFwhw99r/xpdf2U7joxRk0crJBWiYwfEjTrskVfoPQbZcNHdyQUsszsmTrzLEVe
         kv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267536; x=1790872336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJun+8vNtKJWH8E0VzNnl0taFjyUTcjZ14T5SYWywBY=;
        b=TAFFcCnKLGhB92pG9RKe8zQlyvTAjRvDm3MqUdIE/QIUdGfL62rJDCJATiES4w6AKZ
         2sO+01/Leqhg9V1y9aOZtpSBN2jZAM17N6/Wyf4UBS1wbEaqd68xIu+89ABCqTzfFkBw
         S3sj0kKrlHrlYzVEUISzjGhc7c2hhvLUuaB3mT187A7pwQsV5LEqXHif2d9fP3d47LJ/
         lue25wJUnn2rsoS0stskupGGMITq+sZ1y4ogG9NwGtBCJaSf8Y0fs/yWCu+1ExX4YCog
         bSux/+DDKYPO70NLfpP34mklu5DJEOWTmiQcFvW/Q/Tr/XjDQSXu+6tkXxRP1dKpHwbI
         MiUw==
X-Gm-Message-State: AFuF++kX6ifswng3ezHZu2zLYXnwOn2opGD060280XYmOdGx4hEg2Apa
	LIuFL85/Uu5jqkBfJug3OnNTsoMUteSyn5SHW39kZKktwBWn6H6L7yOFnGeKXB+W
X-Gm-Gg: AYBFou26phAMddmE6yNXD6ObJME7DIK50L2zHA9EgxwLCyaTMRsGQCbxDffIcTQkZwF
	UkkTQMy7FlsKRkLPj7Jyo+b1e2m3aoJ4Xavze3CB9bNt8puTykLq03Q9ABQxuD6a3Avlk1b7cFc
	P7T+NRBwAs1xEWppMJ0g8TqSS+ZKuewAC7IC87HHYWRVv3wmRQtbAmB8qfxrTLv0GB6JfTejfw2
	iQNhfl9YzI3xFSv2fa7TEQXtWpeAviKeziJq9u0eFaI3syOuKPr/H2N+AREMbkrZMj3el1Ez1Kb
	JeWaktFgAP9UDvmo+Q2ILtjfEy1B06R4FWk9GSDr71EZ7QrbhAc2gEfXS2Lw4I3zknLIpEpZ8c9
	2HPeYYHjqHaWSm+oqMKMfshgTWgdpcqmjUDxNcPDh2kRK2gsDWxBnayJviNxqkM6+L/usasuCxy
	FkWPGecAdE1Z5fSv7EYLEX9MPMAD6LfMi2rTTXtcpcnrkgIVKZgTeAqXy/UscAzi8AhXN9u+n+t
	1prTeONgbY7Qy2MmdVayhD5Dv0SHuQhzzuph6ersvWAqY8eDQhTIHrnVdT4j39XPgGwy4A2Sl3Z
	FzciC8K35rOyO/LZIiEETfo+s8u02Gle2X7duQ==
X-Received: by 2002:a05:6000:2406:b0:487:27f6:a4d0 with SMTP id ffacd0b85a97d-488716a5f55mr5714013f8f.32.1790267536340;
        Thu, 24 Sep 2026 09:32:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm176273f8f.12.2026.09.24.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:32:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 16/18] bpf, x86: Allow programs 2 KiB of stack
Date: Thu, 24 Sep 2026 18:31:30 +0200
Message-ID: <20260924163144.1945455-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=memxor@gmail.com; h=from:subject; bh=W4RRDR4YWPIU74MfUi8DWR0v9/aTvVfwjKIvCLkvZiI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur77vqSW+ZRDurBGrU2refXD9z7+4TGv7M9sWPDkYuK NjuePduRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbykp3hn85uRhPnnOD5glWc PhfqKhLEW2W+11bURZ2xZRXI6VrCxchw/NfErMn/Pv46qxdsad1hb+Xy+c7Smb90Ig4tD3FmOx/ DCAA=
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

