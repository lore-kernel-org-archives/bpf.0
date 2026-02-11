Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75637219EB
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848593; cv=pass; b=C7oVqzlRlf465Ib9A8YfQm9XDxMtBlooZLp+MEjx85oJNuLPPa74jVNM/eCZE/9uuVVzT/Ih+aXpUjfC2U66VwqsSVQqvogoWoY/BjCB3dbKSmOU3a8AZ4Gv+mODv2o8PCZNe7z9IrPnHbEhbgpUsUCyHeBmy7g9oaDI5C1W53E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848593; c=relaxed/simple;
	bh=eXDI5rcV+A/T0/rpbI/ShJOsViO8yaBsbpbntt+dflA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T86FfWuySzeucvBKvvyusDZQA03z4tr/UzSZFwTodxv7nAEFthHDM77QBwa1hRzKbeKa6ux5QCaLdKp1vHLfPBW3BXobCNMZtKwO55mLB7F4/uGTCJ4lEwiIO3VAgP8DCT11FXD+iPR2cmSLWpw+KIwEdqVM9S+NvcoS/lWPqwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHYER+Pn; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHYER+Pn"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1249b9f5703so7861313c88.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:23:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770848591; cv=none;
        d=google.com; s=arc-20240605;
        b=Yts0DrdWaFHUGtbg3AODIHLVp6wVSVEJz/Cr2Esxb6SdOImLb01Tz39zzMyV9/ds+v
         xQpfvHJ6oLWqB1AfyIRsGMdLm1Aai1Q6FDcMKFeSPVikqDJgcvUjtT887woZmaCKjLzo
         Z5n506wbIK//EXoDuxjZgRHZtQJyyCr6oBspnC1r/osaLabxMGaW8FdV+O4lb1RILLKf
         u8CYjMpWac0qwIslbfmATLd8QyzYBYX4UjSH3iyYVEtYCo22VdEtcM3YlP7SQ4dwF7Vh
         HWtSzbSpW54WhU7huUiuRZF3yvzHH2TKkcH6LbtaCa39mwQUIyrsRllQSMOSJLYR7qni
         eEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXd4Rh45bQsBPkhhAC+bUe+BVrbwXVOg5adLymQr3DA=;
        fh=U4lippwZQ8IoG3NfxAP4M5wFS9yj6WHPxFkx4y3hsOA=;
        b=Dg9PTiepELoOCQC9IEGw15ChKNUvJtalzYwkBA4lRBNAUNYwTHC+EA3ep5R5TeSW23
         yufOMOMt6+LjZC1walRMv7+KM19NYCj9AH4tjAFCiZVR6eJWrI9AudFaYlkUsfIBGm6c
         gMjXMbYGEIfiQveeGaO/3wrjib6ZA2Sm2IufQPJPlK+51JGw5rsWShU2Fle2/+pmMp6b
         bkhR/FTR2Z/VOnFsN7hcJmaWoLpnf2Q1I2l10HC9aRHsu7IjBkSxzgZPNzajBS2GQKFk
         0tkGLQedidwx1AeXXw67ly1pN8mnejXdwQWLvV8Jt9IMge07PGIfsGj5qWiBk+Ub27UG
         1XoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770848591; x=1771453391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXd4Rh45bQsBPkhhAC+bUe+BVrbwXVOg5adLymQr3DA=;
        b=UHYER+PnFcGCyQWDmtc9O//LAEie/bQwyaQWFCokH0mVBNlCK/in4gLojClY3q0lUc
         Up3jlmYodtPtQ9nEVefP8jolqeGI+tGtDp4RWN3z5105oJV4eOarHhs8wKfxSzBa5QeI
         a2lFj7Zs1BcW6aEmD6a+J9fqWDimONs2gmM1oCjNE7BhfgzfrMN+DKoehXgyASRtvWf+
         mowmjD3sj/Bc9BeRvwvAEckm/JW8MkFBYauRxgh1w9Aytt0OGImw2pdwtwaZSDrHSXTe
         jYGCPI/wBWJCn1WNpF92GCB0Lgzlq4vSKoMcs5Vwe3FFxw3YCud1O5UpjNCd5mbHUbob
         UjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770848591; x=1771453391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXd4Rh45bQsBPkhhAC+bUe+BVrbwXVOg5adLymQr3DA=;
        b=ZdCa5X8mQqw7GqBcEZ3zKTINdn3h4sHxstwfNdRYApgYrIeyB6dzd1VAiVgezmRLKA
         h5q2tk6JTT9Zb6igW6QbgAogmXG1jnGN65xeuUM+89ThhTJ6ffwv6MBKhxGvnDNIOQtO
         eqXKXndqL7zZr8/bgFqvuDblNLM6rSUdFCPr/QBdKztmBk8Eo5sJmf15LVD1/6V38+q+
         Py9NteWctjsJUgcrXTrc5TSBfFrC+2p6/02MPdJyog1AJfq3yIMCUOgyKK72LrZHGnIP
         mXs4LA+4LLxN+/NAVV3B8Sus1j4sKuTiI0WMKf1Wjd0UjL3KOeuv9hZLPL1lpd0wdmnf
         rTTw==
