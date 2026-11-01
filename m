Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555233;
	b=v8pvUhR4Fa3kysz2exiUMsRxWbyhgc5vV/jsShO9WxyyCKaVAnRoLuChEetViunIVgJV
	 /DHTzR18TuvU09zLRR5+gGMbMJlQbaXIFOd1APmRY+kQc6p4n1wf2Q4KztPwCpbtoH0+9
	 92AgcF38xr9PDfU3iVWTK/RKDG9nI0+BWmtCbU/cfEF9uwVp4bWSsChfHkeRG68DC33QO
	 G2jGlVAxStF6vK5vupfvKNHvNLmeJ2XG51uGt1PDHzW97tz3gW8MylXLbUv+MwmRU8ty1
	 MOlZTpM9kOH1LYjlwRVmLmA0W8xMMpETgHIremEjMzMzfBFYQINV47NPtNWa+GhxKyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vfssr7nMaKCGbpxAiu5MnvxA3M3c9a564EF/4BiSpHk=;
	b=n2AL3tvr0yCmisfI10HbCfeeLvGSVyOIKYE8GNd/eovL05zTjyXSBgTLJblnq1aZ6EA5
	 A1/xnTFigmTHkI5cyk4o8wg4iKZxhxcBy7sO8zzdcTc0b3ogapekQWlY7eJwHLD0pNk0A
	 TpBmUjxI3gEDvRWe1XKS3Jg5AwIgNG0nCAfs9Qv26wmvcCyXQzRO6+rJEfR5kC5mFY7iP
	 MtfLH2P44breixYHUzqZl/fqr9eOACbni1+mdN3sMUwT3Z1V9HwQp/mnTbMHA3GDMBrPj
	 dZK06xREsuWe6E6iGr9Db29devz3KkCETy+0v8T5WdSKkKpgUhej/aFunjT+gLS3mmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TUfH4yGE;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729B606A329
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 17:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6729B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TUfH4yGE
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b0d126f631so21790007b3.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793555232; x=1794160032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfssr7nMaKCGbpxAiu5MnvxA3M3c9a564EF/4BiSpHk=;
        b=TUfH4yGEiV0l1ZeJs92QmIi6Yn2fYaQCogP30L+ZnJ0tCKf6qICW7T8NqljZcSeTOR
         IpP+VjOfGTvxUDfoL9+bDtVGKRX+l18STBm8GHlEPdGOWmHzhX+n9m5xLZIDzXWNVafG
         T0yKEZqqwyPK7ogaW8xpLLr84gv6JFQDd7ZUtP9k7CVinIv4GMv296L4AvbX4ZVTX46I
         jt5AmCjKmpbjYo3b/Ld61IQvgm3NDMdMuZ1/jZ3LoOfuVmYEBAqE2By504A7j5AhUfHG
         O95Oyn0eyTRjTpSXviHTOOvIczFznCFff9aSS1vT02bBls8lPp9L9lU6mhBU4A2cYIGp
         vnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555232; x=1794160032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfssr7nMaKCGbpxAiu5MnvxA3M3c9a564EF/4BiSpHk=;
        b=ObnWBO4eLW03fbCakPxKc3c/JjyDqhFrhTwvPSSX8zGhVbXKxAigGFlY5WgolabzZ4
         fx5fB5jEfq/u2xp16fWj4sXqBiIOzY+dh+b/jCuaXn7UpfbUM3UerN8x9AjzCAo4gGeG
         Ts36NwHEZ8YLvwMUJOHSSCmOKZkfuaIooIA/YlAbPBLrCXdSI2YZExYWNcR5++PrAY5h
         KUZvcNQpNF5zOEag2j16j4rdIHl9G3iERWLks+99SFhZgNgUmKNR3H1to4lccLa8Eh2o
         aTKanzVMAX0XEozg4svBCsPK53ih1B4eaxX9I5Jpb9UKiqKkZV0lkFkeu40vTRhTxH+/
         ltcA==
