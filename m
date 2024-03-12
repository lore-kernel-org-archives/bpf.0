Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDD7826B
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252064; cv=none; b=rn8Gdy4fFtfrQol2RpMsSwStcdlAzZxTtBkTBobfQJ3tpWuknrLeWN1JbQ7Xr38qtAEiJvodNKm1KKQ4UjOHGyMpKO8fhD9bdsZgIF2Tp460mw1iqwnwUbxEEKeRStMVURPYDH8+kgQodAdlIGbfmeXNaLDVLx7bADKCtQX0Btw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252064; c=relaxed/simple;
	bh=r3bvWHkqn0LxwXuGyjtEt70o5bxGaHmRUKS7LtvIF2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSZ27AXO9B/A7LvOQj9VaXOxmts2blmZAbKFgIFVO/z2wjsK2fd4s1qbHK0GybOw+z1YBh9NTObg/fhXL7XgNEckwc+bYh2bc8NRytHifhv+SS8Nj9u3lbxx3lWFAUZ030T0L37kANLdrGrWJgQvLuYLLORmBIxDkjKPTzhE1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=IWoq2MWl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="IWoq2MWl"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e672e10cfso2774306f8f.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710252061; x=1710856861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPS6ueWvDDPvd1bK4Vc3bpf3LfO9QQYNRpSn8aRrVjM=;
        b=IWoq2MWlF/1bKFPI+SoJXcf+yc0zgPpgdGokH7LyEYVwkRosOIbKX7ryU22+evpspb
         gl+2lb76/3Zc2H84AZefDVyBOxPoRQdMHtgYX5Ez20ejN7oVUf7QN0c8bAzz/KjZRHgs
         ZuqtbQ6VFOPe1i2YLEjiXvWLjOvTd8q32UW4aaKtKA2Wy65PrfDw8ZE1mTmISNGMzrxb
         UUaWFEPmzLdR6Lm4nASKufwEMF50nPuma+CqYv9TIdjQwMg+p9KZaIGKXQreUsWaWnEZ
         x+yEnKa95ydjLZntlubXDjNeu8HeFZMr5a3SIB/67kmnH75GFbd5xwL+Ig/oMzEGJtyt
         beZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710252061; x=1710856861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPS6ueWvDDPvd1bK4Vc3bpf3LfO9QQYNRpSn8aRrVjM=;
        b=DGc+Whw3L+35zwMPRdXKNSZYeRkMdTesdxLpQGVO2y/GIMG59oBr7OvsEVTNmUSdoM
         nqD4LMyE2DvjZahDx7cpai/JmkPEEpBSa2gvYPtC26J58MUam9BGrOrw4EyBI2/g1KdE
         qQcF23LPWjsFV1PReIo0PklM/XN9Gmr97BhD2tZHVzZ9CLOcoMGG4bPxgni32uQt7xi7
         ur7JA7MswtnKpWqkbrvXWD1cu/8mZ1uVWPBpvRTLWXwdcwIcuE+C0OVrgdZUUuP9m1ql
         O2MmqVkpoBwNDFF232GXq7tdEmx5uOOIMOsmgMNnMedMZAN6ZIr/BIfC/o4WRcdRCz+3
         7Jiw==
X-Forwarded-Encrypted: i=1; AJvYcCWqgPGifO7vu/BnWP9JMEy7g3R67X1OVCDNwuInj+atWtzgTApEOrBTIfIPtI9opzjbz+bCRpInZDacgieuRftteVUv
X-Gm-Message-State: AOJu0YwFqaGRbYxFIXFBPNfqwQYKnnC+5jRISZdXo8KBqy13Gx71r0zJ
	ROBSqs7rVVRoPMHOcPlLJXKsAlhVeKhYxhbbgYdv/Z7Vg+Mh8RsCe8ytLj8CZ6A=
X-Google-Smtp-Source: AGHT+IH0zLPp/2ltJpbir0yydX/z9G69yX9JtpbNrGTanVBoabeUscKBa1FYLLpnuvwZWpq6Pi4m4Q==
X-Received: by 2002:a05:6000:381:b0:33d:bb65:806d with SMTP id u1-20020a056000038100b0033dbb65806dmr8859457wrf.50.1710252061381;
        Tue, 12 Mar 2024 07:01:01 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:6eff:72b5:841b:4654? ([2a02:8011:e80c:0:6eff:72b5:841b:4654])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d424c000000b0033e48db23bdsm9098417wrr.100.2024.03.12.07.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:01:01 -0700 (PDT)
