Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022738;
	b=eSr3n74psZh/Ca8YURJd6VWAQNQ7WCroYk2tHx8GgR7aYJSq9C2yrcHzKSms0+BC0xuG
	 IArUGFA5l/AC7XjWxYjgBLQuP0TAWXi0n5g33JHVdIOqTdfCz9stFkGLrHVhtyLPVkhNk
	 8bdZfRhWVP2f96zBWFoSr9aty0FAwn0Z4Tzo8E+IeFbcKwObtolldsmPa0RnNg4L3/jiN
	 Py12pjN4YbVVCEJ0JgXsVnKAhunK/GyM6xMzGzMLaqqZQMMEtaWslAOglKF9jsuvwUrfW
	 JFm3dLikPmCS37/S+6c5kQaCQ8d755JpzbGrNUg2NJo6dSoNySkvhz8uMD1jSaKV2+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1ZU5TFKeipuegA5YJTongx5/zxyIHuMwJeq8d1Sew9U=;
	b=UXf/l/9OZ53bHGD7TAJlf2fJznINlelIbzWjJD1OBmkSAOzYXEGoxwd485WX/q5mQ8ub
	 vCSDAXnHpclk3r0GLbb6lNspwGgDXFPIeRQzpKD3/gmyq6p2NqvrAdBwcvnd1+Yu+YG8Y
	 uGNhoN08RFUlxp6n24IhXH3zNHoTHS5R+dUUkXuC3MbTTIX18BEfdgDi3aaa2nv/BGOPb
	 634Uh0GsAepf5I7e4XLWG4O9qwILZx6lcU+bMuCPi+qDTbMo00FTzaPe/EXKO9m/3mN/w
	 ZbbvJvIHsQQMb4ImPVfo4jWI4n7WFZ47wKkrT4Aq0O3DUpozJ021A3iBURwGXuSNDHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ETKSUEM5;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DA606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ETKSUEM5
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso652114a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022738; x=1794627538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ZU5TFKeipuegA5YJTongx5/zxyIHuMwJeq8d1Sew9U=;
        b=ETKSUEM5sOUO7LW8zUyU48tnj4BayeUbeBs1rO2Y650aT/CvG3Z3p4cj1Q8WqoLrlY
         P4Aob+nhMwIw0Dj/22NS4Nm0pwWcCrybJYnpvbQfBYK+BSyB9qb5jjfno1n7AuolpuyM
         DXjCp8SGchOiraLFcu1K7k8pycpodOM+rxKzewo7Ip/Xd/76/v6cp7DjTzlMIHlSpzWy
         31p20fdGpOXGMzepGE3vXBH7TnAU5MaF7vaoKdXBzWsyVSVmSFJqfH1YI1qylXvNfEWP
         eOes5AeQrmbgQuRSsYlquZRydw9TR1Yt3xC2lAMq0CMah8B/4vs38fwWTcVDOolSXHoW
         FYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022738; x=1794627538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ZU5TFKeipuegA5YJTongx5/zxyIHuMwJeq8d1Sew9U=;
        b=vh2AxE3vmrd8zDO+N72OCGs0IazzZuh7LAOW2ENwE75paLWxmz7RnhE/PdjheZ66qV
         kiurycEGy1mCu+SAR+xf6Yrdwy6EisH7jWH5Y+fk5bCIpLiFfbmV6Gdpx8b6QRJDKUP6
         C0f6yHh3JxZ4tWeplTwzi+lkJ30S96YFGjeS6YiaffOLZM3XZQs9UbwTfpbd6zWQINyr
         dTBBxqgfWDeud8OTt1wdcPei6ANcBLXaiwylxPNRrpjNKoAjgBm4HZbfEmz4bG1flxm1
         RYWvZ14ZOVND/ZETp6LLIL3Zs/HvVVZ+Q3ZQg8mDr6khuWRwj9ReDwhrVWpMtMjCHljn
         Codw==
X-Gm-Message-State: APuU4Z/bI2sr7rjvvAteX64xljUSkzMkagPSN9uKPEU4yuGpWi3VHeEt
	8sq1sJip9sHP6fCzbh08V0g48hPRLHmjINRY7WH63rXDmJ4hXB07FF8OrBjitQ==
