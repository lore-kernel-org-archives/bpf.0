Received: from mail-pz2-f30.google.com (mail-pz2-f30.google.com [74.125.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353BD35C6B7
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039618; cv=none; b=KPOt9x/X4o85nouf1DraibUfHfbwoCFV2vPCcnvzEnVq6BpHAB+gXU8DWo1BILuSxDoeJgZxRLD9B3bjTYmoeIjebuc93w6LENNB5qVqTVaaEaJgrsLj6GsFvyadLwjvSy+NGn0a5H64+2WmaJwOSXco4iyluwKJMFa7IcLpYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039618; c=relaxed/simple;
	bh=A5EPA8fm38AZU2wxdZ/+j0TVtsb/Xjio9EcFbV6TbWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFDnZBHkSgz/c3sZ3uCHrCxdcJ9iP8HO47E99mmFH760vEX4Z2iA0br2AfFNbj+Ccz7aQQ6auN190kWHZly2aHNUYE2vUtplW4c6lKsj/zDyvzMXZnYy/tt0GIUdo+SM261vZYf3M8K6KldYPULw2AfTv+Gcf6ENDIyMDhZ2Gf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW0bzTfq; arc=none smtp.client-ip=74.125.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW0bzTfq"
Received: by mail-pz2-f30.google.com with SMTP id 41be03b00d2f7-cc1cea50dc0so1549782a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039616; x=1790644416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tG9ZSUod38cjd11Rs2zD0fPEfXkc1mwEBshikgxL1WE=;
        b=YW0bzTfqBaY7TOAhQ3s9XP0uYm/AFOPozmSLrcvUCp0nANW+NhHI8tYrSQUST2f9mJ
         1dllRV7fIquieEn0nJn3FE7uYpMnrF9/+cgUDNXan0dA4qUd+8ucJ70GT2NvetYLwxRZ
         Z20ieQtVUwTm4NsSHKcAdc6oZQ1O+DuKBsmMPzSkNBNT3rf3qGEABWvLVNtCp4tKXlUp
         k5fnxRspPZs6TB6O9s75WPvf0f56W++T+hdP/PC2Pg7WwSNCw73kw8bkIAI+H41f44uP
         I+qnzFUZVVm7eG/1ZRBAlnOhBde7xnwy4mFNMQLO3vz1v2pEL4dyTNOKCvg54MyHMfSC
         HHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039616; x=1790644416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tG9ZSUod38cjd11Rs2zD0fPEfXkc1mwEBshikgxL1WE=;
        b=GK/ZC60MPZhenCnoDSxa5hImlKhj4f844UkArjphZfjHiug4R4b9su5YtVd2AmJe+E
         I2wANGFrltdAP1Zn9IkIW5CSyKYdkCxPjraAMK7cGRIKWZka2ZPWPvT837C3Yz8cQERg
         460Hp2+hQintnIihfYh/hQZdtwrurvypxuFExRh5aKUco3nAkyygsuyYgq8VYrYJSKNy
         EZb4qQjsbjBB8C5ixy1GkG4z1HLCy66iQK/z5TJKTyOzCl4e36vZGAj0IOqN1as2hzT0
         XjvYU58UqM3AkosVbDuel8FP00R4gah57n/ApcmWSaAv6pziYZRnHsdbZy/10MTu7DyQ
         E+uw==
X-Gm-Message-State: AFuF++nvTEAIaK9WyivUwJS/sFEzjd2BlIdJYrnhM2SQFCqGOt48HnX+
	2nhVcZEPDrlnEfKFYdrBAJ5vCKd0kXpBi0ZC76tCnfb+MSz8vyUsHIWo0g5hpw==
X-Gm-Gg: AYBFou28M2KhPao1bcoQ6QuTOMPwVjsgCDdRTZxHaDcaPiBaQACEQqClcXgjgSLvERH
	MnqiKSKiF5gAjFAwOlFd/PLkqOLAS4RZiCWfdGRJYvv3MRlP8runE5ysZo3AfT5jQzfrySVo/Yb
	n0VfmtmJ8w/hrQEscTukOkUbOMDdquBGHsSzwxMDpLUly7QckmI5kCIotZb8H8zvG3J5n9ttdgN
	BBsq2Z8vzLZHl6xaSetQzuJQH/Bzz6F64Qo90sgzQa3gKBtetTjdYknRJkEf5IJRusxcjpmKgE/
	hxRe68UmpdrSqJRJumaPTs+F+dBUklkDZRwjnFF7KhEGHDQSNqdKUuO/vGLlv7btnQTssLuUIfM
	TBB3pL0w/8wGHisI84wlz5lNe9eUm406WUZJImNcrwcR76olqBYrJ4ROpVrQiO4FKpgyMdUuSA3
	++gAy7RMQAaeoFIrHdfl/Y/aE4OQZgEh9PYAK5YvGXhtmD2/950cnCGJiU8o9bcnDSWjJcF31XZ
	atgwl+TxG3OJP/bvp6p1P4hx4kUQUwtpFkarijMatUS3AyoaD56zxUo0NI91YcF9YxY7GqBreKc
	d0o6FUqxbDtw4m2zWEDzCLkcJoekRTTSnyEVl/dxNhw=
X-Received: by 2002:a17:90b:2b43:b0:39e:1ff0:331b with SMTP id 98e67ed59e1d1-39e54d37ad0mr16565913a91.2.1790039616083;
        Mon, 21 Sep 2026 18:13:36 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674c321dsm1620456a91.14.2026.09.21.18.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:13:35 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 01/17] bpf: Fix infinite loop in check_max_stack_depth()
Date: Tue, 22 Sep 2026 01:13:07 +0000
Message-ID: <20260922011323.1298619-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

sort_subprogs_topo() rejects recursion via direct calls, but allows cycles
that go through ld_imm64 BPF_PSEUDO_FUNC, since the address could be taken
for an async callback. The main verifier pass limits the number of frames,
but it doesn't follow calls into global functions.
So the following program passes both:

  static int cb(u32 i, void *ctx) { return foo(i); }
  static int foo(int x)           { return bar(x); }
  int bar(int x)                  { bpf_loop(1, cb, NULL, 0); return 0; }

  SEC("socket") int prog(void *ctx) { return cb(0, NULL); }

cb -> foo -> bar -> bpf_loop -> cb is unbounded recursion.
check_max_stack_depth_subprog() walks this cycle too. None of
the functions use stack and the frame counter is reset by every global
function, so neither stack size nor frame limit is hit and bpf_prog_load()
spins forever.

Reject a call into a subprog that is already in the chain of callers.
Async callbacks are skipped earlier and are not affected.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d62c0f74cff5..72ea662baea5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5505,6 +5505,22 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 			}
 		}
 
+		/*
+		 * sort_subprogs_topo() tolerates cycles in the call graph that
+		 * go through the address of a function being taken, since it
+		 * doesn't know what it is taken for. Such cycle is a recursion
+		 * unless it's an async callback, which are skipped above.
+		 * The main verification pass limits the depth of the recursion,
+		 * but it doesn't follow calls of global functions.
+		 */
+		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
+			if (tmp != sidx)
+				continue;
+			verbose(env, "recursive call from %s() to %s()\n",
+				bpf_subprog_name(env, idx), bpf_subprog_name(env, sidx));
+			return -EINVAL;
+		}
+
 		/* store caller info for after we return from callee */
 		dinfo[idx].frame = frame;
 		dinfo[idx].ret_insn = i + 1;
-- 
2.55.0

