Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6AF2E63C
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770778055; cv=pass; b=WvOmodnU1Gf4jJCguHitSueqhonv++9YCexCRKre7R1ByR7GLavP6eRdH1gfdgDOMnS948mWZ1yJ4CpganjeYV9wE7Yr6qkVGjPTQKzV0SYDsZ119VNOAIFFiNx1ipYgpckmHgfV2aJv9X2CG9FGBdm02G/mPvzJL9xSFtDGN6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770778055; c=relaxed/simple;
	bh=1EMmP3bOOgbmAcfssvM4Mg4vj58oM6VVlrfvuyMQ/fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSAvduL9wM8uW2dj2TKyu/2BZpsvDuBIeRd3G19LWhE3/zWcEMCVsZ8f9gK1oOvFsSe/wvRC3mclVpzx9qVJsYS0Kh6U9iXKmNvGrh651QLZKxBDgswsbkX9H90A2rNt4q9YNR1Fr6ExEhM9Z4zhVH9bCQQfntcyxpWAqryJ8wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHBKtqO9; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHBKtqO9"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-435f177a8f7so4642070f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 18:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770778052; cv=none;
        d=google.com; s=arc-20240605;
        b=Oc4tQwAek+ddN1ar/WpIq0dtlXrKWebjL/owmLANpCiRZG3PR+qU4W9+T0z7wWkRZ9
         WulmAdzksDb7aiIy1k7bb+hB4GT+DuCUrhivTyboSQtG/CTGMul8mAGmwVviKixJjgLB
         z2vju5kdS31F3ad6FsIzde5uQwG2oS/YwnYwbMvwo3ND3+VPcOmGzGH8QE29niwhLArn
         7r01q+15YjujQYZhRY81V4/XaC3+dNQlTd/EPvUcVrRKuN2T6/Apf3pKYhJz7Tn3Hen/
         z+8rIukygcY++Rm0PZWDWAMb4fxAbgPS7YyptcgRanps+ckAQqPAUnW6hOx+pIcJsHYR
         cnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPAco6rZkDZuGB6VxUPenKFR0LwT0r2F0+1JDJx35sM=;
        fh=SIaJeH73d4typAYM1xsg/6rN9adF+qAkXXGFfIO8+4s=;
        b=i0rUQEREtxR0KXPz+SDgiNeAxsgW6sCye6Em75AoFCqrqXHWPUhR7UUJI03FAaTqJO
         5JVbF/XKAUwFldBUgOQrvk4G5ukmTTOF3K+36cOVyURfqpLJ2DichZAHsakQkTH7cE4F
         ibzMuiJB3Xbw0wMtd8vOulJyE1P+/TZEySI6Gw96iCwTHHFgSnzpEuyswX2egtgOyeOS
         bMl9hsapHOavRKqIEJByR3QvQiXJaCIHLDZ5WqIRe4O0hxTSktD3EV+9r1dXOgWyzm+q
         CwYsiKQ3lsIZHZDibyR82TFDJMqqD7BmjjIEQAJRjC6Y89HRVCROF28acVlfhYYjXZaA
         91Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770778052; x=1771382852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPAco6rZkDZuGB6VxUPenKFR0LwT0r2F0+1JDJx35sM=;
        b=BHBKtqO9XmGKnRJCmj4KJl/03KtMRMNTR7TiMcbiwft8fomOGvsERlHdpa6FbAknqI
         YdThIprGfyU9uGdKqB6Isved8r0+dscKp9WiwZYkz5qJ562m2PsWg1gnAzPdHTB8lx+8
         c0oV7Sfww657d9hDI+htyyWdGxUhIz1/N2R+AhIcSDuNllq4g3NBKUTityjz3GXtbpEa
         oCgHAMyuPYtAu80Gv4f4QmQlYOOhDE32eo7j4ok2vOXtp4qCNX1klWGHch/PTYYKID1I
         XsnjDzasRWzsa1YN4EMMUjfxG7gef+8YiY+wMHs/4M6XgJgAcqlGsylaeknZOklJ8E5/
         mdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770778052; x=1771382852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPAco6rZkDZuGB6VxUPenKFR0LwT0r2F0+1JDJx35sM=;
        b=My7vowpbqt+KkQd8Eob+z4Hpe51NmB4Red/tpFKw67I3Cxxaqq2n740AnYq6P33ZL0
         p7D+4UyG7tBFe6Hga+ngZ3OPPE3vXEExIhCRYKszBQJ2Z8wKB14FpS77qfVhVV4pAEoL
         tDUAQMFZ+tAm9HvhOLMByIhKk/N4Ndog0isa06g4BujSSAFdzof9XrvanumGkbqdxuG8
         SjrEBx/E1FlnyR8g+iX20pOBGS4UG4Ryc7EK1oNSeOIT6mC1dfrBnO/A6CltrehzRd8L
         EZOi3/CFItaSmzEPXNUKfajtwnbumAT58Hg/C9r2RO/0zBtPTygk2Z7MCKXo6KMH2/u2
         evmw==
