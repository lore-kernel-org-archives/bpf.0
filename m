Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575531F99D
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217500; cv=pass; b=ILnzcPakMryB/LBN01tlMGyJKZYCK5YZdh4YGQgTGGnZNmyd+FhlslQWWZAwGd35nEqDPanuKvPXSLPhHxujVWo+ewGuPH62i6GbKLKdpY3RXFA4wmRVyz7KrIF42zosAS9+Hsmfto8DQAuGZEARy0fgVjmuWP5skji7wkCJmi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217500; c=relaxed/simple;
	bh=cojGRWW/Ex1hiO5wrDav3feItUxRSAUPq9EN/ARWbRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrSem9tDsISlmIow/6FZvFYrAZ8AMeD5eKJ/uop41NTVG0MPFNnFWeZIenOFA6sx8KPzYm+oZ7OABMn0egXoquTroAonKnTsFnBwnZo9EJMQT4nABcMDVL/XywLRDA3dwhWeO6VdybRhNZ0VgZXR+ewKmIfeNUPV7DlquTFMC7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rTDWqukJ; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTDWqukJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so33151945e9.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779217495; cv=none;
        d=google.com; s=arc-20240605;
        b=iMcsZ45sV664pc1zdIvh9hlt4B2EYl09DVhP24ngkjXqxJd2E6fz6I4xET+P5GYvC8
         VTMudztUi/+mvGTlDolxtb5gg7GZKmYYS8MUEmyAp3m1QL8rk74/E9Dfvtvxp8u5StwT
         T9OKsIXE66KNSWxNbNnBD4ogpqrJDZMEXaDdu1D1z+4aBg3UhCFoMCBwayJK/1BigbDw
         e1h+1lBlg7tBNPguthCZ5kUy5+97X8t4PDfJJosTwg4+/LFFTrOxVkPcjO7mQFusMGh9
         WBqW9gZ5JvoWfRmH+W7+RGu3hF/jfl3dxlHsk3MSwUUmxQzWvmbu70iwQ9G5ei3JRI++
         fe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cojGRWW/Ex1hiO5wrDav3feItUxRSAUPq9EN/ARWbRI=;
        fh=/3MTHRFiYJPeQzTW0UHfCHC7PZ9LlQ2y8HrI1J72LJw=;
        b=TvVIxOAEpL5LQXYTtJwY4nZeTJRdLs1C92/Jkzf2jrew1VEPQblK0eVVuXrakj3aFl
         rEM/u0WffzBxI0OmLnYKidwkCvDuraR2+rou7vqC5kraVDPeUVEcocq5ksnSiyWo9wg6
         n0QsCBqoFTaWRBXSz2TU1PWa/oGgrlRxYfcyPC+V49Xno7RdVV2zfUvm6nFFF8zwrSxd
         zpef3JE/ky4KQDcC1Twiy1Jha3niWAt6k92nbRjQB+V36l98gXPfMh4MAYboL2/4IE7m
         TA1C+0rh3KZArCKpU58IXd67jkVVC5lLVRXsHeZm6yTlpPl4TcICmVn6Rim0dAqbqinQ
         lhxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779217495; x=1779822295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cojGRWW/Ex1hiO5wrDav3feItUxRSAUPq9EN/ARWbRI=;
        b=rTDWqukJeTDZ7t38KtbZw4zVQHbIdfeYLw3OF3x8yrqkQEWaPIfDBIe3QYrVX8rXjj
         uHeC/39wulGFephxOlPFndI3R5MKZCHSw8umYUiDMmPKQBFo1J/y5ymMdxsuiAd5tRhU
         xGMkG7efHZJXWzV01UVKJGYBzbbI/aQsMc/xyEzuGNpEVXBMtbLN0ZLKoQ7k0VhtifX6
         yi8lPNoepp5uCds28ByVdLKvXMk3OCXiLDhAVRH+F8+sjeBSA0/30PRFLcnlq49G7wiY
         cciaT7WIMIafXRyp5q6xHQWJXYCou8LUqA5pSQjvJ3XMycvTX4eyIVZqaLVYn8mAfg56
         2Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217495; x=1779822295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cojGRWW/Ex1hiO5wrDav3feItUxRSAUPq9EN/ARWbRI=;
        b=jTYUQUwlL1yK1i/HVYK3wOfP51EMCtLwVVbhOUbSQuP1x7ekQoGYyN7mjXyDcQLgOd
         Yw5YG0I5LSHLJYYu8bqmgUSA6Beho7DvUQMlgnj5QhfoAa6YztIGeFbIS5WNh8J5aJGF
         ie0IiZjNwL4/eFYgzTFyqzc35Z2rRChCvqRJppMRW5mv5Pabs9Kn2HG7urYy9iqH7ncW
         WPUDqNC50ZRsQarx5iS2PYIRE3uLGIY0qNyzKN9LKrq0+uqr44/r/7S3zJ3eWkZ0R2KS
         ePWJn29kSpdYafFenEupbJQ0RMWBSWiXKVcFPH9/pET0J14Xd5aamqAqhdBRVjfJycGB
         dA/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+QIx2ZkNoVktxI9JBZtXKNwN+EUiO3iC1hm02Sn40ddnohkplZQuP9rylsEUarWYp1GT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5cciqQOlLxk6nboj5kiz2LXxoqps1g1becqVJYAfxD4/yLaXZ
	+vx0xScPIqjus3OjefzplLgNYfqAZe3dpaIv22VNzdB+o1bwzoiuQ48WKhVxC8r0nV6ipRxaeBA
	pOHJSSYabtha7FoBHRxI8wrdQOlP1QHA=
