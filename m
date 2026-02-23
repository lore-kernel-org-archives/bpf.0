Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E933AD8D
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869894; cv=none; b=NJRA2yDCqPuJMgcLR+ka7BHRIPmUvBTiBxpkzkvr5srmFRCoSMSQnrMu5D3TYSrDjhmB7c4iAh0vuCkl150g8hpnZfdTU9NhkNFT3K/mPo530Sy4ACkDZIz060cdu7qwSEhYIOZ9howo8wUzu0W0UPWyrAgdYmZvWkzHQmXVqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869894; c=relaxed/simple;
	bh=tYopF09zQvHH1k1p1K6RPGew5DH5Gxq99Bvnl+rqLAo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kudZQoRayBJpQGaN19OT3jl8Jbu3WlZqM9Ggra9k3G1S6YvSRXwuo4qy0s1pukeaBo/qRK/WIC09kNpkt1EeGQYNB31auUpHXLkPjTdF3xCwn/2uD/u6WLpZrnaM7iMNAexvrNJipfa0i1vh6R4xbgUxhQnF2VYFLJseOHTuk/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=tQQqXBxX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="tQQqXBxX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb48234b08so490773885a.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771869891; x=1772474691; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3nZL1UYY8AC31wFnwMwsi+LJCkkUXvEPfADu2pCdjQ=;
        b=tQQqXBxXvcPI96k5aOJyMFrwIM/eiUEY136KIUi4zb4VMrFPsxbwCUOjTkRk8SG0zM
         DaOHz9sIgSNcUeQEzIy6sq1DVQigfG0UDH5lpIWztGGctyFhexUBK5wEUCI+MW3cyNIR
         GUWcgC/+6UHJfo3/VzOxmy0KntsrI2TX/9TR67zu/qIXW0eluO4CijLWV8sCU+pynCOW
         Hrposf9wIcGD++6DNSZW/xaPGB9lBBCcUfKASbXZVHnkjWmKs18Z7evGMBrGdPLfweN1
         PZGkZjvFg7F0TiwUFF2GU/E+k+oac2+LcQrnEDmWIR22neN9vGq/+TygjReQoKQYJfBr
         rBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869891; x=1772474691;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3nZL1UYY8AC31wFnwMwsi+LJCkkUXvEPfADu2pCdjQ=;
        b=RziuvgrWL3Itqy7e6rrBlJATNUGi4eNWnHGayHOh7bnNo3TjEu9hTCrTq7r0P5vhZa
         Ih7W9nqU1G14C9SrxwZpUVgtUR6nhnQyxuw1mKOn+9CCqA0oK65lqclbpkos0LkDs9ao
         LBmURJBPgnnK/Hd3kjpzx8l+X6JCV0OrmtRkYVRABivQJXaXhBRP8qVB756iYS0CE4eB
         W3BLZyEBk8c/dhzcANiHadSwluQCkkw2X1MFdJ0C816aTIWJiA+CKlIcChmoOs3gaJch
         cF/iKdJpx0ORqP1vGjULWOXTXcgRSQV2RY9EMMyfvi9EhlR1+cGBHh+/UVryJXz9VGo9
         ZP4w==
X-Forwarded-Encrypted: i=1; AJvYcCXHgQeOpj4zye2wenCDxHqf10Dmnot0/Jc7dL7ukaMjZdbU5vJn7Lcc/OXpQL/uUfT/9c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA43LXGEtXiFmm+tZO1G9RZceOaMNJV/sPKg1yhjVzxK3Ca9XK
	mhBdPrZ7/MMTDMHbIiygMsm0oPh7XPI4uAEXhieIrPNvYWiCVe28Udk7JjoMlbcOaBY=
X-Gm-Gg: AZuq6aLKwnJVV5X4XWEbDl14GRzoiwwALFn5Jg7qWsDu3zF91wbrkxLJkXeEGYXMfpj
	GluwSYdmhzZT8utiJDNwvq1m/j8CGIUVTbvrZMGWudjaR6uaY9Kda5t5MtHSy0Sk/h4syTljNAt
	+yFOBzsHDzHH/dkHu0KXc6XPtltOQEUDpzcw/hBmQXd2krI555NdJKS1VmxQQlCQlNHn8FGR+70
	fm7Xjofr9ygogxK4aT3rS1a26C4aOdHDpDWFih/TvFH1eIHF9fAGaWwX+nhQAW9EonuReK2/Zr/
	yyAdE3uK8vSv5K1FV13jb+kNlP8Ayy01JVOSqrsov1oTVxcukB6rsQabRSUQ8J8XrcjolM0kA6Y
	EVFLp3tyzL5cYOZtE4xgvyQ02HhFiLzsB24jFnIjMvSaxgdeECy9Wu27Zxi8Kjo/c8cV7CD1NXa
	JCwHBBPvjOefsRcCpyo7kTzCs=
