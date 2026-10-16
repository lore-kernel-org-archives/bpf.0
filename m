Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97A30EF91
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117133; cv=none; b=O+rYbsDTqPouvp9Txcj6b6LaGZhjxfrvNHA2SrtsBRFbFYgQf7Y+iNSVD1o2LC0/AUl6iwiTtx0FEkZqX9OwVxUHGHHqe+brKzajKt02gENwAU3EgwUBxmFqnN9UWOnhMiaufLKzNRAvOhZdGabv8G+ORICjZycWzEDLKsXZyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117133; c=relaxed/simple;
	bh=fS+1/YDK2c5xj53yMJr2qNGjho16cvGDrTz0OXunelg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8yl51jtnG53O3XJv4mBODMBFNjqZE5q7UOxHpAi3+KLue4r9kAUscIj1nUd1QOIT/QyMWSourB6CDPds7PLGAev4EMG8FgQDHwCguInG1LEAf1D3Zz5QMcOiHOUZ2uFEEQjl2tocjp6+hz1l4PjQy/UdraUn/ZUAFz1Csdby/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kDJg9C6E; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kDJg9C6E"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30b6dad2382so14198847eec.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117131; x=1792721931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jc4afiZdmgjSlBTxJSupYGZTonwC9tDWBHg+soEoOIU=;
        b=kDJg9C6E6s54SvQqum55RjuOd050HlahDc0l1d44tbN6OD/+DRTPIBPzIu9fry47bB
         YTFQWCHTh5WylcAc7j8Kh7spJT46A4LiXlv8ZdbJFZ4k4rYU8ejyW3Xyd34gnAPUlua9
         ygiQYsA3SEWtixKThI9KzDbv6oTEMOLKLstjA+L8j5sNIo829EHJR5c0MGIOMvPAeypP
         SiroDSdv9CTZUg/Z4n1TlLHXYqGGD/yjsRMh6SvUV9RyNuInhD5STCXW0prvwogJsb0i
         fu5gaNeFp2Uo8/ceh/HTfY5oOjs+K/WWLTcPfYALB2NQm1WWV7J/vF7KsSjy5T4629Xl
         GAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117131; x=1792721931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jc4afiZdmgjSlBTxJSupYGZTonwC9tDWBHg+soEoOIU=;
        b=wJPs0+CIRJ9SIRAhCUCBDZlM/DhrqW159KvJerrYYJkF6+Y7OzPAVaCRqQ6/fHp+wP
         1FA4+wLFHPuuiMF4KnQ469/AOe7FW2IF8ZIurzAyKLeeDVWbPWXktYG7pLZf5kLpyeCA
         kMcIL0Q/RvR6PSv54LKG4KXKlFer3nJfbogW54UUvVZuZjQxBqYI6TqmKswGw9eGGCv7
         9Q88JvnqM6v0nVnCTA2v9LaeNAM9zARh+bBihJOdEOAScYThKa/QXWGTnWiUSLXF0EgE
         49eKztHfJd1C0U3DPe2kAacIf5ft/05a+PPan/cA3IhskkT3c6HlMHLvsJS8bE+OBjtd
         ObpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwM2w2L7+liA66dSO3/i3cp4p5hqkvVW999yK8RdBkbh+ASvAzxvYJm/Eb+NjJdar7PWnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUmCgAXZJ5f/jw9cpDUQtpTtjMKa9WusqZonn77jnvF/r8ovlg
	YCYeGva7a7t31HbxjR+sZnjhOtiwcsX0xacs+SymudynDDImj6IC3d57K4Gnp0MNnmv7FySH88K
	+/frylqGX4g==
