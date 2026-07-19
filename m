Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB243A0B05
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475400; cv=none; b=lAoIzTTXlucfTG4/AP2gTiFmS5vmSGUb0EhdpdYeJbej2Pad1yl3BstuK6dBIUo7QRFH8ghJbthe4btH6mJafayne6mSr9WtDEAma1GeMsrDqCgTrFfnU6+7Foy18j40NV54Aig0RncJ2QyZznAejac3Z02Yx/IAIQjTWisMVb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475400; c=relaxed/simple;
	bh=zKia3Cdvt1uzcEmaVeuvlZNp0Y7WYjddfeALCFQqbDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cL5UCfk69REVrZN2vl/pD/dNNwcEyIaSVQo4jwk2lvduL+i0ntzKii94c8E7GwyJXS+/nX12Y49FLybOdlYaJAyUaVBqMHyftZxA6tQDoU7o1itFoeaTHZikwTU4HA/TZ0WzdQDVN9sG1zS8Dkd9vBsB4pU9n60vZSi+fXHZQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGb29yev; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGb29yev"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so1356645f8f.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475397; x=1785080197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozx2jIvkeaIBpsk5EHBRBchKjLw2UWi+nMANXvWDy+0=;
        b=jGb29yevT6s3n7i+eadSlFSQMGKHQdoRLg0KSZrWo7XXJuImpP18ZEdLGJ7T2f0q+W
         Zji4H31s417s7MZhVBjcbdv+MXjICQYGJcalLj1o/RgMQJ7PoVMZM6JkCrNsBhNQCtqf
         LGrUoZeQdlPgf8HgQhjcqcF1P0EWEFgCiVjA47XuNddNgfMLhlXCdcp7m/suGhBAbZrS
         A//XHm2dtyvZxNzHokLMnbK2MBm5GXYw+ox3Z982YONe0vtP6W+FeATte5tAtnQuJZ1Y
         In411vZg3Dbj5dVRooLvjMTWzdG6/WdPOclnN4FxUyIVTMA6ulN6JcVefZUdWURdqSmg
         CwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475397; x=1785080197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ozx2jIvkeaIBpsk5EHBRBchKjLw2UWi+nMANXvWDy+0=;
        b=sVnD6QiXDfF4aivpqTmQcC5w871cqrBAVEs5llSNQA64pPHoU/Vz2PL2HfhecXwGJ2
         YVKgTAzNEszT+dmHpwdJ9hpM4M/zK7JHnQ37h74MrG0hz0KqPEIEv6IPWEk/wul46wQi
         Efh2I2kcot8+8gQK/I38NSfjSKVH4tqbw/wXgBMZ2qvsUwAm8z5+u0hK4IbIUjiq8FW9
         jdd3q62tP7HjYA1IyHFrcytYKbADYXhb2gXrdgT7ZuxOMu6uqeCmkDa8L/OK8JFcntR+
         ZQSXr5GwjCwCdz26mzrPkg+oHo3v1Huz8A4rH3ZFfixsbany+jv/Eq+XCw/dJitFpDDB
         NdRQ==
X-Gm-Message-State: AOJu0YwsrQiyNS2lJAk33S9znCmc19lhoHB1QW0E9lAAZ14Uvf/BaJNd
	IrRAKsnRHT2aPLXS3U9Lh1sXvef5WJbc4Of/sQT7lTFno0lsLV4AsKA4SvMEXl8x
X-Gm-Gg: AfdE7cnB0Ppt/jMj4+YeF2QwfcrPCoiY1D+pyxBqSsTRYktfEXJoj+okYuXjZiPs/PU
	eo+URlr9K9KrOl6VbaiN5ybqdBa2G7a5XQ5crgTtXU2flSr3XO7n+w/lUdsk/hqYdsDF3HKbG2I
	smZz5mRtAcELN5Wz65PGacehHVMIrfCsYwLMBg2GGOFd5KmDWQT9cVUJ162XLl+gnszaLrOAdqb
	SQzsWIWqYbyjXjHMhurTPVAk9CM6Kz9iW4Bx8j9v4u5r/Cdct3JYuSguLa8PnHxFP/wyi732N1e
	2PSa4mkUOb0rLQJbmdUXY3467VqstMEqocw85YVY7aOGyekQ04Kf4e6TC+YkwKTpUbO7Jvo828w
	dVsYWnX59hExhzixCKf8rBzjm2BdvzhpV3fZP7szYbw5OPrYyFz7T9iIYSaoib/YHaOizo8t24Y
	SBv33NFKJ/4mCM9fNTZ09un/J75bdvwfaw7On2Ni+VfmW+0xmBdbKQ7Ve35dfGQ0oZlYSXqx/Ps
	LJpDldkH0pyCp11fyT4Ae2Yd4IgYZosU3smFcpuoEAI
