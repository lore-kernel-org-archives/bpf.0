Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B3039F165
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761806; cv=none; b=G0U352thx3Xg5cryJaX9UKyuDXCM+5/0dRtRrASrE48Yful1dN5VwtyEkjDJw5hINIUjdRBBxX/1hqbZu3lDwe5ysnqrMskVrTibVe253RcbSyqn8VqT44TNlGQInq69WEztzDuuSda+UCEEIPNQ9a5bfSbXUrM4uFFyvUF1J48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761806; c=relaxed/simple;
	bh=3dhBzQ+bbdEpVIHq6VxRxN5V+WYOijQC+dXe5oLtaOk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/fo8QKITOlRDWSSJnl7tandT7+UWTfj7zXDw9c0BNpTtxXh9KfULf7k91V6c6lAQl70KbuF8HKzLLsJ6b6t3dtNXWEWDn5XR8OQ1LiB44J44i6GAF4Bi6VEmcs2j51S06dQ58ICOrRG5DUVnf8U7etD7NXNVb/9LWCNk+rscHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjNHy4bt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjNHy4bt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba840146so37420165e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761803; x=1777366603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EvjVgrD7wUaMF/ip8CIwfCZPYUhhfg7yiwwpu15Oxlk=;
        b=fjNHy4btIlbeWPTCNsWurHN9saBamhKEUPd77dKBRYHZRmsWTTYtKkrFKNa3ysQTRK
         E9y6MmnYM2TywqteAxO419N2zBVE4hefZStnsvaV/iFexf2yIxF4NikM/OUI5JmhRlat
         hBE3oP0mjEIdWfdrc8Lmtjke6bkwi3ghzypCk6yXNPJ3tWaMXORXo7NoNnzFlUaqx9B+
         Z4uVrlClhAS/cFnPRBxnLZsiKED8F/3cYacsAFoYF1bn3X4CQmnTNK1xwSNXMI0BcUrV
         sGut2qcHSmAiLzeZyoX19gMaLtXDhYkSrUyd//wZAA05XrlBo4heGnra2JXgm6DUnsnB
         5R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761803; x=1777366603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvjVgrD7wUaMF/ip8CIwfCZPYUhhfg7yiwwpu15Oxlk=;
        b=gSt2s6/T7D0lUlCckVp1Mp3loghTmiBZrsnHIStoReI5CLd8DCT/hG0IEuEDLfMksF
         ENH6Exk8NFgSZ9ljmAKpHXigrl78lqqzNCB4mGghKNsS94HdhpODd4F35gA5LlcECEkB
         Z0fGczZJy/Rw3ts556o5JLme2O7Sa4hy5vUrbdmA28TNauLKce7dcVFDrqLEW++1Lmt6
         ywcbsERT/Yfc1kANuH82TXu6w4dzukNOaZUwSAcEwjFGsShb4XOSztNWT3RrDSGLOX6p
         Dmn3331fTYOHnC1J7rwJpoWuqVUOZXwQETDmhAzrBUYiIe9aJTC64aKxhvgP24rSl+Eh
         tESw==
X-Gm-Message-State: AOJu0YxjfVeyeecFe44BEicV3krb0Yy62nSSFbaaB0G1Utsw5DnRuQ0C
	Hobqwy42Mej+meYFZ3YK+Bgtg2XenV7scqoOcGe2d59Pt35Su5KV7vTk0cAX+MuL
X-Gm-Gg: AeBDies2D3NMnhjeONnpJPRCkr8IlY4G4LaQ+hRfAGC0WoRoIAnccf5OFl8eQiK2YeS
	KNFNcwVHJ//a+brw1xSpaeeKsDAVeikN2MXo8WoR6ZC6pDIihcksQFbK77Zgqmv4zbpC0B+7suB
	bcDFm6NRiHaQKmWIXpww0C8qLFEu5X+H2y9IsM4IuxLmFQr+rCzBcVhHvIVw3VBwajTxGgP3eMQ
	xpSY1ub54R000buCh4Wj0ZCBLXy9AQV5XsAbyNWeJkK1mE00G0XMCqGIN020oVhKe7qdKADmbBX
	jNvCLhJ0vuG0khLVYEc5WgIscasxg5cd0MntcVJspcuGYYRq63TAbcfRb3jDredgwwmtlhXZb2A
	/hRjT6b4Dtn3Hd7WplRgZoM/jiDZpn2Sec6BPRuQx+qw5cC6FKc9kh8Vu7B43UCKPwLWW+F2VWz
	vz29kxJigc0SFZjbo9LQ==
X-Received: by 2002:a05:600c:1da1:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-488fb7863femr258221345e9.27.1776761803250;
        Tue, 21 Apr 2026 01:56:43 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb735d3dsm229577645e9.2.2026.04.21.01.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:56:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:56:41 +0200
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 18/28] libbpf: Add bpf_link_create support for
 tracing_multi link
Message-ID: <aec7yX-RdKmzBZuo@krava>
References: <20260417192502.194548-19-jolsa@kernel.org>
 <20260418035011.164BEC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260418035011.164BEC19424@smtp.kernel.org>

On Sat, Apr 18, 2026 at 03:50:10AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Low] The patch relies on UAPI identifiers (`BPF_TRACE_FENTRY_MULTI`, `BPF_TRACE_FEXIT_MULTI`, `BPF_TRACE_FSESSION_MULTI` and `attr.link_create.tracing_multi`) that are missing from the kernel's UAPI headers.
> --
> 
> commit c0f93aeff516311471202b8e10f7e659acca62b7
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> libbpf: Add bpf_link_create support for tracing_multi link
> 
> This commit adds bpf_link_create support for the tracing_multi link,
> introducing a new tracing_multi record in struct bpf_link_create_opts.
> 
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 5846de3642090..ad4c94b6758d3 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -790,6 +790,15 @@ int bpf_link_create(int prog_fd, int target_fd,
> >  		if (!OPTS_ZEROED(opts, uprobe_multi))
> >  			return libbpf_err(-EINVAL);
> >  		break;
> > +	case BPF_TRACE_FENTRY_MULTI:
> > +	case BPF_TRACE_FEXIT_MULTI:
> > +	case BPF_TRACE_FSESSION_MULTI:
> > +		attr.link_create.tracing_multi.ids = ptr_to_u64(OPTS_GET(opts, tracing_multi.ids, 0));
> 
> Are BPF_TRACE_FENTRY_MULTI, BPF_TRACE_FEXIT_MULTI, BPF_TRACE_FSESSION_MULTI,
> and attr.link_create.tracing_multi defined in the kernel's UAPI headers?

it part of the related kernel patches:
  bpf: Add multi tracing attach types
  bpf: Add support for tracing multi link

jirka


> 
> It looks like these enum variants and the tracing_multi structure within the
> link_create union of union bpf_attr are missing from include/uapi/linux/bpf.h
> and tools/include/uapi/linux/bpf.h. Attempting to use these undeclared
> identifiers breaks compilation. Is there a missing patch in this series that
> updates the UAPI headers?
> 
> > +		attr.link_create.tracing_multi.cookies = ptr_to_u64(OPTS_GET(opts, tracing_multi.cookies, 0));
> > +		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
> > +		if (!OPTS_ZEROED(opts, tracing_multi))
> > +			return libbpf_err(-EINVAL);
> > +		break;
> >  	case BPF_TRACE_RAW_TP:
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260417192502.194548-19-jolsa@kernel.org?part=1
