Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401878;
	b=h0aJVS22qO7D5mn6MnYf5/CGK+iHCaE/9p2bfZxgwUZqt8x0Zg62RipTpsmJbuJofWuP
	 NfZ2TjaDv25SSbtJ/JeW9HcyxkMYZf8ML8zikJCC6SjkIk7ib9e3VLBHfE1qnHjhjhvu+
	 XT6eT7KDagHeWVDAR28HoRru6mdcnTLKxdhz3n/8/Dez8YF44Cz8Vhhp6QDy1tmvZs3Rq
	 6+T2umyEZshlcS7uODN8GhnFWmXEDN/3ed/u9BuAhBylgPncX4pBl3XJCHusw9gmpsCRT
	 qOEM3c27MUZTR1qbY5kE75mSHoGb6lug8O8gVXhlU8BsX7B+QBqASCsaYHlxYdiSbAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=MWY7seNQMY134IxioRIFZnLkDjgMYoaZ9InuNPbSKSg=;
	b=ydXHoNtcP6RwjlsayeArj0aefz99m4zfaHcF59qU78wH6bLU6c39OQX5/Vcd17i8h7JO
	 iKtR57tznFa3Tz+b17GPMVSXvNc/c0s07+myU/LaSN9RJj6Yh3qN+g0/C4E95YSyuGPA6
	 MAEbCj4RZx8doHycBgjPoLpKw3gJ0mogCBPgocP13PHr97ykxQ0WvZqIfoRgWTW8o2L0S
	 8MaLN5Rny4e7y0T/xpP2kjWmAjzqnM/J3arqkqzHreb1uIIZBOeEtjdMoSej1FelWfYBL
	 gC5ADb4HddCia750sAEhwQD/RAIFLc0yVUh/gbQVcE3cXCgQHELXTbkQIYiOMHZ7GwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u884T68u;
	arc=none smtp.remote-ip=74.125.225.136
Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4644606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4644606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u884T68u
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4a77811be24so10593285e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401876; x=1795006676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWY7seNQMY134IxioRIFZnLkDjgMYoaZ9InuNPbSKSg=;
        b=u884T68u8oWZ6VmUj5ee5CLcc9IlMmpmca9BJMU0ZspxebHFHF40PMgOZtWKh5uyZX
         FRc0L2e2llJWetEc8V2Zm1gC8jZ2ao60Oof5Hfc9pqO28rvuhA5j3acKuo+dMBeEtUzm
         j8yGMDkWvJY6eIDehOpU+PL8itD7XHyj9qrNfQgo3VNSYZZinnHud56uxHWH6YaDRfJX
         oTz98ybhXTlEZS5stpAn200pOUQ95hudgiJRx79HsV4OH9y84HqHDkgdjpOM6WuTGfb9
         0jPd84CKYvL8xVtvBhI8h/feUSesy60Cvul1/0rVc6jWeTXSmXn2/Zu4VU3XRbZdE8hF
         oWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401876; x=1795006676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MWY7seNQMY134IxioRIFZnLkDjgMYoaZ9InuNPbSKSg=;
        b=0JjIkguyYLUcIM2DHY7lkJXmkbzEkHjgOAs5ULLl4uYMXO2nm7+87azLZdYUcEqaem
         KWlnADFTL7raSKfIPZzHNbowqz4sc4vMvK/LbG3v/uSRxS68m0JHRTrVhlgBemw0H/b+
         7Qycqa3KBFsOMl3jULRzl6XE77TIP6FNm9SWTTENDF0a/WgF4NOrZvTzy02Rem4pThPL
         +bet+OglUyliBsky/AxDf0GCxFc3wQBSfgqa66MaMZlrL6WObxp4adSBSmuVojdahJq4
         pEdBjBJ/dG8nUGf7zU/3tzXeRN/4G91meFao/j4ZDuR/qWc2cvsxZyJXAJUf73I4JMsf
         PUNA==
X-Gm-Message-State: APuU4Z+x03BTqbC/y3KjW9dkT/0TozvGRo71E0HjhaOezSND0owUvi0Q
	R39jbfaNwfxxfHMr2r1YIIgQoNh/7IJTQq/g6OOI/FqkMqSP4dhxtCIrKrmfWDrClR0=
