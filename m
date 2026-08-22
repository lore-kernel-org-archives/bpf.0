Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A082931FF
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359595; cv=none; b=oCVzv+1ybCo+cLanij3fW1xefeZODAFap7RZ6gbTytxaE/d4Vu27ZFJCH9J8NzFkmOO1krz14b1eRYvKJWb9XMXUnoR3ZkPwcO9d4CqtVjGTzR0AFLNZctm+JOnbbWVBnmP0s7mEZMyyDh58RYYJ49uLd1FdN18sSbFCgWrnAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359595; c=relaxed/simple;
	bh=uhNb9nUCaL1FlnR7rGrvXBF0hfBAUTp1qgp8sn5DQCI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c2CYyapvQIKiAXQE2bwlSZTbp5nxj78m5afvcFIqtiVhRSmWzyvtYE0Akhlipm//DGMbr5ixvVDbFqzJ5YjvJzZxdcborm4FqW8FFeWPAW5ksagPEWdBo8almp6m1NJRO5lPpuZZzlwScRHuKarQEAgdZDLwxTiXWJVDRuPsdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8Z5RNs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8Z5RNs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC161F00A3A;
	Sat, 22 Aug 2026 00:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359593;
	bh=y5LsC/KF/ksav4FCYxPdlaR1y0e3SnlF1VCwPnRM1Xg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K8Z5RNs0pKGiShA7GtFQCsP/IXBd2FF3rp1u4fFUjVZMHzBt5TteRRYoRADkUx2zw
	 NyaWwY0eR+Xx/uUV7OmI4FBSS6jUwTSXx5rLWQBZP39d5898oACfyVI3Jvu4TRL+PO
	 HCyR7M6Gd4lPbtnT2/UI5lFx3Zj8m4ijLvumDlAe3BpDsr0khAkg4viYOyYe7hMoOc
	 yOhWGFzDpUFHfXFnfBsS6vQeuL4hY3xtANGdNU2U7eDjygHJ2hndCqk4FJpkWRUXpU
	 kFiq6Lp7qlDnVAdS6PzhTqPYy/JqaZtbaV0SaqyZByR4Z5pUTBAff8E4YsxwtNhyyW
	 54nxecMQ1wcvA==
Content-Type: multipart/mixed; boundary="===============2473846574651238165=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <633e8cec05d3a6c95f8c3ce2343469d4341c5b8d7c4da1bfbf5a79d22fcd77f1@mail.kernel.org>
In-Reply-To: <20260821233516.3426127-13-memxor@gmail.com>
References: <20260821233516.3426127-13-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 12/14] resolve_btfids: Drop KF_ARENA_ARG flag support
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 00:46:33 +0000 (UTC)

--===============2473846574651238165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 37d7e7224207d..3dbf329edb469 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 3f9949e8227df..a4381c7fa7da4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c

[ ... ]

> @@ -315,7 +307,7 @@ void test_resolve_btfids(void)
>  	}
>
>  	/*
> -	 * Check resolve_btfids wrapped exactly the arena-flagged or suffixed
> +	 * Check resolve_btfids wrapped exactly the arena return or suffixed
>  	 * return/args with the address_space(1) type attribute, and left other
>  	 * pointers/returns untouched.
>  	 */

Does the reworded comment accurately describe the mechanism? After this
patch there are exactly two annotation sources: KF_ARENA_RET for the
return value, and the __arena/__arena__nullable parameter-name suffixes
for arguments.

A return value has no parameter name, so it cannot be suffix-annotated.
Looking at add_arena_tagged_proto():

    if (kfunc->flags & KF_ARENA_RET) {
            ret_type_id = arena_tag_ptr(btf, ret_type_id, kfunc);
    ...
            if (!is_arena_param(btf, &tag_params[i]))
                    continue;

is_arena_param() is only ever applied to btf_params(), never to
proto->type.

The new text 'the arena return or suffixed return/args' mentions the
return twice and asserts a 'suffixed return', which the code cannot
produce. The old wording ('arena-flagged or suffixed return/args') was
defensible because 'arena-flagged' collectively covered KF_ARENA_RET,
KF_ARENA_ARG1 and KF_ARENA_ARG2; the reword keeps the '/args' shorthand
but drops the term that made it coherent.

Could this be reworded to 'the KF_ARENA_RET return and the suffixed
args' to match what the code below actually checks?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32538351576
--===============2473846574651238165==--