X-Gm-Gg: Acq92OGis2xngzjCbdhlkjHV2P1zBISQw5rRN3fUxX1eNHndWYKCRpxfALH7wvho8op
	L4GJOoe/2MSoGrpaL9/8LG5uWQ9hxxaMXogG9JNAHpqv1u12uhEI6MlfQFph7hJKKS+u2FzCQRE
	7qTEFW6rMdN5c6KhKLUfe4kGLUsK7dQG0ZH4Jec44V7VbICB9m1vE0wCdsDS0IcMkmC3+sIFnOp
	RyJLF2Hya6dgbQUIBJYGgFK0jSH0AO+noJ/m0HKwHnzRqEfBQuJIA9RBgne4bqpZCP76tEqBFSC
	dzqirafSN54sEkJgt5SNGyMNaCR5zmBdO/s0u+eW5CUjyTg3yaN5tSAuP2vFxnbWKLXev3E=
X-Received: by 2002:a05:600c:a00f:b0:48a:5301:bb5c with SMTP id
 5b1f17b1804b1-48fe63263dfmr337569515e9.16.1779217495209; Tue, 19 May 2026
 12:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517211232.1670594-1-tj@kernel.org> <20260517211232.1670594-2-tj@kernel.org>
 <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org> <agtuPrgIDNKSu2Oo@slm.duckdns.org>
 <2f02d90d-cdc9-48ef-abe3-99e00f22595f@kernel.org> <297658c4ae2d6e7103f5968efc936224@kernel.org>
 <04b03066-86d3-4c0b-b077-307fd0f3bc9c@kernel.org> <5590fd3d-dae1-4070-b52f-bc40982ac678@kernel.org>
 <agyZxmHoueGwBAQg@slm.duckdns.org>
In-Reply-To: <agyZxmHoueGwBAQg@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 May 2026 12:04:36 -0700
X-Gm-Features: AVHnY4KnCVsDx1rhJ5Rhju09kIJne6tHjry-aCcLnmL6aRppUmxM6vRJAa3dciI
Message-ID: <CAADnVQJt0p7hSn2G074QZRh2LEdthy3RKYJ9j3w5yeJ-e8UQLw@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: Add ptep_try_install() for lockless empty-slot installs
To: Tejun Heo <tj@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 10:11=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, May 19, 2026 at 11:40:48AM +0200, David Hildenbrand (Arm) wrote:
> > On 5/19/26 11:05, David Hildenbrand (Arm) wrote:
> ...
> > >> The only requirements are that the kernel doesn't oops and the
> > >> violation gets caught. Beyond that, behavior at the address is
> > >> unspecified, and which installer wins the race doesn't matter as
> > >> long as kernel integrity holds.
> > >
> > > You'll have inconsistent TLB state.
>
> Wouldn't it still be either or with both cases being okay?
>
> > > I really don't like that approach.
> > >
> > > We should really try to just take the lock, and remove any code under=
 the lock
> > > that could trigger such unpleasant deadlocks.
> > >
> > > Is that feasible?
> >
> > ... or can we run into similar problems with kprobes? (I am obviously n=
o bpf
> > expert ...)
>
> Yeah, I mean, that was just the first TP I found scanning the code. Any
> kprobes or other TPs in the path would behave the same.
>
> When this fault triggers, the BPF program has already malfunctioned, so i=
t's
> not going to be a high frequency path and performance isn't a primary
> consideration. So, anything that can ensure that the kernel doesn't crash=
 or
> lock up would be fine. Any better ideas?

As you guys already figured out the trylock is not an option.
The fault handler has to install _some_ page and let kernel continue.
Scratch page or arena page doesn't matter. Potentially different CPUs
will see different page. It's not a concern at all.
bpf prog is buggy, but the kernel will continue to work without a glitch.
bpf runtime will disable and unload misbehaving prog.