X-Gm-Gg: AYBFou2By0S3vV6eQqB4CedNyLm053Whl9rYspJMNE9T+1VaTbESc63h6nMhFESXtPm
	AH2D+lANnCjUsGUXMNkbtQYWEeV9M59wEFTnu2fO+fvhzhhmv3AkgVqmXA3S8nv6kWF//pX/+xj
	jHvkXvV43YiN0vHlqIV6kq7LjT+5zepYJ+abMkB7mc/z06lasgdrN7gGG5Y9uU2I6mMP7g2nA1b
	hSj6OgVzQDbC4KMINSo2rcV3e+r5swc0UXWdkJZ5BakQ82GBr3Anva5QBOqm6fToLNWa/YeUBYw
	/qKZ1OanBj/oivTSisNnZQqPAna/oKOkS2plgDf81nYQObn0ds0CItaK4Bl9klomwzSPpIZYqLR
	PqcgXOTQLfXamz64q0f/JQHdEs/nQgEfK0qkENzdVW7l2mzbkhAMh4a1vUbRDFZ0QfMySkN8Dzf
	8uwja4JAqs7SAQtX3H5FmDFaqkFUp5owdanT12schkfn+ZA7WKFYqamgH4Su+gm7q5OSvUO/rI8
	BXE76m5PcsZe+28dmABMG6ZpBV1T3dJyPe6BvFyvLLhNRy5d4uIGwnrAl+XY+Djn2jHImUF9ZIS
	jIhF0kNda3jOrGOPuf/IhwC3/nbBEPN9llrwMQk9JzVPiTwpRGUWBJaTKYIXs3k7xU6GMwYe/Up
	GGiDmGKLIY8oQPoSS1COm0f5H/gnV+YcZgcau/mE+bPhFU4OmLMn757sqPH1A2jYmjfjj
X-Received: by 2002:a05:600c:1986:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ba09376d2dmr41272895e9.11.1794401875801;
        Wed, 11 Nov 2026 04:57:55 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08ddbfcesm29972475e9.0.2026.11.11.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:55 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 16/29] bpf: Describe locks at throw sites
Date: Wed, 11 Nov 2026 13:57:14 +0100
Message-ID: <8861d3d06eadcff128742ac81b2ba9c54f71c523.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11925; i=memxor@gmail.com; h=from:subject:message-id; bh=Xo2H+NwcyFXdTN2zXeNjCIjAQ0a+PVuwPlKgEpelWT8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzEKt0vua99hVv6v+Y+oqf99qovsiL5spNMr5grllW 8xWpvUdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmEjvRkaG+yonhL8cyPp3i3XJ x4Xn6nvulwjvyNx8Ts1qYbH6hYWS3Qz/g1aKXxLbeD789N8Lul4PJ737NGfiPZap150a7Hasi0j 2YQQA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently no site describes a lock, so every lock that a throw finds held
is kept in a hidden slot. Its address is stored before the call that
takes the lock, and cleared before the unlock.

A lock does not move, so a site can describe it:

 - The lock of a global variable, or of the only element of any other
   array map that the program refers to, is at an address known at
   verification time. Its resource class carries the address. The site
   entry is marked BPF_FRAME_ENT_FIXED and reads nothing from the frame.
   This does not apply to an inner map: the map that stands for it
   during verification has no values.
 - Any other lock is found through a pointer to the map value or
   allocated object that contains it. Such a pointer has the same id as
   the lock. The acquisition records the offset of the lock in the
   object, and the site gives a stack slot or a register that holds such
   a pointer, with the difference as its adjustment. A lock whose offset
   does not fit in an adjustment is not found through a pointer.

A lock at a fixed address then costs the program nothing when every
visit to a site finds it held. Any other lock costs nothing when, in
addition, the frame has a pointer to the containing object in the same
location on every visit. A lock that some visits to a site find held and
others do not still takes a hidden slot.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  4 ++
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/frame_desc.c      | 77 +++++++++++++++++++++++++++++-------
 kernel/bpf/unwind.c          |  2 +
 4 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b157863cb952..cbb0d7a61f98 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1860,6 +1860,7 @@ struct bpf_resource {
 	union {
 		void (*dtor)(void *);
 		struct btf_struct_meta *meta;
+		void *addr;	/* a lock at a fixed address, in the only element of an array map */
 	};
 };
 
