Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49A38B7D2
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269074; cv=none; b=Q0r8AjKcxsOqJ8KMsmvjLoSz+s2evmwQePEB6aVc2MVjxzXoaSc1No2oFRbESn+h33udaNs2HVnlWM9bc8PZTOGAZ32lqOOdjlpRGVZpLfng0H3Gbl8fZtYSSaDPr+u303WfoON/R8aEQNVVYiwbMVFZcNFrPBJfpgYxfgEq7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269074; c=relaxed/simple;
	bh=DtWnRXqB7uvOVeX+OMQCwnhgJjDbTelfSd2KW6wObsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JONJsnMzanrTnbl0b+522TRuME2/f54eUYnwDVRKXEHlkaegNd0wR66v7iKMWssJIHj01QOkOFqVnR66QRN2J2KdG36wPfnoBaty4wapLvcdFgqeKGblRuANw0MKmOVRgghqy2Mg3vWB0vuu3jfN9LWdHIrgLgCoEo3NzjMWMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNjNWMTO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNjNWMTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124221F000E9;
	Fri, 12 Jun 2026 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781269073;
	bh=bruhVyYPlS3/Tmnus4gL9tdJ59uUxbkypiOZgxKCQvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lNjNWMTOB3OLNFyJ8h6yTvhfjbbWEu1RtnvOpY5gQRrkuXurlt8DSi8jh9GYsPtqn
	 0SzRF6C1uWAQzpExMQA38Kpmpjpf9RBKMaeHYFtXL0abfY9bCe6/VdbbcyGLV3+G6W
	 nsd3q+2XiAY/bIlMgXjJP2yv8hGHCGTgutnkhj3gkN1/VSvESOmDD8hi+yjaOp6XqE
	 ce0tMtiuVRF6R2BrIINg1VV1gY2xV+H2NEyT+2swaK+WRwvffLGuM2LxOfRs/JtmjC
	 +qKEO9m7lFHhNlDBy3TSRadfYyYuLcuty3xb3olU8pLXOPLAOvf4a8cOP1D1u4zg2R
	 +PhSI40I93bWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
References: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 12:57:52 +0000
Message-Id: <20260612125753.124221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] BPF program modifications to the packet payload and the `cb` array=
 are lost for fragmented packets, breaking API contracts and state passing.
- [High] Returning 0 on `skb_clone` allocation failure causes a structural =
connection stall.
--

commit b299b25e2b7e463fddbfdeb09ab2432fcc43e867
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: fix use-after-free when the stream parser resizes the skb

This commit fixes a use-after-free in the stream parser when a BPF program
resizes the skb. It runs the parser on a clone of the skb when the message
spans multiple fragments and the program can modify the packet data.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index e1850caf1a71a..97e5bc5f38c35 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1149,9 +1149,29 @@ static int sk_psock_strp_parse(struct strparser *s=
trp, struct sk_buff *skb)
>  	rcu_read_lock();
>  	prog =3D READ_ONCE(psock->progs.stream_parser);
>  	if (likely(prog)) {
[ ... ]
> +		if (skb_has_frag_list(skb) && prog->aux->changes_pkt_data) {
> +			parse_skb =3D skb_clone(skb, GFP_ATOMIC);
> +			if (!parse_skb) {
> +				rcu_read_unlock();
> +				return 0;

[Severity: High]
Does returning 0 here cause a connection stall?

In the strparser framework (__strp_recv), a return value of 0 from parse_msg
explicitly signals that it needs more data to determine the message length.
This causes the parser to consume the current bytes and suspend parsing unt=
il
new data arrives.

If the sender has transmitted a complete request and is waiting for a respo=
nse,
will the connection stall indefinitely since no new data will arrive?

> +			}
> +		}
> +		parse_skb->sk =3D psock->sk;
> +		ret =3D bpf_prog_run_pin_on_cpu(prog, parse_skb);
> +		parse_skb->sk =3D NULL;
> +		if (parse_skb !=3D skb)
> +			consume_skb(parse_skb);

[Severity: High]
If the BPF program modifies the cb array or packet payload on the clone
(parse_skb), do these changes get silently discarded when consume_skb()
is called?

BPF sk_skb programs are explicitly permitted to use the cb array (the first
20 bytes of skb->cb) to pass state between the stream parser and stream
verdict programs.

When the program runs on a transient clone, modifications to the cb array or
the packet payload are lost when the clone is freed. For non-fragmented
packets, the program runs on the original skb and modifications persist.

Could this structural inconsistency break BPF programs that rely on state
passing, or allow attackers to bypass BPF security policies by artificially
fragmenting traffic?

>  	}
>  	rcu_read_unlock();
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612123553.2724=
240-1-rhkrqnwk98@gmail.com?part=3D1
