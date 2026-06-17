Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218ED3128BE;
	Wed, 17 Jun 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686379; cv=none; b=Seb1dPTm4ieYTc4RuucYsC42APVAFIVjI0GfltqMjOqtyvhC7r+VHdf+p0EXR5NuAgVw9A0RDrop8FkEwSY4LEU+gFdF6VfsC5KHg4xL4Y50DSC2992KOgIXHtsBeOzsNTBHBxbpGtxSIsGfO0bBkShuNxKjMW4RIAUL9dVHHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686379; c=relaxed/simple;
	bh=pUvQSNLWLRh7OpfgodfrsgtToT9DzCGSyR/QzanlZTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=blkW1Ox0zw8l93WA4LiV2Y+gv5Z6iiaY2EE8KT1IlP03IqPx07uEEMSxn9Ed/j3t3onpziTKwjdEGW89LZOK1xgVLVSJJtHLjpg/B+jPdL39K3tiE/oF0XF2fj/5DX+WGB8t6U9Pv/QCGpq1pNPP/k0vosyREKUt7rFc0HJF3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=U8O7i/mO; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="U8O7i/mO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1781685955; bh=EnC+xQ4kjAflTt/HOK2e1CKwIXuOTQTQ4uzmcNK7l4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=U8O7i/mOH0wiYi63S/ed+enhvGbhDDC2J+vtgA0p5pjaRr5qEsz22ixJcMGdvhEcw
	 BwnPOmws5mCBdlcInMHUlJIqxlS8UzyjGjEJey4rr9XOiI35zxuQXSye0yA5sAVFAm
	 BnjHqhFVq6h13T9Yr8nf9x5eHPJtw5qXyA9qoLFVyLhAYi2uxyzOVLLdkS1zq3ex4v
	 fZ6PbVwD/cJMDwB1I6882xFY43K6Ucn0frybtQZAiiGA6AOs1Yg2kSyUREYina0F4E
	 ZPty9+V4DE9IQgBM897cNiYvuLLcWQs1s5B9WFjybcGVXXsx2igmfx56Vpe2yRA7ui
	 TJH+vg7p4iqrQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ggHWR51djzPjj5;
	Wed, 17 Jun 2026 10:45:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:d9e
Received: from localhost (unknown [IPv6:2001:620:618:5b8:2:80b3:0:d9e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+7VQ1Fq7UmwSr5wNINd1K9w5LBzRtcyQg=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ggHWN4LgxzPkny;
	Wed, 17 Jun 2026 10:45:52 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  John
 Fastabend <john.fastabend@gmail.com>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Shuah Khan <shuah@kernel.org>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover stack nospec slot indexing
In-Reply-To: <20260617-f01-11-stack-nospec-slot-index-v1-2-e3a080b0cd7e@mails.tsinghua.edu.cn>
	(Nuoqi Gui's message of "Wed, 17 Jun 2026 00:57:56 +0800")
References: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn>
	<20260617-f01-11-stack-nospec-slot-index-v1-2-e3a080b0cd7e@mails.tsinghua.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 17 Jun 2026 10:45:50 +0200
Message-ID: <871pe5v9kx.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nuoqi Gui <gnq25@mails.tsinghua.edu.cn> writes:

> Add a verifier test for the fixed-offset stack write case where two 4-byte
> stores initialize opposite halves of the same stack slot.
>
> The test uses the CAP_BPF-without-CAP_PERFMON loader lane so Spectre v4
> mitigation remains active. It expects both half-slot writes to emit nospec
> in the translated program.
>
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  .../testing/selftests/bpf/progs/verifier_unpriv.c  | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> index c16f8382cf17d..9ebbd4b531df1 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> @@ -976,4 +976,27 @@ l0_%=:	exit;						\
>  	: __clobber_all);
>  }
>  
> +SEC("socket")
> +__description("noperfmon: Spectre v4 stack write slot index")
> +__success __success_unpriv
> +__caps_unpriv(CAP_BPF)

Not sure if the conditions that led Kartikeya and Eduard to add
__caps_unpriv(CAP_BPF) explicitly for some tests also apply here.

It seems adding it to this test will not provide much benefit because
the other tests in verifier_unpriv.c already assume
sysctl_unprivileged_bpf_disabled=0.

Because this already affects the more restricted 'unpriv process under
sysctl_unprivileged_bpf_disabled=0 without CAP_BPF' environment, I
suggest dropping __caps_unpriv(CAP_BPF) it.

> +__retval(0)
> +#ifdef SPEC_V4
> +__xlated_unpriv("r0 = 0")
> +__xlated_unpriv("*(u32 *)(r10 -4) = r0")
> +__xlated_unpriv("nospec")
> +__xlated_unpriv("*(u32 *)(r10 -8) = r0")
> +__xlated_unpriv("nospec")
> +__xlated_unpriv("exit")
> +#endif
> +__naked void stack_write_nospec_slot_index(void)
> +{
> +	asm volatile ("					\
> +	r0 = 0;						\
> +	*(u32 *)(r10 - 4) = r0;			\
> +	*(u32 *)(r10 - 8) = r0;			\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
>  char _license[] SEC("license") = "GPL";

Acked-by: Luis Gerhorst <luis.gerhorst@fau.de>
