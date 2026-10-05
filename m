Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9064A2A7D
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210160; cv=none; b=NkQU/36wiBWqWncbiarctVwS9HwnCmpX3iWzSlQrrO2UXmSnS88dXi2Jb08AOqpK5EqJKFIoNzB8ytjsAJMeSKywMpZT8IzZ0MTU0uktOmGOd9wgl09ONKpn+/gGbB56ztAEE/x08oWBs8zCYe5vWXntII77qj590xVZZYhCpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210160; c=relaxed/simple;
	bh=N4XdGhWuHxNHH/DH5/s1/NTOoPGDS5vDWXrFZ1DW+1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c82teaYui0PS/378CJUiuFdb7Kw3gYRSN9NsEXciLBd0//v4UUtuJ42hSyHnlw8PTLLUX/Ue7JfGcqvXbbKC5jrBnwmKBecu4jL5SJbJ/+wA6Yn9oGDb9V+oOiBcTVr4MKWO++XZksW6EWpsFtilisqMQjrQSMJ92jUGbmpnP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK0auxcp; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK0auxcp"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a01ff8c098so12280275e9.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791210151; x=1791814951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OHnqMyBZA28OVgMK+xzMpR+Ee/alSC2HkxUl5T7L3m8=;
        b=dK0auxcpBg7qJMnaNbaBXry+0X/lKFIhJurAJZCU1LJoYAuuyab7TWLPrx7WEsZoJX
         6JxTlA9wrsFlPVzlZiS1WY3iqpgaNYxT1qoEC5w6+3M/6iabXrSQmIkIvcHqtSD/jMzd
         07DajEam8glV4fa1tPTXFid3Oy01BHmBgDDhRwtXfwo0J5DOkvNGU2HiYl/f/mz0Sssh
         cfrfttDyue9oLb1VtYD4LOWIASjJ1how2+pn0wY5HnexDN/hn7rMO7HdR3ZRpGow/poZ
         bUBgi3IGo5lUhkLlKDMlV9sl3i0Vi2DFuqCZvUW4cWJjWEI7JjT473Mzglva1l96WUBo
         utPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791210151; x=1791814951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OHnqMyBZA28OVgMK+xzMpR+Ee/alSC2HkxUl5T7L3m8=;
        b=v9jFs+/FsDxxRTmYcH6auSdiKyIPBzPzjPxJyLKxp1Mzwmqb7raDM0uYZM7Lv3gNun
         g0in/pvE3Omn1AfMmAX0SE240qiiO5stmilUlnouARzdnkzUyIUhvKSvKcGugoshDFCe
         art+pVwK3uRH1H6Ps1fs5fGbT8shGO2xg12a9zixnI3i6Q8uGu6A6XhDFzrYZnjq30Ri
         c0EnijIGqU/xfFnQSfLZ+jQsrwC3PWw0zXWv0GxMls/G0GGTbF71Jx3kxF5gNiaMIXrK
         15W9NpTez3yk0PDEWQ3Yn9mb3WtycZO3wysEXgBeS2dq2i7cU/kIb63jcNYhos3wAbTq
         mWvg==
X-Gm-Message-State: AFuF++mRgdZMm3+ChPcHFZo/a3XHfgct41ULY3GoeIeJBo2ZYqvcRfnr
	6QdQzeI92Igsq6JFcEbEXLUJXb5QjRjJ49T6W1msg/HSCasmn786Regf2hYvW9x+ZEV+1z8t
