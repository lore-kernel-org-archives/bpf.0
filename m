Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06A1DF742
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783810; cv=pass; b=Y145KNjLkFE+TnHATinGE4jQU06CqlZsEtTHG+GNqPW7OmxPgUlKQ35Xe7va4FSxxpjiOeEugh9rPmmq4l4sERNNU72yv/Y3RM2/Os9xNwX6Eq+lFnt0Drj+k1AyMKfRvgA8dorxGPtVjQZP9avnmuFw1yssMmRpZhi0UBs9aiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783810; c=relaxed/simple;
	bh=5feqezYq4DtXKK86LxTBwiMMXMb/AYlWKlYvgZI8o5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKNGCFivg9l8oyq7QJTzwIa//l78iyZe2nF36L/Z83FUPM9XPkRfz44+SSdFsXgNo//ctDysGHAz8RRO82fJlwv0XpgR8K8xNdNzxsuXf1g1WMPx4m8tGzWRY8FVsgqYpvtwSfxlL+u6IS6lE4OsTbE5RhgaYJLWOpbV6WCQ8tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hew9ZV54; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hew9ZV54"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1233b953bebso1596690c88.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 20:23:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770783808; cv=none;
        d=google.com; s=arc-20240605;
        b=FMEWZAKDPGr0Vnw5AIgRV+ueEuw5lNM94cS8cZwgkS9EeZsrJp0mjqsqyK98CjC+VY
         qtlhJJLngvV/+i2AwNKklFKYShaZYzmdjKKB++lR0fj+JOIshh0DQ27N3W3TsvmtdaEq
         gPljzC6Jb2d6j6sw1b1qh8mUM/6887BS1G/3vVdOFQzhEB/Z4u/PQXd86X4zMxQ9PsLB
         CNmaByxyZN94BeihX7CuGD+jKfGkXfWEV61Wl9ADYBRTdLkbYksG0EW/5JwT0nMAf2Fi
         0oL+S+sZ6y3xsQDVKqiG/FsPj0nez496z5IpMzET8rbfu0wYGXDIpNmGAZtP4d31qB4X
         XsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=onR670WObIKN1WaDZsvnS8cFGX6eA30W7fb0qX5OToY=;
        fh=Q16yz6hO15zekXV9Kp6AhLotmWciyubk8WGZdr28ZpQ=;
        b=MAnJTU86/vzuOvfxWsBk/ILXmY6/nJm54DjQpSswfXAGHu1atBZSiAcYsG9kRnMJpO
         D8pdpj/eCZh6j2vuIx9IqV1yp6qEaWVRkzmqGBpJxewVawbKaV23qeAwPjFqOtOFAXnh
         K4n9ibajOW7bccMfsnnPSr7d4SRrV3Fze1WxjfARnOxEUduZlQHNOYIdh2GicVOliOB7
         Dqmw+yce1zYDI7b4nqufwXHqJ36QD486KZXEz+uYh2wtWy/NV61E/GnNPEXMlVUCik8/
         RXkxc5VTv0Lp5UPdfFDzM5RH3sCSSg5VZS769qmjz5lBdBsbfmtpK15caeOfRrRKbstP
         n4Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770783808; x=1771388608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onR670WObIKN1WaDZsvnS8cFGX6eA30W7fb0qX5OToY=;
        b=hew9ZV54DwhTTQVL+Wi45ZRDYJyD4EOMa03BqsooyU98LFfwmN+tkcX85lUGnD+u/0
         9ZtVpxZQdTCEeE3vuIu7kokLH3eVh3QIwJ7OCignzkGFMcOX+AfNIdYyz4H/pcMy5F/Z
         QToLWwakQVj5jEqBEv6o9rKGDA3f5/7dlGgvd2WE+irmd8aignrsNAVkTGPNGlEYZCcl
         uPx6kDwX45G6OcMhc+IrkWrkyho/DRJTuz24G2vd+/NBPpf6BAGjG0U+Md/aH8OosJAe
         0e6hRBg8dPL8O+mp+zIyQ+CZEKUFSJ5ESCxiPsIDkQTQM7KeduWqGJQnerJppIM5snAQ
         5JGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783808; x=1771388608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=onR670WObIKN1WaDZsvnS8cFGX6eA30W7fb0qX5OToY=;
        b=jl5vHaxjVEBizCI/FUqGQXXKN45C8+dmPqHAYExOpEK4kEkcX4ijBFat2Hl9BgeKvv
         o8P0mECIhKowvqd3nubQJbrWuWFt48rbhetOs11+nl9HXmUvES/7WSHqUF7ylxHdeLk4
         RWenQJ4OLiUNIxEm9D8hmC/Uaik099OYNuj9gOLJL/T6V1jBHSM0Vp6C8vnjx2qY2doy
         V3iXyNtFlDZeGpAhtnNAhRZGLnM8zlPwB4qDUnNli96tXJLppLi1IeMJhyyW7YpSMLCQ
         Di0swwLIESfZ223g53YBGGVCNQSAhGjPUKYGL+WS+gqR9YoGFYlEAaKw3lmZy8Oq9THx
         t+1A==
