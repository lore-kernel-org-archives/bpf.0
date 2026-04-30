Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C13CA52
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513140; cv=none; b=UJ3qOVAn5F+Z/zx0i5Gux3TClVE4oXeBXtQtG/mUafNSZW7Ira71VqaS4JJXPFzS3XWrFBx83TPuMt4oWSPcbO1QI0h4UcJXqfwnQhPSlXbuS76y25k5JyCDlDD9Fjx71md5DjRrJjap19bROq7uo4vIAXbZSjGzJps8KD16YeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513140; c=relaxed/simple;
	bh=/VQwAYgzj5sxcry53o7E8nV9NKuk94h5vZb507nl4CI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsAMJfUEyRcqHaNZIgZpxACH6ZDXq4sgiSu5+obqi2AMDPvTdcJhPo8sjjnKSaTDqYqyJ0AkPUqPV7BTwMthNMi9lJeB7PMQQG5FqQ0ZdxgP7EGvMIx9k9jwVp9XN9nqVhcB0NhCfeZv1tRu7BfR5vUefb8IBEqwgffOB9HAxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gids6REw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gids6REw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so218871a91.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 18:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777513139; x=1778117939; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ia+lIsbVPPGuRJFobP+QV3MmlTGazmt1tNjjpzmRiwU=;
        b=Gids6REwymetfQ4NrZUAzUnoJoHs6V4h36xrpo1oL3BU67FMd8ui4OA8Mh4T/OGUp5
         MfItBIkg/9L1tuWzpdGD+6o8WV3DMhavSXl0kIKY4hxmSRI2I8ssokUnAXGSP3oNaI+s
         xsMgvQ5G9fXwXifIt512pul+RjoQfhf/qk4jRjzwPKr12G2sWJy56IF36UHy3Q7YS6RU
         nG1PU8R8fSq8cK/iX1TvyaOTY6imLs3dzs7kCJesUJVQDf7sK3efPQRWLRLqI05A7M8W
         BgwCdm3oj0ZRJSWzAiwatVCFGnYOtLXPI+dtGoc4wm55z7TiCWeNiqAm9raXj26v7QU1
         N7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777513139; x=1778117939;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ia+lIsbVPPGuRJFobP+QV3MmlTGazmt1tNjjpzmRiwU=;
        b=dtu8h84vrpUEbJ5CBE3EO5RMbdTqSbm2crEetVTvKK2o1wqvBWsm4K+/uRE2wKWMRB
         /oawL6z/eYdgj39+BzPcfyn/pRJeQ32XWPdMe8wPGeGu9+IJA7qhfsLDdSOZfCBPWYVV
         r6ziC6Nely6Uz0JkN/uBmwheEu+5/5ey+hXSwISHDfoMn1mSreqdzGJwSyFeM8V9daWp
         5ZFpnw9M9F8rZoicFMI7b0Q0mpK89PW/GLE910e9gnn/jkbF8aelopGnE7kj/5mZypi1
         HnqE3J81QkBDPjO3eoUAF5BfCwBNk/T/8bh/hHrlPGY3u4TTlcC9d8Nss+hCeLH0gxoH
         slqg==
X-Forwarded-Encrypted: i=1; AFNElJ84/oMsUDT9//nd7ETw8/k12E4i3djnuKZFvVF7i5xAQGnYTmB/Ko1Y2TMulHhMsENdbFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSlbdCyevxP/G32lvTNlYAne7r4/Dqx817xzWPRplA0M+XueG
	2sgg7/dgr6RgHKW1zQqg+uMsR19H5Y4dER/BOl7NlzXewWyWGZzR6Jsv