X-Forwarded-Encrypted: i=1; AJvYcCWZaPOU/DVb0kS7xQQZ3zhiD4GycJ8w6bIsNZBtK6n4dfE6sgKqJSjbjuZzMauuiFtyMS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDooVo3Tu1gU9+XHY4QI3kTBl6FatCuEymG5Y/uS67EiU+7eh0
	nUJvH7Fo460r4S6UeDWotnPg3Bd1GdkEClYsCXNUdI8AyI2SSCKVxsWtrUuNNVaazozQpL2dUwj
	vbLAJzcYw+ALMUHbr2HGA7o8RCFaj7hX1x1uHU3Zg
X-Gm-Gg: AZuq6aKuOMRM/7v2ZJuo/nBIqs+KD+CqbWQAtoGR0zhZUMAJtDvgZ0dui3TQ22kmVTg
	n4LptYZMLBC7Ew7PxX12NuAwVF5ezX7+rBr5LIEVH4z+j1AYEfbLfyuDtRwJa5z2z9gmDB99o9S
	F9NZ3LzqVePt09T+6569Mo/YO5A1tMW9q6h4e4B2TuPHnyaWwKnDHhlGu3bk6Hgy2xiY0SNe5tw
	Fz7P86eUV2emxmYHpFufHeiLjKf8WWfAMlZcEuQKsfcep5Jk8w3MAwkCyD73VrePPe/o/D2ZBsa
	mUquviKEEd5Vy1zr9FpcuG8SBk+nEOHfTWl1AywcXGmXK9pzv7mYS2NhceX5z+bG8YxoXJKl
X-Received: by 2002:a05:7022:aa3:b0:11a:2f10:fa46 with SMTP id
 a92af1059eb24-1272f6ae25cmr375464c88.0.1770848590968; Wed, 11 Feb 2026
 14:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
 <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
 <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com>
 <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com> <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com>
In-Reply-To: <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 11 Feb 2026 14:22:59 -0800
X-Gm-Features: AZwV_QiPNieHzWYGG_TDs6__svEWgiAeY4tKhfKEKpnfCSRcmQuqSC54pxDgLH8
Message-ID: <CAAVpQUC8Xx2aGsqzOeBnevzytEPTqUJQkyxsWbX8tqCoERx1qA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Reject access to unix_sk(sk)->peer.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 1:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 10, 2026 at 8:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> > > >
> > > > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@=
google.com> wrote:
> > > > > >
> > > > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > > > > bpf_skc_to_unix_sock(). [0]
> > > > > >
> > > > > > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(=
),
> > > > > > but there are many functions where bpf prog can access the fiel=
d
> > > > > > locklessly via fentry/fexit.
> > > > > >
> > > > > > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > > > > > the last refcnt of the peer sk while a bpf prog is accessing it=
,
> > > > > > resulting in use-after-free.
> > > > > >
> > > > > > Another problematic scenario is that unix_sk(sk)->peer could
> > > > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > > > >
> > > > > > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > > > > > by marking the pointer with PTR_UNTRUSTED.
> > > > > >
> > > > > > If needed, we could add a new helper later that uses unix_peer_=
get()
> > > > > > and requires bpf_sk_release().
> > > > > >
> > > > > > [0]:
> > > > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0x=
b0
> > > > > > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > > > > > Call Trace:
> > > > > >  dump_stack_lvl+0x5d/0x80
> > > > > >  print_report+0x170/0x4f3
> > > > > >  kasan_report+0xe1/0x180
> > > > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > > > >  bpf_trampoline_6442564662+0x47/0xab
> > > > > >  unix_shutdown+0x9/0x880
> > > > > >  __sys_shutdown+0xe1/0x160
> > > > > >  __x64_sys_shutdown+0x52/0x90
> > > > > >  do_syscall_64+0x6b/0x3a0
> > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > >
> > > > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > > > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79c=
e6ef6cae0@rbox.co/
> > > > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > ---
> > > > > >  kernel/bpf/verifier.c                         | 18 +++++++++++=
++
> > > > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++=
++++++++
> > > > > >  2 files changed, 43 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > index 3135643d5695..b328a1640c82 100644
> > > > > > --- a/kernel/bpf/verifier.c
> > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf=
_map *map, int off, int size, u64 *val,
> > > > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __s=
afe_rcu_or_null)
> > > > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_=
trusted)
> > > > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type,=
 __safe_trusted_or_null)
> > > > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __saf=
e_untrusted)
> > > > > >
> > > > > >  /*
> > > > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_=
area_struct) {
> > > > > >         struct file *vm_file;
> > > > > >  };
> > > > > >
> > > > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > > > +       struct sock *peer;
> > > > > > +};
> > > > > > +
> > > > >
> > > > > That's just one out of many. It's not really a fix,
> > > > > but a bandaid for one case.
> > > >
> > > > Right, this is only one example where a pointer lifetime
> > > > does not match with bpf prog.
> > > >
> > > > > We discussed it in the past and the only way forward is to make
> > > > > helpers only accept trusted args.
> > > > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > > > We should do the same for helpers.
> > > >
> > > > What about just reading an untrusted pointer ?
> > >
> > > What do you mean 'untrusted' ?
> > > There are 3 types of ptr_to_btf_id:
> > > trusted, untrusted, legacy (without either trusted or untrusted flags=
).
> >
> > Ah sorry, I used 'untrusted' since the pointer is not always
> > valid, but I think legacy is the one I meant in this case.
> >
> >
> > >
> > > kfuncs now accept only trusted, while helpers still accept
> > > trusted and legacy. The legacy should be disallowed.
> > > That might break some bpf programs, so it has to be done carefully.
> > >
> > > > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > > > could optimise out branches that always return 0.
> > > >
> > > > Currently, this passes the verifier and can trigger UAF.
> > > >
> > > > u =3D bpf_skc_to_unix_sock(sock->sk);
> > > > if (!u || !u->peer)
> > > >     return 0;
> > > > if (u->peer->__sk_common.skc_family) # unsafe access
> > > >     return 0;
> > >
> > > No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_mem
> > > treatment. So above works and won't crash the kernel.
> > > It's effectively inlined probe_read_kernel.
> >
> > Yes, it doesn't crash.
> >
> > I was just unsure about the bpf expectation [0] like how we
> > should treat KASAN use-after-free report by bpf prog reading
> > a pointer whose lifetime is not guaranteed by bpf helper/verifier.
> >
> > So, if this is WAI, I'm fine with that.
> >
> > [0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+S=
pHBGqKcUT0iMA@mail.gmail.com/
>
> That's different. That's the actual UAF inside bpf_skc_to_unix_sock().
> That needs to be fixed with what I described above by allowing
> only trusted pointers into helpers.

I got this point.

> In my earlier reply I meant that:
> if (u->peer->__sk_common.skc_family) # unsafe access
> is fine. It's safe access, because it's sanitized by the verifier/JIT.

but I'm a bit confused here..

Even though the verifier makes sure the pointer is not NULL,
u->peer can be freed concurrently by another thread,
then how can verifier/JIT prevent UAF ?

Or can this be still called 'safe access' regardless of runtime UAF
because the user-provided bpf prog was verified once and not in-tree
kernel code ?


> The code inside helpers is a normal kernel code,
> so kfuncs/helpers should only accept trusted pointers.