X-Gm-Gg: AYBFou03Zg2Jzm1ESdLeo5fP/+sn583+I4JWL9wKBuRUTnDH8mfZn20R774pY9xSPNg
	v8Ojec1HGsF8Xw59wgHEUd14GpMLlylBW9VmRE6+YHW/2HRc1JutNnGRCBAyfE4DdHIxNXBjd0i
	VM+vpK9jYiOMFrHSm0ffbUrvgxRLQTV3lwo5ATPRZl147/+wzLYEDfqcM+WICql+zOjLW22CJIe
	X0nBtjci9VJ2f5TFafoWYg/MxBN0RU8fW5Lg0LzX6QnNPcrF+6jaOA0P++f4KptnFGAozSFT5Yk
	bCb9Fxwblpf7EijtRyZCN3HR2E1mx6//mn3JCipciedipp74BVzHgwE1TOxC1WZWKZSbjWt2mJU
	x+taDjCnw+wgsK73CiqexLVVzJgNi9XLVxc/XQH1ar/uYZoqXlL+UVkDfPxkHwgRDj/ZhcMOonQ
	jTawbi8pvXZ6TLB0FYwnuTmYhhWVEFaiBE+xNgbjQ0LsoMcqv+bckKhVZ5luod6RAxZIVIQr2hu
	C/ckfowzNoPpxz8FoD2Vb62RfLZgghKBzPWor+gGmC4H7TdQms4BfOd9wIoAMvvDKOgPIASHEYp
	a3BeRdJzAoXWfTuF7r3spr0mlqWvKIv4Z3p0oQ==
X-Received: by 2002:a05:600c:a00f:b0:4a0:1a18:b742 with SMTP id 5b1f17b1804b1-4a0274e9a97mr189541035e9.2.1791210142474;
        Mon, 05 Oct 2026 07:22:22 -0700 (PDT)
