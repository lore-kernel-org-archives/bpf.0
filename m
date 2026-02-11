Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C136212B
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845169; cv=pass; b=FrIpu59BHsR8O2B2hdmg8VvBaXtrV2C/1I6sSNwU/uPygWi9pOFAVxDwsknTkIyJGRza0MEZX0+q8KAsc5p5qIW347s5fuimFokW0Bnw+u4ZZmarcfXprcYCLS26iiNnzPcx7TrrQKcuw4lCFou4sxX5v3cZWnCA4FtzBhakK0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845169; c=relaxed/simple;
	bh=F2M7aQlFoZH0cgy1kFODhyqS8nrF6gbB7NAYuBeaUTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJwn9jMZDmxGTcPJ+M0zD4UPiV9f+FodcGRs1ttp00ME9xm2EHkseqNnp+6f4tSHo1UL9OD9FRn5gf6fOHFkVsNxqnh2C/vFOyUsLilRr969D7mhLwgnEVsOJul3GfjKqhqH0BsyDI6GZcXGyQi3XmT3kXWwsw3PEqWsolnpB+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR2unsBn; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR2unsBn"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43621bf67ceso3650627f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:26:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770845166; cv=none;
        d=google.com; s=arc-20240605;
        b=g6HMSl9kB6uZIg/KQ5lRJqF1wLfvUzO+aEqHft1ilXPrCf/wzC4Z9SkAdG4WeOa1X1
         pI8Z2WUOyFELVZ/+7IF2DjoC3r5hoBYDgu9ktAcspzXzW2mvOftv/ysIWhiwm2GdlE9s
         lxO2Kv7jDUYCG392RnUaIJQeAXuoICzDDfv4tdxJcphJJkzLwQrF7yaPjt8iNrFVURdF
         7sgFNqQX9aPSEMWoW5v9NMG3C4GAheLkSSjCpoWU5F5bbhYvIPV8c7fCMd8RXVGq04/G
         v6k7lm9rtX5ph+zFBSIxhGhBQiXLOdxdLqYPmXh82tFNEGmlznX2mFdfPxcV91+NATgV
         ly3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=65Nvr87DM3NpPKCY/DERxSJtqtoSj0DAfyvi6/s8EBs=;
        fh=MUSpCTkcgqFZhC387zZEkbFL+/cAutN/2Ppb7QuMxZI=;
        b=Zb+qbtuoVphZwTm3kAlxTcO8uCKDY/NssVB7VA081Ruaz8WPWIncpaZ1hLk+ljXKQH
         S2iOzV1uxWo4412l7+ea0kanwtDzQJTrRJ5eyOnJFk3aQnkZALbljkoBMdtPqWAXGjpL
         uaMAgeGFPpyfMKdxhZvAdsUxJRB34kjv2It/Lrz/fS4aSa3LR+BU5R804+OjYxBPfgRg
         xw7abfblETARgxgNF4VDkYQvbpJorzA+WdU99gvCtfXqgDTYO8gDd/sELnJUvVDk747l
         I42TGmgXKPbzGvhVTpFcoaMVc+ctjruEZOvKGU3JRD+syLusn0HLf/ttfZyX4dnZ9fbm
         LB/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770845166; x=1771449966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65Nvr87DM3NpPKCY/DERxSJtqtoSj0DAfyvi6/s8EBs=;
        b=MR2unsBnLBM1+CzuSXpvL09F3V+2/OoVR58SFRX31FgaVFtixoWaUZ/WFu7ZVOU8on
         GU7Z7Ix2onbMJWmVBxPV2dcO38gafRGbYqCmo05ykJR7zuL00/m7/UqeR1Wu11597X4B
         9rOe/F9shJzqcOyqA2ND9P2Pzq+s8QNl97LjIZQV/VsVnL5Ma89eCEXZFlUVRcVP9EBp
         gJtfSvU8VPsqmRNCERLgfNbHyXP0Ok5pmAgBhjhw+r1nznH2Esd4lXV+Ci7Y1x4gIVpq
         oerEqk96n9h/NH7dCd7Kn8+BkIK5ne93uiA7hOxSf7/RjdbXzkzJG6xW/7C3ILy9o2iH
         sSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770845166; x=1771449966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=65Nvr87DM3NpPKCY/DERxSJtqtoSj0DAfyvi6/s8EBs=;
        b=aYiVIKF/Fkh3Xt3zezRTNOxfDDXnvVT4uQdKf7HDl4FuVvh6Q9kXuejpVetjVBvUAZ
         YJTKA1j6XmfGxQ25cR4FGXeoVztYrf533JowQjGapTFvrLQTb92uscsxlaIiRIrP9PUi
         Hvigyz4eV3rGyZLoHrMhjQHVSZKsTTNzNvhIFI1biI8thtN9Nb32+Kc/OIEczg9ckaB1
         hj6Lr3KvLIFkdDBXWVoJpwTJ0Tl/kq5wPPs2oRnTUGDJQu304z8mtylNCLY36elNekYK
         ThcsoU0OIVoy9wisTMBgNxdRZO00zdJMY2zVm9w36A9Duf3TUi/Sdu5V9+ueBe6PN3i6
         w7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVO3Jx9pc0hFYvdnxmoh/mCA9Y6SW+J+uajlNZuJG6bkfbNR1lbsp0hOXCQbc4F0eUL3Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAjUgC2FT5+2sL7d5Cj0wNqKsHmrQCwDzsTH/VLcBZr9dTKOH
	Vmqgum8l17nOaasTbs1CTMofn4M2SVKvnhdzD+diDFCoHEhUq+/1r4kGbPY6R43fkjX+iKxJ9MS
	NkguGj00VUNeuaSkcjR+xFy4Sld2X1gg=
