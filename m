Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B743F0BB
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154728; cv=none; b=HIROKVECq3I83ECmYbGQuqA9hA6xySf0u2GJqfuh4wj/WU58JoU+p5lE+WSUXntIubUJ0t+0is9jzPD/NMRKrXqZWJDZVCO7tK4AIhK46qJhorecBw70CWnuteF0T+1KiKjP1CzOY94CQSLYIh6ZJAYwbyJdIlr3ynb+YJWlonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154728; c=relaxed/simple;
	bh=OK6kCiVOPwe4XhGPzoCxh6vhbTXlmYoWjN89PBR38dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyzfxDwmt6DGags/xrk7LKkklPmcGLv8k5/2rckz9xPwak73NGXzfkkTAs4WvnbxJpYSKsaLA1K/DY6+4qm03lzDIj7igAOw+jGVHGGD7GL7MVYPauErXQzGFmkq3yJg0y9427DzhS284ehCfggBr9STnFJ0JN0wpPE8k9T361A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NdfdyYG4; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NdfdyYG4"
Message-ID: <ded5cd45-fe73-49a8-bee7-02ab8c5d9a87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784154705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eVU6j9QuYxrMLAsUIFDAt+VplE0mVZOYgpwaWM0kk0=;
	b=NdfdyYG4lL1P6HUeRmOZrJh6laG7y1wQ5yILXvw3gYV8hrMYcNInRpgv1ZbRpI6K36hZMO
	ln36Q7XgrHWfK95i4n3Gy11cZjCl6HBJIRzHqPHxky21KrNn9BdMONRy3i/Q/esCh6gg/E
	SHIl7bW5jyJNLIjZ5Wa5nrXH82tAtj4=
Date: Wed, 15 Jul 2026 15:31:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 07/10] bpf, x86: enable KASAN for JITed
 programs on x86
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
 <20260709-kasan-v5-7-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-7-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Mark x86 as supporting KASAN checks in JITed programs so that the
> corresponding JIT compiler inserts checks on the translated
> instructions.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bdad90f210e4..705a9ab85f3a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -233,6 +233,7 @@ config X86
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
>  	select HAVE_EBPF_JIT
> +	select HAVE_EBPF_JIT_KASAN		if X86_64

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_EISA			if X86_32
>  	select HAVE_EXIT_THREAD
> 

