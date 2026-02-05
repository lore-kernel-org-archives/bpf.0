Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA13358DA
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330471; cv=pass; b=FFDMAZ0LtIg+J1ZmLbdD95QzhgMoeCjJsFwaDjwya7eNxwSIwW4iTw4hKw4D/OAVaHTam/SCst48mLTb+kC8XXE4oHnR9NKheWbsBcDUTvbrCwXQ8ZIhnfBdWRCb5Nh5P4A+K1FCj5ARcUVIwc6jOUc0jtws6+qNBvh3z3UKyZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330471; c=relaxed/simple;
	bh=wT63vSp5kCeLsH/iyRnGKz4w1Whcg5hYPhhenR/aQuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E161/DtBKugS4yRl1Gw/KQpKgLyIPbKd4LPYGR3ilRAFYmmERK6Hx+CSrDi+p8Rid7AkWNz/suJTADhgD/3crw4S44IXSKWx5N0KYHGWg1uXk+vhqHFdhku/MCDddfwJadeGLq40PFWm44Py8YMEgtJcfRrdC/hc97Bs+FHwg0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6QXUV85; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6QXUV85"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-352e2c59264so924297a91.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:27:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770330470; cv=none;
        d=google.com; s=arc-20240605;
        b=dpPaVJuGA88n9/TXsk7Cuo0ld+r3ecDbUV+B9voRIHUX5fU2iRXPnKp4ChLFERhviA
         t5PHmZK0TQ/4frQznghnxhEEimsjJBDDcF+4ZLtI3deWeR9pz2D073DIaVGONJVsyeLJ
         Wy8Wy4oUE6KCPAfmaW69daaauX7os7G8M0jpYrBEHjHPAZezksLxOtNl1qjZbfaWS7Lq
         tDBUs4PhRWVhf1hIg0jhhOyJGePsSkwB9+J+5w3I446SWHHezxlKXSEVccy9SLdSnLrv
         nDP0S0h/Gck17sh2ojmFo9eJmTlTjJumNphh+Gum8v47tzK2tu0ZsZIbvFJOvpYJdtht
         szBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cQT746w59LutbmQ8NQLgOwJeCXLUJTo5+ZvjfzU2gRc=;
        fh=WOiymP0CIcc0DG5xQwi5NtuW2zhOkAQx2r7MDjkTWfA=;
        b=PfLxWAwMGZKkSGhGjn6nOxk1thhDC1JEf85l2GF7WPX+t60mpv+n7w11rTecDd3onM
         L8EukTtSQJ6IWO5jUYgBbw+PJTK6ZLRbbquSVYAXDBNrA45hjLUgPQrcZzK4qjo5x6fs
         L81LVb12uqxpHly35WQO0u9WjJn1cCeiK6+b0yrboNBMwOC20ynWv5GqYKLkLFNP4zR8
         tmDFhD3FNLeSQZiTAsngHd+2WAaPeTVELQsTaOybGzwne34BChwNHhQ16W0KVsvQ6Wca
         X85+ZtSfnz+Zu3Equa8ObtioA95U+RHd2INFWtSSJelPOfa7YJdYmkrxUv579CouptzC
         g74A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330470; x=1770935270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQT746w59LutbmQ8NQLgOwJeCXLUJTo5+ZvjfzU2gRc=;
        b=i6QXUV85tw1L3ZjyL92mBDjXuxY/ajTyNKF2mWIY04u6iPeXDGy9vCNMlRQcsWeY1j
         kx8O7atbc5qjDAO3Ckzb415dsmWxqxDD7Z8wOHG1Eo8Xa4SKo22CKkMPgrlmlAPclv0w
         qWBcl7qUuRjQNS4aynbJsko5hL4vnsAGyQmneOxpj7pVleixAOq6AF896e8ve3cF7SmM
         FxMc8FM34DTA17mRN5fOBA1MO5d5NRbycfVnhRxDo9FKPpY+L/9YLpeDuUSlfvRue99a
         +dMKIlJmyaKEpKL0oe0NxSM86tjgIvQAWUI/Hv+OBs/RjhHMHuZeP1Pckh5UTT/ErAhy
         /J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330470; x=1770935270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQT746w59LutbmQ8NQLgOwJeCXLUJTo5+ZvjfzU2gRc=;
        b=d7Fw/9eoFdQ2kOU5OdBh9dkMtIxhx6nGAw/dSQVhX5isxO5uXCUHjwo/vhFhHJ0QBX
         Sno2bH5BOZwMfKAIam3U3v/Y+/6upIwN+ftL9kJ+xbK0m/3CCGi3RSIQQkzZ0ODH5jTT
         hKX/HlTEJCaEY1WjbCmUyFDgTyqZiZ3pijMdSSAFD2OgLRdtcQxNzo1350GJgaKjQ0mw
         KrmtXWNKxBtFT7a/s9lJvM3W8T9eLpisOrpKb4XhGm8eIrHXEwLzMnSTHrbiEl2ofxUS
         InBCzcHZxTdEpZTCbBcZKuVcgjFo0bcx7SpkUhTx2C23kKp0kR/EpdKJaK+ey2qnrsBc
         85aA==
