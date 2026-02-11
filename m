Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD07346AC0
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849568; cv=pass; b=TKQBSysuNFE3V3DQhHEpEJ+2IxXCetzmNrX9an/HYtNveFIPIf+1DykJfqda8H+GroCZvsgdXN5QOpRX7xSV9cXcaBuQTUoVTnsNV9QhiUL3l4rTHkCXG2OHNaV4XmsshjVro5Sw+HoYGbCDeVJ0qmEQd3X002mXGmnuADg8uUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849568; c=relaxed/simple;
	bh=ygfV75Xo94JB86PUxabdo20IGfrJlF+2SR59V/gjj04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fussNMkdqTCgV8qVe7vlYml1BNYygqicgEIO0QZRbm63//fP4/7JmMQnPyb9B30V/WlsUg2Zn9sb6E6zlxXGVu1ohseukn1ayWjuRmZoaah0uWZrIBNDikn65UIS16X8HPp1nWhA/cB94Bf/DESWGER7GwnAD50f2lmnwcA6Tyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOuFpfr0; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOuFpfr0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3828477f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:39:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770849565; cv=none;
        d=google.com; s=arc-20240605;
        b=CInShY2XpQQHtkRkfyIZnIf06ZShcnHqVZNJJHT5vAznrvLsPjkHZb3oXkQf3NUEfa
         nivMd9xJ3RVckhWeqnYMkB9nn1z0wq2E13Kpd1w9Y7WiWkr09GJ9AC+ot0/sX9XCsYdL
         X15Z/01Mne1M6P96ZFoYb1qIYVoKlvWvJIpdn7pWq8HhOHHUve6gH88CSreOD1Us/kW+
         st3PGAbMPRRH5wLi9f0F7hKxJtF6n5uUHT6aD2iZ1JfH2bATYSHFBhk2lPu2KfzcKgKW
         7zH1k2fBifhDBDVHle3GwGFWEQv17wLpcJPos/1xgj5cjqK4Pn0vu09mo14/R1OAb6gt
         k15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ie0ERPPIZTClxSgIdjeialdCdod0tEwIsqpMmpbBJTA=;
        fh=Paj6wpe41O29xR912U967KrevxlLU3oGHxGKHUaul0o=;
        b=e0wk1xa8ACUENXRN/5GakH8+Sw9abrePGo3fmXhN1OvJ4G9l+KLyxNGhn8HBm00AUO
         XLZvVlBdFIXWbbdInjqcTCp0Tr3HA78RKonOrLsXMlc4PpbgjSRMP1q7DFcHhawdiuAu
         qZcNq1XXB+Pdk/B6CaBNb/GkQZfW6bGZsxOZA5EKYWE24eGik2H9JLR+qH4hNzWM4wP6
         gonUc86SiU+pL7K5U2m3OuO53o955xZmDB6Gu9oFrjf3AvDwevVSq9KY4QcYcGJfwJL3
         9MbmM5tu6HBXS8Hpu4VzKCmjCN0SoHa13Y7bUrTujuuQjyCM8tJZFV7kVo5ysohPk9k5
         lD3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770849565; x=1771454365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie0ERPPIZTClxSgIdjeialdCdod0tEwIsqpMmpbBJTA=;
        b=dOuFpfr0EDjigFHkBr32CCFWtrwEe5uZ1+ieTVEZiykTqePKo5rnWCpDmyWY9sWOyR
         YNnuagSLgCuVvNFQHZi0VTdig8/qsxdemMQ1tOIHPRlUhUXdwy4IwIHBrFnidQBg+Liv
         QM7RbukKr2YwYBSd9Pn/BSMc1aS77wQClg0RW3X4szh46d5UQ2hGWbn5g2HjY3Y/0Gad
         VJFVUHbV9ZnEr4wRybCjNa0BdLTQaBZ8DzV2Iv91MICse/PelUX2o3iSiavJBvhdAikI
         GgLMTykgy1x5iiRA3oB7pj2QgoeLLpcA+G4TWAFkeMBLC4zb/jin+6dVFRKzPpJrYV9E
         A0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770849565; x=1771454365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ie0ERPPIZTClxSgIdjeialdCdod0tEwIsqpMmpbBJTA=;
        b=oSS+Xfk/QEViKbeR8eINcShulEZnJf8rkL5agsakhI/lREQ6Atf6tqfgkyjUs/FnFv
         9KLiFgu78gcJYStFSGKiGrnhNJAYQnF97HNRIFFXPJ3kPQICgu6kQ8KweeXBe+HsdSLr
         hjpITDUqouI2K7Ade16svDNceV7HJVSB23IgtNbaJvM+kMGkVDoTm+1cyd1oH+YrYUcV
         VNTg1kY7Vzm0nhVYMV0DR/1TARyXfkKFdPw4cdmiMy3i1AuA4B20xyMiQKJD/Y5q+KlD
         0vD4/2SscRxHDAdHrZ55pxIz2aOvui4vhZUo661auw9+TKceGJR0T0jHJ0rSuEkxMSRK
         GOAg==