@@ -1880,6 +1881,8 @@ struct bpf_resource {
  *    bpf_arch_throw_entry();
  *  - with BPF_FRAME_ENT_OBJ the resource itself, an iterator or saved IRQ
  *    flags the frame has on its stack whenever it is at the site;
+ *  - with BPF_FRAME_ENT_FIXED no location: a lock at the address its class
+ *    gives, which the frame holds whenever it is at the site;
  *  - with BPF_FRAME_ENT_COUNTER a hidden slot that holds a count of sections,
  *    signed: the sections the frame entered less those of its callers it left;
  *  - with BPF_FRAME_ENT_COUNT no location: the count of the sections the frame
@@ -1891,6 +1894,7 @@ struct bpf_resource {
 /* Released before the other entries of the frame, which it may be using. */
 #define BPF_FRAME_ENT_FIRST	BIT(3)
 #define BPF_FRAME_ENT_REG	BIT(4)
+#define BPF_FRAME_ENT_FIXED	BIT(5)
 
 struct bpf_frame_desc_entry {
 	u16 res;	/* index into the program's resource classes */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 158e7eddc19f..a7c9b113e071 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1253,6 +1253,7 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
 #define BPF_RES_F_MAY_FAIL	BIT(1)	/* acquired only when the call returns 0 */
 #define BPF_RES_F_DEREF		BIT(2)	/* the handle is the first word of a dynptr on the stack */
 #define BPF_RES_F_CTX		BIT(3)	/* a __ref argument the kernel passes the main program */
+#define BPF_RES_F_NO_PTR	BIT(5)	/* a lock that no pointer to what it is in leads to */
 
 /*
  * A call that acquires a resource, see frame_desc.c. When a frame can be
@@ -1301,6 +1302,7 @@ struct bpf_res_loc {
 	u16 acq;	/* index of the acquisition */
 	u8 cnt;		/* the places left */
 	bool obj;	/* they are the resource itself, an object on the stack */
+	bool fixed;	/* it is a lock at the address of its class, and needs no place */
 	struct {
 		s16 off;	/* relative to R10, or the number of the register */
 		s16 adj;	/* the pointer there points that many bytes into the object */
diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
index 5cb837688f90..72dc6597321a 100644
--- a/kernel/bpf/frame_desc.c
+++ b/kernel/bpf/frame_desc.c
@@ -376,6 +376,42 @@ static int resource_of_kind(struct bpf_verifier_env *env, u8 kind)
 	return resource_intern(env, &res);
 }
 
+/*
+ * The class of the lock that the current insn takes through @reg, a pointer
+ * to it. A lock in the only element of an array map, which every global
+ * variable is, is at a fixed address: its class says where, and a site needs
+ * no place for it. That is so for a map the program refers to itself only:
+ * what stands for the inner maps of a map has no values. Any other lock is
+ * @off bytes into what the pointer is into, a map value or an object: a site
+ * finds it through a pointer to that which the frame keeps, unless the offset
+ * is too large for a site to tell, see BPF_RES_F_NO_PTR.
+ */
+static int resource_of_lock(struct bpf_verifier_env *env, const struct bpf_reference_state *ref,
+			    const struct bpf_reg_state *reg, s16 *off, u8 *flags)
+{
+	struct bpf_resource res;
+	const struct bpf_map *map;
+	u64 base;
+	u32 i;
+
+	memset(&res, 0, sizeof(res));
+	res.kind = ref->type == REF_TYPE_LOCK ? BPF_RESOURCE_SPIN_LOCK : BPF_RESOURCE_RES_LOCK;
+	if (!reg || !tnum_is_const(reg->var_off) ||
+	    reg->var_off.value != (u64)(s16)reg->var_off.value) {
+		*flags |= BPF_RES_F_NO_PTR;
+		return resource_intern(env, &res);
+	}
+	*off = reg->var_off.value;
+	map = reg->type == PTR_TO_MAP_VALUE ? reg->map_ptr : NULL;
+	for (i = 0; map && i < env->used_map_cnt; i++)
+		if (env->used_maps[i] == map)
+			break;
+	if (map && i < env->used_map_cnt && map->map_type == BPF_MAP_TYPE_ARRAY &&
+	    map->ops->map_direct_value_addr && !map->ops->map_direct_value_addr(map, &base, *off))
+		res.addr = (void *)(long)(base + *off);
+	return resource_intern(env, &res);
+}
+
 /* The offset from R10 of the stack slot @spi of a frame. */
 static s16 spi_off(int spi)
 {
@@ -397,6 +433,8 @@ static int acquired_class(struct bpf_verifier_env *env, struct bpf_verifier_stat
 			  s16 *adj, s16 *obj_off)
 {
 	const struct bpf_func_state *frame = st->frame[st->curframe];
+	/* a handle that is in no register can only be found by the sites */
+	bool in_reg = regno >= BPF_REG_0 && regno <= BPF_REG_5;
 	const struct bpf_stack_state *slot;
 	struct bpf_resource res;
 	struct bpf_reg_state reg;
@@ -414,8 +452,7 @@ static int acquired_class(struct bpf_verifier_env *env, struct bpf_verifier_stat
 	}
 	*flags |= BPF_RES_F_ARG;
 	if (ref->type & REF_TYPE_LOCK_MASK)
-		return resource_of_kind(env, ref->type == REF_TYPE_LOCK ? BPF_RESOURCE_SPIN_LOCK :
-								   BPF_RESOURCE_RES_LOCK);
+		return resource_of_lock(env, ref, in_reg ? &frame->regs[regno] : NULL, adj, flags);
 	if (!stack_object_find(st, ref, &objframe, &spi))
 		return -EOPNOTSUPP;
 	if (objframe != st->curframe)
@@ -794,9 +831,11 @@ static const u8 site_regs[] = {
  * The places of frame @f of @st that hold the handle of @ref, which the frame
  * owns, in @loc: the stack object the reference is of, or the slots of the
  * stack a pointer to the object is spilled in and the registers that hold
- * one, see site_regs; @throws when the frame calls bpf_throw(). A lock has
- * none. The slots a spill is removed from again, see
- * bpf_remove_fastcall_spills_fills(), hold nothing at run time.
+ * one, see site_regs; @throws when the frame calls bpf_throw(). A lock at a
+ * fixed address needs no place. Any other lock is found like an object,
+ * through a pointer to what it is in, which has the id of the lock. The slots
+ * a spill is removed from again, see bpf_remove_fastcall_spills_fills(), hold
+ * nothing at run time.
  */
 static void ref_locations(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, int f,
 			  const struct bpf_reference_state *ref, bool throws,
@@ -805,42 +844,50 @@ static void ref_locations(struct bpf_verifier_env *env, const struct bpf_verifie
 	const struct bpf_res_acq *acq = &env->res_acqs[ref->acq - 1];
 	const struct bpf_func_state *frame = st->frame[f];
 	s16 adj, lim = env->subprog_info[frame->subprogno].fastcall_stack_end;
+	bool lock = ref->type & REF_TYPE_LOCK_MASK, ptr;
 	const struct bpf_stack_state *slot;
 	int k;
 
+	memset(loc->at, 0, sizeof(loc->at));
 	loc->cnt = 0;
 	loc->obj = false;
-	if (ref->type & REF_TYPE_LOCK_MASK)
+	loc->fixed = lock && env->resources[acq->res].addr;
+	if (loc->fixed) {
+		loc->cnt = 1;
 		return;
+	}
+	/* a pointer the frame keeps: to the object, or to what a lock with an id is in */
+	ptr = lock ? ref->id && !(acq->flags & BPF_RES_F_NO_PTR) :
+		     ref->type == REF_TYPE_PTR && !(acq->flags & BPF_RES_F_ARG);
 	for (k = 0; k < bpf_stack_nr_slots(frame) && loc->cnt < BPF_RES_LOC_MAX; k++) {
 		slot = bpf_stack_slot(frame, k);
 		adj = 0;
 		if (spi_off(k) < lim)
 			break;
-		if (stack_slot_is_object(slot, ref->id)) {
+		if (!lock && stack_slot_is_object(slot, ref->id)) {
 			/* the handle of a dynptr is its first word, as when it was created */
 			if (slot->slot_type[BPF_REG_SIZE - 1] != STACK_DYNPTR) {
 				loc->obj = true;
 				loc->cnt = 0;
 			}
-		} else if (ref->type != REF_TYPE_PTR || (acq->flags & BPF_RES_F_ARG) ||
-			   !bpf_is_spilled_reg(slot) || !reg_ref_off(&slot->spilled_ptr, ref->id, &adj)) {
+		} else if (!ptr || !bpf_is_spilled_reg(slot) ||
+			   !reg_ref_off(&slot->spilled_ptr, ref->id, &adj)) {
 			continue;
 		}
 		loc->at[loc->cnt].off = spi_off(k);
-		loc->at[loc->cnt].reg = false;
-		loc->at[loc->cnt++].adj = adj;
+		/* the acquisition of a lock has how far the lock is into what it is in */
+		loc->at[loc->cnt++].adj = lock ? adj - acq->adj : adj;
 		if (loc->obj)
 			return;
 	}
-	if (!env->describe_regs || ref->type != REF_TYPE_PTR || (acq->flags & BPF_RES_F_ARG))
+	if (!env->describe_regs || !ptr)
 		return;
 	for (k = 0; k < (throws ? ARRAY_SIZE(site_regs) : 4) && loc->cnt < BPF_RES_LOC_MAX; k++) {
 		if (!reg_ref_off(&frame->regs[site_regs[k]], ref->id, &adj))
 			continue;
 		loc->at[loc->cnt].off = site_regs[k];
 		loc->at[loc->cnt].reg = true;
-		loc->at[loc->cnt++].adj = adj;
+		loc->at[loc->cnt++].adj = lock ? adj - acq->adj : adj;
 	}
 }
 
@@ -908,7 +955,7 @@ static int site_visit(struct bpf_verifier_env *env, const struct bpf_verifier_st
 				if (cur.at[j].off == loc->at[k].off && cur.at[j].adj == loc->at[k].adj &&
 				    cur.at[j].reg == loc->at[k].reg)
 					break;
-			if (j < cur.cnt && cur.obj == loc->obj)
+			if (j < cur.cnt && cur.obj == loc->obj && cur.fixed == loc->fixed)
 				loc->at[n++] = loc->at[k];
 		}
 		loc->cnt = n;
@@ -1481,7 +1528,7 @@ static int build_site(struct bpf_verifier_env *env, u32 idx, const u32 *new_of)
 	for (i = 0; i < env->res_loc_cnt; i++) {
 		const struct bpf_res_loc *loc = &env->res_locs[i];
 		const struct bpf_res_acq *a = &env->res_acqs[loc->acq];
-		u16 flags = loc->obj ? BPF_FRAME_ENT_OBJ : 0;
+		u16 flags = loc->obj ? BPF_FRAME_ENT_OBJ : loc->fixed ? BPF_FRAME_ENT_FIXED : 0;
 
 		if (loc->site != idx || a->slot)
 			continue;
diff --git a/kernel/bpf/unwind.c b/kernel/bpf/unwind.c
index 473897c3aff7..d3cd95f08769 100644
--- a/kernel/bpf/unwind.c
+++ b/kernel/bpf/unwind.c
@@ -233,6 +233,8 @@ static void bpf_unwind_release_desc(struct bpf_unwind_ctx *ctx, const struct bpf
 			continue;
 		if (ent->flags & BPF_FRAME_ENT_OBJ) {
 			handle = loc;
+		} else if (ent->flags & BPF_FRAME_ENT_FIXED) {
+			handle = res->addr;
 		} else {
 			/* no descriptor names a register that was not captured */
 			if ((ent->flags & BPF_FRAME_ENT_REG) && WARN_ON_ONCE(!ctx->entry))
-- 
2.53.0

