Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAB3CC313
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709356; cv=none; b=KyZeOKHrQsPCrj3OVJplv4AVdk3nQC006KAG17WL3wlHyhVJFnb76B7B8DNk+hexY5C5IaZyJdP/rlZamKAvuqeN6ElU7lwOkCSDjWIXSa45Nhl9vZxzS+yWxwKziOFDJVl50FaOYiNpCXF++ybRKn7rAVIPp345fBrX9ZiSW4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709356; c=relaxed/simple;
	bh=X08kWp8jmhMiEQVbjvhfh5vLI15KXvtgbw09urQ43+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhsEYD5kPnotieJt8/p1iTDQMykxkKdCtfWoKE7KWKU9bszJiqDVrRnWlLG6hY/t4TosclqjO99BYbBqt5EQTALtfgXcJqkG6B4lIVCq9rMgAcqLJ8za1+5B5BtUrFN7GeT2Q7ugjY3gA56ADc1CrgJpiQIXmQtzWszBveqsKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr2J2vFG; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr2J2vFG"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so172543f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709353; x=1790314153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sgezfLhyLKmvB/l7AUCFMgxBolD3JzSsHKTErSFZewg=;
        b=Tr2J2vFGtUpAXyApKSZ5sN+ltPYznMnvhQ+lKTcVfWaUgvX8sQh74iTMeu7cVkmBSA
         XFNnrQoYU6DLzto0dhHmEBsP7TrrJ7sHs01mn7Lna1wUmI4hv+rDZFSSMHfekhCTMf1D
         gi7zqJbkXsq4gqyTho/g8017bVuKr/HDd4ZVbtbR4SDnNQI55Or9zd73js+X6Y2VnB63
         DTUi2muqkJBv/BElSFeEe3x5M6JD6WsVP+91NwkFU+ezZEy66q85INwSuc6hLVg75cJU
         wm+MdkETlhzStW6NPb729svU8Bv4xRzrTVi+PLAYnSaIRFyCmsIWsHOqJ5rEzX8ZU+rm
         D5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709353; x=1790314153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sgezfLhyLKmvB/l7AUCFMgxBolD3JzSsHKTErSFZewg=;
        b=RZWOuJTQgSi/9JmGiX7d2eK30TxcpWa/JrjhGNJ5qpeW6A277xD3fAnleDWbflmhYH
         NBbYS5TJ836hAS4Zq+Q6RacR93hfw5nLVA+0xct8UN+kxMOS/6on7zapiS0RUPkD6lTF
         p1YMSCaqU4DywQJi1U8MmnF+aoLh3nU/B/vNUJhU1PyGCo8FTXpkaf+rFxAbjeNb46cM
         uzScdX0EVbugbtw9OU3SXYxxAyA4EC5dOksKBq+kS2bcPrVSbvHN6YNy4P0RcQ83LVcN
         bR1QnyHodEDJrlr6/1T5JOu8ksloMrKbrMC1qAyZU/iuBJGVDvvzhgCbjRsyHy9K37Ij
         nSyQ==
X-Gm-Message-State: AFuF++mollA00ENe9pR+JHI7y7zczX4k75HlIgpbTUH7XxiFxccW0o4t
	nSGBkxD/lFwgxniCBnZi1INgMa50hVD1ogrwt2WDhXWoIxdOr+TBv/mUkcoflQO1
X-Gm-Gg: AYBFou3T0k5cxN6dTCkygIA3CMXc9p7UdS5idKNez1hgopbe2PTBxbuskGVEEARD86w
	dDe9b74cDNUpi+v0VlkgGPbPgoZucvKgpR7PHhLU/aMrZ93Vgp+CbMP/INHFPkub+1bCZpcs4A6
	WYO9QtrQoNgXAJ3gn4Hs8kv2fCOU9ErbyhRYvQTo/ssRcmoo6wtkgWaYVSOZfZKqNt/L/vhzm/D
	V3+9QNdiIi6dXmCB2JElYyaqNy6Kzv/rXfFFzESo/3b60DsbywzNiWdu7l12jYdnWS/XvcyYA6K
	U167MVms9+6SXQOQYiU3Vq4spEBiUkmUK8LVYAxevIUM6HJ2ct9e7oam0II43hL3SJd6+nX8CcA
	Uxu2LNVeUav5fZno5aVonqXia3o90hFLvPPGMsK78RsLY581QD8gnjGkyk14qN0xaqcDIj3nGJI
	nw5k1TWGRgjWg06mF6xihqkLkBLIuFTloZA1foGdAwoqKzdaRHnDnYcL9LtTXKbvJ/0x8lL9b7p
	byhWiCziMqiwTL7SZXZwvBOZiizCHo9y2WABS2kYCCKzLbFSs5YGwZwCn9DKiBC1QaPvpR7qcf3
	KMZrIAoqNsd8zSQtr9oZsfateKUaNtwyIdn/CQ==
