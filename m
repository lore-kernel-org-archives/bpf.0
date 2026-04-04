Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F288351C0C
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775299114; cv=pass; b=QyDqKViJnBLqr81oBtREbIUlSKQ680qnZ6qu5lyCgzF5rHdw/b3ZGt2ytlj3ffsO2FpMbDheDVZV1b3N4h056tVh6i5EUGMCRgdyrI25cC5khX8f/n2wXiTSryJ+RYTanbsQnBiM/pvvzvM2jAc5to/Bn3KVkIDk5lk2GSPGH/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775299114; c=relaxed/simple;
	bh=rPYg7TpDFWwhe5RzRfbD5Fi94DA+blbzYv/IZpUpv7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3N14fXQCffQZ7/Us+PsCpmpo6gkJwf+1Vq3AAbbTKgupDadBD1WIOUYcvT98ht9XfC7naRKgIzv3hw/hDoJLF/59rQT2cvl2zD8YuC6StT7KVmRRVU6ALr2nAP2IXGPw+Y8zcoLp0OvPa7g6nlLTie9Oe2K2LA/aScHuomw32Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PER6PPnW; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PER6PPnW"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c648bc907ebso1841658a12.3
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 03:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775299113; cv=none;
        d=google.com; s=arc-20240605;
        b=ghUAalE6iBXveJsRt1a3ZRCjs6cx6LJwlbSBsVz/R9TJGg4ZTmVib2IEa/G/CwpWoX
         dES85Bz2GBuat0fVBSR97anhYHZSJKvYwtzmHyUikJ7QftS1OUuvTx5gJF7AxB6+saKN
         STTtdxCqV4xgS39X7SW5wgDJm5x74nhMrYqAsN4LZQPZNIDSLf/BV22ntc1KHh2J0O+F
         US3p0Lj7yspJnJZHgs3bR2JUYD2Whp06dukd4OYECfzIkUlwMstdQX6O0FTwlis2746c
         YIJomm3eciETBh77bMJBmV9Sx2WXbb7kYLwuoaGMI6Z2I2WlgOd3SXdQ9z+jXVMCi9wj
         NFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bqvsUxiNr3YkUyIOE+Y6OHDSRkUfY+F/AiYEwjdurB4=;
        fh=9iLXz+XOb3NepKMqzcFA3WOFiLNx215OIg3IDBJo0rM=;
        b=EBLgRkGRVh0ZSQK9oRoIaZkdAVZubfwb9MO+COQ0X0bnAAcmRAQ2krMCPd4ohtBdsW
         bIVS0b/fSXTvHFUENGGNU2Kp61NYK+12d7sAH598Wu23lydeuOvTnCErTbj233Av38q9
         bdgoZxqTEb3FaNNGlTINtw6l9+pvEfAfFuotq0Bt8e9+XPZu6UdsibqBSpsTE37e6ZHX
         DvtxAT0CL1ytow9COhQ+/NtQ1vpoeWkOlwyJo45PgLhfEpRqqTqY2II+mvVHeJ4GsKum
         gKPQYnY94gP1X2nAT/F26a8v2scPDrdH/e+Q2rnlS+lwYlaTl4Ck0C+A1tleoCfMm7Di
         KiKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775299113; x=1775903913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqvsUxiNr3YkUyIOE+Y6OHDSRkUfY+F/AiYEwjdurB4=;
        b=PER6PPnWSzc+H01zGgIQVMwZL+XRKLd3o08y+Uo/Kr60Yh3mGy4/SMgF5hIiepaIyw
         9pK7XZnRw2jaHl4wydckSnvkDZaGbqaWk9g+ctB7HtY2b88KdB3aULQ2KkHhBfKTQrCL
         TuUIgntI0AM8eVIrkuuJEPXH/Mlx9hCoGBok7tvg2sFqIphyFypIPMbfpI4v2Q4irqVZ
         m7arestqDVHAxkXmaiOUvGQ4UrzjKQYw5YBwMqDFU42Csx01QBrrqWgYvWzZ4LgAm2S4
         VogaGUrD2Oil2Qq3EAdKHMkvMyZA1wtyAbPji0dRvVFKAc14QjlO1aZUDWXP2II1zzHz
         YVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775299113; x=1775903913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bqvsUxiNr3YkUyIOE+Y6OHDSRkUfY+F/AiYEwjdurB4=;
        b=Of2gXBov9Y5nBGP/CqwM0arNdPuvCMpB4jkLcOVR8avg1xbQRWNOuN4H+kEogzVu86
         LAra+Yc9mTwyNQJnwOGsNa26X35D0yLx9Vw5ZFb4BurRJt8ZWbO4HYofYcqD7GnEse85
         wPJMzZNopvcCzx3Mwo8bOLI7WLpxZL6MXbQayJHyGUmvexOZZcfM+1EOnX0rTJanMkLt
         zdg1ieW7auNRsasTmSCY0l4/JlZUERmeUImHfKWc5UBH2qSeTKjzX1p+Q8F3juL4tgZb
         gGi6JFX7kSOMLMUtVxCGZYaHSCPc5+99BjpkVraL3AHKhfjHnnu12ke8cBoFJ6AFc6X/
         8xcg==
