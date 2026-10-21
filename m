Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792582831;
	b=yfodS5nbuE1Xu2GY2R8tDaP5xwVKeHIg/jC8faROCKUohK1yDVxoSfmPaFPNOVvY6c9s
	 3yzDHBa0RFoRrAdXh6l1LBfOhX+fS69e/lqgQU6FksAhk9MWY2Li+jDO6LWpyE7D+EA0N
	 CB6bGECuNXeq9c3eR2r+c75PbOJkYcQeg7hmv0IpRXHCD4QQphT8JdNHx/SBz3gCFmptn
	 Kc4mepYwMkmzDfAWixPkEGzhCKFHSmk2gMCOlx1Lz4P4zATacn1aN1ABpM4VECtT0S3ei
	 C/ZwPkeA2KIaPMGwBWH7DCAFUr7wcVS1WyDZv8LhRjNuqUHY4bbhYZpcVow3QfOIz/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582831;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hRvoRPccK0ObKuMf62aLb3R3R+A968xeDh5CRkvKhSM=;
	b=CF+XmGIi6gAtB7Vs6PKDS7GeNLg2Ibbhne3ZweJmH/EJKZYnnBIj8VJYYjUMKzBOwIxs
	 XIsU5EhqJG1QV4QfESNMDFH/Qo7ZGJYLQaUBAW11RWY+/a7cqX/Pi7eA5usoAB8I6+BwX
	 VTLY1UgZNp1grXMvSv++n7gu9y/ofr3JvJ57y7VJPtn/jFqhRrdKbgoEd4F+rFUCGt0OZ
	 IPbnFvOyjVQRU5P/ZqB0iVla6MKGF+qXGz+YB/CnMwqxe6IOuvXfUa4ujcEwIEtZbCVXZ
	 idpD76K6EmuxfM7kdxJDvSY+uiV4oKXjSYD8aanpL+qZRKzZZBpWpUqu9zUFFRmkjmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h33VLacb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE01606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h33VLacb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D781F000C4;
	Wed, 21 Oct 2026 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792582830;
	bh=hRvoRPccK0ObKuMf62aLb3R3R+A968xeDh5CRkvKhSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h33VLacb4OUhHA+wtY+sI5cKdIF2czPPGRkYnihor+xX2FmPSsm/mqo/QiZqMFjow
	 AWYjJG36aosVWVeXvHZChQ5jWXg+Q+oR2yr5m/DQhWJEZIiWeIdlNTiAofFOB5pyNg
	 4W3Wdi2W3qApZEwrYm7vcqQ4veFz9Xnou+P1J97+XeyCUi2dle9mB+e4iR983+W2Yc
	 9FbNOcVqAvzhSOstPejbBtPTzeuxZvk5ysHsMmFyxOGwgx3f0frTjmVSMMS0M4XvN/
	 VsBg7vOfqimxPriV6iNz/idPoeoE5TeH0UpoQ7OqFzLNAV5J07eXOSiZYho022gVY8
	 dqGkF2mK39x3A==
Message-ID: <sashiko-outbox-180175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] mm/page_owner: add bpf_iter target "page_owner"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261021112437.1799213-4-zhen.ni@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn>
 <20261021112437.1799213-4-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:40:28 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/page_owner: rescan and post-stop show() in page_owner_seq_sta=
rt() at EOF
--

commit a6ba125169596a18417440d179f83a946227810e
Author: Zhen Ni <zhen.ni@easystack.cn>

mm/page_owner: add bpf_iter target "page_owner"

This commit adds a "page_owner" bpf_iter target that iterates over pages
eligible for page_owner output using page_owner_next_eligible() and passes
the PFN and a snapshot of struct page_owner to the attached BPF program.

> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
> new file mode 100644
> index 0000000000000..529b2c4a589a9
> --- /dev/null
> +++ b/mm/page_owner_iter.c
> @@ -0,0 +1,118 @@

[ ... ]

> +static void *page_owner_seq_start(struct seq_file *seq, loff_t *posp)
> +{
> +	struct page_owner_scan *scan =3D seq->private;
> +
> +	if (*posp =3D=3D 0)
> +		scan->pfn =3D min_low_pfn;
> +
> +	if (!page_owner_next_eligible(scan))
> +		return NULL;
> +	return &scan->po_snap;
> +}
> +
> +static void *page_owner_seq_next(struct seq_file *seq, void *v, loff_t *=
posp)
> +{
> +	struct page_owner_scan *scan =3D seq->private;
> +
> +	++*posp;
> +	scan->pfn++;
> +	if (!page_owner_next_eligible(scan))
> +		return NULL;
> +
> +	return &scan->po_snap;
> +}

[Severity: Medium]
Can this rescan PFNs and invoke page_owner_seq_show() again after the final
page_owner_seq_stop() callback has already run?

In mm/page_owner.c:page_owner_next_eligible(), scan->pfn is copied into a
local variable and only written back inside the loop before checking
scan->po_snap.handle:

mm/page_owner.c:page_owner_next_eligible() {
	unsigned long pfn =3D scan->pfn;
	...
	for (; pfn < max_pfn; pfn++) {
		...
		scan->pfn =3D pfn;
		scan->po_snap =3D *page_owner;

		if (!scan->po_snap.handle)
			goto ext_put_continue;
		...
		return true;
		...
	}

	return false;
}

When page_owner_seq_next() advances scan->pfn past the last eligible page
and calls page_owner_next_eligible(scan), the loop reaches max_pfn and
returns false without updating scan->pfn to max_pfn. As a result, scan->pfn
is left at the PFN right after the last hit (or at an intermediate PFN where
po_snap.handle was zero).

In kernel/bpf/bpf_iter.c:bpf_seq_read(), when page_owner_seq_next() returns
NULL, bpf_seq_read() calls page_owner_seq_stop(seq, NULL) (running the BPF
program with ctx.po =3D=3D NULL), marks iter_priv->done_stop =3D true, and =
flushes
any buffered output in seq->buf to userspace with a positive return value.

When userspace issues the next read() call to observe EOF, bpf_seq_read()
calls page_owner_seq_start(), which calls page_owner_next_eligible(scan) and
rescans from the stale scan->pfn up to max_pfn. If any page in that range
was allocated between the two read() calls, page_owner_next_eligible(scan)
returns true and page_owner_seq_show() invokes the BPF program again with
ctx.po !=3D NULL after the terminal ctx.po =3D=3D NULL stop callback has al=
ready
run.

Similarly, if the initial scan finds no eligible pages (*posp remains 0) and
the BPF program writes output during page_owner_seq_stop(seq, NULL), the
follow-up read() enters page_owner_seq_start() with *posp =3D=3D 0, resets
scan->pfn =3D min_low_pfn, and rescans the entire PFN range.

Should page_owner_next_eligible() update scan->pfn =3D pfn when the loop
terminates at max_pfn (and only store scan->pfn =3D pfn on a hit after chec=
king
scan->po_snap.handle), and should page_owner_seq_start() also ensure *posp =
is
advanced so a follow-up read() after an empty scan does not reset scan->pfn
to min_low_pfn?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021112437.1799=
213-1-zhen.ni@easystack.cn?part=3D3
