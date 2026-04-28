Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0F43E9C5
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388126; cv=none; b=rWs7O0/tyo0A98Q9+br/TeQotVT3wa+4Kn0MBTUGziKLB24HFrUyO95BSwGkfLiiAiBq5NLEuU2UqB7epwsyXkVjWK6Ka7fhKXK0zp8fjBaewTqTPFZ43q/cQGsOy5Wa+gBSkM+glJiiEJ9UHz3ygfiBFNciHJmEUTW0by04dmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388126; c=relaxed/simple;
	bh=LCO6K5Y3DUN8mqrbtGmMrzvzjJ0y+mOOCEtolN0u24s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oyjlrEQHe9hTvPTSqGcOlMA9IfwHYuKvRYgVz6G3GF6CUXAGZ/IEYiFG0IB+UA3fYnZ5xYt1DvprsgHKyd8ql28ah+NBSfZ2yxtqjPgpEc4W8Ums9VP5H3LlJ6/MxI7iweM5FGuSZjVfFMyGqXHD6R23+xgkUO+hmw9otIkAMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZWicnY4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZWicnY4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488d2079582so136155715e9.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388123; x=1777992923; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJQvvItXDKEFw55ddzouXtlAPrXgiBxPg3SAZAF1X+8=;
        b=FZWicnY48w2tKKIBptX5q7HMrb9/Oaosr26qVnNXX3RzmPAa6njXv0N1tHZG6sF90h
         DJehrgN1aJlB0FE4PX4CB3PihXK7Vk9rDpmk/ij4+q1PXbzFiejw/40uFebpckPVXSMl
         GuPtSCOK1UKch56KdAU0/t03qQXqegQ5+GhqEd45yG/BLsmk6Sg8mCBOOOCK4sZa387C
         w3dxE2hm84omvXYoWtddtp6mV9XiyxbMn8e96otLHdwU/nkkRYKUE4+3abq/+A/snyhe
         /N9wZmUlmd9DOngbcdNitHbvk/9cZboC0F7Lz4T3ONjnIH+Q7OY6AeD6guwpiPcqoGQg
         YRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388123; x=1777992923;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJQvvItXDKEFw55ddzouXtlAPrXgiBxPg3SAZAF1X+8=;
        b=BOeIRt5K3ofyBbMiqkPlYphMxMd+6uN0ldD+5X0en14wE1PF71VAnRrJIMb6SjEb9B
         gYwNbxGcwdsBm5oulW+6vlXRmdpnRjAKYbl6eQDJ2jIn/DDoTHKxYk7w+HUURJLvIHEr
         2mrX8WOJCrpTQrPabWOgyDt8UUq+1VJIyPozCaRMZiqD/T2TXWqlqHhizr/MWFkCodEc
         xNXfSOU8O3NxA0UbUvzFReS3Tbm0Bc/JPRiWPDKFx9aMBP3SsJngcpFjiVgJSsQ4eIMd
         aMDM0CTvOp7ab0PcQFOmzz218vsVkwPh56oP2vdTdjf4TROf5J038vZru7XAgYgQwmm2
         WZpg==
X-Gm-Message-State: AOJu0YwDvSUDlXdjk4PVXMoNdicca6OE7Z6erdtdNsd1SsD2eoa6YmH3
	505A74TLvaZNKT+ttGIKpcQnNQSSBvyLnWmqYO6O9WQlDUQtCSm36ntq1N8csA==
X-Gm-Gg: AeBDievjTnrEVdWZgaGyO4fe/MnMYPHqUTJ4BOcBQGmzlj9o1u/4ITLcS1hqIhwupzE
	PEfanIG1CqcM9hXQYjWwYj/6AwmPbCFyDLbMAksUoNhfj/ECOCfTdxT2UmcvW84iYF8KKC2Br2D
	74lf/99ZQFxFKMUgYElcWrqdqxPHfnvBdLX4usjL+qdjygK3JUdAwquV9QGYoeKzzfRaJl7Jcsh
	J2fKHs1qDvUtyj9lK993ABO9P9lJ5ej9Snm4m61f0TiC/zrshhtnXmiW2pN5HMgkkb8D+IqmFE9
	rht+bHKLWsrhB6rxa/WdTmHzCeb40WIyEuiL8c/gV9x28xXWLkGfOP6ZPdBo5fDJ7RI96uqv83H
	QrY2p6qFMz6M/6Vx52CSCd2W3JvEki+CJSftucxTVsKy6WnHcWSlCP914vIqxMi599wzufXTn+z
	+xY5esQCQWvJJ7Np7vwjwNOqehCsZO6Q1JDomgbtONX05ZW5UeCcqzACkxUsI3zF3UJ7NuDqR90
	vvG6LstxWxhcD31RbWyexZoudBP54SzY353fgkGWu/PwZkBNxqxjOEJ41j+RROpymkcQ026Iw/N
	Bf+A7Km5SPL1SFICmdL3k7AtuXdlOAFyNMHZe50m/fLsGn83tSjW
X-Received: by 2002:a05:600c:5247:b0:489:e696:836f with SMTP id 5b1f17b1804b1-48a7b519485mr377215e9.10.1777388122781;
        Tue, 28 Apr 2026 07:55:22 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0059b820af0e4d43c8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:59b8:20af:e4d:43c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773f8b2fsm59456765e9.15.2026.04.28.07.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:55:22 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:55:20 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Print breakdown of insns processed by
 subprogs
Message-ID: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com>
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

