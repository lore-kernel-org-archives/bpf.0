Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788246;
	b=BrwaE1qmSSTAnJujOZwpdqVfAp1asSYMk14eAOqO+aNm5yd+pxMOi38wYKF+EzZpx2KB
	 rY31G0QVQugISWBKCqdzjzHAFW362I+wYUWOzZKZV+9wrKJd70UrOmKDCeBsnJLYo0zMx
	 /+WNTzdYGm/OT7d6BHCmZ7Yj0/dDW2wQq7gjuL/Rmg4gK0S+sCj1/IiziI8cY3c9FEWc3
	 pUGSHiPePH5DX3Z+B0kR1qvKr5wMM/+Q2CFY0T54wEAInxs2Vquegqh2vw/f89i80QBtv
	 3gJRy2xW0cAXYrsHH2gVFcRLGNGH8rvD46Q10K0niD0HOlYtQ56iQO8hUVr+yTIqKBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788246;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=/oInJo8vXdWdzusi1A6UniTrK0nXFaYuOLA3sRJZHVo=;
	b=HHRZ/b3wuCzEYvwWVpmQmMY0g/SbwFwwwDk/3O95k4E8xnNw/i35wZzhqN3xUhqIFpyi
	 2AaY+hn/Dn0lzCryLeUwT8wWtmceVlyP2LJUiiwwcmFKYEhpV2hE3B7QGe5UXqxvTWyxW
	 ovhsUmqumUzO0dpJFT34c42z9zQaf2g/fgDL+kNqSTB2AsBqg8MvJMF5oBWlxB3xSIlI1
	 Xi12H5LMwBMoJKpwMdKVromkU+Z4aQNpuPC1YpEGA8gc9qCvfa0MdZ8bx6hELiFBUAmr+
	 eGo11ENqyboWTCmTXK14cvDWsJ7cNmEyxvEm3bwzjCzfasH9+6C7Ue+IrL8urN4Hnag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmvrnUMV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D6606A31C;
	Fri, 27 Nov 2026 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmvrnUMV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640FA1F00925;
	Fri, 27 Nov 2026 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788246;
	bh=/oInJo8vXdWdzusi1A6UniTrK0nXFaYuOLA3sRJZHVo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gmvrnUMVwfdN0snrK0lo2swGupjTqd8Atp2w+NKm7Ak134BtC9w3Qp4x0w2Tu3y2K
	 dRwC+sHsEmm98mEBlL4qvA7ytTSjXqJdahTOSjadAiVMEXV8KfAseTaHe7TLWdWIEg
	 Z6JNSKYOPSTE6hrxtKLEDtoLueuO15aH8FGdlrLaxtKvgiEc1NX5fvRxtrItVHlcmP
	 jvB/zNU6bJGXnW2k+vZ55TnUSghagm0coC7MXYZZrf/km4UPXExZr/HAKoRk9YXlvt
	 yH9Xxhu6/6fRgq8JHGNuIR1r1q58tvU+AWuStPT/U+EoDstmJrplfeWOvUlLz+kD3O
	 wsfFnfbQJIJXg==
Content-Type: multipart/mixed; boundary="===============1281668951458116797=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3f89ad0cf49f89f8d10f230ecb61bd69bebef63465e260b3e4faf4e2eb65799d@mail.kernel.org>
In-Reply-To: <20261127133051.2540069-1-irlanki.s@samsung.com>
References: <20261127133051.2540069-1-irlanki.s@samsung.com>
Subject: Re: [PATCH bpf-next v10 1/2] bpf: tcp: add ecn_init callback to bpf_tcp_ops for per-connection ECN
From: bot+bpf-ci@kernel.org
To: irlanki.s@samsung.com,kuniyu@google.com
Cc: alexei.starovoitov@gmail.com,ameryhung@gmail.com,andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,corbet@lwn.net,cpgs@samsung.com,daeil2.hwang@samsung.com,daniel@iogearbox.net,davem@davemloft.net,edumazet@google.com,g.pokhra@samsung.com,irlanki.s@samsung.com,kuba@kernel.org,linux-kernel@vger.kernel.org,lorenzo@google.com,madhan.raj@samsung.com,maze@google.com,motomuman@google.com,ncardwell@google.com,netdev@vger.kernel.org,pabeni@redhat.com,r.kumawat@samsung.com,raj.kumars@samsung.com,ramyashree.s@samsung.com,sharmasagarika@google.com,sporeba@google.com,srihari.k@samsung.com,ts413.lee@samsung.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 27 Nov 2026 14:04:03 +0000 (UTC)

--===============1281668951458116797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: tcp: add ecn_init callback to bpf_tcp_ops for per-connection ECN

TL;DR:
- Commit message may misdescribe why syncookies skip ecn_init (no listener,
  not no request sock); a comment is suggested
- Design question: Kuniyuki's v9 concerns (route attribute, callback cost) may
  be unresolved

>     bpf: tcp: add ecn_init callback to bpf_tcp_ops for per-connection ECN
>
>     [ ... ]
>     the default via bpf_get_retval(); an out-of-range return keeps it. With
>     syncookies no request_sock is created, so the program is not invoked and
>     the sysctl and route decide as before. No negotiated-mode state is
>     stored; the decision taken at handshake time stands for the connection.
>     [ ... ]

Is this accurate?  In tcp_conn_request() a request sock is still allocated
when syncookies are in use, and tcp_ecn_create_request() still runs on it
and reaches tcp_ecn_init_bpf():

    req = inet_reqsk_alloc(rsk_ops, sk, !want_cookie);
    ...
    tcp_ecn_create_request(req, skb, sk, dst);

The program appears to be skipped only because a syncookie request sock is
allocated without a listener (attach_listener is false, so rsk_listener is
NULL).  That makes sk_to_full_sk() return NULL inside bpf_tcp_ops_call_int():

    struct sock *__sk = sk_to_full_sk(sk);
    ...
    if (__sk) {

If the program did run on a cookie SYN, its ecn_ok decision would be encoded
in the cookie timestamp, but the ACK path re-validates it with
cookie_ecn_ok(), which reads only the sysctl and the route.

Could the commit message describe the actual mechanism (a request sock with
no listener, so sk_to_full_sk() returns NULL)?  Would a short comment at the
tcp_ecn_create_request() call site also help keep the two paths from
silently disagreeing later?

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h

[ ... ]

> @@ -3035,6 +3035,12 @@ struct bpf_tcp_ops {
>  	 */
>  	int (*rwnd_init)(struct sock *sk, struct request_sock *req);
>
> +	/* Should return the ECN variant to negotiate in this handshake:
> +	 * one of net.ipv4.tcp_ecn values. bpf_get_retval() has the sysctl.
> +	 * @req as in timeout_init().
> +	 */
> +	int (*ecn_init)(struct sock *sk, struct request_sock *req);
> +

Kuniyuki Iwashima raised design concerns on v9 that do not look fully
resolved.

He asked why ip-rule (or VRF) with a per-route attribute cannot be used,
noting that a route attribute would also work with syncookies:

> Why can't ip-rule (or VRF) be used with a per-route attribute ?  Also, a
> route attribute would work with syncookie. ... one concern would be that we
> end up adding more single-purpose stateless callbacks during 3WHS, which
> could be more expensive than stateful solution.

The v10 respin only adjusted the commit message and applied his nits.  Was
there a reply on the callback cost question, or from Amery Hung whom he
asked for input?  Is ecn_init() still preferred over a stateful approach
such as rwnd_init() plus a kfunc, given that syncookies still bypass the
callback?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/46008849646
--===============1281668951458116797==--
