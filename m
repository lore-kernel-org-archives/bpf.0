Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207949;
	b=tlPOcKUd+vBy76NICP95h4POMgB+U+Jzm0gCl9h99CeBXB0sjcFK1l2fjU1CgDwDp2D/
	 0mEhebCLEcrEGLeGTFCiqs5j/hF2oEmm6h91Jdp0BLA/Edj0en/ZB6dAB0pXkEOv3Sbd/
	 oMUUBnbnGkM98m9qGtp/0J07t1G5aE1yuxLwhSPoazqYWnvOk5JHaLzfN8r1oSWoO+uql
	 UgHDyhb9Y4W6TuT2XxhPLs3uYsxSGLSTj/19nC+hlyZFE5/T/FtFX2inRS1TBmNwOeeha
	 2WKlrKS7qxq5GH09WUo4CeafFO4EMI5GJouEMx36HFyH1ctAWs74Kdq0JtYxIXeH2Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I2OqgYKdNmQyK3w2Hqd64UEV+xK7HmZrtJ5GRhdwdOc=;
	b=D3TqlvZ8P+1fXlEcw8fEzP9TsqluVBjuxsNP9rAh0nIfLH/Ck5RSXSALTE8a7RBwF3/h
	 u0x+h9Iy+OLFB9jb1mHqrndhYzbI0JlnFdrhWHyE85SoCYycQF81uLIj8o0CzCGDwn9Q3
	 7yTsKJqfhtfcmM+xe+P63pEDVfgf3/PVx2C0TjOE/VDCS4Z0OUvl7wQNxxcPds0PCCXqh
	 FTgYpW+Z/vgx/PIRrjtn4jOPoGGxtWlp6SyA23mUJ3eQqMYAJ6sw0tiq41VYwgjSVH1dv
	 lEXVW9Vx/zPaAEbMGXMZqGU3r6O+sTeBbGZPEmhg1HCvD4Ehrj/i3eNkeMePxFPH4KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eI8xP8fY;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD9606A333
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDAD9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eI8xP8fY
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so1141205b3a.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207945; x=1795812745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2OqgYKdNmQyK3w2Hqd64UEV+xK7HmZrtJ5GRhdwdOc=;
        b=eI8xP8fYljmwbufuDgh9BvJQhCilQUw7BQe+2ANPHdZ6zgLNlBdjA+h0W9RZAZClVq
         beHntAyWsmsJ9aacOcxnjqBP12FGKeA96qR+vKptkEvD8SGqP2/Fi2wSeFVi2sbkTwy7
         H0YSzeCd5nHIsYO6P0aoDz3TpLgpEw+KvUzu30ufAH7apiMvvyOrPDEv1ZgdjVwzEqkY
         C0fbTkWhDmkv+MWbnmBClilqKvspSvKX7PmrAzXTO0AtLG8Zwp9H9/bRYArAk4DorOWC
         VNbZD+SSKVLIHNjnUkti0znoXxK5Qh0iAeubMe4PEJjGIYi+GCd47uvnoziN9BGFYKjF
         TkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207945; x=1795812745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2OqgYKdNmQyK3w2Hqd64UEV+xK7HmZrtJ5GRhdwdOc=;
        b=aXbNvvO4FQEqtkMKzFgf/viGSZ0YnNP8GHRWYKhC/KedJ9zRz5oAXE8mZf+Fl/FTsc
         3AzGpVv4sASgwfTuPtw0nllXqh1ufF+hXAsJg1ANXmW4bbT1qzYGYj2O209F2O4UkQxF
         iGP7rPuslNNQMA/XJmR9IZ+gXGq7lYLZFL+zNRE7/PW6yLVmNBXSAgEA7+lWjPReUfVz
         vv99uY91imy9hJW6fpIC8tN5j0wH19INlxiPljVmdHWl5QmYCSxi4KKYPr5BuDpA0/sN
         xRxYQWc5UQDirjhueuV2gGVrriqFlurFBZ74BmKAStqHWd1ku91T7zmgx0R8zd6MHbRC
         B6kA==
