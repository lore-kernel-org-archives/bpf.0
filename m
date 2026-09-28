Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509228DB55;
	Mon, 28 Sep 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580687; cv=none; b=bcNfTtDCZfX8DDpM5sldWrKyxVDnuYrXmFwdgzPNkOb64GTP6FVYnmDR9tfEAn3QQOaEwAWwCKW3MyRC3oxE31h0xbp9y2AKNSBMb8qJ+zBrZRIl4SSyVv1agKtBxEHIIIZlyqMLAwq1ztP9PQe55upgfQww7zIaaO+DKOVqlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580687; c=relaxed/simple;
	bh=Ca9sZ4RBLOYv0TdqAiJl97XpGIudxDx96U1gD4wT5Hk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=knb1EUebGY9k1fGeizw8SYGRtvxJghdKwK0EIorfhITtTqmDdDo54d0m39SU/4jj8G1nscZaBZPAHQHxiTSsYqVz25as/tWDQDxALKGXsmO2YWV2PptGcbkIEW3qHYW1xSezriAMQZxyxMD4PWFXXlQvCIta+brkOAham0K/LKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlNvvELL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlNvvELL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1861F000FF;
	Mon, 28 Sep 2026 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790580686;
	bh=eUkQZnFeJ7aRQhuoiAx/6V9HaJwecxUtJMzNDOUByhI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nlNvvELLQetkR33rdbttAnu4L1qLqJERdAp3Lql0uneIYMjLpl25dXtbCJTzu7mxw
	 E+IeQrkVozoIhK/y7PJ9Sjl5/ngEQsVaRQDjXaGnpPAdIimdL9TDTjSYISmJqpUMwB
	 I7x/PEEZVI2K/WUHJrebBNztLY97PeeLfo0JrGG4PP/yrfUaardojyoTB5W8Pu1+TN
	 DANSCnB/+lm1GcJm506WSNAFS50VeGCDfd84+FFHqe9zN+nKKjPSwP1f44swhsWaKV
	 jHK1SFF6iYjMwl8BVkoSEo9IceMNzkfNvmNXoLzCNbOwUvnJ7ycyqqb4GvLOIbRBP/
	 IYyt0IOB6A5UA==
Content-Type: multipart/mixed; boundary="===============1352127693393188869=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b9e3f19e7883e9d62c2d4c7de0fbaa17017346d92943e36a17704f7a68864ef@mail.kernel.org>
In-Reply-To: <20260928063724.24008-1-hui.zhu@linux.dev>
References: <20260928063724.24008-1-hui.zhu@linux.dev>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add bpf_proactive_reclaim test
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,david@kernel.org,baohua@kernel.org,geliang@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 07:31:24 +0000 (UTC)

--===============1352127693393188869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 2b883b388f90..5621ef94ad7e 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -57,6 +57,7 @@ CONFIG_LIRC=y
>  CONFIG_LIVEPATCH=y
>  CONFIG_LWTUNNEL=y
>  CONFIG_LWTUNNEL_BPF=y
> +CONFIG_MEMCG=y
>  CONFIG_MODULE_SIG=y
>  CONFIG_MODULE_SRCVERSION_ALL=y
>  CONFIG_MODULE_UNLOAD=y

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> new file mode 100644
> index 000000000000..d642658a2198
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c

[ ... ]

> +	/*
> +	 * Charge FILE_SIZE of page cache to the cgroup. Reading rather than
> +	 * writing keeps the pages clean, so reclaim does not have to start
> +	 * writeback before it can evict them.
> +	 */
> +	if (!ASSERT_OK(ftruncate(data_fd, FILE_SIZE), "ftruncate"))
> +		goto out;
> +	for (off = 0; off < (off_t)FILE_SIZE; off += sizeof(buf))
> +		if (!ASSERT_GT(read(data_fd, buf, sizeof(buf)), 0, "read"))
> +			goto out;

Could this allocation method cause issues if file holes are mapped to the
zero PFN in the future? The read() approach assumes that accessing a
ftruncate()-created sparse file will allocate page cache, but if the kernel
someday maps file holes to a shared zero page instead of allocating backing
pages, this wouldn't necessarily give us page cache to reclaim.

Barry Song suggested using write() followed by fsync() as a more future-proof
way to ensure actual page cache allocation, which would also allow removing
the two lines of explanatory comments above.

> +
> +	args.cgroup_id = cgroup_id;
> +	args.size = FILE_SIZE;
> +	skel->bss->reclaimed = 0;
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.memcg_proactive_reclaim),
> +				     &opts);
> +	if (!ASSERT_OK(err, "test_run"))
> +		goto out;
> +	if (!ASSERT_EQ(opts.retval, 0, "retval"))
> +		goto out;
> +
> +	/*
> +	 * A single call is a single bounded pass: it reclaims something, but
> +	 * stops well short of the requested size instead of retrying until the
> +	 * goal is reached the way a write to memory.reclaim does.
> +	 */
> +	ASSERT_GT(skel->bss->reclaimed, 0, "reclaimed");
> +	ASSERT_LT(skel->bss->reclaimed, (__s64)FILE_SIZE, "single pass");

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36389535910
--===============1352127693393188869==--
