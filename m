Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929D6DCE1
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149589; cv=none; b=T98ZL7bVq9iIzShz9Lebx5CgxWY9Q8cTD5mOtq6iL7d6Rs6fHRdy9SO+rpVTRmmMmPYzUGkpoBRHPava4JOVW4A6h0QLJ1+sxRsDMeDm90Dr4lvDw/7Akp5j9o61ZfKbbBdIhBoTrwBdOp0zVfJbyG9B4VUFodwFUg1H/z989ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149589; c=relaxed/simple;
	bh=5+A5l+GNqbbV1HVda5gRF1Qxw9gPHU9idojKDOfaYTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9UIL95RCae34/iElr6coWgzSx13izsWSva2fY3A8ry3J5SwFduDVFNBYt6EPiac7esgrDdB2GbSZX5UHUu5E1t79hfg/pjfXpyKpN+M6NggYauH6DMhN8lwl7VKlj69AQGWt3A8ADlE+ZNxioazJ4XCXl/OtEeK3OBMr9CilQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nckk7Vg8; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nckk7Vg8"
Received: by mail-oo2-f4.google.com with SMTP id 46e09a7af769-7e9fe57f70eso57993a34.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149585; x=1786754385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y3ixyDgYppbI1ur77JNyXScjw0wR1IOQdlBVuDrZJfE=;
        b=nckk7Vg8djNurjyqu4H7eOfWsgYCg7kMTd84IVtQjXtVbGOuDj9MC/upDVWwHVSAMs
         dojaA6hmxxOxV+PEJwSwhkOPETBY6ncQMvVD5CWm4TiiUSYl3Bg9CmC2Nyq/XhghZScx
         nAG0DTOleiFPSktnNweJOsev6j+CEHvGqtzrRv248ltWMYmS6003Q/ntpBbeYyS/hxBF
         VtKFyO0YLz6crGD5kmEvFRye4mksHevIU+GJeWnX7Eyev5H/LBW3ZcGfSB/0GSjOHu1i
         lPHH7u8tP2BUbYvr9whjjWA9gAxmYbq3wS9de2P+aMUJTeEY4waP7BiB9dyXyFREz9EG
         WDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149585; x=1786754385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y3ixyDgYppbI1ur77JNyXScjw0wR1IOQdlBVuDrZJfE=;
        b=pmNwiKBcx5/vg8W9S5z4y6WSqOiWdlFzTk/F8crSyq6ikPjn1/FZvjX6AwyW6dmb86
         0NpMOoQqF2PwyxfhaUqfVzdJjNVU3rMdu/MhSV2Y9f7kZ/aqz0UP/VUDnd1iDUbNen8X
         woM4gzBsl6FWwHLNBnUFCOXgqAhazPRMnXGQ/wQUw+4/tngkiomL5zEZWy8Sdsjiy9oJ
         3MVsHMqmNLX2oZJD+XeQ++LsZduZzA80tPcxw894qWgERMYDNpbKt1QLioCu7XDLMGKO
         mjLBP3MT36h9KCpWE8G962iTpsSNza9NAqv0APC+GoxikOnIymi/DOSd2AfbBHhzmGQB
         jZSg==
X-Gm-Message-State: AOJu0YzeS9StvO5WPbkUDX431I7emYmyWqyhC+/wLXsQKGa5sSXd8/j4
	R1b73zpKcMhtOmPSdAuUrb0DbFi8kHW2hR2Zd/hqUma9aqZ/PUxieTW9NcXqHBoktwg=
X-Gm-Gg: AR+sD12hi9MrgAjqFN8NF67ZE73sY1AFbWzqy7wYBShASxyVrpIIp6jnlA5lG4EL2Fw
	oldpT3DirqwI5EFm5oc/kolJeW5Sz/TkeNwtBHrQl/EkJH48wQOjnbqzyr9pPE2GrFTjg7NrUKf
	PRRzvcX/Kf7KeEEkSf5vn4RuLBg/mpGNLzhJCrRAHu238KmVKvNGuUU0+0YCbIVz9eM2iDi6EUn
	4uVRyCw5567ZKD69gi9V/bso2efTaq2qqGRqoS4wgq2GSysw6kRxO2qKwSCDwG4WI+04BLFwwI9
	Yrz+QEOPY6WVCsjuYygQDGP5ffcYtGFjs56uZljxauH6t5X6YLs7xWfntk5SSR45TgnYzMPsdHj
	odGlQYh5Tu186K2CWVFav2fKQ6izieSd1XcmPALUzzsZJCdBcAj5QrvI82t7k1OKE/iVXteinzX
	6xhn8ZVWAkXoGUtqmb9/7A1uFYn0/RT16EJuVrpPP8Ry8co5DoNhhlH3M9lisMTzh6WnOCcJvhW
	XV3IGm9VUS1G/zJ08PCsb5oLLfjTbcSV0VXieN6yGtQN+24vJ4VPxA9SFtqx05X2qTUcuyeOTHE
	vIfubQ==
