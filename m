Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E723815B
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495783; cv=pass; b=SdOK6H3W0iSSOcJ0X069F/iq3EMd/scQLSQGZC8LSHIN86oJO3NY0TeqlRiSsn2M2Ht+rgOFOMp+xD3V500ES3dbKE2xJhSX7UcYaAgXNOYK4s+brYO7zcZoQDjbZ8LB5wHo+uVD7NM/nc+jVYNBASl476+CGgkOdCBGU1CtD4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495783; c=relaxed/simple;
	bh=+b4RqN/bq99NFKJTF469ATTYpo2k0M6WRaHIdC7aoF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvuaiU16Nms5VpxAb46dOscKVwpR5ZWLRElUbvUdnmpL0AjjRZXAbEbOq31UW8NUBbFiPg8VS43xRJvYBQ/rfobhUL/oymI6dL7v/5S8FaIfhUFp2oQVz9Ua9w0AvyCrBr2/42Hj0hf7LE8zkeac410yirw2tUDORCm/na/u1ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoPlrSYN; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoPlrSYN"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-135e88b8e55so2601172c88.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779495781; cv=none;
        d=google.com; s=arc-20240605;
        b=LNlEHfbrbyz02mn+qeBEmfzG3cAGffI0KFmkUavL8eJabpFvhUyjqblQh9JN4pd+5X
         kKpmdahS4hSg8bVdyaZlFQi++g1SaFd6sUGamWC5AJmUHThHxtiIxNR8nlbFjDehB997
         LrNb62RJddDeku5isqZzZw26NKoBgDDKsw1yDOfV0z+Zly9cDlPR5FpO3g8OluX0eLpm
         4i81a41RxZV2NDf8ccNVuL4xo5JQqsxB121m9L+XdstsF8eMqhzkrSIP/YU3jbQvVpt+
         MbJVn4HFLGg9btRXWnpbKQz4NdMOBJfm2L//8LeKWdw54NSgyjp9tl2VKRQ8TKWOxHaL
         +duw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xYj58BCtDwMdw4Un0o/5awfHoJ76G8q7m0EyUW6lkM0=;
        fh=IgGGeve/j2a27aRvg1hSDw4ebKkZeRWiH72Zko/LTqw=;
        b=aGqvC1jpcltiZejCwUhZ+g2+SncwMZhgE/UQ02PeCb6e6SecRqVHjlzrb06IM105jf
         hJnlr/MoplEEDa02O0Cxj3ojWCljbCBoKw+2EzxMdARf3n/QC9XH7eVrhLBmi9N6o1z5
         ZaSrZ9KvIIceHZMGgd/y+bmUmsgzSqIDUG7BrmI3sNXLxGEL0XdMkiKq5SzI7Pgn30+I
         ivoxuy6Wn5p/nQ8zJcDcgJUY+m+fj4FP7XkdsejEbfCtrSZmYqrD3+gDI44RQzJkcSzg
         nKhdS27Lehk6QNU7KNBdJ4YM2dPlPRF+jRqYMsPFcUteZPiBqnaE0Dcp8Rgu0CdMrb5c
         uR/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779495781; x=1780100581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYj58BCtDwMdw4Un0o/5awfHoJ76G8q7m0EyUW6lkM0=;
        b=QoPlrSYNM6Jn0/A8KBQZrw/SMhB+eK8rBVfqg+h5pvc6MJ5BQkhBmClfv7os3GlzPg
         2vti1FkMuO/8e7Wtq1qXR6DDpG6oOr8i/o0/l7jTZUej5s1BZgbwHzpBir9znZyaTI40
         UdDHfDQ/FVonTS/PzKsM/dbvNUXz4mMhl8fu2e5wVvU4zibXyf9PtoxmV9IqQjuh1yj7
         MixJgqD2bXyM7JVfR+xpiwpI0II83EAdo6HTSbJDBUMMT6S8LaaGIXcX5SQT8axkl5IH
         /nHe+WdguSXE7W1anSygvusndVZELvkQ7VhSZwTWMMPKaEaYytSReZbK8OMkZyOc8YcZ
         0zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779495781; x=1780100581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xYj58BCtDwMdw4Un0o/5awfHoJ76G8q7m0EyUW6lkM0=;
        b=TjePuOFdmi/VyRa6S1Z89ryTOuH1+0LWAixk3TqHqTHH/G59xzJCiCyOyz1CIJB1FV
         fsnyT6cvwX5eQqKClE6fXX0ZVxsfzMquWrMtaamw6wBMml5nTDkbPrBynY9cDmxc8wh/
         BQF9gKSLeDkjLRTUvHoeSqmsNWPEAuqb0pNQoaixYgEdXA3/CZvH+DaVTeCL2hJrQfl4
         YLEf9uRWljzinpmGlNPafTM3cF0f/oQzuGlo1wlB82WrVq70yryNeXDUj2Y4/7fuAT9B
         7IFpf6zYH5GyyynBJVIe7W7590KU33NdGCvJsLX5YafkS79lqjB9eEPO8uFfnvNyIHqf
         JzNg==
