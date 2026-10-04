Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D539A04C
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121824; cv=none; b=CScNvu1jtEt3pNwS4b0e2FTZCy9tLILUjuMjO4NevYpwfXrKTBraiNKhcba7OdJsbSStcF4fnFJtfotpwTQbA/Ltwd+DxVJzx1MNc/AZLxo3lrHY6YV1ZVZMHeJ2ZrMALWZY1C2jp4LT62kBy56l82uaDD1xQEo97EmjShTeDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121824; c=relaxed/simple;
	bh=Aea23bK8B6t7DCpVCGm7mQ6nilMV8pbu2Ckvlmmg/IU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zj/RfIgQl4drLFH9Qv/XB8ImZ6pSiRBn2uLOVcul8mH7JHMIjhn1C4gx/3shNCYj39dZzrtQyzOkbEAG12Do0FHGYU6rm/mHseNG1R7pRkWKFfmlkPw4EGvxKCMsjsjvEkFdxJ74UzJIUZnDFr7P1csxMPdpOxhWbHANhZ51vQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewqsjw06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewqsjw06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D7D1F000FF;
	Sun,  4 Oct 2026 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791121822;
	bh=V/FNlRO9YHBzgKmnX0hF4ljHl4TmmmfVWKC7dOLTFT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewqsjw06+znbGkhJ09MTbyqEGNjKoNg6deNiJ2dvq3HzbCflqRIdW2Uklv4QM3pTd
	 nJ04vTN9dTcIhvXS81jiT3e9nJZKuVS/+E1SxB8t618s9brnysin4C3ENN996oE20v
	 OOpCnF4a4gCqTT4Qv8XENJXY2XGP7Nfgj+Wnc1J+vNbkyjz3TbsyhmeGQzeCJUYcMR
	 n7uFL7jEotMH77BfYPmAetGn/AYr3MW8XnxcOfa+H4LJgU1WrbN77ute4TPFlcT5xt
	 Mpfp+Gaz50Sk8+/RCqZ1Qk0dz8OtYa1EgpU+Y4YpEm5QlpQA81s6IDLtplcbG5QkNL
	 aHLB0EM+xNisg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 18/43] bpf: compute immediate dominators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261004-scev-minimal-rebase-v2-18-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
 <20261004-scev-minimal-rebase-v2-18-f6254e29fdf2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:50:21 +0000
Message-Id: <20261004135022.46D7D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: integer overflow in compute_predecessors size calculation
--

commit ce110737451057ca4a576ab4cd5332b75722cc64
Author: Eduard Zingerman <eddyz87@gmail.com>
bpf: compute immediate dominators

This commit introduces a new immediate dominator tree computation for the
BPF verifier. It analyzes each subprogram to find exit conditions that
dominate loop backedges.

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> new file mode 100644
> index 0000000000000..0a9e10edca871
> --- /dev/null
> +++ b/kernel/bpf/loops.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/slab.h>
> +#include <linux/sched/signal.h>
> +#include <linux/bpf_verifier.h>
> +
> +static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env =
*env)
> +{
> +	struct bpf_iarray *succ, *preds, **result;
> +	struct bpf_prog *prog =3D env->prog;
> +	u32 *num_preds, i, s, sz, len =3D prog->len;

[Severity: Critical]
Since sz is typed as a 32-bit integer, could it overflow during the size
calculations below?

> +	struct bpf_insn *insn;
> +	void *tmp;
> +
> +	num_preds =3D kvcalloc(prog->len, sizeof(u32), GFP_KERNEL_ACCOUNT);
> +	if (!num_preds)
> +		return NULL;
> +
> +	/*
> +	 * 'result' layout:
> +	 *  - array of pointers (struct bpf_iarray *)[len]
> +	 *  - struct bpf_iarray one after another
> +	 */
> +	sz =3D sizeof(struct bpf_iarray) * len;
> +	sz +=3D sizeof(struct bpf_iarray *) * len;
> +	for (i =3D 0; i < len; i++) {
> +		insn =3D env->prog->insnsi + i;
> +		succ =3D bpf_insn_successors(env, i);
> +		sz +=3D sizeof(u32) * succ->cnt;

[Severity: Critical]
Because sz is accumulated here without overflow checks, can a BPF program
with many gotox instructions sharing a large jump table repeatedly add a la=
rge
succ->cnt, causing sz to wrap around?

> +		iarray_for_each(s, succ) {
> +			num_preds[s]++;
> +		}
> +		if (bpf_is_ldimm64(insn))
> +			i++;
> +	}
> +
> +	result =3D kvzalloc(sz, GFP_KERNEL_ACCOUNT);
> +	if (!result) {
> +		kvfree(num_preds);
> +		return NULL;
> +	}
> +
> +	tmp =3D (void *)&result[len];
> +	for (i =3D 0; i < len; i++) {
> +		result[i] =3D tmp;

[Severity: Critical]
If sz wraps around and a small buffer is allocated, does tmp end up pointing
completely out-of-bounds?

Would this loop and subsequent array accesses then overwrite arbitrary kern=
el
heap memory, potentially leading to critical memory corruption when an
unprivileged user loads a crafted BPF program?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-scev-minim=
al-rebase-v2-0-f6254e29fdf2@gmail.com?part=3D18
