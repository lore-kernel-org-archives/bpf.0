Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80233B3C1C
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073694; cv=pass; b=jiFH2pmUrfWzr0fvEEi6hFsrwDHiRQ3/d/L/R1v4EoKe8BM4TzvSdvigsNBwaUKzp3B+dy0UgSVaMUF84vSOV4oCS3pbyiBWOdT5x1CNnIgamTyQbnkJ3Dnh/d/SgU2wrxejH27OTXmTHC9Bcd8du+C7jMdQobs8pfK7yBcKy3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073694; c=relaxed/simple;
	bh=6FcdC7XGQ4jkQLD+Wscs7I1j0Wqn5J/bSiY/KJxoln0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzHtre27qHeoFGVPgfqBKtUF7b6GuDYzLo6gwMvZJQ/ijINNZvM7qZVvRQQVsZd96Mkrbvq2EsEfkaRoTjGF6XT0uhhMcYOexmbAi1akLgusU89L+IXJF1bqQVRsjd2K+edw2NQwV70DC4tmR+g5oGw/ikyYSysuCqWEJCDpqxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=YWN6V1Cr; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Im+Zw8b3; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="YWN6V1Cr";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Im+Zw8b3"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629FpVkh2575578
	for <bpf@vger.kernel.org>; Mon, 9 Mar 2026 16:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=XMVepEXCHAiG6crC1IEBcOFkczgNZ9CneWdZtRfQKVk=; b=YWN6
	V1CrdOGKHQ8ksl3f2wY8j9f12Bd2ik6/fnmurXbYi6r83ChYUPNlwCp6eJY9jSoS
	MXCj9ceplBiOfAV3SjVqF4++YxYnCkCAZS6SdCZoMQAqBZ06ysjDTifh+bEzJ3Od
	bQ8dALXcJd18NWx/6EnOqkMeGOkDf+svPSX7Y8ewiMJX8OodDaJvcJ3G4N+8IzN8
	A6RG/toqXY0qHbd8g0gosNAmdjNYnib7lCkSECeIJRgFAmvF8lplZh8rUhsLyqm2
	vZwzIGCdaCcjNDtpyynu6f4rrcsRok8DvKhuNwyvEU5WjT3D5eT7EzOTLaZEgtjW
	cLOxJGr2ECGak/EhOg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cs1u05527-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 16:28:03 +0000 (GMT)
