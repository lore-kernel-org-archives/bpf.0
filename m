Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED52D9ECA
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774084292; cv=none; b=rUjf8eJc8iK52UxjLpXK+oZbDjAseaa8TZHn5AcMYu4q/UXpe31PqqL+5/3T3g6/+TDUb1GjpCOok5enSKM/L0+aZdWCiUeJ8q/dOWY2Gz2h017VsdKSeOA2mdtowSIQMfRnObVmLYbgS+3qCJiOuywGeYe/HzElvw+wlKIdmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774084292; c=relaxed/simple;
	bh=g88TsmGvhPf/0xyn5Z4d4bZ5OWZNV190OqTroMj8OhQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHcXWEzl6Zzo0b7eS3fKD499VzRgPlNqXsN91ARqV81fSK7Dc+wP8HiisFs6ovdxHGxgb33rJ8cyLEb9h+ZoL1AwrWwL6zYw4xmPfRDus5hlYpzO6AyAqEjEDi6pDUpoZAv+G/jI7mB0unBYQIlQOlSYXo0rnO/bnzE5nZMHz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh8MGTqm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh8MGTqm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so12013325e9.3
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774084289; x=1774689089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IedKiARDXE8lCU5jVbRUokeFlyWix2GoFLTc0oC95Q=;
        b=Eh8MGTqmyXbp6ou5WDL26ffruGvqiLWcEoZK10zIBFFdWPynNUPH65o5ReLWILqBou
         +qH7+5RoiuoPu3hMfiGCmaBMjl/68hvDxXqabfpv1bSDeI33aUtjgDMPcc7DHeBedKve
         tQtQg7+JeuLGIpGFXUUp173PcJsYC/zzjgj9hgDNrnfbCvvXuBAYd4Zwdf8SHH/vBmsj
         Qsxm5/X9GTFyAC90+MHjvk5hqCe4BPYR+xmwkhOvEoxlls2cU0IPvxZL3FDxpC3KSIVC
         ISRpWilhm0EsLg9On3AJ8e6LMMe0m05qMwwgytFJGc16uY1TVQ2+5jk5GU+p+PDWBJSg
         FDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774084289; x=1774689089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IedKiARDXE8lCU5jVbRUokeFlyWix2GoFLTc0oC95Q=;
        b=jm+ylLzOD68lKcNRB+98EGQTlrS89q2CLloaClLO32Ozy5uUohFP8QgpiLKk/7537d
         eofc6T+QcU4ENcJeOJIUjGlvt4wOZcrB743Duzbgk70NQeoL4Z/nl+LVArZpkxKEDIcE
         4ZkvgIBNDSygcRTeYe+UgzmJK4fxH5H2LNROiAQsQyH0EVQH7dq0tRiUD9r1FDpFPscg
         xjzXayz7N3lMpi2DiT+SDJDbgeROAMzwZrAx7NmJxGIhpBOcOtKXwLlRcF2UhW+m4xvL
         kWbiSSDVTmZ+w8KzPrDEwMk9PrVE2tfpzwshBGIUrLJEDtpi9Q7FDglErNxFRCq4s7NE
         iRjg==
X-Forwarded-Encrypted: i=1; AJvYcCW4nBH5L7b+6E8Grv+hABk4OMCOf8VNSuq52shoMEkyAYDcRoTwmBjXYtTAa00d5K9KFT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPoZ2P6PcVpXJYD/+kopf6Yju5/2ZecQQJMOHkGWuc+LkehQw
	plzP4DeviPp8BdH9rAuiwu2k4XR923G/oZ6keZ2BO0Ri8CeVKbYu+ANv
X-Gm-Gg: ATEYQzxPM2UZNI3qBtbYX+Fv9jE3LXn9b/m44XZrn2jRb7n6SJarmTxjEp0nx9HlmDM
	d1Nwd33brnsfOCoIGm113u8ctpzlFWcu1x4So7EopRJ/G/4AeykBAg/X0JTCV1iW8eZ/v4kLLjC
	9hvTpJBbTJtCaRS2jRe9nK5gtII4IK/X2tmYTxzD8CdsNEL1jgMmxNsAxVdnIm+Q/yphnHl2lXi
	E+o864aS2gXzR0ypBkhppSMwbbwTUPlRacYEwpitIW9xaQVCuINxm0vPhatvJifS1KjQngOedXW
	bMVhpy9RptAGruFVr6WSHJBT4Q64wsV0odeFq77yJ0JlO95WGbWreErdU56s3mj2NVLG7Q+GgZ1
	9AUSIAFm0L+8sqe7kgbhUTzZudPS3BQyrCMC2UxV9KxF2/ddHB4EyrGcQ3oKRD3bLbp+UqMhv
X-Received: by 2002:a05:600c:4705:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-486fee0d816mr81541115e9.20.1774084288761;
        Sat, 21 Mar 2026 02:11:28 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7d6c54sm291474725e9.4.2026.03.21.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 02:11:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 21 Mar 2026 10:11:26 +0100
To: Weixie Cui <523516579@qq.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Weixie Cui <cuiweixie@gmail.com>
Subject: Re: [PATCH bpf] bpf: propagate kvmemdup_bpfptr errors from
 bpf_prog_verify_signature
Message-ID: <ab5gvtCzRBcIHeI5@krava>
References: <tencent_C9C5B2B28413D6303D505CD02BFEA4708C07@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C9C5B2B28413D6303D505CD02BFEA4708C07@qq.com>

On Sat, Mar 21, 2026 at 02:08:00PM +0800, Weixie Cui wrote:
> From: Weixie Cui <cuiweixie@gmail.com>
> 
> kvmemdup_bpfptr() returns -EFAULT when the user pointer cannot be
> copied, and -ENOMEM on allocation failure. The error path always
> returned -ENOMEM, misreporting bad addresses as out-of-memory.
> 
> Return PTR_ERR(sig) so user space gets the correct errno.
> 
> Signed-off-by: Weixie Cui <cuiweixie@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 274039e36465..51ade3cde8bb 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2832,7 +2832,7 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
>  	sig = kvmemdup_bpfptr(usig, attr->signature_size);
>  	if (IS_ERR(sig)) {
>  		bpf_key_put(key);
> -		return -ENOMEM;
> +		return PTR_ERR(sig);
>  	}
>  
>  	bpf_dynptr_init(&sig_ptr, sig, BPF_DYNPTR_TYPE_LOCAL, 0,
> -- 
> 2.39.5 (Apple Git-154)
> 
> 
