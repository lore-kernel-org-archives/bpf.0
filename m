Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473510;
	b=hJjzGTgwirujkpodnurVKNoYbEMqYmoCt3EuuER1VPCD0fv/bBEGXYb77R6IXTSg+Nlk
	 LcP3vwnAxeYQQrDa+2l5NjM8OOebb6oLN3cja0VaIXzsqmffp5QpjMHUeQFM7iYGAtioF
	 NQKwFVb13j2XTPXMItPbFtTL1k4HNO0KBwUijVet1byPCDo2gHKG52mgohH578dOf6JQk
	 WcC396UCKAyb9zAUXC/Gb/IdtPggK8i31/0SlMWkZov98zMfYc9eKOkpV8wfievYLtB/D
	 B67M+T3Qib2lVOJFpz403U1W0x9Qa+3U9hP1DZFmYhmSlC7fgG2pO59TmZNiuXKMgJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473510;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JiDJqzlk2zSD12ddIvBgM86PdNXU9+98uTUQC2EpOP0=;
	b=4dfH+GYHgXWlLH8qwt25+MJ9tS6Mh881NpsCCs34tflrPY5GldsPCiL0p8DY6Tnl6+f0
	 RQo5Juk5KMYxMvQmSKRgL9GHwcQQoP0UX7qeDDkmQKFEdJbH4y0jdkOx+xECOwo99ub0B
	 w+gBvnYuOYLAq755e4o12rSWSxaYIfs82vIaFIposO/KijdBa+CUJyuWftzurvmYlxfAO
	 x4X5MsOytYyIbHdEJ6UU9PgaTte3YDC9A/onNe+eNWAt3QUaVe56LHVALfWBw+zu0Lw7h
	 jxjgWSWhzttHq/J8DsNfXfiKiw3hX7X5p9OCWM+cWPrKDlrFh7O1IxtV9GM+EYA2KJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+lgYL7B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B4606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+lgYL7B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9A51F000C6;
	Mon, 23 Nov 2026 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473510;
	bh=JiDJqzlk2zSD12ddIvBgM86PdNXU9+98uTUQC2EpOP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+lgYL7Blmj0lgQbtZgI0fglvRLujvOq5n41E6h7S+OgK5HIuM1bqhbWBcoYJJmSS
	 mQ0Ib046OeWsNYnbUh293eJv22bL2FYzOVLp6ij/LMFgEVDBtzjWaDagNmUTTqGNZC
	 xo0Qb0Q7KzSaHLabNr4opwfySI4oIvwSUyt65kX7iWmutBxG60RusH2L55u6smJ85V
	 ZYoV3lvb5lalt65C3EQTe9XNfJY9v9IHWkyp44zOPKqmm6C0jTVn1ie1TRRiGJUZdu
	 oNCvmkLIgT1JfcsSEy2e+jocuhotX1RBLTfp6sMs+8jzWJamC7g+gdMCP+Mj6lVy+9
	 P87a/Igjb7eXA==
Message-ID: <sashiko-outbox-230151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/7] libbpf: Report function argument
 relocation support via type existence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <almagui@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123223227.745345-6-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
 <20261123223227.745345-6-almagui@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:38:30 +0000
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
- [Low] libbpf: multi-line comment style violation in
  bpf_core_spec_match()
--

commit 4236a42c871ff888d9de43484f575fb4195ce34b
Author: Alan Maguire <almagui@kernel.org>

libbpf: Report function argument relocation support via type existence

This commit resolves BPF_CORE_TYPE_EXISTS relocations against function
argument structs to 1 when matched against the attach target, and adds
bpf_func_args_supported() to bpf_tracing.h so programs can detect whether
function argument relocation is supported by the loader.

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 2f6627952220b..ed566a55cb068 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -907,8 +907,15 @@ static int bpf_core_spec_match(struct bpf_core_spec =
*local_spec,
>  	targ_spec->relo_kind =3D local_spec->relo_kind;
> =20
>  	if (func_args) {
> -		/* only field accesses (args->x...) of the arguments struct
> -		 * have a meaning for function argument candidates
> +		/* the existence of an arguments struct indicates that it is
> +		 * matched against the attach target, as only libbpf and
> +		 * kernel versions supporting that find a candidate for it,
> +		 * allowing programs to detect that support
> +		 */
> +		if (local_spec->relo_kind =3D=3D BPF_CORE_TYPE_EXISTS)
> +			return 1;
> +		/* otherwise, only field accesses (args->x...) have a meaning
> +		 * for function argument candidates
>  		 */

[Severity: Low]
This isn't a bug, but BPF coding style puts the opening /* of multi-line
comments on its own line rather than placing comment text on the first
line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123223227.7453=
45-1-almagui@kernel.org?part=3D5
