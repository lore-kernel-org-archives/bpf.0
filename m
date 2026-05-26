Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D130F803;
	Tue, 26 May 2026 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832000; cv=none; b=JUNV/ae/hMdWTtfLcG1MgZc+Kw1Zmkmat1U1BEnp8VhCkuOXa9vPtlKHj5YVLzG/KP2hDwY7Hohp0LZ+DenTI7UhF9vJXvaTdS9ToTNBWvxc9YIS1zHYMLal1QUDguwyMtNmLMBh7+oM5ssl3fQ86Mj43SXn6AbI1zhAHHxSzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832000; c=relaxed/simple;
	bh=BXL7pmHy1PXC470JXQsiFkKLlRWVBM7NAHjFNtz0oYk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uC3k2hKQTG7+3NRGg92/B3VgKXTTq/U6BVkuwbI37t2QtObABashdWyQQ7tDwBwW2iK6E6CFU13u19bL9UGlKf8WIftdjeteo7P1yP0GVb07bBo05sMr8yYO772s+q/PvbnUVIso/1cNBfsT+XeZbF8bWogf/zh3UFry+222Ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkpAjNCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkpAjNCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C274D1F00A3A;
	Tue, 26 May 2026 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779831999;
	bh=DgVofG/E1bGdqPxRoLV4BqrzwDDD9Fl6r+39kA8z/Rw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DkpAjNCMw/InI4vI7bbuMJQG3r/7acLBn8X6dGE+RiMLTUeSMNnJ1DEjbMNCXYznB
	 LthnhxGZwxS0Fr3X+g0UV7oJnX4wi/Qb8C0xh7uT7WMNd34ForX4cNNipg3VsO4FkM
	 iW5q/dkOFda5DtUmIf7YtfQjsXvsFmwyFDW460UOsvl6dhoHqSSJYm8yEvvRCUFiv7
	 JfReEEHix6aQBdxuUyMiXoNFlcINPyHvWmf12HNJynXdGldQcIaIp/Hvk+aDEwEe0R
	 GYyIsVKDJGvfmkhPxt6J9vvBBhQDEEC5ZniU3XKbwK0UbrisD1dTtlx/hk0fIc9rmp
	 LImDl87OzhEfg==
Content-Type: multipart/mixed; boundary="===============5300361452356741764=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3bec8cfe67b2e52b7316d77f6907373a99ee0443a27c15ad26b90d6c5539ecdf@mail.kernel.org>
In-Reply-To: <20260526205840.173790-10-jolsa@kernel.org>
References: <20260526205840.173790-10-jolsa@kernel.org>
Subject: Re: [PATCHv4 09/13] selftests/bpf: Change uprobe syscall tests to use nop10
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 21:46:38 +0000 (UTC)

--===============5300361452356741764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index c944136252c6..0868fb9793e0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c

[ ... ]

> @@ -388,14 +388,15 @@ static int find_uprobes_trampoline(void *tramp_addr)
>  	return ret;
>  }
>
> -static unsigned char nop5[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
> +static unsigned char nop10[10]  = { 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
> +static unsigned char lea_rsp[5] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
>
> -static void *find_nop5(void *fn)
> +static void *find_nop10(void *fn)
>  {
>  	int i;
>
> -	for (i = 0; i < 10; i++) {
> -		if (!memcmp(nop5, fn + i, 5))
> +	for (i = 0; i < 128; i++) {
> +		if (!memcmp(nop10, fn + i, 10))
>  			return fn + i;
>  	}
>  	return NULL;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index 69759b27794d..fda3a298ccfc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -252,7 +252,7 @@ extern void usdt_1(void);
>  extern void usdt_2(void);
>
>  static unsigned char nop1[1] = { 0x90 };
> -static unsigned char nop1_nop5_combo[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
> +static unsigned char nop1_nop10_combo[11] = { 0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
>
>  static void *find_instr(void *fn, unsigned char *instr, size_t cnt)
>  {

Is the loop in find_instr() adequate to find the updated instruction
sequence? In uprobe_syscall.c, find_nop10() was updated to search up
to 128 bytes to account for compiler-generated prologues:

tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c:find_nop10() {
	for (i = 0; i < 128; i++) {
		if (!memcmp(nop10, fn + i, 10))
			return fn + i;
	}
}

But find_instr() in usdt.c only searches the first 10 bytes:

tools/testing/selftests/bpf/prog_tests/usdt.c:find_instr() {
	for (i = 0; i < 10; i++) {
		if (!memcmp(instr, fn + i, cnt))
			return fn + i;
	}
}

If a modern compiler generates a prologue longer than 9 bytes for
usdt_2(), find_instr() will prematurely terminate and cause
subtest_optimized_attach() to fail. This concern was raised by
reviewers in v2 and v3 of the patch series:

  https://lore.kernel.org/bpf/20260518111604.CC731C2BCB7@smtp.kernel.org/

The author acknowledged this with "yea find_instr needs same update,
will fix" but the loop bound remains 10 in the current v4 patch.

> @@ -271,17 +271,17 @@ static void subtest_optimized_attach(void)
>  	__u8 *addr_1, *addr_2;
>
>  	/* usdt_1 USDT probe has single nop instruction */
> -	addr_1 = find_instr(usdt_1, nop1_nop5_combo, 6);
> -	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
> +	addr_1 = find_instr(usdt_1, nop1_nop10_combo, 11);
> +	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop10_combo"))
>  		return;
>
>  	addr_1 = find_instr(usdt_1, nop1, 1);
>  	if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
>  		return;
>
> -	/* usdt_2 USDT probe has nop,nop5 instructions combo */
> -	addr_2 = find_instr(usdt_2, nop1_nop5_combo, 6);
> -	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
> +	/* usdt_2 USDT probe has nop,nop10 instructions combo */
> +	addr_2 = find_instr(usdt_2, nop1_nop10_combo, 11);
> +	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop10_combo"))
>  		return;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26475828601
--===============5300361452356741764==--