X-Received: by 2002:a05:600c:3143:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-4954a3d0cd7mr124931165e9.2.1784475397270;
        Sun, 19 Jul 2026 08:36:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955370d78csm97505835e9.12.2026.07.19.08.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:36:36 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/5] bpf: Preserve unique-field state across nested structs
Date: Sun, 19 Jul 2026 17:36:29 +0200
Message-ID: <20260719153634.2908692-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719153634.2908692-1-memxor@gmail.com>
References: <20260719153634.2908692-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4641; i=memxor@gmail.com; h=from:subject; bh=zKia3Cdvt1uzcEmaVeuvlZNp0Y7WYjddfeALCFQqbDk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvmlfjvLq1fBtwfvjFlpOiyO6yZUHPXQvpem8nHZa/ed 7+zNNjRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImUnmRkWJVTZNV+Vvjoz/Dd fxQauEVXvL8btid+89KsX3y5O7ZvMGD4Z3o6SOC8pyfDK4YIzaPWX/2FLbLEhOrkow7+0FIVFeb lAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

btf_find_struct_field() initializes a fresh seen mask for every recursive
descent. Unique special fields in different levels of the same aggregate
therefore do not see one another. The duplicate fields can reach
btf_parse_fields(), where they trigger an invariant WARN_ON_ONCE(). A
crafted user BTF can consequently trigger the warning before map creation
checks capabilities.

Initialize the seen mask once in btf_find_field() and pass the same pointer
through struct, datasec, and nested-struct walks. This gives the entire field
traversal one shared uniqueness state.

Fixes: 64e8ee814819 ("bpf: look into the types of the fields of a struct type recursively.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7d4e9ba24e2..c577f00e9d88 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3751,7 +3751,7 @@ static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt,
-				 u32 level);
+				 u32 level, u32 *seen_mask);
 
 /* Find special fields in the struct type of a field.
  *
@@ -3762,7 +3762,7 @@ static int btf_find_struct_field(const struct btf *btf,
 static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *t,
 				  u32 off, u32 nelems,
 				  u32 field_mask, struct btf_field_info *info,
-				  int info_cnt, u32 level)
+				  int info_cnt, u32 level, u32 *seen_mask)
 {
 	int ret, err, i;
 
@@ -3770,7 +3770,7 @@ static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *
 	if (level >= MAX_RESOLVE_DEPTH)
 		return -E2BIG;
 
-	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt, level);
+	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt, level, seen_mask);
 
 	if (ret <= 0)
 		return ret;
@@ -3827,7 +3827,7 @@ static int btf_find_field_one(const struct btf *btf,
 		if (expected_size && expected_size != sz * nelems)
 			return 0;
 		ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
-					     &info[0], info_cnt, level);
+					     &info[0], info_cnt, level, seen_mask);
 		return ret;
 	}
 
@@ -3892,11 +3892,11 @@ static int btf_find_field_one(const struct btf *btf,
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt,
-				 u32 level)
+				 u32 level, u32 *seen_mask)
 {
 	int ret, idx = 0;
 	const struct btf_member *member;
-	u32 i, off, seen_mask = 0;
+	u32 i, off;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
@@ -3910,7 +3910,7 @@ static int btf_find_struct_field(const struct btf *btf,
 
 		ret = btf_find_field_one(btf, t, member_type, i,
 					 off, 0,
-					 field_mask, &seen_mask,
+					 field_mask, seen_mask,
 					 &info[idx], info_cnt - idx, level);
 		if (ret < 0)
 			return ret;
@@ -3921,11 +3921,11 @@ static int btf_find_struct_field(const struct btf *btf,
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				u32 field_mask, struct btf_field_info *info,
-				int info_cnt, u32 level)
+				int info_cnt, u32 level, u32 *seen_mask)
 {
 	int ret, idx = 0;
 	const struct btf_var_secinfo *vsi;
-	u32 i, off, seen_mask = 0;
+	u32 i, off;
 
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
@@ -3933,7 +3933,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 
 		off = vsi->offset;
 		ret = btf_find_field_one(btf, var, var_type, -1, off, vsi->size,
-					 field_mask, &seen_mask,
+					 field_mask, seen_mask,
 					 &info[idx], info_cnt - idx,
 					 level);
 		if (ret < 0)
@@ -3947,10 +3947,12 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 			  u32 field_mask, struct btf_field_info *info,
 			  int info_cnt)
 {
+	u32 seen_mask = 0;
+
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0);
+		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0, &seen_mask);
 	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt, 0);
+		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt, 0, &seen_mask);
 	return -EINVAL;
 }
 
-- 
2.53.0

