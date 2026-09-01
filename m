Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB53806DD
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270056; cv=none; b=aVLbaz1GeOOV23wAG/A1C8GsiqgX4i6PDYZHuOTqK9IkfUNnVLl2ZmkmBCtnxMt+WiOnIRwxDS8q8n64rZMDb92kpkXMMiHQHHZRG//1Vm0T0B9jmmr8O1uMmg2IKaYpZAn006plegMD9k9BY03sT9BmpmgtUUYjjZtcc+WDByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270056; c=relaxed/simple;
	bh=7xm5sajbb01sj2Uf0UekBpbsCqCy1OTaIDBG0Pfb4/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k69oA2iZ2LL5BFJOP+8nGsaWqMfhLvgYEI2dDekbrmeACUayzuAEdWVno4g5jRTsK5KxTGu+Kq5hotRIDhZ6vZ/6MXGeeAH5UwKtgTDQ9+pSnsywbyY9x1/wRv19XHvnf76/XOwc1erg4tCod1/S5KJEc2/zFrYc289eErvyyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa+T0djg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa+T0djg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49954b88fffso34311015e9.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270053; x=1788874853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XqGHSUCegqFm5LumV6i1f0/rJo7Oi51dC82e7oDCp40=;
        b=Aa+T0djgZTUAxokJKzuKyVPRZ540uivbN0VHoN4x1a+mzwvsDqPXog/+7QXTUWUa6o
         euEf6A+MHxfW1dFpxFGlYclHyME133TlVGHxtGPKz+25suJ3puWV3qf7/PgkCYK3Kd2w
         5zfpmKklHGmnFf9m6BdEli6RKvfQHQBruOHjWQ+qp/JzrxbvceKhlGkZGIgyt4qjWpN/
         6TFtcYUBsht1fF9kHjNovssW1V3uWpr/r4N9D4OhsYeKzp1Ba3JeaQ0YPWWiPuGkD8o0
         vk7AsaB6N1G1KH9sjD0gvuyPUq9kol7ltAETdgp5Gc49oZnOwIMPThmelq/xzEAP4CSE
         nL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270053; x=1788874853;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XqGHSUCegqFm5LumV6i1f0/rJo7Oi51dC82e7oDCp40=;
        b=JbvdtqXNbqTMNVbFoJIAmRa5jJ97jnelFMB1rI1pxf10R/f6L1RfTLtyPGG55Pu784
         Fliuw/06haLj05C+uKfp2oLHhZdWr4hah3pooJPHd+SMFNNq0NqZ2J3NySFjDMiK1iBc
         zOpc6KHRGvzOzvIRgeex3/IjTw/dXMExHpmyvfE3OpkmDsDMNxK7UG4ioSwcoUZFjQCi
         tq8fkZNSQFfCbqklpxjuznUnv38P16C5izJeahV2ixHNINbVNtHEzTzE1ujsN/Ljgbv+
         7uUPtFk7koZJE+r8tGBaaLlrltdNV31snGLMt5pw16bxgMdDHCOz2WKbAhdsk8rGp+Sp
         5H6w==
X-Forwarded-Encrypted: i=1; AHgh+RrsvhiNIta6+Bnn/0anudDIeXxOCPZE97cdU+uz4vusqlfEm0JU6OiS802PulM8nS1nhlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lVqDrZrrOYzlivTKZFFu95wq19sbpdbnXjCIQeYW8haG0+gI+b
	G4zvD+3ARPI4XW+9VyGJxo9FVCaeHG97Zh3VHKpYsSSDCnMzKN5WPFRP
X-Gm-Gg: AR+sD134DgNSLiRq6Ba6l2reNREcu2MtjdqBBIVxI3Q5k2gjJMqEZlVOOn1KQs1JFH/
	hZEUPOK7cDQl+bsoBBPkv6w3UuQN2PAe+ZEOmQrh8KIhO18TRc0fl/xXOAIiU3t7mHw7QaGPNUK
	OYTnoC3cOqFoX41Q+yd/z2Flp8jFOcBpF9gvhfy/ikztqGgXl4G0GXzsjOnT/Fgc+uFb8OYl4ga
	J/THfjopsAI0lCevK73Pf/4EzekCMM7iiiSQiSTX1jUC96dNyL6Ov6x5aLyuuym6LUUbuXdzZdL
	5uqT+tEhgtUR9pg89F65EZPGYDiWWbWxzGkWljX1nfJGYzvpNnWt3D12XPYHsTdLRFvKVDP7g7k
	mddMddsVwg8CtGBLSamKtN4rjxDziNcPnv2kO24Ts+e+Tj3VACK9/RXtuy4xAA3JX5hOpNxsv3G
	ok6Oy/9NCtWjkIfqCLaoCB9Ow0NfpwqouO6CVItl8IzHC5BZLLNFCG57xSXNdaz0Wci4XD
X-Received: by 2002:a05:600c:8581:b0:499:a760:722f with SMTP id 5b1f17b1804b1-49b91c47bf8mr437892345e9.13.1788270053120;
        Tue, 01 Sep 2026 06:40:53 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d7c1c0sm5088229f8f.32.2026.09.01.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:40:52 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:51:30 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: sidchintamaneni@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, puranjay@kernel.org,
	rlmenge@gmail.com, hargar@microsoft.com, apais@microsoft.com,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: allow terminal gotox instructions
Message-ID: <apbYYiTCT8w6a4MF@mail.gmail.com>
References: <20260831223314.89787-1-sidchintamaneni@gmail.com>
 <08bc375fdf3ed6ec599f4f9a8b220f46d8d485a2c8420531f081797b33cf1296@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08bc375fdf3ed6ec599f4f9a8b220f46d8d485a2c8420531f081797b33cf1296@mail.kernel.org>

On 26/08/31 11:26PM, bot+bpf-ci@kernel.org wrote:
> > bpf: allow terminal gotox instructions
> 
> This isn't a bug, but Anton Protopopov requested capitalizing "allow" in
> the commit title when he provided his Reviewed-by tag. Should this be
> "bpf: Allow terminal gotox instructions"?

+1

> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8f585ceb2cd51..483473df7746c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -3107,7 +3109,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
> >  		if (i == subprog_end - 1) {
> >  			/* to avoid fall-through from one subprog into another
> >  			 * the last insn of the subprog should be either exit
> >  			 * or unconditional jump back or bpf_throw call
> >  			 */
> >  			if (code != (BPF_JMP | BPF_EXIT) &&
> >  			    code != (BPF_JMP32 | BPF_JA) &&
> > -			    code != (BPF_JMP | BPF_JA)) {
> > +			    code != (BPF_JMP | BPF_JA) &&
> > +			    !insn_is_gotox(&insn[i])) {
> 
> This isn't a bug, but would it be worth extending the comment above this
> condition to mention gotox, since the accepted-terminator list right
> below it now has a fourth entry?

I would ignore this, indirect jumps are unconditional as well

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33447655511

