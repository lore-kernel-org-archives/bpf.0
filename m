Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270481;
	b=HrrgvmKtbW9eqXizBtDE1C5Qj7rldOX9CX4bzAMpG1nYTIlqAdGlLA/SMddCeZpjrFJr
	 6fYv9HMEgokR4Jhgzom9sWjpRu+DMW+GRWz86vJPh2BYcnko1aABg+22KkWBT070QbWDn
	 El9CMRL3T5m73gKiD2Sz3jDwe1nPCdFkfnbKMtkcsdqLfsIrMMHZKYxvCV0WV3bfRdpaz
	 7E0QYqmh9E7GTcC+OtoHLhvN2N7rdg4bxqoGw+w2HzoX5LRgc+teG7265yClsYqp3vXHY
	 0ZOXaIlbCX6jDlSqVp+zAeuBMAFMBI9G93a3Vyrsb59Il5Z5nrQl4BaCBSjzHkRcNHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=kv4c8wpatJW0fs+TYedE8BQdpzsR6rNWWBWkGuKgX+Q=;
	b=e79ATNj5szWOcY2J3J32kTjqSMdyRIVfgoW+i/OWNDsXaNk5xgWcVCnWel8ZAFZTrRMB
	 fJ8mFr0/iwN40g+i9irObQ+jz3xY4/v242YQYf6IcBm1RZtxBr56SAooHay1EfXKXYpqn
	 w30Hsi4JbHFT6FT1EJ8ozUlrGLTQjg500NRc7ftsGV4hmN3uTdw4bRzpJciu7Scii9G/u
	 jPAukjocs1YX3ny1/N1YNvFsIdPzQnR+uaNLGWWLFegiTe08IlplrOHzZCAQR80qSWKXj
	 zxxzlk3gfgL90UccuGrK/gMMPfcHUbw39gzZtFPxaKO1KgnRWEV4ZI4iW1rfs+XCrTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klPrM9d7;
	arc=none smtp.remote-ip=74.125.225.73
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227D606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2227D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klPrM9d7
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-490ca655ba2so725746f8f.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270479; x=1794875279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kv4c8wpatJW0fs+TYedE8BQdpzsR6rNWWBWkGuKgX+Q=;
        b=klPrM9d7sQKwU73eGX8BBrc+xaaw9HiTaGvszlrpYdWTlQKLB0kZtf1bND8p48YfqM
         KHwnc1DsOO5VPfMDUeFa8aEGtgutE13jmPckjxn7JqLhrM+33ceW+A2U1ZNbNKfLGJWR
         2SSc+Lg23iD+UvVOO1dUnKnBG/O4pOBssdCDDlytuU0S6vClqesf5j1daFW1FqgQs4Yx
         tB7nn+hCyGq79Vax8SfE5OZuhTGMMKlecd0kluEwQ0Gc3Q3clS5a/2qrk15XHyoyi5P+
         +Sw1OFQjR0odUqauUFqevLhBwx3BVJ3YxHoeRZG6hxU7G1CXRW7uAg+Svr5ofxPi2HDy
         oKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270479; x=1794875279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kv4c8wpatJW0fs+TYedE8BQdpzsR6rNWWBWkGuKgX+Q=;
        b=No+MEhF/rYrNIJSL1/GRVo39oXZCr7fxGh2pG8rUg2NvLN0dLd6oteDOvoLsDFzTOd
         /SxHJ98AmXqX+O2ICy7fJHKb7g6GT4jrIupNDdNPWSQBH8vLT2B2GK+ip6TGyKkGRsxe
         v5SBsMSw74kuwt0yM6Cr0/ULfix1UqA09eZuk1w9UNpK2CUHlwiJ+U4OdXDPloL94kld
         mpoeuh7LuMfFuo2ggG/26lRjyn2+DmUHwYRBzYIJYV6RNFk5zueedH/is1BL+OZu5GXZ
         icfaknfpaGkgdl+bzRzWpCfRO5YyJrnyB9Qjh5xfFoLA9/az0XHveJ5Dfmw40LFX4hXe
         Em4A==
X-Gm-Message-State: APuU4Z8ZKQdARqfcYt6WU4br1/OrXw7DkRjBl9ngdPhdUfzRUqRVFNll
	ndJZrKDNC9a5rMIENwgpmbmsZ4OBPm4F+IkNOixqyByQTLTdmyqSsXhF4P03a3ec
