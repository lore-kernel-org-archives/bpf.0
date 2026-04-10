Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77C2BE7BA
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862429; cv=none; b=a1IGTzDd1Yfcbl6MVWgDShg8pmkH9pFuzh1upY46lWBODhmi0iekvRm2gc0K+8ydjXvBArC7rgYOaPCopZG0gvhvs8Ukeqcs2WDr56Ap7jiN0Z/dlTCidwANaZviUD4cYQ/kr30azSsQ4vU2xJFq4Bf8TYD9JhHFr8yjh/Em/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862429; c=relaxed/simple;
	bh=emdC1XT4Nw4X60rUVpBMukGfEk7nMJ3gsPVu9rpfRzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDVfGXtq635/MMBHmkx1ArsGmcqCY2gy5Zg8/KevVR1cMS5UhaK3Url/1Hback/ZVcDcxmxHeMsHP7I3K47Ze3+6uJ5BFXY0rrV4pdnQE6XxQ7/dkj9RmsjNFQRbpa5jUNKxUCw80jz2IyE6DRoA/9EFmazImrQaKcPGTvE3lZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDti3tdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDti3tdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3D2C2BC9E
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 23:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775862429;
	bh=emdC1XT4Nw4X60rUVpBMukGfEk7nMJ3gsPVu9rpfRzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DDti3tdqnrq9TJ8fpoJY5yKanmhB/5RfSCY4XFUt8nzTgGN1vrowLhOiLHh4Lvbdw
	 5p5x+bYvbSFtxuF6OcSRfUovhNXkoYvFybcxOhzGmLAzXAUvHfKJgAavviVAQLbSQf
	 dphfaCNb6HnEuwAFek08oQa8AApCIOWh0GcZ6IXyr7KREfxNcP1I1W3CiBO/kjORKQ
	 JWI1T1OhzLtO6x3BvrrAoPcfQVS/x8luMRR0ie1UoNY8DMehHMeTbQuGYZdmGAPkHt
	 KHBTud/8aCO336vPUtCYFcTRZSwDBrZ4D5HH0CqEVp4KrMf/CLUvwnurrLOjEJC+l0
	 dgyH7mCiIeNZg==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cbc593a67aso230403285a.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:07:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8z2M4wwKZkQRVzLlyKYgzGY5P1qkWEpMCPzHTnaJHhbuEFIEa8BBcYsq+FCiYyV4Irh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqBMX1c8fuewxTLnFRI/7dB7V/kk5kwCjfoPc6vI//pExGY31
	XFrB+MQy6fEmga/DjsxrBT2bLk8i9H/81bP6zvne/a7RjOsFnb/vLMJxcL7y+FyXglAzgHcceHc
	aVG4KCLzes/V1gMU5bWGigaU61ziUMFA=
X-Received: by 2002:a05:620a:d85:b0:8cf:d62a:c81d with SMTP id
 af79cd13be357-8ddcded6af2mr753068985a.29.1775862428044; Fri, 10 Apr 2026
 16:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410163041.8063-1-emil@etsalapatis.com> <20260410163041.8063-6-emil@etsalapatis.com>
 <CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com>
 <CAP01T76gQXua1e+-zQxHcO2W9XHVe23t+QCCT3bWR_UyRWL27Q@mail.gmail.com>
 <DHPQZ0PMVOS8.OYBETSS0OQ34@etsalapatis.com> <CAPhsuW5ZAxvMy2LeHOc_QjuEViwK-MmPGNf4kjopAnLsPTO3_A@mail.gmail.com>
 <CAADnVQKU-ki0azXbZROivqVrajGZ_yHuwJj5U-=byFCOxKpSmQ@mail.gmail.com>
In-Reply-To: <CAADnVQKU-ki0azXbZROivqVrajGZ_yHuwJj5U-=byFCOxKpSmQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 10 Apr 2026 16:06:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7rxqMBQXGems3KxiPRv-wwV5HaiJk_mPCvizhiGF+JWA@mail.gmail.com>
X-Gm-Features: AQROBzCOwHsN93_GiQgWGXjj6rly1kzQBT1NVVnQUTPJrpA03ocMrwiilKU7VQ0
Message-ID: <CAPhsuW7rxqMBQXGems3KxiPRv-wwV5HaiJk_mPCvizhiGF+JWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/9] selftests/bpf: Add basic libarena scaffolding
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:50=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
> >
> > There is also tools/sched_ext/include/scx/bpf_arena_common.h, which
>
> imo tools/sched_ext are bitrotting. I wouldn't be surprised
> if they're removed. It's not really a library or a tool.

Hmm.. In this case, we can probably ignore tools/sched_ext.
I guess we can also ignore selftests/sched_ext? It is not getting
a lot of active development either.

> > is similar to bpf_arena_common.h in selftests/bpf. We can have sched_ex=
t
> > include this version of bpf_arena_common.h. However, it seems weird to
> > have sched_ext code include a header in selftests/bpf. Therefore, I thi=
nk
> > it makes more sense to move libarena to tools/lib/. WDYT?
>
> I wouldn't. In general tools/lib/ is not a place for generic libraries.
> libbpf is there because it's needed to build the kernel.
> libarena is in selftest/bpf, because it's needed for selftests.
> The kernel itself doesn't need it.
> I would remove some of the libs from tools/lib/.

Assuming both tools/sched_ext and selftest/sched_ext are bitrotting,
selftests/bpf is likely the only user of libarena in the longer term.
In this case, I agree it makes sense to keep libarena inside selftests/bpf.

Thanks,
Song