X-Gm-Message-State: APuU4Z9QYN4kvt85lO4UBGGGhHlGTgoB2GcQy0LZz6EkTJs1wBtkFSOH
	YWpvftRgvMr/66PI03ij5/kM0IKNdk8P69RKSKPsq/TjljgJgl4onABPmdiL+Q==
X-Gm-Gg: AYBFou3KzBq5UPzUmyYTDrd1l6Exp8qFe2tQS3KiHZKvQCFSl/5AZCcK9RyIYfX5h10
	FF41ENSVZyTpI0DyTh5PxitXC9j+M60FtoDiR6uOwr7LyZ6z0/GOasa/ICUGIeNFwSdlDo3s1QH
	HOfepdD5XBG7xJPcwVoeOU06+ri0grPX5afT6gKkInfnAmuikqSCnBroJmtOvqtloaX0/NYRrwK
	Pfy1MSwFMprjEY+TCN/3wUMwA/8DhSqLD2czJmpE877zYtWj2bA3sgFfsei0XrYeX0RibgY0qiR
	gI+ULB1Go+/GmTsmzQDhICpXTuVaTumeTG4um3E/qAvxjvyi8UFg6GQypyFk6vhIKCn3CHTMv1Z
	v2ltHzNpUSpLZ70wKH+jYSw+93APnZOsnqpgGnUfgqNlqvrlNyfCa6Lell7t/ED3X0YodXA4/nx
	hh2Sa+hEssoiWNkHTQI9N2ztqIjRmlexULCgZifU8dPl7iSy6GxmxPvFycTv/6zR1y11uSHSfr/
	dW8/D+RjtMAdM6TQ9z178GNaD83JTyW/ggQzn+9uLt0pOCAeqcK2tS/TenvKikC/9ADZRa758qY
	K/75MPbsd3/H2WRiqGCjkJQ03YeEc431IjOcc1EB/coby4sZkffilOcNn88PdZobxPB2qPbvPm1
	YI6cTTyEb4nOpo6lSfkXNo+cX0aTHze1UFMxqGiLbNEQ9kaVGFx3KdEJalGxVqZKkZQMEc96v1w
	==
X-Received: by 2002:a05:690e:400b:b0:679:bf8a:d2b3 with SMTP id 956f58d0204a3-67ba4c909c6mr5987975d50.6.1793555232227;
        Sun, 01 Nov 2026 09:47:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf270946sm3440510d50.8.2026.11.01.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:47:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: A lookup in an array is not NULL when the largest key is below max_entries
Date: Sun,  1 Nov 2026 17:46:59 +0000
Message-ID: <20261101174700.4086827-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101174700.4086827-1-alexei.starovoitov@gmail.com>
References: <20261101174700.4086827-1-alexei.starovoitov@gmail.com>
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

bpf_map_lookup_elem() in an array or in a per-cpu array returns NULL only
when the key is not below max_entries. Since commit d2102f2f5d75
("bpf: verifier: Support eliding map lookup nullness") the verifier knows
that, but only for a key that is a constant:

  u32 key = cpu & 3;                            /* max_entries is 4 */
  bpf_map_lookup_elem(&array, &key)->cnt++;
        R0 invalid mem access 'map_value_or_null'

The counter of a loop is not a constant either. Scalar evolution gives it
one range for all iterations. Thus the verifier rejects the loop below.
It accepted the loop, one iteration after the other, before commit
6ccf49f79327 ("bpf: Use SCEV to widen bounded loops").

  for (i = 0; i < 64; i++) {                    /* max_entries is 64 */
          key = i;
          bpf_map_lookup_elem(&array, &key)->cnt = 0;
  }

The check does not need a constant. It needs to know that the key is below
max_entries. Use umax of the register that the prog stored to the key.

The stack slot has the range of the 64-bit register. The key has only
4 bytes, but max_entries is a u32. Thus a value below max_entries fits in
the key, and the helper reads the same value. All other conditions stay:
CAP_BPF, a key on the stack at a constant offset, zeros or a store of
exactly 4 bytes, no BPF_F_INNER_MAP.