X-Gm-Gg: AZuq6aJlCyApf8eJZLIs+ghQhzsq50NZyCdqMbKdc4kFpo8M83uNp26kJ9E0wczC33W
	On608KSMX16fZb9yi3P1YDzes/P2TJ86LZcx/h/WlUP4h5nVaRMZVBm03GawazNx+r8+kFxtUKK
	CQIgEnRDGNqFZLUO09rD6maFTATl4HgrXymneVdbITI81ldARi4UpFd34l98rW6VBG7chquPgXQ
	GwQ6nqij/e1jPiEMU/5xbkn2dKJ7+XNJmASA9HTwR4KA5k/vFL5OZISm8tlcdEAr1+S/z2K2y5P
	5SbeENbh8sLESle4VvQFOATvLytJvPNc9g0p+P8GJcQz4dGAPOT5ArgfyF5ixgI5/7AR6f3JA3Z
	lbrks/Pe+md723S0Itn2iKIrv7w==
X-Received: by 2002:a05:6000:2dc6:b0:436:3475:4737 with SMTP id
 ffacd0b85a97d-4378ac830dbmr1118836f8f.30.1770845165507; Wed, 11 Feb 2026
 13:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
 <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
 <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com> <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com>
In-Reply-To: <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 13:25:54 -0800
X-Gm-Features: AZwV_QjLi8Bv6mmZLoIJpsm3LgwONesQYtRLMgT6WXTmt9Mr1zAQ9ZKNptCgiO0
Message-ID: <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com>
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

On Tue, Feb 10, 2026 at 8:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> > >
> > > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@go=
ogle.com> wrote:
> > > > >
> > > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > > > bpf_skc_to_unix_sock(). [0]
> > > > >
> > > > > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> > > > > but there are many functions where bpf prog can access the field
> > > > > locklessly via fentry/fexit.
> > > > >
> > > > > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > > > > the last refcnt of the peer sk while a bpf prog is accessing it,
> > > > > resulting in use-after-free.
> > > > >
> > > > > Another problematic scenario is that unix_sk(sk)->peer could
> > > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > > >
> > > > > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > > > > by marking the pointer with PTR_UNTRUSTED.
> > > > >
> > > > > If needed, we could add a new helper later that uses unix_peer_ge=
t()
> > > > > and requires bpf_sk_release().
> > > > >
> > > > > [0]:
> > > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> > > > > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > > > > Call Trace:
> > > > >  dump_stack_lvl+0x5d/0x80
> > > > >  print_report+0x170/0x4f3
> > > > >  kasan_report+0xe1/0x180
> > > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > > >  bpf_trampoline_6442564662+0x47/0xab
> > > > >  unix_shutdown+0x9/0x880
> > > > >  __sys_shutdown+0xe1/0x160
> > > > >  __x64_sys_shutdown+0x52/0x90
> > > > >  do_syscall_64+0x6b/0x3a0
> > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > >
> > > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6=
ef6cae0@rbox.co/
> > > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > ---
> > > > >  kernel/bpf/verifier.c                         | 18 +++++++++++++
> > > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++=
++++++
> > > > >  2 files changed, 43 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 3135643d5695..b328a1640c82 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_m=
ap *map, int off, int size, u64 *val,
> > > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __saf=
e_rcu_or_null)
> > > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_tr=
usted)
> > > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, _=
_safe_trusted_or_null)
> > > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_=
untrusted)
> > > > >
> > > > >  /*
> > > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_ar=
ea_struct) {
> > > > >         struct file *vm_file;
> > > > >  };
> > > > >
> > > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > > +       struct sock *peer;
> > > > > +};
> > > > > +
> > > >
> > > > That's just one out of many. It's not really a fix,
> > > > but a bandaid for one case.
> > >
> > > Right, this is only one example where a pointer lifetime
> > > does not match with bpf prog.
> > >
> > > > We discussed it in the past and the only way forward is to make
> > > > helpers only accept trusted args.
> > > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > > We should do the same for helpers.
> > >
> > > What about just reading an untrusted pointer ?
> >
> > What do you mean 'untrusted' ?
> > There are 3 types of ptr_to_btf_id:
> > trusted, untrusted, legacy (without either trusted or untrusted flags).
>
> Ah sorry, I used 'untrusted' since the pointer is not always
> valid, but I think legacy is the one I meant in this case.
>
>
> >
> > kfuncs now accept only trusted, while helpers still accept
> > trusted and legacy. The legacy should be disallowed.
> > That might break some bpf programs, so it has to be done carefully.
> >
> > > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > > could optimise out branches that always return 0.
> > >
> > > Currently, this passes the verifier and can trigger UAF.
> > >
> > > u =3D bpf_skc_to_unix_sock(sock->sk);
> > > if (!u || !u->peer)
> > >     return 0;
> > > if (u->peer->__sk_common.skc_family) # unsafe access
> > >     return 0;
> >
> > No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_mem
> > treatment. So above works and won't crash the kernel.
> > It's effectively inlined probe_read_kernel.
>
> Yes, it doesn't crash.
>
> I was just unsure about the bpf expectation [0] like how we
> should treat KASAN use-after-free report by bpf prog reading
> a pointer whose lifetime is not guaranteed by bpf helper/verifier.
>
> So, if this is WAI, I'm fine with that.
>
> [0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpH=
BGqKcUT0iMA@mail.gmail.com/

That's different. That's the actual UAF inside bpf_skc_to_unix_sock().
That needs to be fixed with what I described above by allowing
only trusted pointers into helpers.
In my earlier reply I meant that:
if (u->peer->__sk_common.skc_family) # unsafe access
is fine. It's safe access, because it's sanitized by the verifier/JIT.
The code inside helpers is a normal kernel code,
so kfuncs/helpers should only accept trusted pointers.
