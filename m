Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AA426EC5
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123687; cv=pass; b=BSVoyYoMJuCMF3vfh3F/JOdcvtGIAW94XpnpmSzhpKsQkp0g1y2txKj8QPdrigdZ62hARODmcLH+3EeQlItzxMb8vShlmfBoABlho2oUjYAOFZrNUYvCHta0USiG5w5omd/Ct+gFmeSIMjlnbX/1TAnPhfmMzh2pBPcALqgyuQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123687; c=relaxed/simple;
	bh=vjzTRvbWQqht790Rr00MYPk2OTbL82V6UIMNHq5W4T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CS0NHYsWWQb3J7F0gRY2DmJ1xmyQdCinezwgdxiBDt770RBsUsBodlLULOYc5IZfYzY60VpGDx0YhQbXnYU4x1cMAWoyzt2tXKiKu9j+Mib3JRH1BMdyoEsTb9MzFBZrXBy/c3SDMTZ4A4dBNSbtYw5sX1Y29FMQ80McZFuzNU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+9wmOSV; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+9wmOSV"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43987b97701so741741f8f.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 08:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772123684; cv=none;
        d=google.com; s=arc-20240605;
        b=CWW2KZnxY3dust5rSjVnP2ludhv46RGlBKrKVpvTjnolbyeD4gm3Dzef5wbULabWrW
         SfN6FthAdqzsRLyjsqYD4NpC+kIUjvxIO5QgyqkNaEE/IuoTfv5s/A6lOyUq5hVK1Mvn
         3Io2vMUDMBGO06y1o5vjCE+3mzCyh6lIRkYWAbbeOMSSSTyGBGQP+iXc/9NeqOXJZNxD
         uFXefINgxfd0D8eHv7en8ZUkGmkNrrBqVnFU1Rsw61OV+S6VNePYfmumjdM/QflBtiag
         PCdf3lINyZ/TcZuM8fVT2QG5s38i+wvhoRm6i9dR39ebxCBvkpGwrvc6YhYdWE24EWxD
         4QBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nvW79o6Js6hFr7ZOr2szBhITqmlzECLaruyg3s/bQn8=;
        fh=fq14LMY11OHnw2CTIi0FQMRE3Wzp5CHqHxqmBWI5psI=;
        b=GGV8yrvAVAYs4EqzvTQ8wr/Nq984p7G9eWL+338ZRKH6YyBbMbaVG3F2WDUqvYRcwl
         /O6nU9+3rwybtp57eoSfgQMjv5aMxdKEAZ26QDUAhINBauZX5cuwG+GEV2+Hpj4QfWo9
         j9tXZ9Fo0nQIG0s+eDIeFTnDxUZPiJuZb9eMR4Lfo01srpNAwBadWmE9BlgQ8Va1kIfS
         Cur3T6Co5a67FCS0HOg+Clz77VTKqz5dqIYxRXDJk0DdtByzGfS7C2k/SuL9yYlF8SFX
         jdlpPlSsMPfrrv/iecZwQ3787aN2piakzSlariAUb7tx0E7vEiCQrgsR/PjBoifUw8RG
         Llig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772123684; x=1772728484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvW79o6Js6hFr7ZOr2szBhITqmlzECLaruyg3s/bQn8=;
        b=b+9wmOSVyeoZK70Okx3TzX+fyP+lHSrAn3MSI8HUcEigNpc85TG+jzCIh8C2b6jSwI
         e6ljEKGycuqatVXkezoGM/ZTIpxUD7caJmybCMQHzvAD/DwsTBfwdsoD//W6f1iKpUi1
         amjBCKto8sck89K/tihXDXNxX1tBdRzuIt9UkCsL8xPiQbQvR8DlRYHqPgdKMAjFrYRF
         MazYolv6/kEQ5quCprPgHa86qvWWUFE22QDkDxTz7BWojUFSZICJdu/wTb9NEI9sL4X5
         Ow7BMopbeNUbECZEDEwny0zJvbNYKV1O7xtOz5PaBjckvu/fRxQmLzeVu6WBqM5TBHDt
         NMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772123684; x=1772728484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nvW79o6Js6hFr7ZOr2szBhITqmlzECLaruyg3s/bQn8=;
        b=U7+Zhtw69l5WR733W9BxZC+05jZ8dj2gF7+gq7oOP7f0S4r/J5fDACRWv/xtGDnuYJ
         goZ5EzMJrAH7l7uuJKZWSzgvnoa9MFzuOzbjWxT9VsyVoX2IbFMkkIyDj/aGBSO1Jdai
         NqH47i2e3ZoRtl1BVf3K5Yspo+HAPp8mwV4Tc8f7Zlce4CfZBsNoReVGEHiJreweSOEd
         iH6ONhZzfey/CRGkuXVsU4buqxbTR7V/Q0iKcuASb7R/eqg264/lSoKBu5P6vlogGKve
         2RrnTYMMMgiDiBAOQWG66Dr651X5tGX67Ypbnua9nyRdJDfsRYVg7xvMkzpz1Ofx7LjQ
         3jEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtRqhQSjjPndxAlBXUUXwBF60y46yCa2NU/Co1BIklR0ESzcVRTRHuMVX18PcyT4Ggd3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkzwoN69MP/ee2PIhaBQ14hyU7Iosp3mRnBt10+BjW9/ql4xI7
	UMNLgpWgJHwjsz0wHPpwx9LUfNcX5idhJyuxUEaXAMPDS569ScmbUmbZwnvOAZLojDZMxhTaIOq
	ofiJUD/GypHOo5mn4N5OexClccYk6HoA=
