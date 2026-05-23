Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612332E692
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528575; cv=none; b=b8qddfKDyLwZAroIPyQojJ4cOkakiIddV/lnjA0Y8TwDAeuDG8VpkL3McSIp4Z9SQagtGObVoMV5zkuwuYUmh6kn2mqHVUJuZFOrM1KDjzsVrJZaenTwQFXkVaY7caFSbiB7+2TMOCd9L4XMvy6KFi877W3RySjVfMk4intcZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528575; c=relaxed/simple;
	bh=75AjGX91MFqqKLTNnUyLVT8FZMLfcwPNWxjc4d+ZfBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ckgUf7Y5kFTM3Il+LxWUm7yVsctJ05v4goQTyi5rAbN0mtc7EfUKa0en/auAAZxzkMnMUE0SVoExizR0UjQA/uxvFuPWXzj9t69lszE3lnFCKrRujK1eJnQ+vd86i2ch3eyGuZGn3CKoNiVfLkZ6S2p0BGZqmgiZUspAWeUOlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMT+J2rP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMT+J2rP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3551F000E9;
	Sat, 23 May 2026 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779528574;
	bh=mj9AlI9e0CZyFXc2qrpofdZb7fHcr93Fo72T06q27gc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMT+J2rPUJ+lUjT+ZvD5IisjlyrzyrEsc7Qb42xFgYkbittGXMhViZcGKNf4cfjtF
	 bTnHZhIaNUeeSh1eRU/Q1K4nMciPrNSZl1znXZkiU3I2Tgcywq4p9p1zsG5GqTCXMl
	 2LRq+f7c5LxoLCoPrCG3Fa2pG0CbHlUaRrB2XC5sU4aH5wvPnOxSn2UzyrOuGB1Vaz
	 485HY8MvNUeMf98tzGqi0rxaDmk27AY3sDg4qbKHTS1Et5kcabUtgyypwGtX5OxlxQ
	 C1KwjD+WNO+DkOe9sWYgFROnTimZ2CzgEj6AbhmGtxSVlC4Cg8FwQlXS4ReqBliKHp
	 o8bwuphP9hCTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB
 and SOCKMAP mutually exclusive.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260523083001.2911931-7-kuniyu@google.com>
References: <20260523083001.2911931-7-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 09:29:33 +0000
Message-Id: <20260523092933.DE3551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The mutual exclusion between BPF_SOCK_OPS_RCVQ_CB and SOCKMAP is c=
ompletely bypassed due to a Time-of-Check to Time-of-Use (TOCTOU) race cond=
ition.
- [High] tcp_in_sockmap() fails to detect a sockmap if an Upper Layer Proto=
col (ULP) like TLS is attached, allowing the mutual exclusion to be bypasse=
d.
- [Low] Calling tcp_in_sockmap() in net/core/filter.c breaks the build when=
 CONFIG_BPF_SYSCALL is disabled.
- [Low] Using relational operators on pointers from different array objects=
 is undefined behavior in C.
--

commit ebabac3763475d472254639d69b23d839f36111b
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive.

