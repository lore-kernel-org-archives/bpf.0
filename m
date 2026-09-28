Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B121352034
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617371; cv=pass; b=jjaRNVjBRC3RQcbm6FX5PyjjBPHRDLmVURZLpfCUsMHGs9qmbRp1Gx0wtNNucjx6taaQVhDP8WPBkssRBxwZIsz6iCWCkQlNWRtFTfR3m/IO0h+SIQgxyagViLHTzTcE/7D2ebH2UDq6GGaIoGvMEJlPYN4ruI6nt28iMRqoDHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617371; c=relaxed/simple;
	bh=Npa3NhfIpSTUOekKmre1kyW31Rzyrp8INRhp34ots1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK8LGtGBmVcueD5gNcDRaMYYxsJ0+qhMkIzPW3uk9/SEBuxanlc9HLJXa8rXv/tHRFqEmEeniHMyEWJwI5WxrsGbjkDMM2EaGE35XRjGfOXm8DR1/CfyYtCgfV8cFbJTXchOIyDlibtL/H9WDhk5MSMLnQpYYIEkvdTNHDjYRKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5+IWu/q; arc=pass smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5+IWu/q"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81be5042c56so1179812a34.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 10:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790617369; cv=none;
        d=google.com; s=arc-20260327;
        b=qdObX5ZMzyhSbLygw9lIiRO11opDcnVzhE7RlkM2N59snxvVpInygFQlCY6JuqLdW3
         puANF7fIk+OGIW4YprRfeY9UhDhRNfQCMxLIb9zRp5+FXn5qyfXuvrHueCl8fWqoo+kc
         WXb46IlmqUqj5CMOkUaMpgkfRKs7B5jA2SzHDNF/faKP393SjZiS8akE3SkdG+Rsh50m
         T/y6011kFJYGU2LebPrZRGbAWSdsj6nQ1as4Z7jj+7a5RqtJ8qwFicJ6gT4Y4miZesh8
         62VPr4cmrfZFnO3ZHA9ISwFJXB0rYolXceuHkvBG5AJ06iJYURN2NVIfztJUidub0S7B
         M4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6tCgnjqQbHVW6Tb7vs+HFe/kEIpjTrwTxu+9OT+dpA=;
        fh=2MBOojPsOSARizhxuWgT5BqcaOh4dFXJJ9MmFSYnYEA=;
        b=UhMpbA/l0TyGzhZMY5EX4YkEObKbNXZ06N7KTLFgX8c9rOwyjQUndHVBR7asYcdQYi
         TwAoOnarVdjD7GxVq7M9paxEQKhA4P6+hSCLVCCFwIvzHyxgEpWBjnj37DYW1nGArPqW
         ZgGoC1+8TtmRXRjNW+n3woBTqYGB9Q/EfBkvGh26f0lP+6M4a0C/VoFPFu0kBTU2pckc
         j6WXxASYMKhmOxvTQ2IHNKSUgLzt47X4G+BSHvFBzgRyMGP6k8cEX/C0YKJsJ7KBJ7HY
         9bA4GRbFudOunhSFgEsp/xXZW0h13/FZh2G9PmUjC42Qgr2bq5wIrjwVMw4QW1MV0ERu
         uedw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790617369; x=1791222169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T6tCgnjqQbHVW6Tb7vs+HFe/kEIpjTrwTxu+9OT+dpA=;
        b=k5+IWu/qepaKRfdKmv2ZNSbU30denRGL/UUjQM53bSSbbmFg4G7isnJlOpU+XjqZEL
         KYYp1btWMlr6d1a5kdziFxZvZAwAdiZ65RAYxbwyyTKP+MX3wliyzwsw5SASe7rMidOy
         xNpcTADRhgY0UKxFyN7INngHY95lZflKiMypfdt209SHcRanhyk+9l1apWpfqgS8qLWd
         gHw+kyJavxr0KRmLkghycFZjjjnVcqDrNUzb2Tur2Qe+fUE4v4v7oyP78gp//akqACgZ
         A6iB+6mgDHOVXsuuuCRvPdYB+VVOypRIHcUZgXCmkbi7iDngk82Ktyxw+OXf0a3+R1XD
         iwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617369; x=1791222169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T6tCgnjqQbHVW6Tb7vs+HFe/kEIpjTrwTxu+9OT+dpA=;
        b=G7DtlEWr8TFOauGgtuPAQFNt9fRgIVgVzXkMf6ORKFitO8TCKg5ISREvYLWlcHepca
         LJWsRJP1gAWbaBSsGwDCcOZR3//aj7Qv3rfDRvsKsEJolTmQQlkHZ5Vlcp9QKODnP/yA
         Zm4ObbPPZdV89LietpORCI7ZmIxp75w00SZxx6ziLVQ14WJsQzi3m6a3eWA2dpgH2lvg
         VP7xKzIfWQogEtmZOp8NClROY64n+uoRA0D1IaUIsmCR8ip0Z986cKyXymV1GcukacYY
         6mrEVaFRIgqzMhLp8eiGic3WY8wfD7vRhTWZ2Dy73Lq1VSfz960dRU8hoiAWpBwkKs7t
         3S3w==
