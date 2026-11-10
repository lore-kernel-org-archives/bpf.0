Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320354;
	b=U/Ue967JfyMCphvFD3TsToRGAq4nnU9SP/eCG8ANPVI+OpJ8HhRBFk5SIdMWty4Egxb0
	 w08AiB1AAewisY+AChFb7vEpTnwxvr5a229ae8I3s0+kM7f7L8KGZkwIhN3ZCBHddLZJi
	 4QBX8a0TUd67+1FFggj9FX9iNeUJ8E1xG4QWyS56PwfYEhvcn4+B46x4IP+kNe6bNLXnJ
	 azC5sKRu8iSqqVUdycTLN3ZfTJRea6Sq0+6RfkK7puMxQSzYhCXhdblxg06rQGrts2RlO
	 rAtvcFEJX3fSv+IOTxtfG0IRl4SddHgaus3tJgX5gARtQoJ26P04DB2TyCYwH+BgGUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QhTJ1UWGwR20oUsM7cXnvNb9YbQCwYXDfIW4idiD5k0=;
	b=A+1ns+uKLzzC4hHhEJgH/W+I2rJCygWFCHa5vhdG2zIsKr/Gohz88iXyLyjveoYa9Sz1
	 oXckP/DlpVpRWnAI6Y5vGohbQdKLjMS4lMbYmGtnodbIP3/6bBem8Zj43YcbakfICbx/O
	 7yaTcAp6meV3yYulICObeWquU6cpniDUCwnL+sucFmuIqOzZ9KnE33k71NvWIGTrH4rqY
	 dGDbJn6FLHyl5HSVTc+y08Nc013HfzaSZ0IJ1LGPiaVxE/ikVnm7KTrd08kAs7OpKDA3d
	 W7ke7Sl7kSEsbCysQXQ02F952E4QjAnBK/f7+GEqdAk0o+MRSKOx+GaA9NBypFiJI9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OCEnyKXP;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A745606A331
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 14:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A745606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OCEnyKXP
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490a0e72588so1125033f8f.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320352; x=1794925152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QhTJ1UWGwR20oUsM7cXnvNb9YbQCwYXDfIW4idiD5k0=;
        b=OCEnyKXPWIWFw5ljr+H0oHgSUaB0rFehTyl429KRO1pZ9/t9V7/GJ7m8ejs/lACNsZ
         U9JlZI/IpHdVc1KPKZaYJOXH+J0PoBENn0EadHm+PW865kSg60hGVtMzm2gquoliW10+
         spbekRFrFUI+aow8X1uRzuU9xYALTnKf6ga+8UBaLq2tY1SDvyIcMq8sf2wJwFllB5Bi
         BmNHiYhq1l2K580vvkrrbMJxEww6fGPSQutjrGWhuTISGjh7T66D/H2s2UQ6WUi7clW5
         Jl/lqMFIohyhRtZlzFJUia6nT93+BQafWuXRSANmYLgSe5MNUAf2kORWZC4apQeo5NVh
         N9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320352; x=1794925152;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhTJ1UWGwR20oUsM7cXnvNb9YbQCwYXDfIW4idiD5k0=;
        b=w3sC86Dc2qXSDXLWEvW2SUgPvqTO2Q7jXwcOemDBSSJQiXkLFkJjgngii9RNFhJ4Y+
         9ZydtipPcqqSFzQxNOok6XQE2J8FppJhlCW8grwoNa/tDf9iKg9wPbkqyCWUcZev8jkB
         V/4d0SjjIqRcANbn9/J4IEME3SmBUGDkKg15k8q1glTju975Vm8dp2PPXNpZ9wwDW5X0
         sR4BeJC/yJZdju5fYBSgcZIEBIY2xnORDxGF5V6vPoLDor+V6yMtlLmPUBDBCCALJ0pB
         be4FmNv04nWgniPTd+2Nj3JFmdgHEIHowL+PpUH7FIUQYspIL/LaZAnYilRTpFJ1Mfom
         ozGA==
X-Forwarded-Encrypted: i=1; AL+hErG0dLGW5mTB1A/V3MaQavBrkg0vFpIIRLYeozsYn2I1/6ohYziKTH8Ry7P7gGof5ysZTEY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5sfGrEIlF2EaZRnM5kpgAnIwTebyd+8NgcRTPmwwkkxB90tP/
	/GYkaetxKKp0vJcnJA2imezrLvlmBZX8fuZj48m+gmh3SZc4jcwA8qaa