X-Received: by 2002:a05:6820:f011:b0:6ae:8ee6:38f5 with SMTP id 006d021491bc7-6b03505d077mr3821924eaf.7.1786149585237;
        Fri, 07 Aug 2026 17:39:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1d81fadsm3152125fac.11.2026.08.07.17.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:39:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 01/14] bpf: Rename 'early' BTF checking as a preparation phase
Date: Sat,  8 Aug 2026 02:39:21 +0200
Message-ID: <20260808003938.3486067-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3844; h=from:subject; bh=5+A5l+GNqbbV1HVda5gRF1Qxw9gPHU9idojKDOfaYTQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqqJdfrv4MzG7n5t3OE5IS2Wcp7Yt0eTv9LJ5Xa9Pypms dOHrKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESW9TH8Uyp897q3jcm4+Yb4gU/qv0 N9pkY7e62tFdjUl9FpoflqLSND76ao9Snhnv1avj8EfV5fz3FT/pxcllP/Jzfd8vU+ny4WAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

BTF processing is split around subprogram discovery. The first phase gets
program BTF and imports func_info because a BTF-tagged exception callback
may not be referenced by any instruction. Subprogram discovery needs this
metadata to find it.

The later phase validates func_info and line_info against the complete
subprogram table and applies CO-RE relocations. This split breaks a real
dependency cycle rather than merely running the same checks early.

Rename bpf_check_btf_info_early() and check_btf_func_early() to preparation
names that reflect this role. Add short call-site comments to make the two
phases and their responsibilities clear.

No functional change is intended.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  4 ++--
 kernel/bpf/check_btf.c       | 14 +++++++-------
 kernel/bpf/verifier.c        |  4 +++-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a2a40caca0a0..a9555d17fd8e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1177,8 +1177,8 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 		*btf_id = key & 0x7FFFFFFF;
 }
 
-int bpf_check_btf_info_early(struct bpf_verifier_env *env,
-			     const union bpf_attr *attr, bpfptr_t uattr);
+int bpf_prepare_btf_info(struct bpf_verifier_env *env,
+			 const union bpf_attr *attr, bpfptr_t uattr);
 int bpf_check_btf_info(struct bpf_verifier_env *env,
 		       const union bpf_attr *attr, bpfptr_t uattr);
 
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 93bebe6fe12e..0e8b3ccc7a5b 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -28,9 +28,9 @@ static int check_abnormal_return(struct bpf_verifier_env *env)
 #define MIN_BPF_FUNCINFO_SIZE	8
 #define MAX_FUNCINFO_REC_SIZE	252
 
-static int check_btf_func_early(struct bpf_verifier_env *env,
-				const union bpf_attr *attr,
-				bpfptr_t uattr)
+static int prepare_btf_func(struct bpf_verifier_env *env,
+			    const union bpf_attr *attr,
+			    bpfptr_t uattr)
 {
 	u32 krec_size = sizeof(struct bpf_func_info);
 	const struct btf_type *type, *func_proto;
@@ -407,9 +407,9 @@ static int check_core_relo(struct bpf_verifier_env *env,
 	return err;
 }
 
-int bpf_check_btf_info_early(struct bpf_verifier_env *env,
-			     const union bpf_attr *attr,
-			     bpfptr_t uattr)
+int bpf_prepare_btf_info(struct bpf_verifier_env *env,
+			 const union bpf_attr *attr,
+			 bpfptr_t uattr)
 {
 	struct btf *btf;
 	int err;
@@ -429,7 +429,7 @@ int bpf_check_btf_info_early(struct bpf_verifier_env *env,
 	}
 	env->prog->aux->btf = btf;
 
-	err = check_btf_func_early(env, attr, uattr);
+	err = prepare_btf_func(env, attr, uattr);
 	if (err)
 		return err;
 	return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9533ea700ba..92d0cdd95c0f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20325,7 +20325,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		INIT_LIST_HEAD(&env->explored_states[i]);
 	INIT_LIST_HEAD(&env->free_list);
 
-	ret = bpf_check_btf_info_early(env, attr, uattr);
+	/* Prepare BTF and func_info needed to discover all subprograms. */
+	ret = bpf_prepare_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
 
@@ -20337,6 +20338,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Validate BTF against the complete subprogram layout and apply CO-RE. */
 	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.53.0-Meta

