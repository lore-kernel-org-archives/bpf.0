Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662251;
	b=4r6DsVC2rklf75jeAAqoHAW2I3lE1atAKWiu8DhjmXW0dwc9uooxE4zte2aLnuJ3phop
	 bofo9U9Rd91ZcfMquhgS7yVMNJ9iY6wbiCJ2Z2JbRGLSm9JTZ9kYObgmkRfES614pdVo4
	 Ep6Ww5L1nIf2AAmgjC9nXN3spkvFVvwrRxXESDhJRmmryDXdFuOuCD/ux72wScOdaLIHO
	 ylAyYEWCCtmA7UlhhGBaFLxgzT0614Q5d0eX4v2jy0mOep51dKZV6iijGvHbm1BrF7Njx
	 LlyWVerP1fnkMo7kTDu1oChyceLmqIS8k6Pc/7CR0SPzrgXdj36ImLvM/WC6G5lcgeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eavhGyMs2OlRyaep6DoY3KL4/4c96J2IXqmi41o05Qg=;
	b=gWH2kB8ISmQVVcB00QKbwLKS1FaDdvO0xmC8FzowQL0BlkIqS8xnTCJLsb4XTxoikpT9
	 /yNADWah2oHmtaPzLQn+7KoRuUzyYBuz4zr+HZNzCDh8HokjXZisE6enJUVxRFnimJLFE
	 kPbbLzs0hbq4K/6TQYB3d2Tmfrws0nzgUpmhlBnjMUB+i5gmI5hUDgGHbaNZ6d9Of5okK
	 vR6+DlFjnzhNt+YF71XzsT5NRXOqBw23VwXyOhYL89dRIA9XOg0MEDMJ5OdX5NQvZKtJi
	 wbXfML5goqDBzmwO6T+epJPhSRGORcTf9Ucg63zBS4FrF/BA1OjhlreRnqKZDzSoffA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="V4xUN9//";
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C57606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0C57606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V4xUN9//
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so2860226b3a.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662250; x=1796267050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eavhGyMs2OlRyaep6DoY3KL4/4c96J2IXqmi41o05Qg=;
        b=V4xUN9//v/u37bYX9jaTKYHPR+gEDq/KaOIj2ScT1tlNjHY863kzdALUvg07Nq0Z40
         T0tcq7d/YeTfztT96ipRHwm/OyZHYm/fXuSu0iDSLtOoGr6Eapn5kfX8bj5RVo50zpCG
         32/zQi+eE8fU6MXamnmxC5naH6rDFPzikw0xb6SYQV3mkSLES/VcizpW/VcPiYxUWkMe
         k57QzpgYzdaSLjcTsHSyZ2qQT5qyHVox4XJ0d3omUK04w/SCMEqv6XbgPBjt4yly+M2u
         xGaFL80zunNeJuIcgw6SCevSUz/GiTKkED3/C4QxIuOuPwDDiTL8mI2VaB23/1no3C0F
         YFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662250; x=1796267050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eavhGyMs2OlRyaep6DoY3KL4/4c96J2IXqmi41o05Qg=;
        b=jQ1MYyAMU9Yr7jCNL+EDa1//NapoAhAbqZzAQAqoBlT6SOG52vNfqnIxqPfuDsvN90
         aNIJys0YYvxM/HmZIKen+B+hrIvB0Bhrk3ZAViYqqMzKdBige8nhPhT/BrzBK9ZMAPtz
         jCMF/zo5nqcHl6P4Ygd4XJ4wZ6h5JFRisrIJM/J2ZxJPnzBNa6FQzqHGDf1Ao2H0KqQ1
         HncywWCGv9Oqpseyc++T/VH/3kG5cqBsLs9Fgo61UVkkNxHz2PXjz5jZ3kVlfFJHHz45
         JKq0TmX3hdvYouaB8jmWk+rX9zDXVxwZEj21NvqNsY5MtNAYwD56eAs6bv8yBa3nVk6s
         wqtA==