X-Gm-Gg: AYBFou3kwUxuGyfaLOtwqvE5+qlAtmDL2udwkHS+LitR+ZC1lRJz6XQQU9mZr5TyAbk
	/xAqNXqO0eEUMOLTOOQ3orfYIjPleufGmVom44Z2DjNFy0HjqxrP7grZkMSTFeq4CUt5el/TOrV
	tZr3F3b8wXauRg2Irg0St3Pq7KuGVuvVkjVt0jCzuwxs2FUDDylTsi2PaJde0AizdS00+CodP6k
	aqamauFu7ontE9FAUDejaU86s3fRmRoCAUnWrR9Llv2Gf6SuyOYFEPRu2jcA7WoywBW76xZ2xdt
	+RKefDmeZ6y8BFTXPRSXfCYiOVNZaNnD40r+hVJFvTArLe0kqw9YrSpMNbAAxgWg0DyQz0bziTe
	O0HemCkHs1xEf63TwgMidv/fy9kyFVW7+hmkyFUYqEbgwqH9QpHIB6YMRONP+mFslJYW+Bw0/te
	hpnf8WM7s5qNWVG+CiW9FcvF9G4ejdXdBcrnVCRgSQhXLDGhf+ScOFupb8M1sYaTUfRVK0JbFW2
	4jux0wlWJC43MJY497xr9b7cI2L0RgAx5l63vB1Gp0MX4I7+tMk2J7Gte0eokD65e8/aBhU5Ya/
	dVp9
X-Received: by 2002:a05:7300:828a:b0:34c:d1f2:b552 with SMTP id 5a478bee46e88-3537dedaa87mr26642176eec.4.1792117130878;
        Thu, 15 Oct 2026 19:18:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608219f838sm1887564eec.19.2026.10.15.19.18.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:18:50 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	thevlad@meta.com,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf: Fix kmemleak warning for percpu hashmap
Date: Thu, 15 Oct 2026 22:18:47 -0400
Message-ID: <20261016021847.16847-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 11ba7ce076e5903e7bdc1fd1498979c331b3c286 ]

Vlad Poenaru reported the following kmemleak issue:

  unreferenced object 0x606fd7c44ac8 (size 32):
    backtrace (crc 0):
      pcpu_alloc_noprof+0x730/0xeb0
      bpf_map_alloc_percpu+0x69/0xc0
      prealloc_init+0x9d/0x1b0
      htab_map_alloc+0x363/0x510
      map_create+0x215/0x3a0
      __sys_bpf+0x16b/0x3e0
      __x64_sys_bpf+0x18/0x20
      do_syscall_64+0x7b/0x150
      entry_SYSCALL_64_after_hwframe+0x4b/0x53

Further investigation shows the reason is due to not 8-byte aligned
store of percpu pointer in htab_elem_set_ptr():
  *(void __percpu **)(l->key + key_size) = pptr;

Note that the whole htab_elem alignment is 8 (for x86_64). If the key_size
is 4, that means pptr is stored in a location which is 4 byte aligned but
not 8 byte aligned. In mm/kmemleak.c, scan_block() scans the memory based
on 8 byte stride, so it won't detect above pptr, hence reporting the memory
leak.

In htab_map_alloc(), we already have

        htab->elem_size = sizeof(struct htab_elem) +
                          round_up(htab->map.key_size, 8);
        if (percpu)
                htab->elem_size += sizeof(void *);
        else
                htab->elem_size += round_up(htab->map.value_size, 8);

So storing pptr with 8-byte alignment won't cause any problem and can fix
kmemleak too.

The issue can be reproduced with bpf selftest as well:
  1. Enable CONFIG_DEBUG_KMEMLEAK config
  2. Add a getchar() before skel destroy in test_hash_map() in prog_tests/for_each.c.
     The purpose is to keep map available so kmemleak can be detected.
  3. run './test_progs -t for_each/hash_map &' and a kmemleak should be reported.

Reported-by: Vlad Poenaru <thevlad@meta.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20250224175514.2207227-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
[ Backport to 6.6.y: Omit the htab_percpu_map_gen_lookup() hunk;
  this target has no corresponding helper. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-37807 to 6.6.y.

The code changes are identical to upstream, except the generated-lookup
hunk was omitted because 6.6.y has no htab_percpu_map_gen_lookup(); see
the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/hashtab.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index e14a0caa07bfadf9daf7720c065aca810165e310..fb7f64c494b0e3b181cea397b79327e1585a76ed 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -197,12 +197,12 @@ static bool htab_is_percpu(const struct bpf_htab *htab)
 static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
 				     void __percpu *pptr)
 {
-	*(void __percpu **)(l->key + key_size) = pptr;
+	*(void __percpu **)(l->key + roundup(key_size, 8)) = pptr;
 }
 
 static inline void __percpu *htab_elem_get_ptr(struct htab_elem *l, u32 key_size)
 {
-	return *(void __percpu **)(l->key + key_size);
+	return *(void __percpu **)(l->key + roundup(key_size, 8));
 }
 
 static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
