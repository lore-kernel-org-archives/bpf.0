Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B732A3C9
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786543; cv=none; b=oDe+/RW+YDYmjUQj2c+f/whclZPbMjGvVB2UIio56LzO1gUf0AVNTLO/w6Mmsrnbzc7rYo5DSDk0sFJCHdX/1Ekaae6AMXLppGpbhI6u6NreVCd0ZqV5FV2e4GxLaKJvAcGLAdfkn0yAU7qWBCXLkTLIJIebTtzEWOv+7jgkSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786543; c=relaxed/simple;
	bh=wifmy2M9I33WN9jTlE3XHABxB5wKUHu9cqt3mx9LLQg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QPmDch9UYJF4O0pgdiauFr5I1UUnyIGEfvTAKdDE8TeNSqQhRGO+sZjVBhoaNK7P+VQpzpjk5KxVS4CnxB+nuPbaQwC7x3D1ZACEsAdxD9oH/95KbS1i45qRRk2fQTLJ60SirLRjejwwwBE+VAcz8C6SPxJ/5rAdKKUG8tSm4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxBaZjAF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxBaZjAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C63C4CEF7;
	Fri, 10 Apr 2026 02:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775786543;
	bh=wifmy2M9I33WN9jTlE3XHABxB5wKUHu9cqt3mx9LLQg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pxBaZjAF5OBUrA8fyCnL5+AoQsoaVZwJRLjIjN3LH/WZyFJny+YtsW/+k9f1vk7Sg
	 OyUbK3exfQIWsbWUy0Uj14KtDe0dJPwXh6i2yjZQv6EJjSqC361nTiQQm4FHP+htHI
	 VpTUGLJYD6MfsU4vhak6nkVQacW5xZrs/NFrGy6Dyb3Gpyx+gTgFIEYb0pB6PGc8B0
	 G+0fYZvFP/93afNgePOQfF5bR+sH6CSOaYnpYWXvD7ZFwleZ1SgHLjYPskTmnPHXc+
	 HX5WwXtuOHGLGqz7gUc0U22ZSnML13pEWWXBBSbTGXAzI+6b3PjTf7n7fGftrkU01A
	 sP9Fa5Ej0hZCQ==
Content-Type: multipart/mixed; boundary="===============3617998886249351899=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a9f22c303a699a8ede396b7caedcf9e4f5c543d7df96d3646859f1ecefbda1c2@mail.kernel.org>
In-Reply-To: <20260409-patch-set-v2-7-651804512349@gmail.com>
References: <20260409-patch-set-v2-7-651804512349@gmail.com>
Subject: Re: [PATCH bpf-next v2 07/13] bpf: introduce forward arg-tracking dataflow analysis
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 02:02:23 +0000 (UTC)

--===============3617998886249351899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index a3af5972520f..1b2abc96d5a3 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> + * At memory access sites (LDX/STX/ST), offset-imprecise marks only
> + * the known frame's access mask as U64_MAX, while fully-imprecise
> + * iterates bits in the bitmask and routes each frame to its target.

With 4-byte slot granularity (128 slots), spis_t is a 128-bit type
(u64 v[2]) and SPIS_ALL is {{ U64_MAX, U64_MAX }}.  Should this
comment say SPIS_ALL rather than U64_MAX?

> + */

[ ... ]

> +/*
> + * Collapse to ARG_IMPRECISE with a bitmask of which arg
> + * identities are involved.  This lets memory access sites
> + * mark only the relevant args' access masks and only set
> + * stack_use when AT_CURRENT (bit 0) is in the bitmask.
> + */
> +static struct arg_track arg_join_imprecise(struct arg_track a, struct arg_track b)

Two references here that look stale.  AT_CURRENT is not defined
anywhere in the tree, and the current frame is BIT(depth), not
necessarily bit 0.  Similarly, "stack_use" doesn't appear as a
variable or field in this file -- the code uses may_read.

Were these left over from an earlier iteration of the design?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24221779050
--===============3617998886249351899==--
