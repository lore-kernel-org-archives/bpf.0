Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DC2F290E
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779060529; cv=pass; b=clnf00b3u3Qju4jsNOpz4yVrG07wAnwttaZ7Ruhzu6+e4fbELeLUf3HR/ZtmwA+oLIsuVui1MKJ63ZxZNGyi7hWB5DFgef+NevSkNcqwPUN8Gq04Zz8hr5894W/Ttz6+xc5WFSfJE027Gdf6UVEopvcvwHhgYd0vzT9ydMQqO0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779060529; c=relaxed/simple;
	bh=m6bgQW4Zf8MXt1wfbHMNC+QaLmkOQvqE09zCrI53oZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9t6CFTrhG64gPYCOKq8EyzVDj2QaN3MYwbiv+BCTwrLvqYJJN8cOI/8txUVqKy6+eU/Bi1e58LNiRQ/LH+zo8lIvXX4w3wU4scvNNDJgeoOSTX5YdaZv+Z/ZukMik5swioazVx6VkF7ekdGHmdwkWMVExoXlWTH3orsrzZPvE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJObiiNe; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJObiiNe"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1329fc4bf77so3976713c88.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 16:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779060527; cv=none;
        d=google.com; s=arc-20240605;
        b=Xz5WbQ0hww2sfNMJcL589wcfQno5WGXoJYRPxQP1twW4/1CloGnodX7S4t46PVzlRL
         c7g/PlA0Vb1FN2SXw/UnJy1MEEgimVlpYtueaBdmLciph5e3JwxM+Y5Ck4dlnCQP9Ax3
         4KqosG3x6V8TIX8EOzmyHTwjrUl48E505PEb1LyaJNy34/IfW/A1eJ+3bR/OVuoY1+gn
         yT0l0vJ7E/byoBlHNK8TPIkx6LgZT66CgR10GpVLmGGTYVlq83K3fd0VnGNYcBuJRtqX
         uz8GXt4B48JiJFzDZL7MZYJ5SroglEZ0NccY8qJBHBtVJetRfFDM0UGbi3d+EVx8KuqN
         JCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rnjcwh3aBXAGcoUKmcFWo1+pBa0cvkHlTiGofoh+fLM=;
        fh=suOAWQE/6OvDTFZ48AG7BVn5l0iGjEKnxKX1FYAdMOE=;
        b=BhRoq0WpfRQ5xpHRXuBbSWy6mOy6u8CF4GZ6ZC/hLgC3XP1IpIGx9mwGxMM+kWVvN/
         mUUw8OQ0eBAXMYw109b8DxKC+2gQ9U1oWvYmq+RQ0fHU7fuNcg067YTsVz1HzIdG3QGB
         iop5futqueuUNR2ZB2pqe/KiZHvJXRcfsKS8QWLLt0ZwzJo+yHByQzFDIUn2nVvAYDh4
         9fmzdcPlxahc5o3ebe4v5Jji0tk61p26GnsmL/55/smHesb5xijOthyPG5WTqXQPTfwN
         8wnmyEXZvqaDnKNNYHvveWgrBddSSy4AMx57BPbaEYPw9ovRkVln5VZs0QZOMAmVA+pX
         bf8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779060527; x=1779665327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnjcwh3aBXAGcoUKmcFWo1+pBa0cvkHlTiGofoh+fLM=;
        b=IJObiiNeQVmyQ4i+ARUgXwH0aNUqN6QLS9zvqoUkQNcWtRHWuHOPKfKpEWaD8ocyV3
         sml47GtI1MnBdS/VVo1wD59t+Ayb3kxkMTW+qW7gFhPRvE5RXiMfZqjUe5jS5DFGVAcK
         GMX3njpH/a6RMOCRZKd4RDz6Qh9BzsEfs63mMkrNaKrn2tMV2jMnFJ6lTueaaRiDTKcj
         fiNXW07pMxBADDJr7diaHvUufjRRaVIiCfBpL6Lumql8VY0XnSWJtBN1wpLBuZZfUQdm
         htyc1mMpaia40bz4NOc9ez6d6gys9OOJSmvwgDZRvf6QJzlgWLsajNygsUX+svNErmkA
         6Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779060527; x=1779665327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rnjcwh3aBXAGcoUKmcFWo1+pBa0cvkHlTiGofoh+fLM=;
        b=T3JhGzTh33k74vx+SY4RlVJMt+wlYeCtkbOCqPySz2qh6sYCFOuHEU1brEM2IYr3+C
         /RV2ZgLiwVKy+OXQJo1rgcUI7bemM76W6E0qILSQvQqAAnN+biWppJ5OvRMIFC7JopET
         xCaJwQmDxZuPtBfQ+jekMLbpDsBGF3ZQIP+QMzni5GBF2bFx8glmAQSwLKlZhdIRq9rG
         USvc6x5l/Z+yu6lmDBMQYYyazrL7o0DFfPJY4EYPK+86cS5pirqGMmPFMLiN7NxmDYp5
         +ZIeuzAqIrqxFWavHudc4nsm1SJONfg0fSHNG6M2/IzS4p90tb+SttcomuXG75C5PiDm
         dEQg==