X-Forwarded-Encrypted: i=1; AJvYcCVERRhqU6Sj6DFO4WaoK8ZhXOHU0HRhZ4CiG2P/WjZUJIZ9Tuloa/6Xk8cp8xlM/yLDwCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEI9w+dKUXWukXsbvOJ8ZgoBiau06ki9EMPuPZQtX79Bzk2X6D
	/bWeL02Qs8LQAv9zZoKsac4rAW7805MsL+UO6N3vYDtfzcKM0cXYORMt2PEXf88gNnY7OvHS8Ki
	BWgdcO054d3TxsOJppsI1YwLDr6FFQpU=
X-Gm-Gg: AZuq6aKusuwTajuUbn0RI+0BU2hXfJyHrYwoia0QYowrBC42LHLjvtN1AnmjCt4ZL2K
	VjWUu9M2fECeBdFzvGYdiCmF+PVY103LGLKB6ZVRl0u+SLx677KePYu2JfZm6CiiVxvXDglbBIq
	4wnCr7t0FVA3wzheTN5z/GOQa5Az8wL2FMFCdif53W32vojGdgkgGk6aj3SCvVW1WRusKeXkdIA
	Z57lf+ExC5ozVtYHtTAp99JNDCdCW3M8oHDXAfuo/NDIEEevSklYh7qn97UL3iXQ1XZHpZLzLEe
	brr8Zibv5IJsdpxVLnHsOrrB8mvO5w1ReOdv+/8sZMHELkUYN2TP1Ry/Mexw1MIIa6wLobCU2Wo
	j/FCKMideC2a7Trh7WMp5RVBkog==
X-Received: by 2002:a05:6000:1acb:b0:437:681e:cbc3 with SMTP id
 ffacd0b85a97d-4378ac92470mr1509564f8f.13.1770849565325; Wed, 11 Feb 2026
 14:39:25 -0800 (PST)
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
 <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com>
 <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com> <CAAVpQUC8Xx2aGsqzOeBnevzytEPTqUJQkyxsWbX8tqCoERx1qA@mail.gmail.com>
In-Reply-To: <CAAVpQUC8Xx2aGsqzOeBnevzytEPTqUJQkyxsWbX8tqCoERx1qA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 14:39:14 -0800
X-Gm-Features: AZwV_Qik4ZkumFKH9So-dw-55ZcCvj-mt-W4k4Qqq-_Jj3P-XFC8XKCbt20EFA0
Message-ID: <CAADnVQLBWUyrp5n_mPJFnOAx1kMnZjJR5nTL_8UL-8KLE+DnbA@mail.gmail.com>
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

