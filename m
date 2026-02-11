Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D12FFF94
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770850905; cv=pass; b=jJ5lkvEsu2vuhFW3CtnKkNA4nAnyYZbVRAH7NsWzi4832O7Fb6woNJ2WvR6kBHO8R8KMetSqr8OgiRpZa4rosf+yh+72AuEgclgWNQ+1Jsshvtu/H67jcvTbN+DlZWpxOpvB2z61JTiGadzLRsm10p04vYEF9gQgkj/dhwz4rIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770850905; c=relaxed/simple;
	bh=1udlOiyE/Ppx2kNUZ2ygSNvFIXtyAU8H42LORwBeYA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyt/OANfJIIscSS8FgYPWQOc2dvPI9n1inmGBH0VeZaAjITmEDeU//pklqPZ67q7DD09HG+4Hfbay1M7Ya/RQKBoUl+PsjNHqW3FeWh5vqdxAL7r5Mm2YHGi+7DEWWj9AhAz17EZHrL9NGEfqP2C6r2u407CiKRkoNV+bqqcwtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTT1eM9x; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTT1eM9x"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12336c0a8b6so84482c88.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 15:01:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770850902; cv=none;
        d=google.com; s=arc-20240605;
        b=F8p5kaBY7o5Ie54VlwyNmtxknHLsa/A/8rx7SVWW2k+qJAk1gU3E3vUCOrOFWa0WI1
         DXhoYJv1mBrKshIqO0iDnGwdux5UrlxuHD7X/P84Wj3gsxKjkpVqO/ocT0xDgEj0WUBy
         jRzNe8xH1jKAWEnmtgQFXI7+d/tOK7t4A2rIf/nkhL+PJsVxQmER3ceoTOvv0oOy0FOH
         9bVXQ4gNrF+EQIgtloFfWZn1aZjnU+C4qiypdZ9lp1oYRBkupJx6LjTyk/ZDGcttoOMC
         rM272XN2SpdHHxbJZvbb2YTWH5rok/vPQZUFb+DViHYus7jKbVjqN1wMNb2a1dMTf2bg
         QmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E6m9F/dx48LqXuQRNg/m8pIzXhJQNC52svY/pA72kE0=;
        fh=aWuMTHW6IHu/PIiYSGswYQRUXAqIgEvISs3q1asaq/M=;
        b=EkMaFykvB5zJR7t2z67MTyAWBwIkoGRkVg+wUConfChtueNui1Fv+IZjSkBi9k/VdD
         7A+9AVGyFJtT0MISZibjDBC+ODFEHfPtryZzolma4Rowy8hiuXwaAvh85GMBMncuKTth
         cmKisIIxzhzY6fv+jADJgmXYi3ryY0y7xw5GUVHRvsg3w/Nlq/2IvryBTsLalOjS4UcO
         +6QTKZYhNqQIEw9QM2FpENLnw5vqHWe/CIePYd8toebG336AgMRL6YnAbUWmxWtUBP7n
         YmUh9Oe2IQ9n1UlVeab5WtrwgOUlktDjAZbXpZ3nrG//oPcKr5kWPLtm+RBcyj+d/oWM
         ZUxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770850902; x=1771455702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6m9F/dx48LqXuQRNg/m8pIzXhJQNC52svY/pA72kE0=;
        b=GTT1eM9xyOI64gbEHWAlGC13XWHAh4jaXcswlafdvjtpF2qw17YtHOTIzlUFJhPQp5
         5M5AGUJDFXaxpl3W7BFEbVTcm+urUlLa2RbxKKGhmMCuE8mU9IOC4hxFQq/icQ0vkAz3
         S+AGutSSCi7VwvmIraNVs60FJheykGfbR0AndRnneUshbYxxgG3MHowcsTZpl5yDtl8C
         CrkSXOj/gz3L0SxdGmhh+5pcqTizWFPDDh3dhvw2wZV8mUxOC+g/X1jPIAywZ5WfZ2ML
         zhKl5GYYfmtajoQf/ArRyeq4XOpMwE9+fAyR5P1W5EWhZR9bTtf0xSRBU2Re4eFGevZe
         +PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770850902; x=1771455702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E6m9F/dx48LqXuQRNg/m8pIzXhJQNC52svY/pA72kE0=;
        b=iS9FDvCFEND7L5JEKbvakNFotFsmfXOwOwsajPdoD9aFpEbWc1pzmo7fFeriTNODG8
         tH+53LQza6wE/NdgPSz/ZpeormvT7+0dZID2tEvr7BO/mjyOs+ES+432lCCIPwRX97zu
         PBG+w9cxlzULEh47l9TYF4JPq+U5rQ8a7dV2Mam6XSCO1/79Q1oyslJrgx7mpyb1FXuB
         1zLVrEvLewH148sQBaL19XQdX665BcUP0VTQ84iBgaxcwsZGiL/P3sZ46VyjYnAWIt8J
         Owk9hEphugDcFnMJxaoq9RPwvgqyphAiEn/5tGkY/+iRzjisVQC3l8IE6BLAJBQwnm4Y
         MSvA==
