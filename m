Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583234;
	b=pgGdqBWOy4/n5ZCUSNtw3A/gmp15bnuxED3nexgvMxCwZ9Q6VgJcr54rkAt5FXaWHdea
	 77vl/1z7sDHg5m1TnEwDrhNwgCzX8hpJ8apmf/cbEcxBOApvY4QNa3rtzVhwYdqHzzNDx
	 Hq/02w7NuPJmn1joVHJfKxQDBbrSe9CIns6YaooUuiSVcE+13vauF0pAYl8pBCENnBIgR
	 Xr+uy3Bp2aze6XU4W3OuuvZ+v9/UqtpMtEzhfX81GKWUa1o/KcZZq3zevyFFOaSogHbNQ
	 KMMXrDs3tgiPqAsBI/V/Wz0eqO52J9/Pcpd1ChRWsG1vAau365PagPF4I/FggyGO7Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IdDgTKCxpf1nuZkRqrogBGqvSxTe75AAA2ASqP0X8XQ=;
	b=fqbMOxuFWzqxT55S0UEfAGqIcfTNRd5niyZ8P1+i7dHdrUZPoKgxMqNz3FR1ygRlRVr2
	 TQAiu7/xob7Jgikr8iEgJR/j8Tr2XI7nPLeGb4Wf0V6Pk/ug66K57RdmJ7X3wdcVFgxde
	 PXUTlJ3fvYmOCkslQsnRo4AAWILmMlgVCwCxRqP4LZTfmy9vNX++aAY5oEANa6VVho39p
	 J3j9mAxj7Y6Ue+xQYYrL8LJadzk+bCLI7xElnCVfUlKp5E2OWxJFEEGq6YmT14dVUinvB
	 02osmU5Qxip/2TiuCE5LFFr/H0gmm+yegQeyeTuQ8gsEKWWmdHucuFMXyZDD8ePwbfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRO4uprZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E369606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRO4uprZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2871F000C1;
	Mon,  2 Nov 2026 01:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793583233;
	bh=IdDgTKCxpf1nuZkRqrogBGqvSxTe75AAA2ASqP0X8XQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hRO4uprZv08uflDv3zp0ZwIBxCkCgou0XCJZgeWxaYO8qIJcIccvrYBr8w/2E8CnQ
	 NY4XAzL434Uqg4zmn/oHvPeHpOuvpAwvj9p9yx3W5cYXoIBMYK69f8hU+NIne4CFVY
	 RRwXUj4UOtwGWCz3IUZ8581DSH6AnVi7V06jMdO7ZfJIMnAxc893r0d8yD6My4OPMM
	 OTVjDMGpvwoUXCCgVkT3f8aJYP2WZ5hwQ7n2Uw54UHjK22tKLSQu6Lygf8jYu0aYiU
	 sFlzh3r9Ps9KRCwR/mExGq43G39W+KGogMTm0yG0ZXGnMx8UjAdFt/PFj6fxUxnjrb
	 SCy5Bjrh84FNA==
Message-ID: <sashiko-outbox-192806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 4/4] bpf: Mark bpf_iter__sockmap::sk as
 PTR_TRUSTED
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261102-sockmap-update-limit-iter-v2-4-e96a63c43b39@rbox.co>
References: <20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co>
 <20261102-sockmap-update-limit-iter-v2-4-e96a63c43b39@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 01:33:53 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: unlocked socket destroy via bpf_sock_destroy() in iter/so=
ckmap
--

commit 97a776f78529c30ceec62254569454f51205e10f
Author: Michal Luczaj <mhal@rbox.co>

bpf: Mark bpf_iter__sockmap::sk as PTR_TRUSTED

This commit marks the sk field in struct bpf_iter__sockmap as PTR_TRUSTED so
BPF helpers and kfuncs can accept the socket pointer provided by iter/sockm=
ap
programs.

Link: https://msgid.link/DM92JCFA4X4U.30MTDH0KCPTJ@gmail.com

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 057e2f3c0265e..2a2a073728189 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1989,7 +1989,7 @@ static struct bpf_iter_reg sock_map_iter_reg =3D {
>  		{ offsetof(struct bpf_iter__sockmap, key),
>  		  PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY },
>  		{ offsetof(struct bpf_iter__sockmap, sk),
> -		  PTR_TO_BTF_ID_OR_NULL },
> +		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },

[Severity: Critical]
Does marking bpf_iter__sockmap::sk with PTR_TRUSTED allow iter/sockmap
programs to call bpf_sock_destroy() on an unlocked socket?

In net/core/filter.c, tracing_iter_filter() permits bpf_sock_destroy() for
any BPF_TRACE_ITER program as long as the caller supplies a trusted
struct sock_common pointer:

net/core/filter.c:tracing_iter_filter() {
	if (btf_id_set8_contains(&bpf_sk_iter_kfunc_ids, kfunc_id) &&
	    prog->expected_attach_type !=3D BPF_TRACE_ITER)
		return -EACCES;
	return 0;
}

With ctx->sk marked as PTR_TRUSTED in sock_map_iter_reg, a NULL check on
ctx->sk yields a trusted struct sock pointer, which matches struct sock_com=
mon
at offset zero and is accepted by the verifier for bpf_sock_destroy().

However, unlike bpf_iter_tcp_seq_show() and bpf_iter_udp_seq_show() which
acquire lock_sock(sk) before running the BPF program, sock_map_seq_show() a=
nd
sock_hash_seq_show() in net/core/sock_map.c only hold rcu_read_lock():

sock_map_seq_show() / sock_hash_seq_show()
  -> bpf_iter_run_prog()
       -> bpf_sock_destroy()
            -> sk->sk_prot->diag_destroy(sk, ECONNABORTED)
                 -> tcp_abort() / udp_abort()

Because bpf_iter_run_prog() sets current->bpf_ctx, has_current_bpf_ctx()
returns true inside tcp_abort() and udp_abort(), causing both functions to
skip lock_sock(sk) under the assumption that the BPF context already holds =
the
socket lock:

net/ipv4/tcp.c:tcp_abort() {
	if (!has_current_bpf_ctx())
		lock_sock(sk);
	...
}

net/ipv4/udp.c:udp_abort() {
	if (!has_current_bpf_ctx())
		lock_sock(sk);
	...
}

For UDP sockets in a sockmap or sockhash, udp_abort() will run
__udp_disconnect() and sk->sk_prot->rehash(sk) with no socket lock held at
all.

For TCP_LISTEN sockets in a sockmap or sockhash, tcp_abort() will execute
tcp_set_state(sk, TCP_CLOSE) -> inet_put_port(sk) and inet_csk_listen_stop(=
sk)
before bh_lock_sock(sk) without holding lock_sock(sk), racing with concurre=
nt
close() or abort paths.

For established TCP sockets, tcp_abort() will only take bh_lock_sock(sk)
without checking sock_owned_by_user(sk), running tcp_write_queue_purge(sk) =
and
tcp_done(sk) concurrently with process-context holders of lock_sock(sk). If
this races with __tcp_close() after sock_orphan(sk) sets SOCK_DEAD, both
tcp_done() and __tcp_close() can call inet_csk_destroy_sock(sk), leading to=
 a
double sock_put(sk) and use-after-free.

Should sock_map_seq_show() and sock_hash_seq_show() acquire lock_sock(sk), =
or
should bpf_sock_destroy() be restricted from running in iter/sockmap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-sockmap-up=
date-limit-iter-v2-0-e96a63c43b39@rbox.co?part=3D4
