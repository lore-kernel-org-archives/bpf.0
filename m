Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C473C3C16
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785498572; cv=none; b=NqhJSjaUXTJ0M7uQzi2tlRZBFRa9S0gi+fxq96kZMafHwbE0EhHK+l8pk2fIXOZANwjGI2ECh0E+Otna/2gKGATzr346OBHg0BPE1SMpfHGLLf/YvBbOChh0u+miuyAIc1PRNtV3kC1chHIzT0z9FZKH81lhIiVpVze1Y2IiHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785498572; c=relaxed/simple;
	bh=LieFTCR6JmG/EdtuQxfKvLw/py+JZdVlzcvZNr6+KVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AubfaxzoAetzEAZ5UzqahyFyw5RmQ8JG+z3o0/m2PdGssflF7jiB2AExWn+XAyDO9Utq3w1m3coj5iPTPv9N8BHfeAM7D7jwNVNEY7q3Rj71YZO6UhqIWGseuOR3+Wl6XnR9cwrZmdr9dIJ9AHoXDgXpY6W08U50URfOqNdAz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ota82xCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ota82xCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF531F000E9;
	Fri, 31 Jul 2026 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785498571;
	bh=h1vre6+I4pZvUi9mbW7mr0tFWS5+iHnwPCpKms/xHnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ota82xCxXcGiSR5Y6qbjOO/+7bWK4/IMFgr776AGjdq7qaQHKp1w7p2rIFVMwT5zK
	 BElmf/YnJforesm6SBzOIhmofEDQsUgEGafeaEP0/tLRuIO1pGktSK5JcEumh9O3HZ
	 BcrbMI+U+JYME+Fsp0Dgw1Sx+xlcpd+Un2njkvx21qi3aSrE3iecDA4A9sP8qxwL/6
	 WFKF8bWNOMjfqzBld/LPvrGXIYFC9yvftZILv8m61+wnwcqKLsRQ0OxVo3O6qEDE8e
	 pwJumK5Q4EgLPcbg/pSE89ku6x+oZb+Se6PP7wiluxFqS1VY4Q2BB81VIgajGGkdfH
	 BC0ZTZAdmJHrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
Reply-To: sashiko-reviews@lists.linux.dev
To: chia-yu.chang@nokia-bell-labs.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260730114919.658373-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260730114919.658373-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 11:49:30 +0000
Message-Id: <20260731114930.DEF531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tcp_tso_autosize is not exported as a BPF kfunc, making it impossi=
ble for custom BPF CC programs to utilize standard TSO autosizing.
--

--- Patch [1]: [PATCH v6 net-next 1/1] tcp: Replace min_tso_segs() with tso=
_segs() CC callback ---
commit e9e6269217c20aef163ee8ebfb7cab71f918807f
Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

tcp: Replace min_tso_segs() with tso_segs() CC callback

This patch replaces the existing min_tso_segs() CC callback with a new
tso_segs() callback. The new callback provides the explicit TSO segment
number for each data burst, completely bypassing tcp_tso_autosize().

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d7c1444b5e304..d9bda3a84f261 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
[ ... ]
> @@ -2269,6 +2269,7 @@ static u32 tcp_tso_autosize(const struct sock *sk, =
unsigned int mss_now,
> =20
>  	return max_t(u32, bytes / mss_now, min_tso_segs);
>  }
> +EXPORT_SYMBOL(tcp_tso_autosize);

[Severity: High]
Since BPF congestion control programs now need to compute the final TSO
segments value, do they need access to tcp_tso_autosize() to retain standard
autosizing?

The commit exports tcp_tso_autosize for native kernel modules, but it appea=
rs
missing from the BTF kfuncs set (bpf_tcp_ca_check_kfunc_ids) in
net/ipv4/bpf_tcp_ca.c:

BTF_KFUNCS_START(bpf_tcp_ca_check_kfunc_ids)
BTF_ID_FLAGS(func, tcp_reno_ssthresh)
BTF_ID_FLAGS(func, tcp_reno_cong_avoid)
...
BTF_KFUNCS_END(bpf_tcp_ca_check_kfunc_ids)

Without being registered here, custom BPF CC programs cannot call
tcp_tso_autosize(). This might prevent them from properly migrating to the
new tso_segs callback if they want to retain standard TSO autosizing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730114919.6583=
73-1-chia-yu.chang@nokia-bell-labs.com?part=3D1