Received: from 04WPEXCH009.crowdstrike.sys (10.100.11.79) by
 04WPEXCH008.crowdstrike.sys (10.100.11.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Mar 2026 16:28:02 +0000
Received: from mail-yx1-f69.google.com (10.100.11.78) by
 04WPEXCH009.crowdstrike.sys (10.100.11.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Mar 2026 16:28:02 +0000
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64ca3de57f1so13663274d50.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773073682; cv=none;
        d=google.com; s=arc-20240605;
        b=jznwhhNLm5grTgCiLcwXA2QYtb11dpV2Dev1qeua/K9rmQIIIX8mh2Ap4Bpv+8z486
         AL9StLrx9jCGs1NhBzexSvM6WRTF2Lw9i/mLN/QxyqYLnnAA7ZGkvwk6ra/sulbEy9hY
         wd0B7gAqO0sa8qSuBliz7ngtiOKnRREaGg+eFzoSvMuitMRwGZoPJBoNwN20sR4Upe1+
         FIrWMkshCJa3ewgJEwriLlJq0YWmtB1c8TVBYkTcNcpP+peE64MxM57kZKclPHVzDYpf
         HnFIgyW/iS6qYGfp+3de/CyX3nnKG0wQcVQU1xWVfukfSe9ET8D2QVsh9+RphK1RmkcF
         lAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XMVepEXCHAiG6crC1IEBcOFkczgNZ9CneWdZtRfQKVk=;
        fh=Eu4umwily2rRSS9LrU3YEXKRRKdb5TGhuAGlbptaSF4=;
        b=R7j6hGEcLLIuozPgXujJskuJU6RPuR9izFja1ThvT6CUJhSA0/9s/poGZB/P3GFNVF
         Mx23Lo5obzSjVWXUsMWQ5hc29CukoNWnrIoujVeZeA/AWs8Sf3BZrImjZN7iLcCqQouh
         3b6pYbsMIEDaVNoKGUkLKlVYd6t8EDt8jKu4ooBNCgdBKvUI4wRx3bPUX/93PZDqycqf
         AolEIl0zbR6MZA+w/EYway3a8OkohjARo76jlraktI0bw8x8kwatWqJoXRKXsasr8EF2
         bYfiLOpqqBeIhJjOWakz7N+rq9F3KgO6FB1kR1I1p4Zg8Q6fUHUTp/7YfivE07rkHV/k
         md5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1773073682; x=1773678482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMVepEXCHAiG6crC1IEBcOFkczgNZ9CneWdZtRfQKVk=;
        b=Im+Zw8b3Q2FNadAmIv34muC92HFoBEWYcmD1Vx1bRpoc8MQ9iRiQWlaSLJEyUWVLRX
         2qBubqEpFGJLz/nVGJ+BXuPi0LWYj0Ed8NVcMJ9HKhLT6NeLzdL2nnywjkdMDf+mAHAg
         zDwJKgiKovikmu240Psae41X+0QNiyGOoXO5IMmeARIbeMPfeFKPDaw86mSrmZgZ+9ac
         7TwQPKNw2cWGnG8zgk4xcHoOX0HO1i9USX5xigh99piEwx7Wa/iNqRF+sb0rs0ixSRQ8
         UOJtECOEdrnaVaAfTels8iLnWaiblyULNg+uaP+IWBvX0bpm3xQ3PMSgx2WMPg0EfpF5
         a9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073682; x=1773678482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XMVepEXCHAiG6crC1IEBcOFkczgNZ9CneWdZtRfQKVk=;
        b=NZsSsBH+Mob0do+d1jKJbVtAfKXYjQRwl38AWsuw9RFpzd+qlJOyQGamGKGjCeXQj4
         N/u7NwMG+bKnc2CuitoOqnaGQFrwzDW0Fmt/9xtDiJQaB494fXM5mqeLyixo2B4rIG3c
         xHDg9ZA4hzxqcH97DF2dk7d2KpvRJfZeWNpo5EmlKFskm8z/Q//0GCjznPfzQVDYOCTu
         c7CtA0UER1bjifVyO5P/z2Ilck7YPJd2qp5rk27/NWuxG600TLdgRw2/6pnR51Qs4nLz
         NjuWlpQUfuril8P8lDhxhxO/3lo/bEd47cobEd1lJP0A7hBwzb/T9R9k+Kn/ATkzs2M+
         H3Aw==
X-Gm-Message-State: AOJu0Yxpz0LWn3DOgp8aT57i6PZ3xpxwCkqwgB6+g3Jfmwcir0AWhQIK
	jff/raKTuviJibIWMVmCd+VRWGWDkVb/n791iR1FEtmEqO/ypmmPQHG9L13QkpqikJT/TDZs+ga
	nDI0aAZCRrOb2tC6esDOdG8e2lvoE3IwuTQJv/ELsDWQUoEbVA5ycl95MJbXf/0V6/LFwWGeTtP
	Vr2QXJgY4ICNkggwXjLhbiir8AdyFTigIOojCKo7gG8+U=
X-Gm-Gg: ATEYQzyPgMgg7GO1p4uNnEDSN/JmvtpbSW6/VdUyUDo6yh4P1O6tfOQljCupmokngXi
	UPnF/C9B4pes/qp7f+JOOtPnM+WOTXJICYB99lBsGF+5DqGwLe+EYrSmykSn18dLdvHzWEL6lbP
	GPy1hXbYXvqrYamIqEEjQ27w0hCiBibDBnzSol3cev7ZlTzCboqXvZxjXeSFyMpSuRy1KoOLgVR
	jXA
X-Received: by 2002:a05:690e:e85:b0:64c:a5f9:9b2d with SMTP id 956f58d0204a3-64d14101bfemr10276422d50.21.1773073681780;
        Mon, 09 Mar 2026 09:28:01 -0700 (PDT)
X-Received: by 2002:a05:690e:e85:b0:64c:a5f9:9b2d with SMTP id
 956f58d0204a3-64d14101bfemr10276399d50.21.1773073681178; Mon, 09 Mar 2026
 09:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com>
 <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com>
 <CAEf4BzYiwAczqqdb40YKq8yRd7JWgOV_cgyehpCRzoEZ6qeP7g@mail.gmail.com>
 <CAOu3gNgUp0sqgTUfCM_UFsEi6jwsTDjMrAZL_Pv=FZ4Fx_Khug@mail.gmail.com> <CAEf4BzZ8ky0menK0ujPMkKre3+P2SwPQ2oJ=cgtQ9JMp0c86Kg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8ky0menK0ujPMkKre3+P2SwPQ2oJ=cgtQ9JMp0c86Kg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 9 Mar 2026 12:27:50 -0400
X-Gm-Features: AaiRm50LMmLAmQfIIo5zVvJXHG8V5ut9oBjRoyBEAr_isdtHETwBxT-qFhIk68s
Message-ID: <CAOu3gNjcdzFJDBAdBHDFJp_MMKoy2dMG7M3=LHx_gR8ENMK=UA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v4 1/2] libbpf: Handle duplicate
 kprobe symbols in attach_kprobe_opts
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, jolsa@kernel.org, emil@etsalapatis.com,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE0OCBTYWx0ZWRfX3ri7aVJK+Zfr
 caUY2gD/8dPpppg5AQULlUlsH1/Lxk0lAQtytH+7EiX9XPychfptPFkKFSyybpI5RWJQflkivQU
 biDaItp2NE5ltPptF+h+PEOyl8Y8LlBQ9iPZNp5Np99dXEyBAQzvSY6xT3EopPyuBIdWlcyBz0h
 uhahtLphijZaGV640gFqV7S4Cl0a8fdkF5XTsyHnkwh718rAKH3yhI728YQ5S5aCgd2zHuVRyvg
 w5sZSSlPQCgqMjj3ysXb5PFOKTAyvhulxOQdcQBsTxbNJ1bcwT6WIK9m75cPtvHaKNGLsplmtyx
 xV8YyvVt8h9y0aM7xlNcepxznPKM19gdJeVll1p3IksN9VPWT99D++UJ8QpOf5Nrs6S1Mek1aZs
 Z6zQRoUHzsl+H0HrzYsL90+kYxfaP3ktYA8bpsASLVvQvzn/EtRoSC6w9MRGpB7HI700bmdKLMC
 VR28FtQ1YtnwQX59rWQ==
X-Proofpoint-ORIG-GUID: aB2ECoeC4Fgw82MBckRWnGM1WxbKpkJS
X-Proofpoint-GUID: aB2ECoeC4Fgw82MBckRWnGM1WxbKpkJS
X-Authority-Analysis: v=2.4 cv=Z5Hh3XRA c=1 sm=1 tr=0 ts=69aef513 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22
 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8 a=89cUL-tqPNMvuB5KzNEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11723
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090148

On Fri, Mar 6, 2026 at 7:53=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 1:08=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > On Thu, Mar 5, 2026 at 5:47=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Mar 2, 2026 at 1:05=E2=80=AFPM Andrey Grodzovsky
> > > <andrey.grodzovsky@crowdstrike.com> wrote:
> > > >
> > > > When a kernel module exports a symbol with the same name as an exis=
ting
> > > > vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_op=
ts()
> > > > fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy
> > > > tracefs path).
> > >
> > > If the same symbol name resolves to multiple addresses, that's an
> > > ambiguity that libbpf has no business resolving. It should be on user
> > > to resolve and use attachment by address, which libbpf supports
> > > through bpf_kprobe_opts or multi-kprobe opts.
> > >
> > > pw-bot: cr
> > >
> >
> > I understand the concern about libbpf making policy decisions on
> > ambiguous symbol resolution. But I think the skeleton-based auto-attach
> > workflow makes this impractical for the user to handle.
> >
> > The recommended upstream pattern is:
> >
> >   skel =3D my_prog__open_and_load();
> >   my_prog__attach(skel);
> >
> > So it's something along the lines of
> >
> > our_skeleteon_bpf__attach(skel)
> >     =E2=86=92 bpf_object__attach_skeleton(skel->skeleton)
> >       =E2=86=92 prog->sec_def->prog_attach_fn()  [=3D attach_kprobe()]
> >         =E2=86=92 bpf_program__attach_kprobe_opts(prog, func, &opts)
> >           =E2=86=92 perf_event_open_probe(name=3Dfunc, offset=3D0)
> >             =E2=86=92 perf_event_open() =E2=86=92 EADDRNOTAVAIL
> >
> > So bpf_object__attach_skeleton(), which iterates over all
> > programs and calls attach_kprobe() internally. That function extracts
> > the symbol name from the ELF section name (SEC("kprobe/func_name"))
> > and passes it to bpf_program__attach_kprobe_opts(). The user has no
> > control point in this chain - no callback, no option struct, no way
> > to intercept a failed attach and supply an address instead.
> >
> > If a kernel module happens to export a symbol with the same name as
> > a vmlinux function the user is probing, the attach fails with
> > EADDRNOTAVAIL and the user has no recovery path within the skeleton
> > API. The only options would be:
> >
> > 1. Abandon skeleton auto-attach entirely for any kprobe program
> >  that might hit a duplicate, and manually call
> >  bpf_program__attach_kprobe_opts() with a resolved address for
> >  each one. This defeats the purpose of skeletons.
>
> No it doesn't. And there are many purposes to skeletons, convenient
> auto-attach of everything is but one of them (when everything can be
> declaratively defined and attached).
>
> But even for the auto-attach functionality.
> bpf_program__set_autoattach(prog, false), attach explicitly however
> your application logic demands and set resulting link into skeleton's
> slot (skel->links.<prog>). You'll get the same auto-detach clean up as
> if your program was auto-attached. It's pretty flexible. Sure it's
> nice when everything just works out of the box, but ambiguous target
> symbol is not a typical out-of-the-box-working situation,
> unfortunately.
>
> >
> > 2. Proactively scan /proc/kallsyms before every attach to detect
> >  potential duplicates, set prog->autoattach =3D false for affected
> >  programs, and manually attach those. But autoattach is not
> >  exposed in the public skeleton API either.
>
> see above, bpf_program__set_autoattach() is a public API. Skeleton is
> just a convenience wrapper around bpf_object, you still have full
> access to bpf_map, bpf_program, bpf_object, etc. Skeleton's first and
> foremost unique added feature is convenient memory-mapped access to
> global variables (and embedding BPF object file for nicer production
> deployment), other than that it's doing its best to help but not get
> in the way.
>
> >
> > Since a kernel module can be loaded at any time, any kprobe could
> > potentially become ambiguous. Pushing resolution to the user
> > effectively means the skeleton auto-attach pattern cannot be
> > reliably used for kprobes.
>
> you are overexaggerating how common this problem is
>
> >
> > The fallback in this patch is intentionally conservative - it only
> > triggers on the specific error codes that indicate duplicate symbols
> > (EADDRNOTAVAIL for perf_event_open, EINVAL for legacy), and it
> > resolves strictly to the vmlinux text symbol, skipping module symbols.
> > This seems like the only reasonable behavior for auto-attach, where
> > the user has expressed intent to probe a specific function by name.
> >
> > Would it make sense to limit this fallback to the auto-attach path
> > (attach_kprobe) rather than the explicit attach_kprobe_opts API?
> > That way users who call attach_kprobe_opts directly still get the
> > raw error and can handle it themselves, while the skeleton workflow
> > has a reasonable default.
> >
> > Happy to hear alternative suggestions on how to make this work
> > within the existing API.
>
> Realistically, just use multi-kprobe. It will attach to all matching
> kernel functions (unless unique match is requested).

