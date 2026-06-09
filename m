Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E43FAE09
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005289; cv=none; b=L/UIAb+tMs72T9uiMZ1xfFzBf9EK5mfTWZtOG7KXzpXQi1V0iJs+3LKjw7whi9h9YeD6pPVHZVsFD19ktCEKSXdZSCdZd22PVgDRcKMIfe+h+OG/4daV6UiFihtKjWFGfnnl7lGZ4WqSZtQXdvnf0zXT9KJ/B1ukmobRW2tIlZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005289; c=relaxed/simple;
	bh=lPP0Ke0PTqadPKHhFn08KxHU0w8olLyXPWuEDFuAUpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UXkm/20awoYlEPIDddNCnGnXclZWnrwqs2fqBCegz4YvrjGAq8Hv8nb1C3T/dC3VgArqKdml8H3pc0ucPQ1HCDk9JWOtlM9F7W3/UjhHobTlsbVnXu4deMN533nIyMQBSSt0GxTotx2cwj1Ku7H6B2MYhhcNK3jDE/4dJoAnxbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETODQSY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETODQSY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501691F00898;
	Tue,  9 Jun 2026 11:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781005287;
	bh=HRfVr2TId1NSiU0bHbx3TfDrAgzgqb+Yllm7kWFEJ7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETODQSY32YOu8g/JgQ853GN2w+kc+2vBzUxFweGpOn8NWZiAk8TfD/L/XqTaHr75N
	 Zf2HN4VdfBRV7lLZiNUWAmiUr5fDfT9PogrdE3V/93crYit1KGx9THab1IgGrDS6+X
	 AZ+NzLvXaVrQgeabI6ocjvCwBOxzeV3Aop9po0N3vH2dxKhReRNz8arze777O/3UmI
	 9YN6/lLJIyeBMecdcDP2XeopP9erqkbBYhexXbEBSCnECctFhpLEDM6E4YLyCOEpoD
	 WXBytuTzd0+RfTXFC95BSr1HizrOxK81A4vm/GKyDnggP8JAum3SMFmjSPTigJlPOK
	 gJKzlvBhWKe/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609112316.3685738-1-rhkrqnwk98@gmail.com>
References: <20260609112316.3685738-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 11:41:26 +0000
Message-Id: <20260609114127.501691F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] BPF stream parser modifications to the packet payload or `skb->cb`=
 are preserved for single-SKB messages but silently discarded for multi-SKB=
 messages.
- [Medium] Using kfree_skb() instead of consume_skb() to free the temporary=
 clone generates false-positive packet drop trace events.
--

commit 222c451a3266f132b61e9cb62920fe1322b0ce13
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: fix use-after-free when the stream parser resizes the skb

This commit addresses a use-after-free bug caused by the BPF stream parser
modifying a fragmented skb. It fixes this by cloning the skb before running
the parser if it has a frag_list, preventing the program from freeing frags
that the stream parser tracks.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index e1850caf1a71a..d5b10f9b0ba8d 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> @@ -1146,14 +1146,30 @@ static int sk_psock_strp_parse(struct strparser *=
strp, struct sk_buff *skb)
>  	prog =3D READ_ONCE(psock->progs.stream_parser);
>  	if (likely(prog)) {
> -		skb->sk =3D psock->sk;
> -		ret =3D bpf_prog_run_pin_on_cpu(prog, skb);
> -		skb->sk =3D NULL;
> +		struct sk_buff *parse_skb =3D skb;
> +
> +		/*
> +		 * strparser chains the message skbs through skb->frag_list and
> +		 * keeps a pointer into that list in strp->skb_nextp.  The parser
> +		 * program may call bpf_skb_change_tail() and friends, which go
> +		 * through __pskb_pull_tail() and free the frag_list skbs that
> +		 * strparser still tracks.  Run the program on a clone when a
> +		 * frag_list is present so it cannot drop frags strparser owns.
> +		 */
> +		if (skb_has_frag_list(skb)) {
> +			parse_skb =3D skb_clone(skb, GFP_ATOMIC);
> +			if (!parse_skb)
> +				return -ENOMEM;
> +		}
> +		parse_skb->sk =3D psock->sk;
> +		ret =3D bpf_prog_run_pin_on_cpu(prog, parse_skb);
> +		parse_skb->sk =3D NULL;
> +		if (parse_skb !=3D skb)
> +			kfree_skb(parse_skb);

[Severity: High]
BPF SK_SKB programs can modify packet data (via bpf_skb_store_bytes or resi=
zing
helpers) and pass metadata to the verdict program via skb->cb. By running t=
he
parser on a temporary clone for multi-SKB messages and immediately freeing =
it
here, are any payload modifications or cb updates made by the BPF program
completely lost?

For single-SKB messages, the program executes directly on the original skb,
preserving all modifications. Does this introduce a behavioral inconsistency
where the same BPF program silently fails to apply modifications or pass
metadata depending solely on network-level fragmentation?

[Severity: Medium]
When the temporary clone parse_skb is successfully parsed and then freed,
using kfree_skb() emits a trace_kfree_skb event with
SKB_DROP_REASON_NOT_SPECIFIED.

Since the packet was not actually dropped and the clone was just successful=
ly
consumed as part of normal processing, does this pollute network observabil=
ity
tools (like dropwatch) with spurious drop events? Would it be better to use
consume_skb() here to silently free the clone?

>  	}
> -	rcu_read_unlock();
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609112316.3685=
738-1-rhkrqnwk98@gmail.com?part=3D1
