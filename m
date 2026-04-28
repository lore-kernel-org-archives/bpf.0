Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4230DED0
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777412396; cv=none; b=avaFn0umX464BVCLX90Wr6QCJa6PO5NrU4/VdSGUdtaD3sssg0W/4WfFY5wmp2tYe8vVcY5NITd95ufwn9ixke8Yeb+6JwgqmtiQvcGLix5W1hB5s+H2Wo6HzSXtJUJfXCFTnohvcHH7CWQ3j8EduUda4xffkIRv1XR1wkq0dPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777412396; c=relaxed/simple;
	bh=2Ni0QkW0NGfVprOQQjm8WTRDtlmNc4uK0zqe0v1y0qE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q/aY7LVnAAep4ZHxrHmnvaOASbGx1wo+IebIKq6c+H7HMZFL/xIFQ+cWyvZ1BfDV9TIc057E1pRU8DwY3lmtqIV8Cgnsa43yZ+N9xwcRAW93Uo2l34Nv6fwRMaEA9dpWVMI5a52gOb5+5dfk05pgKEQ+1eM6gRpWIrCzWwNEejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1LGMQ92; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1LGMQ92"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44509921fbcso1695216f8f.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777412393; x=1778017193; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HywDFu5uow+eABYUf8ZVc3vYAEGsb+wCpKPMtWg3Yjo=;
        b=W1LGMQ92nZyU4YttYAbQO1eA5zjuxQ+pv3bk+Mz3sT5x3JZEbAglUSPb7upqhuBC58
         29c/lauKGQ+WETRJTZCOn6HZL15E6UJmkyGq2f7n7daRPjYu/Nsad0JHsjx8J4Fi1+RM
         quJ3cOCBLW1x39gRlo23a7WRSai6BnuKFCpDG37aZTbQcYJS7fTRtaxNjafzg9EVcZI0
         kYmDKIS+k+gfBw2jXdrrWmFuLOgmviwQ0Qp+t7Osab7eim6oIjqIxrG5gRkelZD/jGda
         bWK+SN00REKzqla/qFB65ehbiwCivbIhXommKAD79ukdZX0JXzOXB4YcTDmaM2U/7mu+
         F6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777412393; x=1778017193;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HywDFu5uow+eABYUf8ZVc3vYAEGsb+wCpKPMtWg3Yjo=;
        b=nEvm2zoILJLcuNia2Er4tnRNvlsyQXuSPGAGMYc9pnRsDFUwtLYk2Qj92eOP7oj91I
         Vt8tEGyopC6CFU2xjlJ3QEn0LwjKwNrXhyZfBtFUHjwDxqh+tHP3dS3MK3WWAgBd84hO
         HBW1AjiugVbx1sEqIwxQ+SDN+vz8Xdbb4dUnISaF4kDde4CdixD0jAmdwP1dnE88tacl
         7tbT3Sk7V37qAUI8pUhykkV9UikbuS6rRexkPKXeqrtedj/mZAgRUb4hYQEmQsXOm+mA
         HxM2eDAWTH2/vj7h4BReU08b69R4nj3+mClJtzWO9MO7QU51LMfXFVRWvn7MKQONypZJ
         s+0Q==
X-Gm-Message-State: AOJu0YzuVJ239R0oflq8DTcW5eFhv67St1vGssJjyD46Ri2W44T+fqO4
	CuHZMsEUfZm2b/7LpzKavYmUpmF5Ql0e7ch1AijceGXzkFx0wzIfNArQ6zHIjg==
