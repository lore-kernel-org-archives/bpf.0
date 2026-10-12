Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522504B0E28;
	Mon, 12 Oct 2026 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821768; cv=none; b=Rtdp71bt4kUs4E4uvPvcDW2JnsjmSO6ev7HQDp1gTUb7tERq4XeNgiqAG8P0GYlNM7W6P9BVtWJtRtuhFfIwR4zaXCkFuOfp5yUgIQ7NVeKBNiPydLp+9LYGOWD/qv6033XobL9R3YNL7Hnu0jMWCGTOi/fnXeYTai43G4cztgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821768; c=relaxed/simple;
	bh=agePPaLdnXEN3kQN7noUxSbJN/HXkEr5bk7QxbY3JE8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XnRkEDI5t/pYTs1hUhVKhc/iaoqWucjMJYe+SSZeLU/V1PtWhq84dlnjbx1CLAkxUfjZHc+mmWy7T2PjD+rIyj3O9ledtIZTV5L5BKq8sKh8RdgiqV1Za67sIw9rvpyDRTq/EISii5OqUFz90DdEZa1dXs1wWyELzj30LLtirYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjSkCsDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjSkCsDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A3D1F0089B;
	Mon, 12 Oct 2026 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821766;
	bh=T6fPcY6JlPrUhMMTreh6oVRaRWau+C8UmFCp9PcL7yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LjSkCsDeHnTwclSTF8z3JLbD7hrZ/uWe9aWrGTkfsHwb0XnJqqjN4k/Ezy3L6bHti
	 LGm2oXZL60KtlbbgDcV3SLSwf/fR91b+gzhiZl/KO6VGqpC3d5rKbAIjjyrp6vQyE3
	 jnXdwfR+7r3x35RaImyTtsV9AXq5PGVlQrRpTqC/BYxjvqymO7Xl4X/wkaK981bZK8
	 4lbFfD5Uehj2vcILvJDaY6BJyB6KASzHUcQYl0vzj0xzeO5UkLjt7f9t4eWGexrKlI
	 FqP4Yo/I6PF80lEaycBq1/a66Ff3XGhwW/jFwaqLytEeXoclM4veXOwFVyDtOm55xC
	 vJYAgECYKbOgg==
Message-ID: <sashiko-outbox-168381@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 09/21] bpf: Add
 bpf_trampoline_multi_prog_attach/detach()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261012154024.29423-10-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-10-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 16:16:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: Use-After-Free of trampoline images when text poke batch =
fails in detach
--

commit 357aa776c5f19ab7b39da8fb3843fb0141fc3b7f
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add bpf_trampoline_multi_prog_attach/detach()

This commit introduces multi-attach and detach helpers for BPF trampolines.
These helpers prepare target trampolines, apply text pokes in batch, and
commit the staged trampoline images.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> +static void bpf_trampoline_multi_prog_rollback(struct bpf_trampoline *tr)
> +{
> +	if (tr->multi_attach.new_image)
> +		bpf_tramp_image_put(tr->multi_attach.new_image);
> +
> +	tr->flags =3D tr->multi_attach.old_flags;
> +	tr->multi_attach.old_image =3D NULL;

[Severity: Critical]
If __bpf_trampoline_unlink_prog() fails and calls
bpf_trampoline_multi_prog_rollback(), old_image is cleared for the node.

Does this guarantee that a subsequent bpf_text_poke_batch() will fail
due to a NOP expectation mismatch?

> +	tr->multi_attach.new_image =3D NULL;
> +	tr->multi_attach.old_flags =3D 0;
> +}

[ ... ]

> +void bpf_trampoline_multi_prog_detach(struct bpf_tracing_multi_link *lin=
k)
> +{
> +	struct bpf_tracing_multi_node *mnode;
> +	int i, err;
> +
> +	trampoline_lock_all();
> +
> +	for_each_mnode(mnode, link) {
> +		bpf_trampoline_multi_attach_init(mnode->trampoline);
> +		err =3D __bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline, =
NULL,
> +						   &trampoline_multi_prog_ops, NULL);
> +		if (WARN_ONCE(err, "__bpf_trampoline_unlink_prog failed: %d\n", err))
> +			bpf_trampoline_multi_prog_rollback(mnode->trampoline);
> +	}
> +
> +	for_each_mnode(mnode, link) {
> +		link->pokes[i] =3D &mnode->poke;
> +		bpf_text_poke_init(link->pokes[i], mnode->trampoline);
> +	}
> +
> +	WARN_ON_ONCE(bpf_text_poke_batch(link->pokes, link->nodes_cnt));

[Severity: Critical]
If bpf_text_poke_batch() fails here (for example, due to a hardware or memo=
ry
error during patching, or a NOP mismatch from a prior unlink failure), the
failure is wrapped in WARN_ON_ONCE but otherwise ignored.

The code then proceeds to unconditionally call
bpf_trampoline_multi_prog_commit() for all nodes, which frees old_image
via bpf_tramp_image_put().

Since the kernel text remains unmodified after a failed poke batch, it will
continue to jump to the freed old_image. Can this lead to a use-after-free
on traced paths?

> +
> +	for_each_mnode(mnode, link)
> +		bpf_trampoline_multi_prog_commit(mnode->trampoline);
> +
> +	trampoline_unlock_all();
> +
> +	for_each_mnode(mnode, link)
> +		bpf_trampoline_put(mnode->trampoline);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012154024.2942=
3-1-leon.hwang@linux.dev?part=3D9
