Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786FC229B38
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938788; cv=pass; b=g1VHyTI4PpV78EA3Fy6Xd+5jjkxEjIYlmGuJGq7GwdbGFx5i7MnPJbWvQd4CqghCpa5vxLXW4OhoSJH4lcEZamK9sz2nuydCqob4Q7CxpKBTWNFiS9FyexVeTs4/ktz5j9cIMJr3mH7ZMIbhJxMIt2QRkSk04qOM6Wp35kpCN+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938788; c=relaxed/simple;
	bh=1mjK4bzoIfjfpA05yhN5AbaKrxIyn0c+nGmaQXfpgRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrxhuRG5Y9Rj8t+46Lh17UqcHdpvDv6s7jePCZS1K045i7zcvgrN4Wox1zcI560hJFPVLs9DCKNcQpdoP560F2CaDIjIFiGkyDQ5QcJPBSKrJ+KpfkGcHpVWeU9V9cYFbTld5ofAislAH3dWrdugBs7tOYVWHSaV1lZphzhUIJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmKmTgXj; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmKmTgXj"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so2049469a91.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789938787; cv=none;
        d=google.com; s=arc-20260327;
        b=LYedce1UOPvnOfwItOOA7MJ4oygz8tdaxtK2WZlGXwUUHOaJz+6K6FaBZHcbrt51hI
         CYafuzK0i7+RqB0UmaJmbdtk+vK2H7cTakO0cLirzXJV3T1/RhzE3yhtlxvNkDnr1hxZ
         6pXQv4ggy1TyFIsULWQkqj/DuB6f9zsnx9dGe87nfZsbdKOFoj6etaItqbOtOq1KD+Kc
         zjSn4bRBvdQ9ixjxXVykgYzEnRx0+i73CcRy2869SaJ4GQW2j03WfwAQqUX2HcLXzqCF
         84Whow1M8W8kGjQdc6hGWwoULFSTD87bQcTQAqztIEGwzoTkTmxoMKq24u2NGSePs3Oy
         hSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2TbkS5vrvn8yW8ujxuvZ93y2O9e7zUBaytbnHS0C3Ho=;
        fh=1MqXq3SNNQ40iDqjsOzR4YnWB9LepOoirnAu7lXYLXo=;
        b=oZhIRghnzwSP1d1XWppm8waptrpdCL9xmp7GxIArWCN+ycW+NrpeAq5VcFeuTd6lca
         pPD50B381+zYGWSfYkLeF20MbOMBeh0FAE9K41y/a1iGL8l1+RWV61bxwoe277CTZ4mw
         0JUgSiXBqxjQsmiIwlaQUlh7AH/GjpNKjvfQhsfkL7m6tO5TL9rAa2GRKcNS6PkUqylU
         wHjoK4QN2tFZgj9HoZaNGxvUtnca9tMO47AxMQXn395/wpgKFs+malJvJshvSW46OHWl
         gTk7xMJfzdcvX0S1W5X1oKC60B16fA/N3wXkTFYSMv/ssxgGY1E8lozlqntXbNFsPNtR
         gh/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789938787; x=1790543587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2TbkS5vrvn8yW8ujxuvZ93y2O9e7zUBaytbnHS0C3Ho=;
        b=hmKmTgXjNMoSPm3i7o6gtuCNIqQ8wG/qGnEjtnVGOk42t05iXwv1ttiaxZsTz9qDJD
         CjmcjWMxxukCjVE+y8gaD0pEDQOou/7regI4sZqvW6fn0oE8TN0G8pQFyK+4v8gCPAiM
         wuuj2Hr9EfOleGC1zkAldkdqK5ASgnA4ufXKhvwdj9db7Nv5xQt9I3dh5U1h6mhftsLy
         biKZJfs5e9hGa1GtuswO+g4nZJ6t1s2U995RlAhiMeqOkdF3KvyxixWfjJR+Jidw7e0y
         /LU5PAcP1ELQ37aZNjE8CeSZHWkN4OMphrR9BrJBnduqqY1ADIglqoq9OjLeCAGqlZFO
         +YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789938787; x=1790543587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TbkS5vrvn8yW8ujxuvZ93y2O9e7zUBaytbnHS0C3Ho=;
        b=21UChcjh0ULu3ZFWGWkWz5svxojD7JFM6h5xCkwddX777ZE7EYyJSrLcLdUxiUo3rY
         A8ezEYw+sk1jRyE98QRoXlAujvA3r7smoSCV2V5DpZE56/vJucpCf834Oi63shYd76wc
         vFlnr0ixM1DzmzVa4v1incmh+mO4mnqHSG0rhbTJZI0HXqvw0kReKO6xzOtKmUreexzo
         ks3YSCgFfvv1BIWsU4MFMo99laTDcReUWmGpJ9LDT/EFSdqNE/dltrDDLLwU8mHJiB80
         RaIfPAp54/HMD2Kk+58MOQfqAfPz/obzwuut0WaIB6LOXttHYl7Wv4+gJXlQ0f8ETalr
         6Tmw==
