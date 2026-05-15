Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62165426697
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842062; cv=none; b=azQkianVSvJnquwAEvuJpN26mbEfGKVx1k/7ONLfIsrPPPl0R3iFdhb1R8Z74L1V7JB2mzQpkXpvRvp37mEME8kKtbZIN0zfLmplay2zk/VhYb88kfff1qDFzv2zXBhbV/WUBlkZr4q0alkyKgBRvrCtDn5EifyC7NvOVgm5540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842062; c=relaxed/simple;
	bh=/MC5F55FqLZalonSWpGJTbFkSSnMo/UzkWWmAW2icT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CAl8I3lXEKEMnUklJW48GiKOAsfGUJzg6hcKkjLkAwikJi6Eby6Acg7tu9Gpw56LIrlbQBpvCfbNvd0r7eGTo8Lhh4jcXMQ1UYfjDpHLaTrf1FWa/MLTCBANIchW9qIHdxy0M8VDvKh6aFOQ/dyAJUGfUiPGAszfmxzVbeQt5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEsrgOR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEsrgOR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6A9C2BCB0;
	Fri, 15 May 2026 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778842062;
	bh=/MC5F55FqLZalonSWpGJTbFkSSnMo/UzkWWmAW2icT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oEsrgOR286GmSV/Q18JBhNh0kJs6WKTu6rf9/nR/GCdx/XHXHb7LWNXZlQGK0U0p8
	 jEWl8XmxIr8vsdv2VcTLUG/KupqrEQaD6xHqu89X4HQ5VkzLfT3HVMUiRfXzZ1Nw5j
	 +X/uCt1za9Og8/Od5WqZaVek4Py9QKyXZoKlYfZKFSYgP6p8DmVpy5GXBeAjnPVUiX
	 ag9tV1g5Q35bzsvuLG+87TheS8xszMzEruoynVXieEeoGENBxFonpR8J0efnJh48S1
	 nmOYZufAfc+MTsHqLYZCQZcO19PR4OL/OGuS+Et2XxYGCxs1C5gxiDgl8eeXdCu/Rw
	 bVxclB29eh6/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net: Clear skb metadata in LWT BPF xmit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
References: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 10:47:40 +0000
Message-Id: <20260515104741.DF6A9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditionally calling `skb_metadata_clear()` in `bpf_xmit` cause=
s a data race and corrupts metadata for cloned SKBs.
- [High] Uninitialized memory read and metadata corruption in non-BPF encap=
sulations and `bpf_input`.
--

commit 2265e07ff5cfd9680de6b565a2b5679d5adafe20
Author: Jakub Sitnicki <jakub@cloudflare.com>

net: Clear skb metadata in LWT BPF xmit

This commit clears the SKB metadata in the LWT BPF xmit path before
invoking the BPF program. It aims to prevent a warning in skb_data_move()
when bpf_skb_change_head() is called on packets with existing metadata and a
non-matching MAC header.

> Drop skb metadata in the LWT BPF xmit path, just before invoking the
> program. Doing it late, rather than in ip[6]_finish_output2(), preserves
> metadata for tc egress on the outgoing device when no LWT BPF program is
> attached - the only scenario where carrying tc-layer metadata through the
> IP output path could be meaningful. Non-BPF LWT encap types do not run
> helpers that touch metadata, so the BPF xmit op is the only site that nee=
ds
> the clear.

Is this assumption accurate for non-BPF encapsulations and LWT_IN programs?

When non-BPF encapsulations (like IPIP or SEG6) or LWT_IN programs use
skb_push() to prepend outer headers, they shift skb->data downwards but do
not migrate the metadata block.

Because the metadata pointer is implicitly calculated as skb->data - meta_l=
en,
the new encapsulation header silently overwrites the original metadata memo=
ry.
The implicit metadata pointer shifts further into the uninitialized SKB
headroom.

When the packet subsequently reaches TC egress, won't BPF programs accessing
data_meta read uninitialized headroom memory instead of the preserved
metadata?

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d3..d26cb9bb81893 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -284,6 +284,11 @@ static int bpf_xmit(struct sk_buff *skb)
>  		__be16 proto =3D skb->protocol;
>  		int ret;
> =20
> +		/* LWT BPF programs cannot access skb metadata but can corrupt
> +		 * it with helpers that operate on skb headroom. Drop it.
> +		 */
> +		skb_metadata_clear(skb);

Since bpf_xmit() operates in the LWT IP output path which frequently proces=
ses
cloned SKBs (e.g., from multicast forwarding or TCP retransmits), is it safe
to call skb_metadata_clear() here without unsharing the SKB?

skb_metadata_clear() directly modifies skb_shinfo(skb)->meta_len. For cloned
SKBs, the skb_shinfo structure is shared across all clones. Modifying it
without gaining exclusive ownership first (such as via skb_unclone()) will
silently zero out the metadata length for all other clones of the same
packet, causing them to unexpectedly lose their metadata when processed on
concurrent, unrelated network paths.

> +
>  		ret =3D run_lwt_bpf(skb, &bpf->xmit, dst, CAN_REDIRECT);
>  		switch (ret) {
>  		case BPF_OK:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514-bpf-lwt-dr=
op-skb-metadata-v2-1-458664edc2b5@cloudflare.com?part=3D1
