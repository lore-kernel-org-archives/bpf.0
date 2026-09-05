Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C820045561A
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597274; cv=none; b=JieoR3KHyMd1Xx8VAfNYyP1GLGvm0FlL8fe1f039WtWPCHeZr7dc0mFIVhPdiVtGIX6/T9Gaamd46BqyC3KIUOJwObFKEFsEerzveWh32KIRKr1vZkW9Ym4u7AZmbDSC/6SCMFGhk34r9GNqbE1f7aFfaemEU2kWuua7EUFacK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597274; c=relaxed/simple;
	bh=WlqzBOve5EbVJ4gzRvzzHFx1h83SL7E/5QZwpzuTfSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VroHsKMV8MeWOF8VY/B8dxtBxm/2XID/KVAQS0NJb99RK8aOrnJT1d4KHzRa7R0PHZLMSb9j1ADBDIgLV8ksN+6+6ahfKVncxhgrHndOnF+9g/sh6a9lqnWIJDRf7qsYcYwldrpCz/pFbeqhfnVadHWgSAf+NBOzjPqudXfJ/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVTf7PJO; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVTf7PJO"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-483960225ccso551528f8f.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 01:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597270; x=1789202070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hIcWD43m6Z/n5ELJH64T9sdUMCup07Fv460rXdxYlVE=;
        b=jVTf7PJOtIo+JReKWy8LzRcuSuLTcVeoFmP32igE660/rMkZ2IoOmvcwlZ5+J22gkd
         3K/LvcLqavtx7n7D7lVcFw7JHo9PNVYdkHXJgL/BA5R7M4Qp+jL2+B0zb0owBOOl4bad
         ypX2fV+QN0k2Td/A6ukb4mE8vbWGOQUBjT/fIPhkSM8tQrHb+UAsaDgpFkpJsgUVQgvp
         ayiWD1dSjg2Jb90ZB9Btb5PWLzDoDSLbnAwerj8VJoAJ7f8CQ7MuBmn3CgEqbwxC4ebP
         3tE3EpBe89xxiFL/xZ5UKq0jqqYi5d6FiPs8t6qgN7iz7pec4dtCt/KsvQKz0Is9fes+
         5G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597270; x=1789202070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hIcWD43m6Z/n5ELJH64T9sdUMCup07Fv460rXdxYlVE=;
        b=aa83JPT4rZPXqjhPqVodie1zbUNxWMqxks5pAZL3MAzvsTxWvzzQiT6Z8jaNZYULpQ
         R4ZcP8AbshyrhRUxnQMuyotDj45urGzTTpmMqvn1GimkyvhvlfhXZqRnhUrIsrOE140U
         LiM4AGdqBN4qsVo+JmUjiYf8KUdcP4d1QaV1+pzmLkKYhkqp1wEN36QdhnWoFbtdM/Nd
         9p/GmfJdKxKZxtVJcSyUiD4gpN7Hticu2jna0JFhcy7lFiRxZqj/aXsUbSqeUrNYYa15
         i3sh0RsNaT9jHQCYRqkntldh6P48PKBHauQProtgtkO4aVrHMKXwm5Xvccu6LSrkG8gr
         5BwQ==
X-Gm-Message-State: AFuF++m9v8N3GTedeR9nD8doaTunsaRGFtd3phMaL/OOJUAHBZkuVGmx
	gfTOoT3MpnG9TM/2qBVsWxsUqsYcRFTdl1AeRz/pUtL2754FE+R63qEME0KpXzGe
X-Gm-Gg: AYBFou2gBTm+NLVlD407bzATSMn8ZGrs1ezEwTzv5fSz4fsHCYZ6mVuPDQjG2rX2cju
	ZUFgOVZ6QnVZEaWxk4WTzJhXpnUANaa+eiRsE3tQNQQsFjkSUAIyqwPbUM8L3PbqgXNtYGeBf27
	0d/pQ/gTme6mNNe+x44HoxEEqPK8bplSnpu46dne/lYgM1hQWN8EDUd8KG1hJEqXGMrFWFKogT9
	VtS3GU1tCvbw1HjeTRgCDzuiZPcuTJGkRniIZUPLDcE2/+FvY8/6Qx2zjjK/CUwPMqHjHDPzJMP
	PsaV0mU71G2T6I0rDdxQBCnXQOy3Pm8Cj2+BTGedR6NsLGTSiYDhWpHR0eEMuLpKGgy1iIPCzC5
	ygD34yS9CxyBBM11V+6nqAxRVDOOKigygBH5kzP4j9weoC97ieFQqTTUDDl95QFw9N3LnVnsvpC
	khKA+DTr+9l5TgJbx2weSFttwpf57tVKySrRiYaRDNGRdxpIfaRyKzP/V4CuA1gyAtI4/O5grNu
	wib24AGSo8J+dKgt/t5c0oC54PnxPpGKLmNR69/VIWhvoCmPnLV5apADWriUgeo7hsexWpSxOzg
	nVDPDCL/hHsOZZSguwbClSpUeUU=
