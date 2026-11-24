Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560946;
	b=Wi45Yo4G6drNvtOL7zz9+QRomu754da8jTgTB4Y8pfu15Ld81V5aOUMFmfGbSW2oJKMw
	 N+oKQqYSUHydVRohhzFrziOKwCpqeikCuwCnVl+raQYYpA2s8kOvCVZh+a/vSglR1zs3O
	 zTCPD+3pzAiZn0wvBNNFbQvs+xN5nGJEKnsRUDubGi5XjHT+9YPBV825RYXpoIoD2s1mx
	 ar388XE7iHSC7E29Rty2exPnzqvf5EZn4BjqZXqt3Kx1PfG4lhFCpO/P2/lyumkeFhP/z
	 /HZhFdGuZ/cITFsLn59G2MzSpaCGEMIiMq4FQKCng3Irk5I8bwFAsHYqwwcnboys9AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560946;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=paK+J2HRq1Gqd98vL2jePpocwwMPdfkXzN8XzWJgC/c=;
	b=Q2gyKcHLybbQEmuIIPTKwa3QPAEmmW4UqRwWDuNoPgMUsEORRWmjU69/tt3Yli4Gx3Y+
	 vPjIqcWdmPDLgpdl2cWKYwDP/6offpYCDl+REUBNjD6B4P5xtELt28dSI4vD9icr0IY4s
	 p6n947pYEFpIRedXZm1w6e+cN/TszRYBuwK1p8X2Z3TIAoVf+H2+3j8CffW/mimmNvQzs
	 +fL8JOLZ1XUy7m0K6ujA+VhWZmW6Ecl+5hegInLLvbl9t5oJ2Edv88eo1mgPer+XfDZzd
	 NMfL7dUDa3MRUu5ZWaJnqqm+yF1h3LscRKZxojoHX4DFHXwWahLRKe6+Fo+B5VnCJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN8hGYhk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF9606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN8hGYhk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF781F000D0;
	Tue, 24 Nov 2026 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560946;
	bh=paK+J2HRq1Gqd98vL2jePpocwwMPdfkXzN8XzWJgC/c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BN8hGYhkotEeAMGWEuMpciLwdQ8L+y/VILx/K0Bjk1sXSSZk+EMzjpxMayHx3BE8o
	 85to9eDu9auRDkVFShXTJ2jOz7E04951+N4TFQ4KtisvPY3kvzEYVqFsXkYgjMwdTn
	 f9Rs+hgeZ49wV15ArzjwPDhqmA16TJrfCGuyiqxefMzz3ZAEI856WOAYX0j2uV2jKk
	 I2J4mQ4OalfONokpuhT2p6xddJEQy9Qgfk1XJYkkp+EAehIM7oXm6aqsJpTN1G+mL8
	 y6DSNMtjqTmgPtQ3BdxpA9KecRQSpyE6RYviyUf2Z3XxdMzWgH2FuhLTDW1aq06f+e
	 ZArs7IAZBdTrQ==
Message-ID: <sashiko-outbox-232175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] bpf: Align devmap values to 8 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Philipp" <tphilipp@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261124225055.87344-4-tphilipp@gmail.com>
References: <20261124225055.87344-1-tphilipp@gmail.com>
 <20261124225055.87344-4-tphilipp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:55:45 +0000
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
- [Low] bpf: non-standard multi-line comment style in struct
  bpf_dtab_netdev
--

commit b6749200cfd19f384e3c763bbc57d732deab6c99
Author: Tobias Philipp <tphilipp@gmail.com>

bpf: Align devmap values to 8 bytes

This commit aligns struct bpf_dtab_netdev::val to 8 bytes so that devmap
values match the verifier's 8-byte map-value alignment assumption and avoid
alignment faults on 64-bit load-acquire instructions.

> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 1b8f0d7f84552..0ef24e3f9f0c9 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -70,7 +70,10 @@ struct bpf_dtab_netdev {
>  	struct bpf_prog *xdp_prog;
>  	struct rcu_head rcu;
>  	unsigned int idx;
> -	struct bpf_devmap_val val;
> +	/* Returned to BPF programs as the map value, which the verifier
> +	 * assumes to be 8-byte aligned.
> +	 */
> +	struct bpf_devmap_val val __aligned(8);
>  };

[Severity: Low]
This isn't a bug, but BPF multi-line comments place the opening /* on its
own line with the comment text starting on the next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124225055.8734=
4-1-tphilipp@gmail.com?part=3D3