X-Gm-Message-State: APuU4Z+A8ZXB3OnW/UYWVvPxkaECgC9rplNDdD/sKW06H3B6P8EOqIXC
	ItXqvYBjDBNMdXfPDh4DCXpdON7EVJBDemr4+ux465rrNTkI7GTe0lANChH+yg==
X-Gm-Gg: AZFdTZd3ByNc9kFAtFkkba0tMRBrwwF3itVUhOm6NXdbtOIGYqOPCXgC9raOr4UxGiq
	k97j4NAINhQ8gvC9gK+QdHCsEFDu1Chn7xf/DYMnE3bgz6cmW+T/XCwqfvBa/pMF8KExuAsztZN
	S77+Ezjr8ZgZNyAgxKdxnkZWNaB6IMH/YhrKNX4kFpd8xPt1WSKoN+/8utlF2yHmmdQacDRhSIq
	gJhfRgwfQ93njhVEyK/m277ymUpoKENRahxWfDixwEjQVtQYiDZjPBLANTQNef5Rz6g94MBbQME
	mJHVcAvZwXu9ueoxWe1fAYowF6ZwNSQHIhKASboj+6Tk7QGbEqXIuc78DsC1e1VMhZED0Yc8czj
	rvlKLOSrImh33K7x52W/450XzP5hrD55lL9oPr9xmcUQxP7w5BmMMEtTuDGDLsUEdtWzaE31gL3
	fnGkA91vZ72ASt7P3CwOj2eAjYpAH8zM/CB/xI3AsH/Hn4y22aV+TyZyOzzMmPBQrsJmjiKr7iA
	uJmvpcp2vX8+ZzLwwgfVRpNIzF0PZkuStMY9qBS1h/xfMG02wN8pGj1WKtjDF5W9I8ktxA+OZS7
	QuQRYWSb5PPJNEB0bocAGGVPM5LJB8UXFUyWbVymmOYAZixBCODS1BtQ0A7bvail9aUVw92QV80
	HVIvVHeVOGxcPZieHPVl8jPkJD4cqhwUGX3oAWgTJ9S8v/he5va2X/i6Xwm8uLBMINE7DOntYAg
	==
X-Received: by 2002:a05:6a00:4b14:b0:8a7:917:4388 with SMTP id d2e1a72fcca58-8c87b4efb71mr4393592b3a.19.1795207944909;
        Fri, 20 Nov 2026 12:52:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285b60csm2013047b3a.9.2026.11.20.12.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:52:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 24/49] bpf: Keep two states apart if data and control deps differ
Date: Fri, 20 Nov 2026 20:49:32 +0000
Message-ID: <20261120204959.614908-25-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

Two states meet at a join point. The join does harm if it makes a pair
of values that no path has, and the unproven insn depends on the pair:

                r6 (data)    r7 (control)
   ok_state     0..7         0
   err_state    8..max       -22
   join         0..max       -22..0     has r6 = 8 with r7 = 0

One rule decides at all join points, bpf_must_keep_apart():

  what differs               action
  data dep and control dep   keep apart
  two data deps              keep apart
  one data dep, with a gap   keep apart   (0..1 and 100)
  one data dep, no gap       join         (0..7 and 8..9)
  control deps only          join
  other regs only            join

In pass 0 the masks are empty, so all states are joined.

At the header of a loop only a type or an object keeps states apart,
else the loop has no end. If the join is imprecise, the loop is a
suspect, also if the other state entered the loop at another time.
At the first insn of a function a difference in data_deps is sufficient.

The hash functions and bpf_range_of_data_dep() let the table of states
skip states that the rule keeps apart. They can skip more: two constants
that differ by 2 or more, or a value and an unreadable xreg.

