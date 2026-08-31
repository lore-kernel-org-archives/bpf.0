Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBEB39A054
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211561; cv=none; b=gyPhr8xgzk3eMUVaY8aj3WqypzRKEAxc7N2jKTA85UjudwAovNKzPxPL0h5jLNxBtxwJrchuD2BU7lMfaHEBO2nOG9Or59ekut6fiYFx57Wb5RPaEs6RyusC+jDe7IbCF6ggSwaO8J26drpSPeHbzjwyo59GEhmh9qdACfL/a0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211561; c=relaxed/simple;
	bh=AHPZLv7p/XIZVyL7GiDuruMmiBMwRW9aqTeppmZw4/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4MmsyXk5F+meRnqKckLDlJraORzId0EMMwMNc4cOX7KtoFBceUHS+PHlMzHrwXgeKclOPZbl/GHpsPXhgUNXLRTsTr/hMG02rxYLhPDuByHS0xz5OEFme2BvoLN9irnv7R49ABaUh7xzUHpCYokW7j9a87QeZq+zRZVHs3IfnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBiPPQUp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBiPPQUp"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso3795075e9.0
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211558; x=1788816358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aQbmJ5UzEspAlrZUDfvA8sbZNSNeRRfdUoE9eJ3Cyhg=;
        b=kBiPPQUpgchrBiieKHClvTK9AZkXnS6hfuQSbd5F0rdtL9NWPRFEuVFIa7VYj3366W
         bRaLyQPRb2iWw1b7rfxpJd6ay6WUZTS6XFodCcKPGJP+HgDeGLMvW6Zes2CBCYDCNXKq
         RQgdYH9/snScRw6sHRPIT/5yimbKsBXEHbTgqK4V7aHMC9Ek+PoknKTPLTwFiqTfXSo8
         s6bEfYPed0vbNm+nEO/Gn3qtG+cgYXC9A/0m1CXv15Z1McTuikN53U+xFhA4ipzEF8cz
         NIoWV/h1ET8SICZgIRRvB/FkhkrvpDDas+fb/v6AjbLMRCEq+2KfYG37boofi9Ygbz1r
         DsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211558; x=1788816358;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQbmJ5UzEspAlrZUDfvA8sbZNSNeRRfdUoE9eJ3Cyhg=;
        b=kZZwrS+6b4SHqF1VmLHVA/NdxAy8ei7NJYgOu39a9gLJ8kmFJhunmJYuORs0QeoxsN
         9i47Afk/HJ2pDu2pJMx+e9Bl+2Jm2DNdux2hQqGu41SzwAUsjZ+oAqEAMiHACaJZAe9j
         1ogZZIqi58uDknzL6E7mOWFnaMEC7uvIdQiRJ4YqEEsFhMzhDhl3X3r2NfXyv8hqvRGw
         V6YQ808GmfYq4Rj5aly0eUOR8N3+YezYkadQBUjuUHFvI8YQbap28Oily/V2qh2MYzgT
         hqdmiCQvmuHnUiqVi5RkYfbQPyuROQJRw31vX6lchYJUFk493fRVwuA4pUU2YUhuUFpo
         16Cw==
X-Gm-Message-State: AFuF++lUgjnTmYxt7pBOo8jHiUX0YtN88fwZvVsYumdFUx1aB/7XtZs0
	u4EjcMGRXeydSFC1XhJgeOb0qYAI+q9gUVSm+irq8wiNUzrzJpyI6gceHn/Eebwg
X-Gm-Gg: AR+sD11z7gSp68//oqGwgI00ZcQOexegbsFuATvsVqmp54o/6WqRR2QgTfAvYik3aD7
	Qk1yED3dy/QNpI+gz3e9n9JJ+SJdZUcEhBxZ8AkA58tbW54q3o/3RPvjPxNxg6o+qoKsBJGrsAL
	qebedROHLvl2AOCjGGIRIuUJLuCFeCmVXzSLOjr47jr3GU+5Emij7Wd3HcBjVcUf790xSWwnYZz
	GB9+eGbxBaV6qbfzIHSH/qCupnNDcVszlGoj5IdkU3184ug7Ln8dJ966yBEDdU/y7RKICEZsR+a
	yDtrbTqRHAL6etwKF+O7qsSXw+MoZKVferi/iCtaWMrCdpfrJOp/zhcFEpqYkXctWYnkM91xjaR
	C4tugrMoZYJjouanWcMVf/EwVYJeunFTOmq/nQpyOFb4nZxpig89t1J3Pl6jDxc3rNnsFFejfXz
	wuZetxVmdhJ1feQYUztq95Q7+XVwkQ7Neneck4TtwFlG7ygmV+2aO80rICHLLb3YoCU17lufOBP
	/PuodnDvclZ7Uny8pBdDe/opuSqRcPTbdtSUcx5UhLS1D12jLOSkjXoNA4cxqjlUJBYY/dKpu9R
	+cuKf1F/YHlt12+s4FvJNEYRZwddeSblvJeJLCTX1j26d73ps3QFpWrA7DRhf03Bm1Md
X-Received: by 2002:a05:600c:4e4c:b0:49b:e22:4ee4 with SMTP id 5b1f17b1804b1-49cdd416ef1mr14239365e9.4.1788211557306;
        Mon, 31 Aug 2026 14:25:57 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce44ea9sm18308105e9.14.2026.08.31.14.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:25:56 -0700 (PDT)
Date: Mon, 31 Aug 2026 23:25:54 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: crypto: Use AES-CBC and AES-ECB libraries
Message-ID: <apXwXLRpBUIWQuC5@gmail.com>
References: <20260831192139.94895-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831192139.94895-1-ebiggers@kernel.org>

