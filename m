Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB73D5251
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443091; cv=none; b=PHYx6XtE3WwXKpkkhTDE5Abz43R9szCfpuIFlKnv7Pl/AQaUyOBWmFQHAx84TasGJowGRhEsCV5TEeTtZoCQ/Q6e7bi09HQRH4od4e9BcvzuGGr1/nUt0Eq5VAbwSVqrczeKhJ5JDtPTc7fSUXAapAvrYMoV2iUdpytJq/Fty7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443091; c=relaxed/simple;
	bh=GPBTp+1O4+roFKFHMU9nfDulOedOh68Qri2l6aoSPhc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVQy8azKcA2kt3vnoiM60jUjvqxYWTKJ4vhg2Y9djW+eD3hEmAPuRALanrs1nK0fsgRdEbzDP8zNygzQvgcv3PalIK3MlwjBs2UQGpgCbsCyRp753QIc99PwWPWBZY0URsMXkrbkuO7bByYU8FQMGmQrZOWzTa12XaSYEaX3DAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw/UpztU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw/UpztU"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-487035181a7so29154445e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774443088; x=1775047888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZG+AxjObasS6xwUegN7FbbmRxqAFvfcWHCDJeVu0lU=;
        b=Uw/UpztUI/fwK/0kWmaICCJCsgBuI7s8r37hRp0B7mNVy69q7vWu4z5CkKIzzJ8nTa
         6KcI66TElgzmXbJyBwjJSdXdPmQ3b0ntBEQavyWOAX3V94aBR3KmUtguB3Q+MXY3RpKn
         KIWTLZIqr/jy2pvYBXs21o/6oCBXESOU2ToR/5N2EyI9OO0TFhUnxSXgQWTHJbLNABmF
         BZgVfP1wK38qZsN/eI7x11EvPVJI5Z92aLCGQu+LwOqw/6CVftuDG2oldc0qIOUYtvSB
         NRVjm9h3O+YsXje2m+o8wgfrWX0Zn0wbXVFv1H7azG2ztwltcGMBojfknS49LYY2LS8a
         wE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443088; x=1775047888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZG+AxjObasS6xwUegN7FbbmRxqAFvfcWHCDJeVu0lU=;
        b=GNQIuAGGQI4Uxw4SFwPJzroT97qDUcRm39Q7AzntrnYc4ILLP2RJnztq/Y9RipxXOe
         HUrfD+csYTheryNLBv7gEkWPrH7EMkJleoXhbLlxri6EG0EwPcPMRt5u3dt/raJwMG5S
         smTKyaSIPiWbn+ZxVGtpQzflxajW1VKbmTzm0TN8IUWYBGy0qF2QyTpjXcJRnwFuWqvD
         AKaCz18uHLDhr2eb6QZxYMctk9yE5szBXxXFAhib6VMOWObHqRqTlqgpFofydnDfrFbt
         7lfmewkGi5pvgesiIHWKnVSmd0boOR7GWZ+X57NbuNbI4AO6uKX3c8FE/xUwZPbpDwhP
         gvvg==
X-Gm-Message-State: AOJu0Yy3UrFAWzGkmbn/yDBmRv9EryrZJr0PVZLD3TqnsLCTqYDRHgQn
	liBHDWwYGa2OUdqnGWVFYsefgyaPAu0P8H6mHkEzMiWE7h0a6L2I3ZRV
X-Gm-Gg: ATEYQzxX6qhV3ORSHCQWoa7VDVlTBMzRspz7cOJcMdJTpJMl+ohGaKf/P0FwdNuI9rl
	6QWDKJHSAx1tN+EASKRpuGkaPZHALg6oqQSaS7IcqEqVe2VA9YnANysgm5qnfI4KfdWNhcqEVtb
	PRdQPVbemwvHsh70nM+8HXDGsi7VefuLaBT8Wy+fh4jJAkC2i3EF+1pb/bgKsn+d04iOBy/rowh
	7hK1MTMAZ1ezUCf4rQMXDBfj4cbMhfZowPkEplFzW3V1nWuz1KkTie/TIm14HVrbzNM3g07nKTx
	ARjhCHrSW6cD3KjW+bJd/W/xIAyAda9AGtyN2pPBQsyX6D4dC68OxVgS2GmtcYUCFCIsnHJGncF
	jr/u7nRTjoyD4y2ErAukaECw0YYy+6DDyZMy8E4vAf7/wURYHJPYMGDnuAq1/naEuyzm5jy58vY
	fxQfvAIaTXHR0=
X-Received: by 2002:a05:600c:6287:b0:486:fc94:d8f2 with SMTP id 5b1f17b1804b1-48715fe2ad3mr45978195e9.14.1774443087426;
        Wed, 25 Mar 2026 05:51:27 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116c0c13sm271961125e9.7.2026.03.25.05.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:51:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Mar 2026 13:51:25 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 2/3] bpf: Disallow freplace on kprobe with
 mismatched kprobe_write_ctx values
Message-ID: <acPaTdLd70YI_uNW@krava>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324150444.68166-3-leon.hwang@linux.dev>

On Tue, Mar 24, 2026 at 11:04:43PM +0800, Leon Hwang wrote:
> uprobe programs are allowed to modify struct pt_regs.
> 
> Since the actual program type of uprobe is KPROBE, it can be abused to
> modify struct pt_regs via kprobe+freplace when the kprobe attaches to
> kernel functions.
> 
> For example,
> 
> SEC("?kprobe")
> int kprobe(struct pt_regs *regs)
> {
> 	return 0;
> }
> 
> SEC("?freplace")
> int freplace_kprobe(struct pt_regs *regs)
> {
> 	regs->di = 0;
> 	return 0;
> }
> 
> freplace_kprobe prog will attach to kprobe prog.
> kprobe prog will attach to a kernel function.
> 
> Without this patch, when the kernel function runs, its first arg will
> always be set as 0 via the freplace_kprobe prog.
> 
> To avoid the abuse of kprobe_write_ctx=true via kprobe+freplace, disallow
> freplace on kprobe programs with mismatched kprobe_write_ctx values.
> 
> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

hi,
so it's another issue in addition to that on with tail-calls [1]
do you plan to resend this fix as well?

thanks,
jirka


[1] https://lore.kernel.org/bpf/20260303150639.85007-4-leon.hwang@linux.dev/

> ---
>  kernel/bpf/verifier.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 12330466d58b..f8257bae6081 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6404,6 +6404,14 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
>  		/* remember the offset of last byte accessed in ctx */
>  		if (env->prog->aux->max_ctx_offset < off + size)
>  			env->prog->aux->max_ctx_offset = off + size;
> +		if (env->prog->type == BPF_PROG_TYPE_EXT) {
> +			struct bpf_prog *dst_prog = env->prog->aux->dst_prog;
> +
> +			if (env->prog->aux->kprobe_write_ctx != dst_prog->aux->kprobe_write_ctx) {
> +				verbose(env, "Extension program cannot have different kprobe_write_ctx value with target prog\n");
> +				return -EINVAL;
> +			}
> +		}
>  		return 0;
>  	}
>  
> -- 
> 2.53.0
> 
