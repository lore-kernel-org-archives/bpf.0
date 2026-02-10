Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3401662E7
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686376; cv=pass; b=MHKwR6vMY53QfsLmEIL8VQBAa2tGeOK8GbVIXJGvHT/HFlVDAgNB38nQm5qDPCxYgmNiuuQ+esEFE42ajWWIQKTwj+VgnOP0zj45N80034/BV/j7RnQJVA/VuTbti5i1T1uuzVOUMGHWaXgA+wiD4d9pkX78pYxfOSHO+AQMICQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686376; c=relaxed/simple;
	bh=M/xjaQ6usPof+auHUm3FeiVUCsdGjUqeSjPcTpKz7CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f69o+qjYdZWxCPJtT0CsZK4hEDYfEWqwlgElbXqrJDpx6D3BVfwOMXeWedKrzHwaC03S5mVjDzVuf4SwKTe1NptpeyDw/gC7uGgXgg9qzMFe9JVnEL1CJc9Kze4ErNwWyoSK81RaHbIMfqjJZQHnrlgPf8wfvRCOm7alfiMd2eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnvDiHUG; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnvDiHUG"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-124899ee9d3so3391231c88.0
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 17:19:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770686373; cv=none;
        d=google.com; s=arc-20240605;
        b=lAbgalYk2dx6MG2LITQv7tWHckigEgvsqVenstgSOXNn0v9INs8w0h5XQqr5HuYycN
         CIm5jURBrbEsSpIakMGwLcye+NR8jVGuSrfbfOdg9Y7GFteo4lz1IXTOuP9PgX91qOkT
         IrkdN0Rgy0iJOC/M+e5joBvBQKNuyM3clcXZBt0/SdNIYE0/fRlVwC07Mws19V6zHimC
         d5PK+wGvxfEGgJs8BRi1ATvXoDCnB0BGBuRNQW2WoXSdXAzsw0A8Bh40Ygzps0FonGK4
         0dCHcRDt8MMtqzTJqiVWWD2dlUwNHbR72yItyXmkuFVAA474e7FZHpZ0PYhcquS46vgE
         BV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMJkgYkbFLkRcuf35gty1YVid2onGGqHzqxh822jpMQ=;
        fh=fxudkUkEIovw6KiG9lw6nlcGV2awmDLJphacRtOQx1U=;
        b=fd0OLA++AJ7lywgw2aXgLYAco6IP9R5q1A2+PssD5mv8fF91T4A7eWP862n1I0Oftn
         61fILxZsJ6hCqa7VGJp+j+jNgkZSCuBnDiN0TmHkbknEwgMo+X3cCdohRk4HhMot3etm
         esqKDt/OwvZwYWF+BMsaslvgNO6sFMJ87vTHfhJVlpYEP9meBAUXI3DzBqalQgvITeL1
         I60/TtXs012LNZF7WEteoPVTalWTcATTSLnciC02wlUwH/TUITv3UbaSWWzEt58iJ43W
         /QlArLvNf43BuYJwaVprD5wTQ1d2sj4RXuKrqjLN4R6ibGChu5Zq++P7aV8TGPTJzQip
         huAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770686373; x=1771291173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMJkgYkbFLkRcuf35gty1YVid2onGGqHzqxh822jpMQ=;
        b=EnvDiHUGIba0mD37PhWZz6SjAt0K6t/jx3LSgxomzAFxzmNJvRsSPYHl87K0AjWZZL
         WZ2kmwknDv1vO04q8Ce3tAhAgpn5lfohaw09OVWqVA12Qrenv+I/GVvbvilG42Fms+kb
         X2HYE+I2hxRwa/DvI28b7jxD3VFJzIsKPO7svJwfDxZUfbzd4elYx5DONajlMj6tXOkp
         xxaWU7lUJsW1gN9DP2de7jZ4+upQ54irbL4xVluhxk8Ef0wFuI1wi+i0DcbnwGL3Picy
         pZDYc1wlt3OwCguv2Y45qZbcZI+aUal6Ujmek+S65QKCqy2ITxr/XPf6znJejzpICESj
         GpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770686373; x=1771291173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMJkgYkbFLkRcuf35gty1YVid2onGGqHzqxh822jpMQ=;
        b=B/MGpWBk8YetndEmCYRzzJAsgXbggdE5DvPDPzCGWsvXFpWIlTmRD0wdZykzmQceyc
         7szgf43UZgnXRrih5ZDeN0Av4Vo5Ikt1OzAqZtkZPV5ty/DpPXjX7dZfkTlsVK03mAL6
         hI2C5Wy/bsk8vfQy8k2PVvGKo/qQqY4rzFOmkeqrCHp9g6ltRqHkdDu/BVH5epMatA+Q
         M6p+VfvtzJvbcjA79KQzJO3oLMvzmorP+C1Q/Ec3UCEXEbBPkWLtXkhJAA41YYwxJxhV
         5yifo+BcZakVjUNPmWWEWWBCYZ4nB0juCKgPfGp7LdqxJhE4OQdF9vTk4wSKYho/FkA/
         rNYg==
