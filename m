Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370023A0E85
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255108; cv=none; b=CKK//ZsXgqJUicNE9DfBXGQP93zD/CjxNcDO2rQzmTznrP3VQaYHtK/SHV6Z8IfeEzshn7WJE+2frLYPYyYrUo1qPfZOds6kUulJkIUsMZCdwvST4r4g1cAOIka1SoBH/l5SQOJwtmKp1zVt585ibm2DGzGVwYCNdzwyh22Cv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255108; c=relaxed/simple;
	bh=pZ33VTUUIdr3Id42qBrlx9WaCFhb+RHlrLGHiyQcfmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LakHa15ZJCP5X8A2W9ZRcDGObqKPMgjEhlly1izNGznrG3LC+AbClj7J0GRvkl2fM0vLFSJmDqJYdtXQRi23h6nweIE6f2HAQxCFoe6sk0YSSA4KZ3ITae7pVr5+SeQmeTzzpl44NzeNGHAnADY7gB4qaTvfiM1Mem/i2/8g3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAaktpJ+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAaktpJ+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab3260b35dso684910a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255105; x=1792859905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i7Y25xFI3opj7OoI+d09/Ii/VGS2yIeOd9lXy3hmv0k=;
        b=WAaktpJ+2rkbK58DBKCNbLNaQKuJ3WN+W5Zoqg6dPD7Mz8dHE4YkfcJR16JcvU5Z9K
         L5fJAvQqdD3GhFtq03TKRCfNuCl/mVJDeyqIxKpZK7pU99ry5+UWHoEkFJvh1Xl0+CtU
         +FW/ydH3tBZbSb56PPmsLeQOvRV1VORg/23rRFQcZEcV5ADE9Otf8Rz3K1cdHaqnkNRc
         vW/DJODDbDMAUrsZlzE6uDWGDxHr5qLg4gZznFCvnz+Q/k5yFRklA0P2dAShqa5VotfZ
         YYkf+UC+fhSv+rLJOZFLqWL09xADsEhK8Y1eOiQ9ozrR2Mr+6yY6XwkNDclThaJdIHw+
         T4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255105; x=1792859905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i7Y25xFI3opj7OoI+d09/Ii/VGS2yIeOd9lXy3hmv0k=;
        b=AEPXV1rHx54egMplWShV8Gj3xWORWL2+Cky1kj+g3V32bQQfyqB9lQjJ7mbvMPbmPy
         IfCF7JIQLmpH+qG/roDKfXn3Q3cdos+KSSJSKbyIvn2XY1B0vWId27ntd80DMcRZqHsO
         K6pbMrBpZDrBTq13qdUsPgQuVlPS1h4XDKIxmsWNkhyMD5k0xRQmn2K/vDd6sE9u6q9U
         SYAFN6vF1FwjE/lbwvixOEhBJaX7/zCGC+Wc2UhaZUO2z4mE7aSqsW0Ca0IdxV4qrRDx
         WGkyLYslcK4Q0NdX752lecF5xq5GCCmTvKpKP0/+57fvEdnUuAkJhKQuIQOw7sfCUw8E
         kDug==
X-Gm-Message-State: AFq9FYJFyFrRYEB8T6g5FF0kRFPxCR2SemkF9oX9qLd8jQj0cO/Lntjf
	OGPaM3rIMtd0zBX6a8Bj0tUZufYrNMIG4cQROcixH/mdXDq/cgUV9m3BvCkuSw==
