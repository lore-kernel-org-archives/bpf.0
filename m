Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229375;
	b=b5QZGjFuyWSpi/v9Tzbj1WiLgc+th5dAifdPvpfuCbYZzaHFHrOpqkbSvzNN22nrSDna
	 4UiE9S5zzaCYCsNoJoaMW0UKIESF3SvGjePV51+JLLDX5CXpUD3BeMcMJFeofLl2jLXNR
	 ibj6UHgTiZPbHxQaCXLHgpU1TCtLYCnT+Uxqa2NprhC3RL79/w5o2QNRG3mGlZxG7klZw
	 pN5hJSqBJxrvQARcJ6Dk6eOhw5Pwzt/QDWi9f2kRyhsUezKlBqvMZF+7spyJM957Bm+mv
	 PvF7NOzdehFDJ7+ccrzkp4rmzAAbHXogenUASAvIAU7xwTccw2ntBOY9Bv2dUvoDnBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=B6AQPvXxUiFUnq3vsSRV0XvSHf+1Sj1rCT95ruc8cHE=;
	b=I/A/xIB5RceRvA/V+E6ZLNvgFrmbLaNEDO5fEOJiJRU/cSC6RBi2PPlE3inUvVe9f5Er
	 Sz4b82bq5sEVvQW9GAIrO4yndLLLfz//siTVotS5HT2R6wkuZEpzAJCuJx/lEhE7ZBMnz
	 crtaALunnKvpunu18gZtHuBFyIrD67XatI3d9eaeCjyyAr9UMUeVFn6georekKOr9U/oF
	 GScChlsotTS/wc6HCUQtZmyk6LEWAu9p+oBT8KXsiS0Yl2nAbTpniYfTSOtyO52vrN8hH
	 +kPoVkkrFnXsv/Z2PhA7UKfztfINYLaZQvuT7e56vGVDQHleDyP8mNfbksdjCwPaJtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hYiwbsP/";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC978606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC978606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYiwbsP/
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d473cfff6so113525366b.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 05:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794229373; x=1794834173; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B6AQPvXxUiFUnq3vsSRV0XvSHf+1Sj1rCT95ruc8cHE=;
        b=hYiwbsP/uKjBNM8VY+iCSDoW7Xeye044wpzuuMFLiU8Ho60KTQThFLCVjQSXjCCs3/
         Yium3axixKzY3svx4bT4qasAmxN7vSFmjWEHpmDekniAQpPdeAG1xZtxKHhc2f5Qw/sr
         D1S+PhuUzr+gkoQ5FTI9dFbGiIVqAvby6zBsvrqlMSNbxJOna93JAFqcrVaKujX+n8mR
         zpNkqx4aaNBt41KB0OuqgIQFVmLlos4vQvQMDDCRwg+9RT24mhFKSE+i0537+O4YqZHz
         R2MXHt116MAruOnACPWmEIm2aX/SuvEF//GJIvLjrCqUaLAWaB3JOL1qvp7c5F5R4V11
         mdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794229373; x=1794834173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B6AQPvXxUiFUnq3vsSRV0XvSHf+1Sj1rCT95ruc8cHE=;
        b=Z6U3mDcK25VjMWiW6XmHSkJcoLB1ko90vSkdq1bf4xYafRhb1VD2CP1+E3oeQGCwRh
         YzdPRsd/7zD5RA7Ntj1TwC76MMM9OjpxCJ3htEd+SQrFgDQ0W1z7BlyP28vVxtb4cLYx
         QIH1zHHxNyFpluSIgwdu66UHrx9lE6eTfajP0mQFGwr4+Nwrs5REMpNwCblh29jrFOJQ
         U+We6XqD2F4TOxHi3IMjARQMsF3qmC89WF3IDIDXmsgfVw31MtUPt4sJEPHnkWVEB0nk
         KjBxs4rU4qtdaX21qAjIdqjP9+MCzhS54+oTNLAGUsTtO7g2AhDEviuweSvMz9+47Le7
         pFJA==
X-Gm-Message-State: APuU4Z9BIgY0vh8wRO9PXlJdwmTdeS1CA35geGP9LDE5WVU9wBunN6tF
	pfl4n5AmcaUh1LHsQ9MVWGVMFGNSLZKpmwb3nNiN+jSnuA/IGnR5RMlt
