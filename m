Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658927;
	b=t1Ygz6ikVC25wbslnNyv/P2eJ9dO7j7ws+D+fAcur5LNm12GkUQbMP/J9/SyfDZolduL
	 dVllDCVEZ3VM6in/KEOe6rIb2J0Fgz0MjdLSchr9Sgz2b82b9oRGGoRZAiU1+nXIAcsDC
	 i1pPftIPQjKH/hwRXMdLxP2WTelv1htdf7KlK5pzfmcNrT/+YVealcK7hz5e77opofrTj
	 XoKmDU6g11u839pQP8ATbEFQRGkWLeoqbeNzl8ajmd1GLi80TcIDvTOkRoDrXClFQuBl2
	 mye4Isbl+1GlgnX7pv4Cp+/suA1HaHUXqEWFsrkjtqoZP1N2SoUrMNzl7NNg/NDxAsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=4ExUq/OiRoy6v0DOAUuIV4LjAOQa0JqbQKdInvj7hio=;
	b=aUK5EQp7k22TxzH6ss5EjQ/8ve0vg2waQYKJja21YdY5zfhVJR/H0Zk5SM2H6afExCpb
	 zp1hL+ouAAqwF0iWHTIem2SoTZUfSeQHcU3fnAdr6IICZVT5U7SA1qUx5OePdKvzfhTAl
	 IXDhPhYHnOOKydkVvNk+45Neww4yyFwHetSm3yVaDhKig+gG1od4OKHpBFVfnKF9rUwT7
	 wp6RTC08gv4h2GlADsr5Y2PuW+1UhLAzoce6zjQ6Ggn1vlA+EE8j2bz/E4WQLn45NqLO4
	 s57P+kFlTrlTMdn3bfVkp7jLbATgkYEQVxz77X37NB9aepIT9nocNznU4ZNms3KazhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s+yZc2Zk;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61501606A321
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 08:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61501606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s+yZc2Zk
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35ef6b49813so2137518eec.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792658926; x=1793263726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ExUq/OiRoy6v0DOAUuIV4LjAOQa0JqbQKdInvj7hio=;
        b=s+yZc2Zk0aUrpkm3TdzIZRhuwxBS+KXQWMJaTVdZLmm9gge2brv8foEli5l5DvxWsq
         zAUIPIg8H95314NepUq5Qxn38FNZJ7yzJ502v1xULuzxmrmZw8mxoURVTM4KojgiMPBR
         THZGayDJmvr42+O/abedsaHiBXzo9pnDhnLrvFPv9wGyEKA6BH9D1UIosIwdxaNUdzYU
         ZTGIDiYN08GmdSS/AJTB/S/GT8WgmmCJZkAf1EfNwyflgkG5LfJE6147lY2Drl9PcfmT
         +pTU5uGv8yxkftnGZWdImDJtAi6qLpE1qEUqRmzNGlp6ATJ3mbH9gESAcufytB5sJwAf
         Gw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658926; x=1793263726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ExUq/OiRoy6v0DOAUuIV4LjAOQa0JqbQKdInvj7hio=;
        b=hEwEY+AdoFNe2O/dtcxCh51Pe1ts6MybSMnvDpveaINOtdrmW5V5TrMxHA9cv2OdEY
         3Ovm7XZf2E4zMYcnEwgMv9VfKteamoDBZ6R2Jy56QPmP2JHyPSGO6dEekTzlxw/LTnAL
         nJd5/0Hjz/CiJYAvoydXNLA0D1iAiIIZOu/5bgd4P/8zNGnQZOe+WRugXCAMy9QGBC4d
         jYkO6ugduvZakQcqF6K2e/f2cIk8ifHOxI6Dg1SIX8CmfiyPXU44UiEHE69PtosEFl+6
         YELKq4bqGbB5Tx4VqhlJo4FlW6pzNXUbyn+MxUb1nB7ORIBUsBO+srL39kesVp4X4zry
         gIuw==
X-Gm-Message-State: AFq9FYIpGwQM1dA9uDWI0hdQ6L8v2pbW7TsL4qsK7HMLpeZYfe1hGKhG
	m7mMN5lQOvGcaeDoXXxFGKpMWhAxGBXnMdpGTGTSpRfrQ61w1hVa06XU
