Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B93BFE50
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621631; cv=none; b=dt7u/OcJVDuMU6+pkM2Z38NdjSQXXDT46mMZCwq2Q/5tDfzLANIidP5AonI8PUAAKG6griPGMiwstjlcDw6fLNoAwMcfWviEnDH2vfE8Cib5ifyQsnzW6NDiUB8PVLVwrzhl/jLd3iZF2Xt+u13rvFeGWq3qCYxkTopE379TdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621631; c=relaxed/simple;
	bh=ibD5dq2qejDCkKGodlbUfJPU0DtINVdBaVZYHRD6pQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xq3WDFRqSZx3uOOwZ0/7LUJFlohNulpSysxGKMSp7ghThZZ+YB9VzYNx63VLyzAZKGxzZaf2JLVJ6M1GRvpkKy/j3bhmuur/79pPoGYljVCO59IYUNEIHpQ8K1Ay0Jacfskh4a1hmJQXuiH5t1F5BQaAL8/puDiParNmD6OeKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilsb9p0N; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilsb9p0N"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c4923c9429so1684332b6e.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621623; x=1791226423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y9BGL/bdq19tzcfdzPyjvl/GXdRIH3G0r2tlJ268v2s=;
        b=ilsb9p0Ntv0YZSspuJpE/jOzr4ir4XshFfEE6ISRY9+BkoNxrV4iEQJcFTaCrdEY0G
         QooI2skS6Zb80K48MF3XTXBEqI4RfpKpUKWvSXyUsJDUiJXTOYsqznVS+qDPyq7AIlEw
         /vGAD+afj5AQRtFX/7ljw/DYzfI/K3XXcM5F5J/HQwoBDIlAqu/ppQjNlT8Jr+6SbDMz
         l4TRaGO0lIE06gKJOoDN+HHKZSplNfleOHdMUmyq60afONjwdMkaQU9ODXEl+PiABilA
         lCRHvQ8RtR0y/JbOk8WIiWZwUbGienFtFzcPGCAYwUZGapw5bP8mJ8cSDv5KHXb6LRau
         NckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621623; x=1791226423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y9BGL/bdq19tzcfdzPyjvl/GXdRIH3G0r2tlJ268v2s=;
        b=mliwRyLvZ51cQOe2P+JN6aUJc6Khs+IK+IW2Whpd49vHI23Cetw+WVWnx1yuLDxCvv
         aF9/EOGmpdaOEme2lchQbKhD6QPkYM3NhIoxY0KbtwwzS8FhO0We64Na9lPmzei8O0js
         I6b/v3Z4se5bPX1abSWUMuwID9vB61qqhRZuY97W+BsEEcJORFhE3AO20KP2bfXtTULl
         GjF0ETtqdmPsJ397s2yR26607mSQFCmZtE8qQymwk5HV3gE0Ndg7+o3ehizb1gbBcVml
         qnlJfB3vlM00Vnvpj9Fug7rWcUMFTlde5qz0bE/6oJaqhJCdecdHY7uaKDY04ruZkZBp
         BO8A==
X-Gm-Message-State: AFuF++nsyu6gGEwb9dcJa7dv4sptMqQdvzJwLX+bXXg+z5vazaQ8MWGF
	T0AqqTY1GDonQqgT8SjkB+d9SclDvtRFRuvU5z7o1WTqR245tRRDLKdFhCWt7Q==
X-Gm-Gg: AYBFou0ApuUuk0hh5pyFd67saYaOtX3oCoo1qbOAi2s1n5XR4YBJQZ+wgMnG6El6e0l
	yqhAEYbxr2RMpG/GNjPEHyH3souL/j9fHnwd/tGpRBsyXol6mDEI2WIyIWNFXjJoKM+z9L+eDr1
	O+EwblRWRisxSgUB5PCr3eoIOPb645tmVI91MOYT+gDmKSgK5XbqTRX1uQSvfoSTfOc3x3asllO
	xcjCvgN1NJyB+qPJVeGdMp349o22hvAc7hZiAztVUwS4iV406iIGBkKrWR2pz2/ojF5Leue3Yv9
	OsxClNphedayvydEGrbdkZPfoo9xGhBdpp0VKUFF/U5B8wt/X+SNdoIAy0zV9eal6Aq/69F+s+6
	lePxAxJGBZQGCm1fda7dBh9ADFhu4cx/ws9odl0BVzueJExGHaBbC9YET11IJdSqiPKZN7xs7Oz
	P9vYwBlFuslOKfrsKZ1DPbhLUwt7H0QChgpVNzBc2r58yMaEYXNKodfHEz31B99Q==
X-Received: by 2002:a05:6809:290:20b0:4e7:dc61:f509 with SMTP id 5614622812f47-4e7dc620425mr3308837b6e.40.1790621623536;
        Mon, 28 Sep 2026 11:53:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebbd3520c1sm2243792b6e.17.2026.09.28.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 05/11] bpf: Check global subprog untrusted arguments in the common path
Date: Mon, 28 Sep 2026 11:53:28 -0700
Message-ID: <20260928185334.1004200-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928185334.1004200-1-ameryhung@gmail.com>
References: <20260928185334.1004200-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global subprogram arguments tagged __arg_untrusted deliberately
accept any caller value. The callee is verified separately with a
read-only untrusted pointer, whose accesses use protected probe-read
instructions.

Keep the untrusted type in the canonical bpf_subprog_info used to
prepare the callee state. Represent it as ARG_IGNORE only in the
temporary bpf_func_proto used for call-site checking, then extend the
guarded check_func_arg() path to cover it.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3c7c1aa0573..79b9e7242fee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10806,9 +10806,18 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 
 	memset(proto, 0, sizeof(*proto));
 	for (arg = 0; arg < btf_type_vlen(func_proto); arg++) {
+		enum bpf_arg_type arg_type = sub->args[slot].arg_type;
 		const struct btf_type *t;
 
-		proto->arg_type[arg] = sub->args[slot].arg_type;
+		if (arg_type & PTR_UNTRUSTED) {
+			/*
+			 * An __arg_untrusted argument accepts any caller value. The
+			 * callee treats it as read-only and uses probe-read instructions
+			 * to protect against invalid memory access.
+			 */
+			arg_type = ARG_IGNORE;
+		}
+		proto->arg_type[arg] = arg_type;
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
 		slot += btf_arg_slots(t);
 	}
@@ -10871,16 +10880,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
 		nslots = btf_arg_slots(t);
 
-		if (arg_type == ARG_SCALAR) {
+		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
-		} else if (arg_type & PTR_UNTRUSTED) {
-			/*
-			 * Anything is allowed for untrusted arguments, as these are
-			 * read-only and probe read instructions would protect against
-			 * invalid memory access.
-			 */
 		} else if (arg_type == ARG_PTR_TO_CTX) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_CTX);
 			if (ret < 0)
-- 
2.52.0

