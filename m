Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599034;
	b=SplxEWKcvM0AD1MRfjNuVvbzQdILK241seLmEDhfTJ91GYHzfDYn5FSorieidPS08yp8
	 0UskPHwUCD5t9qxWWa+vgPQMP4/ezm7lEE4MVVRFTUN1WZAeZfOzlScvRQUOkH8CcVf+6
	 kg6FjVXaTq7Bqp83VRQxeat2IR3SkSPJUCrWSdQMbgD+BoiIlS4MwYCzSCOvvInij/BS5
	 oxzB4JyNF6VxdijNapH6TF4sA2SpzOGSZ4AGEn3BRxEOhMzPxmy/S8yov2xoFaMep1mWM
	 nZjYSz22NRORvVRObfCh3iL4iPXLiU88MUJs/LfSll2c6U19t8QXMtP2H0TYH97DmtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+7Ujto4tjtuV9lFfiMh55O02RRTxCUDxJr9QcS5uaRc=;
	b=iasMJ9nT5jMGuhHCmOt2SCYxr3rhhlDNDWkG70eTJbah1eNZ4UgQuuFx9LgxQTZ1cfOY
	 mUCe36JTole2ByPOJMOQtSrqczCg7CUmoGH1CdwdGuXl80MpSeUeKz+Sebgd/uK/dpdgN
	 6xc9aM12xf8x3JclNaPunIsEAkGfhVzlGhichSS6LTCwvyt4O0qvoF+QHc2PmhssChRoe
	 HSBPq0yh/43/iDFCgLC7xCGL2rJv6hSTZM8eE5vvJkkaJ41sRylVNig4RDPtAyOHDT+ZD
	 5FAQXNzs5sVhMrv23sjBvqb5J3xMPA7ItToI0X9id4TOIe91kdekXh+2GS2xcURSa8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayZGeZ2y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22D606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayZGeZ2y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070CB1F000C1;
	Wed, 21 Oct 2026 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599033;
	bh=+7Ujto4tjtuV9lFfiMh55O02RRTxCUDxJr9QcS5uaRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ayZGeZ2yRdKMbjQdkgFx+6kbHruwxIFAgimpOtMezkw81uDDaOS4bdpP04eqbCxao
	 g/Y0rZeLcMEj9eWzFrxwKvnchZf2aAk8FFb6B2B06peRal6vy0NG2h0a5DUlPB6Z2v
	 QKtkBDEuVnQm0VmLt79xV7jxDyanl9rRi6z/n//nMApk8eEc30Ql7iTY/HcbUuQ6on
	 LQpON8+G48YOmThIGnoeMlE/p3gORqwGesDmw3DR4gTHS+QazXIJfKayE30IMmqrEL
	 gJQn4XZJyO/hvJvVJyv2xx71x2snd5Eh2FvJlLYMlJMlud0sleskcHRmPP+oHJ3YiF
	 RvJjwbMyDeWHA==
Message-ID: <sashiko-outbox-180459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: use READ_ONCE/WRITE_ONCE for
 saved_data_ready in the verdict path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dudu Lu" <phx0fer@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261021155629.68813-1-phx0fer@gmail.com>
References: <20261021155629.68813-1-phx0fer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 16:10:32 +0000
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
- [Medium] bpf, sockmap: incomplete data-race fix in sk_psock_start_verdict=
() and sock_map_unref()
--

commit 3aa9e245b4ee20f4b50e92e1de66b46757cb8a03
Author: Dudu Lu <phx0fer@gmail.com>

bpf, sockmap: use READ_ONCE/WRITE_ONCE for saved_data_ready in the verdict =
path

This commit annotates accesses to psock->saved_data_ready in
sk_psock_start_verdict() and sk_psock_stop_verdict() to address data races
with sock_map_link() and sock_map_unref().

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index df385a5a961e8..0bfb8c4e7f36d 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1260,10 +1260,10 @@ static void sk_psock_verdict_data_ready(struct so=
ck *sk)
> =20
>  void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
>  {
> -	if (READ_ONCE(psock->saved_data_ready))
> +	if (READ_ONCE(psock->saved_data_ready))
>  		return;
> =20
> -	psock->saved_data_ready =3D sk->sk_data_ready;
> +	WRITE_ONCE(psock->saved_data_ready, sk->sk_data_ready);
>  	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
>  	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
>  }
> @@ -1273,9 +1273,9 @@ void sk_psock_stop_verdict(struct sock *sk, struct =
sk_psock *psock)
>  	psock_set_prog(&psock->progs.stream_verdict, NULL);
>  	psock_set_prog(&psock->progs.skb_verdict, NULL);
> =20
> -	if (!psock->saved_data_ready)
> +	if (!READ_ONCE(psock->saved_data_ready))
>  		return;
> =20
>  	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
> -	psock->saved_data_ready =3D NULL;
> +	WRITE_ONCE(psock->saved_data_ready, NULL);
>  }