X-Gm-Gg: AeBDieszLtN/pEIDoUUwB7YYfFXvYtfaEGVFDYYEz86YfZ+Y5Cn8XNPz3sWG3XXHzQI
	NRbUNlvxklrQcLscUocBYkCVGW6B8RILRfl6px/XislOg4vleOfwir9Esz4T3ro4WodBd2jN6kw
	STVw0hJdwd/T66uURxpgzJAON1JCEKI0s5j+nyr3YDW6PPwzisnQ+N4cQ7lFWQ+TcKcW/cRamX1
	gXQKKF79XRxTC2t4aC1j/N3NJu2ZWZ8UVQ6b0AMy521vyhIKkD/nipNRrzLmY+HLczzX2inVqCt
	jiMPIBM8ntLHSdKJEkiPU1Wso1pHumlYb73f3aFa7OK4p1LeZ7XmB1eio4sElMfqDGYS4GeFrIp
	NlsmRnrqFo9gvB7iMgysrchzyzRkGJf9pjG5vPGVwrzhyKAQfXV1Xvr5ZRRLIJnp7Kn1y03A8iL
	t32QuFz9m2VTzOYOGqO8sqjS+ZJbXBSw0DqLLPkALG+0Utz+ZZeD7nk+F4MPnInu+6gaJwq0B/s
	8dG2+BOQXPZVdgUzQ57H0eKrTbzRlgDXkWpJYqjN4bA98a8kmm7uPut0CXByCJ1xq1ey01RpGIt
	nFDlEgXKO/sQJvt3pKXmUfd61GoR6d2uYgxT/jlGu4/KqWwzQDnB46aq3kfd9Ly2
X-Received: by 2002:a05:6000:2401:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4479065df83mr1778956f8f.33.1777412393276;
        Tue, 28 Apr 2026 14:39:53 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004dbd7290f8ae2339.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4dbd:7290:f8ae:2339])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216ed6sm894646f8f.16.2026.04.28.14.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 14:39:52 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:39:51 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Print breakdown of insns processed by
 subprogs
Message-ID: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777398528.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When using global functions (i.e. subprogs), the verifier performs
function-by-function verification. In that case, the sum of the
instructions processed in each global function and in the main program
counts towards the 1 million instructions limit. Only that sum is
reported in the verifier logs.

While starting to use global functions in Cilium (finally!), we found it
can be useful to have the breakdown per global function, to understand
exactly where the budget is currently spent. This patch implements this
breakdown, under BPF_LOG_STATS, as done for the stack depths.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - None for this patch.

 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 101ca6cc5424..976e2b2f40e8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -779,6 +779,7 @@ struct bpf_subprog_info {
 	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
+	u32 insn_processed;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
 	 * are used for bpf_fastcall spills and fills.
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03f9e16c2abe..b48389b48eb6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18183,6 +18183,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	}
 
 	ret = do_check(env);
+
 out:
 	if (!ret && pop_log)
 		bpf_vlog_reset(&env->log, 0);
@@ -18215,6 +18216,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_func_info_aux *sub_aux;
 	int i, ret, new_cnt;
+	u32 insn_processed;
 
 	if (!aux->func_info)
 		return 0;
@@ -18229,6 +18231,8 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		if (!bpf_subprog_is_global(env, i))
 			continue;
 
+		insn_processed = env->insn_processed;
+
 		sub_aux = subprog_aux(env, i);
 		if (!sub_aux->called || sub_aux->verified)
 			continue;
@@ -18236,6 +18240,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		env->insn_idx = env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx == 0);
 		ret = do_check_common(env, i);
+		env->subprog_info[i].insn_processed = env->insn_processed - insn_processed;
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
@@ -18262,10 +18267,12 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 
 static int do_check_main(struct bpf_verifier_env *env)
 {
+	u32 insn_processed = env->insn_processed;
 	int ret;
 
 	env->insn_idx = 0;
 	ret = do_check_common(env, 0);
+	env->subprog_info[0].insn_processed = env->insn_processed - insn_processed;
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
@@ -18288,6 +18295,13 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 				verbose(env, "+");
 		}
 		verbose(env, "\n");
+		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
+		for (i = 1; i < env->subprog_cnt; i++) {
+			if (!bpf_subprog_is_global(env, i))
+				continue;
+			verbose(env, "+%d", env->subprog_info[i].insn_processed);
+		}
+		verbose(env, "\n");
 	}
 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
 		"total_states %d peak_states %d mark_read %d\n",
-- 
2.43.0