X-Forwarded-Encrypted: i=1; AJvYcCWySTrIN4DWGDQnGHWNNLyqRuIzScfncTHc+HZ1QRmtMGEmzPvep8NSbJ4pz+OGwQ5CNB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0QWIHkw7CrmE64jqQ4Xn/SlN+fy1Zq+hptWa3UFzGE6FUpDJO
	XeMZdxdE5r9GFnff7ZVo+y9qjb6t0K69UJ2ZvpL6jA/6zO5cMjut06Z8PI8aBgCv9nyhH2ToInF
	vo61jBfvEo6DI2gnJvzkNaEu2RjE9+H8=
X-Gm-Gg: AZuq6aKjya93KsLfQEEUYRy5mcVPG12APuH2+p/+0cM7xjui6Y6Hhbk65LWo3WtFRSq
	jJ+n5bEurrP3jE1kBGrLJInm9fVDIER9ZjPzFL57yQaKoRr4x879xV/QofjXatGavBHtcuqJlUr
	h9a01bUqWpZu27v/AtFsKZ2QLywkTml9OkGiP4Y5hOuMBfBsu2MrsFy7kC/5zhbuajAjtiXCFtA
	grP8MgZk7QHxKfoAaTwGa3QYeVT6F2m4HIpPm6jBjONF3Wt9Eb46V4gnSbODtEayOtpoRBse7Ar
	x3sPyood02R2Cfot9xTE3ZnGnAKk8cLMvU0JvXF4LSKlzVHCLxlb8BDkShDfi4sD/HfL9UTOInf
	D5zYLHfxJ4/7K9h85psnBnXwBOA==
X-Received: by 2002:a5d:5f55:0:b0:436:1707:2884 with SMTP id
 ffacd0b85a97d-43782cbfb55mr1732075f8f.56.1770778051952; Tue, 10 Feb 2026
 18:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com> <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
In-Reply-To: <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Feb 2026 18:47:21 -0800
X-Gm-Features: AZwV_Qjlm8gj9p7Vk-rjzYXw24X30I8fin4TlrHPsw_erjOADTwEOI-4QchPi5c
Message-ID: <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Reject access to unix_sk(sk)->peer.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> > >
> > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > bpf_skc_to_unix_sock(). [0]
> > >
> > > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> > > but there are many functions where bpf prog can access the field
> > > locklessly via fentry/fexit.
> > >
> > > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > > the last refcnt of the peer sk while a bpf prog is accessing it,
> > > resulting in use-after-free.
> > >
> > > Another problematic scenario is that unix_sk(sk)->peer could
> > > go away while being passed to bpf_setsockopt() in bpf iter.
> > >
> > > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > > by marking the pointer with PTR_UNTRUSTED.
> > >
> > > If needed, we could add a new helper later that uses unix_peer_get()
> > > and requires bpf_sk_release().
> > >
> > > [0]:
> > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> > > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > > Call Trace:
> > >  dump_stack_lvl+0x5d/0x80
> > >  print_report+0x170/0x4f3
> > >  kasan_report+0xe1/0x180
> > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > >  bpf_trampoline_6442564662+0x47/0xab
> > >  unix_shutdown+0x9/0x880
> > >  __sys_shutdown+0xe1/0x160
> > >  __x64_sys_shutdown+0x52/0x90
> > >  do_syscall_64+0x6b/0x3a0
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef6c=
ae0@rbox.co/
> > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > >  kernel/bpf/verifier.c                         | 18 +++++++++++++
> > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++++=
++
> > >  2 files changed, 43 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 3135643d5695..b328a1640c82 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map *=
map, int off, int size, u64 *val,
> > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rc=
u_or_null)
> > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_truste=
d)
> > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __saf=
e_trusted_or_null)
> > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_untr=
usted)
> > >
> > >  /*
> > >   * Allow list few fields as RCU trusted or full trusted.
> > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_s=
truct) {
> > >         struct file *vm_file;
> > >  };
> > >
> > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > +       struct sock *peer;
> > > +};
> > > +
> >
> > That's just one out of many. It's not really a fix,
> > but a bandaid for one case.
>
> Right, this is only one example where a pointer lifetime
> does not match with bpf prog.
>
> > We discussed it in the past and the only way forward is to make
> > helpers only accept trusted args.
> > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > We should do the same for helpers.
>
> What about just reading an untrusted pointer ?

What do you mean 'untrusted' ?
There are 3 types of ptr_to_btf_id:
trusted, untrusted, legacy (without either trusted or untrusted flags).

kfuncs now accept only trusted, while helpers still accept
trusted and legacy. The legacy should be disallowed.
That might break some bpf programs, so it has to be done carefully.

> I used bpf_skc_to_unix_sock() in selftest in case compiler
> could optimise out branches that always return 0.
>
> Currently, this passes the verifier and can trigger UAF.
>
> u =3D bpf_skc_to_unix_sock(sock->sk);
> if (!u || !u->peer)
>     return 0;
> if (u->peer->__sk_common.skc_family) # unsafe access
>     return 0;

No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_mem
treatment. So above works and won't crash the kernel.
It's effectively inlined probe_read_kernel.