X-Gm-Gg: AeBDietVKe3rXXi7s8rFnNfv599VmeZpRrTDZPZjKcv77L0epqQ50H4Z++df4/kK8ve
	XjScOAtkbycrKrdb5pH1GQQWez7Y+5IxK9scnC4eOl3WGc4qYuemfj972wigtqP2xu059lsfpDT
	RK6QETqavTejK/YLtBamzXkhqK327F9jBIJypBigLmpT5AofC4IPcjp6jmWjkKKm+Lco/8h+hNM
	CSuorXF4dkUimgMMKKAEZle2q7w5hrGZsNWIkFBCAXbFCZEd5Mv2Wdk+KmrROFZDgoMgtI/8hXP
	vcY64CV2+bl7BZIKX/8eXikc2T2bAl8cobo52TMkBucSdjUW0b6TQZ86okV0HJ9hAOyG1o0F3Ev
	6F6grRR87CVk6Mdgsi2a3OJec+Wnx77e3apMFD5gIsCySN2A+TFT+LPMVo+vYzoE6z+rNcZnO/v
	A+fzrVcytKySgXmOJqKqpanNl6z7g4qVFBavpZkMCLuc+rufSIBP47wwX6MuofOsTjxTBYVUgAE
	YrJQ4GY3S8koLPX4JPfLaiDXRnvbh1y30eQ8g==
X-Received: by 2002:a17:90b:3d89:b0:35e:d012:5a39 with SMTP id 98e67ed59e1d1-364c30cb703mr752103a91.14.1777513138626;
        Wed, 29 Apr 2026 18:38:58 -0700 (PDT)
