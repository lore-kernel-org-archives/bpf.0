Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559957;
	b=ZW90pBFBeJ+65+/9ddh01/sdCCmkwFFZ9GU6XHHywQLqZ/pl07RT6wZp8tTOQN6nrX6S
	 DgqQI1l/b4hSi6tDtJ82oK9FY0BBV9uR8WkUhx4u6LW56kXB2+FI099Bmc8Hl/QLhy74C
	 TcEOCNuOkvxxeSj0X/JLQQlUEtY4o6Ugqq+8ZjUlW5p1DDabpGa/MO5l6aeIT11WJvnqJ
	 msYi2XDMfZRMUJU0zvxPvFlEItNa5MOPrH2p28vFEgRpjgapOXVkJqRjj2+t9jI8LQFTD
	 luELms3sVNSTVDWLfufxkH8guwoc+yWxFlN2Mp65IDfrlxkwxFHfbFB76o5lU9NWCFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y0Zk/rhDArrBJkvaHRz/WJOsjJlI7NCjTFTAE2QTy2I=;
	b=jzGoYTZzTBGgBxfWcXF6C5xQbzXuvugU3NIA6vniEut1i6s+dFP5a++aYsA5Idr2vvX6
	 RGNigAZgwwSlrSVX86GpkXwIIX7UgCAgam8BZIE91eWusj76NyygKe1lnpuA0ebfrPmWH
	 9FqfSnVDtRo4WezJycxsHDkSgLXNsAbxsqU7WHYASO9+DcwU1Dt5s544XXqUSv2Zid7po
	 bASQVTjoMp288V/PPsA7v23MTvU4g5qNWl76pNmTiGXNDpVSYBgOFKIV8jIAMUB16OfM9
	 Q5NNkNEBEg6xS6Ohf55O2xpPWs2xntq0sEffGxRHMSXzGMPrd2qaaIpjxZOxXKFIxdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PFugIKGH;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58768606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58768606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PFugIKGH
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1929285a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559957; x=1794164757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y0Zk/rhDArrBJkvaHRz/WJOsjJlI7NCjTFTAE2QTy2I=;
        b=PFugIKGHirjA1HsthAA6Ddt90bvaPKJIPAl8fEfNGkw761en+8bAs6BF3QNSdTVayI
         d/mapdX9R+fAgjQPzBw3iA5OfoPmjyC1ghsARoSTRVbtaQhKf2qOLQsLKLiDPQJzpjzQ
         wtKkmVG8DIiim6rzUByatYblx5fqT75LUrEIFwIaLEJXIwZmwDh3qyi2bFFS6we1ifWV
         rMmZwixCRU1spkKnFE5qhzcmVrchoqP5ZgtYW0JrGvk3+rsTbQF/bxIha3Yj9euIZszL
         jwXCBVkrpWMx/j1BjzS6wTCDi0FOKLEi0oWX+R8PDmupnhSsL1/III6L8LoFJz/hwiOm
         Z72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559957; x=1794164757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y0Zk/rhDArrBJkvaHRz/WJOsjJlI7NCjTFTAE2QTy2I=;
        b=FUfRdzkOFYsw+W5g6FV5SVOEU3GvmkyMHOod11/68RV0hDJ4nxAdGp3K+1NLDW+J9s
         R7JdCbfJTMXx6yEkusE117NrO4gdCqoGTtZjf89WrjiKV34CxdWMegOMFn2RMMj5xRj0
         WOml/2SJ5Ie4eUKZ/fvTSHyyL4yUz2xVw/sA/bZ8WXxoYBRVi54pUEGwNODC+f2x1yO8
         FJoHr16HJw8qO9USydR/WDF5IRroQo/fEou2I2tOntTHU0cyk+DdCCchQd49c55MxOAf
         nNxh6JCy80ewF7NmCGCyKewYEoEvgUpixNIKl+u3NUgpwX2NV0UkcYujjPX59F+oK1ee
         f3yw==
