Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271F212B2F
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590592; cv=pass; b=LryziW9DnJWu4VkWPqbF8LMWob3w32xDMEQj59WO7TW89ifEoB0TS+0g72K0P9v0Do9rEVHJA7PUggsBWzhhTLjfLs1L2iZeI6kEQq68EenxafCIcZzoLNzuQyQ2rfhXmzU8em58chBQydpolbXMgEXflfP3jgh4DlAIqIpX9VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590592; c=relaxed/simple;
	bh=xevObdWL5eNBuC/cS0xtweYtfnJpcvmbx+mP2C2tBzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nO3wpx0rk3DW0kJW+JrQiQnwnJTCW0emyYFgnI4L99j22b+LskhZrrDNHJRSFlvlJvcgdZGTQ+P9pOmwRZ8WJe+veeSK3J3eB/81y6zmzKdQlC87ynXr4F/GvAyj9eVfOwn/Tvohx9j/J1EuDq44ajxgQ1OSFcLDqeuJpojCr9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8ko9Hah; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8ko9Hah"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45eec22fab7so524297f8f.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 09:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780590586; cv=none;
        d=google.com; s=arc-20240605;
        b=BFMCMOp3nfkZduIWPD7h6f6gz6a2+wX9epPfhv5J0i+gLXaKL3V6iBw1+W1dL21V0l
         YOkakofcVMNrjvVbK3tN3WwTYDocL/QKRCYnW4iYGQx+5v/87+CKIMFyeG8rq61CGipG
         TvHyzb2xm5/vHoyBq/OXknc6+DqJEULVo2zLas3TwfkXfm+yiy/g2EbS+MZDT9d23y3o
         oI+KKOcG9mSn1i5t5cwWpUXSRJ5vOy6tV8L0tAGtBTnO8iW8Z5NUeD96UMKOZY+6pbP7
         6DNdLPfvdbEnHC6UFiLR/w5eXff+fPHoV6NMW4bPrgMIFAnryY/VOUaYOTAu9FvGIt8n
         0a0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l5qVoj8EKub2gChmLjYqwg1sPwVHH5NTjNMd9dBDwro=;
        fh=x/PqeoEAl6Xa69rF6Bh1nRAJjLwmD5AN8EDOSt2OLuw=;
        b=YviZYSQfHoCCNmEdokY0KqsQZhcLcl0xa3JVz/qqKq91oK6nt/QHBCP7seVUVYkEj3
         PrY39FSgVDQARVJZqFLsFfMSUJmL70JUNg/7IzHWOfw1UOpGgXsXP2NhWgUvI5FcMQZZ
         CAwrHLLv8QZFnMuLhC1aOK/Z+BEL9jgNlCAyvyFsyBTsj+yaeboSApuJASAnwmGYyvu6
         THzukRirR00nLrMMUFIbnCrlFegFh8kfV+ncwTlCIeFmzm+ZbHRvz7PG4VnfmQFmZRH2
         TuaVC3czGjRNNMRE5Hm1uKFWLSZZ/CjM+a1MbRxRzWogHTrxAgInbqjkOM8GQTNlHsXe
         CoCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780590586; x=1781195386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5qVoj8EKub2gChmLjYqwg1sPwVHH5NTjNMd9dBDwro=;
        b=h8ko9HahXC78dWEq7g4dcbDBRetccW4pCUKdRhbUlD6UKo71YsTtyAaK1yynRmA14D
         Rk98QBYAdZMhhY3ZNX5P7nJ09FMPpUQ3BcUa+DIGLJF1/Ptw8EcMbr9vh2PMaiMhR7Vn
         N3Nhb8clDOS1YN5xUFUcdu9XCkbdk2zvOxMtjRQsygl6udV5/al6DADCFb3x3mnHCTVu
         00CT4Th4wQfJEZSluRunj3SxCyLs6sCqtuV0yAjanOmZHMNJA9zP84ORH39ZxtVAx4ew
         0owKAZxEA3aA3J4+T6FnIaV1GaT5Xe+gmsRfbFO3IhsEDw3Fn2yisnEIqhDwWkKUO+cr
         NeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590586; x=1781195386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l5qVoj8EKub2gChmLjYqwg1sPwVHH5NTjNMd9dBDwro=;
        b=LZyzoNsUiqln5cL4l8rzuV8IhN0W3k30RBdOHROcpaZGDnzJVs72oPPW6+CFW6RLRo
         Ht1LnG5f/bSJMg3f0l4Pk80FhUveGjEjRVCgnI1BrwWt3ONhg0Y9RrexjxnW3MMF5oJC
         30GKtDtKW325sNASZvRx1AV4lKMTOH4PZzbtKZ+XQPTS6xykQUjrUAuKSJ8Nis140gLW
         WiWe2Ixd9OAFanSey3MQG+gISP7SxBf1PkbGLuNaVIMi1J5dJ4gBK307rCr15/rV4q00
         5zlP1RPN4uHcHZeQaKsxfgl+LZ5l4gQ8I1nGvz/xAqkfY2kFqgXhEPkqJsPeuJzRpEoQ
         dTGA==