X-Gm-Message-State: APuU4Z85lPCWo+NHsSmpXpnVUe28eLLmEHjevTMQwWsRQzbDx+SCPWDH
	0QwkxWE7VAPJUmgZAaZedQEhMecjcFnRq1qn2ZgYWMtKl18Wpo48ML7L4UOH9A==
X-Gm-Gg: AZFdTZc1q6rFMuuToYIfz2LV+D92m641EaP9AlbxT79JFF/l25l9hRVoXC6Do/9vV5n
	2SnPv89xmF14FHQB1+MR78b9PDEYSinTeRIPi4efTE+v9NddV8ddJUBjD6z1cuuZe3WRRTZbsFr
	q3rpjeT5AaMVf589hPOvGjeN27k2ehAlyp1JTQggSN6IcTUtYKkVvo+OtB2OWaPlgtXHLadjN+G
	jfYrmTt0/ubzcypeO6EfttGjK2eFKyL3c5S9DFxCfs+9w/Yepke2fh+T53h3omoN1evpKeq4IhV
	Gz573XMzA2p7hVWhJmFt0uPa6zbuYns+p9zve2VGl2Q+6LqmfLVPAhEu8K6L2OjsmV9XWXzs1Iu
	UjAqYJvNyN9UAF5AiBtyeC+Turb3Cp9uqc79wFcAQzhyl4XzRG7orJZTx6OD7jNAiIIx1agwb7y
	vTa5Jd19Okj9lBME/N1FCT932wIVMnlqtIok/6v9pKJ7rtW7ALYh7MplEQV50/KdGvanXPca+OD
	AUQHm60w2mXusQ+s4GUapsHxUa7Ofp2VfQGANBcqDe/9Xh6dYOZHiE3HIRHY3PEMJP+vF/n8jkQ
	MkTKR8XHo6jDAid0dRn996bagVdqQpe/q+5IAPD6y9luCBNFRYyaqRkN4ypBWXTQm3GxVQxzmPp
	kCWav67bCWG1XkXnW5RiRQ9yBCByugqhUmqPljgLcfBjsyFURyS6jinxptKbRlDFBqgguc/SIqt
	s=
X-Received: by 2002:a05:6a00:181d:b0:8a0:23d4:f4e7 with SMTP id d2e1a72fcca58-8c87ce33af7mr18255407b3a.38.1795662250037;
        Wed, 25 Nov 2026 19:04:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077babfsm10153324b3a.5.2026.11.25.19.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:04:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 4/4] bpf: Allow only fentry on a subprog that can throw
Date: Thu, 26 Nov 2026 03:03:42 +0000
Message-ID: <20261126030342.4013902-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
References: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
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

bpf_throw() does not return, and neither do the subprogs between it and
the main program. With fexit or fsession on such a subprog the walk of
the stack ends at the trampoline.

Allow only fentry, as for subprogs that unwind. might_throw of the CFG
does not see callx and counts dead code, take what the main pass found.
Two selftests expect the refusal now.

Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h                                 |  1 +
 include/linux/bpf_verifier.h                        |  1 +
 kernel/bpf/fixups.c                                 |  1 +
 kernel/bpf/verifier.c                               | 13 ++++++++++++-
 tools/testing/selftests/bpf/prog_tests/exceptions.c | 12 ++++++------
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e9a4d15af0e..92c314065d58 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1937,6 +1937,7 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool has_prologue;
 	bool might_sleep;
