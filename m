Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37AC14F112
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844792; cv=pass; b=n3LildTafTNY1NqqoBL395AOzDlFcvbQLb/wvecY2CfxZit7NtMcomg4V8KER+bN+kLxCT3JT4FSYM6LlxhdR02qDVhSl+6wA1thAzpaoeKsnCF3Z7gipYE31a1b0B1w8t/U6BLUUGod2X5vmEnRl8GrrSK8ll2GM5RjZMbqRaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844792; c=relaxed/simple;
	bh=KgC75WWku0vFWN0FPoaUFQGBduqYB4wIG4FIDN51S2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNzxz/NqGXdGYPczXDpFXSt7JaxDmHEx2q9H3sxgxn4/juYaYEJ2xDQx9kKM9ls+2cZ+VBW/RAaM84utl4NSt9QkLf40Azi9ZUNO8TljDxqInCHDGdzX6avnUyfEKfPybJlqR255tEMepshDrkEfRjhYCXHOZI1ceVM8Bn10Ng0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W93MMCqj; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W93MMCqj"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8299f1ca86fso651339b3a.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772844790; cv=none;
        d=google.com; s=arc-20240605;
        b=ixbGRb2aMCNlY2jqJI1aKaQQCeG0U7ejpb01lQxk9CslWgWRfZGBDDwDfdwwY5uVvk
         3HU5OT0194xxvI4EOddeVFVyQLb0Gw7PgYUMVeP2xnY/LaBX3DjkQxx2Eck0Zm0ahh86
         Shj2lw2zT78yfzjroH+uXJbeLO9yuzum/HdyO5hOE/JuE5VLvP8TOqF2qlD2X18Ip5Fe
         w8vCHW4Zzi/3dyDXtFsJ7U6Y5ZBqGO+JAP5dRgD9ftJCraQktYVyndlVy5/XLhKRftdW
         7TX69brF2b65H/C4RAac6T7+w2365k6qM1UvJkWo+OYmWPRZuMz/NVun1nqTlTabl738
         v7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUBvhRli2+tpD4rC9ts0IOVrF/QooZN64iTMRsQJNbg=;
        fh=nQy42juJAtOd+ZZJVn9EZi5KSLdCBMcThKSvGZVlprQ=;
        b=VZzT/SMiKvxVlMFFBb0tSEdvM9s1SGLyRxTBCbFlGtXji5c9Eh7CitPOAuHoxk7nxc
         V7mrBibdpfGwEpufbKyi6gUKovTe1PWovXNppeXOqxxY+O7CeBQMb/729HVo7GgerP9q
         PPMnP7UrdmH7or4oslcUUtXj5VsQvuxtJ/Bo6+iKD63fMdWKilKMXYrh17kAjF7n6olM
         epafl/Jrr/oolmfseFGZCFTS/l3olJTBzlY2Ko3GJUb0Cwy64k3kMu0qGjrhX4SntbX4
         E/XoftH6MYpAv1/1vU5vT5U1unmPX0gVwYDh4rzC5UJ4+bUkudi5LzU87Y+Q0lWSBvM8
         Lp/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772844790; x=1773449590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUBvhRli2+tpD4rC9ts0IOVrF/QooZN64iTMRsQJNbg=;
        b=W93MMCqjS/1xoTmn3Iz85M4nnRTtFOKvJeobHncr9Rf+h1JuwubI5HCH9bQeZcXPWy
         g0lArdzX9qztXiF0aZmk9jhOBble5oZWX9D22n0VPrrwZ/LEzkBaFtwEt5vHBguLRwQn
         SU7mzlJsI3PXxEsU1DlwoltOdyl+pw4z8QHLQAGTvD/XeXmA0Jy1Lvudh1CUPLlyTR8W
         2sMKWkGYi+QW7QG/cZsu9ixkQFBytUH6mViwcVQGhItTUNhZOWlzwdk0Ts3Cnm6ChHK/
         /ZPn0I46lvcW2sxYE8GruHHfr+mFe68HtEDTDmhYllHM94o65DO2NXN3QrGS50thJCrj
         ou7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772844790; x=1773449590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUBvhRli2+tpD4rC9ts0IOVrF/QooZN64iTMRsQJNbg=;
        b=STHQ/2UV8rufqmDWgF/HZqkuqzLCs0N2pjHntQEPEMdbRhwNWO0uaO0RaT4pRxF3O+
         i8/2LCfPFjj+hnO01a1NCnbeviyHpSguL6lQtBemgnSlZOkSRv330pSIDxKGBVEJh/b+
         i+H0VvTg+f9HEBxAdRkeipashWrFEc9tHHQKKHmNndfHRVPIae8HVyx6YIhyCEGk8GfT
         J0iwfynNyxcXGk1Jllexo0uTHIlfE+MaDkYoCDCIUh6zyJycyugiMwe4vxFvaJHXU3B+
         U97zz0BhPX7jDUVi7YqYrrcgJxiuGEV4g8L6mPsnYCt/PR2GggXs0lrIKpk65wMDkR1q
         wmsw==
