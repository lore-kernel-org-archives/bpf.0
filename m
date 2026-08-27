Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A043624B7
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837412; cv=none; b=dpBwhHftMCNUX137Kput90FjQzXmezE6HIlqvfLZ/+dINBrLplPrmTa5mBJFpiKj/HMMmZnZccbfqzA0wNIzpLgCQTFymO7uGiP4pituYzcCrRMc+gZ2cjPVRqu8JOx+z1rTwS0nZjkulGLZpWspyBxnCD2rXriPYRmB99wCoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837412; c=relaxed/simple;
	bh=KtfRFkT+oAksoiG4I1U+6QdBXNwsPCdzM2S02ggA6Nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o4MEePDxxZmy19iHuzqIA2e9cpMpU3opki5ApkhNaNleA+UX0FD8kGLi1RLLbH9Rml2AjI1n5yoAZ/MOQvJrL79BTO0/UGlo8HBwJL5jutI5uiJ+S2VWuA+ULMxHR/cLcfbQOdyho7VCV4AqhBMiocFZJL0OtR0TEaTAgIlU+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmFnCDkv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBWSw5So; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmFnCDkv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBWSw5So"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787837349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tyawd/wlpyXA+cjjPTN3rEnerzspCQ+EjODeWqtloEg=;
	b=FmFnCDkvBafe9VnB9OzfEUsnEuQzS8CwNOeYJH3bEWC1BhsNav7LxHeG1meUBUIdq59VA5
	yklQ4Wdtr3pMOCsjts9mT/59Wkb/mrfhqIb9JR11KEfVdWyJmGBZ0YQxCQ3BP4NfDHMBLz
	U6sjSPYLMi1Q9NFayWTl2+42bhiUFnI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-R8mahVPkP2Gx59_OpKPjWw-1; Thu, 27 Aug 2026 09:27:45 -0400
X-MC-Unique: R8mahVPkP2Gx59_OpKPjWw-1
X-Mimecast-MFC-AGG-ID: R8mahVPkP2Gx59_OpKPjWw_1787837264
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-499a7993a9bso16169205e9.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787837264; x=1788442064; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyawd/wlpyXA+cjjPTN3rEnerzspCQ+EjODeWqtloEg=;
        b=LBWSw5Soh+wJmDL0pgNNx9x2wCgirAUiddqVjZgFPiYtqyQNgf6I/UMleOT3hnr6Pt
         DLPwej7SuScPN3cgPtkB6tLwT2bXPEivRxpA9XOqHIDls8gZJbaqN8AqSia7cl4BMGrf
         JVNwLQDPaaGH/bgqfe3b6NalH3Y9TE4K69UN3XUlLQIL4dzfd6y4R959IigJS36laY+L
         itXlPhb5qrzsSJnl9GCgzoBDd3xzyTcqG0pO0t9VtHDCq3rxD9Bl8EJ0i8RxNz2f9mbd
         tuNm4CdM/n3Ffy1JnST0O60YsS91TtxmKZaLkZT18YiIuBWLn47ZV0NN8ibdE3AOFcsW
         2kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787837264; x=1788442064;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tyawd/wlpyXA+cjjPTN3rEnerzspCQ+EjODeWqtloEg=;
        b=W12E+brcdO0lrU7CuppUbkIMG17kPAlAu2wDJD1g4efwEG1r2Agti6rTa/bIMWTeje
         jT5qAJedOtufqY2Zdu0/Cs5RycfLlrfyIs2HpaXsJ2KbEJtBOKWmMMRuhmiCO7Jx8UR8
         RvvwgFfIqpRUvoPu1GqaREY44I3kW9c1lBTCpN2xHo4+VPKOc5fQynFdV6i/fmNWd8H6
         gMU3zT/xGPyXQWKwdvuQD5w0pljb5it/s6shuOuM+ey8wQ8ustIKj39lu+99u45kl7U3
         LNwQ72eXRmENHpwi8opddr1QYNsp34/TQ7InV88E5sJXhsM3f+wjIfvDI7HKlMwu6r0d
         GWtA==
X-Gm-Message-State: AFuF++m0NHkk2GjxzZ0G6KPWdL9W+oO88q0VjbGjpSedsRauA1fC6zOK
	tHBxyQJtqe6W+5gLRmJhalgTVahOZLCx5JqZ0c8l0uZ3bnSU1B1/jAhe0FWWXmef5e4E9blKdeN
	Yz+d9xuV55nptowRkBZhgySNEDtJ5xi4BmLGRejfpAFy/T1GUxeRuhQ==
