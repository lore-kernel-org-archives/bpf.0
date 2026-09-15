Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58324AA019
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474075; cv=pass; b=ZSz5GzZmiucf8mRPis0wq/RkGtV5i7Kzm2MRWligJfnzLNyBa5/aoXUYhHEN7JovBZKjLd4JqVkye7w5UUybl7Stdo2KUb8b74nQE1OfW0ZGzcxvELMhL8B2CDkfSs0xXPwsHVXIFfrG3v0H3oqDPfko7TZdoEjMrX3+Xyx56Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474075; c=relaxed/simple;
	bh=H8Hb3OAflh27h91tJ3OskQsRwA3/+y5+gbZ+gkFYhSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nF2WuDEBnTWan/AcxsHtSe7CxiwrdfYKOGPAIbQlD4VYnkphZG0Kj3ut7xulIvei09cN017iDePRDbEyNlIOXsKl/HGVgi3uV6BjVN/K5hGLzSCbvBLocIoKkb2VEAAWyHJgXlbFC5bxnftKvgnL7mAD4Tu0iR0/N/VJ4I4RwQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhE2QWGN; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhE2QWGN"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a8038a9f10so311846a12.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 05:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789474072; cv=none;
        d=google.com; s=arc-20260327;
        b=k3ba2fxbas2bz/AyWkbd+IXZpnuIiYBiRSKm39Ni3ekSSUav/a3QlcN95H3VLGgkrp
         i8BYlirYJrAupQYjZxpQZ/uF3/HL7EHzpQTSBUtFJgsbqUZv92nt4+9qmik0k/BbBiWF
         w5zKIXFAbFFsJw06RWTQ9BcAJ9ueu+Eav4/422Ek08okKAymr6hh+ugDC+4TLP7Te5KY
         9pXM/cmI+az5cin0q5HxtShWTPeKoNGQtM8EBeCmYKHvi+zYEUXo+5I/Sp/cI72hV8Io
         TVDD4Cqtwwa6tZCQCZf2ybM4kZYefx5+C0HwyZ9nfcke0Te8YZXZYFZCzUDjoVA4O9C0
         8Gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q8mjJWntdNcyjD/YCKYvvjUmGFsw69zWofEcdKwU08g=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=nYaW/j7NfpuEC9P32zhmxRCW3BPJQkCKtF3DtRo8nrxlTL+lj60l2zCZQ+2iZQogZh
         ug0PexrBl9oG2V/p+DduBtKXZoqd8NGOkwWd0GCCqn/0IWmLfA9sbnvMMKzi7xdByMVi
         N6ViagB/5GRwjL+dwVagG1yXA3Q85lJ7LexeD4aMEnJwsw55/qQSK2Phw/quORu+CN6x
         Vbvv8syYauQ1iL69WCAb6Owhie+EoVm6T08iA490cIyHcaDLptoqVjI/2zLlOnzulmtA
         3TJ19WyPRzE2goXiXOUc55PcmWAyp+CmB3jnjkh3sq9uvqxey9INSTTKbQ1DzIsjOSrw
         p0Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789474072; x=1790078872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q8mjJWntdNcyjD/YCKYvvjUmGFsw69zWofEcdKwU08g=;
        b=KhE2QWGN1P95gRyY5q3ASPHcHxwDlY3thSvhp8+NpZi9gqnJzHvFvWb+CB6lLKOup8
         nXJ2vfiW7RnTuJCyy2o8OOdOFlOV3g8ixDFHRJQWk9iGMw3zFisqj4iBwzSyDkGmo7xx
         Eezr9wookSyN6rJkvjAZiJU2aLxRl6aMM5tvL6jdUx56tbsTOSPK/dzt047WouAgDIhy
         XHNyaxArR9uI2ZvxGAq38Mrwap91UdYxESkgA9m96Fdy4ZEHPUyo7AO4qzbeX5Jaa4N8
         DGmfJ+FACsSqWFxqtZAIoH82bE9AK+gohmbjh/IHjCqzRGtBYYj95CeeR/Q/WOpWE92r
         cGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789474072; x=1790078872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8mjJWntdNcyjD/YCKYvvjUmGFsw69zWofEcdKwU08g=;
        b=DzkmbiY/dIsnXB5QmLx+PTI+qft03yx2m+Pd7IsS1LM3VqZQfoWqQqfEhMZ7fmLQmN
         NL9jfhcM7VeJh1pY83uEflkDOx9Ru5qSoNni4nwPQ14hqT6AMMXHoNF7w0XynDn+ICBo
         ETrFwwlrl8pz8UkaxsI+AIfglNhx9tIeK2y810LBIWwQae812l2P9bd5LocIohheOsn4
         zVkblI2+PbLJDF6hhOCO0LLAmIsAX3IbEYruvQgdq0JPcNOtuLZxoGko/7IeGFIZ/vzN
         06JcQUp9JrsU5DiMZsu3caUoLxPLjC02+wlSqTDMhIROLXCRrUgSl3PeJBbyopE1Z+TJ
         RTBw==
X-Gm-Message-State: AFuF++m58FbWxEz6ENkwaEv7frraUdjARGx77QWsDEoOKanuhj73fztd
	rWzlqUT4/AQN6im0k3bqgTWpQHB08Mr06qiA2naoMlMGLfTRMehIAxeLmzyK5/jjKcyiLsyNC2G
	5IOUmfz2sz1me1fZoPTvnOGi2nSLJEW8=
