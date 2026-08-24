Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8C32B2D7
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563507; cv=none; b=O4qgsEK1tXRawWirZeWySvLigyokRqVwD4zxWkbu0cszvPS9cnQH4GDiFBkxmqo3cib876Fummj+uJ0FBH40mN2RVLVUnhlrUXm5qlvfi0Ofjg9stEDFfwfdLXSxcgy7A/AipqSUfRSkHNYqqMEXHdHBTUn40NVAbJ4kmNr9sIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563507; c=relaxed/simple;
	bh=qznjS0PDXi9SjI1y/d2z4oNPd3PO0frpXJiY1S+t6/o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=swe9D1i6fpQrsoI2emh2Kde9RM5fFYsyHfw2DFO/Os7XccEbqJXg/wKin9H+EYPFQChcKD3/V+g7d1xjVDI0cfKnoI0Vmi3vyqh7Ik98Ivcc2YR8y9/EATrHM8csPy5hNnNRnJAuGqlR78UcmHDWMLQr4HxrFfO13eaySL+xyoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxPUNBye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxPUNBye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6D41F000E9;
	Mon, 24 Aug 2026 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787563505;
	bh=gBR1nD9IQuVtB35TbOSBC9lUwE1N2JT+vIt11iczKgQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KxPUNBye53Eh6rzQp/U2RZAj/5/c6y1DiJaJ4iAfOGAdxlYb27LI2apW3rL17vj5s
	 tChF1ZK9fLeNfGGMvLpYcEHs31o7xbNTWv1ecD6OhMDuBP9h55CAWTp+75WEZofiD3
	 xervwo8p1n+IQJm1skz9fXkHEi632+pK9fMKON1efuaN1giyf98Aplqay2Q8HpH005
	 nvc0dlVfXSp8HB0GyfhuIcQXjDAXwTQFiale/gCVDaPIDlVIywDeD1DF9zfE+mqlfZ
	 8aFwttfFHjR2RFb4Vbke/xZZkSn/piqFVyRcMdA37ILYgvllBPbLRNCph3LxeD+pnc
	 FVfoV5E8m7NTg==
Content-Type: multipart/mixed; boundary="===============4496037626131391778=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bec6e986016d9cda455a763f444f78bd78df2ffa7a1025e6e4c640039f850f91@mail.kernel.org>
In-Reply-To: <20260824083327.1708560-3-chenyuan_fl@163.com>
References: <20260824083327.1708560-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for queue/stack map size limit
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,andrii.nakryiko@gmail.com,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 09:25:05 +0000 (UTC)

--===============4496037626131391778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 41441325e179..efe808eedd9a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c

[ ... ]

> +static void test_queue_stack_map_alloc_check(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	const __u32 big_value = 1 << 20; /* 1MB */
> +	int fd;
> +
> +	/*
> +	 * Regression test for the u32 index overflow in queue/stack maps:
> +	 * a map whose element storage (max_entries * value_size) exceeds
> +	 * U32_MAX bytes must be rejected at creation time, otherwise the
> +	 * u32 head/tail index multiplication wraps and push/peek/pop
> +	 * address the wrong element. 8192 * 1MB = 8GB > U32_MAX.
> +	 */
> +	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, big_value, 8192, &opts);
> +	ASSERT_EQ(fd, -E2BIG, "queue_oversize");
> +
> +	/*
> +	 * max_entries == U32_MAX would make the u32 capacity counter
> +	 * qs->size (max_entries + 1) wrap to 0, permanently breaking the
> +	 * map, so it must be rejected as well.
> +	 */
> +	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, &opts);
> +	ASSERT_EQ(fd, -E2BIG, "queue_u32max");
> +
> +	fd = bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, big_value, 8192, &opts);
> +	ASSERT_EQ(fd, -E2BIG, "stack_oversize");

Should these three negative test cases close the fd if the map creation
unexpectedly succeeds?

On a kernel without the fix in patch 1/2, queue_stack_map_alloc_check
returns 0 for these attributes. The allocation then attempts an 8.59 GB
or 4 GB bpf_map_area_alloc in queue_stack_map_alloc. On a host with
enough memory, __vmalloc_node_range can succeed, returning fd >= 0
instead of -E2BIG.

When that happens, the assertion fails correctly, but the fd remains open
for the rest of test_progs, pinning roughly 20 GB of kernel memory across
all remaining tests. The positive test case below shows the pattern:

> +	/* A normal-sized map must still be created successfully. */
> +	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 64, 100, &opts);
> +	ASSERT_GE(fd, 0, "queue_normal");
> +	if (fd >= 0)
> +		close(fd);
> +}

Adding the same guard after each of the three ASSERT_EQ calls would bound
the damage to the failing subtest rather than OOMing the rest of the run.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32709296749
--===============4496037626131391778==--
