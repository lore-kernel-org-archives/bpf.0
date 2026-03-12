Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8033F23B4
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335633; cv=pass; b=eV9rvEYPZhPizC+axsdDumTs+fbRjTb1CGT9sIKXrUzp9TBXSduw9kkeapaEDmOc2+VPxlIdZ3t4rmE1dlJEemhxEdUpcVLtNe4r0qlgXcelMsMF4MA8wphZnzPk7fJAO8NEDBL75Ay8L4qQCYlBGxJAjY58vxdQ0BUOIwx6qNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335633; c=relaxed/simple;
	bh=Qarh+60tr9Vhypw9EaR6FndlagE17HBNIP90zwt0hAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agMcKJT1yMNXycI1rY5Kb5b02Bq1gODqNL84fNkXugFxzrXYWsohMpsHpRGV4yghgB1GDPy/hXkbSG0VTqe8bKfjH43KicwzzCf23IaCJRadeLEuR8GU6GyFQ95oWU5t9EXe+K437kE3lRW94Cvo6Fpx8XMfkWV6uwSW0p3CcnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1pOUXo1; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1pOUXo1"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9358bc9c50so167069666b.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 10:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773335628; cv=none;
        d=google.com; s=arc-20240605;
        b=fidweMwcrEBmDuk8KCJ84G9s5ZVnU8b4QVWYOCQao88UM2/fke91ubptSsKOQ9jWHs
         RguWxMMjWwdKK3B9bZK27saDSTkiaInWJHEN+KE9mvNMo0TdHMD9wZLk4W0b2DVpHQCu
         PNKgWJwW7owBMRCLlydsH3sa2S3UnPtT59VtIspjDioadXc/zwgzdwndvQGLioLbZVaU
         XYJsUVIzsOQHU8k38KW1r1xbVZY11kTvaZ7SXqfdobAeiZzCDGpsHoqD9oV2HR1sK78h
         eyahGrajptDsiB6Mr2KrsfM3EddLbtWDo6iulTEDsMG78kxUA6MVY+YLvRoo5+kIh82v
         jZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q3Us2s0ytc91Z8HkFiJJSVXFlWx4veaTgJEHu++sdXI=;
        fh=lB/GQ2Sk0V/va76Zlp/g6Sp7aQt/033fMCzylBCMoYw=;
        b=Iw+2NHakgDERw+oS8FjdAg5V2Vb49mPsC9FpuFHGZsQsgZjAcg/0Cn+RHNfJxmqL6I
         K2uV0AV664psas7UHrBwJs1jjtK76j1ITeRSkNgMqn5DrvELYv/CzWmjufcxxdSQnt96
         UN7soOKFiBueN4hhExGZRnY4Pd04ZkXLpyeLzzFtVUsz2GX+4d5GBHLqGsH7NVxpvwTW
         CzY45u+Q793mRexW1SSBQJaxUAlbqZ2MapztBnfjrtSZqe0WWQb8bj71Ttz2yXyENvTF
         fYEQSy6X048UGiyaPNi0GrYlN+x8Ihr9hRphc9RI5Z7mRh2sLbL03Ce3/UyQp1OD9ZZ2
         3NAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773335628; x=1773940428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3Us2s0ytc91Z8HkFiJJSVXFlWx4veaTgJEHu++sdXI=;
        b=g1pOUXo1yEw3tcztV5PQwIUH9r6cnDWFyoK/aC8JfPNMQy3+UOqEl1Aus7NL5Dt5mL
         gpiUzDbuF33wDg014yhrGIOElGAkJ6iTsF++R+18WlzjCDgBFZ91G69mB1jkwzr6thZe
         7PrTTXIOZRk2HFyl3yKZdudMp6g0jyhYdoS/bzYbK3ez/KtIAcZCPQ1GitNQr4iHrRKy
         +VOAHExXDllB7c4yihXidC70frGFR0drYirJuaJDlzoPvz1ig8tTVBbhGaX4StI+Toi8
         ct/4KkGWylV6tK4R+Ot/oGZpAsA0Or+LyHlw1MJpuwySMFr9hql8o8idZ6l7QtX68bOt
         BruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335628; x=1773940428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q3Us2s0ytc91Z8HkFiJJSVXFlWx4veaTgJEHu++sdXI=;
        b=PPr/7yHKv3JDFM5bhmBAyPuPZY8zVmLAQHi1Z+cpMx7XrY3eH/Yz9CdXbYcZ305rHY
         eOVpvgijRdnzENLqghvE0yQiCNtJ1VEKYrxbOW1VN+9zdLyokI6kUr9gFfz9gIM6ZZK0
         EvMlUzCIJaMXacCWyJ+V3HzHjn2BvdR783NtCsjoVJdgkaJRvGhWjt7wtVmpWT3si/WN
         FwbWm8tSyCnP5S48Ee4AhwCt6jn61wHPnY3n3UQKh0t25m+VSf0sZQvK+5lq1IDDDOZD
         I0eV9Rkutksz+VR78+BLh9lfEuMTmsrr+4MALRR7dManXGEym3I9WGj+gsU9Ml17nnBo
         TcNg==