X-Forwarded-Encrypted: i=1; AJvYcCV66wRk14CM+CeoT8Zg/LXfxcM01ImowJCSjeMqQ7o20wO4zhCBb78Aq3386asHr3kbXso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Sg2sd4P0m/MIAeEConwq47SW8wCJLpae/9bJVkb0uyofPAym
	GV/ZKNrZbEE1ObhSIUWlgy6Jn7bkovYIiBSg0vius9pu4dB1FOaSJ/hBqLKWMCfBNTr+bGe3Bvk
	1mde/6JXL323qkyuoGCz9aeQkP2C1q774tQ2AKKy6
X-Gm-Gg: AZuq6aJn6aK5PdKAY1bhbAqiPmp+vx94io3bqjxDMp3OZt65BBz2SUUouBPt1QTZbN+
	3gIl7UejZarvoyKx7FXu41juScv5eTnhOokT70rlmWtLgZMgcWoAIToQpgaX0XRmKTx17FGN6qN
	z19SdHXhX+3MGS2r9mEivFTXxdqKtIhPdc54Vk80jkCgV6LyUoaNQveosGR2ak1HxnC+eEB/cDB
	6Ic+WBb0SkIbPQOQxmxocPJftogs7AaWeGwq4+Bg1mx6JF+mf/85Qj/ulxg2PpvouSjS2NcizWw
	Xy56ZGTRR9lN/bjMm1htB5rpHJInzeVrsvbe1wafXpmVG6M6RifISF9aVh/sjhJHrPxRFjTN
X-Received: by 2002:a05:7022:4585:b0:127:fa:7758 with SMTP id
 a92af1059eb24-12723ea9f97mr308681c88.9.1770686372889; Mon, 09 Feb 2026
 17:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
In-Reply-To: <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 9 Feb 2026 17:19:21 -0800
X-Gm-Features: AZwV_QgLHU9qq-VTNodmxFHxhk_GHudR0gC0151o-atRLaJy99qtZNSTJExKFRA
Message-ID: <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com>
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

On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > bpf_skc_to_unix_sock(). [0]
> >
> > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> > but there are many functions where bpf prog can access the field
> > locklessly via fentry/fexit.
> >
> > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > the last refcnt of the peer sk while a bpf prog is accessing it,
> > resulting in use-after-free.
> >
> > Another problematic scenario is that unix_sk(sk)->peer could
> > go away while being passed to bpf_setsockopt() in bpf iter.
> >
> > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > by marking the pointer with PTR_UNTRUSTED.
> >
> > If needed, we could add a new helper later that uses unix_peer_get()
> > and requires bpf_sk_release().
> >
> > [0]:
> > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > Call Trace:
> >  dump_stack_lvl+0x5d/0x80
> >  print_report+0x170/0x4f3
> >  kasan_report+0xe1/0x180
> >  bpf_skc_to_unix_sock+0xa4/0xb0
> >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> >  bpf_trampoline_6442564662+0x47/0xab
> >  unix_shutdown+0x9/0x880
> >  __sys_shutdown+0xe1/0x160
> >  __x64_sys_shutdown+0x52/0x90
> >  do_syscall_64+0x6b/0x3a0
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > Reported-by: Michal Luczaj <mhal@rbox.co>
> > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef6cae=
0@rbox.co/
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  kernel/bpf/verifier.c                         | 18 +++++++++++++
> >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++++++
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3135643d5695..b328a1640c82 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map *ma=
p, int off, int size, u64 *val,
> >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_=
or_null)
> >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
> >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __safe_=
trusted_or_null)
> > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_untrus=
ted)
> >
> >  /*
> >   * Allow list few fields as RCU trusted or full trusted.
> > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_str=
uct) {
> >         struct file *vm_file;
> >  };
> >
> > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > +       struct sock *peer;
> > +};
> > +
>
> That's just one out of many. It's not really a fix,
> but a bandaid for one case.

Right, this is only one example where a pointer lifetime
does not match with bpf prog.

> We discussed it in the past and the only way forward is to make
> helpers only accept trusted args.
> Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> We should do the same for helpers.

What about just reading an untrusted pointer ?

I used bpf_skc_to_unix_sock() in selftest in case compiler
could optimise out branches that always return 0.

Currently, this passes the verifier and can trigger UAF.

u =3D bpf_skc_to_unix_sock(sock->sk);
if (!u || !u->peer)
    return 0;
if (u->peer->__sk_common.skc_family) # unsafe access
    return 0;

Thanks