X-Gm-Gg: AYBFou330ROsU2/5bIBb2nxbLTJYx3pnyIoTi8nZRfJakmKgOGivM/vKaU+kSwfjvgC
	kOzRhV9OKGMVhoMo+figIoQzmFrwMMJ997+Yoa8rhGZHOXF2yXNTsZPmae4DzGt0oCG+kBOn7ox
	pMNSqIhOzSDBuZPOL2NAMIc5UMppzgeTCbW7DabaOC4keqDYc6ceeADL1878mCjoXCYSTWDHcvx
	i2U9+RD1ScWXIG808/8DgIIM8K+JlcrMHyjvhRI9XJ9em628XZaeWuMZjSJ0XY2M0IC9/MnN9w/
	u5MM/oCP2J6f/FAAFGfpltQRJrzk6zuA/I+Dw73h8KwF3mgrX+lWEKQFXc1aG29PX+FpDMIp2m9
	IK+TkaRSXVY5IhPTECvawbtikZRLDe2wLXsg7iMHvbWkfQ7mRhHUCxfx3BQHDTGd4vtLiZhxt+L
	BJjznv81hB186oBBvhINmKpnt+vPmx+vPJ89mP2XLpdQ2mFxihfEuoUb2nuUZatpylUlARHy+1o
	yvDq52cJxV1ME3WbQfTL99876h1hzpTRR9+OTXFFtGRoeKrPFB4ry2Jtn6p2j3MHd7nT11l58Q8
	hgz5N7sCNbkTbeKEk3Ojj9may45C5zdfSOiGgSAiOryr7vun97vraqn2vol0OA6goa6CxT7BZa2
	3fci927bu6p06fDFD8HxOJahaSdAXCHhK6nANihwJgH/Ky2m1UHYcNE30E6313ip/BVX+Othymw
	==
X-Received: by 2002:a17:90b:4a12:b0:3a7:db88:3491 with SMTP id 98e67ed59e1d1-3b0db6e9b3dmr4490075a91.33.1794022737400;
        Fri, 06 Nov 2026 19:38:57 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc27e829sm1262513a91.0.2026.11.06.19.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:38:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 09/46] bpf: Find the registers that hold a number or a pointer to arena
Date: Sat,  7 Nov 2026 03:37:17 +0000
Message-ID: <20261107033758.1547725-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

The allocator of tools/sched_ext/scx_sdt.bpf.c looks for a free slot:

  if ((word & 0xffffffff) == 0) { num += 32; word >>= 32; }
  if ((word & 0xffff) == 0) { num += 16; word >>= 16; }
  ...                                         six times, this is ffs()
  return (i * 64) + ffs(freeslots);

The main pass joins the two states behind each 'if': num is [0, 32], then
[0, 48]. It must not join two constants that the prog adds to a pointer to
the packet, the context or a kernel object: these need the exact offset.
The states meet before the add, and there the add is only 'r0 += r3'. If r0
can be such a pointer, num stays a constant and each 'if' doubles the
states: up to 256 at an insn, not 2. sdt_init_task: 4897 insns, not 666.

bpf_flow_compute_kinds() goes forward through the control flow graph,
before the main pass. It finds the registers, stack slots and stack
arguments that hold, on each path to an insn:
 - plain_regs: a scalar, or a pointer to arena: it may point anywhere,
 - value_regs: that, or a pointer to a map value that has only scalars and
   is not read-only: only the lowest and the highest offset count,
 - the context: a load through it can give a pointer to the packet.

  ALU op other than 64-bit add, sub, mov     scalar, addr_space_cast too
  64-bit add, sub                            what both operands are
  load through a scalar or a map value       scalar
  load through ctx, or of less than 8 bytes  is_valid_access() tells
  spill and fill through r10, r11            what the prog stored
  helper, kfunc                              from the prototype
  static subprog                             true at all calls, all exits
  global subprog, callback, target of callx  only the context

test_cls_redirect.c has the context in a struct. In a subprog c->skb comes
from the stack of the caller: nothing is known about it.
  data = c->skb->data; if (data + (v6 ? 40 : 20) > end) return 0;
So 4 bytes at the offset of data can be a pointer. Else 20 and 40 are
joined: "invalid access to packet". loads_pkt_end notes a subprog that
loads data_end, for the main pass. void * from a kfunc is a scalar, but not
with KF_RET_NULL and not from bpf_rdonly_cast(), bpf_cast_to_kern_ctx().
  p = bpf_core_cast(t, struct task_struct); x = z ? p->pid : p->tgid;
