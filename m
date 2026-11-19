Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078108;
	b=DhftAgxpmnwamOGEOnroDs3g5zVQU5eswMA2cmouIn90kTAK/2SAHuWoblTmWzXa4E5H
	 qv82+F7KxKXGjz/Ug3nY12TyLh8bQfAZGSqxFPlOh+SVYwPPyyGTx0eeYlY2+2aqFSh26
	 wQWA6NRtMx7RpCKTeiGeHKJWGNLv54tJgl4SbPL3PJc0p3iFGA6GcYQmoxN/XzfGH8eew
	 FogitzYOWuiKOYaGsyXNVrko7Kiv0TF2EpALhJhsG/pSGqu+qHIotdKDT/f7zl+lQMBhp
	 QISY/mEjlxFoh73lWoGMVrSSIWaTuRNjl6iu1qxPuWpqpnIw65jW43iGH54DcpHpMeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078108;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2DGfvM7qByzpKVDZ+ShBLfzRqMDlNgUiCoMSZg5a9wA=;
	b=um0HtXJ2RNoP83sM5iPKx7Y8ljU85MXtpOCBmFTlPgF1MYJWTCA3MgUjeeKJi0/HH3x6
	 sLfl45D8itqksLEJDTEA5Eee7MiyCrxWF0rMqw2LhmWhQPq5Yny5L2f1j2DA7DXc910mZ
	 ouV28/l3YDmiGTShdahYJuwYCTcoPal6Rfu3ieEzTh58Wp4pqmNwLOGjGj/R13d4RG1Kt
	 XR/BGxpsLkdPIHSuLTWvFidB91+FEoOIOlA2GbcWsXD7n1jtiQ9IelBKdzqBP2trl9Yq/
	 ey45Pf42fJ4IZBqcS1uBC/6e7gyvzJ6zTxXEKu7TQI7jfoKneiXrAyTcNfwaOhY/RDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbD7H8Ao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25688606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbD7H8Ao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B583C1F000C5
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078107;
	bh=2DGfvM7qByzpKVDZ+ShBLfzRqMDlNgUiCoMSZg5a9wA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IbD7H8AohXhp9T6d2YizYcw3IEOLuMrBuGlnMP/hbh+qaH2NZTdQK6XvcpIrE0oLt
	 eHc6ujjspld2m0TEYAwidrOC3LxGtGaKnw4GKCw8ySRfUzZ4Odhw3Gpj41mcpbEysU
	 KwSMhSVthY55rm2q0VPKvTXGkf+noW3G742+9RJoMlOIyViTw1hCrWNTwJv7U0tkil
	 8uVY2XkPsM75Vl1FPJKgGPdbQyXYJ8UmQbgKlEldPQz2sDdL3mA2P4bON2hz91Vz7F
	 VlN0ZtaXlIFoVa3CBZN0aBOWryWOPLyc8rrAp60KRrbeUiKwgNVJkS/t8S0ItsL7/x
	 L4AkRxbD9a77Q==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-716c0217635so772122eaf.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 00:48:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFhMc+I3Gr1DhQXAVorwEl/l5t7Gi9p8mGN3qJGSFQaHKnsF/SRHKjy8w7jJdXFzr+gX3w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cxutpttfuu/gWesiQ1b7mueK8ZjapdqwTtr6HzZ6IT/ede8qP
	tEV8QyxPWFDFgMPXsTstIhP5fjhNbOq4Ju/zEp1aNYPNu77PdgXfXEtl7PjmnDJNm8uuoroL2YZ
	GaQLXdrqwCEwNNIv128XSZOAmDqoBc68=
X-Received: by 2002:a05:6820:340c:10b0:71a:d047:6555 with SMTP id
 006d021491bc7-71b325f3a96mr154013eaf.23.1795078107107; Thu, 19 Nov 2026
 00:48:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118210933.2477423-1-thaisonphan@google.com>