X-Forwarded-Encrypted: i=1; AJvYcCVHumGD1kNDNKuc5BxfMQz2HiCw0k0qM8fQy3sYCWmhQ8fv6UZ2Xw8Q/5gs40Xy09dWadw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOO4FFKp7h0EsN/IIClK2QOyiGZ6B79+bJ9ZleyzXhDAcPn/aP
	KBl7MrnofUWevQrGQwEU4dSBY83mWVPg+xOmjDFuPt2+uPbj8I9I7un4oqV2hdHVlvUgcZSsyzu
	ZIREaWs6I3+AxLY1M96TWND4unfMF1gM=
X-Gm-Gg: AZuq6aKhTF06MhecyEDYR5Klew9cOk60bgPNOdBK772PHWeYCeke8JlZjV1vqPEOs6Z
	vUycuw7aRMK4nZA7l+kbEc298uRB9vIIPdSI3kHaicCxlHpC1+8GS/MU8UZIMgEPt8jjV5z1MXO
	8ipZ2JFGxsq3YB7el/hLadN9vBMzX/t0/3DXOqqPmQyfK31u9VKJbmBx7aHg2SewwHWgIqGz+ll
	SLhNH/kpHv4oYdxc4C0nTKWwZb63La5D4ltNGuW8meLA1goz9Zejgr49GEZ7XYejeNhnJ3vt2iI
	6tiJzsGwou7kXjQEijnVIg==
X-Received: by 2002:a17:90b:224e:b0:353:883:affc with SMTP id
 98e67ed59e1d1-354b3c8a795mr448234a91.18.1770330470396; Thu, 05 Feb 2026
 14:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-5-jolsa@kernel.org>
 <CAEf4BzYWxmg7YO_ewENt1rr4R1YT=iL0fc5yJqanfQZJk6u1nQ@mail.gmail.com> <aYRbYY8f_wWoiZhk@krava>
