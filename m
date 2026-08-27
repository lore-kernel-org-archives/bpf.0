Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BE37EFF3
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849723; cv=pass; b=lq9OcPiVEvB3OHAw/DnkLX5ae38AyqmU4/m9V7P5N3EYbVxIZvuz5PKzLbhM7mDJecpuOxU0JGhA8DzQMDuuYiI26Hbo/6S0T1f4BGgMHefZq8o7JJWA5X/pVEgeg3uWXv2SXf2LqqV1aOKjKFEulR8L1wotjvBKcZnJSKAbF5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849723; c=relaxed/simple;
	bh=FcmsiJdsM6FOny/oatYZLhV8FSoSl85nDji8uo8ja98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjwQc49rjepE8xo1+HQ9zivW0WDvndaNVZqZfbtHf9PqW90zGJKmBIETdPdoE1KsAhQ1e89GpvXIWIwgzPzRM9K9Hww1VrsJJU5DuyDbdr/y5xmUxUnhrvvgXRKDNeig5HZJCKaEmtPCo/JcViNAEuHsmz8TB0Ve8Jq/MktXHXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2KvPhVJ; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2KvPhVJ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so94718a12.2
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 09:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787849722; cv=none;
        d=google.com; s=arc-20260327;
        b=kotuZb4OoEc7MhCNsxBUl0DIt8Nh8rBODe6U9dKnilbKQk+uKMXWvDwUTOchFL4ITr
         LVgAOcAML7sgjZh3WJgaJpoASS9mqcQ2Rgu49h6OhT31MmtZ9w2zdId8KbSA5/1KmJuz
         5adeLxixABgY4NfI3CjkzwbBZ8Ipbuc8AAzqDPt2FBPLQ2inRl3n0SaLFtMmQfpLYlvs
         ErGndK9Yxq1sauDH6ex38qkU5G9lpFtSR8VUx0i23b9Nlk7WclpncMghh9wJ5OY5cV0H
         fKvczEfAjuFcdy/QB/gMdQQ7t/VfhKwVmwvl24/5+gBwFjAmRNeiN2Ds4MK82q6QWJTY
         wxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=peld70uZS+AZOWUPOW+UYjUUA6bUakzXmPZM+FZTzT8=;
        fh=HkQqy2v3WZhSvoTttY4niJqeYey1Msx2RBIpqpGWTEA=;
        b=i9EVMqPKa3xDGJFVOwD22m14H0YhXDrDQuWuBIdRqaVizfGIxXnAaDNK3VOHnp3gDi
         BbrxUSoOwTMZuMjuUdgsqFahzbsFk1xlm4mFbiNpf1ewa0luu4hI31lTvWlGtJQp5HTH
         1yvkmhXUkpVXDq+AmpLNtZkX+Si7RXBsHwEd75vSsAl7MFweLjHKLsuf/ocb7Ks8Okmv
         GQLcXXBdUz2GHOsCSN1PGLT+m3yja83Rb6infWMZGtCZYUDMJIrds9pjBFFuIrFgfpT9
         hUN6hgGPcxR33pPN6ndxtBe2Rm6WidzpdJp2JWDdZjuI9dYllG3/sk3QfPuEw1oD0g9z
         xWgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787849722; x=1788454522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=peld70uZS+AZOWUPOW+UYjUUA6bUakzXmPZM+FZTzT8=;
        b=H2KvPhVJbalXcP7QUpt4sLmvq47xdd/H90+arpUdZ3WT9XYXSv9Yk949oHK0VpId+k
         SXApsAdwlVly9CG2kO2CcPKXU5qKMvwGkOW4ZOzi7gN69SKW2oZnE0ATg9Kqe6Gepf5i
         Hb3GS/GEbIhQXi4ZkGA+2cuan+0oRE68wfESYWCKJEle2Ig9XCJNQxngRva5rlFT+niY
         v68yaIHZtMYeZJlNboBK10AY4Z0hD1XgcBekzHouDbv7tIVFazqiiVpS2kx2K5m2AzVM
         W2/aOVICsh6BfGoQ6rP/KwmuRvYIUrmq0p5R9zuxUmokOTSOGAjOqxN3SA17jR9HO0P0
         zQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849722; x=1788454522;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=peld70uZS+AZOWUPOW+UYjUUA6bUakzXmPZM+FZTzT8=;
        b=H2nXsuc7JL2w90bfK/BQ91dS1YDAB4isB4X1odx4o4wIUl79zSZMRUvSyb7rTNAshX
         XnJYi8Hnk3ZlYQXrcHE2yNjdhE+HyxGc6+19cGHqjE0plY6/nviHGStzB3CLjWqDHWbx
         qhHgWXIGFlS3BlYO/hJoupm/zYdrJsUqHSsAaKC5+IyaDGS/++X9iJgHEoQOZTAvwXqI
         s6QLpa1rYfhNU2oqTF13G/bMPxFQovG1n1I9xX324VC74R8uR6UQikywAagWP2pUF4UP
         fU5E0JXEyiBO0h+nslL33RZA4TsOYF0qYwfrT/bOQ1lehbIPbmvrXD7p+9shZyc521VA
         mTNA==
X-Forwarded-Encrypted: i=1; AHgh+Rpv2k1LrZYz+P9eZoiFzc1vRq+MqnLK8uum9aCD3KNVFkhPHAS6fOrm7AlxvtoR0q9Mnks=@vger.kernel.org
X-Gm-Message-State: AFuF++nzElnveajcw/HI9grLFBtQZEh/WCa9XDJwG+RJIg45oSjH+jkK
	JMjC0q+zR1usODACej1a3XMHtw6eJL3dRBf9xq2ZnuCgjET81eQDnr48JVAbWYkFvy4Lzgg2aJF
	eVtvPgk8aVLgE8I6cGCorNKLzwBF+SIo=
