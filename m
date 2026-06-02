Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3D3BED0C
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439364; cv=none; b=kUkUHu8E9JkfZD8PNAOaTBn2vl0DBKeU8XfbHURBLcB9HGZKRUPrYkCzN9NMT57vxtjdZeYVB6hPBHU+XS5q6oDjX50GK1sS1d5I6FcN/ed65Mew+QE5v1JAEJTRf1htva8Ot3Mt/mqMiW5veyAEXd4DOdovvLZO5PBanujIirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439364; c=relaxed/simple;
	bh=uCD4hCc4XJ9cLp0cEeWugpV7A+Kjg6CRiPP8rloQDrU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fa6NsxLKtcYpoZcnWzRbYJ34s3Eu/EapbimXRIbvqbxVatD0UmHpkSeBNT5FCnG4io2YHXt4L6e8Mw778PJAlQ5H02XS0k7Ah26IKFAlaa8xZFyNZOnPbe8wGsnbO1D+af3ogGcRfwWgmN9WvCc5o6vk/UxHXttA2PlFrAnlzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwbJnAP0; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwbJnAP0"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-49068493267so69690525e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780439362; x=1781044162; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCD4hCc4XJ9cLp0cEeWugpV7A+Kjg6CRiPP8rloQDrU=;
        b=bwbJnAP0x7WFGy2gHA/WCNsUl+cSz/0EFtuqkdU3x0j2KXLhvsKVSttsfwgcyJS+/9
         WVtz89ZVEUXpB61eUZ6Crrs8p3kIgkJhCmcK68a31xrDD8MmX6FUPcxXcNZhUyPvdMwd
         SNOCdZxOXxjTCDNzCyskYF+WrhwgbS0Ov/2sA2EFmxaqu7NAcQd5Yh9NKNfV7THyKWfu
         y2d7eFohDY5Kk9A2nZx9U7seY/fozfqCVz5mWSpBthpVhBhGqi6QHQNf5s8mnXuxQuuq
         tewg/KiIxJ9p+KhD/PXhYFy/Tsm9jXSbptd97PbVM0ra6qEDzDx9MkMrMiwBiH/tcD1P
         Wx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439362; x=1781044162;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCD4hCc4XJ9cLp0cEeWugpV7A+Kjg6CRiPP8rloQDrU=;
        b=iQOzVqkMGErydnSfMDzrsnjZA9xPAKPvOh4BmQ5DCjEqjH4OKX4903VjHI6GTioOew
         dYjJurz9uD2xhxJZmRT9LkVzEVpopuyf8Lssnu5GcH/Pl/pJTLKx8yCpPzV6HUFamDVZ
         p2UdGvyU3Nm7NKb+h/thIRkdLi5/9rN63qHJ0sTkW5R4/6CibCZVRavUwv7Obs0bJmR3
         VL59IoOVOM9+5hIpiE2DOcaJWvsZw3oJmEAnJeDytU99xITc+Hwtl0Nh4UpyngFQjXt4
         98xhXIsnaH2lbaO/M2pAQyEZTeIg0QT0AgV7Fzaj/CDMnyPFJg0TprIccnVAZvOiZiyy
         3XNw==
X-Forwarded-Encrypted: i=1; AFNElJ/oXwCGIOIt9YWLw6a140ARPbAzGoKOq1pKkf9+/4Kv6u5PgDAeq0iLNE+XufwNaLjioJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDc2s5yj47rEMVSCH4z9pG6XT6WSogxAFTA8fzGdRDitghc3s
	t6PqlIavh8fYAot8+V05GPElQvcRlimS+aT04p+wWQPlG74ci+Ks3XFw
X-Gm-Gg: Acq92OGVrkVOsIIoRd4hlKGup60Wcvlje8b4hg7pplvslQezFvyFJaZWn/P/I6A1mlx
	Fbcw2XSo0ol+sHcnOCyOTBBiLxVBnL9+gKWTRMyCnTp+dnk203bWMvSv1+ccA5dDF4juTmM+M+v
	rWKhOt/FlRF+9t1rT/Q4oOnbfR+649ZdmZLKLgffd3Wr3oonBzDDm7e+NF0tu+1cc6gJrXODCRp
	8GG7ijIxtg9bpZEmk80JzAwrxppiFThQAG6QXw+UmZJGrUlTyo/TJDAth2/M46WI8NfhHdum8Ld
	Bfs1r6e52CWn9r8algooikkthKlGczn9ZgVpZV8B1maQ9dLgJfUwozLUjZIuGpYAjiA9fzi22iG
	9JUoeKcFE+7muwmPs8vJbSNt2cCta+BxHCyIVapVGuw/DXz7119e+v+jssyg3PU2BWAxpyYOY1d
	EySTCLIe1EsU3PFztFbeWerfCfqvciBDT764oDGP6QwZn567PwrZ7VuzE3Ernh1KVmW6rqYPWkh
	BVbNfSeeQqdIjhDovRtXHaKaE4ukixMGHK9rjth6qcy5elKnYywIUOlxK9ZXwslOmO+9O4YOCsi
	EwLzoi8D47s=
X-Received: by 2002:a05:600c:3495:b0:490:3c90:2cda with SMTP id 5b1f17b1804b1-490b5ed636amr10835505e9.20.1780439361703;
        Tue, 02 Jun 2026 15:29:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b612f92fsm3362605e9.15.2026.06.02.15.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 00:29:20 +0200
Message-Id: <DIYX2UV4C7W8.212LVKLCI8WG0@gmail.com>
Cc: <peterz@infradead.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
 <david@kernel.org>, <rppt@kernel.org>, <emil@etsalapatis.com>,
 <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>, <x86@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Replace scratch PTE atomically when
 allocating arena pages
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, <void@manifault.com>, <arighi@nvidia.com>,
 <changwoo@igalia.com>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <martin.lau@linux.dev>, <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260601183728.1800490-1-tj@kernel.org>
In-Reply-To: <20260601183728.1800490-1-tj@kernel.org>

On Mon Jun 1, 2026 at 8:37 PM CEST, Tejun Heo wrote:
> apply_range_set_cb() maps the pages for a new arena allocation and return=
ed
> -EBUSY when the target PTE was already populated. Kernel-fault recovery
> leaves the per-arena scratch page in unallocated arena PTEs, so a later
> bpf_arena_alloc_pages() over such a page hits that -EBUSY, and every
> subsequent allocation of it fails the same way. Allocation must install t=
he
> real page over scratch instead.
>
> Overwriting the scratch PTE in place is a valid->valid change, which arm6=
4
> forbids without break-before-make. Route through an invalid entry instead=
:
> ptep_try_set() fills only a none slot, so the PTE goes scratch->none->pag=
e.
> On finding scratch, clear it and flush_tlb_before_set() before retrying. =
The
> new flush_tlb_before_set() is a no-op except on arches like arm64 that ne=
ed
> the break-before-make TLB invalidate. The loop also copes with a concurre=
nt
> fault re-scratching the slot.
>
> Arches without ptep_try_set() never install the scratch page, so keep the
> must-be-empty check and set_pte_at() for them.
>
> Fixes: dc11a4dba246 ("bpf: Recover arena kernel faults with scratch page"=
)
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> ---
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
