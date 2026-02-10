Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CB2F5461
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742134; cv=pass; b=d3fUsr8+UWceWj6bhLAfhJhKwVb51x14HnMgeybilaQtuglBb+fPd54chxcDiSurAJcmKtsZQNkzvETtlvYvudfGeNcZUZj2neqUe9Kh0FJbuu0KOA/yUY+WGZWHULJQVxGlUT7GvaU635mG0TMDbl/Qg0evmCKSRhGx2mRWkTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742134; c=relaxed/simple;
	bh=cn5+eLRFyXybilovXeK1nbQgiKBCKvcC8nE/jjFqDXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXw5X1w0xYbaESxKYDG1tfjWfwlUryQH0/tsiEbVW2vyDyCWMxPT3qGOvzAysESaFjg+um3L31a3wq58m+FqtqxBgcdpHXHHm3fxbcgQoJhtiOlzTfJwOUEVj5NVS7B2e8DA3+BBBSm5TFKud8Q7vVBLfsk3BXLqYFyyds8t/9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGcOdLUp; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGcOdLUp"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6dd0ec465aso383a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 08:48:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770742133; cv=none;
        d=google.com; s=arc-20240605;
        b=SPPJaLmrixD5Xzaoj7txWHoK0XSYiaNxHwxFoMCbF78mSSSUzkdMU/uu4tvBghfnvU
         /haOu1BpxBEsxTq/dUTYT5KQveIV3uY4USWbAsA7Wthz8RSyiBtenwqRHwHpo6eUpqsA
         fxVmyOiA4h4MLiJEFvMoiC6jh9SFl9sm+xHNxbRUWzJUAU2jcK+4nuwIEJ6yoioSr74X
         BTYKIn50iFzhLvtQSh7/S28IvsOYXpk46qjTcE/UhPqVk1dQCFa4IYU5H/scVFZHasS1
         9IIxvdgd7Nr4RcDX+nylzBDF7UQM+M2lmBxhOgPtpsoo/GHprByetVpvs7XxCI/9+oeE
         UFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fdN0niDgwU0p5pLJISvMf3YiADHyHlfw/GlVzZCGO/o=;
        fh=TCTIBws018cdvbzFnR9DP/oHdDTIeWJgn/HK86y3L8c=;
        b=QqXhnKQ5ONeZurFuN1YXTPUA7+VfGfoZ8c62yzuE6AY7QiKW0w2GCnuaJRxMBEoEzU
         JUMD95yxLnaFy4dqhvB78j3kfznyl1hSlRJWUefyX5quhfKUfV0iEXr1eK3nv13KwAsd
         VW3BBEnMJfN4R/aq2VVwytgppAU77GX0HFPySrxwevDnud79oigo2WZlbG6piLSw8ZCV
         fVKDuaHhqXvGhW2/FL6U2Pid6oJJKtSkiA+L6otHsrNSJMoJJnslBejzC8qSD0gSIKId
         Md3n/pQqAhAzcoA/DQ3/cFUDNGS5Ff35/nZf+HYwkvOnJ1kozYtsqI/Pt1KzJpEaUacm
         bxlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770742133; x=1771346933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdN0niDgwU0p5pLJISvMf3YiADHyHlfw/GlVzZCGO/o=;
        b=ZGcOdLUpVAGxuRyUGu6i9qqLSh84F9ZdyITfGfwx2xUo6JUIvUPrVEwIUpBZIjNIAE
         HaegqJ2m+gsTMbNhz0jLrKokm84XIwU5TmmExm/T5R/lADC1Wd34vuYzNJ7Cn7Q83uso
         91Ba+Gl2NRpglElHX2aTtTj1g6pjsl2PKep2m4sIvtqnMKNdsrGhz+Ewg7xRDEPVrhZz
         BiNGmKvETEHaeY03kKTrBXm8NUERVRnGxF33A5QYwBIdd1Yj8oSn/i91muka+pyJxAPz
         gU6a0U6ltvG18no0cKjN+bF8ejtWyNO+jYlfBt4E7amhugbYpHxjzTIHyUA1LnmbZXSv
         DvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770742133; x=1771346933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdN0niDgwU0p5pLJISvMf3YiADHyHlfw/GlVzZCGO/o=;
        b=BGskaZcVpOOLeDV796Jyk0i9mwt5vpDDNnG7OpKRsJ7yaCJvIQGqW8UZD/GHP9nrfJ
         ugXJg5QElOvaxoe0XTenSjd9x7zULqaKBSF7w5uwkybF/ZMpN7VgD5hIxT2tQnE/OdJS
         2+CmMgaFwaWc8lQ/q9mTmig65leDgF2K0cq8hzbyxw83u0/ZiGKamyJ8iX7aDArruvQ9
         fjEiQTpCxBB0ntvsrLU3yLGWgMp1VcFQTVq4QlADYlvroc687ntHM2q2MSs5JiP7chNc
         rYdZgjL81LlriH1nbkU6hj12RdJVu1ctcZ3/lqjD7it6bt1JDvog8pXSm2vb9t3+UsJM
         N+bQ==
