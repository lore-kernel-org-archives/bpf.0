Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA123AAF49
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915175; cv=none; b=Ewc5Yqn4X48r9BGI245dqCcFkSTP5rcRpoFy2UtUQHTwp6vkjyXao8o0MUraEbXYaZ9w4EE3msG2V9TVH+vSOjq49R1akmYTsnJZLPC4iEHh6BlmiYso1u5dMpuSElyrE+HADM1TX5iWL5vyiak0VTEie4ZBjfVVe2lgOyIz2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915175; c=relaxed/simple;
	bh=1IkbNLOe/M+YGxvfKbqbhXLG8hbOs8JzxZDBORH059k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l+6+7UY80hEl8MIVzffz68MwhsveDcVuNxlFjtOECulwpHzfCaTBDu5cy/AJUJok/08vY67u9yNO/rUyWqfMjwhwHBtXeY1It+X18LBr4NeaTtevLBM8Eca+Zv0LQcYCp4734iSrBuvMvpr8OsRFF29CI/t8QHizW6AIMrst6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi4J1Xtj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi4J1Xtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4A41F00898;
	Sun, 20 Sep 2026 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915172;
	bh=EYGYGt1Kc1zXxK/pPvYfYYgcWgAhvK7paYwmzXHsGPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fi4J1XtjKgN+jEWCbXxWMtm+fkuhcAZA9UKvnLpIxIC2giRIR/eDsXEGKx6us42wc
	 clHQzypPoGmczfc/dBXN4FCJsta3z+WuHu70Xv6ujtQ+7jcyuyQtuFSa6fURNvYHWs
	 nTbcFom3N/LP9zbr39nsV7kXoZStYYYIknXDgKXl1HS1xO9sm+ooSblu+EiO+gkQkv
	 KjsqR7cDh96Y02u2GuALmGkRmGy19jfky57Ui3uvZvwblegXwYoNu3D/IaV4dgfJm4
	 xNJ54GnJ70V5gXoUeYBkF2r/DjrpGbo10JlJimZ8j8xiF/7NxdmlN2ECoI5/7qQqhz
	 pM2vFGezyC5Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 9/9] tcp: handle the start time of each
 split skb in the tx path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919143732.11772-10-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <20260919143732.11772-10-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:31 +0000
Message-Id: <20260920143932.3F4A41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: __tcp_transmit_skb() drops start_time when copying cloned S=
KBs
- [Medium] bpf: tcp_mtu_probe() misses start_time propagation for partially=
 consumed SKBs
--

commit 29685480e121f376d52c9ec47c6328d8844a8e0f
Author: Jason Xing <kerneljasonxing@gmail.com>

tcp: handle the start time of each split skb in the tx path
   =20
Segmentation and collapsing create or reuse skbs with a fresh
shared_info, which would otherwise drop the start time recorded
on the original skb.
   =20
Handle every TCP path that manipulates the shared hwtstamps:
   =20
  - tcp_gso_segment(): handle the gso case. Propagate the same
    gso_skb's start time to every resulting segment.
   =20
  - tcp_fragment/tso_fragment(): handle the tso/recovery.. cases.
    Copy the start time onto the second half of the split so both
    fragments keep it.
   =20
  - tcp_skb_collapse_tstamp(): handle collapse case. Copy the eaten
    skb's start time onto the survivor.
   =20
  - __tcp_retransmit_skb(): handle retrans case - the retransmit
    path __tcp_retransmit_skb->__pskb_copy.

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 00417a4292225..cb43215e8b3c9 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c

[ ... ]

> @@ -3669,6 +3673,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk=
_buff *skb, int segs)
>  			nskb =3D __pskb_copy(skb, MAX_TCP_HEADER, GFP_ATOMIC);
>  			if (nskb) {
>  				nskb->dev =3D NULL;
> +				skb_copy_start_time(nskb, skb);
>  				err =3D tcp_transmit_skb(sk, nskb, 0, GFP_ATOMIC);
>  			} else {
>  				err =3D -ENOBUFS;

[Severity: Medium]
Does this code miss propagating the start_time when copying cloned SKBs in
__tcp_transmit_skb()?

In __tcp_transmit_skb(), if clone_it is true and the original SKB is
already cloned (e.g., still held by Qdisc), it calls pskb_copy():

net/ipv4/tcp_output.c:__tcp_transmit_skb() {
    ...
		tcp_skb_tsorted_save(oskb) {
			if (unlikely(skb_cloned(oskb)))
				skb =3D pskb_copy(oskb, gfp_mask);
			else
				skb =3D skb_clone(oskb, gfp_mask);
		} tcp_skb_tsorted_restore(oskb);
    ...
}

When pskb_copy() is executed, it fails to propagate the original SKB's
start_time to the new transmit SKB. This allocates a new skb_shared_info
with a zeroed start_time, silently dropping timestamps for these packets.

[Severity: Medium]
Could there be another missed start_time propagation for partially
consumed SKBs in tcp_mtu_probe()?

tcp_mtu_probe() allocates a new MTU probe SKB (nskb) with a zeroed
start_time, and then absorbs payload from queued SKBs. If the first
SKB is larger than the probe size, it takes the else branch to
partially consume it:

net/ipv4/tcp_output.c:tcp_mtu_probe() {
    ...
		} else {
			TCP_SKB_CB(nskb)->tcp_flags |=3D TCP_SKB_CB(skb)->tcp_flags &
						   ~(TCPHDR_FIN|TCPHDR_PSH);
			__pskb_trim_head(skb, copy);
			tcp_set_skb_tso_segs(skb, mss_now);
			TCP_SKB_CB(skb)->seq +=3D copy;
		}
    ...
}

In this partial consumption branch, tcp_eat_one_skb() is not invoked, and
start_time is never explicitly copied, leaving the MTU probe packet with
start_time =3D 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919143732.1177=
2-1-kerneljasonxing@gmail.com?part=3D9
