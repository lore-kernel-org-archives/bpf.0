Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265D3DD86F
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506391; cv=none; b=mID2TFr4HFGRacT3iw8qkxT+8YDUaaoLyy5xstKv1rYRJ1iktxjylfiboJP8/OeSWhozivdxTfUyuuQzE4qhzSX7lu0hMXa7LN7LixX0mPpLBeSSCx1SfQJqfYt98Z+2lbMywiCQcttwVm8Rhz3xMLZE1WDkEvHC663ToPrzCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506391; c=relaxed/simple;
	bh=aES+Bi8oumHB9G+ZUD5/A6dNpjwUWMUM1qTQmBo+spQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OohGvuIzbUg2vI9j1k9RqfV4PjSPaY1D7ERClo+H4CGw/yEqoS3Mtekz59BEyMjzTwhwtCqdbFwuUWGbm1pW0ar5J+xowVWVO+gKCch47trnr1N93UAmYaZ2FF/T16tL4GsMxNflG9g+nyjCd7cbIh1eWLsDU7jwvJkxH20Cz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy5ZtGKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy5ZtGKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77EA1F00893;
	Wed,  3 Jun 2026 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780506390;
	bh=qySrxqUzcvvZ/6PfM/Nspl6TwLNs8gU7FFgC/o8JFjU=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Zy5ZtGKgblCqdw5ffJpIFJ/QH5QqHnswvY0ucqe8mPIBwtW3LmzvHDF/5w5+vM0SR
	 VOdxhB3XR345nJhawlJ23SeL6Y/1BlzY4c3FHRC3Dyc5pY0RvIbd/VBGH90zHC60Ks
	 6dhSu3eX77WeSEWlDpiFeXQfu/X2DgWxT77jI91pRIrAYTjpcRutxCOgYWKgR0Xrb1
	 RnsInlGxCRzkXDU3/LtsvHTk+DLXvE0iW+zytpwOERY+cJWrOojAzXmggz7qd8H1ZS
	 gH1ER620lcjCG1DwrlqZM3Od2u6nB3Q6WROmTGBE8MZ6ZRymp4mvpEk2fXj3y+6xG2
	 BjEqiRVm2WY1g==
Message-ID: <f39f555c-ef34-446e-9a05-bbb571944d34@kernel.org>
Date: Wed, 3 Jun 2026 18:06:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpftool - splitting llvm disassembler to a separate plugin
To: =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>,
 bpf@vger.kernel.org
References: <CAEmTpZHLNZWkDTrWwSSvbqcSY93T_mD+DzawOuSnBA6d8VdrsA@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEmTpZHLNZWkDTrWwSSvbqcSY93T_mD+DzawOuSnBA6d8VdrsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-06-03 20:56 UTC+0500 ~ Марк Коренберг <socketpair@gmail.com>
> Hi everyone,
> 
> On Fedora 43, installing `bpftool` pulls in `llvm20-libs` (~140 MiB) as a hard
> dependency, even though the bpftool binary itself is ~730 KiB:
> 
>     # dnf install bpftool
>     Installing:
>      bpftool            x86_64   7.6.0-1.fc43    fedora   731.4 KiB
>     Installing dependencies:
>      llvm20-filesystem  x86_64   20.1.8-2.fc43   fedora   0.0   B
>      llvm20-libs        x86_64   20.1.8-2.fc43   fedora   139.7 MiB
> 
> The LLVM library is only used to disassemble JIT-compiled (native) programs,
> i.e. `bpftool prog dump jited`. Every other use case  works
> without LLVM. For scripting, automation, and CI, dragging in ~140 MB of LLVM
> just to have a single optional command available is a heavy cost.
> 
> So, what I propose?
> 
> Load the LLVM disassembler lazily at runtime via `dlopen`/`dlsym` instead of
> linking against it at build time. When `prog dump jited` is invoked and the
> library is unavailable, fall back gracefully (libbfd, or an
> informative message).
> This would remove the automatic ELF dependency on `libLLVM.so`,
> allowing distributions to make
> LLVM a weak/optional dependency (e.g. RPM `Recommends`) rather than a hard one.
> 
> I've done everything here:
> 
> Issue: https://github.com/libbpf/bpftool/issues/262 (has additional information)
> PR: https://github.com/libbpf/bpftool/pull/264
> 
> I would like community to review changes there (at github), and once it's done -
> send patches to mailing list or ask to apply changes right from
> github. If it's not appropriate -
> I can send patches in the next message. Please tell me the best way to
> interoperate.


Hi, and thanks for this work! While I've got no problem doing a first
pass on the GitHub's mirror, I don't believe you'll get too many other
reviews on GitHub. Please send the patches directly to the mailing list.

Note that you don't need to reference the GitHub issue in your patch,
but make sure you have a relevant commit description. Some related
resources:

- https://docs.kernel.org/process/submitting-patches.html
- https://docs.kernel.org/bpf/bpf_devel_QA.html

Thanks,
Quentin
