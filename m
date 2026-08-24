Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C93AFB19;
	Mon, 24 Aug 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565808; cv=none; b=WdbKhu2TRojfk3B4fzScKLS3MePGT41LQoFSAHNflHE2YefxeBUmZN2Igi9lnNGyolByPiL2d4B6ArOtXgxFH7K2T77k6L2nBJJWEawhQp3BFkGkN4G4rIDDziOeFhtI10oM3uT70wbwIRt6BfXXeNAXEghNVPpdwuSStQySTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565808; c=relaxed/simple;
	bh=KZBW1f7BV+BgImk8FmmvdnTcElmwmbPIdlVqJjqAAgs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qW4/69NonL47h6qqS3pD8G3gLsqnL5+F2JLezaYpwHfeEzaJMR611BNmM2HszBEpcNNb3e/MQ5zksgPTYrIe4aqa27zYqezgz6nCsk5YhVDD8m5ImDuN4XeZsYa8EXNSCFW+XbZH1IpQ8+bPH9f3uXxCtXXAh9WFGbkW+q0kfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQh67uHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQh67uHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC391F00A3A;
	Mon, 24 Aug 2026 10:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565807;
	bh=lgamHOuW3jOsWMwnYC6D7Z/XTfRHTgArdCSgAkxBt4Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YQh67uHtwDL3Of3EH1Q6ybRdNCyUi2oLmgVOMDUnbMRF8mMm2Y0y+xymSUPv1GWPk
	 3sJkyXXI7uHlNgKCXxPnLVLG4phoXQxbNneRux3zQ8VA6/OjXCeJRPrjIv7YwfV8gs
	 2bLR23/IqF7io9lLthHcEQQE1UGVcBoe7D94Ca65EQWVwsjT2OxKXMDkiJpI/5Nn2m
	 HpRIYE39uNQrax/PQwUMyeuXBqbGiPPuvjXCdMEHjnNwo+0ZFzgt4xENTg5Rl1/HIS
	 FcdvRPIqSE/obi9WaErB6GHztoM0/Zt/JqGuXapabU6Bohx3NK2mxi8fUXntV7yvVw
	 dyQJSj1mH9MBw==
Content-Type: multipart/mixed; boundary="===============2351152834968410006=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <796b7f30046de601f05035d9705806b2cc098cb37b81c957797bee18022586be@mail.kernel.org>
In-Reply-To: <20260824092847.361683-2-jiayuan.chen@linux.dev>
References: <20260824092847.361683-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for usdt probe with page-crossing nop10
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,peterz@infradead.org,jakub@cloudflare.com,phoenix500526@163.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 10:03:26 +0000 (UTC)

--===============2351152834968410006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index 8004c9568ffa..eff1e57ab13c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c

[ ... ]

> @@ -342,6 +343,57 @@ static void subtest_optimized_attach(void)
>  	test_usdt__destroy(skel);
>  }
>
> +/*
> + * Test attachment to a USDT probe whose nop10 crosses a page boundary.
> + * The kernel can't optimize such nop10, so libbpf keeps the uprobe on
> + * the preceding 1-byte nop. Do not assume any particular placement
> + * here, though: however the probe ends up attached, the attachment
> + * must succeed and the probe must fire.
> + */
> +static void subtest_optimized_attach_cross_page(void)
> +{
> +	long page_sz = sysconf(_SC_PAGESIZE);
> +	struct test_usdt *skel;
> +	__u8 *addr = NULL;
> +	long i;
> +
> +	/* combo is placed up to a page of padding after the function start */
> +	for (i = 0; i < 2 * page_sz; i++) {

This isn't a bug, but should the comment say up to two pages to match the
2 * page_sz scan bound? With the .balign 4096 fill plus the 4086-byte
.skip in usdt_2_cross_page(), the combo can land roughly 8150 bytes past
the function start when the compiler emits a prologue.

> +		if (!memcmp((void *)usdt_2_cross_page + i, nop1_nop10_combo, 11)) {

This isn't a bug, but could find_instr() take a search range so this
subtest reuses it rather than open-coding the same memcmp scan?
find_instr() already implements this loop a hundred lines above, only
with a hardcoded 10-byte window instead of 2 * page_sz.

> +			addr = (void *)usdt_2_cross_page + i;
> +			break;
> +		}
> +	}
> +	if (!ASSERT_OK_PTR(addr, "find_nop1_nop10_combo"))
> +		return;
> +
> +	/* layout sanity check: the nop10 must cross the page boundary */
> +	if (!ASSERT_GT((unsigned long)(addr + 1) % page_sz + 10, page_sz,
> +		       "nop10_crosses_page"))
> +		return;
> +
> +	skel = test_usdt__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_usdt__open_and_load"))
> +		return;
> +
> +	skel->bss->my_pid = getpid();
> +
> +	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0,
> +						     0 /*self*/, "/proc/self/exe",
> +						     "optimized_attach",
> +						     "usdt_2_cross_page", NULL);
> +	if (!ASSERT_OK_PTR(skel->links.usdt0, "bpf_program__attach_usdt"))
> +		goto cleanup;
> +
> +	usdt_2_cross_page();
> +	usdt_2_cross_page();
> +
> +	ASSERT_EQ(skel->bss->usdt0_called, 2, "usdt0_called");
> +
> +cleanup:
> +	test_usdt__destroy(skel);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32712703327
--===============2351152834968410006==--