X-Forwarded-Encrypted: i=1; AFNElJ+WGIYwtzB2/eKa+L7VTF2PNRMW/pANkXI0GPGnf78boodWpfo/DM+gaxWp0+/p/vNMcYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziO4v7xJcUJtiJoZVedQdh3gLcgZdAPRxt6YfxZh3cMBHwdkI0
	ekBpZ9kMimPZ2E2GsKj2xMdt7f77cmJzy8gg2Uy6OaKztY2grRpnC6NlewJ2s941a4n8Xgybq9S
	ntuIhgdBGl3R4Xm0Vj4G8s5z7dyZGgVErP1QXTMag
X-Gm-Gg: Acq92OGCYZgyvaO8ih6pHIIIGmcG6ZKuCsK0tMlRvoo7FAoxez1vpUbkfJZY+ka/P5B
	ee4ftVziwt9E4xBSwEe0lTCWZVlW+BBSlUMbkgKcJwBzcwuSfPpAhiqr+GEzF2luTQga3iibg2o
	KJvGmfqlN2pW5BJ/RLdvqmqLIhCakRGk9B653KWGOR57TzX1PDWuCR4PtTMrYKICbfP8zlYzApP
	sGDFyeS8ZHLWZv1LWmn934qVQoV7fd1FB1lvkfbI9oAa+tbwwkW1Zp09X052uGUe0xLhjmzaNAm
	zK5rr4ZyZR9ocUpxNw87uVI66hUaXA4STtBLAafnSwOJEFgxzc5zT8lNfOQC28N319zYckuIGyn
	0wC98l6TpoFokmcLt/b8I/PDrDkdPeYS88U4kkTnf/A==
X-Received: by 2002:a05:7022:41a7:b0:134:def6:e70b with SMTP id
 a92af1059eb24-1350451e322mr5774300c88.6.1779060526553; Sun, 17 May 2026
 16:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-6-kuniyu@google.com>
 <87ik8ujfa1.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ik8ujfa1.fsf@all.your.base.are.belong.to.us>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 17 May 2026 16:28:34 -0700
X-Gm-Features: AVHnY4Ig7UxTlQzaKGRM04g04YbMYBZZ4r4oVDiLULEpxp4tTBPeWfll-rBxudw
Message-ID: <CAAVpQUDKx=07Rhz279oFOD3dw6PvuOP4mVmvQKDjPFOHZXimfw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 5/8] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 5:34=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Kuniyuki Iwashima <kuniyu@google.com> writes:
>
> > We will invoke BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVLOWAT_CB
> > to adjust sk->sk_rcvlowat when
> >
> >   1. TCP stack enqueues skb to sk->sk_receive_queue
> >   2. TCP recvmsg() completes
> >
> > Let's provide a kfunc to set sk->sk_rcvlowat.
> >
> > Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
> >
> > The wakeup flag is determined based on bpf_sock_ops_kern.skb:
> >
> >   * For the enqueue hook, skb is always non-NULL, and wakeup is
> >     set to false because
> >
> >     * tcp_data_ready() is always called after the hooks in
> >        tcp_queue_rcv() and tcp_ofo_queue().
> >
> >     * when tcp_fastopen_add_skb() is called for TFO SYN,
> >        the socket is not yet accept()ed, and when called
> >        for TFO SYN+ACK, the socket is woken up by
> >        sk->sk_state_change() anyway.
> >
> >   * For the recvmsg() hook, skb is always NULL, and wakeup is set
> >     to true because tcp_data_ready() is not called in the path.
> >
> > An alternative would be to support bpf_setsockopt() by adding
> > BPF_SOCK_OPS_RCVLOWAT_CB to is_locked_tcp_sock_ops().
> >
> > However, that approach involves excessive conditionals and an
> > unnecessary memcpy(), costs we do not want to pay for every skb
> > in the TCP fast path.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/core/filter.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 94d07a15b2ab..9c4cd27c6d4e 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12346,6 +12346,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct=
 __sk_buff *s, struct sock *sk,
> >  #endif
> >  }
> >
> > +__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern=
 *skops,
> > +                                           int rcvlowat)
> > +{
> > +#ifdef CONFIG_INET
> > +     if (skops->op !=3D BPF_SOCK_OPS_RCVLOWAT_CB)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (rcvlowat < 0)
> > +             rcvlowat =3D INT_MAX;
> > +
> > +     return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);
> > +#else
> > +     return -EOPNOTSUPP;
> > +#endif
> > +}
> > +
>
> (Nice work BTW! I played a bit with this, but took a sockmap/stream
> parser approach instead -- this is much nicer!)

If you want to play with multiple sockets, sockmap is the right
choice, if not, it's slow and kills zerocopy.

>
> Curious if we can get into a situation that commit fcf4692fa39e ("mptcp:
> prevent BPF accessing lowat from a subflow socket.") fixed?
>
> IOW, we can construct a program that enables autolowat on MPTCP
> subflows, right? If so, do we need a similar check (or checking for
> subflows) in the kfunc?

Good point.  I'll rather drop support for MPTCP for now.
If needed, they can extend kfunc to call the mptcp-specific
rcvlowat function.

Thanks