X-Gm-Gg: AR+sD110SNvebyoBkhsacR+1sWuuAWWz2LEoyqKmBJiH1Z5frVn2jIYawbBMmwbjHnB
	2jnw/3LPvZHq278m0byFb1vofaehiZ+PnqHKseg97KgpyTQPmovD50P+PeDyZgUt2bQEqp8JWTE
	HGRvxh7dP0Zky2ftPr9st+JUM5LgUS7i+yc+8XAkOsKX3/HJdkRVDOUX3B+B+HzQd+7/lqdJd0a
	HC5Td+U1hgKpAf+j1C4rMKWAUIG2qa6DXDLOqbO1UV5yj69dCXOYq4V4Oj1qTu1mp2b4ALe+8z4
	eaHNCfrY+IYxxxVqPKTy/Y1lZ6A4tlgVIZcfxteuNTs/pdAUnEDKqrIGv5tVz0L/dDDtjyz5JG3
	ue20TMx3K4R5HkW0F6lkhk5ll/KP1mlTXsx+LpR8J28jzMjf7gwE7PO6DLMus
X-Received: by 2002:a05:6a20:918c:b0:3d0:ba81:79b1 with SMTP id
 adf61e73a8af0-3d26277130fmr872772637.0.1787849721482; Thu, 27 Aug 2026
 09:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822225444.2774461-1-simon@swine.de> <20260822225444.2774461-2-simon@swine.de>
 <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com> <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
 <CAADnVQKD1eOG7cnDHvFwfJOEGZ0g8wZKEzMri27en7uoA-MT5A@mail.gmail.com> <CAEf4BzaB+EDyf2exV8XGq_x4TvhTii7gJnWU0nq3380guaWF7Q@mail.gmail.com>
In-Reply-To: <CAEf4BzaB+EDyf2exV8XGq_x4TvhTii7gJnWU0nq3380guaWF7Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Aug 2026 09:55:08 -0700
X-Gm-Features: AcwNN1W26dr4H2uiTLZyvu1qJBQWg4eRlgH2I0-78g4NmBqI5ET8X12cg68Ln8o
Message-ID: <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, stable <stable@vger.kernel.org>, 
	Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 27, 2026 at 9:35=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Aug 27, 2026 at 7:56=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Aug 25, 2026 at 6:20=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> > > > > A JITed BPF program can use one private stack per program and CPU=
.
> > > > > Sleepable programs can be preempted, allowing another task to run=
 the
> > > > > same program on the same CPU. The second invocation then reuses a=
nd can
> > > > > overwrite the first invocation's private stack.
> > > >
> > > > I'm confused by this. sleepable progs go through __bpf_prog_enter_s=
leepable_recur()
> > > > which has per-prog recurison counter. So preemption of the prog
> > > > doesn't break private stack.
> > > > If the same prog attemps to execute on the same cpu it will be skip=
ped.
> > > >
> > > > syscall prog types go via bpf_prog_run_array_sleepable()
> > > > that have per prog recursions counter.
> > > >
> > > > Looks like we're not doing it for bpf_prog_run_array_uprobe().
> > > > I'm not sure what the right trade off here.
> > > > I feel universally checking for recursion is better
> > > > then selectively disabling private stack for uprobe.
> > >
> > > I'd really like to avoid adding this "recursion protection" to uprobe=
.
> > > With uprobes, there is no recursion, it's called from well defined
> > > context in the kernel and you can't have recursive uprobe BPF
> > > programs.
> > >
> > > All you can have is a very valid and possible sleepable uprobe
> > > interleaving, which the user cannot prevent or work around, they have
> > > no control over this and it's just a fact of life.
> > >
> > >  E.g., a simple scenario, we attach one bpf program (let's call it U)
> > > to some USDT. BPF program U is sleepable and actually can sleep due t=
o
> > > page faults (e.g., unwinding Python stack trace requires sleepable
> > > mode for reliably getting filename strings from Python runtime, which
> > > are not always paged in).
> > >
> > > In such a case, you can have thread A and thread B both hitting the
> > > same USDT (e.g., somewhere in memory allocator or whatnot). Let's say
> > > thread A hits it first on CPU X, BPF program U starts executing and
> > > unwinding Python stack, does bpf_copy_from_user() for string contents
> > > and causes page fault, is taken off CPU X. Meanwhile thread B hits
> > > USDT on the same CPU X, kernel runs program U, and it is supposed to
> > > work completely independently and concurrently (no shared state or
> > > whatever) from U's execution in thread A.
> > >
> > > Yet, if we add this per-CPU "recursion check", we'll just skip U's
> > > execution for thread B. This is data loss, and it's very bad in
> > > practice because it frequently just invalidates the entire data
> > > collection trustworthiness.
> >
> > ok. fair
> >
>
> great, thanks!
>
> > > So I think we should disable private stack for uprobes (sleepable or
> > > not) instead. I'm not sure private stack buys us anything for uprobe
> > > cases.
> >
> > why disable priv stack for non-sleepable uprobes?
> > While non-sleepable bpf prog is executing the same or different
> > uprobe cannot execute on the same cpu.
> > So bpf prog can be preempted by kernel execution,
> > but a user task cannot start preempt bpf prog,
> > so 2nd uprobe cannot start running,
> > no?
>
> I think that changes on preemptible kernels, this was called out in
> discussions on previous versions of this patch. So only for that
> reason.

my understanding is that preemptable kernel doesn't mean that
bpf prog can be preempted by user space.
only by kernel.

I looked up earlier thread, but don't understand what Jiri meant.

Jiri,
please clarify what problem do you see with non-sleepable uprobes?
