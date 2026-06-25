Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669883603DD
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370072; cv=none; b=Khb874fY3k1W9P6KzHa/OOHOMTQ/pisg2FX3P10W0CCGzrMEyB57nBhAKsNgowTKpIqjBBHJldJ4hUak8tUoE7WMOYuqGiLVCTiybEQASxFf3AvioNwex0D0S2pBtxdvb0EVpcRRmakqAgN0Nr/tb2fY6NkY0i9+tzXphVscZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370072; c=relaxed/simple;
	bh=2S4oue/5LZpXedezfBMD5Ldx65Q0wL8h3EePY7kAULI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp4pN+PccFXVis0XNgkZcAghMjhAU0oMoMZS1ogcfvfnluip2ZWWQEMMDWrePokuwNxuLxvx5TgD6J6luefXKDLCAivXChLKRuudEJWkkIWtCS6fZlHH8eFHi8iNNlwE15V1CZFaA2Y7ddBrnmW89jUW+Wjh+6a7ghT9ydLyAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e88mWsmt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e88mWsmt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cdae130cso10186055e9.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782370070; x=1782974870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cU2+wBd9BH/gGXihQ9a2daHlvxuS/kh0+xAtwAu2RDM=;
        b=e88mWsmtIuzzcS2F212jaTcmcYosnNQ5ID8GhC7U2grcJxVf26uIuxgRc9+xCnlCbP
         HrzFwIwtbGNAxpW5oo0UtOjGtBIkCkSv//f80A9D9h6xG3j01yPuPJYljFiWsSomvU2P
         IQjgBls2GQimgwsDsxrlQcsZFxyulTiuSnG2kUKvUj90eN3z8G+G0MaGEMeYcneQje1h
         rHr5gHBkYA3KdqluE0EZ5pVADvbRwqInVx3WImXpYxFdSsGOgiDTsppo3NYYT4Pcx/os
         qSeEJMdhCW4VTrLFCzF49eQnciakCIwJd6TUUM/lidNQ8cPoPwqpRBvxAdF/GALPltjL
         nsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370070; x=1782974870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cU2+wBd9BH/gGXihQ9a2daHlvxuS/kh0+xAtwAu2RDM=;
        b=d6uMJ05uncR0Vq2riySPGhiAZR/ohMm9hyVS6CncCSfOBKHtw5HFHvG87zAuPMnOBf
         gHrpgT2GETlhOgHTbiDuTBp7rXPAlAOSA8yx/4WLy29MT2xky3AzzFn0i56oYxp11/k+
         F2kslLVPd8znsAOKCYdDeBtIs+Ylsn3bkW1U/6W7EQXG/YVx1Sny84owc/o7+VwZBt4m
         +lVyeZiVw0zAKe8TjyItPT4eeMfn84jNyKn+s1VcINSgl52N6i52Zqj80vXX6i1owTdl
         7fxC+mX/ZFYTNHoRyEqxXtWN0/dmQbJfeJeEO/zJu/8pdLOBIe3ogJMMgAY3ouJcKLsL
         slXw==
X-Forwarded-Encrypted: i=1; AFNElJ8pePs7WKjl+cuOogmqjU59bRCSY+y8dATykt6oAVxIhbY5LXGi46TJNSEGYF6sq7+vgyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAKyDa9o65oQ5qCxr8O8TwAdqyFssp30fuGELaKik0WzNfl+P
	2SMghBdtv94HJbgymRW6fsaOyC+mEhuSoZfSn4uRraQNSv4UNuxE05B5TnOsOyTEK+M=
X-Gm-Gg: AfdE7clL8YQxLsuDKdtcdyPC0aDeANATJbRRUZS/hQOle10ALFH3KDhG5XKV6glXWHw
	Q2oJQ9Gwt+ybPcvy+nw0WXyUuA68kxq/8tnpLTbcbg9dWJWBlO2K+C4iqRneymFVPinLvvS/pj3
	BcxF1Rx07/eJL+FICKZfPsSq8ObsJ1qymWhP+2u5ODcofGmKtt0skT3KkxLundt+8SBTDAbfW4y
	UwQEhhqzyVm1dWZVFVEGiiLHrbtQGEk6vMJy9Y9ezVUsHPyBA2EiIzPA5sBQmfSHK5IUpviJfX2
	77bbnnaaqfaHrVeXbBYJHhMMyQVnNvPVU0NoRygkJOjybGMCG9yJtHnWAmfemCdkCqruQu34Aa7
	CZ6Ys72WjTFcKt7g+BbhF8keoZUCSfzu+dl/Hkfh54K3nqWdGGBVxrsbZFWuM2knWVuM/Jav6R1
	TPKlydogFbRU95op/MATpiE8tBGOupP77O
X-Received: by 2002:a05:600c:4747:b0:492:40f4:9fab with SMTP id 5b1f17b1804b1-49266889b4amr13294045e9.29.1782370069749;
        Wed, 24 Jun 2026 23:47:49 -0700 (PDT)
Received: from u94a (110-28-25-46.adsl.fetnet.net. [110.28.25.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f65127a5sm12795685ad.83.2026.06.24.23.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 23:47:48 -0700 (PDT)
Date: Thu, 25 Jun 2026 14:47:37 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: ziye@zju.edu.cn
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tangyazhou518@outlook.com, shenghaoyuan0928@163.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpf: support shift operations with
 non-const src operand
Message-ID: <ajzHAB3EJDD2IY83@u94a>
References: <20260623120218.25869-2-ziye@zju.edu.cn>
 <e290f581e78208441b8c3069a7ec3bdc7f1fa76c189d566ca924488b418d9950@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e290f581e78208441b8c3069a7ec3bdc7f1fa76c189d566ca924488b418d9950@mail.kernel.org>

Nit: subject prefix is missing 'v3'.

On Tue, Jun 23, 2026 at 12:42:12PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2abc79dbf281..bf247c219cab 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -14516,14 +14565,14 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
> >  	case BPF_MOD:
> >  		return src_is_const;
> >
> > -	/* Shift operators range is only computable if shift dimension operand
> > -	 * is a constant. Shifts greater than 31 or 63 are undefined. This
> > -	 * includes shifts by a negative number.
> > +	/*
> > +	 * Shifts greater than 31 or 63 are implementation-defined behaviour.
> > +	 * This includes shifts by a negative number.
> >  	 */
> >  	case BPF_LSH:
> >  	case BPF_RSH:
> >  	case BPF_ARSH:
> > -		return (src_is_const && reg_umax(src_reg) < insn_bitness);
> > +		return reg_umax(src_reg) < insn_bitness;
> 
> This drops the src_is_const requirement so that non-constant but bounded
> shift amounts are now range-tracked.
> 
> Is there a real use case driving this?
> 
> Earlier review on this series asked whether compilers actually generate
> non-const bounded shifts, and whether any real programs are rejected today
> because of the conservative handling.  It was also noted that the current
> behaviour does not reject such programs, it just falls back to an unbounded
> dst register.  The range tracking added for BPF_DIV/BPF_MOD deliberately
> keeps requiring a constant operand for similar reasons.
> 
> Without a motivating program that is rejected today, is it worth adding this
> complexity to the verifier?

I am with the bot here. This adds complexity in the ARSH code path, and
while LSH/RSH code path does pretty much already support non-const
shift, without a compiler generated program showing this pattern it is
hard to justify moving the patchset forward.
