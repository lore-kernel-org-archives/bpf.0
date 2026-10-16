Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0E3F4DFE;
	Fri, 16 Oct 2026 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181750; cv=none; b=nAe3Nbtkt70SrurDrlXWRspM/xAOcMj5EiXkhUgwHYk3EMx1p5fP3Adkk9awBc/HdSPtjV09GcpOC07QOjCCBuEsIDjnkZ9Gvr9iewkWuvN55stN8Fhl1cRr92VUjBLyZrExceLqXNdEG/J/I1oapzRKLpnBtlkcMJmQsSIr5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181750; c=relaxed/simple;
	bh=1CtdNjBP/tT+f6Z4HSlvplXa838Nfx85jUo5kW1Umdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WMxrBPeHZESip9QOMQkKQcMubQUsp16ohd1hchZIi5k9X56CzPVcssV7EcidrbqcrePqByQozcIXLHAVudwhMN2efkLcSk9F4eHcwOxPVOPQsiWDAcFuMfXMjfuO9Z+Gm17pO/x6tOyvHf7sOyMSrJhE+8arpufWJjAG6d4uUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndcfiN7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndcfiN7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A401F000C4;
	Fri, 16 Oct 2026 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181745;
	bh=PHvv5s7xTkvqkhoQfbECIs2qM/anmRUbsbBZ2oBhi/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ndcfiN7lDTkzMOicy2la/SON2lfNP0pJSTx2lrPdJGuuT2vEFOMpwsik6ZHhUgVjC
	 akyhqHohEI1uaki5sly91FgO6V802YngT5LNIEN7MWTuNP8Wjrgft26QejzvzaO7OT
	 PERVh1hhoC9cltKHBWv8zw9O3UQcJqXkRWE/vjtkGZr62m8zlr8Qbj9jhQuBT6F3c4
	 jOR/19F6doBkyuh6RsUeGsykLdR07svkJgWrMdoyYzDcaw0JkhCHzhJVMiOr8+6PmZ
	 55dNpbDz6b5qhI4PCwGAC8wkbVxFbywNw7YlDEkp4Q2sXNrO8og+saIp6iOKOgQPbj
	 d3HucrKe+/0nw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Clement Lecigne <clecigne@google.com>, aleksander.lobakin@intel.com,
 edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, sdf@fomichev.me,
 horms@kernel.org, john.fastabend@gmail.com, ast@kernel.org,
 daniel@iogearbox.net
Subject: Re: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
In-Reply-To: <atIfJAKqp3dZdY4M@boxer>
References: <20260629072300.1664622-1-clecigne@google.com>
 <87qzhp51vc.fsf@all.your.base.are.belong.to.us> <atIfJAKqp3dZdY4M@boxer>
Date: Fri, 16 Oct 2026 22:15:42 +0200
Message-ID: <87cxt94d1t.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Fri, Oct 16, 2026 at 01:19:35PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Waking a dead thread: RISE FROM YOUR GRAVE!
>>=20
>> Clement Lecigne <clecigne@google.com> writes:
>>=20
>> > From: Cl=C3=A9ment Lecigne <clecigne@google.com>
>> >
>> > Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion=
")
>> > introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero=
-copy
>> > frames.
>>=20
>> Hmm, I acually hit this in my WIP for UMEM page pool provider hack.
>>=20
>> > Note: Currently, this specific AF_XDP zero-copy conversion path is only
>> > reachable from the drivers/net/ethernet/intel/ice and
>> > drivers/net/ethernet/intel/idpf drivers.
>> >
>> > When building an skb, xdp_build_skb_from_zc() uses the chunk size
>> > (xdp->frame_sz) for the allocation. However, napi_build_skb() automati=
cally
>> > reserves space at the end of the allocation for the skb_shared_info
>> > structure.=20
>> >
>> > Most high performance UMEM applications use 4K chunks, where the
>> > corruption cannot happen.
>>=20
>> I think this can also happen with 4K UMEM chunks.
>>=20
>> For example, on ice, use MTU 3800, 4K chunks, and no extra UMEM
>> headroom. Attach an xdp.frags program that returns XDP_PASS, and bind
>> the socket without XDP_USE_SG.
>>=20
>> A 3814-byte Ethernet frame fits in the UMEM chunk:
>>=20
>>   256 headroom + 3814 packet =3D 4070 bytes
>>=20
>> But the copied skb also needs space for skb_shared_info. Using
>> the 320-byte size from your example:
>>=20
>>   256 headroom + 3814 packet + 320 shared info =3D 4390 bytes
>>=20
>> The old code allocates only 4096 bytes, so the packet copy
>> overwrites skb_shared_info.
>>=20
>> Am I missing something?
>
> I was pushing back on relying on scenario above as we respect the tailroom
> now since some time:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Da315e022a72d95ef5f1d4e58e903cb492b0ad931
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D1ee1605138fc94cc8f8f273321dd2471c64977f9

Hmm, isn't that only with XDP_USE_SG? My example binds without it.

Then xsk_pool_get_rx_frame_size() returns 3840. XDP_PASS still builds an
skb with skb_shared_info, even if it's linear. So we only have 4096 -
256 - 320 =3D 3520 bytes for the packet.

Or am I missing another check?