Received: from macbook (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab5a1sm3881623f8f.36.2026.10.05.07.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:22:21 -0700 (PDT)
From: Yusheng Zheng <yunwei356@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Hao Sun <sunhao.th@gmail.com>,
	Yusheng Zheng <yunwei356@gmail.com>
Subject: [RFC PATCH bpf-next 1/7] bpf: Let kfunc sets give kfuncs a BPF body
Date: Mon,  5 Oct 2026 07:22:13 -0700
Message-ID: <20261005142219.33451-2-yunwei356@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20261005142219.33451-1-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let a kfunc set give some of its kfuncs a body: a few BPF instructions
that compute the kfunc from its arguments in R1-R5 into R0. The
following patches make the verifier check each call of such a kfunc as
its body and the JIT inline native code for the call, so that small
kfuncs such as a rotate can be used like instructions while the
verifier knows what they compute.

A kfunc set lists the bodies in .bodies and .body_cnt, next to its BTF
ID set. A body may also have an emit callback that writes native code
for a call, so that the native code of a kfunc comes with the kfunc and
not from the JIT; a following patch makes the x86-64 JIT use it.
Registration checks that each kfunc with a body is in the set and has
no kfunc flags, that it takes each argument and returns its value in
one register, with constant (__k) arguments in 32 bits, and that the
body uses only R0-R5, ALU instructions, loads, stores and forward jumps
that land within it, leaving out the cpu v4 instructions that not every
JIT has. btf_find_kfunc_body() finds the body of a kfunc.

Assisted-by: LLM
Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
---
 include/linux/btf.h |  27 ++++++++++
 kernel/bpf/btf.c    | 126 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4b63bb91550a1..1e7e52e778d82 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -120,10 +120,36 @@ struct bpf_prog;
 
 typedef int (*btf_kfunc_filter_t)(const struct bpf_prog *prog, u32 kfunc_id);
 
+#define BPF_KFUNC_BODY_MAX_INSNS	32
+#define BPF_KFUNC_INLINE_MAX		128
+
+/*
+ * The body of a kfunc: len BPF instructions that compute the kfunc from its
+ * arguments in R1-R5 into R0. The verifier analyzes each call of the kfunc as
+ * the body, and the body runs in place of the call unless the JIT has native
+ * code for it, see kernel/bpf/kfunc_inline.c.
+ *
+ * emit, if set, writes native code for a call to buf, at most
+ * BPF_KFUNC_INLINE_MAX bytes, and returns its length, or an error if it has
+ * no code, for example because the CPU lacks a feature; the JIT then copies
+ * the compiled kfunc. reg[i] is the native register that the verifier bound
+ * Ri to, for R0-R5, and those of R1-R5 that are not arguments are free to
+ * use. imm[i] is the value of Ri if it is a constant (__k) argument. Like the
+ * rest of the JIT, native code is trusted to compute what the body computes.
+ */
+struct bpf_kfunc_body {
+	const u32 *id;
+	const struct bpf_insn *insns;
+	u32 len;
+	int (*emit)(const u8 *reg, const s32 *imm, u8 *buf);
+};
+
 struct btf_kfunc_id_set {
 	struct module *owner;
 	struct btf_id_set8 *set;
 	btf_kfunc_filter_t filter;
+	const struct bpf_kfunc_body *bodies;
+	u32 body_cnt;
 };
 
 struct btf_id_dtor_kfunc {
@@ -604,6 +630,7 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
+const struct bpf_kfunc_body *btf_find_kfunc_body(const struct btf *btf, u32 kfunc_btf_id);
 int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag);
 bool btf_kfunc_is_allowed(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0630675377aaa..4b729d0367bb2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -246,6 +246,14 @@ struct btf_id_dtor_kfunc_tab {
 	struct btf_id_dtor_kfunc dtors[];
 };
 
+struct btf_kfunc_body_tab {
+	u32 cnt;
+	struct {
+		u32 id;
+		const struct bpf_kfunc_body *body;
+	} bodies[];
+};
+
 struct btf_struct_ops_tab {
 	u32 cnt;
 	u32 capacity;
@@ -269,6 +277,7 @@ struct btf {
 	struct rcu_head rcu;
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
+	struct btf_kfunc_body_tab *kfunc_body_tab;
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_struct_ops_tab *struct_ops_tab;
 	struct btf_layout *layout;
@@ -1883,6 +1892,7 @@ static void btf_free(struct btf *btf)
 	btf_free_struct_meta_tab(btf);
 	btf_free_dtor_kfunc_tab(btf);
 	btf_free_kfunc_set_tab(btf);
+	kfree(btf->kfunc_body_tab);
 	btf_free_struct_ops_tab(btf);
 	kvfree(btf->types);
 	kvfree(btf->resolved_sizes);
@@ -9695,6 +9705,118 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 	return btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id);
 }
 
+const struct bpf_kfunc_body *btf_find_kfunc_body(const struct btf *btf, u32 kfunc_btf_id)
+{
+	const struct btf_kfunc_body_tab *tab = btf->kfunc_body_tab;
+	u32 i;
+
+	for (i = 0; tab && i < tab->cnt; i++)
+		if (tab->bodies[i].id == kfunc_btf_id)
+			return tab->bodies[i].body;
+	return NULL;
+}
+
+/* a scalar or a pointer of one register */
+static bool btf_kfunc_reg_type(const struct btf *btf, u32 id)
+{
+	const struct btf_type *t = btf_type_skip_modifiers(btf, id, NULL);
+
+	return btf_type_is_ptr(t) ||
+	       ((btf_type_is_int(t) || btf_is_any_enum(t)) && t->size <= sizeof(u64));
+}
+
+/*
+ * A kfunc with a body takes each argument in one of R1-R5, constant (__k)
+ * ones in 32 bits for native code, and returns in R0. Its body uses R0-R5,
+ * no instruction of cpu v4, which not every JIT has, and jumps only forward
+ * within it, so that it ends by falling through the last instruction. The
+ * verifier checks the rest.
+ */
+static bool btf_check_kfunc_body(const struct btf *btf, const struct btf_type *func,
+				 const struct bpf_kfunc_body *b)
+{
+	const struct btf_type *proto = btf_type_by_id(btf, func->type);
+	const struct btf_param *args = btf_params(proto);
+	int i, n = btf_type_vlen(proto), len = b->len;
+	const struct bpf_insn *insn;
+	u8 op;
+
+	if (n > MAX_BPF_FUNC_REG_ARGS || !b->insns || !len || len > BPF_KFUNC_BODY_MAX_INSNS ||
+	    (proto->type && !btf_kfunc_reg_type(btf, proto->type)))
+		return false;
+	for (i = 0; i < n; i++)
+		if (!btf_kfunc_reg_type(btf, args[i].type) ||
+		    (btf_param_match_suffix(btf, &args[i], "__k") &&
+		     btf_type_skip_modifiers(btf, args[i].type, NULL)->size > sizeof(s32)))
+			return false;
+	for (i = 0; i < len; i++) {
+		insn = &b->insns[i];
+		op = BPF_OP(insn->code);
+		if (insn->dst_reg > BPF_REG_5 || insn->src_reg > BPF_REG_5)
+			return false;
+		switch (BPF_CLASS(insn->code)) {
+		case BPF_ALU:
+		case BPF_ALU64:		/* not movsx, sdiv, smod or bswap */
+			if (insn->off || (BPF_CLASS(insn->code) == BPF_ALU64 && op == BPF_END))
+				return false;
+			break;
+		case BPF_LDX:
+		case BPF_ST:
+		case BPF_STX:		/* not ldsx or atomics */
+			if (BPF_MODE(insn->code) != BPF_MEM)
+				return false;
+			break;
+		case BPF_JMP:
+		case BPF_JMP32:		/* forward jumps within the body, not gotol */
+			if (op == BPF_CALL || op == BPF_EXIT || op == BPF_JCOND ||
+			    (op == BPF_JA && insn->code != (BPF_JMP | BPF_JA)) ||
+			    insn->off < 0 || insn->off >= len - i - 1)
+				return false;
+			break;
+		default:		/* not ld_imm64 */
+			return false;
+		}
+	}
+	return true;
+}
+
+static int btf_add_kfunc_bodies(struct btf *btf, const struct btf_kfunc_id_set *kset)
+{
+	u32 i, id, cnt = btf->kfunc_body_tab ? btf->kfunc_body_tab->cnt : 0;
+	struct btf_kfunc_body_tab *tab;
+	const struct bpf_kfunc_body *b;
+	const struct btf_type *t;
+	u32 *pair;
+
+	if (!kset->body_cnt)
+		return 0;
+	tab = krealloc(btf->kfunc_body_tab, struct_size(tab, bodies, cnt + kset->body_cnt),
+		       GFP_KERNEL | __GFP_NOWARN);
+	if (!tab)
+		return -ENOMEM;
+	tab->cnt = cnt;
+	btf->kfunc_body_tab = tab;
+	for (i = 0; i < kset->body_cnt; i++) {
+		b = &kset->bodies[i];
+		id = btf_relocate_id(btf, *b->id);
+		t = btf_type_by_id(btf, id);
+		pair = btf_id_set8_contains(kset->set, *b->id);
+		/* the body stands for the call, so no kfunc flags apply */
+		if (!pair || pair[1] || !t || !btf_type_is_func(t) ||
+		    !btf_check_kfunc_body(btf, t, b)) {
+			/* a set that fails to register leaves no bodies */
+			tab->cnt = cnt;
+			return -EINVAL;
+		}
+		/* a set registered for several hooks adds its bodies once */
+		if (!btf_find_kfunc_body(btf, id)) {
+			tab->bodies[tab->cnt].id = id;
+			tab->bodies[tab->cnt++].body = b;
+		}
+	}
+	return 0;
+}
+
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 				       const struct btf_kfunc_id_set *kset)
 {
@@ -9714,6 +9836,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 			goto err_out;
 	}
 
+	ret = btf_add_kfunc_bodies(btf, kset);
+	if (ret)
+		goto err_out;
+
 	ret = btf_populate_kfunc_set(btf, hook, kset);
 
 err_out:
-- 
2.51.1

