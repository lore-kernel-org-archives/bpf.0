Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA7266B72
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012158; cv=none; b=Bd9y20bGEWIu8aAqS1hluOwcIRdbrkCKbPug3Qeztd9wsztD4RONPDkldnYAiKmUTsXDYCujDPlze9ghFmV7tqiNZH2YdwpOxCdTVeskdTqZTnsPCWXhQmJVgZizXd3b46crH5P579975SNlMBQW3dGjX2kzpFc9hkRiDBQ/ww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012158; c=relaxed/simple;
	bh=dDFXS/M8qoO9X2CAJVgy9jRXH0Uni0JbDwNp8k+FXqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ds8dvXm4JiBbDHlWWLtoXL+AZNgb+4XbHa9IGwmjAZYsGzezrlB/FPxZmY6oZizKRJiUZP0SBUo9N4fyi7YqOvqIKDevPk5KVK/C1dTx5GK0LRaBMeLPUSh8ucj25HhyflQFW71Aka5DOlfNyVH+TNNH+AA7w12ENzUXZqsWoxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEfTko0Z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEfTko0Z"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so10046833a12.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781012156; x=1781616956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VejtetX9fcaWAyJoRO4LBHFSq0jXx/xM3nEaIQCjeqg=;
        b=gEfTko0ZHHfwq8irjRZT5Xqicum9Jjmp63OwRQXmmoDUBOaVcaNVGu3ZnfOybDTk1j
         U2xscZNE32dysX47yEJUotKc3RygMqqEd8r6agcEOb5KaXEk/AzpKmQy+X4CtSXGH83Z
         kfSrTrbJK7d9S0R+KBpFrONUO0z8DJqI+AGSi/e2SXRjgeOLOUHXsUiarLzFOY3241Ih
         ohW2gR/3E90NlM/I10fakRnXZexDV0wvE6ZQ98QQ6zFDlENEsVVBH4ObRgJskeh0m7Tr
         rBh4rd2LeO59AR+jGzXPQwdvp+lv/5VkO/MAx6Auj20ERYnSgvBKoPIyIXV9Jeiqj15/
         3hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012156; x=1781616956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VejtetX9fcaWAyJoRO4LBHFSq0jXx/xM3nEaIQCjeqg=;
        b=QTeNijvZotpIKgiKaKgs2DCZgTyApVLwtnHm4nB8T1famrIPsKH9lcG02+azpW1KbF
         23lnaQ8fX9ri0of+88w/eICAFdOC/m0DRv9VcL/mNxXNNzovuJtggFU5VsOqVsMmCwct
         v8xryISTux0vLKoaOGeW/Ob7q8C2ic+VT1By9xpdMDEYjVvoEFL6GHxiMFi6NuFx0vFq
         7fq2LhjLykeGJU3PKSYG2pRQGH8l2+mYX8X3OgsIVzkrmx49n958Gbj4johDeDD8ZBMJ
         mF7TlWuvzKa96WH7481Sv+rJsJFPx4ZTjYRM1n4uUy6AtE0t45YaQ2yhwFUxKryAd5F/
         52LA==
X-Forwarded-Encrypted: i=1; AFNElJ8rBUpvikwxxF/7XPX9zVB0s/vmlVobjydSR4in09qwro4IKmALahIENSdWFML5SGaU+vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWP/3bV0Tlb4Bzar03LGBAJQUTk4aALzS6bdNKFjmr8H0XZEfA
	2txoQXpySA8PyfURXXtsthRBQQTN4Gly6abklGqgkcyeynnGRB/SJwKT1As0/1rT
X-Gm-Gg: Acq92OF9Hevg9W79syr1DezyMv3SmjcDYVMS39vexW7jlHaRD43Nrd0lmtRjuaK9Om6
	zeV9B90/FDotAH61bQItpMEtlDMfXAodDu6QyUo0Fcu4ncZ6Vo6DbWt3MzbtINNEa3tmsrRLP7m
	bCWKSJKr+f7OO7NyuZ8f2JSu5kbTY/VhjTJqZKEDZtDmKhTUZQepPxChAYvUD+bxdz3hM5xZDx3
	vTQ/v2fWC8K9/zZr097I3rulpQM504pRc/ZzrVVX6gsuTwhfVQxOJBpUft1mH1U0lsKriyYV+8A
	oJJ7pGi1w4PHww64UHwkl81nbxSQ3EOcKSUeSMvK8bQ/eSwVVYaC+nWV0JBHgLwaOaWsOoedifB
	f5/pKU/fiJ7w+JTEuMjoJmK+SL5yLTTfWFzU7SJA6NXozI5zWRBj/HLGphEOlfQJvlMBAX8SqTp
	NMiWn94ViKdgX9sh8x3QEKd7sccjPsc4RukgHpaJL24vhWAHQUPdp5Scciqh9lUPwJsytTgqWfb
	tLYjFsrJ470+0lX3N+Kzg==
X-Received: by 2002:a05:6402:1d55:b0:680:b3ed:c5b with SMTP id 4fb4d7f45d1cf-692386354fbmr1432883a12.14.1781012155436;
        Tue, 09 Jun 2026 06:35:55 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65027662sm8832540a12.11.2026.06.09.06.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:35:55 -0700 (PDT)
Message-ID: <2ec75142-04b6-4d03-9aad-7441b6350f2b@gmail.com>
Date: Tue, 9 Jun 2026 14:35:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: Skip bpf_object__probe_loading() when BPF
 token is in use
To: chenyuan_fl@163.com, andrii.nakryiko@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 chenyuan@kylinos.cn, daniel@iogearbox.net, eddyz87@gmail.com,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <CAEf4BzaY3LLmMbSm1ritXwTvqGYi+KSWSkqMYJd62D7opu4ZnQ@mail.gmail.com>
 <20260609131100.3097225-1-chenyuan_fl@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260609131100.3097225-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/9/26 2:11 PM, chenyuan_fl@163.com wrote:
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

Please resend your patch applying these:
 - don't send as a response to old thread
 - this is v3
 - target bpf-next
 - add fixes tag
 - include any Acked-bys

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

