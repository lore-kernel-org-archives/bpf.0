Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320493D45CF;
	Wed, 15 Jul 2026 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154383; cv=none; b=aSiNaCGhpUWS31l5wspG6aT8pa1jPgj+vGiG7QTIT3G8ZoF09JXpm3VZJu3aSz7r464+O2xkQCaZjX/5mlLWJsBF/B0/uQ52hTze//DnJd2fFvumHQRGT34h68MRFHMPFtIYlSjFkngerrxldhqxRvPCYMrUTyPJco9iWcOb6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154383; c=relaxed/simple;
	bh=dT4hw1+ypKj5K/P0a1P5tWqIFAyCLoV4BCgRpq9A8Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYp8QZIT3BlfUqhf3h1Q9kAd1mFELoSDqUN07QAkx5/WPCXz5wtzgrf7GfcATMoPmOpfxPcLhfapvGs5xQU7aL97sLdUtn2HaASLWSJeB2/u6G8aXq/i1etx2viUidfhE5fSAbNLEtcCTLEjqAKU2TBr6kJR+oe7XjMmiYt+eZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xv5mlaFG; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xv5mlaFG"
Message-ID: <08a1f21e-e789-4db6-a043-634c1cd00949@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784154380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtnnehMZkL7KEYGIb8KhGcOOY4nCAo0BpcSNP6BC17E=;
	b=xv5mlaFG4XiRdrfPRvaBIwhhQYOldYajEbAj0QUBfcca3QrUJHReWeq85HqnSA4ApdZGQK
	TYf8SJxgCeUWZydc9Qo81LGWsKsqiGGHrZgO/ARwx5QZNBBy+dciEaVsFxIiSA+9JRz/eS
	MFFhqMUhWK6gQXpn671bh5oRcC8LxJQ=
Date: Wed, 15 Jul 2026 15:25:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 05/10] bpf, x86: refactor BPF_ST management in
 do_jit
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-5-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-5-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> In order to prepare for KASAN checks insertion before every
> memory-related load or store, group all BPF_ST instructions that indeed
> access memory in a single helper to allow instrumenting those in one
> call, rather than having to instrument all cases individually.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

The refactoring looks good to me.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> ---
> Changes in v3:
> - new patch
> ---
>  arch/x86/net/bpf_jit_comp.c | 99 +++++++++++++++++++++++++++------------------
>  1 file changed, 60 insertions(+), 39 deletions(-)
> 
> [...]
> 

