Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BF43C057
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079918; cv=pass; b=IP8lQCjwq2PEKclIazUEQS85zWoMmfnyaxQ09L8YbRGe17h1uFMu3soaxXDQ2JlM02jyseiwJ8bIRfuX8IbpIFuSCdZhklfintPWKkpAuePa/0/akUu29mjBS86Wv+GmEvadPLjBZP+7/7eI1NPzUzu+PdCg6IsIvDpKbmW0nAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079918; c=relaxed/simple;
	bh=/iWiuvGopjfPOqN1ltMMiCqrYpx4WW05J/mF6yDghGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogrnhsoVZbQQbquy/eGWXXN7kdARqVgxTiIULCC00rKT808uRPN3Xc8Y66pDG+OI6ckpR8GFJQzuHyPKwsW7uqQpD5ImSXpvaykyGrIrFD+FZTb89o2M3f0LLEalOq+wNGyZfdYoDOaQa7f4UIQUIS9J4z/lIzpFYjWMeE496zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed5zffYz; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed5zffYz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso68132045e9.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 11:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079914; cv=none;
        d=google.com; s=arc-20240605;
        b=lS7xc0rzSlwFal213dxCLqe5g60mEMELb2pMEKwArTqLaoTOnBro5YNXcKF9xJalww
         JCFyovv0P8v1ZwrzMq7zdqbUAvAQE5EHynPrZUkbvsXPelfZNIr1IyIr6eNX53fB6xhh
         7wQYgW95EBHRvHTXJQWqCPrMuZYj/XyShToa89T/XeTxdOQEw7mIJyHcdtSsm5IoO/aA
         qO9Aa6lTqIW/awM0RZdGxKB038Qm7cm3t+dy8TZAej8v3SJsnlUZx6fG3y1VXNNRskNd
         cyooyyBsw2jWZAtcI1zvdk63EIp4SCIoSe5bX4wnwCwS7w0SdJFvBWtE5OCNC6lpeWRx
         wh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/iWiuvGopjfPOqN1ltMMiCqrYpx4WW05J/mF6yDghGQ=;
        fh=J75y2qs6OwEPMqHZDTBrIJlMRlFdhnniml4izFoxQ8I=;
        b=JVH9pihCGPWFwBPDK/oqE2lxH09CaGwS8wv2gJqQc86L+X7UOgWzGax2wbtvyaDaHF
         SRfLl3W9Dk7pT8H2y57Q1RSXywd2z7C7g20knv5V2Pvj+zxVPKubWFBSexn5hWdjDkGX
         BH3bSrlD3FEfM9w3dX7Z4gzml4mM4hpYBZb7eNWtSj5MGV6GXs0aSa0OJA7Z3C+/cuvd
         t56mIuUAt8KbVQWq2mUk9feI6OrSSk5asTUjtioUgbEpBKb7dlBGvWK1Apmghc89brhR
         +Qjz79SPlSX4J+XuvXodVkIJ445vrEAu8cpOB3/mFJK0m9tAofVTUZig0RyewB4SffoQ
         n2hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079914; x=1780684714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iWiuvGopjfPOqN1ltMMiCqrYpx4WW05J/mF6yDghGQ=;
        b=Ed5zffYzmYf1XBY3Qk/7jyA61e0lScof3KPU5sqVXwyB2O2N+fgLgSzrC7L3JFE9Xu
         y3WHH3vvbQvWZJErpULeoWJtBMGYE03deQKZZTuvRBWhFn9nP8ZidKjDZ0kmG6heCNH8
         IcF3dWjOc2uM2CDadGpkm3gTKTDs0ei3MIcuyF5ksl9sTHebSianqiIWCCycP/CEJrem
         hGeldblYgKEh5dLNId1ajrpHarqvW1JqwFpWJj0yTzQywBj84rE4IBssr7W9yvS2FEFJ
         3jzSSQIfaOPuMGl1D6pd8432GmCLTwuUvHo+8ccWBsanST8rWdoAgRVxkL5PRQz4z5Ft
         fXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079914; x=1780684714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/iWiuvGopjfPOqN1ltMMiCqrYpx4WW05J/mF6yDghGQ=;
        b=nPc6RkZBgxKOD0xxo/VaS+MRA6opw/oPejKaxTIJ/1dVoR9FCViVSznLQDAqk0eR8e
         m1pcBX7wuTVQZ0sWSlI6lo7T7hiJjr+qHOqhYmDbWOYDwUgNTPGnfRhf879k+V6UvGmI
         xZ9Um1E8f9cRBabk8Dlkmtw6C17P1zh7nz0aodAVmU2OESLIjyXLEC9rOPvVZ+GPAfr0
         BYTAs4VHlHpatV14cw5l0xdGSTxklr10LYLykALMkvvSUp9/MOx15oYkVfCcMf6bwWS/
         VuElmOfYmSZfW/uN+pcRFZX2KTMLygRYaCSBjYN/0jzNtd8QK+Ri4AHDj8EZIgpmcQJh
         4wCw==
