Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783765013A8
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896442; cv=none; b=ODOaXw/kSbJB7/CHIZkKbsNtEeXHh3/loXyq0JTGQFyjQZw+6oiciSCznQOEsi7B4o6+QXFtftlAOnDyr+30m8Q1TItthgdXuCuw4FZsjE7jF7cEzZnIeMFy0wgs3hZSXQ9S7KgWOKN9orWZkR6xJFcBltvY8VmMjs2lBKVrqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896442; c=relaxed/simple;
	bh=yQEEfCOK4gxCSnswHreCDFy8H0r8GTZ69JS3nEOvTJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHWrBLmcZ12PK9emXmhafPzdCMSUiKFXHAjdqU2k1KwTeKoBTeCVpQ1o7XAOn0lGcmLvL5AYu8Cb4a9j9A4DWUzILWepCl7pPmCMlH/9s4FPhyHmhnT06Z5HTArNzUBHyIIMOuHvffK6GpMCaH49PL4T6PwIW4FhvekvItD8878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtwEsIMn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtwEsIMn"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so25167175e9.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791896438; x=1792501238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NthVEFHw1ElrKnMw0H8naPta36sjMNg6TdhZjsytLXU=;
        b=LtwEsIMnouq+efgAzmhwe7OfMDtbBqOTe0Pei7irgAZISHYjm6v+y0fk1wQ9qMrsGT
         C96itFHmA45e6xDepSZiLh0I3ORrDzLG0NkDLtq3x6TW20EeEQjhS8ddydHLyhbRgQVa
         bE5/5WyCKS56CrrVln8Scri6DpeAh1Wzs1TdFq62F7mXG1vCe0iwB182TD866y6vCBEa
         xF+cc8fYytyFkxZefaOHpVSA4nPUTFiEQyIPMiAwlgfTXJ+oPHElwhtMwZH+nt5GkQCa
         7jiKL6QcDN3/tCVfpC243ZAF4qL153HwmFoI/IBj058a334MsChVza+nczl3emvvmAaG
         lrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896439; x=1792501239;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NthVEFHw1ElrKnMw0H8naPta36sjMNg6TdhZjsytLXU=;
        b=muotWi9fjdWWkc38FqUFXxRV/dv2WT2LFxGm1oSA20jJQ6Mt3PEV4bkMKX6Tn9Gx1B
         e8xMHfBNxEDL8nofUmvX3uR4Zdmc88UTk0xGg8slNV5uOYSXOV9uLW07YB2cgbOuxd29
         X6NW1urhBTLiRK991tdv2UefeemuQs6n1cE4z8H7F1qt2qVccTRY0uEne41Jl81AyQa4
         v+JwUFZpkJFsQyev44UUfR0kCqSVyQqGkswam8VUQdJiTEUELuLJ0DWpIcCZ8aLTV3OU
         VtQ4gsnJKFnk1Qe3iedZ8kB7vui7ZWsi2qJNXn9ZcdZnAxbDNN+cJc1/0EWZVrvQo6EU
         dT0Q==
X-Forwarded-Encrypted: i=1; AKwUvBybPWdjuW7TrJxitQarrUqAjzBKZsiO46O6ik3kKrmEoyHkVGpnCO4+MIaHbuBqieMOsvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo8ZBnKiralMB0FmY8tLcAFyvqvtlclH58wz6uvf3YWhacCSOi
	dhYI39x1ekPFP4YNpWR5GNxf7q7YwkPLEztmMMR2JC7cBGCLXeDG8lpK
X-Gm-Gg: AYBFou2B968Wws0srSrnUkSM1wIo15rGaUlywKuGP9IwB8Wt2kqWwpz5Knpk3rPc/Az
	wf0hd8EpBICSN/Vk97saxsWbJY+fRPylzIWUflZYaooHs2WsoislHNHcN1+I9hbwGM9BpBex068
	RJ8b4jMERGFSJSE6S8GcjWiex3A+gOSUVRP+amHA0c5xcxvI0Dq02SORUEHPBgzu4IBUMGf+AYS
	eRFaSYX1OP12aASgCy8WwEB4KP1J12BYr71vpNwO8cyzGkJ1WS/gacgyJm8I0BurCcJT1yRCJqM
	ke6BODq7pdhoB/QpeGUt5INhLwWp5BsgAgV53SfnbZANPOJ31O41pDLFiUFo+xdpot5Yh2VKVm4
	Ig74gtouJdbS2Jq4VxK6NPJ5QUHSvoe0SchSarzYF7m/NNnGitxl88HaErRP27xCe06sPy7e5Bp
	QEqxDs6jNnPjAYfeDt2Sjv3ShVMNKqZNTybfObIMzF/2rihtNFfdxxm5mP5ZuM6u1UZxudvV5BH
	8YKNvzITFKzsYojFCWvsRYFrftBCK9sO6M=