Message-ID: <c73285ba-57db-4f08-8e77-01c66c98379c@isovalent.com>
Date: Tue, 12 Mar 2024 14:01:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Fix missing pids during link show
Content-Language: en-GB
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240312023249.3776718-1-yonghong.song@linux.dev>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240312023249.3776718-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-12 02:32 UTC+0000 ~ Yonghong Song <yonghong.song@linux.dev>
> Current 'bpftool link' command does not show pids, e.g.,
>   $ tools/build/bpftool/bpftool link
>   ...
>   4: tracing  prog 23
>         prog_type lsm  attach_type lsm_mac
>         target_obj_id 1  target_btf_id 31320
> 
> Hack the following change to enable normal libbpf debug output,
>   --- a/tools/bpf/bpftool/pids.c
>   +++ b/tools/bpf/bpftool/pids.c
>   @@ -121,9 +121,9 @@ int build_obj_refs_table(struct hashmap **map, enum bpf_obj_type type)
>           /* we don't want output polluted with libbpf errors if bpf_iter is not
>            * supported
>            */
>   -       default_print = libbpf_set_print(libbpf_print_none);
>   +       /* default_print = libbpf_set_print(libbpf_print_none); */
>           err = pid_iter_bpf__load(skel);
>   -       libbpf_set_print(default_print);
>   +       /* libbpf_set_print(default_print); */
> 
> Rerun the above bpftool command:
>   $ tools/build/bpftool/bpftool link
>   libbpf: prog 'iter': BPF program load failed: Permission denied
>   libbpf: prog 'iter': -- BEGIN PROG LOAD LOG --
>   0: R1=ctx() R10=fp0
>   ; struct task_struct *task = ctx->task; @ pid_iter.bpf.c:69
>   0: (79) r6 = *(u64 *)(r1 +8)          ; R1=ctx() R6_w=ptr_or_null_task_struct(id=1)
>   ; struct file *file = ctx->file; @ pid_iter.bpf.c:68
>   ...
>   ; struct bpf_link *link = (struct bpf_link *) file->private_data; @ pid_iter.bpf.c:103
>   80: (79) r3 = *(u64 *)(r8 +432)       ; R3_w=scalar() R8=ptr_file()
>   ; if (link->type == bpf_core_enum_value(enum bpf_link_type___local, @ pid_iter.bpf.c:105
>   81: (61) r1 = *(u32 *)(r3 +12)
>   R3 invalid mem access 'scalar'
>   processed 39 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 2
>   -- END PROG LOAD LOG --
>   libbpf: prog 'iter': failed to load: -13
>   ...
> 
> The 'file->private_data' returns a 'void' type and this caused subsequent 'link->type'
> (insn #81) failed in verification.
> 
> To fix the issue, restore the previous BPF_CORE_READ so old kernels can also work.
> With this patch, the 'bpftool link' runs successfully with 'pids'.
>   $ tools/build/bpftool/bpftool link
>   ...
>   4: tracing  prog 23
>         prog_type lsm  attach_type lsm_mac
>         target_obj_id 1  target_btf_id 31320
>         pids systemd(1)
> 
> Fixes: 44ba7b30e84f ("bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c")
> Cc: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> index 26004f0c5a6a..1eb756f8d02e 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> @@ -102,7 +102,7 @@ int iter(struct bpf_iter__task_file *ctx)
>  				       BPF_LINK_TYPE_PERF_EVENT___local)) {
>  		struct bpf_link *link = (struct bpf_link *) file->private_data;
>  
> -		if (link->type == bpf_core_enum_value(enum bpf_link_type___local,
> +		if (BPF_CORE_READ(link, type) == bpf_core_enum_value(enum bpf_link_type___local,
>  						      BPF_LINK_TYPE_PERF_EVENT___local)) {

Looks good, thank you! Could you please just realign the
BPF_LINK_TYPE_PERF_EVENT___local argument on the next line properly?

With that:

Tested-by: Quentin Monnet <quentin@isovalent.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
