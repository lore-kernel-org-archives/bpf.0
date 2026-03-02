Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42462836A0
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472737; cv=none; b=ewWH60V5mnz5OCasmyELyiKK07y6bTVGAKDJHnvRgvIQijGoHX7gPzH5tmWayvIItBX7TFQfVLveQpuv5y9NJlvWxJV/MZNSpyWovjHLNl4w6YLQH1w9O79seBsIyPp1PfXNiAOGOtpEe1dfo9dFVB7g6EdvGIWWKTvqGpu6MUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472737; c=relaxed/simple;
	bh=5ZDTL0UhBj8FmMR3SQ/ZKg5/VvcJcVV2Vl99vYgOlG4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SuxZlaVSdiBRcE1Uqp89OP8MD/ZjECpQShPpDLIxR5o8eqdnbh2TVmsaId53i0w8ZdYyNFP3xDyYMgHDSf8WUBaeosasd5SIYrgJRyXlWtYuXBKQuJJbATqP9pXHvMk4CXszaUGgOgcmmkGPo0j0HN8WOaiH6YBuFrx4CDnUuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwrcP0rN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwrcP0rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F1BC19423;
	Mon,  2 Mar 2026 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772472737;
	bh=5ZDTL0UhBj8FmMR3SQ/ZKg5/VvcJcVV2Vl99vYgOlG4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lwrcP0rNcjYlEb0xnlez7a66uR+9tN14ELSXCzQcBjedJhK8oLR3RmpBAslip8tRo
	 Vy6rURSNlrz/0sUKGZ4La7fpoAs8wv+SYrKGiz96Zrb4e7zraTYk/sfhbx5dJkqmtK
	 3i9xvcZsnbp8NNzg130ZdN7Uxz48VBHBss5EJWz2pcSBGgDJ+LBKfj92Z0hQHQ03MM
	 XMzYcnhZC6jnNKWyTojlSJRkRoR4T+J1D5Xn9nLdhPWAgVanuAx25K+hrjOYpzI/vq
	 b+y4SvlyJLIrIMQ6wFgnN/yi7wpZWfxJgplpt2Gvo6AoBoENUXxz5E/D92Jy0EItRb
	 tK91TIPn4Gg5A==
Content-Type: multipart/mixed; boundary="===============2779274183918500010=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7be9da1d46a65e0646d157e7968171c1a8a7e12f8d99b203be1e6ca83d01ff5@mail.kernel.org>
In-Reply-To: <20260302164846.36713-2-andrey.grodzovsky@crowdstrike.com>
References: <20260302164846.36713-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 17:32:17 +0000 (UTC)

--===============2779274183918500010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -11716,6 +11787,53 @@ struct find_kaddr_ctx kaddr_ctx = { .kaddr = 0 };
> 			prog->name, retprobe ? "kretprobe" : "kprobe",
> 			func_name, offset,
> 			errstr(err));
> +
> +		if ((err == -EADDRNOTAVAIL || (legacy && err == -EINVAL)) && optional_func_name) {

[ ... ]

> +			err = libbpf_kallsyms_parse(find_kaddr_cb, &kaddr_ctx, true);
> +			if (err) {
> +				pr_warn("failed to get addr for %s\n",
> +					func_name);
> +				goto err_out;
> +			}
> +
> +			if (kaddr_ctx.kaddr) {
> +				pr_debug("retrying %s using kaddr 0x%llx\n",
> +					 func_name, kaddr_ctx.kaddr);
> +
> +				offset += kaddr_ctx.kaddr;
> +				free(legacy_probe);
> +				legacy_probe = NULL;
> +				goto retry_create;
> +			}
> +
> +			pr_warn("symbol '%s' not found in vmlinux\n",
> +				func_name);
> +		}
> +
> +		goto err_out;

When libbpf_kallsyms_parse() succeeds but the symbol is not found in
vmlinux (kaddr_ctx.kaddr == 0), err has been overwritten to 0 by the
successful libbpf_kallsyms_parse() return. The code then falls through
to goto err_out, which does:

    return libbpf_err_ptr(err);    /* err == 0 */

libbpf_err_ptr(0) sets errno = 0 and returns NULL. The caller gets a
NULL link pointer with errno = 0, which is an incorrect error indication
for a public API.

This can happen in legacy mode when EINVAL comes from a cause other than
duplicate symbols (the check matches any EINVAL, not only the duplicate-
symbol case), or if the vmlinux symbol exists but has a type other than
'T'/'t' (e.g. weak 'W' symbols), since find_kaddr_cb() only matches
text section symbols.

Would something like the following be appropriate here?

    pr_warn("symbol '%s' not found in vmlinux\n",
            func_name);
    err = -ENOENT;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22586644239

AI-authorship-score: medium
AI-authorship-explanation: Systematic bulleted commit message and descriptive naming suggest possible AI assistance, but iterative v1/v2/v3 refinement from reviewer feedback indicates genuine human engagement.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Error value clobbered to zero on an uncommon fallback path causes incorrect errno reporting to callers, but does not cause crashes or data corruption.

--===============2779274183918500010==--