X-Gm-Gg: AYBFou18+CAsdvebtk1WFGj35pMfYcvAcDdR95jmtWQv2jqiT4CPxhJuoBepWwoD7Z+
	BMvhcBdrJZFKaf5EIB96Y053RQ5scmz/aSU8cfhqiZkeXOGQudTAml+IWHH3g6u3djsX0g2Ewth
	FDPw0OJqvqjgQKSPbgXJ2PoRm35d6cORkTyO4J29jvnfNLNOWiC7oN/ii3xzdtnor90W+S2Qhuo
	Q+rpfYCHFgEnyAW1b26i8He1r0Dem2zXvQXM2e9NCipSdbt7NFL97ZAsIN2URnBr38vDLz99l+O
	P0ZbZ3w3vsjLl25Ir61e01AZUn0VaudrfZYRnFj5Lj/b6P4fUto/+gxNRcap2OyGGTivmHl/um9
	Gjl6sJkgTNWFKhAoOIwS41s2qIkfePzGrzCpu8CLOU2Pf6vRSc1mue8uy8V67G24bEOvM/pe58Y
	Cwc8n8rx5ngzg1EgR6FoEnGjgVMLRCHPKTAplvvMsbJLUwviBNfJ8K5rkSjSHpSLDbGF7KB1Fuh
	4e2sz/ecMi3tFGygOaNuQPJ7NOCXWDDIWOfZ6aZNPkZsF6wqN9lDSMbtfKKFgkmNd+0JLiQlPws
	kJQeEfDeQTMVU1+aOXINSgH25sTBAktmBWECtySzZqbE0uvH/S/ZccmmozzRKMOz9WipyreP3PZ
	UhcsTJenDrZ48a9jp70GiwkPOvOZTU9PNVy4OkpVChgALCEMSRzuc6uEcIJvRmSxTUQnc
X-Received: by 2002:a05:6000:1627:b0:48e:5e1f:9a36 with SMTP id ffacd0b85a97d-498308b94efmr1086556f8f.42.1794270479486;
        Mon, 09 Nov 2026 16:27:59 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbbe5sm1981574f8f.42.2026.11.09.16.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:27:58 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/20] bpf: Keep programs that park away from per-CPU state and tail calls
Date: Tue, 10 Nov 2026 01:27:29 +0100
Message-ID: <5b21348bcf56086efa89aae60bd62f4966aac099.1794269506.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8128; i=memxor@gmail.com; h=from:subject:message-id; bh=SS2K/AOFNlDZtg14Lc5oallzFCrfd1FwuwC9FoafX0E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTouuDwJ3RCudfPP1QfE0jmIHh/5FDFxMEGNkP/3Zd7 Z78oP1/RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbi9J3hr6Ro9ov3Sx9O4zI9 6M8dE3W6p3fFiR2qwu+TNX2OWTu4nWVkaJnYza//3yXxE8Mvp30OTJssTK490Az3s5zideFzhsg 0DgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_task_park() lets a program's run end on another CPU than it started
on, and leaves the Tasks Trace RCU read section while it sleeps. Parts
of the BPF runtime rely on neither happening:

 - The stack in arena is taken from the CPU the run starts on and given
   back to the CPU it ends on, see bpf_arena_stack_put(). A run that
   migrates releases the stack of another CPU, which a run there may be
   using, and leaves its own taken.
 - The timed may_goto keeps its count and timestamp per CPU, set when
   the run starts. After a migration the loop reads the slice of another
   run, or one that was never set.
 - A tail call runs its target on the caller's read section, and nothing
   else holds the target. A target that parks leaves that section, so
   deleting it from the prog array frees it under the sleeper. The
   caller's verifier does not see the park either, so the caller keeps
   pointers the sleep may free.
 - kern_sys_bpf() runs a syscall program between
   __bpf_prog_enter_sleepable_recur() and its exit, which count the run
   per CPU. A run that migrates leaves one CPU's count raised for good.

Refuse these combinations until each of them is taught about the park.
The verifier records in prog->aux->may_migrate that a program calls a
kfunc which may migrate, and refuses the call in a program that uses
R12. bpf_do_misc_fixups() refuses to give such a program a timed
may_goto. That includes the one the verifier adds to a loop it cannot
bound, so a loop in such a program needs a bound of its own, as
bpf_repeat() gives it. A prog array refuses the program as a member, and
kern_sys_bpf() refuses to run it.

bpf_task_park() is the only such kfunc so far.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h    |  2 ++
 kernel/bpf/arraymap.c  |  7 ++++++-
 kernel/bpf/fixups.c    |  6 ++++++
 kernel/bpf/syscall.c   |  3 ++-
 kernel/bpf/task_park.c | 20 ++++++++++++--------
 kernel/bpf/verifier.c  | 24 ++++++++++++++++++++++++
 6 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520fd72e21fd..5dec537fe688 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1943,6 +1943,8 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool has_prologue;
 	bool might_sleep;
+	/* a run may leave on another CPU than it started on, see bpf_task_park() */
+	bool may_migrate;
 	bool can_unwind;
 	/* frames of recursive subprogs can be on the stack when it is called */
 	bool in_recursion;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 133f189bf6d2..541f0830cf79 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1028,7 +1028,12 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 	if (IS_ERR(prog))
 		return prog;
 