In-Reply-To: <aYRbYY8f_wWoiZhk@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Feb 2026 14:27:38 -0800
X-Gm-Features: AZwV_Qi0sNoP5otEpg1sqvr1nRA_s5ZwaLJsMTxo-ZEf-4gsK5EHmi7JfFu50Y4
Message-ID: <CAEf4BzY=vqpnjrDNtLVvC3_nU5=Z7iROU_He=xbkEJDuGCoqug@mail.gmail.com>
Subject: Re: [RFC bpf-next 04/12] bpf: Add struct bpf_tramp_node object
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 12:57=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Feb 04, 2026 at 11:00:57AM -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 3, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > Adding struct bpf_tramp_node to decouple the link out of the trampoli=
ne
> > > attachment info.
> > >
> > > At the moment the object for attaching bpf program to the trampoline =
is
> > > 'struct bpf_tramp_link':
> > >
> > >   struct bpf_tramp_link {
> > >        struct bpf_link link;
> > >        struct hlist_node tramp_hlist;
> > >        u64 cookie;
> > >   }
> > >
> > > The link holds the bpf_prog pointer and forces one link - one program
> > > binding logic. In following changes we want to attach program to mult=
iple
> > > trampolines but have just one bpf_link object.
> > >
> > > Splitting struct bpf_tramp_link into:
> > >
> > >   struct bpf_tramp_link {
> > >        struct bpf_link link;
> > >        struct bpf_tramp_node node;
> > >   };
> > >
> > >   struct bpf_tramp_node {
> > >        struct hlist_node tramp_hlist;
> > >        struct bpf_prog *prog;
> > >        u64 cookie;
> > >   };
> >
> > I'm a bit confused here. For singular fentry/fexit attachment we have
> > one trampoline and one program, right? For multi-fentry, we have
> > multiple trampoline, but still one program pointer, no? So why put a
> > prog pointer into tramp_node?.. You do want cookie in tramp_node, yes,
> > but not the program.
>
> yes, but both links:
>   - single link 'struct bpf_tramp_link'
>   - multi link  'struct bpf_tracing_multi_link'
>
> are using same code to attach that code needs to have a hlist_node to
> link the program to the trampoline and be able to reach the bpf_prog
> (like in invoke_bpf_prog)
>
> current code is passing whole bpf_tramp_link object so it has access
> to both, but multi link needs to keep link to each trampoline (nodes
> below):
>
> struct bpf_tracing_multi_link {
>        struct bpf_link link;
>        enum bpf_attach_type attach_type;
>        int nodes_cnt;
>        struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
> };
>
> and we can't get get from &nodes[x] to bpf_tracing_multi_link.link.prog
>
> it's bit redundant, but not sure what else we can do

invoke_bpf_prog() specifically doesn't have to get prog pointer from
bpf_tramp_link, it can be passed prog as a separate argument and then
bpf_tramp_node  with cookie separately as well. I haven't looked at
all other code, but I suspect we can refactor it to accept prog
explicitly and the relevant parts (node+cookie) separately.

Just at the conceptual level, we have single prog and multiple places
to patch (trampolines), so we shouldn't be co-locating in the same
data structure. It feels like a complete hack to duplicate prog just
to make some internal code access it.

>
> > Because then there is also a question what is
> > bpf_link's prog pointing to?...
>
> bpf_link.prog is still keeping the prog, I don't think we can remove that
>
> jirka
>
> >
> >
> > >
> > > where 'struct bpf_tramp_link' defines standard single trampoline link=
,
> > > and 'struct bpf_tramp_node' is the attachment trampoline object. This
> > > will allow us to define link for multiple trampolines, like:
> > >
> > >   struct bpf_tracing_multi_link {
> > >        struct bpf_link link;
> > >        ...
> > >        int nodes_cnt;
> > >        struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
> > >   };
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  arch/arm64/net/bpf_jit_comp.c  |  58 +++++++++----------
> > >  arch/s390/net/bpf_jit_comp.c   |  42 +++++++-------
> > >  arch/x86/net/bpf_jit_comp.c    |  54 ++++++++---------
> > >  include/linux/bpf.h            |  47 ++++++++-------
> > >  kernel/bpf/bpf_struct_ops.c    |  24 ++++----
> > >  kernel/bpf/syscall.c           |  25 ++++----
> > >  kernel/bpf/trampoline.c        | 102 ++++++++++++++++---------------=
--
> > >  net/bpf/bpf_dummy_struct_ops.c |  11 ++--
> > >  8 files changed, 185 insertions(+), 178 deletions(-)
> > >
> >
> > [...]