X-Forwarded-Encrypted: i=1; AJvYcCU3A2DSWPFRXXL6hyFGt5pPMlT05zPHKF/I9vj5j8+hR1z2X40jlGZndnCuVQ4wTnRgzr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Nz1UaQORkbYKLH07evUAv5EjyOfRvpOrs881963M7HqPAOeU
	YgyR51Ak634cjEbjhoJazdb8Kcb9M6+IW2254z3kW3IDEyZ1dBzOuYLFw4kvZLoJ+SmlI2ryyQ0
	QAdhdMwaZV2SLHibFAx1g9bfAe6oi7Uo=
X-Gm-Gg: AeBDiett7S711vAoDOYuON9IUQpooy+fh5CQeXg72xZZSMgjlAsnpH2BLmrn0v1OxF5
	I5cRp2iA4xTIhoyCuZlICSIG1c+7vJDo50TMAzkyMhvqM8kMos5ed3FmqI8ZP3aSjYEMW3pPDEQ
	ESGCMPOZW7PN8GLGjB2+AQtc4OAfacywfvjVAVfaRA1KdyE9OezSMN76PBjF9UuWAxvcEfVqFwN
	Bzrs/5i+Rpjh0Px+8+GTIzIH/aynzqrabkUig2gRiclr0pebWf3g12xfbFwoQXCmJAxkfLGAscm
	HCal6g==
X-Received: by 2002:a05:6a00:1804:b0:82a:768c:9a2c with SMTP id
 d2e1a72fcca58-82d0da6c2aamr6214084b3a.22.1775299112820; Sat, 04 Apr 2026
 03:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329140506.9595-1-pilgrimtao@gmail.com> <20260329140506.9595-2-pilgrimtao@gmail.com>
 <CAADnVQ+xS4ti=cSqAnG4ePmjEZXUb-8Ss9cjkWiiWgtv-_NNVQ@mail.gmail.com>
 <CAAWJmAYxbEX0M3JFJn11WOfvRoLrxnuXtkDp5omt-FJYwc8mpg@mail.gmail.com> <1fcda49a-caeb-42b9-9727-d1ab3d07d84b@linux.dev>
In-Reply-To: <1fcda49a-caeb-42b9-9727-d1ab3d07d84b@linux.dev>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Sat, 4 Apr 2026 18:38:21 +0800
X-Gm-Features: AQROBzBVuir0D7nKBJ5AeyVjTwhlTc_NLfpWFV4-GAP2nVZvUQpLNOXZ8a-J-BA
Message-ID: <CAAWJmAYNS-NaY-57Pt=GC5qSpbfJLKwydVXfem6ckwgFW9aTnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using
 table-driven approach in verifier
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Chengkaitao <chengkaitao@kylinos.cn>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 12:49=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
>
>
> On 4/3/26 10:41 AM, Chengkaitao wrote:
> > On Tue, Mar 31, 2026 at 1:05=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Sun, Mar 29, 2026 at 7:05=E2=80=AFAM Chengkaitao <pilgrimtao@gmail.=
com> wrote:
> >>>
> >>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >>>
> >>> [...]
> >>> +
> >>> +/* Kfunc family related to spin_lock. */
> >>> +static const enum special_kfunc_type bpf_res_spin_lock_api_kfuncs[] =
=3D {
> >>> +       KF_bpf_res_spin_lock,
> >>> +       KF_bpf_res_spin_unlock,
> >>> +       KF_bpf_res_spin_lock_irqsave,
> >>> +       KF_bpf_res_spin_unlock_irqrestore,
> >>> +};
> >>
> >> I think it's a step in the wrong direction.
> >> I'd wait for Ihor's BTF_ID_NAMED cleanup.
> >
> > After reading Ihor's messages on the list, if I understand correctly,
> > our two approaches seem to target different problems. What Ihor's
> > work appears to achieve is the ability to remove the entire enum
> > special_kfunc_type. My goal, on the other hand, is to replace many
> > scattered func_id =3D=3D special_kfunc_list[...] comparisons with a
> > table-driven approach.
>
> Hi Kaitao,
>
> I appreciate your efforts, however after a quick pass over the changes
> you propose (both here and in the new series) with respect to BTF_ID
> macros and special_kfuncs_list, I don't understand what problem you're
> trying to solve.
>
> The inherent complexity is in the fact that the verifier must know
> when a particular BTF id identifies a specific kfunc, or whether it
> belongs to some pre-defined set of ids. This is why
> special_kfuncs_list and other BTF_ID_SET/LIST-s exist.
>
> And so there is no way around defining those ids and sets *somewhere*,
> and so far BTF_ID_* macros did a fine job of that, all things
> considered.
>
> AFAICT your changes simply move around the same definitions from
> functions with if statements to constant arrays with a runtime search
> on them (which is slower by the way). What is the benefit of that vs
> the current implementation? We still have to maintain those arrays in
> the same way we have to maintain the is_foo_kfunc helpers.
>
> Your newer proposal [1] takes the same idea to the next level, by
> introducing an entire new BTF kind, new ELF sections and a bunch of
> macros that are no less complicated than existing. And all of that
> just moves the same arrays "upstream" to the .BTF_ids section. Again,
> I fail to see any benefits to that complexity. Having differentiation
> between LIST and SET, and having to mark START and END is not a
> problem that needs solving IMO.