X-Forwarded-Encrypted: i=1; AJvYcCWrDlxijkIX5ZeD6cEn9S9fkGzQADzvzpfqLfqZ8s/nlhWsaEvip4DP2pKG+bJHbCLiLnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGd9QE8V6rx6lV1iy0HSkQzwHxbFeHuEq/TakR1VlpolM2b6G
	wk6NOD76Pgcq/zrA29+dC9Z1BOogqh/Zt9avPpjziwy/Hq6BgM7sDtZsBHUj0gI25tsA2OZ4WRY
	GyVqYl+j6sxkKMYAi/N8dfASCfZDVDfF1DtC8thZr
X-Gm-Gg: ATEYQzyRHah/goocrm5RlwpUvUgEdQ8i3QvbsM/mliLuC5G9JI+InUj5itqZntfloNN
	R9lGHFo3VfyfKlVNOxupvjgZ1aEd49BPyApIX44Ilb9xGnU8EHXH+ndlm/4EfNbn/4lfD7Knges
	6RPCioJMZDehkLy1gCN+Ft3Gc0sY257LRLTvcUcDjp4dAchktt0t7jjZMd374F3kqLP2l8H39D0
	E8ykJH0O5m+ghEC8FYEtjL1hfO3sm1HJC8VtgWj2dJX/MCqtBDMVmkArORf/bUU8w1+Jm4612Pj
	chR6F7cYwsDEIpxnrW9nILJtabxrcUor9Ou7eQ==
X-Received: by 2002:a17:906:68d:b0:b96:ff4f:11ec with SMTP id
 a640c23a62f3a-b9765376406mr10240466b.44.1773335627950; Thu, 12 Mar 2026
 10:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225210820.177674-1-wusamuel@google.com> <CAG2Kctp1q1QtB1-JT2cgBsYu-WceV1YdSM1sSwNm8pyGtZQ6TA@mail.gmail.com>
 <CAP01T776Ni9R6CT_phx5wNDUoN13Tztz3DD5ZgKWedNLx7Nb0g@mail.gmail.com>
 <CAP01T77EZDLhjwtZBSt+DXLG-ftHfows-p_6FgXZQDQGowcDtw@mail.gmail.com>
 <CAG2KctrkGjk3SMQ=8-rrYnKCTUseSmBV+kg+=OyT9M2mBT1bwg@mail.gmail.com> <CAP01T77YFR9227YpTZin-i7w-hNLWMM9ANuzmiAzLwzPGJ=gEw@mail.gmail.com>
In-Reply-To: <CAP01T77YFR9227YpTZin-i7w-hNLWMM9ANuzmiAzLwzPGJ=gEw@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 12 Mar 2026 10:13:36 -0700
X-Gm-Features: AaiRm51B_dIIfyACyk-OAOec3hanGlP08SBv_HehG83WVK_MCf0gXzElUeZ7ZiY
Message-ID: <CAG2KctqiMYUChu7stigNj1UKmWgPyWAt6T1G9imu1QqnQ3NyGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/2] Add wakeup_source iterators
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 2:06=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 11 Mar 2026 at 01:23, Samuel Wu <wusamuel@google.com> wrote:
> >
> > On Sat, Mar 7, 2026 at 12:17=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Sat, 7 Mar 2026 at 00:28, Kumar Kartikeya Dwivedi <memxor@gmail.co=
m> wrote:
> >
> > [...]
> >
> > > > I think it's still unclear why this cannot be achieved by exploring
> > > > what Andrii proposed initially in [0], i.e. by using existing
> > > > primitives and adding extra kfuncs where necessary to solve
> > > > bottlenecks, and I didn't see any indication where it was explored
> > > > sufficiently.
> > > >
> > This is my bad, I misinterpreted/misunderstood Andrii's original
> > proposal to apply only to open-coded BPF iterators, hence the follow
> > up patches with them removed. However, I don't disagree this can be
> > achieved via open-coding. Both proposals are viable to traverse wakeup
> > sources via BPF, however I see two distinct advantages of the BPF
> > iterator:
> >
> > 1. Iterators provide a stable kernel interface that decouples the BPF
> > code from the kernel's internal data structures and refactors
>
> I think this is my concern; committing to a stable interface that
> we'll have to maintain forever.
> It's a narrow use case that can be better served by dedicated kfuncs
> and rolling your own solution.
> There will be no end to the number of iterators if we keep making one
> for every linked list in the kernel.
>
> It would be different if the synchronization scheme for the
> wakeup_sources list was really complicated and hard to express inline
> in the verifier, but that is not the case.
>

I completely agree it's a viable approach, it seems to come down to
where/who carries the maintenance burden. Regardless, let me explore
how to prototype this cleanly to handle the details like the static
address, and then we will have something concrete for comparisons. I
appreciate the alternative suggestion and the feedback here.

