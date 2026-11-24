Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560963;
	b=0cVZjhuEGEqvGm3NJnSJkEH2hn+Jr8zAB8Qc48zsmNQH8I7L5qATIbmgfD4Jl7xNKoFW
	 vh4izmDnL8m1I1+4k5v8c4SkZg9ojCb94w2RsNa9sYVbQtcOkm8DovyV/gl6l87Wz0/ez
	 ClxzP7TpCx74VihGxQFpst5NRuxPuket/QHy9kyjBswi21z7ocI7u5CCu80/p6O3Etec1
	 YPRHOy6vs7qRo5GLko3VLFoME3AKeuF+g3HQTVwndqsx0+t1WUq598KM2dHrdx3Gnryf2
	 7pI5cyT3Y5Rw5+nHXhhZG4ywiWZTCyflT4dK6+4OikqrCicw8DPTs24A6JtV/AEN/Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Sr3fuIxW6c36EzlN3fVwHbLq2oWm6lvo3miJtGPY74=;
	b=yBbUSWugzx3HzkO8sMUoJar14oYMolvpKuscifj3LGcv2l1zoQFNii3ZOHsg9p4TIid6
	 Bbokrt2yzxEppO2/Rt7nUtt+CtiwMfBVLEzMM3g6bZl4H1urE6WfxnirIX60CjZDKH12V
	 xJz22Vrq+cm39peXKjel/Y12ER/bY70OoHreV7ezIKPGMEG+u+afwTeb+FdMQtXZoRyx8
	 rPuu3ttLjVTe62wmdYL106ensyhM5XWkweIO0k8qZulvuVrev2jgMvx8YI1F9NPkaS4pd
	 RDr1ltLGrnsE7UHbljr/MR1QUJldLOEsXR16V/gF5GibqQoGzYNsTvmpxwOS1ihPb9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFHL1rml;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A5B606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFHL1rml
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F61D1F000CA;
	Tue, 24 Nov 2026 22:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560962;
	bh=6Sr3fuIxW6c36EzlN3fVwHbLq2oWm6lvo3miJtGPY74=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lFHL1rml2w7KgLRDG7BxGXaDvPImBxPpopx9hAzgNJ/tRvFDMH1E+Nzj6bB5G7MFg
	 efYGZ4tIdvRrCLP1J2w5+ZgZezUQiEz1EJNNdBjbBEiTLQPMTHOyC0ZKhVoACuz2NH
	 c8HrzNMSAQJe/gKwlfpZIHt/5TLkrGUqYq30H7zhrleDBrNlhN6D9kJx+HKTDRclkl
	 i9/Gw86Uso54UtSKXb6GojKIDH6xDoA1HxowGaOwKbVuU/dWHtZegozpOxgUdfnPod
	 IzQ44n4S+Ob0dQ0WE7jb4CW5LsWkAC9AXzBHSm2om3UxzQ4g/Vu8kbnbvdW5V4joj+
	 ymiYnWBwqWY5Q==
Message-ID: <sashiko-outbox-232176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Align lpm_trie map values to 8
 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Philipp" <tphilipp@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261124225055.87344-3-tphilipp@gmail.com>
References: <20261124225055.87344-1-tphilipp@gmail.com>
 <20261124225055.87344-3-tphilipp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:56:01 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: non-standard multi-line comment style in trie_alloc()
--

commit 7745369351fba1841a655972ae45f1b4be10934b
Author: Tobias Philipp <tphilipp@gmail.com>

bpf: Align lpm_trie map values to 8 bytes

This commit rounds lpm_trie's data_size up to a multiple of 8 bytes when
computing the value offset and node size so that map values are 8-byte
aligned.

> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 4d6f25db9ba12..44ad5c1630006 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c

[ ... ]

> @@ -597,8 +597,14 @@ static struct bpf_map *trie_alloc(union bpf_attr *at=
tr)
> =20
>  	raw_res_spin_lock_init(&trie->lock);
> =20
> -	/* Allocate intermediate and leaf nodes from the same allocator */
> -	leaf_size =3D sizeof(struct lpm_trie_node) + trie->data_size +
> +	/* Allocate intermediate and leaf nodes from the same allocator.
> +	 * The key bytes are padded to a multiple of 8 bytes, because the
> +	 * verifier assumes that map values are 8-byte aligned. Objects from
> +	 * bpf_mem_alloc are 8-byte aligned, so data[] must be as well.
> +	 */

[Severity: Low]
This isn't a bug, but BPF multi-line comment style puts the opening /* on
its own line before the comment text.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124225055.8734=
4-1-tphilipp@gmail.com?part=3D2
