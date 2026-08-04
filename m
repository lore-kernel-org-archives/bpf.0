Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720139B943
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857668; cv=none; b=dR3G2eAcKt0fDpy+CIk5N6o0tiwbpsVdzLuZrPn3oX8hj2c2biWrbmcymKc8W+OSVDyTE4uo/6J4v4CSQ5sD+VSjKZ8SOBdd/b9ElM13A1VgfhQj5YjwL10yE7WQfNNEzQ6Stc0ZoXaUnkIZZLenRuz8PHGJm3ajG4XzQ6tDH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857668; c=relaxed/simple;
	bh=TWFAh7iAWJ64rYieVwwvMao9MeS+BUom6wUc8OgUPTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HT0t3b6CoVO1iFVbFNNizBgJok7O0BMTGjUrHEOpgP7ZO+xA8I6O+GAjqqCYrqRKzJWSZkap64RU2jwzZOXrJncWS1I/+Owhd9LvpTeusIlJarMHRTgheVy4V3+Liyofzos/GmIpvCjvO3yJBQSEDyGqWBF8/R+vnUDJV21LZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huLNtx3E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huLNtx3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1FC1F00A3A;
	Tue,  4 Aug 2026 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785857666;
	bh=SDxlPMJ+OX7jCApBKCLzdlCawEmnHkId3mCAsmx6bzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=huLNtx3ETlBtd9epMdMhVZwmLY4q3v+0pfHgd1KIDW48FzzoKQSlAWlBDn3OaaIdD
	 LFoqqSHjNbc7UBlaX+bjq9fGxrwPg7phkzoRV1m+sL84EpVHoXCHUDke7RXGeHXCvZ
	 jeRIp9dH/Yh1xKLgOLuu2EmTprBJfWP2V1yxGBwcvumcve8BuSdGeW9EHXidqjcz83
	 Q70dIonOMwdC5mNIOdDSY8alP36B2Pm6LCIZqCcBX6lTw1gthkZNmOKml0yOtso07I
	 hyPV/de4tqLlAVghwct8JgT5FSCrzWn6y/vsgszRWSmIvy4Qz4w11Fq+dTGV+EgR5g
	 2FK0yLSINsWHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/1] bpf: Check sk_state before sk_protocol in
 bpf_tcp_*_syncookie
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <enjou1224z@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
References: <cover.1785823138.git.rakukuip@gmail.com>
 <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:34:25 +0000
Message-Id: <20260804153426.5B1FC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch comple=
tely misses an identical slab out-of-bounds read vulnerability in the `bpf_=
sock_destroy` kfunc when a mini-socket is passed.
--

--- Patch [1]: [PATCH bpf v2 1/1] bpf: Check sk_state before sk_protocol in=
 bpf_tcp_*_syncookie ---
commit fe03c404200965b4022b50ca58915a717cbea479
Author: Luxiao Xu <rakukuip@gmail.com>

bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie

This commit fixes a slab out-of-bounds read vulnerability in the
bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie helpers. It ensures
sk_state is checked before accessing sk_protocol to avoid reading past
the memory boundary of mini-sockets.

Link: https://lore.kernel.org/all/ca8d8c570509b02355bb4bd4e56859f3e2564c9c.=
1785576172.git.rakukuip@gmail.com/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 11bb0d236822a..16845987b2449 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7684,7 +7684,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, =
sk, void *, iph, u32, iph_len
>  		return -EINVAL;
> =20
>  	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
> -	if (sk->sk_protocol !=3D IPPROTO_TCP || sk->sk_state !=3D TCP_LISTEN)
> +	if (sk->sk_state !=3D TCP_LISTEN || sk->sk_protocol !=3D IPPROTO_TCP)
>  		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does the same slab
out-of-bounds read occur in bpf_sock_destroy()?

It looks like bpf_sock_destroy() takes a struct sock_common but casts it
unconditionally to struct sock before accessing sk->sk_protocol, which
could also be a mini-socket (like request_sock or inet_timewait_sock).

net/core/filter.c:bpf_sock_destroy() {
    ...
	if (!sk->sk_prot->diag_destroy || (sk->sk_protocol !=3D IPPROTO_TCP &&
					   sk->sk_protocol !=3D IPPROTO_UDP))
		return -EOPNOTSUPP;
    ...
}

Should we validate the socket type before dereferencing sk->sk_protocol
there too?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6218aa3534d0d2d3f44=
8fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com?part=3D1
