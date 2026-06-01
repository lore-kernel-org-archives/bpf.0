Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3291A239A
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272993; cv=none; b=KejwdTcs8blQ9JlOO6K0gr8k/eXncOvmu3cAT/L1AKCrkm39Yt7LT9XsNJHYZwVQ3TLRuQRd2yNoyKTVOY270/7y8vtoEJspaZ8C6Q5sDg8yp/JJz0EC3ESvBVdL4wVkXwJefpjQ9l3DAE4pa0M4ZIZTbUUZlf6YMSgc1ZLLY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272993; c=relaxed/simple;
	bh=U/Nl6wR3sC9zWrUXUr0okCgaH9pl58OSQrMDaxSxSsA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gg2SnPOqbU2qiINBTIjW8z8Kq7ghFvys8We++mE8+G8i07QZ1iNCNILj7+kbU8LWTTGpVPkPtNUzwz6tAlKqvIh83O/YRFuqetwRapVGkecEEPI4iRhT8xzBcMwyG/7anAw4SlMv2iHJpYVzKOjs3pAR065rMSxossxa3xm/Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNE/0tZg; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNE/0tZg"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4854c4040acso5181536b6e.0
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780272992; x=1780877792; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQdZFdRPMl5NqctlRONekKw7Ci+pCu3VSk8zafduNPg=;
        b=MNE/0tZgCe465Y8JAH578VuOjWdI7vmY9wV4HDuuvT4XY4yHmlHELwgj9PDpt6MEEg
         NmLm7htFmXq/kf2wXKKg9BDNnLl0LlYYJXhiTzpTVYjDeAuY8HnnKAJ2HzJfyQ6vPxvU
         tJ8N3i4jrtAQZT/WmLT3bx+Hj3RuLKmpYptG/bFwzyXHbSY1XYjtFW4S1fDDpwPOdf0+
         KA/1KRY7YVfYQaksd+G3KAqM4PKbUpiCd3lUcfwMjeNX6M/n/9UzA102rgsD3Z2ZKVe8
         +rWzuszcWwY5GppTyDdBFQFNLHXCYsjRy0THemLoWUA46dPCbLhQjh77sZ4YWe9smq/Y
         0uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272992; x=1780877792;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQdZFdRPMl5NqctlRONekKw7Ci+pCu3VSk8zafduNPg=;
        b=FN7qrpQaT0KO3vNo20SKPZUaAz1S3jO+d0sriMGIX/huJyRvOBkrya1ZXZ/upHIerm
         beOY5u/NQ3NUhFJ/PzBiORZ+ksACRMQ89ipY61WWtqCcMkcKx0fwnU+SKu8Z2SVOMT8j
         CdUD7SwzKe50dYjioFqA/A2Er7/Ey7oahgbxQXGJYexQxPa9v1rFbQRzYiSwWCyF3IJM
         2w2KW9woLNKyXK+ygza895YfPEOy8BapnqMc567SfRqx8q6GMQaFEal0Sr51BkpoMOuP
         OyMmPVV4/FDkne2uZcZ8VeFJgVnQXFE0XWIZNlckJVRn98j/tSYvMweY4bnBwpmwXdRD
         7V8w==
X-Forwarded-Encrypted: i=1; AFNElJ/52N0KImPK2XZ659mjH+eLKhJV8xxHhBfqZeQ25HSDRXfFH7rTxjFfmxYO6WlkUQJRd4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzie7BxxKKUl6me2ln1jX9fPoIoiXCOQJGeglweaVxAaX1V+3Ho
	zDo8JjZO9xquy92jRtilRlZ7XQrKXp96lI57SYZx784sSJlS/ZmsTBPw
X-Gm-Gg: Acq92OG8BbEl4hwOpElN2YLEhJOk8kxqQu1UEiuluxK6+MvhzOrHQWguTSM/5LZAW+7
	Y5PtuoUqJ/tFnLtYAZibrzstm0O4Fnzi8or8fDajaQhrnumTv7wLp1AGH33IBNut4/Ur7N5U/sI
	zQzN/GlLb677o3KoSlSgdC15EhVPUzpHX77Slml2vJUhHCWln4rMfPx5B6ZNP0S3m4Iyf7vRP7x
	GvLbQBIWLq4KOcleKre7rDwhBKXl5Gqhe5X2NAr2llWBp+zhNaKpaAorwGoTcg6zM6JSGK68abZ
	8l0/n+7TyVM++EZFJwsTuNreDLh4Zd8UYK712fy8MuKb+a5YR5fA+GLBrqcGtDWHTCMeFWtnwLr
	MX5uhmxtLU9PC9+qB/UTzsHXIXkDOmb9fxQjw/Po05NYTJ9foRlOJao7id9b9nYspyDr1CB7R8u
	zRKl4ksl1XlZXlQtO8wlnlA2XdFO5mC9anKnB/Qd3oDoW2yCT7cYf4WvMJCeeowUroPopV7DyEo
	0Q6l5J6xCM9v0Iun0w89OYV
X-Received: by 2002:a05:6808:80c8:b0:47a:499:b616 with SMTP id 5614622812f47-485fb2aa4c8mr3766450b6e.16.1780272991503;
        Sun, 31 May 2026 17:16:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48605f6a576sm3396395b6e.4.2026.05.31.17.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 17:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 May 2026 17:16:27 -0700
Message-Id: <DIXA3RWL6XLD.1WZMXZRHBH1SD@gmail.com>
Cc: "David Vernet" <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Peter Zijlstra" <peterz@infradead.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "David Hildenbrand" <david@kernel.org>
X-Mailer: aerc
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-3-tj@kernel.org>
 <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org>
 <DIUMP21RASZI.2VNQV45RIL209@gmail.com>
 <3901fe0537edee9d7acdfd91695ead28@kernel.org>
 <CAADnVQJ+CqAszS2sSVu7gSfA_g4oaTR+SWmLNMX3_8c=OdR7NQ@mail.gmail.com>
 <ahnedQ33ZH8ogjbC@slm.duckdns.org>
 <8cc56c7a4aa29628b7d17d85be7eadb9@kernel.org>
In-Reply-To: <8cc56c7a4aa29628b7d17d85be7eadb9@kernel.org>

On Sun May 31, 2026 at 10:47 AM PDT, Tejun Heo wrote:
> Hello,
>
> I posted the check removal [1], and Sashiko's review flagged a
> break-before-make problem with it [2] that I think is real.

ohh. interesting.

> So instead of just dropping the check, the install should route through a=
n
> invalid entry rather than overwrite in place:
>
> 	while (!ptep_try_set(pte, mk_pte(page, PAGE_KERNEL))) {
> 		old =3D ptep_get(pte);
> 		if (pte_none(old))
> 			continue;
> 		if (WARN_ON_ONCE(pte_page(old) !=3D arena->scratch_page))
> 			return -EBUSY;
> 		ptep_get_and_clear(&init_mm, addr, pte);
> 		broke_scratch =3D true;
> 	}
>
> ptep_try_set() only fills a none slot, so the slot goes scratch->none->pa=
ge
> and never valid->valid, and the loop copes with a concurrent fault
> re-scratching it. This also closes the set_pte_at()-vs-ptep_try_set() rac=
e
> I raised earlier, since both sides are now cmpxchg. A broken scratch entr=
y
> was live, so the caller flush_tlb_kernel_range()s those pages when
> broke_scratch is set, like arena_free_pages() already does after clearing=
.

Makes sense to me.
