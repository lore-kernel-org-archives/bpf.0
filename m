Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E734A76B
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802856; cv=none; b=lDygIyLugMA76gfU4DUB5V0D7K9sYzfYjpiIPX7V+88qIh2DckNRX2RY7YmITGkTV3Sz19ek/PJm3yMqf+CcPmaLnw/T8Nr7mAu4vurodW7KhjtQh3arZbOcpKEUZSm2t184wOEU2gVJZGJiiaWriNjjHzTkgt4MQ/41ElnkemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802856; c=relaxed/simple;
	bh=nwN2OwQIQTVgmUGbnLGkN3xTmvooJOLd0YzGCaMvgd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHGt46ZPpVsqFwrVFwXUhC5YDlPLZ/WEtZazWvjkycPOgcElARlyJLM/b4RzFgj3UzsxjvDgwjvnR2/TzzU2SJeFXqqiWBIS0mp9BzQDcmGCDVK4y0GiNujhdjCIMnAk4KY0CZ0ZufPDt/76gxpPGj+VYc2Wr661kibVv8n16IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvgYDPc4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvgYDPc4"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba92146cc86so261640766b.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776802853; x=1777407653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6kFwO8pjhcG1Z4GjXxpIKmempAyG+car/3JqwgjpAM=;
        b=TvgYDPc42dpQ3CBuI7Oy1C2WjagWjrBsfixHaCOxLKzmxkaIt2aJYQVdeXAGyuLtRs
         HA32z1+oFNrtRy0xI/C3v12N0IOC5+lDpdCatHtmKPa7vdT724sprgo8uksGS95faBpE
         ig9nN0S6oJx66pjf//8lgSUozv4rzdSZ1hGNUWEAukGW9EZr1m6I3XvM0Njv+OVf8Z98
         Di0yxk8SKUpXsMNT6SPgzONu7EFmzQH8RmHx7lVxUAyBC5cNWoKknzjr8BvEiSXcv+qY
         uilXpOsYhzwR83UB3auDx4PTwWNTdvxK8ogEZcp5u24jG8RAeR5vl/s2AD8SDsHPSPr8
         BwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802853; x=1777407653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6kFwO8pjhcG1Z4GjXxpIKmempAyG+car/3JqwgjpAM=;
        b=DoXxzcZVa/Y8mk3E1tF/dvRQ6eraMMRJmGqmIcZ4/h3BhUNyuc9+djNxEkeM0bspGG
         lxK7ari2u5cVp+hJOVnZB4kqL2pf3OSp140G/JfPLbcbsLl3SReXqXrFr1PIYMrcnXLt
         gEpBQuPQxsTNx/DU8nAkztCe4J4j1fX+rpdO+B206a5zvVopLgvZvdduvfvaNH0VEtsL
         Yi4KN0bJ3uEc0ovkp6qJt+mlsmaWl6o9CAzzKoT1Y6qAbj+07m2IcIfsTzZdUaX0Y+Om
         gGsQRnG/InynkGrJaH2mOWi0AjMak59Lwh4+/TneaOGhpKOsZnx8odfrjbFnpDTblxwQ
         rHvA==
X-Forwarded-Encrypted: i=1; AFNElJ92OgBCMweiUyLuA5fFvl9xPjRwTsTRyS92xinWsmU6wHvAAbRAE383LUDO2HXkTKbXTZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xRrc/JtNcpQrD35lWiuU8P5QBdARAbqX/Exc6PDT3wcZikse
	SkpjL+7axgI150e9F2JIDTMhFaR8TJSdYV35cus+Csrp1tK2/d1UuQ5IAk634sDDPg==
X-Gm-Gg: AeBDievl1VcmKcOYZ52hypRAUgbMV2wM6VRLH0UOqAG+fI0Sw/+ylM3tAGthp503BDP
	DFITey1/8itFwwza8BTPBHde7rpzEOvbPBOzObrjQxtHnBcrw/yQlLI7l0qt7iQAniV8Fkf7Dx4
	/Tvdq5HJJr3OSZTt7qaLzpQdEi1tA/GkOGH8Dvo/YBbi1zvGIaXiIBLuSdIh8DAwDGn3pXlhFIN
	zwxE7VNDEVZCQNNfelk7LqwK2UR7ucAjWhjY6HjAOfE6z3O+/TH6tpAIdw2NAOl02c61RxODxG9
	NBUrtzEkLINi89bYVajguKcadV9UkxCbMw+12fwC9z7yFP4XSN6ng9W9Yr9ZxQEq7QKEK+jCSeO
	9jM+8lj7SxZqaOCyKNHvOs3i939rycgrHqGLSHncxcTw3gdnhpu4M81135D1ntUdtOG+Tc+s67r
	FtaLSrMnZil3vzMM+anNqCA7VKVqt6E5fj7nLl/Qhjxwk6HyKf5XyIrmTonjeaPs0ghE1tYZsn6
	EXzHahiK6d6