X-Gm-Message-State: APuU4Z8dC7jNhCpuV7nmkXGjxZeBGv3Z1LWoCnguHUBKQexVIMi52seD
	GY6/Lr2tM6Fqbn/B3N5/9MCRZra5xJsI0AaHG57zfVOMw0pi7ajEOtfjq/b0+Q==
X-Gm-Gg: AYBFou1ysBVWkt6x0JfmWqbQoAIEc431dH0mr1vLQo/8ENWg1z1xFBMwg0DO8gYwF87
	tqOBlBES30aZcoEQA1IdaM6QxWFkvePUr2lqUaYqO1D/ENSbrCH3MKF9qoyUrFZAvOzj4NosW2E
	btYePjo6G6k8xRMDRQ4z8mI5qgbhbhu6UiGcliBbSvKrAKOCLGaj66i1FP3rKpPjXSJ1QEnRt0X
	yeCuDbQeKW0Y2vnGmQKJuu2Wlmgt0pooVL23wui9WS5oVCVhUnoLdXW6H7MDeC7gVjghLPcfXL6
	v80cpJ/SitRF44soCp1/rR9HS/5wnDq6HGYXZG5KAMQDrKABg0cP4SttvClAn3EMR6bh7qdm4St
	vvmjkSqZZTJTS9/6lEFq9mkDI6BYTtm7qS05WWPgY2zLrTbsyz8OAlsOwOdldNr74lLTGT+kHUB
	NBhOstUaUoOx0z3voKDVwU9yxIJqWDCwvD6gdFFSjzMd70+ScNYThIdLzzZeAx50eULBaQjmyC1
	kV/PNBYe5yKoT9H9J3hG6+/VIPzUnti8H3Mwhsi2aAPQgIcX/mFm3aoGCwRa7Jf0kfG5Z/IhGGM
	jH22fnV83n0DWEfNO7UqgVQWBrfVWD/mw0e67Expml3/OCM7W0Fp9vWUQrQj3uqGz5pVRH7UAGY
	0Z3jyToGiO/Z5zByFbHNLfoneAmYd9tTMIwSILcLtsOZN33d+dKDLah0s1cPnzAamswO0ilAIsL
	U=
X-Received: by 2002:a17:90a:e7d2:b0:3ac:4e18:2390 with SMTP id 98e67ed59e1d1-3ae895743d0mr7302454a91.7.1793559956655;
        Sun, 01 Nov 2026 11:05:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb2c5sm15364570a91.3.2026.11.01.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:05:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 03/27] bpf: Refuse to map an arena at address 0
Date: Sun,  1 Nov 2026 19:05:11 +0000
Message-ID: <20261101190535.1454146-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

The first mmap() of an arena sets user_vm_start and user_vm_end. Each
subsequent mmap() must use the same range. The value 0 in user_vm_start
means that the range is not set, but a mapping can start at address 0. Then
arena_map_mmap() does not check vm_start and sets user_vm_start again. The
range tree counts pages from user_vm_start. With a new user_vm_start it
reports allocated pages as free, and apply_range_set_cb() fails with
-EBUSY.

An arena at address 0 is not useful, because the verifier rejects all progs
that refer to it. Return -EINVAL from arena_get_unmapped_area(). It runs
before mmap() removes the old mappings in the range.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 3c61c181a6fa..ad8aab551093 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -650,6 +650,9 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 	ret = mm_get_unmapped_area(filp, addr, len * 2, 0, flags);
 	if (IS_ERR_VALUE(ret))
 		return ret;
+	if (!ret)
+		/* user_vm_start == 0 means that the user range is not set yet */
+		return -EINVAL;
 	if ((ret >> 32) == ((ret + len - 1) >> 32))
 		return ret;
 	if (WARN_ON_ONCE(arena->user_vm_start))
-- 
2.55.0