X-Forwarded-Encrypted: i=1; AJvYcCVZxAbm8TfglYwME+f42rPG9CpWhifOXJm/5wPtNxxBqtIngEXkpeXkkbJ6gt70QzvfnOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPWv7E9Rzk8/vXp+qYmaI1WsqDfItApHcmd1kVyz0V9aZA4C7
	oryNnlsR6bNQhmS1DpNplRZkKvL1/DlRMO+VdlO9pKWswj187yMJL5CGjpNNivQf+etZPf/ZOfh
	dKODeV7bBKL7nfiwG5f7LtRIkUaiVLweEWi45fp9r
X-Gm-Gg: AZuq6aLQ6j42Vcvqre9BNxlhXwOodzvIyxbf7dO757LMDg/G/Yd4r6sOCTFzI0YbGO5
	krOCcLvGI2Fy/WXoFH6gdsIn1F9WO4UAgmx7dJz4QgcdCVnqgwY+tJ/N9lCy+WZ9CQQ6ye17r+Y
	AnyBXt+t6RDtMU4vZVSbuielyd0N9CodSBhfX2wx8CwU+yiXZ9AXZXxcC3B/m+9lLeYl55gTw2U
	7UytHyRirHadruPRUZH9mMlxTz8cW19eWZ9b4W8GGwB/qJDofxnEjIf965erliJtamGUuBJNK0c
	D7R2r5BfNK7EyJWfE4Ys6WwEQpMRdWu1TMdPt0+GTh1FOU23970fiEinNBz0HtD3lhoHV/ps
X-Received: by 2002:a05:7022:4597:b0:123:348b:979c with SMTP id
 a92af1059eb24-12703fe453emr7638450c88.6.1770783807886; Tue, 10 Feb 2026
 20:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
 <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
 <CAAVpQUAfUQJsBzqTah8+LhTciGrHnLx3pg_xEqD4=wBuEEEXUQ@mail.gmail.com> <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com>
In-Reply-To: <CAADnVQLMiQFb7SAxgDNFXwoJ4sYLi1DWVHwq4ftAbBxLAa5enQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Feb 2026 20:23:15 -0800
X-Gm-Features: AZwV_Qj_Pvlk5Eij40X708nf6kEiOvBwwkZhZ9dI8ZMRlvtA6GhnVJcn0q8u5zo
Message-ID: <CAAVpQUDCd1fTHfBdzmk2msrMnQTL-EzH6VH0RyHoL1V8qz1y3Q@mail.gmail.com>
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

