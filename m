Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECF3793BF
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415333; cv=pass; b=r54hqC9jht0WgVQbUcBztyd5n7qdcxdclkgI4k79mnGk+kyJtcZs05OfcNUjhmxDJRz3Sa3JBzZVER+7Kv4jWBgmyUopsWoponTNBSvTuCMWftrjhi3RVV2u2LExA670J4slwVcABmgh8PM9L5naUcEzSHBsLCEnhKLKEOpWPPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415333; c=relaxed/simple;
	bh=HiqG8AVCq1Z3K5J4ljs1aq2aJn6IW98a+B5RG4+qpRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rqv0jv7L5309A3Yio/APIpDNVfSisdqYHa/uFxM7uUcShvTmh9Y72LGl0kiw6LtHCZkI9tjGQSGCZ0zkLXaSHOv4XO2Kwicnit03iXDKP3oZmw0l3StsoH/PlPc+sTW11w+gIToT5L3Ai2CUAc6Nt/f1RjNNnT2cJmePHla2ScQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btdR9WOm; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btdR9WOm"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so12172887eec.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 16:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791415332; cv=none;
        d=google.com; s=arc-20260327;
        b=L635JQUj/8SdU5OZpoqSvVUvrJpEelJYaeAEoYNHl8JLUSZOFV71MCwnBpWS1vcs0k
         CQd4h4ev9t3X6/wXtDgm3guw8MJ+Gh0wZiAgE+DWcqxuE5gbAdnsRVc2xl+BoUbVxJX6
         +AdQPJlFYAqVVs7cF35nBqXtuTUnkGLkyzNkfVlFhzaClDHuHqpQePoRHMcynM1SOUcV
         g7EeoOQXqZH+sS1CiZ2wYXghEdAx/A29Pc5oi2IakYAexXiANy+/vIHA7AFuccucslG6
         nfm9IhJKboJk9W3uoYt60LLV+7vhgTwCWUOsMoXl4aG6ZbSSCorwxABzX3wb2ZdZp0y6
         grOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=prskCRIuYR+XX8F5YqRlwpvMCkHISXsdKM8mbnGxz2U=;
        fh=0LHW6KZm1mCkTzcLqqxRFwz+Var6I0b6G4e7pOr0W1s=;
        b=fvea2Igc/QNTXpfNAbhBQbn2TBs8GwwROtE+csDchN2LtR6+KCB3d1Vp+uJrI0V63F
         EZgVkuGqlg8nppFSEsuMUHvMnm+ZnHw4ja5bCqQ+x1E5zQpMGbgYNemj99ed3g8gXmoL
         ejZA2aE3/pGrLX7sHkSdh6eoe/DCk9kwrgv6qbU1lH6vUSznOAiq5K4ZaTrgoW0cST38
         zTSFwGBT7hXjI3K7c790aBQjzPkrfHiDFFHirt7ey6n4G6A9NZ72/3RWnZevtegUFy08
         PswtJlIT35BhPfgtXdyXlkbdVTh1eoSe4ZSrbTW1niCiE00JnXP5oihQ87ahxqFgrWBo
         LzXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791415332; x=1792020132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prskCRIuYR+XX8F5YqRlwpvMCkHISXsdKM8mbnGxz2U=;
        b=btdR9WOmbKb4l/r9ugPjsq64eI9r3d63tVU4MuQK9Fzq+a+Yl8j9Q8Y0LcDhtQ4pBq
         E/8NRYnqP6yIFcDORq1te7tNsUBGffzzq6Q6GhhQZ82MGV9g+iUBQo+/0XHe/Pznr+u7
         gwxdeEo1uRvCNFQz/uSnEaA9V9UyT4swB8SB7XAZzNWlW7FHZxpOgCH3V+9QqwpKhbOw
         7dRiX4UzyFiPkwTY9wngBsYjFrLN/0qlMdJ9KM3gUUiE9QqzUQD5KrwnB21ZQI4ffVVb
         gBqn4TzWymFRe9QWgjRU5Vg0h9VBbIHBFq8PZic1OKrinO6R0Ob68yyfF7aDWV6KP4lk
         RxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791415332; x=1792020132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prskCRIuYR+XX8F5YqRlwpvMCkHISXsdKM8mbnGxz2U=;
        b=qvTWQkcOmAnDZ7J9zNJSDhJNbRrT9a5Oa6HlNgx051LqzRR9J5UuTvazcTmR7OHUt0
         Yu66FKYRjauETPxcc4U9VyySyp71O1WI8Fua5ohOzSik4NDSJzSscubN/PQMZuIix84e
         oggT8Ik9Nl7uTFDyUdKbb/B49HYqFbYmDL/NMf44WjY9q3gvGw1/dvZzEzbNkYGRK0yA
         Zoq1TlD87/3hxpBu5ueJ/zRxuglisZ5lZHa+2e8n6H9TSI+j/gg7/3BlzBYZq0g3XuyH
         kDmFGqPXyfvwVgVmVMHa/A6XaOxw9vDfUj7MNz+g+V2vZnY6fdU0fe1vqabI3GJbqt1w
         DZFA==