X-Gm-Message-State: AOJu0YygvboyBAKki5oIoVP1p1r917kbsTqvUHKiNm10Nc/1zMHTWwY2
	z44NTbBSx3NnxVasgU3SM+phjYyCrQZ6rmEpD5eAzD8Rl7s9fbSix9Z1g42xaG7ZRA/i7/a5sYa
	lFnJMea2KSCK1zYDfqVekqzCQuIOntOk=
X-Gm-Gg: AZuq6aLKh0dSqPIQxq5C5BP79HLttbxnoJuL7PbhkCfnNbussklyzmZg/Vskh+2u7Ji
	2gryZQyPKxzkKmVOPTsQIVMWQYHqYl2EdVDYX39GQRkO1HWJRcHZccsd5s6imM1vZdOwm/RtDKl
	2ydeSBUJJlkUo7CJ3PUcMokvWe1fmpOKXnOQp6jaoqFmjMCGHHgZFkEweFtVkCczoj1649YkzJq
	cc5k6NFd4isHo9efbG3VGmv+q2/KPhAYaiyHAVXcApXb7+24nZUTKZCwuogKGqqUrC458i90ut/
	Kk2ZhId2a16ne1qCXru273Y=
X-Received: by 2002:a17:903:1107:b0:2aa:e388:da4b with SMTP id
 d9443c01a7336-2ab101354cbmr29455205ad.29.1770742132554; Tue, 10 Feb 2026
 08:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210005508.3642641-1-emil@etsalapatis.com>
 <CAEf4BzaLqWT1oj-EXibyAfE0ExmiaCCqhosRujDi7Y0Nyho6dA@mail.gmail.com> <DGBEQ37JLW22.2IFYZDGMHZI2G@etsalapatis.com>