On Tue, Feb 10, 2026 at 6:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 9, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Mon, Feb 9, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> > > >
> > > > Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> > > > bpf_skc_to_unix_sock(). [0]
> > > >
> > > > Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> > > > but there are many functions where bpf prog can access the field
> > > > locklessly via fentry/fexit.
> > > >
> > > > unix_dgram_connect() could clear unix_sk(sk)->peer and release
> > > > the last refcnt of the peer sk while a bpf prog is accessing it,
> > > > resulting in use-after-free.
> > > >
> > > > Another problematic scenario is that unix_sk(sk)->peer could
> > > > go away while being passed to bpf_setsockopt() in bpf iter.
> > > >
> > > > To avoid such issues, let's reject access to unix_sk(sk)->peer
> > > > by marking the pointer with PTR_UNTRUSTED.
> > > >
> > > > If needed, we could add a new helper later that uses unix_peer_get(=
)
> > > > and requires bpf_sk_release().
> > > >
> > > > [0]:
> > > > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> > > > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > > > Call Trace:
> > > >  dump_stack_lvl+0x5d/0x80
> > > >  print_report+0x170/0x4f3
> > > >  kasan_report+0xe1/0x180
> > > >  bpf_skc_to_unix_sock+0xa4/0xb0
> > > >  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> > > >  bpf_trampoline_6442564662+0x47/0xab
> > > >  unix_shutdown+0x9/0x880
> > > >  __sys_shutdown+0xe1/0x160
> > > >  __x64_sys_shutdown+0x52/0x90
> > > >  do_syscall_64+0x6b/0x3a0
> > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >
> > > > Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef=
6cae0@rbox.co/
> > > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > ---
> > > >  kernel/bpf/verifier.c                         | 18 +++++++++++++
> > > >  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++=
++++
> > > >  2 files changed, 43 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 3135643d5695..b328a1640c82 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map=
 *map, int off, int size, u64 *val,
> > > >  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_=
rcu_or_null)
> > > >  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trus=
ted)
> > > >  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __s=
afe_trusted_or_null)
> > > > +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_un=
trusted)
> > > >
> > > >  /*
> > > >   * Allow list few fields as RCU trusted or full trusted.
> > > > @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area=
_struct) {
> > > >         struct file *vm_file;
> > > >  };
> > > >
> > > > +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> > > > +       struct sock *peer;
> > > > +};
> > > > +
> > >
> > > That's just one out of many. It's not really a fix,
> > > but a bandaid for one case.
> >
> > Right, this is only one example where a pointer lifetime
> > does not match with bpf prog.
> >
> > > We discussed it in the past and the only way forward is to make
> > > helpers only accept trusted args.
> > > Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
> > > We should do the same for helpers.
> >
> > What about just reading an untrusted pointer ?
>
> What do you mean 'untrusted' ?
> There are 3 types of ptr_to_btf_id:
> trusted, untrusted, legacy (without either trusted or untrusted flags).

Ah sorry, I used 'untrusted' since the pointer is not always
valid, but I think legacy is the one I meant in this case.


>
> kfuncs now accept only trusted, while helpers still accept
> trusted and legacy. The legacy should be disallowed.
> That might break some bpf programs, so it has to be done carefully.
>
> > I used bpf_skc_to_unix_sock() in selftest in case compiler
> > could optimise out branches that always return 0.
> >
> > Currently, this passes the verifier and can trigger UAF.
> >
> > u =3D bpf_skc_to_unix_sock(sock->sk);
> > if (!u || !u->peer)
> >     return 0;
> > if (u->peer->__sk_common.skc_family) # unsafe access
> >     return 0;
>
> No. It's fine. Both legacy and untrusted ptr_to_btf_id get probe_mem
> treatment. So above works and won't crash the kernel.
> It's effectively inlined probe_read_kernel.

Yes, it doesn't crash.

I was just unsure about the bpf expectation [0] like how we
should treat KASAN use-after-free report by bpf prog reading
a pointer whose lifetime is not guaranteed by bpf helper/verifier.

So, if this is WAI, I'm fine with that.

[0]: https://lore.kernel.org/all/CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpHBG=
qKcUT0iMA@mail.gmail.com/