X-Gm-Gg: AR+sD12UTD+c9LUep9Fekvlm5mUZ5qm+8hOON+awOnckwqftFPf+lfisDfulM8cfQ4T
	hs6mE8Ywqd/Uj+r5bsAMihRCg06fi/DCAciHi6ikql+nzviHkkCfDA+SgcgwBoeasbh2RJnCwvt
	eiXL4wrbdBCJDDgZBjZEI8X68IQKP1mCgffnwK/0aPDDZdyElsUdsB/C7oAIVwmVDdwkBLKTsYN
	g/5RC5ZGgQgWZ8bU1dWJk8FoSYvHYFHRY2RqWchn78TOpWITjVxZ2rtTnGTNYhbeFulP1X/PsL4
	rEzZgKrJktkFa6vox+okzpuJvU8AIcusi8EF416pXqJdD5cYcGc/dd3TTYsL6amHY7HgVVkQ2oh
	lFT4KZW09vVpUkgHjDquT83V4pBc=
X-Received: by 2002:a05:600c:c3cf:10b0:499:d880:ae40 with SMTP id 5b1f17b1804b1-499dc724098mr137786955e9.10.1787837264394;
        Thu, 27 Aug 2026 06:27:44 -0700 (PDT)
X-Received: by 2002:a05:600c:c3cf:10b0:499:d880:ae40 with SMTP id 5b1f17b1804b1-499dc724098mr137785405e9.10.1787837263657;
        Thu, 27 Aug 2026 06:27:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4af00fd2sm48599195e9.12.2026.08.27.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:27:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C54AE979E5C; Thu, 27 Aug 2026 15:27:41 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 1/2] libbpf: Move XDP frags flag to prog_flags
In-Reply-To: <f8413c983b5bbf569125bfa9d12a81f2293adc9905f89d746cc51276c21459ea@mail.kernel.org>
References: <20260827100214.169215-1-toke@redhat.com>
 <f8413c983b5bbf569125bfa9d12a81f2293adc9905f89d746cc51276c21459ea@mail.kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 27 Aug 2026 15:27:41 +0200
Message-ID: <87cxv34rsi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

bot+bpf-ci@kernel.org writes:

>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index b749c01742ee0..7d6f0fe518d99 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>
> [ ... ]
>
>> @@ -7879,6 +7877,12 @@ static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
>>  	return 0;
>>  }
>>
>> +static int setup_xdp_frags(struct bpf_program *prog, long cookie)
>> +{
>> +	prog->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>> +	return 0;
>> +}
>
> Does storing BPF_F_XDP_HAS_FRAGS in prog->prog_flags here break callers
> that use bpf_program__set_flags()?
>
> bpf_program__set_flags() overwrites rather than OR-ing:
>
>     int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
>     {
>             ...
>             prog->prog_flags = flags;
>     }
>
> Previously the flag was OR'd into the load-time opts by
> libbpf_prepare_prog_load(), so it survived any user manipulation of
> prog_flags between open and load. The new code latches it into
> prog->prog_flags at open time, so it's lost whenever a caller assigns
> prog_flags instead of OR-ing.

Making it possible to manipulate the flag after loading is the whole
point of the patch, so this is expected. As for users like:

> bpf_object_load_prog() passes prog->prog_flags straight to the kernel:
>
>     load_attr.prog_flags = prog->prog_flags;
>
> Two in-tree callers do exactly that on SEC("xdp.frags") programs.
>
> bpftool (tools/bpf/bpftool/prog.c), i.e. 'bpftool prog load FILE PIN
> xdpmeta_dev DEV':
>
>     if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
>             bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
>             bpf_program__set_ifindex(pos, xdpmeta_ifindex);

...doing a set_flags without preserving the existing flags will lead to
clobbering, that's what's implied by the API? So any users doing that
are buggy, I'd argue.

> Keeping the load-time 'opts->prog_flags
> |= BPF_F_XDP_HAS_FRAGS' in addition to the new prog_flags initialisation,
> or having bpf_program__set_flags() preserve section-implied bits, would give
> visibility without breaking existing callers.

Both of these options will still make it impossible to turn off the
frags bit after loading the object. I guess we could do the "preserve
section-implied bits" part and add an explicit
bpf_program__clear_flags() to remove everything. What do others think?

>>  /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
>>  static int libbpf_prepare_prog_load(struct bpf_program *prog,
>>  				    struct bpf_prog_load_opts *opts, long cookie)
>>  @@ -7892,9 +7896,6 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>>  	if (def & SEC_SLEEPABLE)
>>  		opts->prog_flags |= BPF_F_SLEEPABLE;
>>
>> -	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
>> -		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>> -
>
> Should setup_xdp_frags() keep a program type guard?

No, the setup callback callback is called too early for this to make
sense. However:

> The trigger requires a deliberate retype, but the guard removal is a
> behaviour change that the changelog does not mention. If the flag is meant
> to be XDP-only, should setup_xdp_frags() keep the type test or should
> bpf_program__set_type() drop the bit when moving away from
> BPF_PROG_TYPE_XDP?

Clearing the type-specific flags on type change could make sense. I can
add that in v2 if others agree?

-Toke

