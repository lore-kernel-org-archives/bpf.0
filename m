Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794887754;
	b=YKOA3pHBw00zpg8LFpRWRoUdWx+TN+87hRlozvm5Kqn8OGT+NRVcwx51fi96VG/qCksi
	 lWvTOvg3kQRPlxrN56Xo0JWtazFA4oTgDKfMMNiDDb2h6CdhA2rm1Tphn5jazmgzgb8pY
	 wPl/4qNe9bhauDHh5hWEQwUMMoyK+d5SconDmk/7DrsMsrKrwxJQ8Om1+VxHQDka5v+U+
	 R8I1Un44ipLM/Rg5igeuA7uB1mK+U3vuG+UKONpWJuVN2uGqYa/ADB3iW7/5R4gM1+8XW
	 PeDW7YMyFpCaAutR++nVPYuxQHUgigTL60RP4k2ZlkIJ6krb0DN5zzFU7NmyIxkivuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887754;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y/TyAvk74dgLA8hHrTwO08MCjUsfwRDt7Lqn6mOj2ok=;
	b=VEuuyTJvRI0tbKzlM2MJNoz5QTNmW4Q7w6vF5Q1GV6O0ya8dgbXZ+/4Tz1TvGRweqddd
	 AmEUReJz42T+N5wSRGQ04z3klALVCJB9GI8k82Gdwn3E6brzCttSGeAtUCyVx+74eAiUR
	 WBgcqLHWyEUiTCeiMfOgQcgn/Wike7q9gPepADGka7PndteSqkFj93snDK6FdyCZ5Y0wK
	 OjBKXkopvXVqBM1yO85OV4f5F4/TNfNMyWZYjEqvOBhPXpfVB/n0rciPk6Th+riu7INCg
	 6Cs4kmMfkmo9L+xlEfeJZNtWCJKFIuZHwoEtFSfVSkZVYXPHy0VuAkZ8KakMMAADN6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJqxnAFc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE2606A88C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJqxnAFc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708821F000CA;
	Tue, 17 Nov 2026 03:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794887753;
	bh=Y/TyAvk74dgLA8hHrTwO08MCjUsfwRDt7Lqn6mOj2ok=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kJqxnAFc0HcNkUIwBLL1xJu6YLA1yn8nuWJfJl33Do3TOTfKpugQMG9d7kxYXddQv
	 c+NoNu3GGB0ZKcPBRlaN29ew4iOwJ3k9QJtn8yeW2dFalvoVOxc/GrjI1332pIGLHL
	 Wt3/7xzUuuDJOHqJcfFDMaWs9H4GIpMFEA9KRd0qlMt4pdgrShwe5A79qHsZHZ+h64
	 1Qr1mcVkQV7HDxtcuniU0OXdW9QSHQ/TaOceILyKT7oagVgwl2UWo1Bw6/Z3ADZN8T
	 Hg2z1jM89/UIZ4KBY8xlXvoTPuj1JPG/VwZYN/VzqnjFHx4rUdH8+wviMcLc3N+Mln
	 xWHi7PmJc0KKg==
Message-ID: <sashiko-outbox-218170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] udp: fix reuseport rescore fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <8c46325c4a433f02fdc7241c0c3884126cb502af.1794759652.git.zihanx@nebusec.ai>
References: <cover.1794759652.git.zihanx@nebusec.ai>
 <8c46325c4a433f02fdc7241c0c3884126cb502af.1794759652.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:55:53 +0000
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
- [High] udp: score > badness check on rescore breaks SO_REUSEPORT
  selection
--

commit ab974582f7bf280a71fe95ae3563909536a788c1
Author: Zihan Xi <zihanx@nebusec.ai>

udp: fix reuseport rescore fallback

This commit updates udp4_lib_lookup2() and udp6_lib_lookup2() to fall back
to the current candidate socket sk when a socket selected from a reuseport
group with connected sockets does not score higher on rescore.

Link: https://bugtracker.nebusec.ai/f/net/ipv6/udp.c||udp6_lib_lookup2||soc=
ket-hijack||m7q

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 2e5562f353f85..23a8c951559c7 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -475,12 +475,17 @@ static struct sock *udp4_lib_lookup2(const struct n=
et *net,
>  rescore:
>  		score =3D compute_score(need_rescore ? result : sk, net, saddr,
>  				      sport, daddr, hnum, dif, sdif);
> +		if (need_rescore) {
> +			if (score > badness)
> +				badness =3D score;
> +			else
> +				result =3D sk;
> +			continue;
> +		}
> +
>  		if (score > badness) {
>  			badness =3D score;
> =20
> -			if (need_rescore)
> -				continue;
> -
>  			if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
>  				result =3D sk;
>  				continue;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 9dcefa1625223..c5adeaaf5b428 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -234,12 +234,17 @@ static struct sock *udp6_lib_lookup2(const struct n=
et *net,
>  rescore:
>  		score =3D compute_score(need_rescore ? result : sk, net, saddr,
>  				      sport, daddr, hnum, dif, sdif);
> +		if (need_rescore) {
> +			if (score > badness)
> +				badness =3D score;
> +			else
> +				result =3D sk;
> +			continue;
> +		}
> +
>  		if (score > badness) {
>  			badness =3D score;
> =20
> -			if (need_rescore)
> -				continue;
> -
>  			if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
>  				result =3D sk;
>  				continue;

[Severity: High]
Does checking score > badness when need_rescore is true discard the socket
selected by reuseport whenever it has the same score as sk?

Before jumping to rescore, udp4_lib_lookup2() and udp6_lib_lookup2()
already set badness =3D score for sk.  When reuseport_has_conns(sk) is true
and inet_lookup_reuseport() or inet6_lookup_reuseport() selects another
unconnected socket in the group with an equal score, score =3D=3D badness on
the rescore pass.  The strict score > badness check then takes the else
branch (result =3D sk), regressing efc6b6f6c311 ("udp: Improve load
balancing for SO_REUSEPORT.") by delivering all traffic for unconnected
sockets in the group to the first matching socket in hslot2->head.

Checking score >=3D badness in the need_rescore block would keep result when
it scores at least as well as sk while still falling back to sk when
result scores lower.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794759652.gi=
t.zihanx@nebusec.ai?part=3D1