X-Gm-Gg: AYBFou3jEpGkklfX7Gdy1HRLaamd5Gnu8e6pZMa7NVx9K2MoV+40Sfm9DdXg1/U7ue8
	VmGb/JmP2yUtoxCz/LwkuqOcXGUp9kAt1vExaMRUvl7JYcFiv8SwTu8dywh7NbgalKU1Z5Wg51l
	SDaO0O19hcbVpTRlucrej7m0KzPooNhK7p/5slcsbYLQrvh+ez3tKcvQaEc9/Ry8e8x/oNApmr0
	vTMxLGzTYZFBubQ3t/OA/cQoMFQQJwBNzi7AXnYvdW+5SeeRni1sZAKr1pTOrRipJPkin0basdw
	b4wk3MpWzMD3tf+tUX95tbvLnXtrdOu328ynxNJfdhgA1Ao9PbQrq7obpRrsXm3EneSnxuw=
X-Received: by 2002:a05:6402:21d4:b0:6a9:cc6d:ea50 with SMTP id
 4fb4d7f45d1cf-6aa12e744bcmr489332a12.18.1789474071747; Tue, 15 Sep 2026
 05:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915114240.3269184-1-puranjay@kernel.org> <20260915114240.3269184-2-puranjay@kernel.org>
 <20260915120127.099B91F000FF@smtp.kernel.org>
In-Reply-To: <20260915120127.099B91F000FF@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 15 Sep 2026 13:07:37 +0100
X-Gm-Features: AcwNN1X-rmDGAtzHDI7Fxgwsj7esKQkKqyteUeVUnqLGOIOyAszdQ6hF_r0Mz5g
Message-ID: <CANk7y0gn5pQs02et+zgcDHPheH4-yqW0YRjd=yvdY-2hGuAJvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Add bpf_call_rcu() kfunc
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:01=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] bpf: build failure due to missing bpf_call_rcu_tasks_trace implem=
entation
> --
>
> commit 06a7a5ada7a6b07d90668fb28558d25075dfcf41
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> bpf: Add bpf_call_rcu() kfunc
>
> This commit introduces the bpf_call_rcu() kfunc to allow BPF programs to
> queue callbacks that execute after an RCU grace period. It adds the
> necessary BTF fields, map validations, and verifier support to safely
> invoke these callbacks.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6c6b8d8520cdf..f91c997bc8445 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12526,6 +12583,8 @@ enum special_kfunc_type {
> >       KF___bpf_trap,
> >       KF_bpf_task_work_schedule_signal,
> >       KF_bpf_task_work_schedule_resume,
> > +     KF_bpf_call_rcu,
> > +     KF_bpf_call_rcu_tasks_trace,
>
> [Severity: Low]
> Will this cause a build failure? Looking at the addition of
> KF_bpf_call_rcu_tasks_trace to enum special_kfunc_type in
> kernel/bpf/verifier.c, the kfunc is added to the special list here, but t=
he
> actual implementation of bpf_call_rcu_tasks_trace does not seem to be
> included in this patch.
>
> I understand the implementation is added later in the series in commit
> d37bdb9e0af5ddd44775e974f01a56e73c98e9d3 (bpf: Add
> bpf_call_rcu_tasks_trace() kfunc), but shouldn't each patch be
> self-contained and compilable to preserve git bisect functionality?
>
> >       KF_bpf_arena_alloc_pages,
> >       KF_bpf_arena_free_pages,
> >       KF_bpf_arena_reserve_pages,
>
> [ ... ]
>
> > @@ -12619,6 +12678,8 @@ BTF_ID(func, bpf_dynptr_file_discard)
> >  BTF_ID(func, __bpf_trap)
> >  BTF_ID(func, bpf_task_work_schedule_signal)
> >  BTF_ID(func, bpf_task_work_schedule_resume)
> > +BTF_ID(func, bpf_call_rcu)
> > +BTF_ID(func, bpf_call_rcu_tasks_trace)
>
> [Severity: Low]
> Does exposing this function to resolve_btfids without its implementation
> present in this commit break the build? Since the symbol is missing in
> vmlinux at this point in the series, resolve_btfids might fail to find it
> and cause a regression during compilation.
>
> >  BTF_ID(func, bpf_arena_alloc_pages)
> >  BTF_ID(func, bpf_arena_free_pages)
> >  BTF_ID(func, bpf_arena_reserve_pages)
>
> [ ... ]
>
> > @@ -12690,6 +12751,12 @@ static bool is_bpf_rbtree_add_kfunc(u32 func_i=
d)
> >              func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl];
> >  }
> >
> > +static bool is_call_rcu_kfunc(u32 func_id)
> > +{
> > +     return func_id =3D=3D special_kfunc_list[KF_bpf_call_rcu] ||
> > +            func_id =3D=3D special_kfunc_list[KF_bpf_call_rcu_tasks_tr=
ace];
> > +}
> > +
>
> [Severity: Low]
> Can this check for special_kfunc_list[KF_bpf_call_rcu_tasks_trace] be
> deferred to the commit that actually introduces the function, so the
> verifier checks remain strictly aligned with the available features?
>

Ignore this version, my rebase was broken.

Will send v3 with all these fixed.
