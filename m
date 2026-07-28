Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8F372663
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255642; cv=none; b=a3f9dJyWY0HqU/HgxalHWXBHZoUj5pB8lhny+4Nn6GVEsZEvVo0u3pHkw54JS1Yx31n7SqJGs5vPGGvo+gKSr/Uzdcc5V5mO3M6F+Ju5pegd5zioB9kCbEL3pGzCXDVKYlxD4MiVDCSSMYigieBph1g9lUTUjVlGLhOPpZV+TNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255642; c=relaxed/simple;
	bh=fsOAbdg/27u1kPaKoQBuMDcCdgzOQzpYIgdZNAWd1hM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bwwxeXwZy7yicFWlMxhpyollJeKoQN/hxegN4BucQgMDbXIySI/C8TaGAzED0tfThllp1IvQ3pEtdTvYE7unCZBX3rUsrYsi84EYJDQc0W9KBJahQIyxPxFJqN/7j+22Ezv1PuysRcB5SFqCpSvyoBw7iDQGBt0xahEYTYPktoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJaBBTre; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJaBBTre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7805A1F00A3A;
	Tue, 28 Jul 2026 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255640;
	bh=TYSchQDCMy8qqpm5wT4lQccAvQOjCwoKMwTTrWWhgpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJaBBTreG0e5Sh/ssndvvYHc8vDYZr3jf02FhGO6ZNDbB2lg0XTXw+Q4UcVU8PhhT
	 QoSXi6SsqQQd2Qf8t4wFF4VGzFGf5xzbACnLax2zorfFkHFJqP41s61XprkGbYH2Sm
	 RWWR1C9ouGIzdFtZOdJfREmn7U5wk7rjqGtdI/F31gp+69KqB+gJhFn7qSBDVnhPnO
	 zIOTJPFPi3wkeV3VzGtH/HBJlXw0fpmdMlAVvHqGNeAW3rPR7pJzzxHa0tuyH8Vwrt
	 32lgn/tsNKWGEQJ8J3wzuN0CanseIiBp4DpeHf0fUmh/or7WDrasl69bpLshVl9qpM
	 9rFleqz5+56WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/6] xsk: clear metadata pointer when no timestamp
 is requested
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Fomichev" <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727161959.885642-4-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <20260727161959.885642-4-sdf@fomichev.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:20:40 +0000
Message-Id: <20260728162040.7805A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in `xsk_skb_metadata` when calculating `skb->csum=
_start`, leading to a potential kernel warning and panic (DoS).
--

--- Patch [3]: [PATCH net 3/6] xsk: clear metadata pointer when no timestam=
p is requested ---
commit 814027e56069dbb5716ac5b9f7f38aebab332dd6
Author: Stanislav Fomichev <sdf.kernel@gmail.com>

xsk: clear metadata pointer when no timestamp is requested

User space can change metadata flags after request processing. Rereading
them during completion can therefore make the kernel write a timestamp
that was not requested when the packet was submitted. Clear the metadata
pointer during request processing unless timestamp completion is requested.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -998,6 +998,8 @@ static int xsk_skb_metadata(struct sk_buff *skb, void=
 *buffer,
> =20
>  	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
>  		skb->skb_mstamp_ns =3D meta->request.launch_time;

[Severity: High]
This is a pre-existing issue, but can the checksum offset calculation
earlier in this function cause an integer overflow?

When handling XDP_TXMD_FLAGS_CHECKSUM, the code does:

    skb->csum_start =3D hr + csum_start;

On architectures with 64KB pages, csum_start can be large enough that
adding hr wraps the u16 skb->csum_start. This would result in
skb->csum_start being smaller than the headroom.

If pool->tx_sw_csum is true, this then calls skb_checksum_help(). Inside
skb_checksum_help(), the offset is calculated by subtracting headroom from
skb->csum_start, which yields a negative integer due to the wrap-around.

When this negative offset is compared against skb_headlen() (which is
unsigned), it is implicitly cast to a huge unsigned value:

net/core/dev.c:skb_checksum_help() {
    ...
    offset =3D skb_checksum_start_offset(skb);
    ...
    if (unlikely(offset >=3D skb_headlen(skb))) {
        DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
        WARN_ONCE(true, "offset (%d) >=3D skb_headlen() (%u)\n", ...);
    ...
}

Could this allow an unprivileged user to trigger a kernel warning and
potentially panic the system if panic_on_warn is set?

> +	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
> +		meta =3D NULL;
>  	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161959.8856=
42-1-sdf@fomichev.me?part=3D3