X-Gm-Gg: AYBFou25riHUhPc+kXVydk5hyaUppurK1v7e1oxGXoRPHwgLs8iFJGygQTeQpjpxDSt
	UW8zb/cXkcZx4YV24rtOnn1vt6F3V/n6NLiN0YwXBZNmdhQcqRzOsPLRyvtDkQyyBEc0/MO6rgy
	ZZPc+HkTExcplR2MDOOl1EqAcKcxnlRacr3564WtegPBiV/VTo2ozlwrXMRS7cBbt14jlQjsaIn
	jMutwqGp8sy8GXj/Zc+KPd4T5GQrcJ6UmywR9Qbx1R//rvU6pMZOA8M1wyuo9JWPJRrMcnbjHrU
	Cy/aW/IQ8gC4dncyB0SDEOHOUgXG3hctY3kZRVPLMEld5M14k73ot+zR9aKi4yrK4BXP4nDq6W0
	FQ372PPLjp0la50FsqzdWN6PMN6P4pkZloyA9qkiTvy9N/1eylq564l9lq0dnkJASMrOBybkU4s
	z9e0Okm/pZQHIS3K82leRQQpOU2z+Et9UTVeTiM0fKK74VK5sfJuaoecBA4RjgaqYyxGsAvMV2R
	222uUHm/yvRYjZ9KhoUgJp35DUrJy8qZ1B2CGrD3qFeyP2j3ks=
X-Received: by 2002:a05:693c:4006:b0:368:5750:9869 with SMTP id 5a478bee46e88-36857509b06mr3808591eec.8.1792658926069;
        Thu, 22 Oct 2026 01:48:46 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367417a2fadsm13962472eec.21.2026.10.22.01.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:48:45 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 22 Oct 2026 16:48:36 +0800
Subject: [PATCH bpf-next v6 1/4] bpf: Protect the struct_ops association
 with a spinlock
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-1-2c0f18e82582@gmail.com>
References: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
In-Reply-To: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_prog_assoc_struct_ops() and bpf_prog_disassoc_struct_ops() update
prog->aux->st_ops_assoc under st_ops_assoc_mutex, and the latter puts
the map of a non-struct_ops prog while holding it.

A struct_ops map is about to dissociate its progs from
map_free_pre_rcu(), which bpf_map_put() calls in whatever context drops
the last reference, including softirq, e.g. bpf_struct_ops_put() from
tcp_cleanup_congestion_control(). A mutex can't be taken there, and the
put of the last reference under the lock of one prog would take the
lock of other progs.

Replace the mutex with a spinlock taken with interrupts disabled, and
put the map after dropping it.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/bpf.h         |  2 +-
 kernel/bpf/bpf_struct_ops.c | 19 ++++++++++---------
 kernel/bpf/core.c           |  3 +--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 580f89c450b55..17b2a425e05eb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1979,7 +1979,7 @@ struct bpf_prog_aux {
 		struct rcu_work rwork;
 	};
 	struct bpf_stream *stream[2];
-	struct mutex st_ops_assoc_mutex;
+	spinlock_t st_ops_assoc_lock; /* protects st_ops_assoc */
 	struct bpf_map __rcu *st_ops_assoc;
 };
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1178acd72296e..a1ae30b145a03 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1541,10 +1541,10 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
 {
 	struct bpf_map *st_ops_assoc;
 
-	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+	guard(spinlock_irqsave)(&prog->aux->st_ops_assoc_lock);
 
 	st_ops_assoc = rcu_dereference_protected(prog->aux->st_ops_assoc,
-						 lockdep_is_held(&prog->aux->st_ops_assoc_mutex));
+						 lockdep_is_held(&prog->aux->st_ops_assoc_lock));
 	if (st_ops_assoc && st_ops_assoc == map)
 		return 0;
 
@@ -1569,19 +1569,20 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
 
 void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
 {
+	struct bpf_prog_aux *aux = prog->aux;
 	struct bpf_map *st_ops_assoc;
 
-	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+	scoped_guard(spinlock_irqsave, &aux->st_ops_assoc_lock) {
+		st_ops_assoc = rcu_dereference_protected(aux->st_ops_assoc,
+							 lockdep_is_held(&aux->st_ops_assoc_lock));
+		if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
+			return;
 
-	st_ops_assoc = rcu_dereference_protected(prog->aux->st_ops_assoc,
-						 lockdep_is_held(&prog->aux->st_ops_assoc_mutex));
-	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
-		return;
+		RCU_INIT_POINTER(aux->st_ops_assoc, NULL);
+	}
 
 	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
 		bpf_map_put(st_ops_assoc);
-
-	RCU_INIT_POINTER(prog->aux->st_ops_assoc, NULL);
 }
 
 /*
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3030beb531d99..0a8ba603f44b4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -141,7 +141,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	mutex_init(&fp->aux->used_maps_mutex);
 	mutex_init(&fp->aux->ext_mutex);
 	mutex_init(&fp->aux->dst_mutex);
-	mutex_init(&fp->aux->st_ops_assoc_mutex);
+	spin_lock_init(&fp->aux->st_ops_assoc_lock);
 
 	return fp;
 }
@@ -291,7 +291,6 @@ void __bpf_prog_free(struct bpf_prog *fp)
 #endif
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
-		mutex_destroy(&fp->aux->st_ops_assoc_mutex);
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}

-- 
2.43.0

