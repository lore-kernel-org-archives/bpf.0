Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500F409108
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571813; cv=none; b=aIvEDrWh4Icxx45PGbRwifj8/j/ff1QxrrXhj9N0TDtfl8ZYxdKnOSppCxJ6FGZaizCeL9eZtSGTqlfsKW7o18pH4fOKIXyeN9/HPt5iXQuP0OkWopacsaZ6aB1jC/AJfjGJvqr2FFfJyt8y6yzdKYP2RvVkyEzCp7XK78o1gsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571813; c=relaxed/simple;
	bh=nuw7kSkPbc7YF8N7R3oOAxNMWLVGF0sb+lqe5K6FZV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUjZvHUfj5P1gtcY0tCRmcz51qREqi4EXji/bVZ5m79gAhwyJ+aOubfHrk5uUOxT7iQnMC3MGVOxo/EoJeXVeZ7dOkSX9lY9DKeDwJigmlwzHtql+UWJCCupNDvtczaxYBXv079/hjHS6xAgRwQ/uLyik/+QbkNrb/m1XEH+868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck4pVUx4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck4pVUx4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bec49f7e35eso73798566b.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780571810; x=1781176610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdRymJxIkKDhIYy0E9qICIsitioN8lA6Xugqy+NL/ug=;
        b=ck4pVUx4GU8c81r+2No3/6eIOeS2QM1I/s5fLhr8zfK6lwFGlyYqO72gKvmYgN+j1B
         KGepuBQvMRVgSQ9vdJOGS3Eza1om90nMFE/D63574M30MHQvxYUf+wHG3KYwnHbm9FKj
         fQyKrLmQmFPUH8ymbag/MLCJxeE3mI8vvb5ZvSqs68VxnKi9g4x3PLOaFM1vmd3SKIB1
         kMBakAEWdbqbKN6YVQ8ldGqXX3YJ0u1sMw8ucHvHMYanT9peVcWUzVhAdrjpkHngxPJs
         Bn2YnJRSQn4XHFVLQ5RCaclgPwI08BNZI8f3fZY+5LDeBvkfIYeTJZ2b+n2mwjdqiHWh
         jo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780571810; x=1781176610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdRymJxIkKDhIYy0E9qICIsitioN8lA6Xugqy+NL/ug=;
        b=l+nzNbNqD8F+MJ9/DR+vgVAc2HeuRjy6Qyp2sU4+kRhF0WROBUN5RuGq0g7dAxb+xl
         LAmy8Bw86s6Zfh5w/sJNgf/XNpUceYEQMX4UY/Sn11YDcVMTOxlS1TIh9udTcTK7/Q0U
         qCw3JGzejIUQwMZCJlTSgT7+di69K5MI5/aRjp+0brocR6rFU40W8j/D0zmJ0GXiThi2
         MIXuz+DzMtxLalLTYtf3+HjsZIhF5La0e7g9EJqciDIpkHzBx0sqDt99+wbX1YW8oQ7V
         pCSiSMyXpBzgWxnLrL868jJ/a8NHOaEjd+VuxW671trP3bTkfryN7ksiSwAtyfbTFerR
         uPog==
X-Forwarded-Encrypted: i=1; AFNElJ86BHLf3rQEZ3Rsq1fMAGTJqGcg4tRQlUA2GBGH9NhuzLT6KMWIJcCnNfRbBx09vKBZOFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqI7d3tA4xS7irMQOPR/o/+mNilb38DkPzlNdez0fS4222/cP
	gqr9zezk0meejXKwgBhimpAtOsbEwA1JDwglpyK5JzQdjF/6JPqbqyfP
X-Gm-Gg: Acq92OHsPTXhHtd43F3oAFcc/+4hCipMdtl3+1sf4yRRVVG8qKZrrg/pHkq8GzGJkw2
	8chNxKPQqIgii/zv8I0drQDWxHCuEL4NC78lzSwYnwz1bRJYajvLkrEnEjbrgGzmCH8V0CRWceF
	GvgaPfu7uejnWUAuhY4rzJiqUv2zFubfDA+WxVei68MlO0z8FZ3D6uorokV/pa7otttSfoOk+Jf
	G2puA0xFcjf4YP6MUp+R4NnVOB68Zg44T/trudMzm8wM6gfJhxRojqaqAv2ty5DB0o5vEgE6Zvy
	t2iL3gLcQ3cDFSgf+L912Rjzxt6aoN+/OD31/HUAhKgAPdK4QVkJIycxtijn5kNZXmWQStHg4Nc
	mYx2kHG+Vxil6J45w6n6T4UCraQ0garrIoVGOfVnQeI+IbH3AQRijPY7fYnXpO1JUBtTBDwc+gs
	EYN3t/jx2t6tFjedDGmqr2esmhWdabyxbpfZ8vApIwuznTyipPmoQf+Dlxml8WLvPyZ9DsaVDGg
	xZfocyZcHISJUoDIKG80A==
X-Received: by 2002:a17:907:c23:b0:bd4:e53f:699 with SMTP id a640c23a62f3a-bf0aed0cb0amr379252766b.37.1780571809607;
        Thu, 04 Jun 2026 04:16:49 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307aacsm292216666b.47.2026.06.04.04.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 04:16:49 -0700 (PDT)
Message-ID: <e23baad8-1709-4210-81c8-22741b9dfb3e@gmail.com>
Date: Thu, 4 Jun 2026 12:16:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] libbpf: Skip bpf_object__probe_loading()
 when BPF token is in use
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 chenyuan@kylinos.cn, daniel@iogearbox.net, eddyz87@gmail.com,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <20260529031604.888137-1-chenyuan_fl@163.com>
 <20260604031033.806727-1-chenyuan_fl@163.com>
 <20260604031033.806727-2-chenyuan_fl@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260604031033.806727-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 4:10 AM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> bpf_object__probe_loading() tries to load trivial SOCKET_FILTER and
> TRACEPOINT programs to verify the BPF environment works.  When a
> BPF token is in use with restricted program type permissions, these
> probe loads may fail because the token does not allow the specific
> program types, even though BPF loading is perfectly functional.
> 
> Fix by skipping the probe when a token FD is present: BPF token
> creation itself proves the kernel has a working BPF subsystem.
> Real BPF issues will be caught during actual program and map loading.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ab2071fdd3e8..7e21c5eb9533 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5167,12 +5167,8 @@ bpf_object__probe_loading(struct bpf_object *obj)
>  		BPF_EXIT_INSN(),
>  	};
>  	int ret, insn_cnt = ARRAY_SIZE(insns);
> -	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> -		.token_fd = obj->token_fd,
> -		.prog_flags = obj->token_fd ? BPF_F_TOKEN_FD : 0,
> -	);
>  
> -	if (obj->gen_loader)
> +	if (obj->gen_loader || obj->token_fd)

This change makes sense, bpf_object__probe_loading() does very basic
check that BPF works on a given kernel. In this case, when token is
passed, this is ok to skip. An alternative, trying to make 
bpf_object__probe_loading() correctly token aware is worse.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  		return 0;
>  
>  	ret = bump_rlimit_memlock();
> @@ -5181,9 +5177,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
>  			errstr(ret));
>  
>  	/* make sure basic loading works */
> -	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
> +	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
>  	if (ret < 0)
> -		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
> +		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
>  	if (ret < 0) {
>  		ret = errno;
>  		pr_warn("Error in %s(): %s. Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.\n",