X-Received: by 2002:a17:907:c996:b0:b9c:b069:8ac3 with SMTP id a640c23a62f3a-ba418b7e657mr677481566b.3.1776802853013;
        Tue, 21 Apr 2026 13:20:53 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455045652sm475484566b.51.2026.04.21.13.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:20:52 -0700 (PDT)
Date: Tue, 21 Apr 2026 20:20:48 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 2022090917019@std.uestc.edu.cn,
	M202472210@hust.edu.cn, bpf@vger.kernel.org, daniel@iogearbox.net,
	dddddd@hust.edu.cn, dzm91@hust.edu.cn, edumazet@google.com,
	hust-os-kernel-patches@googlegroups.com, jiayuan.chen@linux.dev
Subject: Re: Uninitialized Stack Variable / NULL Pointer Dereference in
 __sys_socket_create via BPF LSM hooks
Message-ID: <aefcINkIpzntTAlO@google.com>
References: <aedAqdeuVqLq4hDQ@google.com>
 <20260421100231.1834988-1-kuniyu@google.com>
 <ea1d6de6-55b0-4478-94e3-83733788e7c9@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea1d6de6-55b0-4478-94e3-83733788e7c9@huaweicloud.com>

On Tue, Apr 21, 2026 at 09:05:17PM +0800, Xu Kuohai wrote:
> On 4/21/2026 5:59 PM, Kuniyuki Iwashima wrote:
> 
> [...]
> 
> > I think the issue here is that __sock_create() handles
> > a positive retval as error only for two LSM hooks,
> > security_socket_create() and security_socket_post_create(),
> > which is different from __sys_socket_create()'s expectation.
> > 
> > sock_create()(_kern()) callers are supposed to check the retval
> > first before accessing the passed &sock pointer, so I don't
> > think leaving it uninitialised itself is a problem and I'd
> > rather ignore >0 value as allowed.
> > 
> > And I found a good place in verifier to reject the repro.
> > 
> > ---8<---
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9e4980128151..19cc4ed8c389 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10448,6 +10448,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >   				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
> >   				return -EINVAL;
> >   			}
> > +
> > +			if (regs[BPF_REG_1].s32_max_value > 0) {
> > +				verbose(env, "BPF_LSM_CGROUP can't return a positive value!\n");
> > +				return -EINVAL;
> > +			}
> >   		}
> >   		break;
> >   	case BPF_FUNC_dynptr_data:
> > diff --git a/net/socket.c b/net/socket.c
> > index 22a412fdec07..d40aea527f66 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -1617,7 +1617,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
> >   	}
> >   	err = security_socket_create(family, type, protocol, kern);
> > -	if (err)
> > +	if (err < 0)
> >   		return err;
> >   	/*
> > @@ -1685,7 +1685,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
> >   	 */
> >   	module_put(pf->owner);
> >   	err = security_socket_post_create(sock, family, type, protocol, kern);
> > -	if (err)
> > +	if (err < 0)
> >   		goto out_sock_release;
> >   	*res = sock;
> > ---8<---
> > 
> > 
> 
> Since the value set by bpf_set_retval() is the actual LSM hook return value,
> I think we should check it directly against the hook’s valid return range,
> rather than making a specific change for the socket_create hook.
> 
> The diff below should work:
> 
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10449,6 +10449,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>         case BPF_FUNC_set_retval:
>                 if (prog_type == BPF_PROG_TYPE_LSM &&
>                     env->prog->expected_attach_type == BPF_LSM_CGROUP) {
> +                       struct bpf_reg_state *reg;
> +                       struct bpf_retval_range range;
> +
>                         if (!env->prog->aux->attach_func_proto->type) {
>                                 /* Make sure programs that attach to void
>                                  * hooks don't try to modify return value.
> @@ -10456,6 +10459,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                                 verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
>                                 return -EINVAL;
>                         }
> +
> +                       reg = reg_state(env, BPF_REG_1);
> +                       bpf_lsm_get_retval_range(env->prog, &range);
> +                       if (!retval_range_within(range, reg)) {
> +                               verbose_invalid_scalar(env, reg, range, "At bpf_set_retval", "R1");
> +                               return -EINVAL;
> +                       }

Yeah, I think we should definitely add something like this. Can you
send it through as a separate patch please?
