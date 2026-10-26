Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983839;
	b=QrZfX2QCUoJW3z5OS27l42yhL6vNOgB94oalDFPfcfG2G5O9XurzmsRADZAxBf6m56Uy
	 230ZJK4JyRiTK/ceh3Eq0GPspj2+w8+vZ9shwZGNrjpdrv+TEOlCL6ZhY4D24ok5GAO/Z
	 ID/cEcblV5nYBn20Kb4Jcg60hu0im6CH7TuSBO3/b6MFSMOVo9B6RgaFfYwDwQQjkmGc/
	 zFGNLV/UhckmEtPu5VNi5h7/nTnPWRl/CIe+eT24AXURuSgdsItbwOh13hsNkVv+8GGNC
	 Sh3LiYyssNHVOfbtjfp8sh+9Q1UaZOVUne1/xKDXUSOL60ePOQRfd0nyWk9GKRcM+sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JIYcfXq9jCDKVzYMcdiAOSsAdY+LJOnQEucVZHPRPh8=;
	b=M6fUtLfpOVkOXXmz7Q029wQIs3v5I7g44nSoic/TXsegFCxi9J8qIEAvFCaWopY8jpUR
	 KQYo26QFIZVmrKdPxK30lAwXsCnCvOmk0OEFyoZAYbtJRX6oRdvy2qqlxuz5YEyPToLqg
	 svVIoQDMManDp26UJiOA3rL18+0kwLUTcnt3yk/ZZuwsSpvz7sY/axSJ+PoJQt6rPxYKA
	 aq12/NQpcXhWDdP0IUfO9+z1/zH4BV0fkbKdmXxIK8jd6ww2BBPkL49b82RdKfepQqh9a
	 VVFT1OshnCfOWM8v13t2sRGjP1c37IwMZ1CeHfZ6FkSGxugXYQlhpTrss2Nyxj5Pu3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dqJDCCPG;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979D606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D979D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dqJDCCPG
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1145522a12.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983838; x=1793588638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIYcfXq9jCDKVzYMcdiAOSsAdY+LJOnQEucVZHPRPh8=;
        b=dqJDCCPGyP0xn+iSa1kMXTo37iXwD/m1nRp+3bzLBvdxTHwKn/OU5RbCSCrTA80Wwv
         78ApHXCj5xHR4JIKSP6256IKX/qW87dX1qiWCU0otIdVhcEeM+gC18AM9gtoTAZzFEBh
         AQo/sGFWsTuZrOTVlUgN71CC4cnTPjrKIf8Q9T5xIZFQnbL10/fCnh51B0z067OweXUa
         eph+TAtxfJMte0EQlTry2cLKlm8SaVt8G++4461zI6joXGO6pdqE5YJrReKhCjzcDeNJ
         EmmbwAHGnnxctVWT5A2edYAIPtqQXaGuzuD6ZWAqteDwvx+/lS3t4hI/hTQVwC8pA1yz
         CPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983838; x=1793588638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JIYcfXq9jCDKVzYMcdiAOSsAdY+LJOnQEucVZHPRPh8=;
        b=omeQZZk3SFEUHXykaqCfPkn37LwB+FcX36N5K//1coog9Uch1fzZKU7UETGeLjbsk0
         fQGWDzSaP5BM7WwyOr2JFIKtxnG80T5ZmFUtR/arUiJI9u87XOOTRh15EO/nCaIlL5F5
         OkAcprOXrNCQabMlOEAYjpq7kFx69o6ccqJvWa4MPpwQca6rQHM1PwAloEIHkxGarxQc
         B2JYt2eYDyguxcL0cCthA9c+kiTl700ttt+EqlCWfLv1GEjorKuD7eIILy0p+ChrM4N2
         pYWEiu+tSwD+zL5xTyGoYp5j/qiJ63DWb48SjlRIofFDhPcLWjrtp3LEJRQJw9xGZI3x
         TgVg==
X-Gm-Message-State: AFq9FYI/SGfQdrfn+J9rwd+QrVjNKgSik8kN/hgvOQdeVslLanf0iCCt
	7AHYbMc8OSCDvExtI5euOd3g8qy+LjqM/pfI+gQNCckbt8CD8LjSBG+x9Zgfsg==
