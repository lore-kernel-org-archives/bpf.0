Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B11396572
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503820; cv=none; b=qdJ5UCqymNhuy/o166JvNI9LdIGbR6rF/JsrFvpPAPTM8Ra0MBeG807wCkEVLxSFH2VF1BeOvEVYB8T8dDBOCmVIWtr6z6GxjLUItOJgHdDyvdlatuIerYBOOBres1p3Fnzn3FBQS4e1XV09bs9CppJ3P3+8XYNw4HnKYfVcgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503820; c=relaxed/simple;
	bh=M65fsxuD7Lc2fLO3nfwBKUtkmwBloqkj3MabatFgS+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONAiOjDJOVCuCcCMOsgrcetRji8kzF7RWesiuTa4fo+uoOGGLSLyt9p2JlBm0sgL+6rdiK+ecvbBnau5hkCNmVPQ0H5vxN4C1iNiYjMd+uy+A84Pce7ZAlWcPjDBitNbiVnud3C1pIeO2OIa9262eXFny7+VO/aGb5XolCHwu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pa81+hhb; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pa81+hhb"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso2246765e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503817; x=1789108617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ajuXQR6OKL8Ja3tHHR9W1yqPi+TG/WkwkKThBQ8BgCg=;
        b=pa81+hhbc5ezP5wqfhrqpnL8sjnyk193oktEvUTVZbvdWXaU0RuGwG+02SX6uCZGNL
         8/oO6b7DdqcagjiPU2459zowNic3eghQogmDzkQb2TKcK9tLSG1LH5lMRaS+jP1zxtIg
         9NdrwnWmC/2dlinpyHX7t5xYId4gKHSdCPKh++3ctqvR0WCoH01VRJ98Fkj3JCMvUPrM
         dGG1aELb86ZT+gEoCVGSod0PT0HCgrrjWNlH+FfoZthzc6Ofp7vhxpcfLZrM2s5qvVz9
         yx6JRRmq4o7y9+KaS5CNPC82F/ibCCsRux3TCCGVJZmR1opPdMfcxDqQlZJozOCkc84c
         2YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503817; x=1789108617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ajuXQR6OKL8Ja3tHHR9W1yqPi+TG/WkwkKThBQ8BgCg=;
        b=a51d0CUZsrtBWcrXzfGXbPY4gHAZZGn/8eVJDYu25p5ipNdvZzcl59ZkZFxtPlza9x
         AHDxxmJNDvfZZmAY/g27qNdlBGdWSb5zz09BTwMoDuUuyowbb8L5T2A8TEoNLZQ7K+UR
         Jx8c88WYQzZHPlc6QlyXw/eOYOaUqUB0mzcYn57iy3fi7DwdP3rwIAtlq3+JdUeXmIp9
         QWYDHKDRwH0DTEBmvKk2xik24Gz3ZrQBYGugZt/154bVXRLCpQYu4PWnv3MC0vtOaGkv
         VGMtp8P3q+MUVWiQwI7lHDWk9rtT8XKCnLar+YTWFLvPSGAthFqcgWSuB36ULoMgz9P9
         Nv6A==
X-Gm-Message-State: AFuF++n5Ny96lY3NVjHndXwLIpp7gis1rg0pSBnrazCWh/J/sF8GsDRz
	i97N5x1Q+DYS7waKrd3YzpkGuQ5plHjJrpv52JyQNvu4y7x5xxpfcSU9ppnnugX8
X-Gm-Gg: AYBFou09QrYma/1wtt5Jx2H4xOyMHNMqJ2Vtwms3N9zc/b+cRB/GyMScM8K2IZiGvp7
	mjUmSo23OQvA92JQ6pOp8j4okvFB2kMl8/a9iUYr80a9diasbmyoQZntfHGcNMy9nvzeJdydN73
	U3gOREidLHttGO42Ilr31wtz5SpiIW+tLSn5Xz2EOeGwNxTyUjCNlxiwewzIun4T3qad/qBd96l
	xzSPRo8+/DO2US//CE2dEJgyNKeQ9MXup0ds0dsj9cChYKsZB2q83Mx/oDnsIqsfCVUzjBXrS1Z
	QKuVgUPydUkT/L8mjY8FohZxPn/0USJxgTgmj/e6EHrhf9tPgSq65f5zeK0L+xCzWoUMcQa0HVJ
	twV3HJFBwnXQ3OiGhZhtt4tmrItU4SkuXbmVOnsjntC0QTFmnLAON7VOE2S08upkKb5POkdHPZc
	tuAXxoJFUCc+b9ty1TZf+v3EgBWuv7OAWhSfoUervX9w5iaeqxhVgDQPjgCv9T1ZVdCzWjHPu/x
	3k/bnIpqyHCcWb6+xxqNkjE+a8jXrXJirEY717ntWrv5/+vHzJz5DN+suLN1ooumoR0EeRlVVZv
	n5/7aexxI/AGOLZQmmsCE8lvBhg=
X-Received: by 2002:a05:600d:848e:20b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-49cf824f697mr28976925e9.10.1788503816683;
        Thu, 03 Sep 2026 23:36:56 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf772bd2asm40779565e9.11.2026.09.03.23.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:36:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 3/8] bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
Date: Fri,  4 Sep 2026 08:36:41 +0200
Message-ID: <20260904063650.3877826-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904063650.3877826-1-memxor@gmail.com>
References: <20260904063650.3877826-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=memxor@gmail.com; h=from:subject; bh=7RhG7L0a4oe2YJfh5bn+keIfNEAvNHw8cgMWxI6KGVA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtW2qVU5ovnJBasDXnM9MsvWqHd9di3FFU98WKDVz8YF kZM5YzoKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET6rzEyzGVWenH9bJ52p8P/ Xezzyl+E1H+YuWBK0ZRtEi/NH+Wcy2T47ydUzXe81vMs7xcX5om8i9pCFxSqZzeF+rD6frjZJv2 CBQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Ning Ding <dingning04@gmail.com>

bpf_refcount_acquire() is fallible for a borrowed reference because the
object may have reached a zero refcount. The verifier therefore keeps
KF_RET_NULL on the return value unless the argument is an owning reference.

An RCU-protected load of a local kptr is marked MEM_ALLOC, but it only
receives NON_OWN_REF when the pointee contains a graph node. A refcounted
object without a graph node consequently looks like an owning reference
even though the loaded register has no acquired reference state. If the
program drops the last real reference while remaining in the RCU critical
section, refcount_inc_not_zero() returns NULL while the verifier treats the
result as non-NULL.

Only classify the argument as owning when it is backed by a verifier-tracked
reference. This retains the non-NULL return for pointers from bpf_obj_new(),
bpf_kptr_xchg(), or an earlier successful acquisition, while requiring a
NULL check for borrowed RCU kptrs.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Ning Ding <dingning04@gmail.com>
[ kkd: Rewrote commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68353aa61fa1..bc0abf96cc89 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13178,7 +13178,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 						      bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
-			if (!type_is_non_owning_ref(reg->type))
+			if (!type_is_non_owning_ref(reg->type) && reg_is_referenced(env, reg))
 				meta->arg_owning_ref = true;
 
 			rec = reg_btf_record(reg);
-- 
2.53.0