Thanks Andrii, I already replied to Ihor so I will not repeat same replies
here to not spam the mailing list. In genral I understand the issues you
guys are having with this approach. Ihor suggested a kernel level solution
which seems like a great idea and I will look into it.

Andrey

>
> >
> > Andrey
> >
> >
> > >
> > > >
> > > > Implement a fallback mechanism that, on such failures, resolves the
> > > > vmlinux address through /proc/kallsyms - filtering out module symbo=
ls -
> > > > and retries probe attachment using the absolute address, bypassing
> > > > kernel symbol name validation.
> > > >
> > > > Changes:
> > > > - Restructure libbpf_kallsyms_parse() to accept a bool skip_if_modu=
le
> > > >   parameter that filters module symbols before invoking the callbac=
k.
> > > > - Add find_kaddr_cb() callback and find_kaddr_ctx struct to resolve
> > > >   vmlinux text symbol addresses from /proc/kallsyms.
> > > > - Detect duplicate symbol errors (-EADDRNOTAVAIL for perf_event_ope=
n,
> > > >   -EINVAL for legacy tracefs) and retry with resolved KADDR.
> > > > - Fix NULL pointer in gen_probe_legacy_event_name() when using abso=
lute
> > > >   address by passing func_name instead of optional_func_name.
> > > > - Fix NULL pointer in pr_warn() calls within
> > > >   perf_event_kprobe_open_legacy() by using ternary fallback.
> > > > - Fix memory leak of legacy_probe buffer on retry path.
> > > >
> > > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com=
>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c | 155 ++++++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 137 insertions(+), 18 deletions(-)
> > > >
>
> [...]