Your analysis of the code implementation for the new proposal is correct.
Let me elaborate on the purpose behind my approach.

****** Purpose 1 ******

As described in this patch:
https://lore.kernel.org/bpf/20260303135219.33726-4-pilgrimtao@gmail.com/

If we want to add a new kfunc, bpf_list_add_impl, we would today have
to add "btf_id =3D=3D special_kfunc_list[KF_bpf_list_back]" (or similar)
five times in verifier.c. Under the newer proposal, that is no longer
necessary: defining the kfunc and its verifier metadata in one place
is enough, for example:

__bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
 struct bpf_list_node *new,
 struct bpf_list_node *prev,
 void *meta__ign, u64 off)
{
/* kfunc implementation */
.......
}
BPF_VERIF_KFUNC_DEF(bpf_list_add_impl, list_api, graph_node_api, ... )

If BPF_VERIF_KFUNC_DEF is extended further, BTF_ID(func, bpf_list_add_impl)
and BTF_ID_FLAGS(func, bpf_list_add_impl) might also become unnecessary,
so the snippet above could eventually be close to all the code required
to add a new kfunc.

****** Purpose 2 ******

The kernel no longer needs enum special_kfunc_type to list every KF_bpf_*
entry. That information is folded into the .BTF_ids.##sfx section instead,
so kfunc authors do not have to touch or think about special_kfunc_type.

****** Purpose 3 ******

As described in this patch:
https://lore.kernel.org/bpf/20260303135219.33726-6-pilgrimtao@gmail.com/

In is_bpf_list_api_kfunc(u32 btf_id) there are on the order of eleven
"btf_id =3D=3D special_kfunc_list[*]" comparisons. As more kfuncs are added=
,
every is_bpf_* helper will only grow longer and the verifier will get
more repetitive. With the new design, those is_bpf_* helpers can be
removed entirely, including the awkward scattered "btf_id =3D=3D *" checks.

****** Purpose 4 ******

It pushes us to untangle messy verifier safety cases and make them modular,
so they can be expressed as parameters to BPF_VERIF_KFUNC_DEF

> The work I was discussing with Alexei [2] is targeted: get rid of
> constant enums that mirror existing kfunc symbols by making BTF_ID
> internals a bit smarter. And the benefit is clear and simple.
>
> If you could explain what exact issue you're trying to address with
> your BTF_ID refactoring patches, maybe we can try converging on a
> reasonable approach to it.
>
> Thanks!
>
> [1] https://lore.kernel.org/bpf/20260403170900.58659-1-pilgrimtao@gmail.c=
om/
> [2] https://lore.kernel.org/bpf/21e5333c-0b57-46ce-99c8-f6c414270e70@linu=
x.dev/
>
>
> >
> > That said, once Ihor's solution lands, my approach would no longer
> > be applicable as-is. So I have been thinking about an alternative,
> > please see the patch linked below for details:
> > https://lore.kernel.org/bpf/20260403170900.58659-1-pilgrimtao@gmail.com=
/
> >
> >> Kaitao Cheng,
> >>
> >> also please start your part of code reviews.
> >> Your patches are not going to be landing if you don't code review.
> >>
> >> https://lore.kernel.org/bpf/CAADnVQ+TKKptnNB25V3=3Dbcdybh5G6c2DyW2sYtX=
vyRaVnPN8MA@mail.gmail.com/
> >
> > I will do my best to carry this forward.

--=20
Yours,
Chengkaitao