This rule replaces all flow_*_differs() rules and their tables.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  14 ++
 kernel/bpf/precision.c       | 390 +++++++++++++++++++++++++++++++++++
 kernel/bpf/precision.h       |  15 ++
 3 files changed, 419 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index db18d451070..f2fea1985ab 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -893,9 +893,11 @@ struct bpf_loop {
 	/* while bpf_loop_per_pass.cost is not above @budget: */
 	u64 budget;
 	u32 max_peel_cnt;	/* peel up to this trip */
+	bool peeled_apart;	/* the join rule holds for states that start a peeled trip */
 	bool disjoint_apart;	/* disjoint values in data_deps stay apart, also in the leftover */
 	);
 	bool partitioned;	/* the last partition was for this loop */
+	bool peeled_joined;	/* at the start of a peeled trip, against the join rule */
 	struct bpf_loop_per_pass this_pass;
 	bool guarded;
 };
@@ -1684,6 +1686,18 @@ u64 bpf_hash64(const void *p, size_t len, u64 hash);
 u64 bpf_hash_join_key(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
 int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
+/* precision.c, failing_path.c */
+enum bpf_join_point { BPF_JOIN_POINT, BPF_JOIN_POINT_HEADER, BPF_JOIN_POINT_CALLS };
+bool bpf_must_keep_apart(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			 struct bpf_verifier_state *new, enum bpf_join_point kind,
+			 const struct loop_stack_entry *entry);
+bool bpf_values_grew_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			     const struct bpf_verifier_state *new);
+u64 bpf_hash_apart_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			 u64 hash, bool consts);
+u64 bpf_hash_args(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u64 hash);
+void bpf_range_of_data_dep(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			   u32 *first, u32 *last);
 bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 		      u32 fr, u32 xregno);
 void bpf_note_reads_from_unproven(struct bpf_verifier_env *env, u32 idx);
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index 192f5e966f7..efee61c4e08 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -52,6 +52,396 @@ bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_st
 	return test_bit(xregno, data_deps) || test_bit(xregno, control_deps);
 }
 