[Severity: Medium]
When a socket is concurrently added to and removed from sockmaps via
sock_map_update_elem() -> sock_map_link() and sock_map_delete_elem() ->
sock_map_unref() -> sock_map_del_link(), does this change actually resolve
the reported data races?

Every caller of sk_psock_start_verdict(), sk_psock_stop_verdict(),
sk_psock_start_strp(), and sk_psock_stop_strp() (namely sock_map_link() and
sock_map_del_link() in net/core/sock_map.c, and sk_psock_drop() in
net/core/skmsg.c) already holds write_lock_bh(&sk->sk_callback_lock).
Because all writes to psock->saved_data_ready are serialized by
sk->sk_callback_lock, the reads in sk_psock_start_verdict() and
sk_psock_stop_verdict() cannot race with a concurrent writer.

Meanwhile, sk_psock_stop_verdict() in net/core/skmsg.c still reads
psock->saved_data_ready with an unannotated plain load when restoring
sk->sk_data_ready:

	if (!READ_ONCE(psock->saved_data_ready))
		return;

	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);

And the sibling functions sk_psock_start_strp() and sk_psock_stop_strp() in
net/core/skmsg.c, as well as sock_map_link() in net/core/sock_map.c, also
use plain loads and stores for psock->saved_data_ready:

net/core/skmsg.c:sk_psock_start_strp() {
	if (psock->saved_data_ready)
		return;

	psock->saved_data_ready =3D sk->sk_data_ready;
	...
}

More importantly, the unlocked reads of psock->saved_data_ready that race
with sk_psock_start_verdict() happen in sock_map_unref() ->
sock_map_del_link() in net/core/sock_map.c under
spin_lock_bh(&psock->link_lock), before write_lock_bh(&sk->sk_callback_lock)
is acquired:

net/core/sock_map.c:sock_map_del_link() {
	...
	spin_lock_bh(&psock->link_lock);
	list_for_each_entry_safe(link, tmp, &psock->link, list) {
		if (link->link_raw =3D=3D link_raw) {
			struct bpf_map *map =3D link->map;
			struct sk_psock_progs *progs =3D sock_map_progs(map);

			if (psock->saved_data_ready && progs->stream_parser)
				strp_stop =3D true;
			if (psock->saved_data_ready && progs->stream_verdict)
				verdict_stop =3D true;
			if (psock->saved_data_ready && progs->skb_verdict)
				verdict_stop =3D true;
			...
		}
	}
	spin_unlock_bh(&psock->link_lock);
	if (strp_stop || verdict_stop) {
		write_lock_bh(&sk->sk_callback_lock);
		if (strp_stop)
			sk_psock_stop_strp(sk, psock);
		if (verdict_stop)
			sk_psock_stop_verdict(sk, psock);
		...
		write_unlock_bh(&sk->sk_callback_lock);
	}
}

Because those reads in sock_map_del_link() remain unannotated plain loads
outside sk->sk_callback_lock, won't the data race between
sk_psock_start_verdict() and sock_map_unref() still trigger? In addition,
if sock_map_del_link() checks psock->saved_data_ready before taking
write_lock_bh(&sk->sk_callback_lock), can it observe psock->saved_data_ready
newly set by a concurrent sock_map_link() and then call
sk_psock_stop_verdict(), clearing psock->progs.stream_verdict and
psock->progs.skb_verdict and restoring sk->sk_data_ready for the newly
added link?

Finally, regarding the race between sock_map_link() and sock_map_unref()
mentioned in the commit description, doesn't that race occur in
net/core/sock_map.c where sock_map_link() -> sock_map_init_proto() writes
psock->psock_update_sk_prot without sk->sk_callback_lock while
sock_map_unref() -> sock_map_del_link() reads it under sk->sk_callback_lock:

net/core/sock_map.c:sock_map_init_proto() {
	if (!sk->sk_prot->psock_update_sk_prot)
		return -EINVAL;
	psock->psock_update_sk_prot =3D sk->sk_prot->psock_update_sk_prot;
	return sk->sk_prot->psock_update_sk_prot(sk, psock, false);
}

which is not touched by this patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021155629.6881=
3-1-phx0fer@gmail.com?part=3D1