X-Received: by 2002:a05:600c:8718:b0:4a1:7259:349e with SMTP id 5b1f17b1804b1-4a18e4e0a33mr241281245e9.27.1791896436656;
        Tue, 13 Oct 2026 06:00:36 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:d896:14db:43e1:c012? ([2620:10d:c092:500::7:ee1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf15691sm356699465e9.6.2026.10.13.06.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:00:35 -0700 (PDT)
Message-ID: <1cfad8b6-1e42-4212-b11f-884c88aabf9d@gmail.com>
Date: Tue, 13 Oct 2026 14:00:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 01/13] libbpf: Keep the fd_array fill index
 out of bpf_program__clone()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
References: <20261013082012.1107446-1-memxor@gmail.com>
 <20261013082012.1107446-2-memxor@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20261013082012.1107446-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 9:19 AM, Kumar Kartikeya Dwivedi wrote:
> bpf_program__clone() hands the kernel the fd_array of the object along
> with obj->fd_array_cnt when the caller supplies neither. That counter is
> not a count the kernel can use: it is the index of the next free slot
> of an array built for the sparse fd_array API, where module BTF fds
> start at slot 1 and slot 0 stays empty, since a kfunc insn with offset
> 0 names vmlinux BTF rather than a slot. A non-zero fd_array_cnt turns
> the array into a continuous one, which the kernel resolves slot by
> slot, and slot 0 holds 0. Cloning a program from an object that calls a
> module kfunc thus fails with "fd 0 is not pointing to valid bpf_map or
> btf", for every program of the object, which is what veristat runs into
> on such an object. bpf_object__load() passes the array without a count.
> 
> Do the same in bpf_program__clone(), leaving the count to callers who
> pass an array of their own, and rename the counter to fd_array_used so
> that it no longer reads like the uapi field.
> 
> Fixes: 970bd2dced35 ("libbpf: Introduce bpf_program__clone()")
> Cc: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  tools/lib/bpf/libbpf.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cb09ded90773..fcedb78abe00 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -794,7 +794,12 @@ struct bpf_object {
>  
>  	int *fd_array;
>  	size_t fd_array_cap;
> -	size_t fd_array_cnt;
> +	/*
> +	 * Slots handed out so far, slot 0 included. A kfunc insn names a module
> +	 * BTF slot through its offset, slot 0 stands for vmlinux BTF and stays
> +	 * empty, so the array goes to the kernel without a count.
> +	 */
> +	size_t fd_array_used;
>  
>  	struct usdt_manager *usdt_man;
>  
> @@ -9716,22 +9721,22 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>  	/* set index for module BTF fd in fd_array, if unset */
>  	if (mod_btf && !mod_btf->fd_array_idx) {
>  		/* insn->off is s16 */
> -		if (obj->fd_array_cnt == INT16_MAX) {
> +		if (obj->fd_array_used == INT16_MAX) {
>  			pr_warn("extern (func ksym) '%s': module BTF fd index %d too big to fit in bpf_insn offset\n",
>  				ext->name, mod_btf->fd_array_idx);
>  			return -E2BIG;
>  		}
>  		/* Cannot use index 0 for module BTF fd */
> -		if (!obj->fd_array_cnt)
> -			obj->fd_array_cnt = 1;
> +		if (!obj->fd_array_used)
> +			obj->fd_array_used = 1;
>  
>  		ret = libbpf_ensure_mem((void **)&obj->fd_array, &obj->fd_array_cap, sizeof(int),
> -					obj->fd_array_cnt + 1);
> +					obj->fd_array_used + 1);
>  		if (ret)
>  			return ret;
> -		mod_btf->fd_array_idx = obj->fd_array_cnt;
> +		mod_btf->fd_array_idx = obj->fd_array_used;
>  		/* we assume module BTF FD is always >0 */
> -		obj->fd_array[obj->fd_array_cnt++] = mod_btf->fd;
> +		obj->fd_array[obj->fd_array_used++] = mod_btf->fd;
>  	}
>  
>  	ext->is_set = true;
> @@ -10940,7 +10945,7 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
>  	attr.prog_ifindex = OPTS_GET(opts, prog_ifindex, 0) ?: prog->prog_ifindex;
>  	attr.kern_version = OPTS_GET(opts, kern_version, 0) ?: obj->kern_version;
>  	attr.fd_array = OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array;
> -	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0) ?: obj->fd_array_cnt;
> +	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
>  	attr.token_fd = OPTS_GET(opts, token_fd, 0) ?: obj->token_fd;
>  	if (attr.token_fd)
>  		attr.prog_flags |= BPF_F_TOKEN_FD;