X-Forwarded-Encrypted: i=1; AKwUvBzVWKfa8bhqnhxuOUYxOQpjD+uh8Ih5x32fYhUguQ6KSpc6uHw55RDgV9XV4EPNAmHtnmA=@vger.kernel.org
X-Gm-Message-State: AFuF++laP36S4HLwO9tMYYvf0WQhZ5OjUCT86IrqCnpUef9rCzpsrphc
	YeOq7hHhIg6yrBolUliB+7AKzvUXIhkwRdwYD4xcBW9/9lKzDX2eNEbUsLiaPvq4nSbT7z9MDqR
	cLS37Xlu5qXXGoJOLwTqHd2OhvSDBJY6isQzTKrUV
X-Gm-Gg: AYBFou2KlE7m/Fo8NZ7se6R2PfUiyvkzgz7dLBxvhhyaGXfZ/G+dcoQb/9y1Ou97oUp
	DZnqxysgjYFUegtcQE+D9uiykaPJm8qVakMwzloqxK9HFBz9zh48BDV+O5AI7j8nuK6ptOFP2PM
	J05xxuqheZ5QBHolK99gdY0pVr1Z4B5CJ9nGtkidSg2HhMspW1JmLi6ThN2Y2j1JJsLrIDElgZC
	GmGMVRYKbu7Lo7YCL+RQapH4wOd5BXhFf5U8oK5FNLo6dLdV8nY8qgzkE1HCtE36EfxpQS10KdC
	e7lEctBt/9oCKOaw6bEhP9Lf4pRwQ8GQc7CmirpiIXPTlDk8VgdcB3W7bpiX3UnAsDqV5CAhZfJ
	ob1UsmuxxFqW8JOIMivMg5uHmxDTNVeCnh+u+AtOaKsRhe0szIvsQdzJpHUpuGIAjP51MKSVHl0
	D2pA==
X-Received: by 2002:a17:90b:48c7:b0:3a0:3d1c:2dc1 with SMTP id
 98e67ed59e1d1-3a03d1c3a24mr2589830a91.67.1789938786366; Sun, 20 Sep 2026
 14:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920195633.3033620-5-kuniyu@google.com> <386c023dc4bca44689253b97a3f71c7758d9a320a014cb12e21562cba72a3443@mail.kernel.org>
In-Reply-To: <386c023dc4bca44689253b97a3f71c7758d9a320a014cb12e21562cba72a3443@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 20 Sep 2026 14:12:55 -0700
X-Gm-Features: AcwNN1VOFKzOS0OdgPcvkrdxKWm41uZitVdcprTPwzhwp3cOlmHDu6WtAiYEeTU
Message-ID: <CAAVpQUB9p-ELucWW+Vk8NjCJv4eXr6Ux0f5OmWidFD-F1iTxgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] tcp: Split out __tcp_set_rcvlowat().
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, cleger@meta.com, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 2:01=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > In the enqueue path, tcp_data_ready() is always called after
> > the hooks in tcp_queue_rcv() and tcp_ofo_queue().
>
> Does this "always" claim hold for every enqueue-side hook site?
>
> Looking at the callers of tcp_queue_rcv() in net/ipv4/tcp_input.c:
>
>   - tcp_data_queue() -> tcp_data_ready() at line 5709,
>     but only if (!sock_flag(sk, SOCK_DEAD))
>   - tcp_rcv_established() fast path -> tcp_data_ready() at line 6694
>   - tcp_send_rcvq() (line 5565, TCP repair, tp->repair_queue =3D=3D TCP_R=
ECV_QUEUE)
>     calls tcp_queue_rcv(sk, skb, &fragstolen) at line 5601 but never call=
s
>     tcp_data_ready() or sk->sk_data_ready() at all
>
> And there's a third enqueue hook site the message doesn't mention:
> bpf_tcp_ops_enqueue_rcvq() in tcp_fastopen_add_skb()
> (net/ipv4/tcp_fastopen.c:284), which also has no following tcp_data_ready=
().
>
> So wakeup =3D=3D false doesn't always mean "a wakeup happens later" on th=
e repair
> and TFO paths.

This is mentioned in the kfunc patch.  TFO path calls
sk->sk_state_change() later and wakes up the thread anyway.

> There's no functional regression since neither tcp_send_rcvq()
> nor tcp_fastopen_add_skb() signalled the reader before this series either=
, and
> the later commit 0390d95e0979c explains the tcp_fastopen_add_skb() case.
>
> Could the changelog be more precise about which paths it covers? Perhaps =
naming
> tcp_data_queue()/tcp_rcv_established() specifically, and noting that
> tcp_send_rcvq()/tcp_fastopen_add_skb() have no reader to wake?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/355350=
82194