X-Gm-Gg: AYBFou1zDrerRfwwCesfZQ9gkmvmqe1CGlB6LZObvbTTve7ugvpdm6m8/mkLG2I3H4P
	cysGlBF+vTL/xD3jyZ2J0zKzJ5D5q4VSNXUZbzO/WSgFpiTAppNysj0qrQmzPhA2lF7q6nHtpNM
	S6Z144YgQsvgZAKBLFDLMvrR2wuMcKK2bL4Pi5Cdg1lnF8va6EV3tfN5fARHXRJ8Cf0ei1H3d5v
	FxApiks1oiSRp2DdRD/QPnPghUtpbBa/LjuTcWV9IzKb0lDrWpyrZpKZ4aQpDlSi5R9XoR3UvQ7
	1Lwx5/N2/YjKVh+2zDEQAVx83o4W6kav/z8hHp6k9ANdUMruQhWxgNgpFzxgUIHzpg1L/eK43UH
	wg51SThR2soCyUkaSqV9s5YJiE5ZZiHHyStLQ4QC+y3GCNi/xxEUwrOtIy55KOM4Hu+2kqhAz1l
	PBiEwqzdvH5yBCwndHGi+LM8yp0uVcYMf1N1+3zr7qEyKr1Nxkvvmq+NNzpWES1EX+uJJd48+P4
	3RHQ4fZVjrbB1gwZOuDPvRKhDNyJnqGOHu4ojcc7rLAjBFT/4oKFk5FPjb3pbem4eHyNuAhTi+v
	wr3iZBeTMrAcOLWk6X2XUXjpooEXddVacoyKPeSFLiaU52GMBK2DH+ibUO/KMA1fpBbZDmTG02p
	1+baDh/zKaf/LwO2sZDjcaYcT
X-Received: by 2002:a17:90b:518d:b0:3a0:c31d:80c with SMTP id 98e67ed59e1d1-3adeb5511cdmr2994205a91.9.1792983838032;
        Sun, 25 Oct 2026 20:03:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae29c7e756sm914974a91.16.2026.10.25.20.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 43/81] bpf: Tell user space that a run of a prog was cut short
Date: Mon, 26 Oct 2026 02:59:04 +0000
Message-ID: <20261026025943.404450-44-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

A run of a prog can end before the prog completes its work:
 - A loop with may_goto runs for more than 250 ms. Then may_goto exits the
   loop.
 - The prog leaves with unwind_exit, for example after a Rust panic, and no
   caller catches it. 'call f; unwind_goto pad' catches it: the caller
   continues at pad when f leaves with unwind_exit.

The hook gets a return value, as after a usual run. No value is correct for
XDP, LSM and sched-ext at the same time. Thus user space must know about
the event and decide what to do.

Add the bit 'unwound' to struct bpf_prog_info. The kernel sets the bit when
a run is cut short, and does not clear it. bpftool prints it. The stderr
stream of the prog has the cause.

  cause                          who reports it
  -----------------------------  ----------------------------------------
  may_goto times out             the function that prints the timeout
  unwind_exit in the main prog   a call that the verifier adds before it
  unwind_exit in an async        the JIT code of unwind_exit, when it
  callback                       finds no unwind_goto after the call

The kernel calls the main prog and the async callbacks. Thus nothing can
catch their unwind_exit. The message for these two causes is new:

  ERROR: The program was unwound

The verifier adds 'r1 = r0; call bpf_prog_report_unwound'. The function
returns its argument. Thus the return value of the prog does not change. An
extension prog gets no call: it unwinds into the caller of the subprog that
it replaces.

Progs without unwind_exit in the main prog get the same code. A run that
leaves with exit does not execute the added insns. A run that unwinds to
the kernel costs about 165 nsec more on x86-64 (Zen 5).

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c  |  2 +-
 arch/x86/net/bpf_jit_comp.c    |  2 +-
 include/linux/bpf.h            |  2 ++
 include/linux/bpf_verifier.h   |  1 +
 include/uapi/linux/bpf.h       |  7 ++++++-
 kernel/bpf/core.c              | 23 +++++++++++++++++++++++
 kernel/bpf/fixups.c            | 27 +++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  1 +
 kernel/bpf/verifier.c          |  3 +++
 tools/bpf/bpftool/prog.c       |  2 ++
 tools/include/uapi/linux/bpf.h |  7 ++++++-
 11 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 58f30911bdab..ea4102af7ead 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1282,7 +1282,7 @@ static long bpf_unwind_fixup(u64 lr)
 	 * The verifier made sure that unwind_goto follows a call in a prog. When
 	 * the kernel called an async callback, it's exit.
 	 */
-	return e ? e->fixup : 0;
+	return e ? e->fixup : bpf_prog_report_unwound(0);
 }
 
 /*
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e417ac4ce749..8b7b330baa61 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2523,7 +2523,7 @@ static u64 bpf_unwind_target(u64 ret_addr)
 	 * The verifier made sure that unwind_goto follows a call in a prog. When
 	 * the kernel called an async callback, it's exit.
 	 */
-	return e ? ret_addr + e->fixup : ret_addr;
+	return e ? ret_addr + e->fixup : bpf_prog_report_unwound(ret_addr);
 }
 
 /*
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3e4c317e0c7a..1b1740d8ca8d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1936,6 +1936,7 @@ struct bpf_prog_aux {
 	bool has_prologue;
 	bool might_sleep;
 	bool can_unwind;
+	bool unwound; /* main prog: see bpf_prog_info */
 	bool kprobe_write_ctx;
 	/* has insns that work with the arena base, see bpf_prog_has_arena_insns() */
 	bool uses_arena_insns;
@@ -3463,6 +3464,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
 void bpf_prog_begin_run(const struct bpf_prog *prog);
