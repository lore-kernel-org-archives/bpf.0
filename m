Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F13655E5
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782874803; cv=none; b=hBCHExsv3AGl5mUE6GFYlon6FqSyZIPSMKTuW6snrDicc5fgsEVTfdxNi30/mvWXowXpWCJOSpaYftjb3M/6S6ZeeU6XWMVDzL6ebr665+Igej6gI0PuzHcRidnlBGwtW31mO7zFjI1Em+UssfCGBXkU2Yq7wYjw6JCwK8/rDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782874803; c=relaxed/simple;
	bh=5P83V6vWgCImeuynuBzSptrpGhtSREd+l0Jf7NPHkdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beyVgddnt64NXaoY3fgpFbRQVHaYug4UGcxdQsPWRofCI9FRA2vB6ABFYyIdtX2tmceQQujP/W8NJM+44jK3kSCJ1VgysiCi22dYiUCfigA0BV2GNSBZaXAcPq3F/ew6DyaVTDiWBTl/siQ7rmMYu5SFNwLmfG4BbTv8433QyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gMvHvSMV; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gMvHvSMV"
Message-ID: <18678d0c-f878-4d7b-bf7e-ffca4967dec5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782874790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yIRhfH8+QW0w2xHkvd0rrvEbPs85DF8cJWcE4hy3pGU=;
	b=gMvHvSMVqV1rHUalg0OUAEOBUdoh823uJP1FBuzITK7d4DZRrsOdr/9k/m3eplcH7TM4bz
	XqQTHIE8GaZmdZdFqgkR/QtCLt/Ed/ifR/Ta1tbGSYIEGTq68aY7ugPyVDbcxeWQgtL6l4
	YEoCC17J9W2KMxldSMAOE7tFhxcWrLc=
Date: Wed, 1 Jul 2026 10:59:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf 0/6] bpf: Disallow interpreter fallback for
 interpreter-unsupported insns
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626154330.33619-1-leon.hwang@linux.dev>
 <DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/7/26 07:12, Alexei Starovoitov wrote:
> On Fri Jun 26, 2026 at 8:43 AM PDT, Leon Hwang wrote:
[...]
> 
> I don't think we need such fallback in patch [3].

Do you mean we can add the internal BPF_ADDR_PERCPU insn support to the
interpreter?

See my reply in "PROBLEM: BPF interpreter fallback after JIT compilation
of BPF_ADDR_PERCPU leads to kernel panic" thread [1].

[1]
https://lore.kernel.org/bpf/90c32de0-feac-4e63-9757-2a1d115be08c@linux.dev/

> 
> And approach taken by this set also doesn't scale, since it splits
> the verifier/JIT logic into core.c which will be hard to keep consistent.
> I think we need another bit like jit_requested in prog like 'must_jit'
> that the verifier set for addr_space_cast, kfuncs and the rest.
> 
> Then the core.c change will be:
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..5126a43c1b81 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2620,7 +2620,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>                 goto finalize;
> 
>         if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -           bpf_prog_has_kfunc_call(fp))
> +           fp->must_jit)
>                 jit_needed = true;
> 

Got it. Will follow your suggestion.

Thanks,
Leon

