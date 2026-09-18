Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D53659FB
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709354; cv=none; b=qOy6aCl0StAWi0idBFSfCAoeLRYnwifdrRSw5jlfr5KlWPpOT8qODBZSoaACk+8QhCq8XlUoYr5B3B7LwqC5xOC8vDLAoQsdWP7iH9tUW7gCruqlAEq2UD7XIQ+ZqUvkJVdjJqcSrc8KX+7K2UeSw0LHPIvWivEJ6i2pe89MQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709354; c=relaxed/simple;
	bh=/QkcFvYOaIkQQPlFz569H9s6J5Myw3GV2PMzoTk2kVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN2O44L7PGapRdyGD5lrNxJtMQB56S9IjpffmHz9DnILxEOa8zydsRryan9YESJannFn9jVFp8u83l1Jp+iE1Yfo6JNqKmhO3RKQm7XsHCAEWByCNtq1zN9n+xrjB35164Oie/RH9Xy3KIiiE+fCLaDnGyXGFMVJeLStYOQbAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz49J5ek; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz49J5ek"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48437cc1b11so46997f8f.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709351; x=1790314151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CCMlKZWsLTGK4PThGdA5a/3un4cTXT8IoR5l92DIxRk=;
        b=Iz49J5ekGN+tO07q8ILnEh3SARLM7fOS2X/m4mvA6H8f//KiQB4KU5/70B4rTi0GzL
         w1o2iJNdrrjPkvUuUMkY9/UDqnQR+CLAmjOO+I3bwM6IQG3+oAogmiIoaZdl5l9gwFKK
         hv3vprOvrCb3ATu8hDTl/2yT+TnmFHRIE04uAVGq0X4Z2ZZVjObvBs4dDTKQGefqJ3XN
         31ZG80TyO7dk69Jlj/6qVj5tc9LlW/EM1soBfIk67hP2QPypV1HUFTFaRAUL04FWR9rh
         nWgzLf9oLzj3oC4hO0gnsa5CAZPgWGYybW0VUb7NMeVOor2fKruO+gpOigviGFfIBVii
         Xrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709351; x=1790314151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CCMlKZWsLTGK4PThGdA5a/3un4cTXT8IoR5l92DIxRk=;
        b=aUPFCAMCdTxi9cuskh1CCmkxWRrQLuI2JvCOMeI43q/f65ZueXTd7QrFHC7dQ/XdO9
         jqzKJrjbVJIQdIwCtw2os8eXsWWsFl/r27xSea4t+xa9+z1ZyQV9FrbMWSoJ/YEEE8yt
         H32/hdk2Qkx48DxFmEUxve6JaNKJzZi3sfaie69zG9q8CWU6/nUeNDcOVX0TDc/rT7zY
         HQoNDMehhnFwAz9Cj/cPMdjaJWYyd7y+AqHMpxPnVrwZXOQGklqde7URo7gSrhPIAP3R
         3iX4XcLwTdtcMuPlmsbGO9+XfMauZNnpCArMkLquAEi2F1RJ2T7VAeKYNEXic7vysW4k
         rFcA==
X-Gm-Message-State: AFuF++lFZamO+sZHfScKLH+VUX8CvZlp3aCP3yeC4IkBMDJU8jGLr0nl
	DBmKFsx83334jVwePIa2WR0xgT4QsgZUUrIwD5Cm5YlfXCowdYf1efwfJWdqnRvx
X-Gm-Gg: AYBFou19q83jq5xOmyMa0xIlmRd576O1vRSsKlpVyTPsCVHslGIcPWXjzPyBzSy83FV
	OrDo6xCVREmS424eBjgm5+5VZszYo7alP31AJ9TaSVoYQe8ixWtDjlyl7BqnI9PwIOcQ74wMgqJ
	lARWR7e59eMJ++ypvHRkYN67I4AvsxwMc/qItJcqWyitzPikomePZXtYRSNQGxOMgO/hFF+ES3P
	XRmLWQ0cEeZXueKXGNDLx+yp5sGAMQFCrWj/13GNxDqQrfXpni0le96hSD8qJkQn6jXlDbtTjup
	TcIA7UE6pXY6V4tX6mTQ7CDdWmi7+u4tpNkLQVCXoHVCwuArDQgI/JV/LDhjK/HMP564jXGNe46
	xMkcjIUMkQXxmArJKRMO+/Yqh274I8rbXJ7/W39v50b/isy1fDeak5QqVd/Dloe8+IQARb16EIy
	eKPMS95TZ8u5rsXoRo1xB8yC9doe+FD/gvHgf2nbxbVWTJsx1+isFSkCUOUKVrV0wQMDLzGTxdL
	59+4tVIyN+MrTrUW3YzIPP82vsEkJmQzeqgEFBCprjBD88JE1Kn7Fd9eyzbgmV6MwQQxHGm+orP
	AfVo7092PyXW8/c0evkb3YaubZXNcOjLmq6pHQ==
