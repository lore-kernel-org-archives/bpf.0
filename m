Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFE352F87
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592721; cv=none; b=DCZkaBRaKsYHyqv7S/BBVntExgbEF720uA+oi6mKdRPdSJbq33+Hh87qkaFZYebPUKSetRC0u3q4HOLaqiHwOujtgpBMF/2Ltl74LbZHI/fa+kCXBDo4PrngAPCQKnZODxuBgd9Z6Ji00iaNn30/aXw/jgY91dbgVy1dnZjoCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592721; c=relaxed/simple;
	bh=6js1o54ryXRCa8VC7u119yh+U5NNqvO3/hqcgoHrtTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2GpwKczXosFyZgnL7GKYmVwZCQ3e+DX44gkJD7uKg8M546gwtiEjQMCHf4VMbbpWX8djLrOVGDWxNHLgS6BWuT5OaiC/Nb00mLXQt+M8HWJ4XnzK9BGbrrdnpPDx6A7pSlQN+rHq7OEvQo3nx/W1O4FHVr8+wbAeZAbT7Bhbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dJeVA1yo; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dJeVA1yo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772592708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiCd+4qx7fOEPmnN8rK1eg8/6oLc65/zTNVRMairnu0=;
	b=dJeVA1yozw+G8upR/M77kyqyu3tVsqWSFOo6CAdEtSFkoQo+6vTmwzFcLUhNRvEKXPLcFm
	qNgEIJAq9sTRytyeJip2p4rk3LeAyv5pt/J5EmGRB/+Bhq31rC07B33yHEggmPaEXJD9dd
	ZvT3eihZMoCh+OM4AwgFXmqwo8knzts=
From: Menglong Dong <menglong.dong@linux.dev>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, chenhuacai@kernel.org, yangtiezhu@loongson.cn,
 vincent.mc.li@gmail.com, menglong8.dong@gmail.com, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH 0/3] bpf: fsession support for LoongArch
Date: Wed, 04 Mar 2026 10:51:22 +0800
Message-ID: <3398058.aeNJFYEL58@7940hx>
In-Reply-To: <20260226065952.4082859-1-hengqi.chen@gmail.com>
References: <20260226065952.4082859-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/26 14:59 Hengqi Chen <hengqi.chen@gmail.com> write:
> This small set implements fsession support for LoongArch.
> 
> Patch 1 introduces a helper named emit_store_stack_imm64().
> Patch 2 implements fsession support.
> Patch 3 enable fsession selftests on LoongArch.

I think this series belongs to the bpf-next tree, right? So pls add the
"bpf-next" tag in the next version.

> 
> Hengqi Chen (3):
>   LoongArch: BPF: Introduce emit_store_stack_imm64() helper
>   LoongArch: BPF: Add fsession support for trampolines
>   bpf/selftests: Enable fsession tests for LoongArch
> 
>  arch/loongarch/net/bpf_jit.c                  | 100 ++++++++++++++----
>  .../selftests/bpf/progs/get_func_args_test.c  |   3 +-
>  .../selftests/bpf/progs/get_func_ip_test.c    |   3 +-
>  3 files changed, 83 insertions(+), 23 deletions(-)
> 
> --
> 2.43.5
> 
> 




