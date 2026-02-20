Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CF64
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618655; cv=none; b=Top0waiYgN4yUbd9MGKQ6jWzqNugT12mC/vcndyiXHeHpenRzl2+zIBK7xudcHe6clRd7gNxmMzq5ranq1xee1ZZWYArYfMLyFDGFm9Fr1IFtiZZSIBI+CqFMl7qUnu44zTWElNrYRcxOOQHWNBPLWzy34uXeIBhvuFHdG9ORFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618655; c=relaxed/simple;
	bh=nv8CpwI9okJBnJJdWm6tj7Sga06cfAwhHUWAV5LQ9eU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ICbHPCMZKuwuSNJoNxudwnD+NJ7CnC2ySlQcp3Qx2Hcq1stVfB7U7G/JHzulw4Ot1l9C0FpuG5MBGRZMUQUQ5a/Uvm5wnNDTOgPBJ1Rr8xJa9yQHvb+lqckVMgznCWUQDrDy/HeJ0HpsNXGynsrK+wAhhVM747pMUL31XYvBhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcf08g8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcf08g8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A445DC116C6;
	Fri, 20 Feb 2026 20:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771618654;
	bh=nv8CpwI9okJBnJJdWm6tj7Sga06cfAwhHUWAV5LQ9eU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fcf08g8hvDGaCXGgXOh4ihNp746DnHr5xe3vvSf+be6AbOA1HqZImXVsi7ms8ZNnT
	 4i/t26//1Y63pSwlTV6Iq+hpKxfdcS6yKOI5iowJOzh9YyuUvWfUi1zgMZLlJ8WHUs
	 a55vHRDCdmc6/2bkfzXbu26zk3dd3B67WZ8aGXpD4BIPIi5fl5J2fNz7EKAViCG8uG
	 pVKf8cMVwvjbg0EP5vKi1KTJji9OV7DIji3nEgtpGXMGpyPB3MYbR3Pp4gnV1gYrPk
	 pmRalEHHzU4dghd0klT1kVfazUn3fSc6yqcqfYelRFAg5QQpDqGdql5CqwNuKYihtG
	 kYC7WEFLMYaqA==
Content-Type: multipart/mixed; boundary="===============8975133139824369262=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20ac5d8ad7e1a7e7d453de5372e31aec4535f188dff144f4454817781d1e49aa@mail.kernel.org>
In-Reply-To: <826ddc79db2a7c1e473615e9cf85c921a32b4838.1771616227.git.josef@toxicpanda.com>
References: <826ddc79db2a7c1e473615e9cf85c921a32b4838.1771616227.git.josef@toxicpanda.com>
Subject: Re: [PATCH v2 1/3] libbpf: support appending split BTF in btf__add_btf()
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,bpf@vger.kernel.org
Cc: noreply@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 20:17:34 +0000 (UTC)

--===============8975133139824369262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Pre-emptively calling btf_ensure_modifiable() on the destination's
> base BTF to prevent a use-after-free: btf_rewrite_str() resolves
> strings via btf__str_by_offset(src) which may return pointers into
> the shared base's string data; btf__add_str(dst) then calls
> btf__find_str(base) which can trigger btf_ensure_modifiable(base),
> reallocating that string data and invalidating the pointer.

Is this use-after-free scenario accurate?

When btf_ensure_modifiable() is called on a BTF that is not yet
modifiable, it takes the full transition path (btf_is_modifiable()
returns false):

btf_ensure_modifiable() {
    if (btf_is_modifiable(btf)) {
        btf_invalidate_raw_data(btf);   /* frees raw_data */
        return 0;
    }
    /* full transition -- does NOT call btf_invalidate_raw_data */
    hdr = malloc(...);
    types = malloc(...);
    set = strset__new(..., btf->strs_data, ...);
    ...
    btf->strs_data = NULL;
    btf->strs_set = set;
}

strset__new() copies the string data into a new allocation:

strset__new() {
    set->strs_data = malloc(init_data_sz);
    memcpy(set->strs_data, init_data, init_data_sz);
}

Since btf_invalidate_raw_data() is only called when btf_is_modifiable()
returns true, the first call to btf_ensure_modifiable(base) preserves
raw_data.  The pointer returned by btf__str_by_offset(src) still
points into valid memory in base->raw_data.

On subsequent iterations, btf__str_by_offset() returns from
strset__data(base->strs_set) rather than raw_data, so even when
btf_invalidate_raw_data() is eventually called through the
already-modifiable path, the string pointer is not affected.

Could the comment be updated to reflect the actual reason for the
pre-emptive call?

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffcb8f..0b0bb5cba22b 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -2004,24 +2004,41 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)

[ ... ]

> +	/* If dst has a base BTF, ensure it is modifiable now.
> +	 * btf_rewrite_str() resolves strings via btf__str_by_offset(src),
> +	 * which for split src may return pointers into dst's base string
> +	 * data.  btf__add_str(dst) then calls btf__find_str(dst->base),
> +	 * which triggers btf_ensure_modifiable(base) and may reallocate
> +	 * the base string data, invalidating the pointer.  Pre-emptively
> +	 * making the base modifiable avoids this use-after-free.
> +	 */
> +	if (btf->base_btf && btf_ensure_modifiable(btf->base_btf))
> +		return libbpf_err(-ENOMEM);

Same question as above for this comment.  The first call to
btf_ensure_modifiable() on a not-yet-modifiable base does not
free or reallocate the existing string data -- it copies it via
strset__new() and leaves raw_data intact.  The described pointer
invalidation does not appear to occur.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22238863764

AI-authorship-score: high
AI-authorship-explanation: The commit has an explicit Co-Authored-By: Claude Opus 4.6 tag, and the commit message style with structured bullet points and precise technical descriptions is characteristic of AI-generated content.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The commit message and code comment describe a use-after-free that does not actually occur; the code change itself is functionally correct but the justification is inaccurate.

--===============8975133139824369262==--
