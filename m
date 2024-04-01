Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D323C1DFF4
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994399; cv=none; b=LsrY5dKISeB/vftfFFSR1D3K8C/DsR+Ji4qiLeRFCxEE8pBiSXfQhwOSpVgbRwhiolmdX5GXX6oXDP8e1GRMo1aZu2Z6+cvR7nxw8cHsNp6MhqN5uN56Mdisk2M750ycu5pdZgBBL6g2qS8un8Cldh3E8tKdewpBvWa8xgCgfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994399; c=relaxed/simple;
	bh=YO788xMr+ALxFwqLzE4CCwS3cB4GYIXmPoZEPpY5CMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPfCv3QRg+vFto75K/Amem4HhnXqLQRTMcumCCOLToM7NcTVQ2WmObt4LGVwxhYkEfEXGigNAS8xOW+zxaqUO7r2HLJgjsiWFP5X3E6xhGecQhiCu7Mqz3zDMy9JnodqSXr0savi75/K5CvkRx7EEG2H+LBk3SeriDx9j5/EetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbmnyWiI; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbmnyWiI"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e8a1b8cf28so502844a34.1
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711994397; x=1712599197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3j9qYfQ9XJ3HIAxAy1vWv9DgHh1u7RgDTYNESmyt1Q=;
        b=FbmnyWiIfy/ly1Pj0FgUi/wD4TbpFXGnk542QJfPmpw9gpH3sd5yT2nmA1FbbqbXKo
         dIul+v1BsicPNtjBV2Xy2LC6ckJAs/+RbK4EANhOFB+DUEkSiaR+TJ+T9esy3zivTKny
         W7173lyqNld5TBRJuwICiTDwZ5GhYJ/Y7gAfLy7eNYBOnm2PNYIkP/JzKeqDIHH9vV1H
         fqRuapM+hm6SPeI4VYSGxJI1tdABOlI9L3B8KjR40mF5+/c+MfeUUgDRaPVfTRbH9XF0
         8lQ9qfnZAUZEi17y4kg20LPWoE7yMMMufDVdZ1j/QQzCOKPCwF3LcayEyWS+Qua/Oru2
         z4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711994397; x=1712599197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3j9qYfQ9XJ3HIAxAy1vWv9DgHh1u7RgDTYNESmyt1Q=;
        b=rfDAiI2xsDE9HGv0pfrQD70QK5KP5EFWtI++HPeY2HSeRBcWpWAnKZHMyuO3RcMmzQ
         yAC5ujStU9/JRypqYSj1DkBqeSToit21lmW+LlST936iAmaocbihUrsPTPQ1DfKBSMJX
         jJtlGW6ZO6g+a7NHzug5hZQLyOR3M/HR3E77Zm+J1EgHp0gwBdczJ4AGFn9N9EUtxxSs
         /Nva/sdRsL+Vk3ehxWstFFpbKNuBysBLlBbnaLQW6K0pkoEIIpsPkQh4SSr+s2++JklP
         gECTZsCgEPnLiPlnXRwQZt234qBbhwdwYM5cdilkyyTqV8Vf9yGLx33sCikL7agTAUxK
         dUPA==
X-Forwarded-Encrypted: i=1; AJvYcCVhD6KhhTAHHOFGzOxn2+r7+HFrVkIszKntxj5YzYI952yF8POZkgk4mPJGJbQv1PYkbDxztHRndEKtTwAEpswAOVQc
X-Gm-Message-State: AOJu0YxH6JJMkd2NoKYLCB+19cpUoJ+vdwCJJD20rpeoG9uQLra8EBgV
	VfPd3nE5h3iEJPDdjU1gGP68c6FBDLghgGIwGarlI+3jWu7lKPS9
X-Google-Smtp-Source: AGHT+IFdO7RXhNEjUyh8TQCmhc11sp/RIma8hVPRSaYYeliCJ7gRj5mRWIaMsjEIWOFfxRPogyh6fg==
X-Received: by 2002:a05:6808:1649:b0:3c3:e3d7:678d with SMTP id az9-20020a056808164900b003c3e3d7678dmr12307267oib.24.1711994396824;
        Mon, 01 Apr 2024 10:59:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:769d:e8e1:4c99:3e97? ([2600:1700:6cf8:1240:769d:e8e1:4c99:3e97])
        by smtp.gmail.com with ESMTPSA id 15-20020aca090f000000b003c3ede3ac23sm1586964oij.2.2024.04.01.10.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 10:59:56 -0700 (PDT)
Message-ID: <b5af75b1-892d-4640-9222-7fe8006d1da9@gmail.com>
Date: Mon, 1 Apr 2024 10:59:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: use __typeof__() instead of typeof() in
 BPF skeleton
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240401170713.2081368-1-andrii@kernel.org>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240401170713.2081368-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/1/24 10:07, Andrii Nakryiko wrote:
> When generated BPF skeleton header is included in C++ code base, some
> compiler setups will emit warning about using language extensions due to
> typeof() usage, resulting in something like:
> 
>    error: extension used [-Werror,-Wlanguage-extension-token]
>    obj->struct_ops.empty_tcp_ca = (typeof(obj->struct_ops.empty_tcp_ca))
>                                    ^
> 
> It looks like __typeof__() is a preferred way to do typeof() with better
> C++ compatibility behavior, so switch to that. With __typeof__() we get
> no such warning.
> 
> Fixes: c2a0257c1edf ("bpftool: Cast pointers for shadow types explicitly.")
> Fixes: 00389c58ffe9 ("bpftool: Add support for subskeletons")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/bpf/bpftool/gen.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 786268f1a483..b3979ddc0189 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -386,7 +386,7 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
>   			 */
>   			needs_typeof = btf_is_array(var) || btf_is_ptr_to_func_proto(btf, var);
>   			if (needs_typeof)
> -				printf("typeof(");
> +				printf("__typeof__(");
>   
>   			err = btf_dump__emit_type_decl(d, var_type_id, &opts);
>   			if (err)
> @@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf *btf, struct bpf_object *obj)
>   			continue;
>   		codegen("\
>   			\n\
> -				obj->struct_ops.%1$s = (typeof(obj->struct_ops.%1$s))\n\
> +				obj->struct_ops.%1$s = (__typeof__(obj->struct_ops.%1$s))\n\
>   					bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
>   			\n\
>   			", ident);


LGTM!

Acked-by: Kui-Feng Lee <thinker.li@gmail.com>

Thanks!
