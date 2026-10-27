Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121026;
	b=TzWnlC4dSGLBL/4F9O3GqpD3YXtXPVwjej54xlW+cdQ8txk0/WU7vokmiEuY8SQxPxSl
	 ACAUsi6E5j4ipHotP8Zu/jzK8enfr6OdJucee8ICeRGm6EkU1/0OHxZC75RDRP2r7J8p6
	 BVATJsUnE655ckOOxzkBZejdqpGE7rLmAysjgGsuZZeAs14rIBTDJ1tmIieqHDHhzIEfm
	 1YrlUhmUfUdQ/d+FKK6u8tRi9nnZrwIdOUNTt3UQnQOBvxyhcRQxjevYCBj8fjhCMQltB
	 i0As3MzxNqoGtX312wvsOhwgBbz3UiRfizeVHEBbrNB97zpG80HJ4BX3Pd2fxKozVrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121026;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=HAY1ws8zTnzFw579N5oFIkhkRPB0qvi0ssFavqqbrL4=;
	b=oYuwBd+12xqRM4/rXQPRx3PUYf1IhQi1+dTni8Zy8hRSuipG/rQsATWUhg8jQNdSZ1du
	 yLnDKWqIgS9OwE/0s+RlADAz4qCRTpjiApVTnmx0W7PpkrR/yWJpE2mFSgxCzjB3dTyNR
	 NqqxwwQUOjcWBNxoBN7MbZI8D4qmmdsad2kssQl1trqxttSMX9xiCMbwQeNzT7shWiac3
	 l0BJU8QJR5hmqpKLgCQgEUQk8tLTgOaTbgo9RkEDZH/us49KoY16dmxht4OWbigcDRHi/
	 0IViCvfOd+K7P7zOhEYfZvcKMsUIUQOfRt93DB8D9PnwRUHN1i6U8USLM2aDq0SmStQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8ncEj62;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086F606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8ncEj62
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3DF1F031E3;
	Tue, 27 Oct 2026 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793121025;
	bh=HAY1ws8zTnzFw579N5oFIkhkRPB0qvi0ssFavqqbrL4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=L8ncEj62oJirox1yJ3a0jS5AjDNkikJkUAYreA2tRa6ypZWCfoUloi+lfDZl7dWcl
	 GylftWOyUb6X2/X7o9ZSN1ywrVS2mH6F2WaXi//RAP8kvVz+Yh168qCtojRfUmMqyC
	 AkDTOML6nStlwQQiWPq226TM22568wrlCPLKc3ajqIIo56vS8dD0Xl51uJSBcmjaVc
	 guD0XN6KaP8jy0tOLAHzJdP92ajzYmgXC6GJzVhewahxenhxLPa+Ypf2NxNLd0vgfE
	 8LmWDyFta9C1aXbaB0GwvWkuLIAdOuBbK5oVKHRECCh8P5EYl4n6MkJN+i4yk+CqEM
	 oYh12Au2BfSlA==
Content-Type: multipart/mixed; boundary="===============2182307373397005891=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <52f81bc4914e11fd18610958e39d4847e675c23115ceaeef11eb84913fa4f1af@mail.kernel.org>
In-Reply-To: <20261027162820.10887-6-emil@etsalapatis.com>
References: <20261027162820.10887-6-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: Test local IRQ kfunc inlining
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 17:10:25 +0000 (UTC)

--===============2182307373397005891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test local IRQ kfunc inlining

TL;DR: Test issue in irq_jit.c: ASSERT_FAIL() in the "unexpected IRQ
operation" branch appears never to fail the test, so that guard is
ineffective; PRINT_FAIL() may be intended.

> diff --git a/tools/testing/selftests/bpf/prog_tests/irq_jit.c b/tools/testing/selftests/bpf/prog_tests/irq_jit.c
> new file mode 100644
> index 000000000000..3d5dc3c77edb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/irq_jit.c
> @@ -0,0 +1,128 @@

[ ... ]

> +static void check_irq_insns(int prog_fd, bool expect_inline)
> +{

[ ... ]

> +	for (size_t insn_idx = 0; insn_idx < info.xlated_prog_len / sizeof(*insns); insn_idx++) {
> +		struct bpf_insn *insn = &insns[insn_idx];
> +
> +		if (insn->code != (BPF_ST | 0xe0))
> +			continue;
> +		ASSERT_EQ((__u32)insn->dst_reg, BPF_REG_1, "flags_reg");
> +		ASSERT_EQ((__u32)insn->src_reg, 0, "reserved_src_reg");
> +		ASSERT_EQ(insn->off, 0, "reserved_off");
> +		if (insn->imm == 0)
> +			save_count++;
> +		else if (insn->imm == 1)
> +			restore_count++;
> +		else
> +			ASSERT_FAIL("unexpected IRQ operation %d", insn->imm);
> +	}
> +	ASSERT_EQ(save_count, expect_inline ? 2 : 0, "save_count");
> +	ASSERT_EQ(restore_count, expect_inline ? 2 : 0, "restore_count");

A subsystem pattern flags this as potentially concerning: ASSERT_FAIL() as
the only thing that marks a failure.

In test_progs.h, ASSERT_FAIL() expands to CHECK(false, "", fmt"\n", ##args).
Since the condition is false, _CHECK() takes its pass branch, so test__fail()
is not called and the format string is not printed.

If the else branch is reached for an unexpected imm value, neither
save_count nor restore_count is touched.  An unknown operation sitting
next to two valid saves and two valid restores would still satisfy the
ASSERT_EQ(save_count, ...) and ASSERT_EQ(restore_count, ...) checks
above.

Can the "unexpected IRQ operation" check ever fail the test as written?
Would PRINT_FAIL(), which calls test__fail() unconditionally, be the
intended macro here?

For context, the kernel currently emits only imm 0 or 1 for these
instructions, so this branch only matters as a guard against a future
encoding change.  That guard is what does not work today.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40544258296
--===============2182307373397005891==--
