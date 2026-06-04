Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7B2FF67E
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560036; cv=none; b=kUOtVGG3H6OTcGo9fOcoewITJbBBUjsWJheFQwLlw4qVnyGbaZGuCktv/Un+p4iYi/fNHfieMQR0cWIZ78XS57iDkTQZDeXjRFG4h860Fy4oCh2ZoRI/1+4y1AzyQ6F+xh6x2xSSmRP/BObN6xm5NzZXqG1Dz+dnu4RTF9BM+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560036; c=relaxed/simple;
	bh=SfESCifJlQC8gwG7XGfkvZA9ud2mCQVHiHUPsZbe7+A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCPL6zKAj6S8lInv/aRbAIn9/0GCGKsEmNv3bfdm2DHcJ2tAjUxIT9i/+0Yl38YDQ3w9S1CKyEgGMFOHrrNKad94qyzG1zPUwCPIH8BnY+3pikpNC6cs//AD52fXRRmJoUquXk8mqdwJL6BMVUmMmrsjUvy8ga6SbH98D5vTYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlfCwG7A; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlfCwG7A"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so285779f8f.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 01:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560034; x=1781164834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fwggcNXE/qZG0R5u5GBwdY5Nt2S4QAlzMN0onVXeTE=;
        b=WlfCwG7AEN6Zk0SM7HNFKuhBvpCtga4gzQ20cB7V/PLjBWrjiV5IB54k0VXJgSHqCF
         3brpB/CE0/uDwcY4GvJ71hj/Cc1832cPEhRT0vxEl1QL0wobEP/ps3pWWG80ZYaU3ZGz
         pRG1gPp1hjwGZjapy0nE573FHmZ48ZlTR65Iks5EKdJYe5KcfaJ6r6ENXa7gfjzkaBaa
         Cz5AXpKVw7WmPWR4N+/k0Ch+ZjLgxoLF6oLBfqo+SOTqbkJw+HOmUl9/QrlWIjx+vezV
         Fb9quk2uYhjNBqCHBG+0MytkniIdUqj6LRn0HlVJZqvSCss2dxxmIrNfBJdkYppZqOkJ
         +5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560034; x=1781164834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fwggcNXE/qZG0R5u5GBwdY5Nt2S4QAlzMN0onVXeTE=;
        b=chGdvIYs0IJI0LvymS+X6jxERhPT6z9dGRtbrkhg1tOTZDEPFlDN62o/6c+HJZxPlw
         uuhcfAp3xkruY1UhDM6f6OLaKleDFby1qCxOH44tJD/fYHXYAO7Ea0Bh/Vy1/D0GNqnK
         RIx/neuZRPV+YKQHVvrBJ76sAkBZgfZ2HSfykR6P5KECwVt/wwcl4SHfNHLnOi+LLvCV
         wP5C2DtIt8Skp0mMnpawVWAfbRGu5uRbn8Gl8FGYQoHMnCvCsmic0Mm8p8pbbAxiar1h
         WOWCrmRkcaQZP2o4p+QB5b/+XgmVw0q7WfqJZffaOxqfvwu8kDox9TnCr7OREWS9AJeT
         sjJw==
X-Gm-Message-State: AOJu0YxYh1HcPoEEpkWZ2gQhFiRvza6VdzeJK7p//AR5ylG8piK4Ax63
	1RTobSoRfbbV8nXHco3R7Tnkk5RuUVZrwFtBEStApgeCC0vsVuiqtxhK99fuHw==
X-Gm-Gg: Acq92OE3cc/usxW37hNrmC4ziUhoeC2td3K5TY3HGCUmbZLrG6+Y07nZ8r216U2GoOM
	UDJgY2/nSKesvp6yBUETW6xlogGiakJp2DxPVFs3Eg2+0608xALUQlyx2WXzNSKrJSMU7vZ+Ww0
	tN2bCnJeS3uY1KpcJ42/w4yK/kTLiRtDyCVuhMO4y0SB36wH6BJBCDFsjTlDOLS+mhUTzG7+NVw
	EEs2YGYvbBi/DvrEDQDn33CV8Dpj3lM3F+g9SOx+oKaQiTKRq3+ntSXpRFZxn8mt2uoaA6WZnJw
	9OJ45efCC3X2iqmYU+o7KgOX83BIbLxcd6XTOfNSqPymm1X1tmt534WAKg/ObqQPjB5lXmaPxy/
	8tOcbAUS5c/HkPgFZ0m+RP7qQWpLG01Ny4jIdSagw/2MWgz3uAxwENjRjqKXJkGeAIW7ZLz0AVi
	B6Q6KnZtXfd03maqUOyjMTU9HE/1lWEHjeOAJl
X-Received: by 2002:a05:600c:458b:b0:490:b409:94f4 with SMTP id 5b1f17b1804b1-490b5fdcda1mr115062605e9.28.1780560033621;
        Thu, 04 Jun 2026 01:00:33 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda363bsm1541050f8f.31.2026.06.04.01.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:00:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 10:00:31 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv7 bpf-next 10/29] bpf: Add multi tracing attach types
Message-ID: <aiEwnwBeP69ZUpCA@krava>
References: <20260603110554.29590-11-jolsa@kernel.org>
 <20260603113751.DC4C51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603113751.DC4C51F00893@smtp.kernel.org>

On Wed, Jun 03, 2026 at 11:37:51AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing `BPF_TRACE_FENTRY_MULTI` and `BPF_TRACE_FEXIT_MULTI` cases in `btf_validate_prog_ctx_type` causes valid `.multi` programs using `u64 *ctx` to be rejected.
> --
> 
> commit 0330f287f02c3a32c9ab8bf7f4f5a6ad6cf7366f
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Add multi tracing attach types
> 
> This commit introduces new program attach types BPF_TRACE_FENTRY_MULTI and 
> BPF_TRACE_FEXIT_MULTI to support multi-tracing attachment. Base verifier 
> support is added to recognize these types and accept them as sleepable 
> programs, while deferring actual target validation to link creation.
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8ed484cb1a8a4..521ec2a9051ed 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [ ... ]
> > @@ -16314,6 +16314,8 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
> >  		case BPF_TRACE_FENTRY:
> >  		case BPF_TRACE_FEXIT:
> >  		case BPF_TRACE_FSESSION:
> > +		case BPF_TRACE_FENTRY_MULTI:
> > +		case BPF_TRACE_FEXIT_MULTI:
> 
> [Severity: High]
> Are we missing an update to btf_validate_prog_ctx_type() in kernel/bpf/btf.c
> to handle these new multi types?
> 
> Currently, BPF_TRACE_FENTRY and BPF_TRACE_FEXIT are explicitly whitelisted
> there to allow u64 * as a context type:
> 
> kernel/bpf/btf.c:btf_validate_prog_ctx_type() {
>     ...
> 		case BPF_TRACE_FENTRY:
> 		case BPF_TRACE_FEXIT:
> 		case BPF_MODIFY_RETURN:
> 		case BPF_TRACE_FSESSION:
> 			/* allow u64* as ctx */
> 			if (btf_is_int(t) && t->size == 8)
> 				return 0;
> 			break;
>     ...
> }
> 
> Without adding the new multi types to this switch statement, the verifier
> will fall back to the default canonical type (void *) and will reject valid
> multi programs that use BPF_PROG and u64 *ctx.

yes, we disabled direct ctx access for tracing multi programs 

jirka
