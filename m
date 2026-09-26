Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE5346AFD;
	Sat, 26 Sep 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790443084; cv=none; b=XytJ7HVQyulhR482b+atSb6jRTSdS9khViIBl3aNPQBxnbX8L03u4UzPa0QD+tep4ZU+ASf9jCR4mDmiUxNQlPMqXpY4kVDJqgHa0jEg3H0IstQqQa55ha2DheMpPXb8SN1yw36BvOM4fHQ+kFeZLzOCzEgHHWK0zE9/B2ptgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790443084; c=relaxed/simple;
	bh=KiyhR7YT6BLjMTMxrqbHMLdNAeUMBaZjGhaED+1Cz2A=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date; b=YM2VTaOfjWMD/y3XwkQPBbTJcmkGXwPkc6GjdXeZVm2Xe/Ff3L/PjS7+MO8ym3fXSalRz5JP/Z9g6pL8UqKuFGtwVffJi1I+5/mNRV8OHpWEDhLQfH64ojdB8ucvqXeBNJegoOltSehCfV2+2APr1KFxlHAvNa0Ls3Tcomc8se4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdRIAXVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdRIAXVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DA51F000FF;
	Sat, 26 Sep 2026 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790443083;
	bh=Ap2kkGH7BmMrgTZ5fBs3gkn2Ihe/QJlQzEHK0mLyAwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UdRIAXVJu8+N4/SkqDpW5Ne6SjU4XGytQ63wC11Ab7hjaffd3wZ1mbQR4r2UM0q+D
	 wC314zD07x9vnE1QkGJfjJbtYUWRgqVCOVXWRBhHzlbjS2pDXkyArq4XhikNBWDhdy
	 28wEmktFe6e0klK/tsClObzh9Os6GLDYcX1liKeJtNpbT7f2AtJeVggOh0fcPBunW9
	 CjB2WKyKZE99QVwla14vPkXH4YdA5KBGVkqbk9FucY4qoiAsxxsW3GE+qbnOw4r8R2
	 cCC75PIiOCkeAJ/qfpAppb1dfoTQ5q+11fNt+1mNUURxqn52ruoI0cuB2XIwc9pSPO
	 etWf52z8b68Ag==
Message-ID: <95657985e60bb3287c53b960c64aaf86@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf, x86: Support fetching AND/OR/XOR
 atomics in arena
In-Reply-To: <20260925134828.2012199-2-puranjay@kernel.org>
References: <20260925134828.2012199-1-puranjay@kernel.org>
 <20260925134828.2012199-2-puranjay@kernel.org>
Date: Sat, 26 Sep 2026 07:02:58 -1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello, Puranjay.

On Fri, Sep 25, 2026 at 06:48:20AM -0700, Puranjay Mohan wrote:
> The first CMPXCHG compares against an unrelated value, so barring
> coincidence it always loses and the arena form executes at least two
> locked CMPXCHGs every time. A losing locked CMPXCHG is still a full
> read-modify-write, so this is a real steady-state cost rather than an
> occasional retry, which is why the non-arena lowering keeps its load.

I'd prefer the v1 lowering with the load and the second extable entry.
The extra locked CMPXCHG is the common case rather than a retry, so on
x86 the fetching insn ends up more expensive than the load + cmpxchg loop
that BPF programs hand-roll today, e.g. the cmask helpers in
tools/sched_ext/include/scx/cid.bpf.h which are being converted to the
fetching builtins. As is, we'd likely keep the loop on x86 and only use
the fetching atomics on the other archs, which defeats the purpose.
Andrea raised the same concern on the scx side:

  https://github.com/sched-ext/scx/pull/3839#pullrequestreview-5318408089

The second extable entry is some added complexity in the JIT but that's
paid once, while the extra CMPXCHG is paid on every operation.

Thanks.

--
tejun