X-Forwarded-Encrypted: i=1; AFNElJ8ANa4oQA+mgsAd+tWKGhHBbGKKlMzLec98BT45j684ORPoEoc5XVQ/SzoZmZ4TOY6NjYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+490I0/HhCXclx1tuYpAPUWpzLJyE2b2dB1X+v45Wvo9m+YYo
	Qc7LTvE3rTrYjsGUJqmLkc4LJeorY40026bwbsON5GaCSmVr2dYOdNj2p00Z81zRjLL6e07GPc1
	JYjuJC6F8r7KkOMzblEqrTDHV755/D9uVqvOgY5Xo
X-Gm-Gg: Acq92OHmr698OEaDdmoJypEI6lGU0d6CbpbDZSBDElMw8iQRxhrlY30EnD8n1lUJCgv
	XUumiqPU8zo4kFKXp69YIIsrAwqeBZL2eTRl9ZpqURyme/yPoirus+pGYL63y4EsewlXF6XnKn/
	dFTQtiE049v2ZA71xJ9AzJAfxPxjjhlQJ/4kLtI9cgx+2PHD08DVmBWVt5CU95Hzm4+VR2EsgOp
	MZzUXra9eYgmyY6juEYo6ILbJgJrckrY8K1D32gZxtC7/Bo8hXYLOQv8Esx5WrOR/5O/pChRN56
	t/+cLeueZ7WNX6hsBeSyPnejahltz/KV2uK2+getMpLA3OIz1NFFqnS14oqJEym/5gt2WxFUuKS
	NETn81+7nHd+5UNeksZopk+5j5qxnQjASw7tVoPOJ1qfi8TbmUbU2wcHxSd0IHvk=
X-Received: by 2002:a05:7022:45a9:b0:135:dc82:85f7 with SMTP id
 a92af1059eb24-1365f70ab48mr2139390c88.4.1779495779978; Fri, 22 May 2026
 17:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522074601.1658705-6-kuniyu@google.com> <b5c171e50d47d65d8bd9edc67d002f02f9843a5ab2677183f57756ff25c8a2f3@mail.kernel.org>
In-Reply-To: <b5c171e50d47d65d8bd9edc67d002f02f9843a5ab2677183f57756ff25c8a2f3@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 17:22:48 -0700
X-Gm-Features: AVHnY4Kod4mBHGxbv2PQA_sK6_vl2iDOwVTcGIw1DgrxSyf0au5JEiV13xePDdw
Message-ID: <CAAVpQUC3ryDha_Hxev3pt40Yp3zb2RzefWJqwxDdJRrErJL70A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/11] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 1:22=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index fa8a7c7d86eb..3608036632a8 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12388,6 +12388,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct=
 __sk_buff *s, struct sock *sk,
> >  #endif
> >  }
> >
> > +__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern=
 *skops,
> > +                                           int rcvlowat)
> > +{
> > +#ifdef CONFIG_INET
> > +     if (skops->op !=3D BPF_SOCK_OPS_RCVQ_CB)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (rcvlowat < 0)
> > +             rcvlowat =3D INT_MAX;
> > +
> > +     return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);
>
> Could this reproduce the MPTCP subflow issue from commit fcf4692fa39e
> ("mptcp: prevent BPF accessing lowat from a subflow socket.")?

At this point, this kfunc cannot be called since there is no
hook placed yet.

Also, a subsequent patch disables BPF_SOCK_OPS_RCVQ_CB
for MPTCP subflow.


>
> In the v1 review, Bj=C3=B6rn T=C3=B6pel asked whether BPF programs could =
call this
> kfunc on MPTCP subflow sockets. The response was "I'll rather drop suppor=
t
> for MPTCP for now," but there's no check here to prevent this kfunc from
> being called on MPTCP subflows.
>
> Without a check like:
>
>     if (sk_is_mptcp(skops->sk))
>         return -EOPNOTSUPP;
>
> or a protocol check, this code could trigger the same warning that
> fcf4692fa39e was designed to prevent.
>
> > +#else
> > +     return -EOPNOTSUPP;
> > +#endif
> > +}
> > +
> >  __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern=
 *skops,
> >                                             u64 flags)
> >  {
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/262756=
74572
