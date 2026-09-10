Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAD568FA0;
	Thu, 10 Sep 2026 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062743; cv=none; b=Zhm6P9zvKUrP4f70YIXBKs4Z0qeIlCaiGMN5TcD4JMnyZjfYYW2VylcS3ZhrEXG6uMI3fMk6gzZP5ar+7+YZRcaCkWGaalr5kmscXv3qY5XbbPrzvPAKupGjDsf4Zt2KD0E2WMi4uDYfZAfE01yg+RZgtHIHL5UC4bHOEYf6hjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062743; c=relaxed/simple;
	bh=mqIjDgwt1k4t/LjJAiodLZiq4rf4oaNlRQSqNUKnMiU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aDP+lxf/MX7Ik9O9WbWaDDq5HyEyWdV8MHLTmZeL/AnRkdeDT2QFkXdrMfwD+bCR0FKV9eOGY6WS1hc0oT/LVk1uCzVruhXFyyLt+DjWJvY+6rJ/ALQMxpwsii50nk2/Qxj5XrVNQgFqY94xa8W6yXchmYy0Dvt7ZlZ7u5AwWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpgfJEhs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpgfJEhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF1A1F00898;
	Thu, 10 Sep 2026 17:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062734;
	bh=rwS1M3RLr+vDcDVapVJ2NACS29ZPvvCWeN6sAturq+U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NpgfJEhsVIw/Zk9OHA+GVJTi6kTpOnZAtxAdTNopMrEAaaBYwF6+FuElVr6VyYIW6
	 gD7IInjuAwbTI4FLlo/VAjMMlTpRP8udb1p7fovkWfg4wJHfT1DN3NjXS1+9/ozyJ9
	 Z1FnYoOeS4/BsllkEJeNhhKvJGDoR9kA/Hb9ndxudulIq3AHj0nTlyhi+8B7OcRhFg
	 eU4cDXRbu92Tzme2of8txzH4A8IRY7X4VjH3+1nymI5C12KjzyVnD2JK73vRX4L6kM
	 +J5euLyRSeOPZ8CAwjFKCA0DUAkzNqi/oQ9H9t+rImkmtbKofjiKIwf/J9idp6lKBU
	 ZysjOIfa6FnWA==
Content-Type: multipart/mixed; boundary="===============7603380297199476794=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6ba21fcb39349c144c340d3605e25a30710ff43c5ea0c53045e78f4408411fdd@mail.kernel.org>
In-Reply-To: <20260910164635.459558-2-vineet.gupta@linux.dev>
References: <20260910164635.459558-2-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of bpf_reg_state->id [NFC]
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 17:52:13 +0000 (UTC)

--===============7603380297199476794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 66fb11b6c6a7..d974baad37ee 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -369,13 +369,6 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>   * and r7.id=0 (both independent), without temp IDs both would map old_id=X
>   * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
>   * X->temp2, but X is already mapped to temp1, so the check fails correctly.
> - *
> - * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
> - * base id (flag stripped) must both map consistently. Example: old has
> - * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
> - * (r3 derived from unrelated r4). Without the base check, idmap gets two
> - * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
> - * with A->B. The base ID cross-check catches this.
>   */
>  static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>  {
> @@ -384,15 +377,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>
>  	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
>
> -	if (!check_ids(old_id, cur_id, idmap))
> -		return false;
> -	if (old_id & BPF_ADD_CONST) {
> -		old_id &= ~BPF_ADD_CONST;
> -		cur_id &= ~BPF_ADD_CONST;
> -		if (!check_ids(old_id, cur_id, idmap))
> -			return false;
> -	}
> -	return true;
> +	return check_ids(old_id, cur_id, idmap);
>  }

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index d571fbfc86a3..da6cb961a520 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c

[ ... ]

> @@ -648,10 +648,10 @@ l_exit_%=:							\
>  }
>
>  /*
> - * Test that regsafe() verifies base_id consistency for BPF_ADD_CONST
> + * Test that regsafe() verifies base_id consistency for ADD_CONST_*
>   * linked scalars during state pruning.
>   *
> - * The false branch (explored first) links R3 to R2 via ADD_CONST.
> + * The false branch (explored first) links R3 to R2 via ADD_CONST_64.
>   * The true branch (runtime path) links R3 to R4 (unrelated base_id).
>   * At the merge point, pruning must fail because the linkage topology
>   * differs.

Does this comment still match what the code does? The patch removes the
"base_id" concept from kernel/bpf/states.c (deleted the paragraph that
defined it, removed the two-level compound/base id check from
check_scalar_ids), but the comment here still describes the test as
verifying "base_id consistency" and refers to "unrelated base_id" on the
next line.

Looking at the function name and __description below:

>   */
>  __description("add_const base_id must be consistent for pruning")
>  __failure __msg("invalid variable-offset")
>  __naked void add_const_base_id_pruning(void)

and later at line 695:

>  	/* Runtime: R2.id=A, R4.id=C: base_ids A vs C inconsistent,
>  	 * pruning should have failed. */

Should these be updated to use current terminology, or does "base_id"
still have meaning in this context? The test itself still works correctly
after the patch, so this appears to be a documentation consistency
question rather than a functional issue.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282
--===============7603380297199476794==--