X-Received: by 2002:a05:620a:450b:b0:8c6:db3a:3735 with SMTP id af79cd13be357-8cb8c9d1d2fmr1178488685a.5.1771869889852;
        Mon, 23 Feb 2026 10:04:49 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a25edsm72640461cf.22.2026.02.23.10.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 10:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 13:04:48 -0500
Message-Id: <DGMJGDG1F63F.36QXE3JC2ZHV4@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
 <DGMIM8SH2Q43.1I9LNNV1X34KB@etsalapatis.com> <877bs3cpeg.fsf@gmail.com>
In-Reply-To: <877bs3cpeg.fsf@gmail.com>

On Mon Feb 23, 2026 at 12:59 PM EST, Mykyta Yatsenko wrote:
> "Emil Tsalapatis" <emil@etsalapatis.com> writes:
>
>> On Fri Feb 20, 2026 at 2:18 PM EST, Mykyta Yatsenko wrote:
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> Add bpf_program__clone() API that loads a single BPF program from a
>>> prepared BPF object into the kernel, returning a file descriptor owned
>>> by the caller.
>>>
>>> After bpf_object__prepare(), callers can use bpf_program__clone() to
>>> load individual programs with custom bpf_prog_load_opts, instead of
>>> loading all programs at once via bpf_object__load(). Non-zero fields in
>>> opts override the defaults derived from the program and object
>>> internals; passing NULL opts populates everything automatically.
>>>
>>> Internally, bpf_program__clone() resolves BTF-based attach targets
>>> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
>>> func/line info, fd_array, license, and kern_version from the
>>> prepared object before calling bpf_prog_load().
>>>
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>>>  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>>>  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
>>>  tools/lib/bpf/libbpf.map |  1 +
>>>  3 files changed, 82 insertions(+)
>>>
>>
>> The code looks in order, one issue below.
>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 0c8bf0b5cce4..4b084bda3f47 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct bp=
f_program *prog)
>>>  	return prog->line_info_cnt;
>>>  }
>>> =20
>>> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog=
_load_opts *opts)
>>> +{
>>> +	LIBBPF_OPTS(bpf_prog_load_opts, attr);
>>> +	struct bpf_prog_load_opts *pattr =3D &attr;
>>> +	struct bpf_object *obj;
>>> +	int err, fd;
>>> +
>>> +	if (!prog)
>>> +		return libbpf_err(-EINVAL);
>>> +
>>> +	if (!OPTS_VALID(opts, bpf_prog_load_opts))
>>> +		return libbpf_err(-EINVAL);
>>> +
>>> +	obj =3D prog->obj;
>>> +	if (obj->state < OBJ_PREPARED)
>>> +		return libbpf_err(-EINVAL);
>>> +
>>> +	/* Copy caller opts, fall back to prog/object defaults */
>>> +	OPTS_SET(pattr, expected_attach_type,
>>> +		 OPTS_GET(opts, expected_attach_type, 0) ?: prog->expected_attach_ty=
pe);
>>> +	OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0) ?: pr=
og->attach_btf_id);
>>> +	OPTS_SET(pattr, attach_btf_obj_fd,
>>> +		 OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_btf_obj_fd);
>>> +	OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd, 0) ?: =
prog->attach_prog_fd);
>>> +	OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: prog->pr=
og_flags);
>>> +	OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) ?: prog=
->prog_ifindex);
>>> +	OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) ?: obj-=
>kern_version);
>>> +	OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: obj->fd_a=
rray);
>>> +	OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->token_f=
d);
>>> +	if (attr.token_fd)
>>> +		attr.prog_flags |=3D BPF_F_TOKEN_FD;
>>> +
>>> +	/* BTF func/line info */
>>> +	if (obj->btf && btf__fd(obj->btf) >=3D 0) {
>>> +		OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_fd, 0) ?: btf__=
fd(obj->btf));
>>> +		OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, NULL) ?: prog->=
func_info);
>>> +		OPTS_SET(pattr, func_info_cnt,
>>> +			 OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_info_cnt);
>>> +		OPTS_SET(pattr, func_info_rec_size,
>>> +			 OPTS_GET(opts, func_info_rec_size, 0) ?: prog->func_info_rec_size)=
;
>>> +		OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, NULL) ?: prog->=
line_info);
>>> +		OPTS_SET(pattr, line_info_cnt,
>>> +			 OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_info_cnt);
>>> +		OPTS_SET(pattr, line_info_rec_size,
>>> +			 OPTS_GET(opts, line_info_rec_size, 0) ?: prog->line_info_rec_size)=
;
>>> +	}
>>> +
>>> +	OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
>>> +	OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
>>> +	OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
>>> +
>>
>> Can we make it so that cloning  prepared but not loaded programs does
>> not load them? The name of the method itself implies the new instance is
>> identical to the old one, which is not the case - we're currently
>> loading the cloned program even if the original is not loaded. I don't=
=20
>> see why for OBJ_PREPARED progrmas this shouldn't be explicitly done by t=
he=20
>> caller with bpf_prog_load() instead.
> Mekes sense, but there are few problems:
> we won't be cloning a program, but rather it's
> attributes (struct bpf_prog_load_opts); I don't think we can do true
> cloning with returning a new struct bpf_program.
>
> So the best we can do is to change to something like
> bpf_program__clone_attrs() (or bpf_program__load_attrs()) then in
> veristat do:
>
> attrs =3D bpf_program__clone_attrs(prog)
> bpf_prog_load(bpf_program__insn(prog), attrs)
>
> Let's see what option maintainers prefer.