X-Gm-Gg: AYBFou32WYP6/guLvYgXv3mxXmu7UMIJx/ul2Iws76ioHAKaiKFNrLkYCsLbtyDTrHo
	MItUk9S5GmQ2u1Y4f5yySyP5DuKnLXSX9zqV9zavWUq4JdYTFrfpKd1ahN6NfaQqn1HqoX1mQqd
	RKezpRIUNg5PbIQqkj1KnKWnt6fTOfFBjYVEJzpCxOBtAoptn2hjjgHogwNKq41M/5vn9aG5IND
	szfAV5lnIUuefpjhgTobHGXIPXMYdSptzhAa7MI2z+Ptt3V9uo8rrZHPr3clCNWMDeSb819YcUq
	5Zz1lH717xThvg1pu1lXcLsGfIoJr8O1cJKtnedlDxyB9V83XYbaLlqdagBI6n2iMiXrGT+69Bg
	V6jFZIY0jD4AgN25MvV5thRvQtwqS6M9Ds+VComKcuaqmNMW+Zpd+s3B9RMOR1cd/gyJDEweZ8N
	VF1Rd32G+llTief+RB4wXmGpnqi2sFBd8Rdlo7r8OP5ttMPbeQ2xpOF8q9Yc1earZs8HqgOwn7L
	0QQSdlH0W8db7ov2GvZEJoAtoQlDJsq9paXDjVBQxIbLRkFKyNar6IdOPFLezS/kTapxwFm5nTe
	eWnD3qaTg/7i2+YnI4Hn14h2p/9vDrd68rGnFeXxvkwGkJnqg8JB6A==
X-Received: by 2002:a17:90b:5112:b0:3ac:450a:f9d4 with SMTP id 98e67ed59e1d1-3acef1544fdmr3002708a91.64.1792255105361;
        Sat, 17 Oct 2026 09:38:25 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm13655450a91.8.2026.10.17.09.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:24 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 06/43] bpf: forbid sleeping in bpf_find_vma() callbacks
Date: Sat, 17 Oct 2026 16:37:08 +0000
Message-ID: <20261017163745.3341787-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A sleepable program can call bpf_find_vma() and use a sleepable helper
such as bpf_copy_from_user() or bpf_copy_from_user_task() in the
callback. The verifier accepts this, but bpf_find_vma() runs the callback
with the mmap_lock of the mm held for read. If the user copy faults on
that mm, the fault handler has to take mmap_lock again. Lockdep reports
recursive locking, and if a writer queued up in between, the fault blocks
behind the writer, which waits for the read lock the helper already
holds:

    sleepable prog                  other thread of the same mm
    bpf_find_vma(current, ...)
      mmap_read_trylock(mm)
                                    mmap_write_lock(mm)  <- waits
      callback: copy_from_user()
        page fault
          mmap_read_lock(mm)        <- queued behind the writer

This is the same problem as with sleepable task_vma iterator programs.
The verifier checks synchronous callbacks in the caller's context, so
in_sleepable_context() is true in the callback of a sleepable program.

Verify the callback like a hash map for_each callback, as running in an
RCU read-side critical section where sleeping is not allowed, and actually
hold rcu_read_lock() around it, so that global functions the callback
calls, which are then verified for a non-sleepable context, see the RCU
protection they are verified with.

Non-sleepable programs already run the callback under RCU, nothing changes
for them. A sleepable program whose bpf_find_vma() callback calls any
helper, kfunc or global function that may sleep is now rejected by the
verifier, including ones that would be harmless under mmap_lock as they
don't touch user memory.

Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/task_iter.c | 6 ++++++
 kernel/bpf/verifier.c  | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index cf2bf388e181..2fa6b8dae8c4 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -810,8 +810,14 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	vma = find_vma(mm, start);
 
 	if (vma && vma->vm_start <= start && vma->vm_end > start) {
+		/*
+		 * The callback must not sleep while mmap_lock is held, and the
+		 * verifier checks it as an RCU read-side critical section.
+		 */
+		rcu_read_lock();
 		callback_fn((u64)(long)task, (u64)(long)vma,
 			    (u64)(long)callback_ctx, 0, 0);
+		rcu_read_unlock();
 		ret = 0;
 	}
 	bpf_mmap_unlock_mm(work, mm);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 883cf148235c..430d5309eb5c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11629,6 +11629,8 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
+	/* bpf_find_vma() runs the callback under mmap_lock and RCU. */
+	callee->in_rcu_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
 }
-- 
2.55.0