In-Reply-To: <20261118210933.2477423-1-thaisonphan@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 19 Nov 2026 09:48:15 +0100
X-Gmail-Original-Message-ID: <CAL4WiioV7HyfBS=RZhGLkeGVyZEHf85fTueKvXD4s+aO3fRTqQ@mail.gmail.com>
X-Gm-Features: AclHuK9F0ayhafrQxHgp6uPjGOaq2j-B5wMREskCAbT73MrvpLVLr_jmqjYYh6w
Message-ID: <CAL4WiioV7HyfBS=RZhGLkeGVyZEHf85fTueKvXD4s+aO3fRTqQ@mail.gmail.com>
Subject: Re: [PATCH net v4 0/2] tcp: initialize missing request_sock fields in
 syncookie path
To: Thaison Phan <thaisonphan@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Simon Horman <horms@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Olivier Tilmans <olivier.tilmans@nokia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, Stan Iliev <stani@google.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 18 nov. 2026 =C3=A0 22:09, Thaison Phan <thaisonphan@google.com> a =
=C3=A9crit :
>
> Initialize missing request_sock fields for TCP connections accepted via
> SYN cookies, where cookie_tcp_reqsk_alloc() and
> bpf_sk_assign_tcp_reqsk() allocate without __GFP_ZERO:
>
> - Patch 1 initializes ireq->ir_rmt_addr and ireq->ir_loc_addr to
>   LOOPBACK4_IPV6 in cookie_v6_check(), matching tcp_v6_init_req().
> - Patch 2 initializes the AccECN request_sock fields in
>   cookie_tcp_reqsk_init() and sets syn_ect_snt in cookie_{v4,v6}_check()
>   for kernel-generated cookies (!req->syncookie), matching
>   tcp_openreq_init() and tcp_{v4,v6}_send_synack().
>
> An AI coding assistant helped audit the request_sock initialization
> paths, write the QEMU reproducer, and draft the changelogs.
>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

> v4:
>   - Patch 2: restore treq->syn_ect_snt =3D 0 in cookie_tcp_reqsk_init()
>     and guard syn_ect_snt updates in cookie_{v4,v6}_check() with
>     !req->syncookie for BPF custom syncookies; document in changelog
>     (Sashiko, Eric Dumazet)
>   - Patch 2: add Reviewed-by tag from Matthieu Baerts
> v3: https://lore.kernel.org/netdev/20261117124710.1338951-1-thaisonphan@g=
oogle.com/
>   - Patch 2: clarify syn_ect_snt / tcp_accecn_third_ack() description
>     for AccECN connections and reference RFC 9768 Table 4
>     (Chia-Yu Chang)
> v2: https://lore.kernel.org/netdev/20261116023709.132684-1-thaisonphan@go=
ogle.com/
>   - Patch 1: clarify how KASAN (via SLUB_RCU_DEBUG) exposed the bug,
>     explain how it was observed, and include the inet_sock_set_state
>     trace line (Eric Dumazet)
>   - Patch 2: drop redundant treq->syn_ect_snt =3D 0 in
>     cookie_tcp_reqsk_init() and clarify how the bug was found and
>     observed via TCP_INFO (Eric Dumazet)
>   - Add Eric Dumazet's Reviewed-by tags
> v1: https://lore.kernel.org/netdev/20261114161248.3428695-1-thaisonphan@g=
oogle.com/
>
> Thaison Phan (2):
>   tcp: initialize ir_rmt_addr and ir_loc_addr in cookie_v6_check()
>   tcp: accecn: initialize AccECN fields in syncookie path
>
>  net/ipv4/syncookies.c | 7 +++++++
>  net/ipv6/syncookies.c | 6 ++++++
>  2 files changed, 13 insertions(+)
>
>
> base-commit: 2a324a58a084c5cfd7e5a2f55e0786bee170a4a5
> --
> 2.56.1.831.g720f3f5937-goog
>
