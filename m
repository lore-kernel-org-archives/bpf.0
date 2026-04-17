Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE428A3FA
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442587; cv=none; b=d6Bjliwtj4Ar4yrqRSDd1p2pVXm2PaOyoXZp+/7/TaSLX72tse/q/fJHEUyI/bFJBZXEudHGW4qftGe7Kd0LwO7W0q7q4+yjynqLsB0keb6mjmmgpNhs/Prw4l2HaCVzKTCP2HS2I5jotM4b84aUlEU8Q29m8ItRdUl28u7EVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442587; c=relaxed/simple;
	bh=4m5wciz5hNh1yBGDtrmk8eX5Uj3UAlYhVqkQGQ9I7oA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XjVE7bRcYSHRFY32Pa/io2ZqAkkX6ZSI81SXfUW3bLBhKXNqx1aKGshFWebtKsp3KRD4gtR54b/WOBhTp3Vv5bLIg3VYp6YNQju4+mRY1zVmFgFl7ppYqvuHjEKOOB5OoubD3VzZ3SjUFrz7XQMkitNP7mA0zvqF8LrrAmUIFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhJ9xnUA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhJ9xnUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0FCC2BCB5;
	Fri, 17 Apr 2026 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442586;
	bh=4m5wciz5hNh1yBGDtrmk8eX5Uj3UAlYhVqkQGQ9I7oA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XhJ9xnUA0PJumupVEOsVjfohwvc2tr/GnfyOdhXUyfhLzdOKnBH2av3ZZkVc6bjat
	 TzCY/aUdjIkHLo8zLghQu+wW/wTDKCOL7q5J9mm5rlVJOjEH9N9TneKIRatV8bKH4j
	 b5M8OhALJqjF7uJhKZgycjcanjM0pzFofYnD+rdbeFxUL5snHvqD/dUuy7rnwz3M47
	 iOxUytCvNaDkfguWcOxbTqY2GhNGyQg71F+AMsikOnsnBBaDCXnG4R5gDirTtqnvJq
	 cyvGl468+lITPO3RWL/d6+avJReZ6tov8Xi8Kwqn/RbwZPbdQBb/CVJjtHgLoCmMvu
	 UGadITiwKUnDg==
Content-Type: multipart/mixed; boundary="===============7098866610740032263=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d342dea76b229c985c7d6724d3027412935fe2c6bd8945f91829c1f5c3e46188@mail.kernel.org>
In-Reply-To: <20260417154122.2558890-2-grbell@redhat.com>
References: <20260417154122.2558890-2-grbell@redhat.com>
Subject: Re: [PATCH v2 1/2] selftests/bpf: Use local type for flow_offload_tuple_rhash in xdp_flowtable
From: bot+bpf-ci@kernel.org
To: grbell@redhat.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,alan.maguire@oracle.com,grbell@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 16:16:26 +0000 (UTC)

--===============7098866610740032263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: eeb23b54e447 ("selftests/bpf: fix compilation failure when CONFIG_NF_FLOW_TABLE=m")

Should this Fixes tag reference c77e572d3a8c instead? That commit
originally introduced the forward declaration of flow_offload_tuple_rhash
that this patch is now fixing. Commit eeb23b54e447 partially addressed
the same issue by fixing flow_ports but left flow_offload_tuple_rhash
unfixed.

> diff --git a/tools/testing/selftests/bpf/progs/xdp_flowtable.c b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
> index 7fdc7b23ee74..e67daa02749d 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_flowtable.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
> @@ -15,7 +15,10 @@ struct bpf_flowtable_opts___local {
>  	s32 error;
>  };
>
> -struct flow_offload_tuple_rhash *
> +struct flow_offload_tuple_rhash___local {
> +};
> +
> +struct flow_offload_tuple_rhash___local *
>  bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
>  		    struct bpf_flowtable_opts___local *, u32) __ksym;
>
> @@ -67,7 +70,7 @@ int xdp_flowtable_do_lookup(struct xdp_md *ctx)
>  {
>  	void *data_end = (void *)(long)ctx->data_end;
>  	struct bpf_flowtable_opts___local opts = {};
> -	struct flow_offload_tuple_rhash *tuplehash;
> +	struct flow_offload_tuple_rhash___local *tuplehash;
>  	struct bpf_fib_lookup tuple = {
>  		.ifindex = ctx->ingress_ifindex,
>  	};


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24574259813
--===============7098866610740032263==--