+	bool might_throw;
 	bool can_unwind;
 	/* frames of recursive subprogs can be on the stack when it is called */
 	bool in_recursion;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 151b5781606d..dc8796ee8cd5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1181,6 +1181,7 @@ struct bpf_subprog_info {
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
+	bool throws: 1; /* as the main pass found it, callx included */
 	bool can_unwind: 1; /* has unwind_exit */
 	bool recursive: 1; /* on a cycle of the call graph */
 	bool in_recursion: 1; /* recursive, or a recursive subprog gets to it */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index aa590efc32d3..7af8cb886f7d 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1772,6 +1772,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
+		func[i]->aux->might_throw = env->subprog_info[i].throws;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		func[i]->aux->can_unwind = env->subprog_info[i].can_unwind;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b5c812bea918..967cedec6fad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5477,6 +5477,7 @@ enum {
 	CG_ARENA_SP	= BIT(5), /* subprogs that get to r12 */
 	CG_CB		= BIT(6),
 	CG_GLOBAL	= BIT(7),
+	CG_THROW	= BIT(8), /* subprogs that get to bpf_throw() */
 };
 
 #define for_each_marked_subprog(cg, s, mark) \
@@ -5520,10 +5521,13 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 				(si[s].is_async_cb ? CG_IN_ASYNC_CB : 0) |
 				(bpf_call_graph_recursive(cg, s) ? CG_IN_RECURSION : 0) |
 				(si[s].has_tail_call ? CG_TAIL_CALL : 0) |
+				(si[s].throws ? CG_THROW : 0) |
 				(si[s].uses_arena_sp ? CG_ARENA_SP : 0) |
 				(bpf_subprog_is_global(env, s) ? CG_GLOBAL : 0);
 	bpf_call_graph_mark_callees(cg, CG_IN_CB | CG_IN_ASYNC_CB | CG_IN_RECURSION);
-	bpf_call_graph_mark_callers(cg, CG_TAIL_CALL, 0);
+	bpf_call_graph_mark_callers(cg, CG_TAIL_CALL | CG_THROW, 0);
+	for_each_marked_subprog(cg, s, CG_THROW)
+		si[s].throws = true;
 	return 0;
 }
 
@@ -16068,6 +16072,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -ENOTSUPP;
 		}
 		env->seen_exception = true;
+		env->subprog_info[cur_func(env)->subprogno].throws = true;
 
 		/* In the case of the default callback, the cookie value passed
 		 * to bpf_throw becomes the return value of the program.
@@ -24410,6 +24415,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
 			return -EINVAL;
 		}
+		/* bpf_throw() would have to skip the trampoline that called the target */
+		if (subprog && aux->func && aux->func[subprog]->aux->might_throw &&
+		    !prog_extension && prog->expected_attach_type != BPF_TRACE_FENTRY) {
+			bpf_log(log, "Only fentry can attach to %s, which can throw\n", tname);
+			return -EINVAL;
+		}
 		/* What it takes of the stack is not counted, see bpf_insert_recursion_checks() */
 		if (aux->func && aux->func[subprog]->aux->in_recursion) {
 			bpf_log(log, "Cannot attach to %s, which is called in a recursion\n", tname);
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index 1bd15c4c125b..fc36cd226fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -266,26 +266,26 @@ static void test_exceptions_success(void)
 		}), "", 0);
 
 	if (test__start_subtest("non-throwing fexit -> throwing subprog"))
-		/* non-throwing fexit -> throwing subprog : OK */
-		RUN_EXT(0, false, ({
+		/* non-throwing fexit -> throwing subprog : BAD */
+		RUN_EXT(-EINVAL, true, ({
 			prog = eskel->progs.pfexit;
 			bpf_program__set_autoload(prog, true);
 			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
 				       bpf_program__fd(skel->progs.exception_throw_subprog),
 				       "throwing_subprog"), "set_attach_target"))
 				goto done;
-		}), "", 0);
+		}), "Only fentry can attach to throwing_subprog, which can throw", 0);
 
 	if (test__start_subtest("throwing fexit -> throwing subprog"))
-		/* throwing fexit -> throwing subprog : OK */
-		RUN_EXT(0, false, ({
+		/* throwing fexit -> throwing subprog : BAD */
+		RUN_EXT(-EINVAL, true, ({
 			prog = eskel->progs.throwing_fexit;
 			bpf_program__set_autoload(prog, true);
 			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
 				       bpf_program__fd(skel->progs.exception_throw_subprog),
 				       "throwing_subprog"), "set_attach_target"))
 				goto done;
-		}), "", 0);
+		}), "Only fentry can attach to throwing_subprog, which can throw", 0);
 
 	/* fmod_ret not allowed for subprog - Check so we remember to handle its
 	 * throwing specification compatibility with target when supported.
-- 
2.55.0

