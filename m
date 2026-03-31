Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EF1EF09B
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941627; cv=none; b=cUYfSYXET2f07aGSmBHfi9jFNAa0R+fMYKxmdgw4sMLETzX7uvjo3NbTPUWMLxrfOtXHS8is0BGMm8tRwUZdrl7vwCnG2KbdKL9eezHZfvZiOCAsYv1JQluwqgFFizJUOZFOFxMVdmPZc8frd0cDqwjsRSkCr3yHDh8320gqZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941627; c=relaxed/simple;
	bh=Ig09pmyQ1CVLjBTHm/qtTk/BGIGrjqWYEB43Rzj9xuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNVbplSgSWk+ufm/vfE0XTpOFz/lmI1WpazInAPqb0semkV26pAK6RVd7IU0QcZ8/IWaktNwB/dey7b8B0tWVucbgIjJLKo++BB7irtJAuF1pGsl2JtF6Lp+uCeIYkTrmwTCN6iplrLwWshumrDLMsfLaOkrhqf1+N+6SFSBV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO5UwGGr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO5UwGGr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a9296b3926so34829305ad.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774941626; x=1775546426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig09pmyQ1CVLjBTHm/qtTk/BGIGrjqWYEB43Rzj9xuQ=;
        b=VO5UwGGrPT7vXlCT60K5iaW8+8Ac1d9VFi9aFlZGJbuagR6/D9VkLZNFc6o5fhedfB
         6IZKVrX7bVBrY8GjZDglCBkjq3MRNm6zf9U3gYzXQOaCIrCJgk0xGz55uqlHI4BIoa6t
         xbJW0j3Y3/+49QTEHcTF94aKHGba2HuRaHhmooRQDlom3VQJyPLSzNhI3bOQpVG4HyKm
         e9cwqh3Q1r0YHQIqx7u/nH1YAG2JehtVWwQScJJejzxrzXcuB173/oKKmy7nlrKj7CcK
         dGgeGhThnxmzUqVBPfHZZtHt9N4EUsa06X3THevuCGyAgL1w/Jf+4Fe4H0i/hKzyx+AJ
         4uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941626; x=1775546426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ig09pmyQ1CVLjBTHm/qtTk/BGIGrjqWYEB43Rzj9xuQ=;
        b=ElACcrN0RxXagZqn+dS1uzIigXhg7GGL+sjAp9ruxg/GU2FuSycJkoC2cydlI7r0SB
         I4bFgE/uLSNb12mWe+5K5UlOt7PZsQCxZkwVZmobrtVayTCKAQnHboa3p47bmNDuJoms
         gMgVl78im2XjImD/qsVb1mShCFozn9yRWhv+RoWQ6pyS6gcKl0B1na7o5mDttWNTFuBZ
         OTkhYCISQqBsg+BLJWMjG3o7S+CmQcBXOZPKxT617fPt2gW5JA+n+bRXVGAiS8H5Ql4R
         ebmb1CcHCOxbDzQW0OQpamg9ObAilApBt19zO+U47R0ASnTCWbUthPSy9/tbs/UYwcNk
         cu/A==
X-Forwarded-Encrypted: i=1; AJvYcCXNSzECm0UUXUSxXSszjzdnW72C0DEysKsQLoXCDyEFX/uc579rP3G3t1ziUWZmcpFxF98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2yV/y15ioR2zqC09z8EkVxZ2xZ+RRkaRwGVwkR12gcdscKFAM
	TuX7seSI9NznbdFcMcXTDoevanPK9zOUjt+TiIzX+T/Cfqox0stx0LEY
X-Gm-Gg: ATEYQzzzoD6Yb5arkaisXsr46ZqDiUtnzH1JmFn8m1XzjAWE5H0mwVSlSRoD+bALcYl
	Zg1CnC/TKXVcTC0aVnJ7HIGjdxuwHmDkxJ3dcT2cBiXC6MyizKZ9RdEW0Uk28DpZn1c7u2/8rqo
	4WrWrSty84W0OdSiTdYBo6QFVTy5lS3ckk+UrsciHIdnpaMSQk+JidKkezcSqtPzo0+PGOIjxhb
	5ExXY+NGmHuu2gsPkS17gF538Gcy7+JRTaai+6wGYdHnZtPyFxY1wC4RwqqVJwHM+PUvzwMDbtZ
	pcyes8LX6o8uF1+9WjZO3JPipyvuC3bSr3Cc6p6FNprwIvB+L/Rr1TwU4GM2YL7q1aMGcnifElK
	3e+ENf1ET4TUoFBZxlhfB5bItSm8mDNVU9NWpcGPEZ3oqpjwghsQgiSqkYQdpuJQ6eEdcb5fy/A
	Io6BNAQQdxwiCLNMtfeQ1h7dCwDpC5B+Rrye9Jo3cnhABvhFcx6Y7Xuv5TefqkdA==
X-Received: by 2002:a17:903:19c7:b0:2b0:5be9:f423 with SMTP id d9443c01a7336-2b0cdd927afmr156997855ad.43.1774941626067;
        Tue, 31 Mar 2026 00:20:26 -0700 (PDT)
Received: from cps-manycore-1.. ([143.248.136.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24267397bsm110018405ad.27.2026.03.31.00.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:20:25 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: leon.hwang@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	rhkrqnwk98@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v3] bpf: Fix RCU stall in bpf_fd_array_map_clear()
Date: Tue, 31 Mar 2026 07:20:19 +0000
Message-ID: <20260331072019.880589-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <56b3dd26-4110-43c9-8bdb-abc3b7a78435@linux.dev>
References: <56b3dd26-4110-43c9-8bdb-abc3b7a78435@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 31/3/26 13:19, Leon Hwang wrote:
> After looking at v2, there's no functional change for v2 -> v3.
>
> I think, you should send a PING in v2 after some days instead of sending
> v3. If v2 will be applied, the tag will be picked up btw.
>
> Besides, change logs are missing here.

You're right, I should have just pinged v2 instead of sending v3.
The only change was fixing a CC typo (eddyz78 -> eddyz87), no
functional change. Apologies for the missing changelog as well.

> Since bpf_fd_array_map_clear() is used across prog_array,
> perf_event_array, cgroup_array, and array_of_map, and this patch aims to
> avoid RCU stalls for prog_array, does this cond_resched() punish
> perf_event_array, cgroup_array, and array_of_map?

map_poke_run is only set in prog_array_map_ops, so the
expensive path (poke_mutex + map_poke_run) in
__fd_array_map_delete_elem() is exclusive to prog_array.
For perf_event_array, cgroup_array, and array_of_map, each
iteration is just xchg + put_ptr, which is lightweight enough
that cond_resched() will not trigger rescheduling in practice.

Thanks,
Sechang
