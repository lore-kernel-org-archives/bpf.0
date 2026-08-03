Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823D401A25
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756737; cv=none; b=ArFQZK952ZHW9qNRVthEPeCnMFmM9zr8gTvkiqak4L2BlV1jZ3CJImLlJiJUlp0OkOvZWIAjeTbviSE6Dnn0tHCupMo5kqycH9fYPsazQWiXz88gxOV5k/HL/jqMn+mosI3czGavCC/ys2yNFT0ar+B/Z7NrVG3DLiH0kXbp/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756737; c=relaxed/simple;
	bh=mpngfkvKH8vqQe6md2oQv+d5bXyGWY+0TQm/G7ADKFQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOQmwfaBP2PRx6h6f7CgNeZlKBvc6BZm6OwsyyCf1z/nBuSHQHZ/mdlQcnF/3MzSYMH6E7Fa2gv25ZqNtf5frZUBJn/GpFTiKOy0uvvlH1daPdVhpkpp+krr92/Jwr5tMkqonkrS+KHWR/R5b5m8eHAi9GIWAc/B6zy2p/Gh5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlLY2mFV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlLY2mFV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3493747f8f.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756734; x=1786361534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4zWdkPq4xP0BoTt8wzn9Jb+qkkuLG7cfYkno38Rp6ZI=;
        b=NlLY2mFVX8MdiCdjbpNGfgGvMxvyPWcqlarjVz9b2eSGwultpnElUz7h9vfEpIjF3I
         Ss/aXRh2D7QFxmNGHb81Ux0H5f08/pAhZJeJANRCSe56GQoCB0uzXLw28uZGLtHyKiX2
         xkaotiNsJsnvMX6ub9ffcjCo8ufsTgmqFCDYGOB+NgyWr5J3ocRNKMacbMHk/XgP8rQk
         z7otdPMBWZYMMcGUtFlV8qCgo4RPfrjxqBG3UF/W9fkyfp8PNrgeKVQwF6+So2oD0//D
         CCOW0Ib2UDTf2/mCg9ZnaHIGlP7bjXbFZAuOeULZFEgvCOBZBr8A5MEYxRLjGDKpuwkr
         iOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756734; x=1786361534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zWdkPq4xP0BoTt8wzn9Jb+qkkuLG7cfYkno38Rp6ZI=;
        b=QIv+gXRqL+Tv9y/5MDnc+QFVBBA392DrpLbFVkBPruUatxTTz1bJyLBoyQzgRRstOt
         T5ijkQwkW8SV+JtGNEfmpiEtS4JK+toQeqZ8SSK4DPfs0//4EoO2O1abAal7bI/14muK
         MfR4xtUL97m2l+3rolWnH6C4ni+5kB+rBdcrvMIgYjLFU9SOaAuJ0q2FkTsHo96Ktc++
         0KS176MxR0g43jCpNnZgZ7/UuXva0Dj/eaek5AnM/ckuFwVtZwnvAyNJxN6/KZehjECW
         PDcRVTyQyuZVmcoB/o4TQDpcFbZH8nzm+gabaUUjgymUvo/Ls/AYqGAE02IM12C7RjDw
         tbOQ==
X-Gm-Message-State: AOJu0YwcUwxZGRL6sGOpkyCICmisVIGpMBPJeTN3XsGKulZd9pb8ddGr
	aQyBcy41MJBPptpY/IQtpyyfweACv6pBbrYjnju5qKIH6Lu5NK4g+IrSq+s+aw==
X-Gm-Gg: AR+sD13Me6i6BOHGKTW26AOMuDc1Eci26PmquCmOpGMbiMpLDLBvVpbomEGQtbviIyu
	zRbDncYbsZ6j/BO9ykGvfnKIgxudHFO8mxS056bT2uPwnzFM+bWsMe5o2z2egLFsBLEvwpIcJP+
	/r6hcwaePwSWUengIwMjKbRM8rqG3H9y+5UaDEELE9W04IX64RM8jcyDmKgE5987CVxpFQ2VcfJ
	KwzkCDBTTo9mmcWokq/XnIwU/f3ccCcCcFkBJWl4WNXkAjWCYQIypkdIEZPZxjWeobkBmIj+BHf
	3d3RnuHvhErBOJ9OWiTIYz1cuAQMHRiSJ+ol4T5SghZubjCumN5E6yRWxTw7ssK1pm0fSnQi0xX
	uA2qEQ++01oJJgK4obBXrVgsJMOr+++WpPZEoo2SLxBJUzb0llBiwDDTQIlfxkI037NGq/Ra9zh
	jOI/VJPQBIZMTDQtTvvSadgXvt29BtIZXtyA==
X-Received: by 2002:a5d:588d:0:b0:47f:7129:e30 with SMTP id ffacd0b85a97d-47fd72a8e52mr24421890f8f.11.1785756733521;
        Mon, 03 Aug 2026 04:32:13 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::86b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458ab61sm32877610f8f.25.2026.08.03.04.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:32:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 3 Aug 2026 13:32:11 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf: Remove unused BTF_FMODEL_STRUCT_ARG
Message-ID: <anB8O5Rxmgrt95Uo@krava>
References: <20260803052726.2821447-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803052726.2821447-1-yonghong.song@linux.dev>

On Sun, Aug 02, 2026 at 10:27:26PM -0700, Yonghong Song wrote:
> Commit 814cba835ef6 ("bpf, x86: Fix trampoline stack size for 128-bit
> arguments") changed the x86 trampoline to compute the number of
> registers from arg_size for every argument, which removed the last user
> of BTF_FMODEL_STRUCT_ARG. No other architecture or verifier code looks
> at the flag, so remove the macro and the code in __get_type_fmodel_flags()
> which sets it.
> 
> Keep BTF_FMODEL_SIGNED_ARG at BIT(1) rather than renumbering it to
> BIT(0), so BIT(0) is available for a future flag.
> 
> No functional change.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  include/linux/bpf.h | 3 ---
>  kernel/bpf/btf.c    | 2 --
>  2 files changed, 5 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 356884587ae1..73bacfc6444d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1207,9 +1207,6 @@ struct bpf_prog_offload {
>  	u32			jited_len;
>  };
>  
> -/* The argument is a structure or a union. */
> -#define BTF_FMODEL_STRUCT_ARG		BIT(0)
> -
>  /* The argument is signed. */
>  #define BTF_FMODEL_SIGNED_ARG		BIT(1)
>  
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5e8ac45ce56a..42414633cf26 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7533,8 +7533,6 @@ static u8 __get_type_fmodel_flags(const struct btf_type *t)
>  {
>  	u8 flags = 0;
>  
> -	if (btf_type_is_struct(t))
> -		flags |= BTF_FMODEL_STRUCT_ARG;
>  	if (btf_type_is_signed_int(t))
>  		flags |= BTF_FMODEL_SIGNED_ARG;
>  
> -- 
> 2.53.0-Meta
> 
> 