X-Received: by 2002:a05:600c:4515:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49cf8273002mr102810145e9.14.1788597269886;
        Sat, 05 Sep 2026 01:34:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7736132sm129132885e9.12.2026.09.05.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:34:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 6/7] bpf: Assign lock identity to callback map values
Date: Sat,  5 Sep 2026 10:34:14 +0200
Message-ID: <20260905083418.3723623-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905083418.3723623-1-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5108; i=memxor@gmail.com; h=from:subject; bh=WlqzBOve5EbVJ4gzRvzzHFx1h83SL7E/5QZwpzuTfSA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2pQJ35x3X8ueoLp0dV/EhOF7wLdeF47mBd3aZ6Pz2n bZsQuPpjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzELJqR4Zvtlx3fNR+nTp/+ dq4JR1HS/KW33paG35OtfRLfyxbDGMvw38HF9JDF/XuPgnrm9Ozhfzl/tbtGtQvDt3v5v5Oe78n 7zAwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier identifies the allocation containing a bpf_spin_lock by the
pair of the map pointer and register ID. It permits ID zero for direct
map-value loads into single-element array maps because they have one stable
value.

Callback frame constructors also leave map-value arguments with ID zero,
but their maps can have multiple elements. Consequently, nested callbacks
can hold two distinct elements of the same map with an identical lock
identity. The verifier then permits a lock acquired through one element to
be released through another. The same confusion lets graph kfuncs operate
on one element while another element is locked, allowing concurrent list
corruption.

Give lockable callback map values a fresh ID in the for-each,
timer/workqueue, and task-work frame constructors. Keep ID zero for
top-level one-element array maps, whose callback argument and pseudo
map-value load alias the same stable allocation. Maps without locks remain
unchanged, while copies of one callback value continue to share an ID and
support balanced locking.

Map-in-map lookups need additional care. Distinct concrete inner maps share
the verifier-visible inner_map_meta, so a one-element inner array otherwise
looks like the same static allocation. Preserve lookup identity as map_uid
for lock-bearing inner maps and consult it before applying the ID-zero
exception. Restricting UID propagation to maps with identity-sensitive
fields avoids making state pruning conservative for every inner map.

Fixes: d0d78c1df9b1 ("bpf: Allow locking bpf_spin_lock global variables")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c797cc3df40..ad14a7fbed72 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -448,6 +448,13 @@ static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK);
 }
 
+static bool map_value_has_static_identity(const struct bpf_reg_state *reg)
+{
+	const struct bpf_map *map = reg->map_ptr;
+
+	return !reg->map_uid && map->map_type == BPF_MAP_TYPE_ARRAY && map->max_entries == 1;
+}
+
 static bool type_is_rdonly_mem(u32 type)
 {
 	return type & MEM_RDONLY;
@@ -1926,11 +1933,18 @@ static void refine_map_lookup_value(struct bpf_reg_state *reg)
 	if (map->inner_map_meta) {
 		reg->type = CONST_PTR_TO_MAP | maybe_null;
 		reg->map_ptr = map->inner_map_meta;
-		/* transfer reg's id which is unique for every map_lookup_elem
-		 * as UID of the inner map.
+		/*
+		 * Concrete inner maps share the verifier-visible inner_map_meta.
+		 * Preserve the lookup identity only for embedded objects whose
+		 * verification needs to distinguish concrete map instances. Doing
+		 * this for every inner map makes state pruning too conservative.
+		 *
+		 * Each map lookup has a unique register ID, so use it as the UID of
+		 * the inner map.
 		 */
 		if (btf_record_has_field(map->inner_map_meta->record,
-					 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK))
+					 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK |
+					 BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK))
 			reg->map_uid = reg->id;
 	} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
 		reg->type = PTR_TO_XDP_SOCK | maybe_null;
@@ -10036,6 +10050,9 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = caller->regs[BPF_REG_1].map_ptr;
 	callee->regs[BPF_REG_3].map_uid = caller->regs[BPF_REG_1].map_uid;
+	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
+	    !map_value_has_static_identity(&callee->regs[BPF_REG_3]))
+		callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
@@ -10132,6 +10149,9 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
 	callee->regs[BPF_REG_3].map_uid = map_uid;
+	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
+	    !map_value_has_static_identity(&callee->regs[BPF_REG_3]))
+		callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* unused */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
@@ -10250,6 +10270,9 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
 	callee->regs[BPF_REG_3].map_uid = map_uid;
+	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
+	    !map_value_has_static_identity(&callee->regs[BPF_REG_3]))
+		callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* unused */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-- 
2.53.0

