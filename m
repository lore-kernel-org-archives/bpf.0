Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17733D6D8
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834349; cv=none; b=RbCTohi4yk6JyxKiEHkOPnNlHbaJeDlZZ2WefJX1f7L7QwqNITpyXNdgRwPoFRmztWVofqWH6Y+dAZH9RI7/kLp3VNSNWQndzR4bFoKppA6z5UbWfQ7GD6Z91Lc2S2tpjW+DPQlWjXnWVuBB3NSe32iDKup6fQLk/5NSRN8zArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834349; c=relaxed/simple;
	bh=cIluydrtyEjaIeM9IwO/I9477yuicTaZiy8Y6g4noCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LgNOsBi+DamL9cb82mKVMKIVsKLOa/FP/K0DBkQAOxjpjxvdJxcqyFF4PvROxvphnMmNDGFGTsk+QQ880AqwDdgkMBbM9gSswjGaGsMfQ4ZvoWxwrwU3l3K1LkynwHdvG5l5QKhBkWDzbejXMpvMRMkTaLCWGiGLeuTLqLaYKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5ofoITu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5ofoITu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E647C19421;
	Wed, 18 Mar 2026 11:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773834348;
	bh=cIluydrtyEjaIeM9IwO/I9477yuicTaZiy8Y6g4noCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J5ofoITuSkNn3JqDapPqmqfzKeHWHMVjXLtVqOylDdKpnkTZ0TKUgGdWXWrsSmFcG
	 fixPAzXhql0KFpgrvxO8xwj63NZr59eHpveUsGHB0qargwSJGL5bWj5ZpXXwne95dx
	 NM5mF6hrDPp6PmoCSzxZt9Zu3rdJxx71Zc41IxERUpLVR9kIWj9XSG/3rYVHz4Bx2x
	 MzTI9Fv1NYYScYFDDEiUTXegvwB3OaEniW/O3dmQaib3B0phQslfiZ1jnQYx5cl5cy
	 Mo6nV37y9JoEJaYXsVr8CSKSFlu45kQZQIyevdjNHhhrmzVc5TOzNPDHSn09HqVGZe
	 0X5MaaydN9MJA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun
 Heo <tj@kernel.org>, Dan Schatzberg <dschatzberg@meta.com>, kkd@meta.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 0/3] Allow variable offsets for syscall
 PTR_TO_CTX
In-Reply-To: <20260318103526.2590079-1-memxor@gmail.com>
References: <20260318103526.2590079-1-memxor@gmail.com>
Date: Wed, 18 Mar 2026 11:45:28 +0000
Message-ID: <m25x6t744n.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Enable pointer modification with variable offsets accumulated in the
> register for PTR_TO_CTX for syscall programs where it won't be
> rewritten, and the context is user-supplied and checked against the max
> offset. See patches for details. Fixed offset support landed in [0].
>
> By combining this set with [0], examples like the one below should
> succeed verification now.
>
>   SEC("syscall")
>   int prog(void *ctx) {
> 	int *arr = ctx;
> 	int i;
>
> 	bpf_for(i, 0, 100)
> 		arr[i] *= i;
>
> 	return 0;
>   }
>
>   [0]: https://lore.kernel.org/bpf/20260227005725.1247305-1-memxor@gmail.com
>
> Changelog:
> ----------
> v2 -> v3
> v2: https://lore.kernel.org/bpf/20260318075133.1031781-1-memxor@gmail.com
>
>  * Prevent arg_type for KF_ARG_PTR_TO_CTX from applying to other cases
>    due to preceding fallthrough. (Gemini/Sashiko)
>
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20260317111850.2107846-2-memxor@gmail.com
>
>  * Harden check_func_arg_reg_off check with ARG_PTR_TO_CTX.
>  * Add tests for unmodified ctx into tail calls.
>  * Squash unmodified ctx change into base commit.
>  * Add Reviewed-by's from Emil.
>
> Kumar Kartikeya Dwivedi (3):
>   bpf: Support variable offsets for syscall PTR_TO_CTX
>   selftests/bpf: Add syscall ctx variable offset tests
>   selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX
>
>  kernel/bpf/verifier.c                         |  67 ++--
>  .../selftests/bpf/prog_tests/verifier.c       |  34 +-
>  .../selftests/bpf/progs/verifier_ctx.c        | 356 +++++++++++++++---
>  .../bpf/progs/verifier_global_subprogs.c      |  95 ++++-
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
>  5 files changed, 462 insertions(+), 92 deletions(-)
>
>
> base-commit: 77378dabb50f593c756d393d8eacb0b91b758863
> -- 
> 2.52.0

Acked-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay
