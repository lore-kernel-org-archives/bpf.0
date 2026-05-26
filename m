Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE53D1CB2
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789942; cv=none; b=WIfA0+URwVurkNDkCKlEixCotySmgoLWcL5YP2/hN5veYj1Kc08oCm0JSCoNRRf8INyesDZwZfGVIPxYSpQi5Aq3jKHOgylZZ4TSrDGp8b9D+Kp4YpSz9nv9AZSztJotzeUNbUOf0G/EgV944leXRIXj8++eQdK0YSOe9V8lFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789942; c=relaxed/simple;
	bh=9fY1iyiH8mmPjQnmCaib67qbpxEL6x5F7z5CwKCpv7c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=my/ZtR4Eg0LTaBGIUziGCQ4vmc6ObaBA4Q4xv1pRCIQF2hG/OAMcOx2Ux6kBSB2S4DYOi903HaV10WWltNn7zPPi31/2RF+p5jvk3DzzXMnobzyEbercCiMWmfLG3RNbS+WpVLmItBi773AmzWHQnuXfHkBWwGx9Wz4Nade4jvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmC4HF86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmC4HF86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6E11F000E9;
	Tue, 26 May 2026 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779789940;
	bh=1KJnBP0FlB3OseDaFayD74ByQXRzT6pllKsb4iOhVa0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AmC4HF86dh4Trd8+NwgQQ7wvpyAr+oy7OK+k6CoLphmiviKWSRAU7U11SlPHW5qz1
	 MXG5OqfSkc8OY0aDSEQImgHrgBE599nc4P9GO5q8l0PRkQ0gR1mIxxY7P85D0GDLTO
	 5Vd6x+hP9HmsTfBb43vzspWZsksYj0gJsgEs2u/Qt2RweWu0bV9ESNNon1AFNSn2k1
	 mgC9ubzIF/fU/4IpUb48xHYS9hHvdMmPXC0hjloPq7JfUNtxDU9RraqZ03ooveLMHz
	 NrrPEKbnmwEcX9ybQo5gfhCoLuiOqk1EyAu/CF54FETyaD7chECpZAr0dRfzWpQePI
	 yCdJA9BT9FlWg==
Content-Type: multipart/mixed; boundary="===============0893980153539895560=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <17990ac45a42c5a9b8147bd9fbac3760467fe44b4e5ef8068da3c9a4aaa3ee5f@mail.kernel.org>
In-Reply-To: <20260526-better-1m-reporting-v1-2-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-2-51e4f2c59780@gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/6] bpf: compute loops hierarchy
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 10:05:40 +0000 (UTC)

--===============0893980153539895560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5cbad3b64130..d0a1fb135cbf 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> new file mode 100644
> index 000000000000..4bbcd923e960
> --- /dev/null
> +++ b/kernel/bpf/loops.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/slab.h>
> +#include <linux/bpf_verifier.h>

[ ... ]

> +int bpf_compute_loops(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	int i, err = 0, len = env->prog->len;
> +	struct loops_dfs dfs = {};
> +
> +	dfs.dfs_pos = kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	dfs.state = kvcalloc(len, sizeof(struct dfs_state), GFP_KERNEL_ACCOUNT);
> +	dfs.stack = kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	if (!dfs.dfs_pos || !dfs.state || !dfs.stack) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	for (i = 0; i < len; i++)
> +		aux[i].loop_header = -1;
> +	for (i = 0; i < env->subprog_cnt; i++) {
> +		err = compute_loops_in_subprog(env, &dfs, i);
> +		if (err)
> +			goto out;
> +	}
> +
> +out:
> +	kfree(dfs.dfs_pos);
> +	kfree(dfs.stack);
> +	kfree(dfs.state);
> +	return err;
> +}

Should this use kvfree() instead of kfree()? The three buffers are
allocated with kvcalloc(), which can return either kmalloc or vmalloc
memory depending on size. With env->prog->len up to 1,000,000
instructions, these allocations can easily exceed kmalloc's maximum
size and fall back to vmalloc.

Calling kfree() on vmalloc memory causes undefined behavior since kfree()
expects slab-allocated objects. The matching function is kvfree(), which
checks is_vmalloc_addr() and dispatches appropriately.

This affects both the success path and the error path through goto out,
since the cleanup is unconditional.

For reference, bpf_compute_scc() in kernel/bpf/cfg.c uses kvfree() for
buffers allocated the same way with kvcalloc().

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26444655429
--===============0893980153539895560==--