Received: from ?IPv6:2605:8d80:5500:152f:f723:34f5:242:8ec7? ([2605:8d80:5500:152f:f723:34f5:242:8ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364be02940dsm868253a91.15.2026.04.29.18.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 18:38:58 -0700 (PDT)
Message-ID: <fc0055b08c4788204287fe05e1e270c65bb17b5a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf
 functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,  Martin KaFai Lau
 <martin.lau@kernel.org>
Date: Wed, 29 Apr 2026 18:38:54 -0700
In-Reply-To: <6b9f2ad0-e46e-4a0e-b395-c0ca45bf682c@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
	 <20260424171438.2034741-1-yonghong.song@linux.dev>
	 <7a031b0dcbf54e34d6a6571256b1bb65b5617bcc.camel@gmail.com>
	 <29308729-2a9c-4a4e-9b4f-a92bd185ee22@linux.dev>
	 <abe6e8e7a0ac5d4c1fbbf35643577d53db81e891.camel@gmail.com>
	 <6b9f2ad0-e46e-4a0e-b395-c0ca45bf682c@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-29 at 23:52 +0100, Yonghong Song wrote:

[...]

> > But this is a very partial check, the max_out_stack_arg_depth is
> > computed per-subprogram, not per-call. As far as I understand the
> > design, it can't be computed per-call at all. Meaning that if there
> > are, say, two calls:
> > - foo(1,2,3,4,5,6,7)   // where foo expects only 6 parameters
> > - bar(1,2,3,4,5,6,7,8) // where bar expects only 7 parameters
> >=20
> > In this case:
> > - Verifier won't know which of the two calls is bogus, so won't be
> >    able to point user to the instruction where error occurs.
> > - This is not a safety condition, meaning that kernel state is not
> >    broken if more arguments are pushed onto stack (and if it *is* a
> >    safety condition, then we need to figure out something two check
> >    both calls above).
>=20
> You are right in the sense, we do not reject at any callsite
> since we do not know whether it is exclusively used or shared.
> For example,
>     *(u64 *)(r11 - 24) =3D ...;
>     if (...) {
>       *(u64 *)(r11 - 16) =3D ...;
>       *(u64 *)(r11 - 8) =3D ...;
>       subprog_7args;
>     } else {
>       ...
>     }
>=20
> We cannot warn at subprog_7args() since it is not clear
> whether '*(u64 *)(r11 - 24) =3D ...' is exclusively used
> by subprog_7args or other, unless we keep track of
> stack arguments. but I think this is not needed.
> The above check is in function=C2=A0bpf_fixup_call_args()
> where all subprog's have been processed. So we know
> *maximum* stack arg count, e.g.,
>      subprog_7args()
>      subprog_9args()
> We now the maximum stack argument count is 4 and
> this maximum stack argument count will be used in jit.
>=20
> If we see '*(u64 *)(r11 - 40)', we will know it will
> not be used for any kfunc or bpf functions.
>=20
> This is a little bit tying to JIT implementation.
> In JIT, the stack args (excepting the first few based
> on arch ABI) will consume some stack slot based on
> native arch calling convention. for example, for x86_64,
>=20
>        high address
>        +-------------------------+
>        | incoming stack arg N    |  [rbp + 16 + (N-7)*8]  (from caller)
>        | ...                     |
>        | incoming stack arg 7    |  [rbp + 16]
>        +-------------------------+
>        | return address          |  [rbp + 8]
>        | saved rbp               |  [rbp]
>        +-------------------------+
>        | BPF program stack       |  (round_up(stack_depth, 8) bytes)
>        +-------------------------+
>        | callee-saved regs       |  (r12, rbx, r13, r14, r15 as needed)
>        +-------------------------+
>        | outgoing arg M          |  [rsp + (M-7)*8]
>        | ...                     |
>        | outgoing arg 7          |  [rsp]
>        +-------------------------+  rsp
>        low address
>=20
> The native off is:
> 	native_off =3D outgoing_arg_base - outgoing_rsp - bpf_off - 16
>=20
> So
>    r11 - 8:   r9 =3D <...>
>    r11 - 16:  outgoing arg 7
>               native_off =3D outgoing_arg_base - outgoing_rsp
>    r11 - 24:  outgoing arg 8:
>               native_off =3D outgoing_arg_base - outgoing_rsp + 8
>    r11 - 32:  outgoing arg 9:
>               native_off =3D outgoing_arg_base - outgoing_rsp + 16
>=20
> Then we have
>    r11 - 40: native_off =3D outgoing_arg_base - outgoing_rsp + 24
>=20
> This will have a problem as it may overwrite callee-saved regs.
> So we need to reject it.

I see, thank you for explanation.

[...]

> > > > > +	caller =3D vstate->frame[vstate->curframe - 1];
> > > > > +	arg =3D &caller->stack_arg_regs[spi];
> > > > > +	cur =3D vstate->frame[vstate->curframe];
> > > > > +
> > > > > +	if (is_spillable_regtype(arg->type))
> > > > > +		copy_register_state(&cur->regs[dst_regno], arg);
> > > > > +	else
> > > > > +		mark_reg_unknown(env, cur->regs, dst_regno);
> > > > For stack writes we report error in such situations,
> > > > should the same be done here?
> > > We should be fine here.
> > This is not a bug, sure, but it would be nice to have consistent
> > behavior for similar situations.
>=20
> Okay,=C2=A0I figured out a better solution like below:
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2f412128d76a..5fa16287353c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4159,11 +4159,7 @@ static int check_stack_arg_read(struct bpf_verifie=
r_env *env, struct bpf_func_st
>          caller =3D vstate->frame[vstate->curframe - 1];
>          arg =3D &caller->stack_arg_regs[spi];
>          cur =3D vstate->frame[vstate->curframe];
> -
> -       if (is_spillable_regtype(arg->type))
> -               copy_register_state(&cur->regs[dst_regno], arg);
> -       else
> -               mark_reg_unknown(env, cur->regs, dst_regno);
> +       copy_register_state(&cur->regs[dst_regno], arg);

Hm, makes sense.

>          return bpf_push_jmp_history(env, env->cur_state,
>                                      insn_stack_arg_access_flags(state->f=
rameno, spi), 0);
>   }
>=20
> and
>=20
> @@ -952,7 +951,8 @@ static bool func_states_equal(struct bpf_verifier_env=
 *env, struct bpf_func_stat
>          if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>                  return false;
>  =20
> -       if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
> +       if (!stack_arg_safe(env, old, cur, &env->idmap_scratch,
> +                           exact =3D=3D NOT_EXACT ? RANGE_WITHIN : exact=
))
>                  return false;
>=20
> <btw, copy_register_state() will be replaced with simple assignment aftre=
 refactoring>
>=20
> In stack_arg_safe, with NOT_EXACT seems not enough for precision tracking=
, so
> using RANGE_WITHIN can ensure proper pruning.

Could you please elaborate a bit?