X-Received: by 2002:a5d:64c8:0:b0:487:1084:10fb with SMTP id ffacd0b85a97d-4871e395fcemr1596298f8f.36.1789709352839;
        Thu, 17 Sep 2026 22:29:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff56411sm1253929f8f.21.2026.09.17.22.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:29:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/8] bpf: Check read access for initialized writable memory arguments
Date: Fri, 18 Sep 2026 07:28:57 +0200
Message-ID: <20260918052906.12226-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918052906.12226-1-memxor@gmail.com>
References: <20260918052906.12226-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3854; i=memxor@gmail.com; h=from:subject; bh=BtbPTp3bvsW1TxjvDUqlQOTdttaorz0OJx1tLsRqAM8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvN6Vdz676m3zxsrvpwbdvC35ev742Uzp1zguFSFw//H r8FVuf7OkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRr58Y/koL//wfwMR85zbX MfX3G3LTTlnryD7jvLQmctfc2foHyyUYGa72+9i7nbz3iO8Lg+nUZX/f+8k0bpkme02H60hw/OK gHwwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

MEM_WRITE without MEM_UNINIT denotes memory that may be read as well as
written. Helper argument checking currently requests only BPF_WRITE, which
checks stack initialization but omits read permission checks on map values.
For example, bpf_check_mtu() reads its mtu_len argument before overwriting it,
but the verifier permits that argument to point into a BPF_F_WRONLY_PROG map.

Derive generic memory access from argument flags: read-only for inputs,
write-only for MEM_WRITE | MEM_UNINIT, and read/write for MEM_WRITE alone.
Encode MEM_WRITE when classifying kfunc memory arguments and resolving
scalar-only struct pointers, replacing the kfunc-specific access override.

This rejects write-only map values passed to helper arguments that require
initialized writable memory. Generic kfunc __uninit output bookkeeping is
completed in a following patch.

Fixes: 8ea607330a39 ("bpf: Fix overloading of MEM_UNINIT's meaning")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d5e4ee64fc0..21eb806b1351 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8886,6 +8886,15 @@ static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_stat
 	return 0;
 }
 
+static enum bpf_access_type func_arg_access_type(enum bpf_arg_type arg_type)
+{
+	if (!(arg_type & MEM_WRITE))
+		return BPF_READ;
+	if (arg_type & MEM_UNINIT)
+		return BPF_WRITE;
+	return BPF_READ | BPF_WRITE;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 prev_slot,
 			  struct bpf_call_arg_meta *meta,
 			  int insn_idx)
@@ -9180,9 +9189,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		if (!(arg_type & MEM_FIXED_SIZE))
 			break;
 
-		access_type = arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		if (meta->btf)
-			access_type = BPF_READ | BPF_WRITE;
+		access_type = func_arg_access_type(arg_type);
 
 		err = check_mem_reg(env, reg, argno, arg_size, access_type, meta, &known_memory);
 		if (err < 0) {
@@ -9228,9 +9235,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		if (meta->btf && bpf_register_is_null(buff_reg))
 			break;
 
-		access_type = fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		if (meta->btf)
-			access_type = BPF_READ | BPF_WRITE;
+		access_type = func_arg_access_type(fn->arg_type[arg - 1]);
 
 		zero_size_allowed = meta->btf || base_type(arg_type) == ARG_MEM_SIZE_OR_ZERO;
 
@@ -12436,7 +12441,8 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | (*arg_type & PTR_MAYBE_NULL);
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
+		    (*arg_type & PTR_MAYBE_NULL);
 
 	return 0;
 }
@@ -12933,7 +12939,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		arg_type = ARG_PTR_TO_MEM;
+		arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
 	} else if (btf_type_is_struct(ref_t))
 		/* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
 		arg_type = ARG_PTR_TO_BTF_ID;
@@ -12958,7 +12964,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			return -EINVAL;
 		}
 		proto->arg_size[arg] = type_size;
-		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
 	}
 
 	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
-- 
2.53.0