The verdict now depends on the range of the key. Thus mark the key as
precise, as for a constant, but only when it is below max_entries. In the
other case the verifier examines the prog with NULL and with a pointer, and
this is correct for each key.

The code of the lookup does not change. It compares the key with
max_entries at run time, as before.

The verifier does not follow NULL branches that the prog cannot take, and
removes them as dead code. In sched-ext/scx 29 of 493 progs change, with
4.2% fewer insns in total. 4 of the 29 need more insns, because states with
different keys are not equal.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/verifier.c        | 38 ++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7baeb831281f..1b8bd65ea95d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1851,7 +1851,7 @@ struct bpf_call_arg_meta {
 
 	/* Only set by helper */
 	u64 msize_max_value;
-	s64 const_map_key;
+	u64 max_map_key;
 	struct btf *ret_btf;
 	struct btf_field *kptr_field;
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b6c0674ff6a..83cbded1f6bd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9639,11 +9639,14 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* Returns constant key value in `value` if possible, else negative error */
-static int get_constant_map_key(struct bpf_verifier_env *env,
-				struct bpf_reg_state *key,
-				u32 key_size,
-				s64 *value)
+/*
+ * Returns the largest value of the key in `value` if it is below `max_entries`,
+ * else negative error
+ */
+static int get_max_map_key(struct bpf_verifier_env *env,
+			   struct bpf_reg_state *key,
+			   u32 key_size, u32 max_entries,
+			   u64 *value)
 {
 	struct bpf_func_state *state = bpf_func(env, key);
 	struct bpf_stack_state *ss;
@@ -9685,12 +9688,17 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	if (spill_size != key_size)
 		return -EOPNOTSUPP;
 
+	/*
+	 * The slot has the range of the 64-bit register that was spilled. A value
+	 * below max_entries fits in the 4 bytes of the key.
+	 */
 	reg = &ss->spilled_ptr;
-	if (!tnum_is_const(reg->var_off))
-		/* Stack value not statically known */
+	if (reg_umax(reg) >= max_entries)
+		/* The lookup can return NULL: nothing depends on the key */
 		return -EOPNOTSUPP;
 
-	/* We are relying on a constant value. So mark as precise
+	/*
+	 * We are relying on the range of the key. So mark as precise
 	 * to prevent pruning on it.
 	 */
 	bpf_bt_set_frame_slot(&env->bt, key->frameno, spi);
@@ -9698,7 +9706,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	if (err < 0)
 		return err;
 
-	*value = reg->var_off.value;
+	*value = reg_umax(reg);
 	return 0;
 }
 
@@ -9881,9 +9889,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		if (err)
 			return err;
 		if (can_elide_value_nullness(meta->map.ptr)) {
-			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
+			err = get_max_map_key(env, reg, key_size, meta->map.ptr->max_entries,
+					      &meta->max_map_key);
 			if (err < 0) {
-				meta->const_map_key = -1;
+				meta->max_map_key = U64_MAX;
 				if (err == -EOPNOTSUPP)
 					err = 0;
 				else
@@ -12534,8 +12543,8 @@ static int update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
 }
 
 /* Returns whether or not the given map can potentially elide
- * lookup return value nullness check. This is possible if the key
- * is statically known.
+ * lookup return value nullness check. This is possible if the largest
+ * value of the key is statically known.
  */
 static bool can_elide_value_nullness(const struct bpf_map *map)
 {
@@ -12913,8 +12922,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
 		    can_elide_value_nullness(meta.map.ptr) &&
-		    meta.const_map_key >= 0 &&
-		    meta.const_map_key < meta.map.ptr->max_entries)
+		    meta.max_map_key < meta.map.ptr->max_entries)
 			ret_flag &= ~PTR_MAYBE_NULL;
 
 		regs[BPF_REG_0].map_ptr = meta.map.ptr;
-- 
2.55.0

