Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F036492D
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772364; cv=none; b=k38EIw7uH7FrSdSPOgE8boiA58/Aw/fdb1U4ifFN1zwnszZdWECBn1u3Nl9um2LRZOk2mh7+GLtuM7fp8Us8KiwKygyAROgFOfhUQ1CpuWYwq8++4uPOl76zUC4sDjHJkOYXkZgl1+oe91a7JHpy8xh4VQuIY880avEd1ZSqWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772364; c=relaxed/simple;
	bh=q//xc7xIC2Cgn3CZWxYxMvyQZQkGKXYPVOAgAO8Eqtw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BlFupxGODUE9ofeYe3YMtcEoLfnXl0R4SOves1oF6TdgfjpaR2EwoE/Lq3KTcP2DithR8cLVLaEH+y9I8PQovUIQSX7Z9MkyM8dgnCUPUo1yVYeF5406oIr/nVfRpXlPl1h8XrdDgYaaadATJL6aRtxNv3MGwhkd4lnK8rzLXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adZWwNf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adZWwNf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5121F00A3A;
	Wed, 26 Aug 2026 19:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787772348;
	bh=9Qtu2mrELyj+Wnq3ymSSEO99RMqKov307L31p4+O0XY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=adZWwNf6dKBhOAiECvXAGKL7Zr/g7VkEUD3+7C56rJkvDraQe5aX/7QvMg/S3s9fd
	 yxebu2m3kKSY6TWSAenekLbeQE2tm9ItlasW4w+Saj8mtAHFQqjxzlIbDc/zk5ltHw
	 2uMOtndV9LDu9PcFdpRishRLeNo5LYdhzkk1Ok4b+5D5DKq0EbSa0bei4SU2ETii4T
	 Wb9p14GAbFKRPGRmSdxODg13Anj6AVQ2sQ9sBxv5lELaqHCfknGtO7x55j2jmouk3T
	 KBO2AscAWSMqGFaNkKTT41P7GljnuN/ULfPip1Cu/fTbdaGeM0XCri6U99E82hY8hO
	 PhTQohxVqo9OQ==
Content-Type: multipart/mixed; boundary="===============0079780471578845309=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c86de5711fe0646c0d7887e5818709f181288fa0705c35911e0e1e7899c047c5@mail.kernel.org>
In-Reply-To: <20260826-bug-029-bad-non-null-inference-v2-1-136789ace9e9@localhost>
References: <20260826-bug-029-bad-non-null-inference-v2-1-136789ace9e9@localhost>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: check_cond_jmp_op(): properly infer if register is null
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,npc@anthropic.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 19:25:48 +0000 (UTC)

--===============0079780471578845309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: check_cond_jmp_op(): properly infer if register is null
>
> Nicholas Carlini reported a bug when verifier can incorrectly infer
> that a pointer is non-null. The bug occurs when two pointers are
> compared and one of them has a type w/o PTR_MAYBE_NULL flag,
> but which allows a value to be NULL at runtime.
> Here is an example:
>
>   // `a` is PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED
>   // `a` is 0 at runtime.
>   // `b` is PTR_TO_MAP_VALUE | PTR_MAYBE_NULL
>   void *a = bpf_rdonly_cast(0, 0);
>   int  *b = bpf_map_lookup_elem(...);
>
>   if (a == b)
>     *b = 42;  // verifier does not catch null pointer dereference
>
> This happens because of a special case in check_cond_jmp_op(),
> which attempts to strip PTR_MAYBE_NULL flags from pointer types,
> when processing comparisons like `rA == rB`, if either rA or rB can't
> be null.
>
> The non-null property is derived based on the absence of
> PTR_MAYBE_NULL flag on rA's or rB's type. But that is not sufficient
> for types like PTR_TO_MEM, as in the example.
>
> This patch replaces type_may_be_null() call with reg_not_null(),
> which contains an allowlist of types for which absence of
> PTR_MAYBE_NULL actually means that the value can't be NULL at runtime.
>
> At the moment, the list in the reg_not_null() omits two types for
> which PTR_MAYBE_NULL is applicable: PTR_TO_XDP_SOCK and PTR_TO_BUF.
> In order to remain backward compatible, and assuming that only
> comparison between pointers of the same type makes sense,
> this commit extends reg_not_null(). W/o such an extension e.g.
> verifier_jeq_infer_not_null/null_ptr_to_map_value fails.
>
> reg_not_null() can be extended further, but I deem that out of scope
> for the fix at hand. Explicit base_type(...) != PTR_TO_BTF_ID
> checks in the check_cond_jmp_op() can be removed with migration to
> reg_not_null(), but that is a behavioural change, as the special case
> would start matching for PTR_TO_BTF_ID that is also is_trusted_reg().
> I omit the behavioural change from this commit.
>
> Fixes: befae75856ab ("bpf: propagate nullness information for reg to reg comparisons")
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This isn't a bug, but the changelog opens with "Nicholas Carlini
reported a bug", yet credits him only with "Suggested-by:". Would
"Reported-by: Nicholas Carlini <npc@anthropic.com>" (optionally
alongside a Closes:/Link: to the report) match the body text better?

This isn't a bug, but the reproducer is already written out in the
changelog. Would it be worth landing it as a __failure selftest
(e.g. in progs/mem_rdonly_untrusted.c next to null_check()) so the
fixed inference stays covered?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33000653934
--===============0079780471578845309==--
