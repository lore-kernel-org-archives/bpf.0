Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E032B99D
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324728; cv=none; b=GndYsZkSt2NF6NfkKrYdnYKdNK0vc+TBgX8Vykw0pvbfi7k6/JwCxpei23k45Zda/IDpuEPKMC0xf9aQA1Yl96jfhAQxU8K3K4p3voUKAWf5ZvHRO9wKEcSmE5UJyM4ggEAzcxdbNeFKb20OSiU3tWnDElN4zMe6iBmC+WSJfCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324728; c=relaxed/simple;
	bh=px4dDlrAH/7tJE9Wj7pUGMff6OrgXnH27UoHJuQpZjI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Th5p3AzufaIlrKa7Re4+2j6aP4ImM5K5KAZo9p29WDpkbrfu0Q+4H73pcyfeijMWjshgJLuhG/PxZB0ALOANMmIvWbmlvycMbDRtf0aGI032+Q06/5MnjSteZNRFco2p/JU5n5O0xwfkovHd3RsZRzF65t9OTSSlLIMCKQfc81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjgKtNKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjgKtNKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FE6C4CEF7;
	Thu,  5 Feb 2026 20:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770324727;
	bh=px4dDlrAH/7tJE9Wj7pUGMff6OrgXnH27UoHJuQpZjI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PjgKtNKvHgM/Tr422foNEFozlnpkIjKqgctxVBkOzDO1xxugvcfjfGK2nmsNzFVFe
	 Dfk2SJ/bpZOPxNCeB2y61EM2eEZIb1J44yLWFazw1dnINxMmD9zJPkqgSPds8vQGHZ
	 ee0tGoJYgZ7TDl8reio+0whCPJ4q/cIM4aNZlBsZ0/CJKI92tsgPK3ccaleeqcLBES
	 4+rTMx7ebIiwfSSIoYuuSvhKOYSHLrMhJL1BMIYYYR9tOteiep0xRoDTDPiZDRT9er
	 qwP2RW8sDYfje4u0ZSQXgSk46uF+Kq4wEI2n0ZuKVGIFe9FoufisjJ+MxD1jUDFww/
	 6gkwzI/WQxH0w==
Content-Type: multipart/mixed; boundary="===============6741272703562814215=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f87fb2776cfa761ea1eb0e2133ca47e33f5778835b28d507439f2d99010f61c@mail.kernel.org>
In-Reply-To: <20260205-rhash-v1-10-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-10-30dd6d63c462@meta.com>
Subject: Re: [PATCH RFC bpf-next 10/12] selftests/bpf: Add BPF iterator tests for resizable hash map
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,ameryhung@gmail.com,memxor@gmail.com,puranjay@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Feb 2026 20:52:07 +0000 (UTC)

--===============6741272703562814215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
> index 689ba6d73..ee8f4181d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/rhash.c
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash.c

[ ... ]

> +static void rhash_iter_overflow_test(void)
> +{

[ ... ]

> +	/* Populate map with test data */
> +	for (i = 0; i < num_elems; i++) {
> +		__u64 val = i;
> +
> +		err = bpf_map_update_elem(map_fd, &i, &val, BPF_NOEXIST);
> +		if (!ASSERT_OK(err, "map_update"))
> +			goto out;
> +	}

[ ... ]

> +	/* Read all data - this should trigger multiple overflows/restarts */
> +	total_read_len = 0;
> +	while ((len = read(iter_fd, buf + total_read_len, expected_read_len - total_read_len)) > 0)
> +		total_read_len += len;
> +
> +	ASSERT_OK(err, "err");
            ^^^

Should this be checking len instead of err? The err variable was last set
during the map population loop above and isn't updated by the read loop.
At this point err is always 0 if we got here successfully, so this assertion
provides no validation of the read operations.

> +	ASSERT_EQ(total_read_len, expected_read_len, "total_read_len");

[ ... ]

> +	for (i = 0; i < num_elems; i++) {
> +		__u64 *val = ((__u64 *)buf) + i * skel->bss->print_count;
> +
> +		ASSERT_GE(val[0], 0, "value_greater_or_eq_zero");
                        ^^^

This isn't a bug, but val[0] is __u64 (unsigned), so this comparison with 0
is always true. The assertion provides no validation.

> +		ASSERT_LT(val[0], num_elems, "value_in_range");

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c
> new file mode 100644
> index 000000000..2de69f983
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c

[ ... ]

> +SEC("iter/bpf_map_elem")
> +int dump_bpf_rhash_map_overflow(struct bpf_iter__bpf_map_elem *ctx)
> +{
> +	struct seq_file *seq = ctx->meta->seq;
> +	__u32 *key = ctx->key;
> +	__u64 *val = ctx->value;

[ ... ]

> +	/* Validate key value are as expected */
> +	if (*key != *val || *key < 0 || *key > 64) {
                          ^^^^^^^^^^

This isn't a bug, but *key is __u32 (unsigned), so *key < 0 is always false.

> +		err = 1;
> +		return 0;
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21727734472

AI-authorship-score: low
AI-authorship-explanation: The code follows standard BPF selftest patterns with appropriate test structure and naming conventions typical of human-authored kernel tests.
issues-found: 3
issue-severity-score: low
issue-severity-explanation: All issues are minor code quality concerns in test code: a stale variable assertion and unsigned comparisons with zero that are always true/false.

--===============6741272703562814215==--