On Wed, Feb 11, 2026 at 2:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Feb 11, 2026 at 1:26=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Feb 10, 2026 at 8:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@go=
ogle.com> wrote:
> > > > >
> > > > > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniy=
u@google.com> wrote:
> > > > > > >
> > > > > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > > > > > bpf_skc_to_unix_sock(). [0]
> > > > > > >
> > > > > > > Accessing unix_sk(sk)->peer is safe only under unix_state_loc=
k(),
> > > > > > > but there are many functions where bpf prog can access the fi=
eld
> > > > > > > locklessly via fentry/fexit.
> > > > > > >
> > > > > > > unix_dgram_connect() could clear unix_sk(sk)->peer and releas=
e
> > > > > > > the last refcnt of the peer sk while a bpf prog is accessing =
it,
> > > > > > > resulting in use-after-free.
> > > > > > >
> > > > > > > Another problematic scenario is that unix_sk(sk)->peer could
> > > > > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > > > > >
> > > > > > > To avoid such issues, let's reject access to unix_sk(sk)->pee=
r
> > > > > > > by marking the pointer with PTR_UNTRUSTED.
> > > > > > >
> > > > > > > If needed, we could add a new helper later that uses unix_pee=
r_get()
> > > > > > > and requires bpf_sk_release().
> > > > > > >
> > > > > > > [0]:
> > > > > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/=
0xb0
> > > > > > > Read of size 2 at addr ffff888147d38890 by task test_progs/24=
95
> > > > > > > Call Trace:
> > > > > > >  dump_stack_lvl+0x5d/0x80
> > > > > > >  print_report+0x170/0x4f3
> > > > > > >  kasan_report+0xe1/0x180
> > > > > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > > > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > > > > >  bpf_trampoline_6442564662+0x47/0xab
> > > > > > >  unix_shutdown+0x9/0x880
> > > > > > >  __sys_shutdown+0xe1/0x160
> > > > > > >  __x64_sys_shutdown+0x52/0x90
> > > > > > >  do_syscall_64+0x6b/0x3a0
> > > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > >
> > > > > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper"=
)
> > > > > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-7=
9ce6ef6cae0@rbox.co/
> > > > > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > > ---
> > > > > > >  kernel/bpf/verifier.c                         | 18 +++++++++=
++++
> > > > > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++=
++++++++++
> > > > > > >  2 files changed, 43 insertions(+)
> > > > > > >
> > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > index 3135643d5695..b328a1640c82 100644
> > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct b=
pf_map *map, int off, int size, u64 *val,
> > > > > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, _=
_safe_rcu_or_null)
> > > > > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __saf=
e_trusted)
> > > > > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__typ=
e, __safe_trusted_or_null)
> > > > > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __s=
afe_untrusted)
> > > > > > >
> > > > > > >  /*
> > > > > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct v=
m_area_struct) {
> > > > > > >         struct file *vm_file;
> > > > > > >  };
> > > > > > >
> > > > > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > > > > +       struct sock *peer;
> > > > > > > +};
> > > > > > > +
> > > > > >
> > > > > > That's just one out of many. It's not really a fix,
> > > > > > but a bandaid for one case.
> > > > >
> > > > > Right, this is only one example where a pointer lifetime
> > > > > does not match with bpf prog.
> > > > >
> > > > > > We discussed it in the past and the only way forward is to make
> > > > > > helpers only accept trusted args.
> > > > > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > > > > We should do the same for helpers.
> > > > >
> > > > > What about just reading an untrusted pointer ?
> > > >
> > > > What do you mean 'untrusted' ?
> > > > There are 3 types of ptr_to_btf_id:
> > > > trusted, untrusted, legacy (without either trusted or untrusted fla=
gs).
> > >
> > > Ah sorry, I used 'untrusted' since the pointer is not always
> > > valid, but I think legacy is the one I meant in this case.
> > >
> > >
> > > >
> > > > kfuncs now accept only trusted, while helpers still accept
> > > > trusted and legacy. The legacy should be disallowed.
> > > > That might break some bpf programs, so it has to be done carefully.
> > > >
> > > > > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > > > > could optimise out branches that always return 0.
> > > > >
> > > > > Currently, this passes the verifier and can trigger UAF.
> > > > >
> > > > > u =3D bpf_skc_to_unix_sock(sock->sk);
> > > > > if (!u || !u->peer)
> > > > >     return 0;
> > > > > if (u->peer->__sk_common.skc_family) # unsafe access
> > > > >     return 0;
> > > >
> > > > No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_me=
m
> > > > treatment. So above works and won't crash the kernel.
> > > > It's effectively inlined probe_read_kernel.
> > >
> > > Yes, it doesn't crash.
> > >
> > > I was just unsure about the bpf expectation [0] like how we
> > > should treat KASAN use-after-free report by bpf prog reading
> > > a pointer whose lifetime is not guaranteed by bpf helper/verifier.
> > >
> > > So, if this is WAI, I'm fine with that.
> > >
> > > [0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP=
+SpHBGqKcUT0iMA@mail.gmail.com/
> >
> > That's different. That's the actual UAF inside bpf_skc_to_unix_sock().
> > That needs to be fixed with what I described above by allowing
> > only trusted pointers into helpers.
>
> I got this point.
>
> > In my earlier reply I meant that:
> > if (u->peer->__sk_common.skc_family) # unsafe access
> > is fine. It's safe access, because it's sanitized by the verifier/JIT.
>
> but I'm a bit confused here..
>
> Even though the verifier makes sure the pointer is not NULL,
> u->peer can be freed concurrently by another thread,
> then how can verifier/JIT prevent UAF ?
>
> Or can this be still called 'safe access' regardless of runtime UAF
> because the user-provided bpf prog was verified once and not in-tree
> kernel code ?

The verifier/JIT are not preventing UAF. They're preventing crashes.
u->peer->__sk_common.skc_family is equivalent to two
copy_from_kernel_nofault(). They may read garbage, but won't crash
and won't cause any ill kernel effects. It's up to the program
to use the values in a sane way.