X-Received: by 2002:a05:6000:186a:b0:487:89:bf74 with SMTP id ffacd0b85a97d-4871e3730f8mr1404454f8f.51.1789709351242;
        Thu, 17 Sep 2026 22:29:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5d63sm1334809f8f.3.2026.09.17.22.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:29:10 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/8] bpf: Record raw memory arguments during argument checking
Date: Fri, 18 Sep 2026 07:28:56 +0200
Message-ID: <20260918052906.12226-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918052906.12226-1-memxor@gmail.com>
References: <20260918052906.12226-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3764; i=memxor@gmail.com; h=from:subject; bh=LGW+Ty0bG7bICAESY89qIlhJVsawkXH60M6OisA8ih8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvN6ZeHXt70SRX+dcXk1Df7u50BP5gX+d2Z++/h4j7vi jMs8ZvudpSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAicXcY/sq+izjk2u8pfrox 4lvfTdOzFzewpQQkuH1Pejwz5NbB+ecZGS7urlgquG/ZVD/Jn3vMg/qKJuim3j8W9vE1x7f6pRW tutwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Record meta->arg_raw_mem.regno in check_func_arg() instead of
check_raw_mode_ok(). This information would be used by the patch
fixing MEM_UNINIT handling for kfuncs further in the series.

For bpf_map_peek_elem() on a bloom filter, resolve_map_arg_type()
does:

    case BPF_MAP_TYPE_BLOOM_FILTER:
	if (is_helper_call(meta, BPF_FUNC_map_peek_elem))
		*arg_type = ARG_PTR_TO_MAP_VALUE;

That replaces the entire type, removing both MEM_UNINIT and MEM_WRITE.
Recording the resolved type makes the later raw-mode clearing
unnecessary.

In the check_mem_size_reg() only clear raw mode for a variable size
when it belongs to the recorded output. An unrelated memory argument
must not discard the output's identity after its initialization size
has been recorded.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cd..1d5e4ee64fc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7215,7 +7215,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * raw mode so that the program is required to initialize all
 	 * the memory that the helper could just partially fill up.
 	 */
-	if (!tnum_is_const(size_reg->var_off))
+	if (!tnum_is_const(size_reg->var_off) &&
+	    meta->arg_raw_mem.regno == reg_from_argno(mem_argno))
 		meta->arg_raw_mem.regno = 0;
 
 	if (reg_smin(size_reg) < 0) {
@@ -8929,6 +8930,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
+	if (!meta->btf && (arg_type & MEM_UNINIT) &&
+	    (base_type(arg_type) == ARG_PTR_TO_MEM ||
+	     base_type(arg_type) == ARG_PTR_TO_MAP_VALUE))
+		meta->arg_raw_mem.regno = slot + 1;
+
 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
 		err = mark_arg_precision(env, argno);
 		if (err)
@@ -9018,14 +9024,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			return -EFAULT;
 		}
 
-		/*
-		 * Disable raw mode for bpf_map_peek_elem() on a bloom filter. The helper reads
-		 * the value buffer as an input rather than filling it.
-		 */
-		if (is_helper_call(meta, BPF_FUNC_map_peek_elem) &&
-		    meta->map.ptr->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
-			meta->arg_raw_mem.regno = 0;
-
 		err = check_helper_mem_access(env, reg, argno, meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta, NULL);
@@ -9842,8 +9840,9 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	return -EINVAL;
 }
 
-static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
+static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
 {
+	bool seen = false;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
@@ -9851,9 +9850,9 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 			break;
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
-		if (meta->arg_raw_mem.regno)
+		if (seen)
 			return false;
-		meta->arg_raw_mem.regno = i + 1;
+		seen = true;
 	}
 
 	return true;
@@ -9985,7 +9984,7 @@ static int check_func_proto(struct bpf_verifier_env *env, const struct bpf_func_
 			    struct bpf_call_arg_meta *meta)
 {
 	return check_arg_prog_aux(env, fn) &&
-	       check_raw_mode_ok(fn, meta) &&
+	       check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
 	       check_mem_arg_rw_flag_ok(fn) &&
 	       check_proto_release_reg(fn, meta) &&
-- 
2.53.0