X-Forwarded-Encrypted: i=1; AJvYcCXXPnJe1C5Cgk8uf/naARt3qAl1MuyoHtB9IGhgqbotq3GKHqlLDCZJJ6sTJBpcvoWBTAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsk8E1MgLydKII6/Vt8ygNlpbYBgm1ufl3RUkPF3+iKwyuULyc
	BQoVIKDOlMJVhii6FGKlfFvTPL3nlR1St6umegox+wHaPQN/kMCIZbIzMFsnGwgoeI2vszRuHJf
	C1Mmg9Sy78WnBOoPHSim7SrpOy0aQq9w9ddPq41on
X-Gm-Gg: AZuq6aIDoArrKMrt4mhrrkxG2z+h6aqUksU/1mmyEJeRFdlX1oewlJPdUJ/pEBkth8G
	3oWCp7tg2zq2k5LQheGix/eFe7M8XaZWXiRzUwKFUEAWEsA3H9SrO79cM4IxPlWlSP0O3pyvRUJ
	hIc1q3ertd04dE0i8dPA0lWcUWNDe8v1FymWSIgAuLlrec9yk+mw2/zQYG8DZisS2bDoTUYKepg
	wXZccoYqZ7WiTzDnYLmqjd+uhe49mWfWBXLxAF/E6xhk+DyzzeSxyYGjvytrRunri6TxiHvGcR3
	cv8wY/3z39BDptQzgbfsqNAooPqYm6EpvJpjWgi16z7u/gQPHIY5nn6FdZ5H8y0ZQ99S4/pj
X-Received: by 2002:a05:7022:61a1:b0:11b:9386:a3cb with SMTP id
 a92af1059eb24-1272f79d964mr331465c88.44.1770850901221; Wed, 11 Feb 2026
 15:01:41 -0800 (PST)
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
 <CAADnVQK8_P9x7HoKb0GxH1dSSnMFDsSgoV04MSkhcUPFw2uViA@mail.gmail.com>
 <CAAVpQUC8Xx2aGsqzOeBnevzytEPTqUJQkyxsWbX8tqCoERx1qA@mail.gmail.com> <CAADnVQLBWUyrp5n_mPJFnOAx1kMnZjJR5nTL_8UL-8KLE+DnbA@mail.gmail.com>
In-Reply-To: <CAADnVQLBWUyrp5n_mPJFnOAx1kMnZjJR5nTL_8UL-8KLE+DnbA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 11 Feb 2026 15:01:29 -0800
X-Gm-Features: AZwV_QhvnyTfpo7ZeXE5tz6CWfHDm_tDg0QmL3FSO5v1u6Lfo4ma72i6m6j-1Io
Message-ID: <CAAVpQUB5mGbD79ZLVCi0G8UDpwjQW15=BV9maB6ikLzCYTjA0A@mail.gmail.com>
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

On Wed, Feb 11, 2026 at 2:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 11, 2026 at 2:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Wed, Feb 11, 2026 at 1:26=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Feb 10, 2026 at 8:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > > >
> > > > On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@=
google.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kun=
iyu@google.com> wrote:
> > > > > > > >
> > > > > > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer =
by
> > > > > > > > bpf_skc_to_unix_sock(). [0]
> > > > > > > >
> > > > > > > > Accessing unix_sk(sk)->peer is safe only under unix_state_l=
ock(),
> > > > > > > > but there are many functions where bpf prog can access the =
field
> > > > > > > > locklessly via fentry/fexit.
> > > > > > > >
> > > > > > > > unix_dgram_connect() could clear unix_sk(sk)->peer and rele=
ase
> > > > > > > > the last refcnt of the peer sk while a bpf prog is accessin=
g it,
> > > > > > > > resulting in use-after-free.
> > > > > > > >
> > > > > > > > Another problematic scenario is that unix_sk(sk)->peer coul=
d
> > > > > > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > > > > > >
> > > > > > > > To avoid such issues, let's reject access to unix_sk(sk)->p=
eer
> > > > > > > > by marking the pointer with PTR_UNTRUSTED.
> > > > > > > >
> > > > > > > > If needed, we could add a new helper later that uses unix_p=
eer_get()
> > > > > > > > and requires bpf_sk_release().
> > > > > > > >
> > > > > > > > [0]:
> > > > > > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa=
4/0xb0
> > > > > > > > Read of size 2 at addr ffff888147d38890 by task test_progs/=
2495
> > > > > > > > Call Trace:
> > > > > > > >  dump_stack_lvl+0x5d/0x80
> > > > > > > >  print_report+0x170/0x4f3
> > > > > > > >  kasan_report+0xe1/0x180
> > > > > > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > > > > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > > > > > >  bpf_trampoline_6442564662+0x47/0xab
> > > > > > > >  unix_shutdown+0x9/0x880
> > > > > > > >  __sys_shutdown+0xe1/0x160
> > > > > > > >  __x64_sys_shutdown+0x52/0x90
> > > > > > > >  do_syscall_64+0x6b/0x3a0
> > > > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > > >
> > > > > > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helpe=
r")
> > > > > > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > > > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767=
-79ce6ef6cae0@rbox.co/
> > > > > > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > > > ---
> > > > > > > >  kernel/bpf/verifier.c                         | 18 +++++++=
++++++
> > > > > > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++=
++++++++++++
> > > > > > > >  2 files changed, 43 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > > index 3135643d5695..b328a1640c82 100644
> > > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct=
 bpf_map *map, int off, int size, u64 *val,
> > > > > > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type,=
 __safe_rcu_or_null)
> > > > > > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __s=
afe_trusted)
> > > > > > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__t=
ype, __safe_trusted_or_null)
> > > > > > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, _=
_safe_untrusted)
> > > > > > > >
> > > > > > > >  /*
> > > > > > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > > > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct=
 vm_area_struct) {
> > > > > > > >         struct file *vm_file;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > > > > > +       struct sock *peer;
> > > > > > > > +};
> > > > > > > > +
> > > > > > >
> > > > > > > That's just one out of many. It's not really a fix,
> > > > > > > but a bandaid for one case.
> > > > > >
> > > > > > Right, this is only one example where a pointer lifetime
> > > > > > does not match with bpf prog.
> > > > > >
> > > > > > > We discussed it in the past and the only way forward is to ma=
ke
> > > > > > > helpers only accept trusted args.
> > > > > > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > > > > > We should do the same for helpers.
> > > > > >
> > > > > > What about just reading an untrusted pointer ?
> > > > >
> > > > > What do you mean 'untrusted' ?
> > > > > There are 3 types of ptr_to_btf_id:
> > > > > trusted, untrusted, legacy (without either trusted or untrusted f=
lags).
> > > >
> > > > Ah sorry, I used 'untrusted' since the pointer is not always
> > > > valid, but I think legacy is the one I meant in this case.
> > > >
> > > >
> > > > >
> > > > > kfuncs now accept only trusted, while helpers still accept
> > > > > trusted and legacy. The legacy should be disallowed.
> > > > > That might break some bpf programs, so it has to be done carefull=
y.
> > > > >
> > > > > > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > > > > > could optimise out branches that always return 0.
> > > > > >
> > > > > > Currently, this passes the verifier and can trigger UAF.
> > > > > >
> > > > > > u =3D bpf_skc_to_unix_sock(sock->sk);
> > > > > > if (!u || !u->peer)
> > > > > >     return 0;
> > > > > > if (u->peer->__sk_common.skc_family) # unsafe access
> > > > > >     return 0;
> > > > >
> > > > > No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_=
mem
> > > > > treatment. So above works and won't crash the kernel.
> > > > > It's effectively inlined probe_read_kernel.
> > > >
> > > > Yes, it doesn't crash.
> > > >
> > > > I was just unsure about the bpf expectation [0] like how we
> > > > should treat KASAN use-after-free report by bpf prog reading
> > > > a pointer whose lifetime is not guaranteed by bpf helper/verifier.
> > > >
> > > > So, if this is WAI, I'm fine with that.
> > > >
> > > > [0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2Rb=
LP+SpHBGqKcUT0iMA@mail.gmail.com/
> > >
> > > That's different. That's the actual UAF inside bpf_skc_to_unix_sock()=
.
> > > That needs to be fixed with what I described above by allowing
> > > only trusted pointers into helpers.
> >
> > I got this point.
> >
> > > In my earlier reply I meant that:
> > > if (u->peer->__sk_common.skc_family) # unsafe access
> > > is fine. It's safe access, because it's sanitized by the verifier/JIT=
.
> >
> > but I'm a bit confused here..
> >
> > Even though the verifier makes sure the pointer is not NULL,
> > u->peer can be freed concurrently by another thread,
> > then how can verifier/JIT prevent UAF ?
> >
> > Or can this be still called 'safe access' regardless of runtime UAF
> > because the user-provided bpf prog was verified once and not in-tree
> > kernel code ?
>
> The verifier/JIT are not preventing UAF. They're preventing crashes.
> u->peer->__sk_common.skc_family is equivalent to two
> copy_from_kernel_nofault(). They may read garbage, but won't crash
> and won't cause any ill kernel effects. It's up to the program
> to use the values in a sane way.

I see, that's fair.  Thanks for explaining !