+/* The value in a slot. NULL if the slot has bytes of several types. */
+static const struct bpf_reg_state *slot_value(struct bpf_verifier_env *env,
+					      const struct bpf_func_state *f, u32 spi,
+					      struct bpf_reg_state *tmp)
+{
+	const struct bpf_stack_state *slot;
+	u32 i, byte_types = BIT(STACK_INVALID);
+
+	if (spi < bpf_stack_nr_slots(f)) {
+		slot = bpf_stack_slot(f, spi);
+		if (bpf_is_spilled_reg(slot) || bpf_slot_is_held(slot))
+			return &slot->spilled_ptr;
+		for (i = 0, byte_types = 0; i < BPF_REG_SIZE; i++)
+			byte_types |= BIT(slot->slot_type[i]);
+	}
+	byte_types &= ~BIT(STACK_POISON);
+	if (env->allow_uninit_stack && (byte_types & BIT(STACK_INVALID)))
+		byte_types = (byte_types & ~BIT(STACK_INVALID)) | BIT(STACK_MISC);
+	if (byte_types == BIT(STACK_ZERO))
+		bpf_mark_reg_known_scalar(tmp, 0);
+	else if (byte_types == BIT(STACK_MISC))
+		bpf_mark_reg_unknown(tmp);
+	else if (!(byte_types & ~BIT(STACK_INVALID)))
+		bpf_mark_reg_not_init(env, tmp);
+	else
+		return NULL;
+	return tmp;
+}
+
+const struct bpf_reg_state *bpf_xreg_value(struct bpf_verifier_env *env,
+					   const struct bpf_func_state *f, u32 xregno,
+					   struct bpf_reg_state *tmp)
+{
+	return xregno < MAX_BPF_REG ? &f->regs[xregno] :
+	       slot_value(env, f, bpf_xreg_to_spi(xregno), tmp);
+}
+
+static u64 hash_type(const struct bpf_reg_state *reg, u64 hash)
+{
+	if (type_is_pkt_pointer(reg->type) || base_type(reg->type) == PTR_TO_ARENA)
+		return bpf_hash64(&reg->type, sizeof(reg->type), hash);
+	return bpf_hash64(reg, offsetof(typeof(*reg), var_off), hash);
+}
+
+/*
+ * States with another type or object in data_deps stay apart. Hash these like the join_key.
+ * @consts: find a state with the same constants in all deps.
+ */
+u64 bpf_hash_apart_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			 u64 hash, bool consts)
+{
+	unsigned long data_deps[XREG_WORDS], control_deps[XREG_WORDS];
+	const struct bpf_reg_state *reg;
+	struct bpf_reg_state tmp;
+	u32 fr, xregno, bits;
+
+	for (fr = 0; env->precision->data_deps && fr <= st->curframe; fr++) {
+		bits = bpf_frame_mask(env, env->precision->type_apart, st, fr, data_deps);
+		if (env->allow_uninit_stack)
+			bits = min(bits, bpf_spi_to_xreg(bpf_stack_nr_slots(st->frame[fr])));
+		if (consts) {
+			bpf_frame_mask(env, env->precision->control_deps, st, fr, control_deps);
+			bitmap_or(data_deps, data_deps, control_deps, bits);
+		}
+		bpf_add_cost(env, 2 * bitmap_weight(data_deps, bits), BPF_COST_XREG);
+		for_each_set_bit(xregno, data_deps, bits) {
+			reg = bpf_xreg_value(env, st->frame[fr], xregno, &tmp);
+			if (reg && consts && tnum_is_const(reg->var_off))
+				hash = bpf_hash64(&reg->var_off.value, sizeof(u64), hash + xregno);
+			if (reg && reg->type != SCALAR_VALUE)
+				hash = hash_type(reg, hash + xregno);
+		}
+	}
+	return hash;
+}
+
+static u64 hash_number(const struct bpf_reg_state *reg, u64 hash)
+{
+	if (reg->type == NOT_INIT || base_type(reg->type) == PTR_TO_ARENA)
+		return hash;
+	return bpf_hash64(&reg->r64, sizeof(reg->r64), hash);
+}
+
+/* Calls with other numbers in data_deps do not share an instance */
+u64 bpf_hash_args(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u64 hash)
+{
+	const struct bpf_func_state *f = st->frame[0];
+	unsigned long data_deps;
+	u32 i;
+
+	if (!env->precision->data_deps)
+		return hash;
+	data_deps = *mask_at(env, env->precision->data_deps, f->subprogno, st->insn_idx);
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+		if (data_deps & BIT(i))
+			hash = hash_number(&f->regs[i], hash + i);
+	for (i = 0; (data_deps & BIT(XREG_STACK_ARGS)) && i < f->out_stack_arg_cnt; i++)
+		hash = hash_number(&f->stack_arg_regs[i], hash + i);
+	return hash;
+}
+
+static u32 clamp_number(s64 x)
+{
+	return clamp_t(s64, x, S32_MIN, S32_MAX) - S32_MIN;
+}
+
+/* The range of the xreg that kept two states apart at this insn, and one step more */
+void bpf_range_of_data_dep(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			   u32 *first, u32 *last)
+{
+	u32 xregno = env->precision->data_deps ? env->precision->apart_xregno[st->insn_idx] : 0;
+	const struct bpf_reg_state *reg;
+	struct bpf_reg_state tmp;
+
+	reg = xregno ? bpf_xreg_value(env, st->frame[st->curframe], xregno - 1, &tmp) : NULL;
+	if (!reg || reg->type == NOT_INIT || base_type(reg->type) == PTR_TO_ARENA)
+		return;
+	*first = clamp_number(max_t(s64, reg_smin(reg), S32_MIN) - reg->step + 1);
+	*last = clamp_number(min_t(s64, reg_smax(reg), S32_MAX) + reg->step);
+}
+
+enum {
+	CMP_NEW		= BIT(0),	/* the new state has what the old one does not have */
+	CMP_OLD		= BIT(1),
+	CMP_DISJOINT	= BIT(2),
+	CMP_GAP		= BIT(3),	/* the join has what is in neither */
+	CMP_TYPE	= BIT(4),
+	CMP_ALL		= CMP_NEW | CMP_OLD | CMP_DISJOINT | CMP_GAP | CMP_TYPE,
+};
+
+/* 0 and 3 have no gap: the join is 0..3 step 3. Most accesses ignore the step. */
+static bool has_gap(const struct bpf_reg_state *a, const struct bpf_reg_state *b, bool in64,
+		    bool in32)
+{
+	struct scalar join = *scalar_of(a);
+	u64 size;
+
+	scalar_union(&join, scalar_of(b));
+	if (a->type != SCALAR_VALUE || (a->r64.size && a->step != join.step) ||
+	    (b->r64.size && b->step != join.step))
+		join.step = 1;
+	size = a->r64.size + b->r64.size + join.step;
+	return (in64 && size > a->r64.size && join.r64.size > size) ||
+	       (in32 && join.r32.size > (u64)a->r32.size + b->r32.size + join.step);
+}
+
+/*
+ * If two packet pointers share an id and their distance differs, the join gives them two ids,
+ * see join_pkt_id(). Then a test of one checks no bytes for the other one.
+ * A pointer with no id in both states is a constant: it is disjoint if it differs.
+ */
+static bool pkt_distance_differs(struct bpf_verifier_env *env, const struct bpf_reg_state *a,
+				 const struct bpf_reg_state *b)
+{
+	struct bpf_pkt_pair pair = { a->id, b->id, b->r64.base - a->r64.base };
+	const struct bpf_pkt_pair *p = env->pkt_pairs;
+
+	if (!type_is_pkt_pointer(a->type) || !(a->id || b->id))
+		return false;
+	bpf_add_cost(env, env->pkt_pair_cnt, BPF_COST_SCAN);
+	for (; p < env->pkt_pairs + env->pkt_pair_cnt; p++)
+		if (p->old == pair.old && p->cur == pair.cur)
+			return p->delta != pair.delta;
+	bpf_add_pkt_pair(env, &pair);
+	return false;
+}
+
+static u32 compare_values(struct bpf_verifier_env *env, const struct bpf_reg_state *a,
+			  const struct bpf_reg_state *b)
+{
+	bool disjoint64, disjoint32;
+	u32 flags, pkt_flags = 0;
+	s64 left_a, left_b;
+
+	bpf_add_cost(env, 1, BPF_COST_XREG);
+	if (!bpf_same_type_and_object(env, a, b))
+		return a->type == NOT_INIT ? CMP_OLD : b->type == NOT_INIT ? CMP_NEW :
+		       reg_object_equal(a, b) ? CMP_ALL & ~CMP_TYPE : CMP_ALL;
+	if (a->type == NOT_INIT || base_type(a->type) == PTR_TO_ARENA)
+		return 0;
+	if (type_is_pkt_pointer(a->type)) {
+		if ((a->id && b->id && a->id != b->id) ||
+		    (a->range != b->range && min(a->range, b->range) < 0))
+			return CMP_ALL;
+		left_a = a->range ? pkt_bytes_left(a) : S32_MIN;
+		left_b = b->range ? pkt_bytes_left(b) : S32_MIN;
+		pkt_flags = left_b < left_a ? CMP_NEW : left_b > left_a ? CMP_OLD : 0;
+	}
+	if (pkt_distance_differs(env, a, b))
+		pkt_flags = CMP_NEW | CMP_OLD | CMP_GAP;
+	if (scalar_equal(scalar_of(a), scalar_of(b)))
+		return pkt_flags;
+	flags = (bpf_scalar_subsumes(a, b) ? 0 : CMP_NEW) |
+		(bpf_scalar_subsumes(b, a) ? 0 : CMP_OLD);
+	if (pkt_flags && (flags & ~pkt_flags))
+		flags |= CMP_GAP;
+	flags |= pkt_flags;
+	disjoint64 = cnum64_is_empty(cnum64_intersect(a->r64, b->r64));
+	disjoint32 = cnum32_is_empty(cnum32_intersect(a->r32, b->r32));
+	if (disjoint64 || disjoint32 ||
+	    ((a->var_off.value ^ b->var_off.value) & ~(a->var_off.mask | b->var_off.mask)))
+		flags |= CMP_DISJOINT;
+	if ((disjoint64 || disjoint32) && has_gap(a, b, disjoint64, disjoint32))
+		flags |= CMP_GAP;
+	return flags;
+}
+
+/* An argument that is not there is unreadable */
+static const struct bpf_reg_state *stack_arg_value(const struct bpf_func_state *f, u32 i)
+{
+	static const struct bpf_reg_state not_init;
+
+	return i < f->out_stack_arg_cnt ? &f->stack_arg_regs[i] : &not_init;
+}
+
+static void note_cmp(struct state_cmp *cmp, u32 flags, bool data_dep, bool value)
+{
+	if (!(value ? flags : flags & CMP_TYPE))
+		return;
+	cmp->all |= flags;
+	cmp->data_deps |= data_dep || !value ? flags : 0;
+	cmp->cnt++;
+}
+
+static u32 compare_slots(struct bpf_verifier_env *env, struct state_cmp *cmp,
+			 const struct bpf_func_state *fa, const struct bpf_func_state *fb, u32 spi)
+{
+	bool same = spi < bpf_stack_nr_slots(fa) && spi < bpf_stack_nr_slots(fb) &&
+		    !memcmp(bpf_stack_slot(fa, spi)->slot_type, bpf_stack_slot(fb, spi)->slot_type,
+			    BPF_REG_SIZE);
+	const struct bpf_reg_state *a, *b;
+	u32 flags;
+
+	/* bytes and no value */
+	if (same && !bpf_is_spilled_reg(bpf_stack_slot(fa, spi)) &&
+	    !bpf_slot_is_held(bpf_stack_slot(fa, spi)))
+		return 0;
+	a = slot_value(env, fa, spi, &cmp->tmp[0]);
+	b = slot_value(env, fb, spi, &cmp->tmp[1]);
+	if (!a || !b)
+		return same ? 0 : CMP_ALL;
+	flags = compare_values(env, a, b);
+	/* the join has the bytes and no value */
+	if (!same && ((flags & CMP_NEW) ?: a != &cmp->tmp[0]) &&
+	    ((flags & CMP_OLD) ?: b != &cmp->tmp[1]))
+		return CMP_ALL;
+	return flags;
+}
+
+/* What differs in the deps, or in the masks @only. The ivs of @iv_loop have no gaps. */
+void bpf_compare_states(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			const struct bpf_verifier_state *new, unsigned long *only,
+			const struct bpf_loop *iv_loop, struct state_cmp *cmp)
+{
+	unsigned long data_deps[XREG_WORDS], deps[XREG_WORDS], all[XREG_WORDS];
+	unsigned long disjoint_apart[XREG_WORDS];
+	const struct bpf_reg_state *a, *b;
+	const struct bpf_func_state *fa, *fb;
+	struct bpf_precision *prec = env->precision;
+	u32 fr, xregno, i, flags, arg_cnt, bits;
+
+	cmp->all = cmp->data_deps = cmp->disjoint_apart = cmp->cnt = cmp->disjoint_xregno = 0;
+	env->pkt_pair_cnt = 0;
+	for (fr = 0; prec->data_deps && fr <= old->curframe; fr++) {
+		fa = old->frame[fr];
+		fb = new->frame[fr];
+		bpf_frame_mask(env, prec->disjoint_apart, old, fr, disjoint_apart);
+		bpf_frame_mask(env, only ?: prec->control_deps, old, fr, deps);
+		bpf_frame_mask(env, only ?: prec->type_apart, old, fr, all);
+		bits = min(bpf_frame_mask(env, only ?: prec->data_deps, old, fr, data_deps),
+			   bpf_spi_to_xreg(max(bpf_stack_nr_slots(fa), bpf_stack_nr_slots(fb))));
+		bitmap_or(all, all, deps, bits);
+		bitmap_or(deps, deps, data_deps, bits);
+		bpf_add_cost(env, 4 + bitmap_weight(all, bits), BPF_COST_COPY);
+		for_each_set_bit(xregno, all, bits) {
+			if (xregno == XREG_STACK_ARGS) {
+				arg_cnt = max(fa->out_stack_arg_cnt, fb->out_stack_arg_cnt);
+				for (i = 0; i < arg_cnt; i++) {
+					flags = compare_values(env, stack_arg_value(fa, i),
+							       stack_arg_value(fb, i));
+					note_cmp(cmp, flags, test_bit(xregno, data_deps),
+						 test_bit(xregno, deps));
+					if (test_bit(xregno, disjoint_apart))
+						cmp->disjoint_apart |= flags;
+				}
+				flags = 0;
+			} else if (xregno < MAX_BPF_REG) {
+				a = &fa->regs[xregno];
+				b = &fb->regs[xregno];
+				flags = compare_values(env, a, b);
+			} else {
+				flags = compare_slots(env, cmp, fa, fb, bpf_xreg_to_spi(xregno));
+			}
+			note_cmp(cmp, flags, test_bit(xregno, data_deps), test_bit(xregno, deps));
+			if (fr == old->curframe && (flags & CMP_DISJOINT) &&
+			    test_bit(xregno, data_deps))
+				cmp->disjoint_xregno = cmp->disjoint_xregno ?: xregno + 1;
+			cmp->disjoint_apart |= test_bit(xregno, disjoint_apart) ? flags : 0;
+		}
+	}
+}
+
+/* See PARTITION_LOOP_DISJOINT_APART */
+static bool in_disjoint_apart_loop(const struct bpf_verifier_state *st)
+{
+	const struct bpf_loop *loop;
+	u32 fr, i;
+
+	for (fr = 0; fr <= st->curframe; fr++) {
+		for (i = 0; i < st->frame[fr]->loop_stack_cnt; i++) {
+			loop = st->frame[fr]->loop_stack[i].loop;
+			if (loop->disjoint_apart && bpf_loop_partition_is_active(loop))
+				return true;
+		}
+	}
+	return false;
+}
+
+/*
+ * The join rule. Two states at one insn have the same join_key.
+ *
+ *  insn 5:       r6        r7			see the example at bpf_compute_deps()
+ *   ok_state     0..7      0
+ *   err_state    8..max    -22
+ *                (data)    (control) -> keep apart
+ *  insn 8:       r6        r7    r8
+ *   ok_state     0..7      0     1
+ *   ok_state     0..7      0     2
+ *                                (control only) -> join
+ *
+ *  what differs               action
+ *  data dep and control dep   keep apart
+ *  two data deps              keep apart
+ *  one data dep, with a gap   keep apart   (0..1 and 100)
+ *  one data dep, no gap       join         (0..7 and 8..9, 0 and 3),
+ *                                          apart after keep_disjoint_apart()
+ *  control deps only          join
+ *  other regs only            join
+ *
+ * If one state subsumes the other in the deps, the join adds no pair.
+ *
+ * BPF_JOIN_POINT_HEADER: @new came back to the header of the loop of @entry. Only a type or
+ * an object keeps the states apart, unless the loop is partitioned. An imprecise join makes
+ * the loop a suspect.
+ * BPF_JOIN_POINT_CALLS: two calls get to the first insn of a function. The call counts as one
+ * more xreg that differs.
+ */
+bool bpf_must_keep_apart(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			 struct bpf_verifier_state *new, enum bpf_join_point kind,
+			 const struct loop_stack_entry *entry)
+{
+	bool keep, disjoint_apart = in_disjoint_apart_loop(new);
+	struct bpf_loop *loop;
+	struct state_cmp cmp;
+
+	/* in two entries an iv can have two values for one trip index */
+	bpf_compare_states(env, old, new, NULL, disjoint_apart && entry &&
+			   kind == BPF_JOIN_POINT_HEADER ? entry->loop : NULL, &cmp);
+	if (kind == BPF_JOIN_POINT_CALLS)
+		return cmp.data_deps;
+	if ((cmp.data_deps & CMP_DISJOINT) && disjoint_apart)
+		return true;
+	keep = (cmp.data_deps & CMP_GAP) || (cmp.disjoint_apart & CMP_DISJOINT) ||
+	       (cmp.data_deps && cmp.cnt > 1 && (cmp.all & CMP_NEW) && (cmp.all & CMP_OLD));
+	env->precision->this_pass.disjoint_joined |= !keep && (cmp.data_deps & CMP_DISJOINT);
+	if (keep && !env->precision->apart_xregno[new->insn_idx])
+		env->precision->apart_xregno[new->insn_idx] = cmp.disjoint_xregno;
+	if (keep && (kind == BPF_JOIN_POINT || (cmp.all & CMP_TYPE)))
+		return true;
+	if (!entry)
+		return false;
+	loop = entry->loop;
+	if (keep && entry->peeled && loop->peeled_apart && bpf_loop_partition_is_active(loop))
+		return true;
+	if (entry->peeled ? keep : cmp.data_deps & CMP_NEW)
+		new->suspect_loops |= loop->suspect_bit;
+	loop->peeled_joined |= entry->peeled && keep;
+	return false;
+}
+
+/* Does @new have more in the deps? */
+bool bpf_values_grew_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			     const struct bpf_verifier_state *new)
+{
+	struct state_cmp cmp;
+
+	bpf_compare_states(env, old, new, NULL, NULL, &cmp);
+	return cmp.all & CMP_NEW;
+}
+
 /* The function that the insn at @idx calls, or hands to a helper. -1 if that is not known. */
 int bpf_insn_callee(struct bpf_verifier_env *env, int idx)
 {
diff --git a/kernel/bpf/precision.h b/kernel/bpf/precision.h
index 63869360160..e057e452ec1 100644
--- a/kernel/bpf/precision.h
+++ b/kernel/bpf/precision.h
@@ -21,6 +21,7 @@ struct precision_per_pass {
 	unsigned long *bad_read_insns;		/* unproven because of an unreadable xreg */
 	unsigned long *unproven_funcs;		/* of functions */
 	u64 suspect_loops, first_suspect_loops;	/* of the unproven states, of the first one */
+	bool disjoint_joined;			/* disjoint values in data_deps were joined */
 };
 
 /* callx calls one of the functions whose address is taken. They count as one function. */
@@ -55,6 +56,7 @@ struct bpf_precision {
 	bool new_nospec;
 
 	u16 *apart_xregno;	/* per insn, see bpf_range_of_data_dep() */
+
 	/* The path-sensitive run */
 	unsigned long *err_insns;		/* insns at which the failing path can end */
 	u32 *hops_to_err, *hops_to_exit;	/* per insn, see compute_hops() */
@@ -63,8 +65,21 @@ struct bpf_precision {
 	unsigned long loop_carried[XREG_WORDS];
 };
 
+struct state_cmp {
+	struct bpf_reg_state tmp[2];
+	u32 all, data_deps, cnt;
+	u32 disjoint_xregno;		/* an xreg of data_deps in the top frame, plus one */
+	u32 disjoint_apart;		/* what differs in these xregs */
+};
+
 u32 bpf_frame_mask(struct bpf_verifier_env *env, unsigned long *masks,
 		   const struct bpf_verifier_state *st, u32 fr, unsigned long *out);
+const struct bpf_reg_state *bpf_xreg_value(struct bpf_verifier_env *env,
+					   const struct bpf_func_state *f, u32 xregno,
+					   struct bpf_reg_state *tmp);
+void bpf_compare_states(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			const struct bpf_verifier_state *new, unsigned long *only,
+			const struct bpf_loop *iv_loop, struct state_cmp *cmp);
 int bpf_compute_deps(struct bpf_verifier_env *env, unsigned long *masks,
 		     const unsigned long *seed_insns);
 
-- 
2.55.0

