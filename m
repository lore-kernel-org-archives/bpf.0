Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC297477E40
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131134; cv=none; b=AEfGjSV8I9uVXmZKKosN2ZXNdrCkpjh2N6+r1/ctTUJXW22Ug4RoU9lyorsukBB583PHs/zu2RmDYYSQ3cNwAlEfmi7kYgTmo8ctxwQaJp2dff1taABNdT4qpXA9ysfLOe6+0E4XfKzktjOsFxEy1XZKDn+l1BBaKDsm/oGb7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131134; c=relaxed/simple;
	bh=bRQgvoaEKG11BskTKOU8E/zChzIDCVr499RV+5s51yc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lL4tt8qIA91n4vkjqI3f3xxT6FVl+yqqOMu0szBhoBE48IK+TkM2bzvMShcRnkCez09PMcRUd9ab4TR31/+XpxbUsFmbtcmZaiKGdF+hrb+qDzykU5WhCYH2MO55kNynwFQx6uXkDcJbdzjImEubkmHtwKXDU7zlE6gjrnh8fBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUc2X3lH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUc2X3lH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F441F000FF;
	Fri, 11 Sep 2026 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131133;
	bh=6hxrY+2Vdq6UVEsz3tRFloJRidnNAT0vjuBON1FIMzE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WUc2X3lH+uPyvS2iuJobODueTEemAlP5odSU8uhmEBx2ZdJrHKyp7UMq2/mvvVF+I
	 by3hgjD8dShASD5HVlXAAIelMwo0FFpmAd0Hk6seUR5T78dkV2IjkHtfzI9RK8LJ0m
	 zies0ffByySRBo6rEfHs128+5uhu/ZIBxE967eHD4k/frS8jKCKUAkw/+/j8kgxexI
	 RD3H5oZQPM5VmJSfR/D75JPM2f9UnrN5EwmaU2u19lGL6K6qiVUIQyZTs46IfIHVHw
	 k/eRef65ZPeIv5ruksS56UU+utPB8uaIrVpoxX3uS7IgkMqW3kPL3IMaHkIwHIQP0i
	 crrbhNyqOy1Gw==
Content-Type: multipart/mixed; boundary="===============5572069417875199778=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e0769af3635afed4f52885bbfddbad5c6cb882ee276c3e9e6269591deac6ac12@mail.kernel.org>
In-Reply-To: <20260911120820.46900-3-zhaofuyu@vivo.com>
References: <20260911120820.46900-3-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v8 2/2] selftests/bpf: add tests for selective module BTF loading
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com,olsajiri@gmail.com,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 12:52:12 +0000 (UTC)

--===============5572069417875199778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
> new file mode 100644
> index 000000000000..04a2acc508f7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
> @@ -0,0 +1,159 @@

[ ... ]

> +/*
> + * An empty allowlist skips all module BTFs, so loading should fail.
> + */
> +static void btf_module_allowlist_empty(void)
> +{
> +	const char *mod_list[] = { NULL };
> +
> +	test_load_with_list(mod_list, 0, -ESRCH);
> +}

This isn't a bug, but rather than restating the function name, could this
comment note why a non-NULL one-element array is passed with count 0 --
i.e. that a non-NULL pointer is what marks the allowlist as explicitly
empty rather than unspecified?

> +
> +void test_btf_module_allowlist(void)
> +{

[ ... ]

> +	if (test__start_subtest("default"))
> +		btf_module_allowlist_default();
> +
> +	if (test__start_subtest("allowlist"))
> +		btf_module_allowlist_allow();
> +
> +	if (test__start_subtest("skip_unlisted"))
> +		btf_module_allowlist_skip();
> +
> +	if (test__start_subtest("emptylist"))
> +		btf_module_allowlist_empty();
> +
> +	if (test__start_subtest("invalid_input"))
> +		btf_module_allowlist_invalid();
> +}

This isn't a bug, but would it read better to make the subtest names
match the function names (and list the functions in the order they run)
so a failing subtest maps directly to its function?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34598086716
--===============5572069417875199778==--