X-Gm-Message-State: AFuF++nCcVgFzpUp5rAv/4eEa8prYmeegffpxhp/tgWRsxuuN6EZWrFV
	ejuaaRGzb0/Ksxa8ZJNwtC13MABgzX3qVpwhAVYV2ZkYtmHWT/bo9Acy8okXvcwUb2nGYFvBjHC
	G2lzNL9Kz3auaUH4/TTnEdC3o4Y1CbME=
X-Gm-Gg: AYBFou3j3Z1oesEFaZtnBzozzh5JnhL08jwXBTgeKAo7C/bK8sEZSLp7sTbXm9sXgtD
	tSbYcc5b1o5E8zAJ5c4b9p6h6R7FeaSqOYgWp5L0Kj+XLWWYjFCT9ed6UMJvnLoRJY1rvmxGPc/
	s/6YgmQIYutJD9Sv2P2PvuspHd6wBfjNTWfYZbgnA5XCrgsWxznpBA9ILulYBAuDidWBetAr3d4
	yFGBlDLxEWvS7zy5M8PYvZ3zz6WRLJiqXqkSwnwWtuOPv6NCKNMSHVI5OZIgKO8ofBDJWHgF01U
	mjQwkUR94zPuLwW8fdQAsekP9mErFpJn5pn0h67syjljSXp2c/gcN2o=
X-Received: by 2002:a05:6808:3c47:b0:4d6:92b3:5c85 with SMTP id
 5614622812f47-4dc69d1d383mr9714879b6e.66.1790617369260; Mon, 28 Sep 2026
 10:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925211256.1834061-1-ameryhung@gmail.com> <20260925211256.1834061-11-ameryhung@gmail.com>
 <DLP49ZWG2U69.HDSWP7IVT0YC@gmail.com>
In-Reply-To: <DLP49ZWG2U69.HDSWP7IVT0YC@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 28 Sep 2026 10:42:38 -0700
X-Gm-Features: AclHuK-ZoWnf3PTeKIJ8KWR4Qoj6GiZ9cYoGDZl0-dFBFbCJqP0g4gdUK5sRejw
Message-ID: <CAMB2axOMVS6TdSFb10znX9k2F3eXActY7OpXw-=ESDQT+CbQjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/12] bpf: Track packet changes in call metadata
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 1:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 25, 2026 at 02:12 PM Amery Hung <ameryhung@gmail.com> wrote:
> > @@ -10970,11 +10971,12 @@ static int push_callback_call(struct bpf_veri=
fier_env *env, struct bpf_insn *ins
> >                             set_callee_state_fn set_callee_state_cb)
> >  {
> >       struct bpf_verifier_state *state =3D env->cur_state, *callback_st=
ate;
> > +     struct bpf_call_arg_meta meta;
> >       struct bpf_func_state *caller, *callee;
> >       int err;
> >
> >       caller =3D state->frame[state->curframe];
> > -     err =3D btf_check_subprog_call(env, subprog, caller->regs);
> > +     err =3D btf_check_subprog_call(env, subprog, caller->regs, &meta)=
;
>
> Nothing reads this meta. Same in check_func_callx().
> The only place that needs pkt_changed in meta is the subprog
> pkt pointer check that the next patch adds to check_func_arg().
>
> can btf_check_func_arg_match() keep its local meta and set
> meta.pkt_changed =3D sub->changes_pkt_data there?
> Then check_func_call() keeps reading subprog_info[subprog] and
> helper and kfunc paths don't need to change.

Yes. That makes sense. Since most changes aren't needed, I will fold
this into the next patch.
