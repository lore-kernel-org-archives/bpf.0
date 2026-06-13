Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C078262A6
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781392268; cv=none; b=H5lzOkrQDlLhEMT2FOfgj5N3KuMQL4sRuvl/i6cKaXC9nB75i/NgRz+kTK4hIlgi2KesYI4ZQ50oB/mknF7JTVA6o69FgJrlUnkrc3w9bTJpH1iqoybE/Pe1E6qhUVcW1yayny9qPPtMXCUtIGf0MoSClxXUxM9A8MSU8QArITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781392268; c=relaxed/simple;
	bh=/fL972U5yVTvH/Va9pzT34bXQGrWaBPS8LL1MhECerQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gabWb6DTHFLYYrfSTP/TuEFP5r4gwf1ULySPPuAv8cLueLHyjFfjczTR0gkIZJrKlqn8emwG20JksF2T8rVGTvR56j6zhjN6qW+8o6DftMxq9d7ci4yABC91jHfgVRxIj6CrVI+/cuG69Y/JE4ExQQhyca95sxmhbaPLKP8lzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVSm5mJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVSm5mJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D2F1F000E9;
	Sat, 13 Jun 2026 23:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781392267;
	bh=a0amtZbCT6BZ5DUnHPaSFiOV8K4fYhTy9XygqZtE91U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IVSm5mJKocXhADXrbJxGD8QTsIa6aeA6phtRfMl78yqL7bnA1u7PP5ifQqhc2pfXc
	 tS0WSMRHZz2op7A+6185fGOmZyVieYdW0WyRh58KLxC8CrD48EbxJNL+a6LFIe4d6+
	 t0GHjgHJsQfsAiQoUvYbLFxlYnhLxIuwdF2rner7zNK3hWGCqoS9ED1VZywUfIpCTP
	 07ohPY9SjF/UkiCs/Ip62wz9a5OKsW2+Lntf4uDq+A5uS1aMByLCbf+QpOTDKaAChL
	 vv+CZYjWLj6xLfaALhkmd5I7qUAcz3QM76lCeRi9SgvGTDgDana5FMppnRYd9YsNN9
	 NymTGUMRVhsCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 3/4] bpf: Add kfunc to proxy TX HW
 Timestamp.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613224823.2399535-4-kuniyu@google.com>
References: <20260613224823.2399535-4-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 23:11:06 +0000
Message-Id: <20260613231106.E1D2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Stale `BPF_RI_F_TX_TS_CMPL` flag is leaked across nested BPF netwo=
rk context executions, allowing state corruption.
- [High] Insufficient bounds checking in `bpf_skb_complete_tx_tstamp` combi=
ned with uninitialized `skb->cb` allows BPF programs to trigger an out-of-b=
ounds read and leak kernel memory to userspace.
--

commit a5f7ad9bfc54080207dfab0d4ae903bce6f3888c
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: Add kfunc to proxy TX HW Timestamp.

This commit adds two kfuncs, bpf_skb_scrub_tx_tstamp() and
bpf_skb_complete_tx_tstamp(), to proxy TX hardware timestamps for socket
applications using SCM_TIMESTAMPING. It extracts the timestamp and enqueues
a regenerated skb to the sender's error queue.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0c6c270d9f7d1..a45cdf38616ac 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4456,6 +4456,41 @@ tcx_run(const struct bpf_mprog_entry *entry, struc=
t sk_buff *skb,
>  	return tcx_action_code(skb, ret);
>  }
> =20
> +static int skb_do_completion(struct sk_buff *skb)
> +{
> +	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_INGRESS;
> +	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
> +	struct bpf_tx_tstamp_cmpl *txtscmpl;
> +
> +	if (!(ri->kern_flags & BPF_RI_F_TX_TS_CMPL))
> +		goto drop;

[Severity: High]
Does this code leak the BPF_RI_F_TX_TS_CMPL flag across nested executions?

If a nested execution occurs (for example, via bpf_clone_redirect()
triggering a synchronous sch_handle_ingress() on a tunnel device), the
inner execution reuses the outer execution's bpf_net_context. If the inner
BPF program sets the BPF_RI_F_TX_TS_CMPL flag and returns TC_ACT_ERRQUEUE,
skb_do_completion() processes the inner packet but leaves the flag set in
ri->kern_flags.

When the outer execution resumes and returns TCX_ERRQUEUE,
skb_do_completion() will be invoked again on the outer packet, incorrectly
applying the inner execution's stale txtscmpl attributes. Should
ri->kern_flags have the BPF_RI_F_TX_TS_CMPL bit cleared after processing?

> +
> +	if (skb_unclone(skb, GFP_ATOMIC))
> +		goto drop;
> +
> +	__skb_push(skb, skb->mac_len);
> +
> +	txtscmpl =3D &ri->txtscmpl;
> +
> +	drop_reason =3D pskb_may_pull_reason(skb, txtscmpl->payload_offset);
> +	if (drop_reason)
> +		goto drop;
> +
> +	skb->protocol =3D txtscmpl->protocol;
> +	skb_set_network_header(skb, txtscmpl->network_offset);
> +	__skb_pull(skb, txtscmpl->payload_offset);

[Severity: High]
Does this pull, combined with the uninitialized skb->cb, set up the
conditions for an out-of-bounds read?

Because skb->cb is not cleared here, it retains its contents from the TC
layer (struct qdisc_skb_cb). The BPF program can control qdisc_skb_cb->data
via the __sk_buff->cb array. If the BPF program manipulated the cb array to
set a large optlen, and payload_offset only guarantees linear buffer space
up to the end of the 20-byte IP header (as verified in
bpf_skb_complete_tx_tstamp), ip_cmsg_recv_opts() could read past the
validated linear buffer and leak adjacent kernel heap memory to userspace.

Should skb->cb be cleared or initialized before handing off the skb to the
socket error queue?

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bd8c9a7b7505a..c8d00067536be 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -12396,6 +12396,67 @@ __bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk=
_buff *s,

[ ... ]

> +	delta =3D attrs->payload_offset - attrs->network_offset;
> +	switch (attrs->protocol) {
> +	case htons(ETH_P_IP):
> +		if (delta < (s32)sizeof(struct iphdr) || !sk_is_inet(sk))
> +			return -EINVAL;
> +		break;

[Severity: High]
Is this bounds check sufficient to prevent out-of-bounds reads during IP
options parsing?

This only validates that payload_offset - network_offset >=3D
sizeof(struct iphdr) (20 bytes).=20

Because skb->cb is not cleared in skb_do_completion() before placing the
packet on the socket's error queue, an attacker can set cb[1] (which aligns
with optlen in struct inet_skb_parm) via the __sk_buff->cb array. When a
socket application reads the error queue with IP_CMSG_RECVOPTS enabled,
ip_cmsg_recv_opts() will interpret the uninitialized skb->cb as
struct inet_skb_parm and read optlen bytes past this 20-byte IP header.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613224823.2399=
535-1-kuniyu@google.com?part=3D3
