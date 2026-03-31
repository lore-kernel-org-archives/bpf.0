Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFF3E3D88
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962195; cv=none; b=KJKOiqcPKJa8kM8Dt/GpKPSXcxNk0MlOMI89weMuQw1Rz3lxG0R7fOrtfE6uGSGP/Z3Qc8Rzgrs5d7klUOct6yyPOvkDl4iZBkr1dfkp6iexbDmS2GO/Lgp2hWAS6E9tO6KxRwlMrfO8ETGRo8rTzXfC9uiZIKOtduf/26qnX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962195; c=relaxed/simple;
	bh=4CzW7YOhBRI2wVd9ytSmK78s7UjO/Lsx99E+wCnu+o4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enQpT1Tu3zcVnR6Z6tLOzJ7iHZSQm+5KCQ96c95zw6cBho/Wi1hUCHfXbvFDHwPolwu40Oad9njjKSQ2dDoNgzJPzjE74EutwYaY7ITTBtsaGeQfYn/nrtOEJnn1eNRDVjUyNuti6LAGrnWD968lucgJL/W1QZo26fztireMVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il2eu5Mz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il2eu5Mz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D13AC19423;
	Tue, 31 Mar 2026 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774962194;
	bh=4CzW7YOhBRI2wVd9ytSmK78s7UjO/Lsx99E+wCnu+o4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=il2eu5MzKbO9eQuDOsbMnNWPfT7CdGXd+iBXofIIcUZelJiZbn47o2a+983lUSGWg
	 skKcAj/GkjtI2Pz/ecI4S4WW456K0q8Wk8cFxgnWBctcQS7yc3kL4dd/N3A2cxYCnS
	 NfN8R1fiTwFYjmVcQab25kHQkgo0M/8MUAbtxAhrNH8OdeoZ4PkpZ2uvByIewIN0DS
	 ohxglEUlzhDxf96BpFwzYi9mIEIIc6SP4DNnxjyYKq0WE1xzz9EIHjuHAX9AEfJUkt
	 siltuWm+t02hMO3qVF52lBiXdUsSf8qSZztuXqEthBLqoACXwpCxTqT6VQ0VB2RCWL
	 3IIdR6zsqxyWQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, Eduard Zingerman
 <eddyz87@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: impose global ordering
 for test decl_tags
In-Reply-To: <20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com>
References: <20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com>
Date: Tue, 31 Mar 2026 14:03:10 +0100
Message-ID: <m2jyus178x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> Impose global ordering for all decl tags used by test_loader.c based
> tests: __success, __failure, __msg, etc. The tags are now sorted by
> testing framework to be processed in the same order they appear in the
> C source code of the test.
>
> The ordering is necessary for gcc-bpf. Neither GCC nor the C standard
> defines the order in which function attributes are consumed.
> While Clang tends to preserve tags definition order in the output BTF,
> GCC does not. This inconsistency causes BPF tests with multiple __msg
> entries to fail when compiled with GCC.
>
> This is based on a patch [1] from Cupertino Miranda (see patch #3) and
> includes some additional cleanups for test_loader.c decl tags
> declaration and processing (see patches #1, #2, #4).
>
> [1] https://lore.kernel.org/bpf/20260305130035.192080-1-cupertino.miranda@oracle.com/
>
> Changelog:
> v1 -> v2:
> - updated remaining str_has_pfx() usages (Puranjay)
> - removed realloc_or_free() (Andrii)
> - fixed qsort(NULL, ...) usage (Puranjay)
> - skip_decl_tag_pfx() returns NULL if tag does not start from
>   "comment:" (Puranjay)
>
> v1: https://lore.kernel.org/bpf/20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com/
> ---
> Eduard Zingerman (4):
>       selftests/bpf: fix __jited_unpriv tag name
>       selftests/bpf: make str_has_pfx return pointer past the prefix
>       selftests/bpf: impose global ordering for test decl_tags
>       selftests/bpf: inline TEST_TAG constants in test_loader.c
>
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  60 ++++----
>  tools/testing/selftests/bpf/test_loader.c    | 202 +++++++++++++--------------
>  2 files changed, 125 insertions(+), 137 deletions(-)
> ---
> base-commit: b6b5e0ebd429d66ce37ae5af649a74ea1f041d92
> change-id: 20260326-selftests-global-tags-ordering-8f324323d9c8


This set looks good to me, after changing the free path of realloc():

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