X-Gm-Gg: ATEYQzwG6FY+Lxopdazcl1pBHGPaits2L0tGzB/QvsFM/QIWqoBTuP3t2nfzaEx9Cs9
	vZDQcj6ioycyL9phrFSsaL6fnLPTw6fU6zxhzX1SzDU/Pl4njRZNYHG/Va3gee9TY64c3EXX6Fw
	PUN9d09sl0lKJeswn6zl0VU1jqehpcQFKNWRi3I3FySeQ2oO5eJjOsSTvorAoOFuF8CiVTx4dPJ
	EeqIleD+2JhYjZmWPe3t7oEBYulGt4SCChHbAnZshkKwD3LqMuUQ3U/ZAOelkx/lvBa8R/6pt6X
	wG80eaTKRTH6l2CopDSeFspnuvLEaHP5J7RkV5RmngXI7yjSX8pb5nzsqdIT2TQO2If1DAZvlVK
	XKPIlVRqL
X-Received: by 2002:a05:6000:2c04:b0:431:67d:53b3 with SMTP id
 ffacd0b85a97d-439942fb94fmr8689612f8f.43.1772123683957; Thu, 26 Feb 2026
 08:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226085624.1909682-7-alan.maguire@oracle.com>
 <dc1d9fb29ac2eba86b21fb85ad1bac9d096f0e9680ef87b42a86200120b5e7a1@mail.kernel.org>
 <de9dbe59-7adc-4e00-a0eb-7f5b3cb88ae9@oracle.com>
In-Reply-To: <de9dbe59-7adc-4e00-a0eb-7f5b3cb88ae9@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Feb 2026 08:34:32 -0800
X-Gm-Features: AaiRm51BqeCxGmIqbkWDPMk4IBLWoIS1BCNZ0qmfHTlkbbNF_eOvASirMb2ntx8
Message-ID: <CAADnVQJOv7aayd1Awsfhwmiotkex_-ie+_H2agx55Ka954rbqA@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 06/10] btf: support kernel parsing of BTF with
 layout info
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 8:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 26/02/2026 10:05, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >> --- a/kernel/bpf/btf.c
> >> +++ b/kernel/bpf/btf.c
> >
> > [ ... ]
> >
> >> @@ -5327,23 +5328,36 @@ static s32 btf_check_meta(struct btf_verifier_=
env *env,
> >>              return -EINVAL;
> >>      }
> >>
> >> +    if (!btf_name_offset_valid(env->btf, t->name_off)) {
> >> +            btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> >> +                             env->log_type_id, t->name_off);
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> >>              btf_verifier_log(env, "[%u] Invalid kind:%u",
> >>                               env->log_type_id, BTF_INFO_KIND(t->info)=
);
> >>              return -EINVAL;
> >>      }
> >>
> >> +    if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->layout &&
> >> +        ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_layout)) <
> >> +         env->btf->hdr.layout_len) {
> >                                        ^
> >
> > Should this be <=3D instead of < ?  If the layout section has exactly
> > N entries, layout_len is N * sizeof(struct btf_layout).  For the
> > last covered kind (K =3D N - 1), this computes:
> >
> >     (K + 1) * sizeof(struct btf_layout) =3D=3D layout_len
> >
> > With < that evaluates to false, so the last kind covered by the
> > layout section falls through to the else branch and gets logged as
> > "Invalid kind" instead of "unknown but required kind".
> >
> > The libbpf equivalent in btf_type_size_unknown() uses:
> >
> >     __u32 layout_kinds =3D btf->hdr.layout_len / sizeof(struct btf_layo=
ut);
> >     if (!l || kind >=3D layout_kinds) {
> >
> > which accepts the last entry.  Using <=3D here would match that
> > behavior.
> >
>
> looking at this again, is it worth making the distinction between a kind
> that's in the BTF layout but unknown to the kernel versus one that is
> not in the BTF layout and unknown to the kernel? In both cases we reject
> the BTF, and given that the kernel cannot be in the business of trusting
> the layout provided with that BTF it seems like it's a distinction withou=
t
> a practical difference.

"unknown but required kind" means that the kernel doesn't understand
the kind, but its layout is described in BTF?
If so the sentence is odd, since presence in kind_layout doesn't mean
it's actually used. Here the check is when the kind is parsed.
So the kernel should reject it with existing "invalid kind" message and
that's it. It doesn't matter whether the unknown kind was described
in the layout.

But at the same time if the kind layout describes some unknown kinds
it's not an error. I think it's fine to load such BTF since all used
kinds are known.
