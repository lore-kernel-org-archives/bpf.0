Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B314148850
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664746; cv=none; b=Uj5BeDGpTNYYvsvgNeHw0Cbb+zONc27I0kOZ6uW7QyQrUNhMeWwLaZrBctaHRUbtVsV0fQAUtHYp/lDvXOXrLmka/gls8fHHmAVP5KMw+Oss+ea7BINGskvaQHBNigE0myWI5WufaqRoIjrfQzg6Q8fO9Vy7N930bioR3E9CToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664746; c=relaxed/simple;
	bh=pCnMMIPVix3pcwq1Y5tAjdkSKT1V4MZmRtqFfbQSXzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAQCX7EMKvRdSpjXM+2cnyzIO+DN7ccph3JGPIzAdBXU11g6A7ABdDvtOAJbtHwK3MPnN94S/QwQOZac2J6lCi4olexFE16mxwkPp2M5vjkR5bAcobe22JVK86VnUGGCH2KtMzi89o+3R2wHmQ1fr64Gx8EgMw+ZhoL3CDfLAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyjBKF9L; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyjBKF9L"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4888375f735so61259815e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775664743; x=1776269543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xD93b+ow82mY6PSjx9T/cuelv3tvt18fZqD8fnQMnug=;
        b=hyjBKF9Lvmj+vzFmOJv+lbcJsbz41JXBaXGSI6pSq8MeT4KWazJP3w8/mujq3DLeIu
         AsbpxOAMQpz5gOmpL9FiHlpzr2CxVtl1kQtAs4bDo4hYZEyvYXXn5c27UEojE0AqniN7
         t3gntrMBTU6kjzTUVN9mvEu66y40+gV8kzFC5aVQskzqiL0wROY2ELBX9XXkzbJH9WOg
         he1e6ElowqumfMv5uXLzq2Vxwr/QECv30VbO0j8lZ1vYlAsX1yb8nYdE/G9CbOQ6PnGZ
         mhQuQfJPyD7v/SjUQFiHlvreZ2pCM/pNLUHZU+FZRXsgoc5iQDTcuDOYq239aWLE8M5p
         yFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775664743; x=1776269543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xD93b+ow82mY6PSjx9T/cuelv3tvt18fZqD8fnQMnug=;
        b=rixPoVJEfKUjHDN5w2L4IBJVIBGCpM1x090ukjjde5Xg297l/a6vh55YNC461y5/J5
         SQsYH4eg+5lOurE1biN4S3oSNi4lhTySZdV9QkcwPMA46t3ebGOXgAHOUAhL67eb1Jtz
         pf1vWPl1SNNN5AVTQoyb1amxXhmPuJ+9IukJDsoPHdpKWhMBQa/73KNNe3cyNCIqBVTU
         ZIl60wTR2Cu7WbSnJ29DNwAqxtra6lYOMyxs3EEf/l9g0cD8elksIAtYAlAOzSpUBlc1
         8w8kkNEpsOI4sqFLbl8KhbZNcsbxcG5jxbvBqiNGEBAWm3Pp8G3JA4BJP6hUCx/gCyMp
         OmqQ==
X-Gm-Message-State: AOJu0YzCVmM5uREXEVjO3DD/4rLftKB4QbvG4dBrpHk5hgnGns8VxK1A
	uffy4bHv1Uhcsk9XI8EIiYtF9StPPoOg/VHc4MTGalP2LqyVRdhE9gp13WTByA==
X-Gm-Gg: AeBDievjmBDNSmsaoOklXeaXBo1JXIpNX+iHmmoqXBWqbLPp09XeisowumwWIDuv26b
	tw3/khJkg/rUE+Tp1KT6na6GlqmIMrwRfMTKLegN+Tu2raktG92kOX5v8gRe/55dZkIlokbsbry
	SVfK86CKE9yVo6ZXsPIDYJYgCblW0SzHG7LWWXnnrAjp9/zDGdbydfuwcVEunXdQr8XykPayGjj
	O8BpSuibKIZf+bbELD+SVnS4zmVSWCGYZU8BomH1JH8bsSWCwsfdsFGhgQMb3tbl+OTu3TkYV7K
	G/9nxhmQ+nT+xtnRkmZV0d3nd3LyOmb/p/aAkiJQf+t2XqgskmSlZXkiqYGLYak9Kje+xyBuGpv
	Lo9jyKvsJV0ruZ8v8xov75Tycjr20eoDPVcbqIFgDRtvFtXYRuyDJyG73/NhWwQ97wGXo8e0+OE
	bDBtGbOEQVkcrwfOqgLfVVgANVsRiypjlA+rQmZKSt5lQ=
X-Received: by 2002:a05:600c:8908:b0:488:a916:14a8 with SMTP id 5b1f17b1804b1-488a91614fdmr165691735e9.10.1775664743288;
        Wed, 08 Apr 2026 09:12:23 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm60776668f8f.21.2026.04.08.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:12:22 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:21:20 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com,
	info@starlabs.sg
Subject: Re: [PATCH bpf-next 3/4] bpf: Remove static qualifier from local
 subprog pointer
Message-ID: <adaAgGjs3TbKnXsS@mail.gmail.com>
References: <20260408153712.523124-1-daniel@iogearbox.net>
 <20260408153712.523124-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408153712.523124-3-daniel@iogearbox.net>

On 26/04/08 05:37PM, Daniel Borkmann wrote:
> The local subprog pointer in create_jt() and visit_abnormal_return_insn()
> was declared static.
> 
> It is unconditionally assigned via bpf_find_containing_subprog() before
> every use. Thus, the static qualifier serves no purpose and rather creates
> confusion. Just remove it.
> 
> Fixes: e40f5a6bf88a ("bpf: correct stack liveness for tail calls")
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 46f55ea6684e..6cb54764d452 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19224,7 +19224,7 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
>  static struct bpf_iarray *
>  create_jt(int t, struct bpf_verifier_env *env)
>  {
> -	static struct bpf_subprog_info *subprog;
> +	struct bpf_subprog_info *subprog;

I wonder where I copy-pasted this from... Thanks!

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>

>  	int subprog_start, subprog_end;
>  	struct bpf_iarray *jt;
>  	int i;
> @@ -19299,7 +19299,7 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
>   */
>  static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
>  {
> -	static struct bpf_subprog_info *subprog;
> +	struct bpf_subprog_info *subprog;
>  	struct bpf_iarray *jt;
>  
>  	if (env->insn_aux_data[t].jt)
> -- 
> 2.43.0