On Mon, Aug 31, 2026 at 12:21:39PM +0100, Eric Biggers wrote:
> There are library APIs for both of these now, which are much easier to
> use and more efficient.  Reimplement BPF crypto on top of them, greatly
> simplifying the code.  As part of this, the bpf_crypto_type abstraction
> layer is removed, as it's not useful.
> 

This relates to my recent patch fixing state preservation in lskcipher's
unaligned path, which exercised ARC4 through BPF:

https://lore.kernel.org/r/20260829194314.42685-1-kmehltretter@gmail.com

While looking at your patch, I tested the actual BPF-visible algorithm
surface. The ECB and CBC templates allow considerably more than AES.

I compared:

  A: cee9395acd80 (v7.3-rc1)
  B: cee9395acd80 plus this patch

both used the same arm64 QEMU configuration and the same BPF/userspace
test artifacts. Each request was exactly one cipher block.

"OK" means context creation plus BPF encrypt/decrypt round-trip succeeded.

Algorithm                     Bytes  A          B
--------------------------------------------------------
ecb(aes)                         16  OK         OK
cbc(aes)                         16  OK         OK
ecb(aes-lib)                     16  OK         -ENOENT
cbc(aes-lib)                     16  OK         -ENOENT
ecb(anubis)                      16  OK         -ENOENT
cbc(anubis)                      16  OK         -ENOENT
ecb(anubis-generic)              16  OK         -ENOENT
cbc(anubis-generic)              16  OK         -ENOENT
ecb(aria)                        16  OK         -ENOENT
cbc(aria)                        16  OK         -ENOENT
ecb(aria-generic)                16  OK         -ENOENT
cbc(aria-generic)                16  OK         -ENOENT
ecb(blowfish)                     8  OK         -ENOENT
cbc(blowfish)                     8  OK         -ENOENT
ecb(blowfish-generic)             8  OK         -ENOENT
cbc(blowfish-generic)             8  OK         -ENOENT
ecb(camellia)                    16  OK         -ENOENT
cbc(camellia)                    16  OK         -ENOENT
ecb(camellia-generic)            16  OK         -ENOENT
cbc(camellia-generic)            16  OK         -ENOENT
ecb(cast5)                        8  OK         -ENOENT
cbc(cast5)                        8  OK         -ENOENT
ecb(cast5-generic)                8  OK         -ENOENT
cbc(cast5-generic)                8  OK         -ENOENT
ecb(cast6)                       16  OK         -ENOENT
cbc(cast6)                       16  OK         -ENOENT
ecb(cast6-generic)               16  OK         -ENOENT
cbc(cast6-generic)               16  OK         -ENOENT
ecb(des)                          8  OK         -ENOENT
cbc(des)                          8  OK         -ENOENT
ecb(des-generic)                  8  OK         -ENOENT
cbc(des-generic)                  8  OK         -ENOENT
ecb(des3_ede)                     8  OK         -ENOENT
cbc(des3_ede)                     8  OK         -ENOENT
ecb(des3_ede-generic)             8  OK         -ENOENT
cbc(des3_ede-generic)             8  OK         -ENOENT
ecb(khazad)                       8  OK         -ENOENT
cbc(khazad)                       8  OK         -ENOENT
ecb(khazad-generic)               8  OK         -ENOENT
cbc(khazad-generic)               8  OK         -ENOENT
ecb(seed)                        16  OK         -ENOENT
cbc(seed)                        16  OK         -ENOENT
ecb(seed-generic)                16  OK         -ENOENT
cbc(seed-generic)                16  OK         -ENOENT
ecb(serpent)                     16  OK         -ENOENT
cbc(serpent)                     16  OK         -ENOENT
ecb(serpent-generic)             16  OK         -ENOENT
cbc(serpent-generic)             16  OK         -ENOENT
ecb(sm4)                         16  OK         -ENOENT
cbc(sm4)                         16  OK         -ENOENT
ecb(sm4-generic)                 16  OK         -ENOENT
cbc(sm4-generic)                 16  OK         -ENOENT
ecb(tea)                          8  OK         -ENOENT
cbc(tea)                          8  OK         -ENOENT
ecb(tea-generic)                  8  OK         -ENOENT
cbc(tea-generic)                  8  OK         -ENOENT
ecb(xtea)                         8  OK         -ENOENT
cbc(xtea)                         8  OK         -ENOENT
ecb(xtea-generic)                 8  OK         -ENOENT
cbc(xtea-generic)                 8  OK         -ENOENT
ecb(xeta)                         8  OK         -ENOENT
cbc(xeta)                         8  OK         -ENOENT
ecb(xeta-generic)                 8  OK         -ENOENT
cbc(xeta-generic)                 8  OK         -ENOENT
ecb(twofish)                     16  OK         -ENOENT
cbc(twofish)                     16  OK         -ENOENT
ecb(twofish-generic)             16  OK         -ENOENT
cbc(twofish-generic)             16  OK         -ENOENT
arc4                              1  OK         -ENOENT
arc4-generic                      1  OK         -ENOENT
ecb(arc4)                         1  OK         -ENOENT
ecb(arc4-generic)                 1  OK         -ENOENT

This leaves only 2 of the 72 tested algorithm names: the other 70,
covering AES aliases, non-AES block ciphers, and ARC4, now return
-ENOENT.

This table describes the BPF-visible support removed by this patch. That
may well be worthwhile cleanup, but it is still the removal of existing,
likely only theoretical, support.

Thanks,
Karl