X-Gm-Gg: AYBFou3sCpFKYKVqy7WPqScFkHBLwxMjtUSfqBlYjlNWudwamtWvX875q9xYS4oqxmi
	nFM/pGuamOVjT7OBlN3z4vvKt9qbyke1Vx3AW4miEpBGyjQ6joQHjLE5IsQyIuupLYs8nc9J+hD
	aYl0deWHsjkiJf+0pADsJVpWox2aovqPKjigX/GAcev+qUKTGYh3c1biwCEnWc2oFu9slyXxuWe
	EnqEiRWgISfaMffNk4BuayQcitXZikEqtX7/Th1+TSN/FhnWVfvv5p5JOBqLP7Eq5stc3Ov1As+
	4ZcF3lQSxrTPhZiRzdeTtPz+LDxhiPM0LRqk9x4BDG5Ksq0FMgZ/HzAxpWyoEJLfGTfCEndfZAZ
	2PSQsTM7p/2R3B/2heGIPQMtKemy8Xa+kqLPZOg9BI/4eIEHppX3GOykDuUn5lzck2bM60VPLJF
	QHDABTQikRB93tYPkFjTBX6g+sjr6HNPe3WSIccWoqAfw2dAo1ozkKEbCFgrUWL/aas+RFIzZdU
	HH6m0kHxlmbsNH1IucHGwG/z+wJh3BcSHZDlulgf8zNyqVvBtVGLhkGJXSUJE31Q5B/unhrNAmD
	TFlPGWCRw3sXD2YePi3nNCbPmqMwRjOLBIhxVf+an+sFI0Se4DCsH2HW+AiD
X-Received: by 2002:a05:6000:29c9:b0:490:f98f:addc with SMTP id ffacd0b85a97d-4982ecf6719mr3325608f8f.27.1794320352301;
        Tue, 10 Nov 2026 06:19:12 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c9a6sm5139928f8f.2.2026.11.10.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:19:11 -0800 (PST)
Date: Tue, 10 Nov 2026 14:30:41 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, almagui@kernel.org,
	john.fastabend@gmail.com, qmo@kernel.org, brauner@kernel.org,
	kpsingh@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, sashal@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v2 bpf-next 13/18] bpf: Check the return values of
 fmod_ret programs on found targets
Message-ID: <avMqkcLz6kf-XXtE@mail.gmail.com>
References: <20261109170550.141443-14-a.s.protopopov@gmail.com>
 <1760ad16d930af8fe5c9bdcc74de2ecb3307c2ae57db0bdcead7505d5d9ff630@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760ad16d930af8fe5c9bdcc74de2ecb3307c2ae57db0bdcead7505d5d9ff630@mail.kernel.org>

On 26/11/09 05:42PM, bot+bpf-ci@kernel.org wrote:
> > bpf: Check the return values of fmod_ret programs on found targets
> 
> TL;DR: The fmod_ret return check may wrongly reject valid programs: when
> states returning two allowed constants merge at a shared exit, R0 becomes a
> range, not a constant, and the load fails.
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > +/* The program must return a constant: 0 or one of the values of the tag */
> > +static int check_fmodret_retval(struct bpf_verifier_env *env, int regno,
> > +				const char *exit_ctx, const char *reg_name)
> > +{
> > +	const struct bpf_prog_aux *aux = env->prog->aux;
> > +	struct bpf_reg_state *reg = reg_state(env, regno);
> > +	u32 i;
> > +
> > +	if (reg->type == SCALAR_VALUE && tnum_is_const(reg->var_off) &&
> > +	    fmodret_retval_allowed(aux, reg->var_off.value))
> > +		return 0;
> 
> Can this reject valid programs when two allowed constants are joined at a
> shared exit?
> 
> The main pass is the fixpoint in kernel/bpf/flow.c, and flow_merge() joins
> states that reach the same basic-block head.  For SCALAR_VALUE, join_reg()
> -> join_range() produces the union range.  flow_join_makes_up() only
> refuses the join when flow_gap() finds values in the union that neither
> state has, and only while flow_has_room().  The FLOW_NEED_ARG table has no
> entry for R0 at BPF_EXIT, so flow_needed_consts_differ() does not keep the
> constants apart.

Yes. This flow.c code was merged after my code was written.
(I will fix my code by allowing not only constants.)

> For a target tagged "bpf_fmodret_retval:-12,-11":
> 
>   r2 = *(u64 *)(r1 + 0)
>   r0 = -11
>   if r2 == 0 goto +1
>   r0 = -12
>   exit
> 
> The states at exit (R0=-11 and R0=-12) are disjoint but leave no gap, so
> they become R0=[-12,-11] and tnum_is_const() fails.  The load then fails
> with:
> 
>   At program exit the register R0 must be a constant, it should be 0 or
>   one of -12,-11
> 
> even though every path returns an allowed value.
> 
> The same can happen with the common pattern "r0 = 0 ... r0 = -1; exit" when
> the tag contains -1, since the 64-bit constants 0 and 0xffffffffffffffff
> touch on the circle and are joined.  Once a program uses half of the state
> limits, flow_has_room() is false and even gapped values such as -34 and -22
> are joined.
> 
> The selftest join_both_paths avoids this only by using two separate exit
> instructions, and whether exits are merged is the compiler's choice.
> 
> Every other exit check so far was a range check via retval_range_within(),
> but this one needs set membership.  Should R0 at the main-prog exit (and R1
> at bpf_throw without a callback) be added to the FLOW_NEED_ARG table for
> programs with fmodret_retvals, or should a small bounded range be accepted
> when every value in it is 0 or in the list?
> 
> The feature becomes reachable once 1c163e52401e ("resolve_btfids: Tag
> fmod_ret candidates as targets") emits the tags, and no later commit in the
> series changes this.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554