+u64 bpf_prog_report_unwound(u64 ret);
 
 static __always_inline u32
 bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 806282c39c57..5c5851cb048c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1417,6 +1417,7 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+int bpf_insert_unwound_reports(struct bpf_verifier_env *env);
 int bpf_split_cur_state(struct bpf_verifier_env *env);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8d7228834305..b0fccdf8c51f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6837,7 +6837,12 @@ struct bpf_prog_info {
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
 	__u32 gpl_compatible:1;
-	__u32 :31; /* alignment pad */
+	/*
+	 * A run of the prog was cut short: it unwound all the way, or a loop or
+	 * a recursion went on for too long. See stderr stream of the prog.
+	 */
+	__u32 unwound:1;
+	__u32 :30; /* alignment pad */
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 21f85c800f0c..bb0aeda9f9cc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3632,6 +3632,7 @@ static noinline void bpf_prog_report_may_goto_violation(void)
 	prog = bpf_prog_find_from_stack();
 	if (!prog)
 		return;
+	WRITE_ONCE(prog->aux->unwound, true);
 	bpf_stream_stage(ss, prog, BPF_STDERR, ({
 		bpf_stream_printk(ss, "ERROR: Timeout detected for may_goto instruction\n");
 		bpf_stream_dump_stack(ss);
@@ -3639,6 +3640,28 @@ static noinline void bpf_prog_report_may_goto_violation(void)
 #endif
 }
 
+/*
+ * Nothing caught the unwinding. The prog or the async callback returns to the kernel.
+ * There is no return value that is right for every hook, so what to do about it is up
+ * to user space. Returns @ret: the caller has its return value there.
+ */
+u64 bpf_prog_report_unwound(u64 ret)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return ret;
+	WRITE_ONCE(prog->aux->unwound, true);
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: The program was unwound\n");
+	}));
+#endif
+	return ret;
+}
+
 /*
  * The kernel is about to call an async callback of @prog on this cpu: a run begins.
  * The main prog does the same in its first insns.
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index c37325af659a..6a591c954c31 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -431,6 +431,33 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
 	return 0;
 }
 
+/*
+ * Say so when the main prog unwinds. JITs make exit of that, see bpf_prog_can_unwind().
+ * It's done after bpf_do_misc_fixups(), that takes a call for a call of a helper.
+ */
+int bpf_insert_unwound_reports(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *new_prog;
+	struct bpf_insn buf[3];
+	int i;
+
+	if (env->prog->type == BPF_PROG_TYPE_EXT)
+		return 0;
+	for (i = 0; i < env->subprog_info[1].start; i++) {
+		if (!bpf_is_unwind_exit(&env->prog->insnsi[i]))
+			continue;
+		buf[0] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
+		buf[1] = BPF_EMIT_CALL(bpf_prog_report_unwound);
+		buf[2] = env->prog->insnsi[i];
+		new_prog = bpf_patch_insn_data(env, i, buf, 3);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = new_prog;
+		i += 2;
+	}
+	return 0;
+}
+
 static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 					      u32 off, u32 cnt)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 60c4d84b9aba..9ba53a3db422 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5188,6 +5188,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.created_by_uid = from_kuid_munged(current_user_ns(),
 					       prog->aux->user->uid);
 	info.gpl_compatible = prog->gpl_compatible;
+	info.unwound = READ_ONCE(prog->aux->unwound);
 
 	memcpy(info.tag, prog->tag, sizeof(prog->tag));
 	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e179514c3b59..f065e7e829c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24348,6 +24348,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret == 0)
 		ret = bpf_do_misc_fixups(env);
 
+	if (ret == 0)
+		ret = bpf_insert_unwound_reports(env);
+
 	if (ret == 0)
 		ret = bpf_insert_arena_stack(env);
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 43599c79c93a..da39d2f0ab2d 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -435,6 +435,7 @@ static void print_prog_header_json(struct bpf_prog_info *info, int fd)
 		     info->tag[4], info->tag[5], info->tag[6], info->tag[7]);
 
 	jsonw_bool_field(json_wtr, "gpl_compatible", info->gpl_compatible);
+	jsonw_bool_field(json_wtr, "unwound", info->unwound);
 	if (info->run_time_ns) {
 		jsonw_uint_field(json_wtr, "run_time_ns", info->run_time_ns);
 		jsonw_uint_field(json_wtr, "run_cnt", info->run_cnt);
@@ -521,6 +522,7 @@ static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
 	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
 	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
 	printf("%s", info->gpl_compatible ? "  gpl" : "");
+	printf("%s", info->unwound ? "  unwound" : "");
 	if (info->run_time_ns)
 		printf(" run_time_ns %llu run_cnt %llu",
 		       info->run_time_ns, info->run_cnt);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8d7228834305..b0fccdf8c51f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6837,7 +6837,12 @@ struct bpf_prog_info {
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
 	__u32 gpl_compatible:1;
-	__u32 :31; /* alignment pad */
+	/*
+	 * A run of the prog was cut short: it unwound all the way, or a loop or
+	 * a recursion went on for too long. See stderr stream of the prog.
+	 */
+	__u32 unwound:1;
+	__u32 :30; /* alignment pad */
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;
-- 
2.55.0

