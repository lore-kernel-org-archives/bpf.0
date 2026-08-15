Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1119D8BC
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786815062; cv=none; b=ACaz4T3x9NNl/0iOPp0wNPEzjSmRWT2DeZL75I75ETLTwv/jOp5FPxtaEOlW3d1zmyI7OU7wxUfl0cVoPynES/yohLEwQt81pRJLr6MvTY1j3YSf9nXfed3NN9RF1sPICZSbHXrgnL6tdoZ7HB1mbFMQvuRRzufe1XNRtn2+FL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786815062; c=relaxed/simple;
	bh=8Swwsegu9Ib2air3YMxCnxKTiKgxErSs5E+TGLBlYE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9JiMMYG35PuAgUt0XMQlRmyFHqokSvEHU5ThmYTdiDwwtG94kluQHyO3hhDOnHDQDqIuxmD4c1hcuxAlftvHqvv6BJMcsn7/228Lc5LOOPg2W058gxabC5dLZw4fNMepsgxHeGb0/RccVKSJG3rVK01zs928vUavQgLGrw+M9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0F/rFCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0F/rFCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE401F000E9;
	Sat, 15 Aug 2026 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786815060;
	bh=LcW0XlKcrIWFkaXxN4wuJjX70VOsX4UCtYt5t+bbhU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S0F/rFCh8Q+MI58sv/gHdT8ayt/poBOsDdxDM6caa0/1pNuzdqMIUIxEkIPXL7ou+
	 XNMOi/mOnEHupweBprMLSgURFUbNbkUMIAHlHekLnQ8T5NGHP/+mtqkP3r3J278NVR
	 QpNLC/0bo9foCeqGxegg4NVvZZTaWIwBTn4Xx2uLG/IdGMF1CcOevq4GHxiazg6ue7
	 rM0MUeSWU216SRyM99zr1nkrcIL8ws7TOWxR+MgJHn/qgVAlk4PyYn6q+mmraY5Yuy
	 sKacwC2+CAVj4Y9J+QTNXSgrSeCBrrR2TnRa1xckcbyaK8MXDxlkAteFif6gAfrVc8
	 VQYtHNXl/cNhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 net-next 1/2] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
Reply-To: sashiko-reviews@lists.linux.dev
To: chia-yu.chang@nokia-bell-labs.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814173034.749151-2-chia-yu.chang@nokia-bell-labs.com>
References: <20260814173034.749151-1-chia-yu.chang@nokia-bell-labs.com>
 <20260814173034.749151-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 17:31:00 +0000
Message-Id: <20260815173100.AFE401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] BPF API breakage: `tcp_tso_autosize` is not exposed as a BPF kfunc=
, making it impossible for custom BPF congestion control algorithms to corr=
ectly implement the new `tso_segs` callback.
--

--- Patch [1]: [PATCH v7 net-next 1/2] tcp: Replace min_tso_segs() with tso=
_segs() CC callback ---
commit c7a0bf37c3be2ea7dea45bba16c15ffe35b92e31
Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

tcp: Replace min_tso_segs() with tso_segs() CC callback

This commit replaces the min_tso_segs() callback in TCP congestion control
with a new tso_segs() callback. It exports tcp_tso_autosize() for use by
loadable kernel modules and updates the CC algorithms to use the new callba=
ck.

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index fcaa04e65189b..7d3e0e715c4bf 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c

[ ... ]

> @@ -2269,6 +2269,7 @@ static u32 tcp_tso_autosize(const struct sock *sk, =
unsigned int mss_now,
> =20
>  	return max_t(u32, bytes / mss_now, min_tso_segs);
>  }
> +EXPORT_SYMBOL_GPL(tcp_tso_autosize);

[Severity: High]
Since the new tso_segs callback completely bypasses the core kernel's
tcp_tso_autosize() logic, BPF congestion control algorithms must now return
the absolute final TSO segment count instead of just a minimum bound.

Although this patch exports tcp_tso_autosize() for loadable kernel modules,
is there a reason it wasn't also registered as a BPF kfunc (via BTF_ID_FLAG=
S)
in the kfunc registry for BPF TCP congestion control?

Without being able to call tcp_tso_autosize() from BPF programs, custom BPF
struct_ops CC algorithms cannot easily compute the autosized value. If they
return a small constant to match the old API, they might inadvertently hard=
cap
TSO burst size and cause severe performance regressions. Otherwise, they are
forced to redundantly reimplement complex internal kernel state logic within
BPF.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814173034.7491=
51-1-chia-yu.chang@nokia-bell-labs.com?part=3D1