> > 2. If wakeup sources are accessible via BPF, the next step should be
> > to deprecate the existing interfaces for wakeup sources, such as the
> > sysfs and debugfs stats. In that case, a text-based BPF iterator
> > output will provide less friction during the transition.
> >
>
> I would agree if this was a one-to-one conversion, where you just
> replace the directory for look up.
> But you'll be reading from one file vs several, so it's already a
> non-trivial change in the consumer.
> At that point, the conversion burden doesn't have the same weight in
> deciding whether to stick with textual representation.

My understanding is that most (all?) current consumers ultimately want
the aggregate list of wakeup source stats, not a single node in
isolation; the reason there are multiple nodes is to adhere to the
precedent that sysfs nodes contain a singular stat. A single
text-based output node with the aggregated stats would be a
straightforward change that simplifies userspace code consuming these
stats.

> > > > I think all we need is the wakeup source read_lock()/unlock() APIs =
as
> > > > KF_ACQUIRE/KF_RELEASE kfuncs. Just need to ensure we pair each lock
> > > > with unlock by passing the index, which can be an opaque value
> > > > returned from the kfunc (e.g. dummy empty struct pointer encoding t=
he
> > > > index). Then you can use bpf_for() to open-code the list iteration.
> > >
> > > I had a longer discussion with Paul on this. When having multiple ope=
n
> > > SRCU sections, mixing nested calls doesn't flatten the protection
> > > scopes and leads to all kinds of issues, an example of which is in
> > > [0]. That said, in this case, the verifier isn't tracking what the
> > > underlying SRCU section protects or isn't even aware of it, all it
> > > needs to ensure is that section is closed eventually, out-of-order
> > > unlocks are ok, it would just exist to allow looking at the list in a
> > > stable fashion using safe bpf_core_cast() accesses.
> > >
> > > So, I just wanted to clarify why I think this should be perfectly ok.
> > >
> > >   [0]: https://www.kernel.org/pub/linux/kernel/people/paulmck/Answers=
/RCU/SRCUhoha.html
> > >
> > > (if you are like me, please follow the link at the bottom of [0]
> > > before feeling good about understanding the example).
> >
> > Appreciate the thoughtful feedback from you and Paul. The example was
> > nuanced but well-explained by the post, however, a key difference I
> > see is that the BPF iterator solution creates continuous locking
> > segments during traversal, as opposed to hand-over-hand locking in the
> > example provided. I could be missing something fundamental here- do
> > you mind elaborating?
>
> It was just an illustration to identify what guarantees the verifier
> would need to enforce.
> The most we need to do is just ensure SRCU indices are passed back
> during unlock, in whatever order.
> Critical section will be using bpf_core_cast() anyway to do safe
> walking of the list.
> With the KF_ACQUIRE/KF_RELEASE kfuncs you will still have a continuous
> locking segment.
> Just enclose your list walking loop between lock() and unlock().
>
> >
> > >
> > > > The iterator would become unnecessary, and everything can be done f=
rom
> > > > a syscall program's BPF_PROG_RUN invocation. I didn't
> > > > check how we can get the pointer to the wakeup_sources LIST_HEAD, b=
ut
> > > > you could try several options (__ksym,
> > > > bpf_kallsyms_lookup_name+bpf_core_cast and then walk it, or return
> > > > pointer from a new kfunc and walk it using bpf_for()+bpf_core_cast(=
)).
> > > >
> >
> > Getting the static variable is key to the open-coded approach, but a
> > clean way forward isn't obvious to me. Passing around raw addresses
> > seems brittle and can raise security concerns. The wrapper kfunc to
>
> I don't understand the security concern. All of this happens inside
> the BPF program.
> If you're writing these addresses to user space and leaking them, it's yo=
ur bug.
> You can do that with iterators too. You have all the raw addresses
> available to you.
>
> > get the static address might be the best option, but it feels like it
> > violates the power subsystem's encapsulation. The iterator approach
> > abstracts all of this cleanly.
> >
> > > > Also, how much speed up does this really provide? It is hard to
> > > > understand the motivation from the current cover letter. Is the
> > > > bottleneck due to opening multiple files in sysfs? You will still h=
ave
> > > > to read text and parse text from the iterator's output in your curr=
ent
> > > > solution. Wouldn't it be faster if you just used a syscall program,
> > > > and used binary output (using a ring buffer) to stream data to user
> > > > space?
> >
> > With the BPF iterator approach on a Pixel 6 in a quiescent state, I'm
> > seeing a 10x speedup when traversing wakeup sources; the speedup would
> > likely be even greater on a loaded system.
> >
>
> I'm sure you can replicate it with the approach described above.
> It might even be faster than parsing text from the file.
>
> > As alluded to earlier, the next step is to remove the
> > /sys/class/wakeup node and debugfs nodes. My apologies for not
> > explicitly listing this in the cover letter, but ultimately this would
> > save memory by removing those nodes, eliminate work by not creating
> > the nodes, and improve performance with a faster traversal, all while
> > transparently replacing legacy interfaces.
>
> And you can do that regardless of the type of solution chosen above.
>
> >
> > Thanks!
> > Sam
> >
> > [...]