I like clone_attrs(), though if we rename it so let's skip the bpf_prog_loa=
d()
regardless of whether the original program is already loaded.

>>
>> If we do make it so that the cloned program's obj->state is identical to=
 the
>> original's let's also add a test that checks that.
>>
>>> +	/* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
>>> +	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
>>> +		err =3D prog->sec_def->prog_prepare_load_fn(prog, pattr, prog->sec_d=
ef->cookie);
>>> +		if (err)
>>> +			return libbpf_err(err);
>>> +	}
>>> +
>>> +	fd =3D bpf_prog_load(prog->type, prog->name, obj->license, prog->insn=
s, prog->insns_cnt,
>>> +			   pattr);
>>> +
>>> +	return libbpf_err(fd);
>>> +}
>>> +
>>>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
>>>  	.sec =3D (char *)sec_pfx,						    \
>>>  	.prog_type =3D BPF_PROG_TYPE_##ptype,				    \
>>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>>> index dfc37a615578..0be34852350f 100644
>>> --- a/tools/lib/bpf/libbpf.h
>>> +++ b/tools/lib/bpf/libbpf.h
>>> @@ -2021,6 +2021,23 @@ LIBBPF_API int libbpf_register_prog_handler(cons=
t char *sec,
>>>   */
>>>  LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
>>> =20
>>> +/**
>>> + * @brief **bpf_program__clone()** loads a single BPF program from a p=
repared
>>> + * BPF object into the kernel, returning its file descriptor.
>>> + *
>>> + * The BPF object must have been previously prepared with
>>> + * **bpf_object__prepare()**. If @opts is provided, any non-zero field
>>> + * overrides the defaults derived from the program/object internals.
>>> + * If @opts is NULL, all fields are populated automatically.
>>> + *
>>> + * The returned FD is owned by the caller and must be closed with clos=
e().
>>> + *
>>> + * @param prog BPF program from a prepared object
>>> + * @param opts Optional load options; non-zero fields override default=
s
>>> + * @return program FD (>=3D 0) on success; negative error code on fail=
ure
>>> + */
>>> +LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const stru=
ct bpf_prog_load_opts *opts);
>>> +
>>>  #ifdef __cplusplus
>>>  } /* extern "C" */
>>>  #endif
>>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>>> index d18fbcea7578..e727a54e373a 100644
>>> --- a/tools/lib/bpf/libbpf.map
>>> +++ b/tools/lib/bpf/libbpf.map
>>> @@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
>>>  		bpf_map__set_exclusive_program;
>>>  		bpf_map__exclusive_program;
>>>  		bpf_prog_assoc_struct_ops;
>>> +		bpf_program__clone;
>>>  		bpf_program__assoc_struct_ops;
>>>  		btf__permute;
>>>  } LIBBPF_1.6.0;