This patch aims to make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive,
as both can intercept and handle socket receive queues. It introduces checks
in tcp_bpf_update_proto() and __bpf_sock_ops_cb_flags_set() to prevent
both from being enabled on the same socket simultaneously.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index c6a6853909c4b..bc95d8e7b62e8 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2853,6 +2853,7 @@ struct sk_msg;
>  struct sk_psock;
> =20
>  #ifdef CONFIG_BPF_SYSCALL
> +bool tcp_in_sockmap(const struct sock *sk);
>  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r=
estore);
>  void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
>  #ifdef CONFIG_BPF_STREAM_PARSER
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3608036632a81..1fb63b264b181 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -5382,12 +5382,34 @@ static int bpf_sol_tcp_getsockopt(struct sock *sk=
, int optname,
>  	return 0;
>  }
> =20
> +static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
> +{
> +	if (!(val & BPF_SOCK_OPS_RCVQ_CB_FLAG) ||
> +	    tcp_sk(sk)->bpf_sock_ops_cb_flags & BPF_SOCK_OPS_RCVQ_CB_FLAG) {
> +		tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +		return 0;
> +	}
> +
> +	write_lock_bh(&sk->sk_callback_lock);
> +
> +	if (unlikely(tcp_in_sockmap(sk))) {

[Severity: Low]
Does calling tcp_in_sockmap() unconditionally here break the build when
CONFIG_BPF_SYSCALL is disabled? The declaration in include/net/tcp.h is
guarded by #ifdef CONFIG_BPF_SYSCALL, but there does not appear to be a
dummy fallback for when it is disabled.

> +		write_unlock_bh(&sk->sk_callback_lock);
> +		return -EBUSY;
> +	}
> +
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +
> +	write_unlock_bh(&sk->sk_callback_lock);
> +
> +	return 0;
> +}
[ ... ]
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..7e7966b095f9a 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -705,6 +705,16 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, r=
ead_descriptor_t *desc,
>  }
>  #endif /* CONFIG_BPF_STREAM_PARSER */
> =20
> +bool tcp_in_sockmap(const struct sock *sk)
> +{
> +	const struct proto *prot =3D sk->sk_prot;
> +
> +	lockdep_assert_held(&sk->sk_callback_lock);
> +
> +	return &tcp_bpf_prots[0][0] <=3D prot &&
> +		prot <=3D &tcp_bpf_prots[TCP_BPF_NUM_PROTS - 1][TCP_BPF_NUM_CFGS - 1];

[Severity: Low]
Is this pointer comparison safe? In C, relational comparisons (<=3D, >=3D)
between pointers that do not point to the same array object result in
undefined behavior.

[Severity: High]
Does this logic fail to detect a sockmap if an Upper Layer Protocol (ULP)
like TLS is attached?

If a socket is already in a sockmap and a ULP is attached, the ULP
initialization replaces sk->sk_prot with its own protocol structure
(e.g., tls_prots).

This would cause tcp_in_sockmap() to return false, allowing
__bpf_sock_ops_cb_flags_set() to enable BPF_SOCK_OPS_RCVQ_CB_FLAG
and bypass the mutual exclusion.

> +}
> +
>  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r=
estore)
>  {
>  	int family =3D sk->sk_family =3D=3D AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_I=
PV4;
> @@ -729,6 +739,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_p=
sock *psock, bool restore)
>  			sock_replace_proto(sk, psock->sk_proto);
>  		}
>  		return 0;
> +	} else if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG=
)) {
> +		return -EBUSY;

[Severity: High]
Can sock_map_update_elem() and bpf_sol_tcp_setsockopt() race here, allowing
both features to be enabled?

sock_map_update_elem() does not call sock_owned_by_user() and only takes
bh_lock_sock(sk). This means it can execute concurrently with
bpf_sol_tcp_setsockopt() from another thread which holds lock_sock(sk)
(because lock_sock() releases the slock spinlock).

If Thread A in sock_map_update_elem() calls tcp_bpf_update_proto(), it
checks BPF_SOCK_OPS_TEST_FLAG() before sk->sk_callback_lock is ever
acquired.

Concurrently, Thread B in bpf_sol_tcp_setsockopt() takes
sk->sk_callback_lock, finds tcp_in_sockmap() is false because Thread A
hasn't replaced sk->sk_prot yet, sets the BPF_SOCK_OPS_RCVQ_CB_FLAG,
and unlocks.

Thread A then continues and replaces sk->sk_prot to the sockmap protocol,
resulting in both features being active on the same socket.

>  	}
> =20
>  	if (sk->sk_family =3D=3D AF_INET6) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523083001.2911=
931-1-kuniyu@google.com?part=3D6
