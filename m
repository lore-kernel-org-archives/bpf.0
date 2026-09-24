Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76FC443C32
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240404; cv=none; b=UTPM/CEc+4ZmUGE3Y4KqczQwiHqukc/hqKJcv7XCe0f+g77K5HAok9VyCkFexI+lai3XhtHrAy1GwvTWzK5NWM3Lti40TJg5j24o0BOfd6Ns2nFMUgVGcmJFFwBoStW+AqdQ9xq2jtz+kQjEbwp8fUjNcscwep6M3hoLjFFmdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240404; c=relaxed/simple;
	bh=gexdfYsX5GqVWJvEQ/hu5MXn/YY9rDFyqf0oxKlXNDk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hlwqEKOLEPcB2LHnCBlliyQ080/u2I9MLk/OKmxd+V2RuyBurvNlHd/GsFDrTliNp5AGTVG7NN6fxlCa1/imIFt5e/dOwrNQOX3n5MBWBg7KjE6XhZeKnTvgtqLSzOP8SY1HEPhBiGcYonl7Yh5qnAht8n+bXFIti/cpXX1sFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHqbwCiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHqbwCiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422261F000FF;
	Thu, 24 Sep 2026 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790240403;
	bh=EgF+CPGZOH0TU2npu3UKI9B8Uly9hzj10rowEzt+tsY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KHqbwCiY6OdZzBQjyybRVR7DX6QBqCDZa0aWEs/4J8/J2TqCsIgepMVMZC1seSAYj
	 A8SH+4UDw166q/RLNSPh81InTRQskXW4DwbL8PxUN0hULE+uXfcID9draxD4DhIyFu
	 5EqdjjaajOVjMO9JQQRbr7zxBoYTYiO+iM8FXR5VlwXS5sg/N9tWSXLcBF77qi/jyC
	 IX51zukOiuHdDJzvTMYFlSyMAtmhGIpoIpb3lxO91sc2GKaTz0CTch9b/1hOfEUijE
	 HHjkEaouxBb1Yeyq+OcjMHyqbWWOn8R/8CXYoZO7f5Y/zurbT/h+q16L9ci9sZpXOB
	 aqoBJXYD7VExA==
Content-Type: multipart/mixed; boundary="===============8963809655352969625=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4ee0bb9bfdc8274a074f6e80dfc65d386e15586e27dd3951317d0eb4b01aa0f3@mail.kernel.org>
In-Reply-To: <20260924082607.2695649-18-memxor@gmail.com>
References: <20260924082607.2695649-18-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 17/18] bpf, arm64: Allow programs 2 KiB of stack
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 09:00:01 +0000 (UTC)

--===============8963809655352969625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
> index be5fc4ac00d6..98d70b8a2533 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst
> @@ -223,11 +223,12 @@ Q: How much stack space a BPF program uses?
>  -------------------------------------------
>  A: A program may use up to 2 KiB of stack, combined over its call
>  chain, when the JIT of the architecture reports support for large
> -stacks (currently x86-64); a single function may use all of it, and
> -every frame of a program running on a private stack gets the whole
> -amount. Elsewhere, and whenever the interpreter is used, the limit is
> -512 bytes. The verifier computes the actual amount of stack used and
> -both interpreter and most JITed code consume necessary amount.
> +stacks (currently x86-64 and arm64); a single function may use all of
> +it, and every frame of a program running on a private stack gets the
> +whole amount. Elsewhere, and for programs verified for the interpreter,
> +the limit is 512 bytes; the interpreter itself never runs a frame
> +larger than that. The verifier computes the actual amount of stack
> +used and both interpreter and most JITed code consume necessary amount.

This isn't a bug, but the interpreter sentence changes meaning here,
not just the architecture list. The old sentence said "whenever the
interpreter is used, the limit is 512 bytes" while the new one says
"for programs verified for the interpreter, the limit is 512 bytes; the
interpreter itself never runs a frame larger than that."

Would this correction fit better in the x86 patch that first added the
paragraph, or could the changelog say why it changes?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35976322553
--===============8963809655352969625==--