-	if (prog->type == BPF_PROG_TYPE_EXT ||
+	/*
+	 * A tail call runs the program on the caller's Tasks Trace RCU read
+	 * section alone, and a program that parks leaves that section for its
+	 * sleep, see bpf_task_park().
+	 */
+	if (prog->type == BPF_PROG_TYPE_EXT || prog->aux->may_migrate ||
 	    !bpf_prog_map_compatible(map, prog)) {
 		bpf_prog_put(prog);
 		return ERR_PTR(-EINVAL);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 1d33a78d9373..df5784a132d7 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2862,6 +2862,12 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			u16 live = env->insn_aux_data[i].live_regs_before;
 			int reg, save_off = 0;
 
+			/* The count and the time are kept per cpu, see bpf_timed_may_goto_save(). */
+			if (prog->aux->may_migrate) {
+				verbose(env, "may_goto cannot be used in a program that may migrate, also not in a loop that gets one\n");
+				return -EINVAL;
+			}
+
 			/* a register that is dead here holds the address of the count */
 			for (reg = BPF_REG_0; reg <= BPF_REG_9; reg++)
 				if (!(live & BIT(reg)))
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9004f2673ccf..3f9728686d05 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6661,8 +6661,9 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 
+		/* The run is counted per CPU, which a program that migrates would unbalance. */
 		if (attr->test.ctx_size_in < prog->aux->max_ctx_offset ||
-		    attr->test.ctx_size_in > U16_MAX) {
+		    attr->test.ctx_size_in > U16_MAX || prog->aux->may_migrate) {
 			bpf_prog_put(prog);
 			return -EINVAL;
 		}
diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
index 5a9b3124312e..5043ccdfc0b8 100644
--- a/kernel/bpf/task_park.c
+++ b/kernel/bpf/task_park.c
@@ -194,14 +194,18 @@ __bpf_kfunc int bpf_task_park(u64 timeout_ns, u64 flags)
 	 * program, and with it its maps and context, for the whole
 	 * invocation, so that the program's own memory needs no grace period,
 	 * and where nothing on the run path keeps per-CPU state across the
-	 * program. The verifier confines the call to such contexts: the main
-	 * body of a syscall program and the functions it calls directly, never
-	 * a callback, and never a region that pins the CPU, a lock, a saved
-	 * IRQ state or an RCU read section. It also invalidates every pointer
-	 * the program holds across the call except its stack, its context,
-	 * maps it references directly and the values of its arrays, arena
-	 * memory and verifier-tracked references. What remains is that the
-	 * program may resume on another CPU, which is part of the contract.
+	 * program. A program that keeps such state itself, a stack in arena or
+	 * the time slice of may_goto, is refused the call, and one that calls
+	 * it is kept out of prog arrays, where the caller of a tail call holds
+	 * it through this very read section. The verifier confines the call to
+	 * such contexts: the main body of a syscall program and the functions it
+	 * calls directly, never a callback, and never a region that pins the
+	 * CPU, a lock, a saved IRQ state or an RCU read section. It also
+	 * invalidates every pointer the program holds across the call except its
+	 * stack, its context, maps it references directly and the values of its
+	 * arrays, arena memory and verifier-tracked references. What remains is
+	 * that the program may resume on another CPU, which is part of the
+	 * contract.
 	 */
 	migrate_enable();
 	rcu_read_unlock_trace();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8edc32153226..a1b3ae59a68c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14459,6 +14459,12 @@ static bool is_bpf_task_park_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_task_park];
 }
 
+/* The kfuncs that sleep or wait with migration enabled. */
+static bool is_migrating_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_task_park];
+}
+
 static bool is_bpf_obj_new_kfunc(u32 func_id)
 {
 	return func_id == special_kfunc_list[KF_bpf_obj_new] ||
@@ -16262,6 +16268,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (!in_sleepable_context(env))
 		insn_aux->non_sleepable = true;
 
+	/*
+	 * The kfunc may return on another CPU. What a run takes on the CPU it
+	 * starts on and gives back on the CPU it ends on does not survive that.
+	 * The stack in arena is such a thing, see bpf_arena_stack_put(), and
+	 * the time slice of may_goto, which bpf_do_misc_fixups() refuses. For
+	 * the same reason the program is kept out of prog arrays, where it would
+	 * also run without a reference of its own, and away from runners that
+	 * count a run per CPU.
+	 */
+	if (is_migrating_kfunc(meta.func_id)) {
+		if (env->uses_arena_sp) {
+			verbose(env, "%s() cannot be called in a program that uses R%d\n",
+				func_name, BPF_REG_ARENA_SP);
+			return -EINVAL;
+		}
+		env->prog->aux->may_migrate = true;
+	}
+
 	/* Check the arguments */
 	err = check_func_args(env, &meta, insn_idx);
 	if (err < 0)
-- 
2.53.0