In-Reply-To: <DGBEQ37JLW22.2IFYZDGMHZI2G@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Feb 2026 08:48:39 -0800
X-Gm-Features: AZwV_QgtdPpoow1icF0yR303pktx8eJSGKE2Vr9D7lmHsbVTS-MQQLITij4fpUI
Message-ID: <CAEf4BzZ1tedVxfv6G+F_w8TJ7ngkHe9Uui22xXOGc24Kdpi5nA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: Add gating for arena globals
 relocation feature
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org, 
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 8:03=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Tue Feb 10, 2026 at 1:54 AM EST, Andrii Nakryiko wrote:
> > On Mon, Feb 9, 2026 at 4:55=E2=80=AFPM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
> >>
> >> Add feature gating for the arena globals relocation introduced in
> >> commit c1f61171d44b. The commit depends on a previous commit in the
> >> same patchset that is absent from older kernels (12a1fe6e12db,
> >> "bpf/verifier: Do not limit maximum direct offset into arena map").
> >> Without this commit, arena globals relocation with arenas >=3D 512MiB
> >> fails to load and breaks libbpf's backwards compatibility.
> >>
> >> Introduce a libbpf feature to check whether the running kernel include=
s
> >> patch 12a1fe6e12db, and only relocate arena globals if it does.
> >>
> >> CHANGELOG
> >> ---------
> >>
> >> v2 -> v3 (https://lore.kernel.org/bpf/20260209234850.2750149-1-emil@et=
salapatis.com/)
> >>
> >> - Rename feature to better specify the verifier feature it probes for
> >>   (Andrii)
> >>
> >> v1 -> v2 (https://lore.kernel.org/bpf/20260209210240.2051209-1-emil@et=
salapatis.com/)
> >>
> >> - Reworked test to use simpler array-based program (Andrii)
> >>
> >> Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the are=
na")
> >> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> >> ---
> >>  tools/lib/bpf/features.c        | 92 ++++++++++++++++++++++++++++++++=
+
> >>  tools/lib/bpf/libbpf.c          |  7 ++-
> >>  tools/lib/bpf/libbpf_internal.h |  2 +
> >>  3 files changed, 99 insertions(+), 2 deletions(-)
> >>

[...]

> >> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_in=
ternal.h
> >> index fc59b21b51b5..974147e8a8aa 100644
> >> --- a/tools/lib/bpf/libbpf_internal.h
> >> +++ b/tools/lib/bpf/libbpf_internal.h
> >> @@ -392,6 +392,8 @@ enum kern_feature_id {
> >>         FEAT_ARG_CTX_TAG,
> >>         /* Kernel supports '?' at the front of datasec names */
> >>         FEAT_BTF_QMARK_DATASEC,
> >> +       /* Kernel supports LDIMM64 imm offsets past 512 MiB. */
> >> +       FEAT_LDIMM64_FULL_RANGE_OFF,
> >>         __FEAT_CNT,
> >>  };
> >>
> >
> > So overall this patch gets the job done, but I think we should tighten
> > it up. I was curious why you have so much ceremony, so applied your
> > patch locally and tried to strip everything I thought unnecessary
> > (plus reformatted that big comment to be a bit more greppable). Here's
> > what I got and it seems to do the job...
> >
> > pw-bot: cr
> >
>
> So to recap:
>
> a) Remove BTF as it's not necessary
> b) func_infos is also not needed
> c) Use sizeof(log_buf) to avoid having a separate variable
> d) Use a TRACEPOINT program to avoid the SLEEPABLE flag
>
> Will update with those.
>

ack, thanks

> For two of the changes I have questions:
>
> >
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index 034ea9b20617..6e27aa618e70 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
> > @@ -508,90 +508,64 @@ static int probe_kern_arg_ctx_tag(int token_fd)
> >
> >  static int probe_ldimm64_full_range_off(int token_fd)
> >  {
> > -       const size_t bufsz =3D 1024;
> > -       int btf_fd, prog_fd, map;
> > -       char log_buf[bufsz];
> > +       int prog_fd, map_fd;
>
> Should we rename here? Every test program in this file uses map for map.
> No strong opinions one way or the other.

given we have prog_fd, yeah, let's use map_fd here as well

>
> > +       char log_buf[1024];
> >         int ret;
> > -       static const char strs[] =3D "\0f\0";
> > -       const __u32 types[] =3D {
> > -               /* [1] FUNC_PROTO `void(void)` */
> > -               BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0)=
, 0),
> > -               /* [2] FUNC 'f' -> FUNC_PROTO (main prog) */

[...]

> >
> > -       /* Be conservative and NULL terminate the buffer to ensure
> > strstr terminates. */
> > -       log_buf[bufsz - 1] =3D '\0';
> >
>
> Should we remove this? If there is no guarantee the buffer has a NUL
> character somewhere, the strstr can fly off past the end of the array.

verifier log on error will be properly zero terminated, that's part of
verifier contract, we shouldn't doubt it

[...]