X-Forwarded-Encrypted: i=1; AFNElJ+TEs9ubfiyyPDSkl6Y77r71ken572dLhEUdasfH8cGxadAyOKrzAoy4eYs8thGoABMbH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Dda4I33RXxfORRW/j6OiLjvP2GSQQjIkn8rk9sc0q9wi9BFr
	TDLdif71ihN+aUCz/pQGcrKFe9UiRp/fb+Ohpq3VxMVQHC4U0hgYVkod2Ucm3ePNEHFQ55jAq1h
	CI8ErBzAI/8E/Tm7ago5LFnoYLiawpCs=
X-Gm-Gg: Acq92OED+SYm0JoTUAwRmRGq+qH4gkRcJHb751rwsLXe2B9zrbuauvAC7P23gCusg15
	TklfoMd+sAA5AWSlDTf5KV4BNrbhyqmQF89CIsPzkoJ0Zn4+HvkDeg0/xR5l/9ZAnFI7itbe7/1
	LeoACZfGPHVwohswOMeiuOORZVbD7zl1KX9gdP5/c4E16cMDMEUD5SkT1ZNrBVCIyprEqgAQTJD
	fN1SGn8OpagjDvqZTIF7P0MqZjkZAqOIlJk6hkWRc8DvTMuCgPlrIJXYz/7gv/Lb7b8RSLbL3Wf
	+qk8F4P4jwiA1wKAP6GOMDbrYOBuHEsoXM4rry6U8M61HOL5PQK81QV333UQ6NPpi/H6gN0ApFx
	UNyuiypadvhnGPXPDvyEHYbh84qag0EOwFiJ4Mi0497Whdvw=
X-Received: by 2002:a05:600c:34c8:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-490a2b6e3d2mr7261425e9.5.1780079914175; Fri, 29 May 2026
 11:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522172219.1423324-1-tj@kernel.org> <20260522172219.1423324-3-tj@kernel.org>
 <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org> <DIUMP21RASZI.2VNQV45RIL209@gmail.com>
 <3901fe0537edee9d7acdfd91695ead28@kernel.org>
In-Reply-To: <3901fe0537edee9d7acdfd91695ead28@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 May 2026 11:38:21 -0700
X-Gm-Features: AVHnY4KtV1pUn-d6UzBaLOg5AUfIedwDfvDWPug9r5TxPVQH38dOVxXqqoga_T4
Message-ID: <CAADnVQJ+CqAszS2sSVu7gSfA_g4oaTR+SWmLNMX3_8c=OdR7NQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
To: Tejun Heo <tj@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:12=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> > It should do set_pte_at() unconditionally.
>
> I think two concerns are tangled here.
>
> 1. The racing write. set_pte_at() and the scratch installer's
> ptep_try_set() hit the same PTE with no common lock. On x86-64 and arm64
> set_pte_at() is a single atomic store, so it can't tear against the
> cmpxchg, but a plain store racing a cmpxchg isn't atomic in general.
> David, is that the worry - an arch where set_pte_at() is split and could
> tear - or something else?
>
> 2. The SEGV. It's a BPF program failure propagating out as a SEGV. Maybe
> not ideal, but as long as we surface the BPF error properly, it doesn't
> necessarily seem broken to me.

returning EBUSY because apply_range_set_cb() hit scratch page
is SEGV out of arena_vm_fault() and arguably ok-ish,
but bpf_arena_alloc_pages() returning NULL because scratch page
was in the range just sucks.
Earlier bpf prog passed the wrong arena addr to kfunc and triggered
that scratch page. It broke the contract and kept the pieces,
so ok-ish too, but overwriting scratch page with proper page
during bpf_arena_alloc_pages() is imo much better behavior.
That scratch page will cause all future bpf_arena_alloc_pages() fail as wel=
l.
Hence I prefer that check removed.