X-Forwarded-Encrypted: i=1; AFNElJ9mznwVBE9R0gLqPYd2OxYhYU3m3RJ3Z2OnhP+up8yoDUDAsz/mFKexy1aGoUnYcwv1vP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqBcZvpqKsCuTIVk0k4jxtayDi3lKeAwwvfvt4X0z2wtJBjJg
	np4as9/rWej2keFAY/qz8WSxmcxQf9lEWCUjwPD7yhSm8JXwp5nykMyFr2kt/QrQeNJe6oroU8l
	UdzzSXb+RCySvJ2fx24WYKDLpT6qviJE=
X-Gm-Gg: Acq92OEmd9KRu68hSfHrLyyPH3j2o1FKY+BH+abY7uYKNtZQ4DAEQAEL7TKG+OHp9DZ
	6zFJN5VhRg4YT0dX+V95ydPLQxgwITsOtPfyohPqZPI9UqyRC2SaQ7EBRaGeooYqs07ge8IspFO
	oQx/WebYySbX/gPDkqTxt4IXt/GJ8vDaBb8U/g8YBl/NNCPe5C6/ntJGFRXPu1lBVhhImRMW4b2
	7fdHMkX66C/SzRMNv8YvgtNw2/y6zqETUjVO5kk2ygqYT+p4bjyYCr2jKuPudsSOSBXVKyjX0+Y
	72hDLjHgBTufOWGkr9xHeqOYMaqL4ddhVkHoH63+IRXMokuf9yqSH9ebp+ff0QL58noiwPbntbl
	w9Rx5I+dk+NWDSmAg7bSbLDjahD5zDBpj16TVBjKK5trH
X-Received: by 2002:adf:fe4d:0:b0:45e:64b3:af44 with SMTP id
 ffacd0b85a97d-460218701c2mr10576967f8f.36.1780590585471; Thu, 04 Jun 2026
 09:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604130458.617765-3-xukuohai@huaweicloud.com> <a91c8225b90fc2330bdca6af51f72c7cb872c1127deb54ca6d89f6f3f34b9657@mail.kernel.org>
In-Reply-To: <a91c8225b90fc2330bdca6af51f72c7cb872c1127deb54ca6d89f6f3f34b9657@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jun 2026 09:29:33 -0700
X-Gm-Features: AVVi8Ccuwu8LMW2wfw5srUHqLFmvRpgtRa6olJNH8oLnrSlY1CnJDdtf-Jo3AxQ
Message-ID: <CAADnVQ+Bgs-jSEFPx6wuQY=YBbrfsnn4w_ceedRmK1=MHsziJw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 2/3] bpf: Add validation for bpf_set_retval argument
To: bot+bpf-ci@kernel.org
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, YiFei Zhu <zhuyifei@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Quan Sun <2022090917019@std.uestc.edu.cn>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 6:52=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7fb88e1cd7c4..1bf58685b655 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9952,6 +9952,7 @@ static int do_refine_retval_range(struct bpf_veri=
fier_env *env,
> >                                 int func_id,
> >                                 struct bpf_call_arg_meta *meta)
> >  {
> > +     struct bpf_retval_range range;
> >       struct bpf_reg_state *ret_reg =3D &regs[BPF_REG_0];
> >
> >       if (ret_type !=3D RET_INTEGER)
> > @@ -9980,6 +9981,29 @@ static int do_refine_retval_range(struct bpf_ver=
ifier_env *env,
> >               ret_reg->s32_min_value =3D 0;
> >               reg_bounds_sync(ret_reg);
> >               break;
> > +     case BPF_FUNC_get_retval:
> > +             /*
> > +              * bpf_get_reval may see arbitrary value passed by bpf_pr=
og_run_array_cg for
> > +              * CGROUP_GETSOCKOPT type.
> > +              */
> > +             if (env->prog->type =3D=3D BPF_PROG_TYPE_CGROUP_SOCKOPT &=
&
> > +                 env->prog->expected_attach_type =3D=3D BPF_CGROUP_GET=
SOCKOPT)
> > +                     break;
> > +
> > +             if (env->prog->type =3D=3D BPF_PROG_TYPE_LSM &&
> > +                 env->prog->expected_attach_type =3D=3D BPF_LSM_CGROUP=
) {
> > +                     if (!env->prog->aux->attach_func_proto->type)
> > +                             break;
> > +                     bpf_lsm_get_retval_range(env->prog, &range);
> > +             } else {
> > +                     range.minval =3D -MAX_ERRNO;
> > +                     range.maxval =3D 0;
> > +             }
> > +
> > +             reg_set_srange64(ret_reg, range.minval, range.maxval);
> > +             reg_set_srange32(ret_reg, range.minval, range.maxval);
>                     ^^^^^^^^^^^^^^^
>
> Are reg_set_srange64() and reg_set_srange32() defined in this kernel? A
> search across the entire tree finds only these two call sites and no
> definition. The struct bpf_retval_range has minval/maxval fields but no
> associated reg_set_srange* helper exists in this codebase.

AI is correct, because patch subject is wrong.
It should have been [PATCH bpf-next v4].
Pls resubmit targeting correct tree.

pw-bot: cr