X-Forwarded-Encrypted: i=1; AKwUvBw8fkJRsf7kAZUHgRqDGGLF9/quyb2JKOGxC5+7DDBXMeFHaIG5FZLaegdNFlXxn0x+Z1M=@vger.kernel.org
X-Gm-Message-State: AFuF++m2H2Q/2lbQDRp3kfUZVE/Vgsm9dr/S2+AR68zBo2sKnBEGazmw
	0jjfzOplrjI+GFmaZVcUqLos98FQITaL6B33RYD1i2fCaqxHaSnObbPVj0iWsQ+mGQ89UsZWKwj
	KxUOnbmNIVT7P1nrWTrbs88YqNaJG8A1QIaRWil4P
X-Gm-Gg: AYBFou2lHN/ga5Ht6QjkN3U6/AtUmjEQTUoH630L0/c/PVVNuSg1nV7pCHJ79UmW7zd
	LbcNOXJnustQKBXOUOpA8vE3m1zxrDJnB0K46/N8Noxc6p2V+WwYuxL/p/3Igm9IcSJ20NEJeY3
	PThL3V+01eWPNZ+8eEi7XpMDhMf8zy5GAnREf4rVdE7+w6V8i1ADog9wQHUw8q93wq7I3HsT7fn
	IsJyVQWkIxTINPJP4xcqF/s241TAcDFulWq3kk62doz3ZwM1VJQPwpAs2pum6QI65sdEt6f29sw
	zxbMU7nqDP14dcO3tGdoKf6Mqm3L5JFAmIkfJQYXpTN+0QaH/u/WJEN9TdKfmTp3Rarv6HxuNP2
	hSBhGva4xfWVcJq+fMXSXnFgMcVYVAsv96GUl9nTyIb6SW5esJUHPs9JCFaaEVfJTZLxgiZA9P2
	sYpI8vLZOP4fxHvx47qvj8uRzPDSFZQbkeCKY=
X-Received: by 2002:a05:7300:f78e:b0:351:679e:ba2a with SMTP id
 5a478bee46e88-351679ebac1mr3190407eec.23.1791415330456; Wed, 07 Oct 2026
 16:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-10-kuniyu@google.com>
 <CAMB2axOLGbeYatQ8=XNmZH1PUmigRdz7qKxwZngt6U4FCmdQzg@mail.gmail.com>
In-Reply-To: <CAMB2axOLGbeYatQ8=XNmZH1PUmigRdz7qKxwZngt6U4FCmdQzg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 16:21:58 -0700
X-Gm-Features: AclHuK82upe5Al7QcZBohwpUxhHT6jCeGNSyHxlFXHnLXVMJkE7hHINjz_ruQp4
Message-ID: <CAAVpQUApCBTdHQDjf0NRXhE55fcg0wtmjGz9yEuQhsbQ8xm3rw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 4:06=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
> > adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.
> >
> > Let's add a new kfunc to set sk->sk_rcvlowat.
> >
> > Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
> >
> > For enqueue_rcvq(), wakeup is set to false because:
> >
> >   * tcp_data_ready() is always called after the hooks in
> >     tcp_queue_rcv() and tcp_ofo_queue().
> >
> >   * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
> >     not yet accept()ed, and when called for TFO SYN+ACK, the socket
> >     is woken up by sk->sk_state_change() anyway.
> >
> > For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
> > is not called in that path.
> >
> > An alternative would be to support bpf_setsockopt() for these
> > hooks.
> >
> > However, that approach involves excessive conditionals and an
> > unnecessary memcpy(), costs we do not want to pay for every skb
> > in the TCP fast path.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@meta.com>
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  net/ipv4/bpf_tcp_ops.c | 46 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index 8182037c4269..2ba73dd6c52c 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -361,12 +361,31 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_=
sock *tp, u32 enable, u32 disab
> >         return 0;
> >  }
> >
> > +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat=
,
> > +                                        const struct bpf_prog_aux *aux=
)
> > +{
>
> Is there a reason this takes struct sock * instead of struct tcp_sock
> *, like bpf_tcp_ops_set_flags() in patch 2?

It also works, but bpf prog needs to cast sk to tcp_sock.

This patch is straightforward and rather patch 2 has a
reason to enforce bpf tcp_sk helper use in cgroup hooks.