X-Gm-Message-State: AOJu0YxRPB1COQ+WgNq6X3ccyxR7AASqWlOFL+EBSNxRuyNp1ho1/R8B
	QcCFNIb7U8ZfTn7n8E2GKEm70flheE5KD0H/L0ooCtcPohdgNXOAN/ThwC2BsI5c8yjC330k59q
	eEM5wfNsnEi+TxQuSTvOfS/mqKrnW1vU=
X-Gm-Gg: ATEYQzzixUWJSqV4d+0vOarJkmfpXnM5O62gezogDTpBY7U9FJQjO1kILXCKGurhsdi
	IjZae/Usz+iEdoXzgeuZjGj2YBcX8aeST4XXTLdhvatu1Pr3N62d33MMPIzrXGySACPW4Usw6WV
	ZlqOpstuxVcp7zkmfqQAYcElJ2sRW3djjD8j4AH8bnaG+psIyU20mhYBaGgU7obeiD19xgdoHk6
	Nya3VPliquM4oScabuYmZnybQ2CubOTMAgGV8IOUtXlZVr1mPBtU1BGPhzHExDNmHCJ5FeV41nY
	orICUlw=
X-Received: by 2002:a05:6a00:21d0:b0:829:7087:7e79 with SMTP id
 d2e1a72fcca58-829a2f49b43mr3751961b3a.30.1772844790225; Fri, 06 Mar 2026
 16:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com>
 <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com>
 <CAEf4BzYiwAczqqdb40YKq8yRd7JWgOV_cgyehpCRzoEZ6qeP7g@mail.gmail.com> <CAOu3gNgUp0sqgTUfCM_UFsEi6jwsTDjMrAZL_Pv=FZ4Fx_Khug@mail.gmail.com>
In-Reply-To: <CAOu3gNgUp0sqgTUfCM_UFsEi6jwsTDjMrAZL_Pv=FZ4Fx_Khug@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Mar 2026 16:52:58 -0800
X-Gm-Features: AaiRm50VW-3g5J2XQ6FWw_8dclIhmc5syPXmzgMvkGYM-L6Xg-GI_roMWjjnOSU
Message-ID: <CAEf4BzZ8ky0menK0ujPMkKre3+P2SwPQ2oJ=cgtQ9JMp0c86Kg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v4 1/2] libbpf: Handle duplicate
 kprobe symbols in attach_kprobe_opts
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, jolsa@kernel.org, emil@etsalapatis.com, 
	linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 1:08=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Thu, Mar 5, 2026 at 5:47=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 2, 2026 at 1:05=E2=80=AFPM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > When a kernel module exports a symbol with the same name as an existi=
ng
> > > vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_opts=
()
> > > fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy
> > > tracefs path).
> >
> > If the same symbol name resolves to multiple addresses, that's an
> > ambiguity that libbpf has no business resolving. It should be on user
> > to resolve and use attachment by address, which libbpf supports
> > through bpf_kprobe_opts or multi-kprobe opts.
> >
> > pw-bot: cr
> >
>
> I understand the concern about libbpf making policy decisions on
> ambiguous symbol resolution. But I think the skeleton-based auto-attach
> workflow makes this impractical for the user to handle.
>
> The recommended upstream pattern is:
>
>   skel =3D my_prog__open_and_load();
>   my_prog__attach(skel);
>
> So it's something along the lines of
>
> our_skeleteon_bpf__attach(skel)
>     =E2=86=92 bpf_object__attach_skeleton(skel->skeleton)
>       =E2=86=92 prog->sec_def->prog_attach_fn()  [=3D attach_kprobe()]
>         =E2=86=92 bpf_program__attach_kprobe_opts(prog, func, &opts)
>           =E2=86=92 perf_event_open_probe(name=3Dfunc, offset=3D0)
>             =E2=86=92 perf_event_open() =E2=86=92 EADDRNOTAVAIL
>
> So bpf_object__attach_skeleton(), which iterates over all
> programs and calls attach_kprobe() internally. That function extracts
> the symbol name from the ELF section name (SEC("kprobe/func_name"))
> and passes it to bpf_program__attach_kprobe_opts(). The user has no
> control point in this chain - no callback, no option struct, no way
> to intercept a failed attach and supply an address instead.
>
> If a kernel module happens to export a symbol with the same name as
> a vmlinux function the user is probing, the attach fails with
> EADDRNOTAVAIL and the user has no recovery path within the skeleton
> API. The only options would be:
>
> 1. Abandon skeleton auto-attach entirely for any kprobe program
>  that might hit a duplicate, and manually call
>  bpf_program__attach_kprobe_opts() with a resolved address for
>  each one. This defeats the purpose of skeletons.

