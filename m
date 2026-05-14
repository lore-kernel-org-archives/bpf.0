Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42525393E
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758828; cv=none; b=EDKod2j+DWoDpNOeJBgkaKQGa/a0WoosIkukfatOOET38QNJNQk2OpIuSHN7ajmC2lPz1Qhvws9C8o8PecHPRLgJ5iAlOZ3cAmNtC3Q4uecVj2+kG1ayaDOWCGx/oKXXTH0NF0sitRa75pumcxkS2hYiNsgrrid4MBFHCQLyIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758828; c=relaxed/simple;
	bh=CDg/f/iPE2TWSNF2OOK72s+EMcw2psqjQNDh66aIuuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXhSYfXEc6fv6SD0zpUY3Q6y3bRr//YdkQKM3TRvwAvXTL3Q0PqD2JGIGVM3c2XUYytjiZFk1LNxmRul42+WFxFvpCT7IRxcQDn3Rx3le+M4RY9S9JrFyCsdGaoO50V5qWuhVaC3PVEJ8x5BKvTfmkBr6bnPW61weDxrRX2bsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkghvynB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkghvynB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso43143955e9.3
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778758825; x=1779363625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ldth8JotWNNXuuFjvG7OgbN0zVV0RxKzEBMsfyUjvI=;
        b=RkghvynBD20rUHrbj246ARtmiJdlSIFLVY8HjHBuQdggEcmF9Na6gKlYtXQdWxNIfn
         QXntEt2DRxbz4FY7zfF2m9O1XKeI9Nsj2pg80UfHPQ0W3KFz3Mi3eTLPH/RzuvpjAcdO
         aDs1KlBqNnmPO0xY4s4LJNtxTAigM5YQRWlugvd8AHMHd7LU3Rg+MWD6/3SLSsyo2qNO
         KV7ralCY9l0f8uJh0qhLt5rFjmdmTjpB6uijfbR7np6ba06MUfpsMAxzpTYEUiQy3q3X
         OjxKHH0EDVKnXG96gXMZPU/sh9HaOQkIKQm68CawsS58RkeLBNloSCNG04fEsDRkQ2D1
         eyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778758825; x=1779363625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ldth8JotWNNXuuFjvG7OgbN0zVV0RxKzEBMsfyUjvI=;
        b=GziXU5WuoAWdhVnVR9mk4XQ9eWXLO0X+lOtl30dkDcQfjXROYz843uoQ0RwE0huRao
         2c2i47KIT75/xlab1m36/gXr3XpE03DenfOmc08LovQo+FE0Vp6YVDJ6uG3Hg1tZBOk/
         5n1MbX8u7qZrD8ltxY3EvMJO3SGGKxGAsRXjuVTARSBKrjHKC3QGRBgiFAMRhIJobUu1
         1oKhsL0rZSSDb/Jqek9KZgh+vXV7a6XFV8/u0fCntkwxPlFlPt4AFHxd71AnufqQjzxf
         UttisaeNxTMWU85y+HLJ4UbFrM9GVKUgryN1WTBLscwrc4zfJsucHZVkRTiYlCi3UWmP
         nbgg==
X-Gm-Message-State: AOJu0Yy3UQQpnWRVc2pA4rqwHCU+oOi8h4zR23pV5hmDlej4/vuozfzp
	OnXqRJOwcY82BfUTbBWVuifc3SMt8gze37QZF0rehx515gv1X29CnEww
X-Gm-Gg: Acq92OFuaYTqeaMd7wpXUPtdJ4eCViOmjMXwCBB69hu5fr637mQYPbQbmmTBtXdol4x
	iIX1ZBrFl9gD8y75tBGYArMjz8x8/0D27+SyEw4pZBxXEb9rP1CgZsnC4UzZu04JmOU3xYfSRgx
	cSar4tpXJR/j7o6Up1lxh0uiMlrcmq6bvo8FST5cHkoLnmEsHB6mEqx79Pjj62SQ8bcI/sgW5be
	a/KJJSx5JYUH5uA4mbEhsBQhRLiip8vCvQ/zVCJ8188PLEpAc5iHDA0WRhXS3Wz3leAdn/7DKlk
	LhGZ2Y3Mn97VBclzhneALn+BoO0hwrLBylJJykIZN288x4lw2PiyBaRNsbihpAw95Ka25GQIxYx
	M3E2piVeD7m1lQXOZRQDp+qh0GKlGTT/R3vYCiQIDnilfSxwi6XHYtu/2/tIz6Zmj+c/eUNRVmb
	eYrzAyTqrKB3Z/cF0/SmGxg2WgPqpNuyhDepUCXsuW5/5cDTx12/Orp+DqpMoNeIb+KN9JZXhvy
	yDpqq8KvaZ3NKfrRBIM14CDM5mIBUP4Wnzh+bvVXwPaY3LvXd+uJ+s8BwXCtIm5Z0TxOsSGXH52
	fw+XEwMrRu9OX/lq/m9tifL+q0yvIRfI
X-Received: by 2002:a05:600c:350f:b0:48e:8741:fd4c with SMTP id 5b1f17b1804b1-48fce9ead8fmr105645615e9.18.1778758824740;
        Thu, 14 May 2026 04:40:24 -0700 (PDT)
Received: from Tunnel (2a01cb0889497e0064f055e44d25c4ef.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:64f0:55e4:4d25:c4ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm5662323f8f.19.2026.05.14.04.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:40:24 -0700 (PDT)
Date: Thu, 14 May 2026 13:40:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] veristat: Report max stack depth
Message-ID: <agW0pt2oNh9oKq89@Tunnel>
References: <cover.1778700777.git.paul.chaignon@gmail.com>
 <a27ed8f336669152c4b1b05e920aee4438e3e2b3.1778700777.git.paul.chaignon@gmail.com>
 <fe8bedbcf7a9c0b3af7c92351a694784804f7e82.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8bedbcf7a9c0b3af7c92351a694784804f7e82.camel@gmail.com>

On Wed, May 13, 2026 at 04:23:48PM -0700, Eduard Zingerman wrote:
> On Wed, 2026-05-13 at 21:35 +0200, Paul Chaignon wrote:
> 
> [...]
> 
> > @@ -834,6 +835,7 @@ static struct stat_def {
> >  	[SIZE] = { "Program size", {"prog_size"}, },
> >  	[JITED_SIZE] = { "Jited size", {"prog_size_jited"}, },
> >  	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
> > +	[MAX_STACK] = {"Max stack depth", {"max_stack_depth"}, },
> >  	[PROG_TYPE] = { "Program type", {"prog_type"}, },
> >  	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
> >  	[MEMORY_PEAK] = { "Peak memory (MiB)", {"mem_peak", }, },
> > @@ -1023,7 +1025,7 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
> >  				&s->stats[MARK_READ_MAX_LEN]))
> >  			continue;
> >  
> > -		if (1 == sscanf(cur, "stack depth %511s", stack))
> > +		if (2 == sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX_STACK]))
> >  			continue;
> >  	}
> >  	while ((token = strtok_r(cnt++ ? NULL : stack, "+", &state))) {
> 
> Thinking about it some more I think that the meaning of the
> STACK/"Stack depth" metric should swapped for max stack depth.

Hm, I was a bit worried that might be considered a breaking change
(ex., if someone is tracking the STACK metric over time), but if you
think it's alright, I can send a followup to replace STACK with
MAX_STACK. I agree it would be better as the STACK metric may not
correspond to anything real at the moment (ex., if the callgraph may be
all flat).

> 
> [...]
