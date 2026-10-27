Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079103;
	b=URMu+IxZfCzOIb0TKBTt3e/67dg6SveoO1JPAifmJZUsV/wX2ZANAKHVPklA6z7YmF3K
	 fd2J5W+v5vEk6/cTkvMLcBvAacTZNElNwuDcFnmjdHZq7Nplt4v83qbeR4C4YlanLbUbv
	 D2iWdNXdUfO9wP5G8xcCZXjBRX6OjOJh+lxPjngJnawuIXrGU3iN0ZuKlwuYUjm4ZVcwd
	 1uRYVuy+w/hPlujqQg06eAjwobTeAFi7qgh34Lul4nBQqO4luOzJ8qMyyvd7XA/UW89S0
	 HfTMf6DlkWdWjIbnTxZsZJw/dL2IOYmxhE/QE/eSSoMTAjS6Mlh9g1uigTp70CW5i0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079103;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Vdr4C3PkcbVZsQqqGDmD8tEhG/m1kQL4TeacGRf3vdo=;
	b=A8xG2Jh1hstZ32YTyCPEKnUGCcN5PL2B/F3npJHjBErhtWqVL6FKGQgts2Ab5zLn+Woc
	 MRYYEoHBzV/IIkkV0p1uY1JItOLmD82iiJ6nYJ9EWDzC+iwb9vnkBj60ZftQf1+oSm8Vi
	 bUamXNb/iZkfZ+afxtFdCqV06msh5u8XhvWIDKeeEihydwchsFULBXO46K6hWvH8OyDi7
	 vuOvmQymmBMZ+8pTDJZFf7PnlhLyPQIbfhZZed/B9BSBwMoBsGQ9nnlAQh9oz4y6cpn3b
	 IC8zl9Dw0pAPsEwHKqjq8o1kzbhb26n7jt66iXXpOacrefu1A/P/MuWNtvOGHJUZNlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyO1L8zA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF5606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyO1L8zA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8671F01825
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 05:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079101;
	bh=Vdr4C3PkcbVZsQqqGDmD8tEhG/m1kQL4TeacGRf3vdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kyO1L8zAQpWi9xUkQbRxPY6Jss1nVwpRvCFjx05ldBQvcEb/zrIuYt4szVNe89Qg6
	 zmtRPChFJtOxHgQHxO0VrMSGeuSJGPZYSR+HWAIHDYpTeI8GDqOaSpH+Qd9q1Ycg+/
	 8IHawtMy6hfe0KIhBcFIO+/2URBo27mByOov2euanpvGGSrLp49MuY/009gBHToflQ
	 L35MgGMwd8bCFhVZyFeSoECY2g58JK3/XvqnmLdJ1SXOHTFNuEhHQ/s2UdiNR1ja0v
	 oW5sF54BYPB1cUIAnhxbCb6CZcWBJz2OHIpZH2WXGBEn9QAuU8eKThiRFeeorV0SHg
	 FNGbFIYk9Wxhg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a76f0cce5fso1437817fac.2
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 22:31:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxTfqorennHTIHaP+ctFXtD4CcKBMfVIyQ19a9HZ3/6+epuqHRYmKkl2XdA3p6mB5IrSx4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlOAiMJWpVTqK6AeSdrc+CQpHJ1BZkIJVAkwd1ZSVlnNZuR6uJ
	jINTd6JBARPpqzqqGF/ZUJQQKKfGWycfJ8mtXjqffsVY38ofhNZYEIXHXBfFFghxDLk0o7L5AxM
	o9g5dHpJfs2jWRGdGBbZySvV8iDXfz5o=
X-Received: by 2002:a05:6870:82a2:b0:45e:25a9:5455 with SMTP id
 586e51a60fabf-4a83f1cb4e4mr5508785fac.2.1793079101053; Mon, 26 Oct 2026
 22:31:41 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
 <auAv3AoY0FkcXIEr@google.com>
In-Reply-To: <auAv3AoY0FkcXIEr@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 06:31:30 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqu2Az-B1dZnVRJefW-F52ouzLQ5VQ56L3FxSaeXcXGvA@mail.gmail.com>
X-Gm-Features: AclHuK-fAzYz3D12aaK1VJX8HEDAnoy13ILnQawpMb1g_qhckuAXvvyZa-sKNj4
Message-ID: <CAL4Wiiqu2Az-B1dZnVRJefW-F52ouzLQ5VQ56L3FxSaeXcXGvA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] tcp: check congestion control restriction first
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	ncardwell@google.com, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, jonathon.reinhart@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 06:00, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> On Tue, 27 Oct 2026 12:46:49 +0800, Zhiling Zou wrote:
> > tcp_set_default_congestion_control() takes a reference to an algorithm
> > before checking whether a non-init network namespace may select it. A
> > rejected request returns -EPERM without dropping the reference.
> >
> > This affects module-backed algorithms too; BPF is not required. For
> > example, after root loads tcp_bbr, a user with CAP_NET_ADMIN in a
> > non-init network namespace can repeatedly request it as the default
> > although it is not in tcp_allowed_congestion_control. Each rejected
> > write leaks a module reference. Since module->refcnt is an atomic_t,
> > 2^31 such writes can make it negative; later module_put() calls warn,
> > and rmmod can hit the BUG_ON() in try_release_module_ref().
> >
> > Check the namespace restriction before acquiring the reference, as
> > tcp_set_congestion_control() already does.
> >
> > Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp con=
g to a restricted algo")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Assisted-by: LLM
> > Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