X-Gm-Gg: AYBFou1FlgXSItMQ+M0jNYYJlIM8hMO7wG5MywI1rQj9z7qek6uYFtKHAfVveNWipdz
	U7zrbtqJcotdwiA5ZTKvTI+seVf8p8aRV7M4ZlpmrNTneDM7ljVX1X/49uCe23dTLUp9hxwrAP1
	cVIrlzkU1AhTNvMB3NQRE/DikWBbRfEUL03eqhjoTB29GlelF3y0p2k3XcYIZAL0ssByottneg7
	1XYGgMIsmQ1mUVrE4kdbLds/f8MidzsDwoLfKKH8PNgAxurdQrLsm4TDcsPZyMUN7g+8DC7wlPG
	ZoKMw8h/0ju6jWLlQkxXvuFzVq4KWOXtRckTMMzW0OrIIaWGXQyqSm4b+rzz8Y72JBtqV8GAhpZ
	JtOdnZd/in9pO7z5zM1MHw2RBS0+SNKqCvedx7PC5nWMZIUkXniM2ncAmNDMegFQzxjWGsSZvm3
	YcCco0lXGP2Ns3MaHisPIFSaKmUkaZNNxiGDutSQUhXx2brZgvqAyN/UAKOF0Rk6YgmhVGgt04w
	NvXUAksCa4EycaxYjH+sub5l9xuz9nimEThZCrbBzudWhh1iWxKpxBQGmCaPzpcO0N6M1aOQ5p+
	ydRRKxBbXGqHW0j1Smi/hMrsMmAsWlXO/kas
X-Received: by 2002:a17:907:8690:b0:c4d:5820:325a with SMTP id a640c23a62f3a-c4d6dd768c9mr282571866b.39.1794229373239;
        Mon, 09 Nov 2026 05:02:53 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d53b77sm168456466b.11.2026.11.09.05.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:02:52 -0800 (PST)
Date: Mon, 9 Nov 2026 13:14:26 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 13/18] bpf: Check the return values of
 fmod_ret programs on found targets
Message-ID: <avHHMqdiCgT79XWT@mail.gmail.com>
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
 <20261106210314.1767267-13-a.s.protopopov@gmail.com>
 <sashiko-outbox-202293@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-202293@kernel.org>

On 26/11/06 09:17PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Critical] bpf: use-after-free in check_helper_call() [1]
> --
> 
> commit f5e3bd12bcf921a0d31fb8a40c17694ea46d4300
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> bpf: Check the return values of fmod_ret programs on found targets
> 
> This commit parses the "bpf_fmodret_retval:" BTF decl tag on fmod_ret
> target functions and verifies that attached fmod_ret programs only return
> 0 or one of the specified error values, while disallowing tail calls and
> freplace extensions on such programs.
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1b58a1796a2e4..71fbb30e4d768 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13338,6 +13338,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >  	}
> >  
> >  	if (func_id == BPF_FUNC_tail_call) {
> > +		/*
> > +		 * The program which a tail call jumps to returns for this one,
> > +		 * and a program array does not check the values it may return.
> > +		 */
> > +		if (env->prog->aux->fmodret_retvals) {
> > +			verbose(env, "tail calls are not allowed in fmod_ret programs with restricted return values\n");
> > +			return -EINVAL;
> > +		}
> >  		if (env->cur_state->curframe) {
> >  			struct bpf_verifier_state *branch;
> >  
> 
> [Severity: Critical]
> This problem wasn't introduced by this patch, but in check_helper_call(),
> can passing an RCU-protected or iterator-yielded pointer to a pointer-cast
> helper such as bpf_skc_to_tcp_sock() drop its lifetime constraints on
> regs[BPF_REG_0] [1]?
> 
> kernel/bpf/verifier.c:check_helper_call() {
> 	...
> 	if (is_ptr_cast_function(func_id) &&
> 	    find_reference_state(env->cur_state, meta.ref_obj.id)) {
> 		...
> 		regs[BPF_REG_0].type &= ~PTR_MAYBE_NULL;
> 		regs[BPF_REG_0].id = meta.ref_obj.id;
> 	}
> 	...
> }
> 
> RET_PTR_TO_BTF_ID initializes regs[BPF_REG_0] without propagating MEM_RCU or
> parent_id from the input argument, and the cast block above only runs when
> find_reference_state() finds an acquired reference.  Because RCU-protected
> and iterator-yielded pointers are tracked via MEM_RCU or parent_id rather
> than a reference state, regs[BPF_REG_0] is left as an unconstrained
> PTR_TO_BTF_ID.  When the iterator advances or bpf_rcu_read_unlock() is
> called, the parent pointer is invalidated while the cast pointer remains
> trusted, allowing a use-after-free.

Not related to this patchset.

The bug itself looks real, I think it requires a follow up,
will try to not forget to send it.

> [1] https://sashiko.dev/#/bug/linux-97cfbde4-a454-41bd-bdcf-b13a51d2adaa
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261106205523.1765622-1-a.s.protopopov@gmail.com?part=13
