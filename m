Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505829;
	b=N33y2PvUVvcmg8JFJ34/aYEd5PBnKI5fJp8pXm5+E2TPBIO5A7ekYrPGcObs1ytRFYZ8
	 bbAjoEmieHqPc88mZu5ALGO69XDzhjD4YgRRJsJMIJ5wN72Ul7onzJcoECbi2l4w7sukh
	 oNWThLCvjX+to4UDc9ttDWSrxIqtQn6hxs6mg4TK2bqark4C/X63ffFEnLsnZSImDtaVc
	 S96UT23CAp06P/8tLfcR3QGxjLz2DZD6EFTT5XqmWHF/o5v9GmFB1xsHAt/TB3Dv/I//G
	 /yrujP+ifAEVxTrl/VUjlrQEj+m9KoYAoYCEF4X8fF5hKwvIVaZ1LWzArGd3SMl1/kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505829;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=/bwahVLN0DEkxTRBZ/QYg4lSD68f7g2itJ3lu6Z/yU8=;
	b=Uieuo8QxNUNLlOjcM5J4t+rrjq6jRtXBEiPHYt91xBLZfMd2lVKZA5RtDz3I9ZEJebXF
	 hOayta9O/u5McGJwiSNni2FKv1tiNfgu14Mj2OSCu+KZ5m4MUe76rWDaeBYe6qi/6oiOp
	 88IFfoxKMyza6yYNv1aQ4OEAQlpJzPxzhHJ8HcVZr2srpzONfUh6qc6mBlowfnlqEmamR
	 i68sh2mdACku22KqrHQJQkR5UwTPvwy3MhkelM5v/5uKs5SKHK3W86/Fyd68LEQaC+AlI
	 JPOpXNDnXwfvnhwN9qXJKVRcYICIOqsvQTYp111YA9t3qbjD5eLvmQfvYezV6/Jn3WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwqYtWbc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48D606AA2C;
	Tue, 20 Oct 2026 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwqYtWbc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7AF1F000C4;
	Tue, 20 Oct 2026 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505829;
	bh=/bwahVLN0DEkxTRBZ/QYg4lSD68f7g2itJ3lu6Z/yU8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XwqYtWbc09MHfYsfV1HGcppcIfI4RZtsJqSYpLJuvClv7mEF1wEe0CcrtCOrZUB5j
	 zL+np52ZBqJAnOgGEx0+vI3RE6qm0/6DRiKcaYCEkcE64mYksv1rkWt8CI6j9sDA4l
	 eUZdPUlBCC7Iwuz6UJm5tCUj338HeHAmfI2uz5A6FtqEOr+XBhP0SFOvJDWkaWgHJr
	 XMECc2rlIXNtO6SFrGnipFNO47rDXbTZ2tSAcT3fAqxPeK7R7+qz8BED2jlGjf1TbG
	 X7aBupPdaLyyrsFDG/YiGs56vdwr4XSo5mhi8nxX4yp9gZzT2zvYGjAW9PqgRs5jcT
	 ggVPYzxoF0lUg==
Content-Type: multipart/mixed; boundary="===============5182827459711567144=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <45632128dde3ab61514bf0db311766b2113e01b63bdbd37c04f4a8b2de6c985c@mail.kernel.org>
In-Reply-To: <ad35a4e7b9ff044a63d7903ae6509c68ea05d6d5.1792503001.git.xukuohai@huawei.com>
References: <ad35a4e7b9ff044a63d7903ae6509c68ea05d6d5.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 16/16] selftests/bpf: Add test for arena percpu bounds
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:08 +0000 (UTC)

--===============5182827459711567144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add test for arena percpu bounds

TL;DR: Nits only in the arena percpu bounds selftest: a redundant insns[2].off
= 0 assignment, and the repeated bpf_prog_load and log-check code could share
a helper.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
> --- a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c

[ ... ]

> +/* check out of range pseudo instructions and accesses */
> +static void test_arena_percpu_percpu_bounds(void)
> +{

[ ... ]

> +	/* a reference at the start of the chunk loads */
> +	insns[1].imm = page_sz;
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
> +				"arena_percpu_ref", "GPL", insns,
> +				ARRAY_SIZE(insns), &prog_opts);
> +	if (!ASSERT_GE(prog_fd, 0, "in_range_load"))
> +		goto out;
> +	close(prog_fd);
> +
> +	/* the first u64 below the chunk and one past its end are rejected */
> +	bad_offs[0] = page_sz - 8;
> +	bad_offs[1] = page_sz + page_sz;
> +
> +	for (i = 0; i < ARRAY_SIZE(bad_offs); i++) {
> +		insns[1].imm = bad_offs[i];
> +		prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
> +					"arena_percpu_ref", "GPL", insns,
> +					ARRAY_SIZE(insns), &prog_opts);
> +		if (!ASSERT_LT(prog_fd, 0, "out_of_range_load"))
> +			close(prog_fd);
> +		snprintf(expected, sizeof(expected),
> +			 "per-cpu arena reference at offset %u "
> +			 "outside cpu 0's chunk", bad_offs[i]);
> +		ASSERT_HAS_SUBSTR(log_buf, expected, "out_of_range_log");
> +	}
> +
> +	/* the last u64 of the chunk is in range and loads */
> +	insns[1].imm = page_sz + page_sz - 8;
> +	insns[2].off = 0;

This isn't a bug, but is this insns[2].off = 0 assignment needed?  The field
is still 0 from the initializer at this point.

> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
> +				"arena_percpu_ref", "GPL", insns,
> +				ARRAY_SIZE(insns), &prog_opts);
> +	if (!ASSERT_GE(prog_fd, 0, "last_u64_load"))
> +		goto out;
> +	close(prog_fd);
> +
> +	/* one u64 past the chunk end is rejected */
> +	insns[2].off = 8;
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
> +				"arena_percpu_ref", "GPL", insns,
> +				ARRAY_SIZE(insns), &prog_opts);
> +	if (!ASSERT_LT(prog_fd, 0, "out_of_range_access"))
> +		close(prog_fd);
> +	snprintf(expected, sizeof(expected),
> +		 "per-cpu arena access at offset %d size 8 "
> +		 "outside cpu 0's chunk", (int)page_sz);
> +	ASSERT_HAS_SUBSTR(log_buf, expected, "out_of_range_access_log");
> +
> +	/* an access below the chunk start is rejected */
> +	insns[1].imm = page_sz;
> +	insns[2].off = -8;
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
> +				"arena_percpu_ref", "GPL", insns,
> +				ARRAY_SIZE(insns), &prog_opts);
> +	if (!ASSERT_LT(prog_fd, 0, "below_chunk_access"))
> +		close(prog_fd);
> +	snprintf(expected, sizeof(expected),
> +		 "per-cpu arena access at offset -8 size 8 "
> +		 "outside cpu 0's chunk");
> +	ASSERT_HAS_SUBSTR(log_buf, expected, "below_chunk_access_log");

This isn't a bug, but could the five identical bpf_prog_load() calls and the
repeated reject/log checks share a small helper?

Only insns[1].imm and insns[2].off differ between the cases, and the
ASSERT_LT + close, snprintf into expected, ASSERT_HAS_SUBSTR sequence is
repeated three times.

A helper taking the reference offset and the access offset, and returning
the prog fd or checking the expected log, would make each case a single
line, like run_on_cpu() and check_percpu_value() do elsewhere in this file.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============5182827459711567144==--
