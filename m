Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C13D567B
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370155; cv=none; b=JOU7Ae1IC6rgXMWTzxj0e8N0K+LjiQ9Nf7NzJ3VO+Jwmh29Zw4eEBqCCAhEHI3QAdcn+q/k+F2V9RAMcwP/vDFQjMyn4dGX12FyrRG+7vV90IniU7x4KnXC9uyOVR9V7gtB64L1vyb3RH4VbuUzOkA6jIYppoFdMZBy4IHiDSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370155; c=relaxed/simple;
	bh=p7PF1+Ak8Iybl1uC9834+fGeYsrgAbgggOaxN16RawU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W4fMP1Fy8hqdWs+bPhDA+u9kVpnyDQyjBtItBNbtsfMdN6U4IUeGhU1JaPv2pWYCgmNPN/fSr5ThB1hjQtkfKExCoA80PbpOezS1JIUdA9fpswqv7JaWkEap8TNn+34ei746qj/3tNq8wB1nZ0B88EgATpCpXRAOkgYpaFPB3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYbFa1+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYbFa1+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC621F00A3B;
	Thu, 21 May 2026 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370154;
	bh=GLT8DV20jiyyay1hjKcM6XdDN+QqqxDcxHpXd03g+XA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYbFa1+P2h0kppsHARqxDSxrc0c8Tt8BKT6IrgTtiArU1wFIOxXHnvHtAZkbiwHT0
	 GvYxO8UZEKRqTtds8dft5WINrqpBE7XpUL3vGFKFqwrMoCOAoUuicJq3JNIksS7SUX
	 ApOFxdyaU6Pfqq8goMogo1rimR8ftvxunN2hPlUUd8imDv96LAASA+H6/ch/QSh6IB
	 0/Q9ag9W6+ZRvy/uY+3A5gWnyACSD6gxXoQdHVgc2ucofAM/6KHlQ3Ibahw5KlEvJ8
	 PEFBW2CNL0Qubb7KP2uDI0xhhWipMDpLaPn3AzbpWpltkPU/MXSETOP9cjXgFvN0x7
	 akED4mNV2DxMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 7/8] bpf: add bpf_list_is_first/last/empty
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521032306.97118-8-kaitao.cheng@linux.dev>
References: <20260521032306.97118-8-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 13:29:13 +0000
Message-Id: <20260521132913.EAC621F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment uses deprecated style in `bpf_list_empty`.
--

commit 22a1ce2a5267998c134b07d40be7e92224236cc6
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

bpf: add bpf_list_is_first/last/empty kfuncs

This commit adds three new kfuncs to allow BPF programs to directly query
whether a node is the first or last in a linked list, or if the list is
empty. This avoids the inefficiency of having to pop and push nodes just
to check these properties.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 89579165ef4dc..b6c3d02d5593c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -2656,6 +2656,43 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(st=
ruct bpf_list_head *head)
[ ... ]
> +__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
> +{
> +	struct list_head *h =3D (struct list_head *)head;
> +
> +	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
> +	 * called on its fields, so init here
> +	 */

[Severity: Low]
This isn't a bug, but the multi-line comment uses a deprecated style.
According to BPF subsystem guidelines, multi-line comments should have the
opening /* on its own line.

> +	if (unlikely(!h->next))
> +		INIT_LIST_HEAD(h);
> +
> +	return list_empty(h);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521032306.9711=
8-1-kaitao.cheng@linux.dev?part=3D7
