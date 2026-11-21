Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258569;
	b=YWlQ6pFCjqkYKw4Z506A1H4a/PzOfPdGluYqeIfGpQzBleulKimXuZ2AKO8FreERs516
	 jgXlRC5X/WPOuH1jjCcIRUQIz6CwGPBgPxcSs26qfjXHPKdeOTD+0utdrOGmKICFEWPHg
	 Pr8K5oIhJqbo+lPzOIKGXBpeCvK1wrwGIRqScXIIcQyYKQ/0rpvbgFC4por3Wz3+08UXG
	 Rjb2iHMv0KSTlEzcUKwhgUnl5zi4P871U8yMgwCZKfVFW8ZezKyyQMri+7InOLvjKhSjP
	 L19gg1XmehtIe1N82mPH36VjoiaTnGKhYMQQcX+3nqf0tn7IRg96xxZWHJxUQbwtK8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/hbv3FbHHPX4zfdRU15VcM0qFmQRPQ3H8YRm5hatRq8=;
	b=o2UYThZup7eK14AtsVRIeOcQE+2SR1v2eFDBvZsuKS9FHQEaRuPOZekx/16taMKjJ3y3
	 wpMkpFLIZVJGKYKh4TgZuGLnuSuGbzR1GS0oI0C55ApO0jrQVxpCX3U1M1HibNbidzFWC
	 oLJIdWr9klZN0FJbgQDB7PJMXJg4QtdunpBSr5GOMYcAblsaz5lI8LZcBTNvbJp0tw+29
	 FdRE2VxdTAiGABcB6TAycqX6hH2kxbftZq3QAj42F0nqUeoVKmeYSfOhiieERAMA+Xf4g
	 CTW9bTXFLS0kvP/RKAVP7MSjUTTx+OIGEzstIcyCycrLo9PFXoBLpUNVyUsoDSdEYqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQem2KxK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867F606A325
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQem2KxK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5671F000C4;
	Sat, 21 Nov 2026 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795258569;
	bh=/hbv3FbHHPX4zfdRU15VcM0qFmQRPQ3H8YRm5hatRq8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RQem2KxK9a5Cduu9vaMLbrq7XI4KHzoZar36C+BjsdtPtz68cd7qRO6Ao0TGPsxCx
	 hSB+l9a+sxcU5yt6+EbB3ac0KiWPufN6IXH+wRo+czRbmOSoMXoBgtIXS/fc60NlBc
	 tbRUTmbLETUpYSWtrsRP28G/RRn4fi2FLfdvSdQmzDHgYzlrTkpBdjlX51Jiaqu0V5
	 W39HEpw6FQayYuj19iz+TtF63xnAbTd5sgUbsdEoM8NJ9p8BqQD8jx+XIOGs6ixt9m
	 OoAPk5qDgzfXEqiRSvWqpR7E5LHGwrIX6/0igTv0peqkjZwTj+Sq4ElFUSLXxS1TH/
	 mB9sVkcKPp3OQ==
Message-ID: <sashiko-outbox-226962@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 08/11] bpf, sockmap: Fix socket lock taken on a
 child before accept()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261121103222.88209-9-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
 <20261121103222.88209-9-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:56:08 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf, sockmap: lock_sock() still taken on unaccepted child in
  strp_done()
--

commit e631a931dbfb1352e17feb424d762db532b4db74
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, sockmap: Fix socket lock taken on a child before accept()

This commit avoids taking lock_sock() on unaccepted child sockets (where
sk->sk_socket is NULL) by rejecting sk_msg redirects in
tcp_bpf_sendmsg_redir() before locking and by unlinking such sockets
without locking in sock_map_free() and sock_hash_free().

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index d8187a9823d18..8cf8ba6269561 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -386,6 +386,19 @@ static int sock_map_link(struct bpf_map *map, struct=
 sock *sk)
>  	return ret;
>  }
> =20
> +/*
> + * The listener frees a child that nobody has accepted yet without waiti=
ng
> + * for the owner of its socket lock. Unlink such a child without the loc=
k,
> + * as a delete does.
> + */
> +static bool sock_map_free_lock_sk(struct sock *sk)
> +{
> +	if (!READ_ONCE(sk->sk_socket))
> +		return false;
> +	lock_sock(sk);
> +	return true;
> +}
> +
>  static void sock_map_free(struct bpf_map *map)
>  {
>  	struct bpf_stab *stab =3D container_of(map, struct bpf_stab, map);
> @@ -402,12 +415,15 @@ static void sock_map_free(struct bpf_map *map)
> =20
>  		sk =3D xchg(psk, NULL);
>  		if (sk) {
> +			bool locked;
> +
>  			sock_hold(sk);
> -			lock_sock(sk);
> +			locked =3D sock_map_free_lock_sk(sk);
>  			rcu_read_lock();
>  			sock_map_unref(sk, psk);
>  			rcu_read_unlock();
> -			release_sock(sk);
> +			if (locked)
> +				release_sock(sk);
>  			sock_put(sk);
>  		}
>  	}

[Severity: Medium]
Can asynchronous psock teardown still take lock_sock(sk) on an unaccepted
child when the map has a stream parser attached?

When a passive TCP child is added at BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB to
a map with stream_parser and stream_verdict programs, sock_map_link()
starts the stream parser on the child and sets SK_PSOCK_RX_STRP_ENABLED.
Even though sock_map_free() and sock_hash_free() skip lock_sock(sk) here,
sock_map_unref() queues sk_psock_destroy() via sock_map_del_link() and
sk_psock_put(), which runs sk_psock_done_strp() -> strp_done():

net/strparser/strparser.c:strp_done() {
	WARN_ON(!strp->stopped);

	lock_sock(strp->sk);
	/* sync with pending strp_recv */
	release_sock(strp->sk);
    ...
}

If the listener closes while sk_psock_destroy() runs on the workqueue
before accept(), strp_done() locks the unaccepted child and
inet_csk_listen_stop() can still hit WARN_ON(sock_owned_by_user(child)).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121103222.8820=
9-1-jiayuan.chen@linux.dev?part=3D8