No it doesn't. And there are many purposes to skeletons, convenient
auto-attach of everything is but one of them (when everything can be
declaratively defined and attached).

But even for the auto-attach functionality.
bpf_program__set_autoattach(prog, false), attach explicitly however
your application logic demands and set resulting link into skeleton's
slot (skel->links.<prog>). You'll get the same auto-detach clean up as
if your program was auto-attached. It's pretty flexible. Sure it's
nice when everything just works out of the box, but ambiguous target
symbol is not a typical out-of-the-box-working situation,
unfortunately.

>
> 2. Proactively scan /proc/kallsyms before every attach to detect
>  potential duplicates, set prog->autoattach =3D false for affected
>  programs, and manually attach those. But autoattach is not
>  exposed in the public skeleton API either.

see above, bpf_program__set_autoattach() is a public API. Skeleton is
just a convenience wrapper around bpf_object, you still have full
access to bpf_map, bpf_program, bpf_object, etc. Skeleton's first and
foremost unique added feature is convenient memory-mapped access to
global variables (and embedding BPF object file for nicer production
deployment), other than that it's doing its best to help but not get
in the way.

>
> Since a kernel module can be loaded at any time, any kprobe could
> potentially become ambiguous. Pushing resolution to the user
> effectively means the skeleton auto-attach pattern cannot be
> reliably used for kprobes.

you are overexaggerating how common this problem is

>
> The fallback in this patch is intentionally conservative - it only
> triggers on the specific error codes that indicate duplicate symbols
> (EADDRNOTAVAIL for perf_event_open, EINVAL for legacy), and it
> resolves strictly to the vmlinux text symbol, skipping module symbols.
> This seems like the only reasonable behavior for auto-attach, where
> the user has expressed intent to probe a specific function by name.
>
> Would it make sense to limit this fallback to the auto-attach path
> (attach_kprobe) rather than the explicit attach_kprobe_opts API?
> That way users who call attach_kprobe_opts directly still get the
> raw error and can handle it themselves, while the skeleton workflow
> has a reasonable default.
>
> Happy to hear alternative suggestions on how to make this work
> within the existing API.

Realistically, just use multi-kprobe. It will attach to all matching
kernel functions (unless unique match is requested).

>
> Andrey
>
>
> >
> > >
> > > Implement a fallback mechanism that, on such failures, resolves the
> > > vmlinux address through /proc/kallsyms - filtering out module symbols=
 -
> > > and retries probe attachment using the absolute address, bypassing
> > > kernel symbol name validation.
> > >
> > > Changes:
> > > - Restructure libbpf_kallsyms_parse() to accept a bool skip_if_module
> > >   parameter that filters module symbols before invoking the callback.
> > > - Add find_kaddr_cb() callback and find_kaddr_ctx struct to resolve
> > >   vmlinux text symbol addresses from /proc/kallsyms.
> > > - Detect duplicate symbol errors (-EADDRNOTAVAIL for perf_event_open,
> > >   -EINVAL for legacy tracefs) and retry with resolved KADDR.
> > > - Fix NULL pointer in gen_probe_legacy_event_name() when using absolu=
te
> > >   address by passing func_name instead of optional_func_name.
> > > - Fix NULL pointer in pr_warn() calls within
> > >   perf_event_kprobe_open_legacy() by using ternary fallback.
> > > - Fix memory leak of legacy_probe buffer on retry path.
> > >
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 155 ++++++++++++++++++++++++++++++++++++---=
--
> > >  1 file changed, 137 insertions(+), 18 deletions(-)
> > >

[...]