is one 'r0 += r1' with 1856 or 1860. Joined:
"invalid variable offset access into struct task_struct".

The result only selects the states that the main pass does not join:
a mistake rejects a valid prog or makes more states. No unsafe prog loads.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/flow.c            | 314 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   7 +
 3 files changed, 324 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 332701cdf3ee..700f5bb41f83 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1100,6 +1100,8 @@ struct bpf_subprog_info {
 	 * a hidden pointer to the result, a pair in two registers, no dead arguments.
 	 */
 	bool stack_args_from_code: 1;
+	/* it loads the end of the packet from the context */
+	bool loads_pkt_end: 1;
 	/* it can leave with unwind_exit: it has one, or unwind_goto follows every call of it */
 	bool bail_unwinds: 1;
 	u8 code_stack_args;
@@ -2113,6 +2115,7 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_SLEEPABLE;
 }
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
+bool bpf_is_cast_kfunc(const struct bpf_call_arg_meta *meta);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
 bool bpf_insn_is_cond_jump(u8 code);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 0f5acdf1cb94..f039cc949854 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -514,3 +514,317 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 	kvfree(seen);
 	return ret;
 }
+
+/*
+ * The places of a function that hold a value: the registers, the arguments on the stack that it
+ * got and those that it hands over, the slots of the stack that struct flow_need has a bit for.
+ */
+enum {
+	FLOW_ARG_IN	= 16,
+	FLOW_ARG_OUT	= FLOW_ARG_IN + MAX_STACK_ARG_SLOTS,
+	FLOW_SLOT	= 64,
+	FLOW_PLACES	= 128,
+};
+static_assert(FLOW_ARG_OUT + MAX_STACK_ARG_SLOTS <= FLOW_SLOT);
+
+enum flow_kind {
+	FLOW_IS_PLAIN,	/* a number or a pointer to arena: nothing checks where it points to */
+	FLOW_IS_VALUE,	/* that, or a pointer to a map value that holds nothing but numbers */
+	FLOW_IS_CTX,	/* the context, as the prog or a global function got it */
+	FLOW_KINDS,
+	FLOW_IS_OTHER = FLOW_KINDS,
+};
+
+/* What the places hold for sure in front of an insn */
+struct flow_kinds {
+	unsigned long is[FLOW_KINDS][BITS_TO_LONGS(FLOW_PLACES)];
+};
+
+static void flow_kind_set(struct flow_kinds *k, u32 place, enum flow_kind kind)
+{
+	int i;
+
+	for (i = 0; i < FLOW_KINDS; i++)
+		__assign_bit(place, k->is[i], i == kind);
+	if (kind == FLOW_IS_PLAIN)
+		__set_bit(place, k->is[FLOW_IS_VALUE]);
+}
+
+static void flow_kind_copy(struct flow_kinds *to, u32 place, const struct flow_kinds *from,
+			   u32 from_place)
+{
+	int i;
+
+	for (i = 0; i < FLOW_KINDS; i++)
+		__assign_bit(place, to->is[i], test_bit(from_place, from->is[i]));
+}
+
+/* What holds on both ways to an insn. Returns true if that is less than before. */
+static bool flow_kinds_meet(struct flow_kinds *to, const struct flow_kinds *from)
+{
+	unsigned long lost = 0;
+	int i, j;
+
+	for (i = 0; i < FLOW_KINDS; i++) {
+		for (j = 0; j < ARRAY_SIZE(to->is[i]); j++) {
+			lost |= to->is[i][j] & ~from->is[i][j];
+			to->is[i][j] &= from->is[i][j];
+		}
+	}
+	return lost;
+}
+
+/* The first insn of a function that is called from @k */
+static bool flow_kinds_enter(struct flow_kinds *to, const struct flow_kinds *k)
+{
+	struct flow_kinds e = {};
+	int i;
+
+	/* r12 points to arena. The rest is not set. */
+	bitmap_fill(e.is[FLOW_IS_PLAIN], FLOW_PLACES);
+	bitmap_fill(e.is[FLOW_IS_VALUE], FLOW_PLACES);
+	flow_kind_set(&e, BPF_REG_FP, FLOW_IS_OTHER);
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+		flow_kind_copy(&e, i, k, i);
+	for (i = 0; i < MAX_STACK_ARG_SLOTS; i++)
+		flow_kind_copy(&e, FLOW_ARG_IN + i, k, FLOW_ARG_OUT + i);
+	return flow_kinds_meet(to, &e);
+}
+
+/* The place that @insn loads from or stores to through r10 or r11, -1 if it's something else */
+static int flow_mem_place(const struct bpf_insn *insn, u8 base)
+{
+	int n = (abs(insn->off) - 1) / BPF_REG_SIZE;
+
+	if (!insn->off)
+		return -1;
+	if (base == BPF_REG_FP && insn->off < 0 && n < 64)
+		return FLOW_SLOT + n;
+	if (base == BPF_REG_PARAMS && n < MAX_STACK_ARG_SLOTS)
+		return (insn->off < 0 ? FLOW_ARG_OUT : FLOW_ARG_IN) + n;
+	return -1;
+}
+
+static enum flow_kind flow_map_value_kind(const struct bpf_map *map)
+{
+	if (map->map_type == BPF_MAP_TYPE_ARENA)
+		return FLOW_IS_PLAIN;
+	/* what is at a known offset of a read-only map is known: a number, a string, a function */
+	if (map->map_flags & BPF_F_RDONLY_PROG)
+		return FLOW_IS_OTHER;
+	return IS_ERR_OR_NULL(map->record) && !map->inner_map_meta ? FLOW_IS_VALUE : FLOW_IS_OTHER;
+}
+
+/* What @insn loads through the register @base */
+static enum flow_kind flow_loaded_kind(struct bpf_verifier_env *env, const struct flow_kinds *k,
+				       const struct bpf_insn *insn, u8 base)
+{
+	struct bpf_insn_access_aux info = { .reg_type = SCALAR_VALUE };
+	int size = bpf_size_to_bytes(BPF_SIZE(insn->code));
+	bool tstamp = env->prog->tstamp_type_access, valid;
+
+	/* a number that is good for a load is an address in arena */
+	if (test_bit(base, k->is[FLOW_IS_VALUE]))
+		return FLOW_IS_PLAIN;
+	if (size == BPF_REG_SIZE && !test_bit(base, k->is[FLOW_IS_CTX]))
+		return FLOW_IS_OTHER;
+	valid = env->ops->is_valid_access &&
+		env->ops->is_valid_access(insn->off, size, BPF_READ, env->prog, &info);
+	/* it notes what the prog reads, and this is a question */
+	env->prog->tstamp_type_access = tstamp;
+	if (valid && info.reg_type == PTR_TO_PACKET_END)
+		bpf_find_containing_subprog(env, insn - env->prog->insnsi)->loads_pkt_end = true;
+	/*
+	 * Only the context has pointers that are shorter than a register. A base that nothing is
+	 * known about can be the context: it came out of a struct, or only some paths have it.
+	 */
+	if (size < BPF_REG_SIZE)
+		return valid && info.reg_type != SCALAR_VALUE ? FLOW_IS_OTHER : FLOW_IS_PLAIN;
+	return valid && info.reg_type == SCALAR_VALUE ? FLOW_IS_PLAIN : FLOW_IS_OTHER;
+}
+
+/* What a helper or a kfunc returns */
+static enum flow_kind flow_returned_kind(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	const struct bpf_func_proto *fn;
+	struct bpf_call_arg_meta meta;
+	const struct btf_type *t;
+
+	if (bpf_pseudo_kfunc_call(insn)) {
+		if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
+			return FLOW_IS_OTHER;
+		t = btf_type_skip_modifiers(meta.btf, meta.func_proto->type, NULL);
+		if (!btf_type_is_ptr(t))
+			return FLOW_IS_PLAIN;
+		/* void * is a number, unless the verifier knows the kfunc: it may fail, or casts */
+		t = btf_type_skip_modifiers(meta.btf, t->type, NULL);
+		return btf_type_is_void(t) && !(meta.kfunc_flags & KF_RET_NULL) &&
+		       !bpf_is_cast_kfunc(&meta) ? FLOW_IS_PLAIN : FLOW_IS_OTHER;
+	}
+	if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
+		return FLOW_IS_OTHER;
+	if (fn->ret_type == RET_INTEGER || fn->ret_type == RET_VOID)
+		return FLOW_IS_PLAIN;
+	if (base_type(fn->ret_type) == RET_PTR_TO_MAP_VALUE &&
+	    (aux->const_reg_map_mask & BIT(BPF_REG_1)))
+		return flow_map_value_kind(env->used_maps[aux->const_reg_vals[BPF_REG_1]]);
+	return FLOW_IS_OTHER;
+}
+
+/*
+ * @k is what holds in front of the insn at @idx. Make it what holds behind it.
+ * @ret: the registers that are FLOW_IS_PLAIN at all exits of a subprog.
+ * Returns true if less is known than before at the entry or about the exits of a subprog.
+ */
+static bool flow_kinds_step(struct bpf_verifier_env *env, struct flow_kinds *kinds, u16 *ret,
+			    struct flow_kinds *k, int idx)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+	u8 dst = insn->dst_reg, src = insn->src_reg;
+	bool wide = BPF_SIZE(insn->code) == BPF_DW && BPF_MODE(insn->code) == BPF_MEM &&
+		    !(insn->off % BPF_REG_SIZE);
+	bool lost = false;
+	u16 regs = U16_MAX;
+	int i, s;
+
+	if (class == BPF_ALU64 && (op == BPF_ADD || op == BPF_SUB)) {
+		__clear_bit(dst, k->is[FLOW_IS_CTX]);
+		for (i = 0; BPF_SRC(insn->code) == BPF_X && i < FLOW_IS_CTX; i++)
+			if (!test_bit(src, k->is[i]))
+				__clear_bit(dst, k->is[i]);
+	} else if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && !insn->off) {
+		flow_kind_copy(k, dst, k, src);
+	} else if (class == BPF_ALU || class == BPF_ALU64) {
+		/*
+		 * addr_space_cast too. It leaves a pointer that is not in arena as it is, and
+		 * a compiler casts what it cannot know. Nearly all of that is in arena.
+		 */
+		flow_kind_set(k, dst, FLOW_IS_PLAIN);
+	} else if (class == BPF_LDX) {
+		s = flow_mem_place(insn, src);
+		if (wide && s >= 0)
+			flow_kind_copy(k, dst, k, s);
+		else
+			flow_kind_set(k, dst, flow_loaded_kind(env, k, insn, src));
+	} else if (class == BPF_STX || class == BPF_ST) {
+		i = bpf_atomic_load_reg(insn);
+		if (i >= 0)
+			flow_kind_set(k, i, flow_loaded_kind(env, k, insn,
+						insn->imm == BPF_LOAD_ACQ ? src : dst));
+		s = flow_mem_place(insn, dst);
+		if (class == BPF_STX && wide && s >= 0)
+			flow_kind_copy(k, s, k, src);
+		else if (s >= 0)
+			flow_kind_set(k, s, FLOW_IS_PLAIN);
+	} else if (bpf_is_ldimm64(insn)) {
+		if (src == BPF_PSEUDO_MAP_VALUE || src == BPF_PSEUDO_MAP_IDX_VALUE)
+			flow_kind_set(k, dst, flow_map_value_kind(
+					env->used_maps[env->insn_aux_data[idx].map_index]));
+		else
+			flow_kind_set(k, dst, src ? FLOW_IS_OTHER : FLOW_IS_PLAIN);
+	} else if (insn->code == (BPF_JMP | BPF_EXIT) && !bpf_is_unwind_exit(insn)) {
+		s = bpf_find_containing_subprog(env, idx) - sub;
+		lost = ret[s] & ~k->is[FLOW_IS_PLAIN][0];
+		ret[s] &= k->is[FLOW_IS_PLAIN][0];
+	} else if (class == BPF_LD || (class == BPF_JMP && op == BPF_CALL)) {
+		s = bpf_pseudo_call(insn) ? bpf_find_subprog(env, idx + insn->imm + 1) : -1;
+		if (s >= 0 && !bpf_subprog_is_global(env, s)) {
+			lost = flow_kinds_enter(&kinds[sub[s].start], k);
+			regs = ret[s];
+		} else if (bpf_is_callx(insn)) {
+			regs = 0;
+		}
+		/* a subprog may return a pair in R0 and R2, the rest is not set */
+		regs |= ~(BIT(BPF_REG_0) | BIT(BPF_REG_2));
+		for (i = BPF_REG_0; i <= BPF_REG_5; i++)
+			flow_kind_set(k, i, regs & BIT(i) ? FLOW_IS_PLAIN : FLOW_IS_OTHER);
+		for (i = 0; i < MAX_STACK_ARG_SLOTS; i++)
+			flow_kind_set(k, FLOW_ARG_OUT + i, FLOW_IS_PLAIN);
+		if (bpf_helper_call(insn) || bpf_pseudo_kfunc_call(insn))
+			flow_kind_set(k, BPF_REG_0, flow_returned_kind(env, idx));
+	}
+	return lost;
+}
+
+/*
+ * Find the registers that hold a number or a pointer to arena, and those that point to the value
+ * of a map that holds nothing but numbers at worst, whichever way the prog gets to an insn:
+ * plain_regs and value_regs of struct bpf_insn_aux_data. The others may hold any pointer.
+ *
+ * Forwards, from "all is known" down, until nothing changes. Arguments go from the callers to
+ * the callees and results the other way, so the subprogs are looked at in both orders in turn.
+ *
+ * Nothing depends on it but which states are kept apart. A pointer that is taken for
+ * a number costs a rule. A number that is taken for a pointer costs states. So it's fine to
+ * miss a store through a pointer to the stack, and to take what callx calls for unknown.
+ *
+ * The edges that the verifier adds, see bpf_head_guard_target(): may_goto at the head of a loop
+ * takes what holds there to its target. A subprog that is out of budget goes to an exit with 0
+ * in place of the result, a number.
+ */
+int bpf_flow_compute_kinds(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	int len = env->prog->len, cnt = env->subprog_cnt, i, j, n, s, t, idx, err = 0;
+	struct flow_kinds *kinds, k = {};
+	struct bpf_iarray *succ;
+	bool lost = true;
+	u16 *ret;
+
+	kinds = kvmalloc_array(len, sizeof(*kinds), GFP_KERNEL_ACCOUNT);
+	ret = kvmalloc_array(env->subprog_cnt, sizeof(*ret), GFP_KERNEL_ACCOUNT);
+	if (!kinds || !ret) {
+		kvfree(kinds);
+		kvfree(ret);
+		return -ENOMEM;
+	}
+	memset(kinds, 0xff, len * sizeof(*kinds));
+	memset(ret, 0xff, env->subprog_cnt * sizeof(*ret));
+
+	/* what the kernel, a helper, callx or another prog calls: only the context is known */
+	for (s = 0; s < env->subprog_cnt; s++) {
+		if (s && !bpf_subprog_is_global(env, s) && !sub[s].addr_taken)
+			continue;
+		flow_kinds_enter(&kinds[sub[s].start], &k);
+		for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
+			if (sub[s].args[i].arg_type == ARG_PTR_TO_CTX ||
+			    (!s && !i && env->prog->type != BPF_PROG_TYPE_EXT))
+				flow_kind_set(&kinds[sub[s].start], BPF_REG_1 + i, FLOW_IS_CTX);
+	}
+
+	for (n = 0; lost; n++) {
+		lost = false;
+		/* a chain of calls takes a round for each link */
+		if (signal_pending(current)) {
+			err = -EAGAIN;
+			break;
+		}
+		cond_resched();
+		for (j = 0; j < cnt; j++) {
+			/* it has callees first */
+			s = env->subprog_topo_order[n & 1 ? j : cnt - 1 - j];
+			for (i = sub[s + 1].postorder_start; i-- > sub[s].postorder_start;) {
+				idx = env->cfg.insn_postorder[i];
+				k = kinds[idx];
+				lost |= flow_kinds_step(env, kinds, ret, &k, idx);
+				succ = bpf_insn_successors(env, idx);
+				iarray_for_each(t, succ)
+					lost |= flow_kinds_meet(&kinds[t], &k);
+				t = bpf_head_guard_target(env, idx);
+				if (t >= 0)
+					lost |= flow_kinds_meet(&kinds[t], &kinds[idx]);
+			}
+		}
+	}
+	for (i = 0; i < len; i++) {
+		env->insn_aux_data[i].plain_regs = kinds[i].is[FLOW_IS_PLAIN][0];
+		env->insn_aux_data[i].value_regs = kinds[i].is[FLOW_IS_VALUE][0];
+	}
+	kvfree(kinds);
+	kvfree(ret);
+	return err;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ea6dd39982f2..d42c67d6d70b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14110,6 +14110,13 @@ static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta)
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx]);
 }
 
+/* void * in the prototype. What it returns points to an object of the kernel. */
+bool bpf_is_cast_kfunc(const struct bpf_call_arg_meta *meta)
+{
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx]) ||
+	       is_kfunc_call(meta, special_kfunc_list[KF_bpf_rdonly_cast]);
+}
+
 static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *meta)
 {
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_clone]);
-- 
2.55.0

