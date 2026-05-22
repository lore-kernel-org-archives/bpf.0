Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91A2C032C
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439575; cv=none; b=di0cwYw7iAsbp0x7Yo+ud7F5N2H8CoxhxRYq4lISJBQ+d5ajpgxKtblUtZiVtZ9zkHheGrhIuWluN7zCW3dF1uevsNYvGHAMvzlXsoD+EmWtxGK3+2Mb3bC4g0ux1mZ4zOFeRGnd6qWJRR4Mi1s/wcUw+mnHo50cavlBpgqhwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439575; c=relaxed/simple;
	bh=Wiy5wnIpqaX6jCxhc+EL89mk3N4WXBLdOzaQWxos6DA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ds8EpeaHj2kLC9MhLHjwkg15+1qxl5jwMjtuQD8epRmClXQFNdwAjiGqyE21Ux5YRX35BFyYvTTanwHHGVXFaDIp7+gLnkHBb3/ETBxqjFWQ6VcXpWnwk4BE2k94Qg/MUyqKCzuKP0Uo7ekEnGRhB5ny+8ZHLXQlahghuhf5MLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwVw96Mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwVw96Mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC71F00A3E;
	Fri, 22 May 2026 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779439574;
	bh=+rsZNksX9fI+e6HPioFUoRj6OuK7ypJp8VN4qgCzVvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XwVw96MrV38Z+6euSWb+i0M3UzwnURjkU1WFSeEH3CWNMsOEi94IvfuzSACdOGos5
	 cp3ndCrbI9qfFIXyJUGAJQUYR5J0dTyoeNAttWm5zPXqdR8L82FEnxtPVRKlyq+hl8
	 /oDKX8byWtNTA0b0sm8qZPos365RShtxZAU7145HLy3czCKHNe0OU8yXW8aJhUCP8D
	 rbqqIvwxDRJcmPk1B6lEQjmSCgHuc8BcBnFhfi0qkIhmLu6G3PDEDFsatBmt0JAQ7D
	 gttTeHJ/hntpco+3+P8LNxs8O36one9MwLAkq7TzIivs28LiPFUBcaQ7Yfn1+AQfDs
	 4IW9R80dushew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 06/11] bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB
 and SOCKMAP mutually exclusive.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522074601.1658705-7-kuniyu@google.com>
References: <20260522074601.1658705-7-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 08:46:13 +0000
Message-Id: <20260522084614.05FC71F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Using `sk->sk_prot !=3D &tcp_prot` to detect SOCKMAP incorrectly b=
locks other features (like KTLS and MPTCP) and introduces an order-of-opera=
tions bypass.
- [High] The mutual exclusion check is broken due to a TOCTOU race because =
`setsockopt` and SOCKMAP map updates use different synchronization primitiv=
es.
- [Medium] Lockless double read of `sk->sk_prot` without `READ_ONCE()` lead=
s to a data race.

Pre-existing issues:
- [High] A failed map update for an existing `psock` leaves newly attached =
BPF programs active in `psock->progs`.
--

commit 5e984d100188fbad217fad5406d80666b989f1b9
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive.

Both BPF_SOCK_OPS_RCVQ_CB and SOCKMAP can intercept and handle
socket receive queues, leading to overlapping use cases.

While BPF_SOCK_OPS_RCVQ_CB focuses on optimizing single-socket
performance by reducing EPOLLIN wakeups and fully preserves TCP
zerocopy support, SOCKMAP is designed to facilitate multi-socket
routing at the cost of higher overhead and no zerocopy support.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3608036632a81..ff7fd415486a6 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5382,12 +5382,27 @@ static int bpf_sol_tcp_getsockopt(struct sock *sk=
, int optname,
>  	return 0;
>  }
> =20
> +static int bpf_sock_ops_check_rcvq_cb(struct sock *sk, int val)
> +{
> +	if (val & BPF_SOCK_OPS_RCVQ_CB_FLAG) {
> +		bool not_tcp_prot =3D sk->sk_prot !=3D &tcp_prot;
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +		not_tcp_prot &=3D sk->sk_prot !=3D &tcpv6_prot;

[Severity: High]
Does this check falsely block other features like KTLS and MPTCP?

Since features like KTLS also override sk->sk_prot, if KTLS is attached
first, the check would falsely reject enabling BPF_SOCK_OPS_RCVQ_CB_FLAG
with -EBUSY. Conversely, if the BPF flag is set first, the check passes,
and a subsequent KTLS attachment would blindly overwrite sk->sk_prot,
allowing both features to operate simultaneously and bypassing the mutual
exclusion.

[Severity: Medium]
Could this double read of sk->sk_prot result in a data race?

Since sk->sk_prot can be concurrently modified by sock_map_update_elem(),
which only holds bh_lock_sock() instead of lock_sock(), the compiler may
emit two separate loads without READ_ONCE(). A concurrent modification
between the two loads could cause inconsistent evaluation.

> +#endif
> +		if (not_tcp_prot)
> +			return -EBUSY;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -5424,6 +5439,11 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk,=
 int optname,
>  	case TCP_BPF_SOCK_OPS_CB_FLAGS:
>  		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
>  			return -EINVAL;
> +
> +		err =3D bpf_sock_ops_check_rcvq_cb(sk, val);
> +		if (err)
> +			return err;
> +

[Severity: High]
The commit message asserts that checks in setsockopt and SOCKMAP map updates
are performed under lock_sock(), but can a TOCTOU race occur here because
they use different synchronization primitives?

While bpf_sol_tcp_setsockopt() uses lock_sock(sk), BPF helpers updating
SOCKMAP (like bpf_map_update_elem called from BPF_PROG_TYPE_XDP or generic
map updates via sock_map_update_elem()) only acquire the spinlock
bh_lock_sock(sk) and disable bottom halves. Because bh_lock_sock() does not
wait for lock_sock()'s sk_lock.owned flag, these operations can run
concurrently.

A concurrent SOCKMAP update could check tp->bpf_sock_ops_cb_flags (seeing 0)
and override sk->sk_prot while the user's setsockopt is validating
sk->sk_prot and subsequently setting tp->bpf_sock_ops_cb_flags. This allows
both features to be successfully attached to the same socket.

>  		tp->bpf_sock_ops_cb_flags =3D val;
>  		break;
>  	default:

[ ... ]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..5c5c67080740a 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -729,6 +729,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_p=
sock *psock, bool restore)
>  			sock_replace_proto(sk, psock->sk_proto);
>  		}
>  		return 0;
> +	} else if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG=
)) {
> +		return -EBUSY;
>  	}

[Severity: High]
This is a pre-existing issue, but does a failed map update for an existing
psock leave newly attached BPF programs active in psock->progs?

When adding new programs (e.g., stream_parser) to a socket that already has
a psock in sock_map_link(), the program pointers are updated immediately via
psock_set_prog(). If a subsequent initialization step like
sk_psock_init_strp() fails, the function aborts and calls sk_psock_put().

However, sk_psock_put() only drops the temporary refcount acquired earlier =
in
the function and does not revert the psock->progs changes. As a result, the
newly attached BPF programs remain permanently active on the socket despite
the map update failing.

> =20
>  	if (sk->sk_family =3D=3D AF_INET6) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522074601.1658=
705-1-kuniyu@google.com?part=3D6
