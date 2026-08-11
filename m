Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5037E5DE
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478514; cv=none; b=o9xWDEuaQN3CBLN7iPoLqreV1Xpyhpnf2K/Dz8bYh5fMhDUJyKsWJJx5S6zGY+SN785bZfxoSmH/5tpTjpPx7HHM8SvFCEyVydUTs6F5vOl8+qIFH/9gLo49zs0l2ZXMlJBVAuNS2r3cFQhhZTQSC2c30DUPaZNG3OxpMINB2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478514; c=relaxed/simple;
	bh=7nvBXY617kWxW87qn9YVdwTtlhPjTygeazcOW9F2H0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAQfWj290XO36YiUUUKkiH68/1Y8WrsET2UjlXNs/JL9iw9bAwDjJDqbOwwpXyL6AZ9algNkGudmAMEe0RaJG0qMljvQa9cDxRysEcc6NeJ3Z5zF5V49LUTwZ1RY4GQdC5JLNgYeHjMAdtNFRjTMNhGakp7SpEaGYvysTJd8J4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT8WnYk8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT8WnYk8"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so135314a12.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786478512; x=1787083312; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kGN+yUXE1g3855+FAgBcVw1f2LdIet9ZF/eeLjWAkUo=;
        b=mT8WnYk8ikPl18sr2ITNm1Re63C6VssP85r4ve96xY6HhN+5HOnAonFPM5KwAaH/Px
         SwuJQXG1SiBtfw9tIiww8I+a1yIKtgpB538iFzWgpW96bRwxYNe0oR23sXgBsijbTHgt
         FN5c1f3QVODtcqvW9oefyFlfhOjg1BTDMVQdBVo3exijNc8Xt2QthZX+EK4A4YtRYxBL
         I3aj/548XmMTgEddicPgvwI0ed3pWlZ6FUxw5DDDLWePBIL0PE66f9IEFQBhDCdb7ZWI
         umQcS5ko8oXRaMP8n5/4+FyczOVLqXsf0zLQFmARDHyyoId9q+b/4/oyH8++rQ34V/9+
         mJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478512; x=1787083312;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kGN+yUXE1g3855+FAgBcVw1f2LdIet9ZF/eeLjWAkUo=;
        b=gXNBksQxTvDgEicYSR5aWH8OOLYUKi9FGNtWcxtGEkpHyTN44gnjUDhr5ABdjY+DAw
         hZc1AaqA0UiydUqrPit3g5tTqpLM4oEfPc/kQ/AgBFY59qjennWuMru/KIYAvOLLBZ58
         nwwBAd5mteG6ta93ELi7pJ0XfCjHfLiEbPsT7YGBAhKo+fmy7z+4WCvNpds5FOFXmxIf
         s48wyhDOPjr07Q2WXWbrY8MxllbE72pnPX7QxDQFaPyZkU16yVk70VtMLJDROm9xTQHg
         UXZbXPpEwJt5KAzZbJgVc0wacxBdWFdK/VP1o4e5WekeqMzKhcL42TMMDWWTVt/4pWhn
         nlUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnQyQp/SsyKjBeReFSDLkrqToz4ZxdbQXJ5auMVy8J4y/8+WQrQyntfBGudcoVVG/jYG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNI3NylO18jUl4L53WPu/zu+fDBtvxu/KejJr+faMfdrdFa2Am
	5D/SD46cGk/BGzzp9izHAP0ZBaefcQx3l7zbw243vNvO8Pgef1yzBHrrf5YztBxI
X-Gm-Gg: AR+sD137IcWauAJlcEakFd+0xR3bKxV4vQ9GOaOSQoYrqA+z2a52+OyKaUB83PV+EpB
	o9Y9wEB1ui4H88l05v+MIGJHQZ6JhbOB6bOgEFZRcuY1dXgArWf7cPmGIm/+LCNMdoi59LrMA2C
	8h+ytP8965tnXu5FNBNTS4hKXLoJ6JhxAuxoyQdFhIy3lmfhbD4y2C200o4goWHiGX4jkjP5RPH
	hb8W+NoTwDxeM9NqOC8E/3X/Bnezimt9d4tcCfZq9I9hc/jWPJtUfEFrpkylWJXLH7gQd9U3jxM
	0/kiupo703rOQYdo7U/gPXvWYfy5fo9oTSlvRHL6R8JfuN7nMDb1UVkbyTxnuXGrGHbKuSW4h7S
	mwemG+9ZaA7KA40VB9Yud6u9Dwe4eInSWfmbtD5gmJUk/Q9UiCkTYMCv3n/O/0mGfX08EDy9tez
	XAXJy4P2QIAmSimVmSva2ZKcaY8/9PJ9n9bEtCXTBWbAnIsl7jnydb7i1YJnXlw5NmqRkLsOH6K
	HoTKD+oZ/WOBdVH/ALG/+spqBJp+nPZGHvbXRG6Oxvthg==
X-Received: by 2002:a05:6a20:430c:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3cc2ba56a3dmr6261220637.18.1786478512462;
        Tue, 11 Aug 2026 13:01:52 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31d39e5ebe8sm418744eec.21.2026.08.11.13.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:01:52 -0700 (PDT)
Message-ID: <9e61dc3e5a979d6defeb6cddd4cfdcc2ffcbdf45.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 2/6] bpf: Attribute async callback
 instructions to verification roots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 11 Aug 2026 13:01:50 -0700
In-Reply-To: <20260808062601.1070988-3-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
	 <20260808062601.1070988-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 08:25 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 855f245e7468..9b76851dcf54 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18762,6 +18762,7 @@ static int do_check_subprogs(struct bpf_verifier_=
env *env)
>  	struct bpf_prog_aux *aux =3D env->prog->aux;
>  	struct bpf_func_info_aux *sub_aux;
>  	int i, ret, new_cnt;
> +	u32 insn_processed;
> =20
>  	if (!aux->func_info)
>  		return 0;
> @@ -18780,9 +18781,11 @@ static int do_check_subprogs(struct bpf_verifier=
_env *env)
>  		if (!sub_aux->called || sub_aux->verified)
>  			continue;
> =20
> +		insn_processed =3D env->insn_processed;
>  		env->insn_idx =3D env->subprog_info[i].start;
>  		WARN_ON_ONCE(env->insn_idx =3D=3D 0);
>  		ret =3D do_check_common(env, i);
> +		env->subprog_info[i].insns_total =3D env->insn_processed - insn_proces=
sed;
>  		if (ret) {
>  			return ret;
>  		} else if (env->log.level & BPF_LOG_LEVEL) {
> @@ -18809,10 +18812,12 @@ static int do_check_subprogs(struct bpf_verifie=
r_env *env)
> =20
>  static int do_check_main(struct bpf_verifier_env *env)
>  {
> +	u32 insn_processed =3D env->insn_processed;
>  	int ret;
> =20
>  	env->insn_idx =3D 0;
>  	ret =3D do_check_common(env, 0);
> +	env->subprog_info[0].insns_total =3D env->insn_processed - insn_process=
ed;

Let's move this accounting inside do_check_common().
Also, having a comment like:

/*
 * The override is needed to account for async subprograms,
 * which are verified with their own set of stack frames and
 * thus are not accounted as callees by account_current_path().
 * Accumulate their total counts as total counts of the main
 * or global subprog hosting the async call.
 */

would be helpful.

>  	if (!ret)
>  		env->prog->aux->stack_depth =3D env->subprog_info[0].stack_depth;
>  	return ret;
