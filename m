Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E4391E55;
	Tue, 11 Aug 2026 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461053; cv=none; b=Z1RSIlf68mwwafkDZTQHfKMCnamDkTyXogWYxPC791bNOGjeQUGZhwHUVeFBbNWFwhDydAbFFPv60bamufPNIh5RFKTKoOaBQthSGO7gX0CAITPDpn6yNO+imaSnP9/bEcbEz+waoCyfyi110iMw1ACFPtU7zOno0RgZXmXpwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461053; c=relaxed/simple;
	bh=crpkQcUNkXzByGL6+JOZa8w9oarTBLi4J14FEGrITb8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jhfNrf3MIf9HgJ8TL6ecb9N7Crf750QbjRU9ZvQ0mnL4cM3ylw1tCdzbEVl8xAyDr9eevGSaTrukdOnYp0SLpJi0sBofNaM6o1mgIM+ClJNYzbbbdq3ZDJRE9nBuo+2I8PmTazLrn9rE6oIair/Y4RTojUaAo6/X6StdfpCQyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMWMaTOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMWMaTOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585081F000E9;
	Tue, 11 Aug 2026 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786461048;
	bh=T7kAUMq1YpLcRinv3yqvWpqWKL586rTrLR5XYOZuKac=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RMWMaTOmckUcM5HztokDhHKyaGCsuwQpKLn6+jSjx83gbe3/nsDK366t8I0lfLsOG
	 tyTv/UUclABG6MflR6tPfkUEZ545efmbV4yVhG15vof6TRJbAlOBITwoy1zlh5D+nX
	 EE4z1mCS2VnP5FveGb4ynhtmjloWN/fM5sv4nwol1SizXegFARkJQY9AEQfLSYo6Cu
	 Pxb51Z1W3B9XyiGwv4x6n2G1Di2CwTmo9LG2krd5d6P/O5gzx8nCjpKrMtR9eFMBxH
	 JJ4mTBqZHlPlYrf7v/Zu3nXwuR9EDSDGKtgehIONopM+ccrwx/Iu6hylQ/5x4k3IPU
	 jihh0Z2T5oavA==
Content-Type: multipart/mixed; boundary="===============7958507019542154891=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9cafe1dfeab0dfd1249f4881846a10c613e72a09124dadeff1b59765b664d512@mail.kernel.org>
In-Reply-To: <4dbdcda23b2f2be06c5659f8102cd6bd036825b3.1786448307.git.zirajs7@gmail.com>
References: <4dbdcda23b2f2be06c5659f8102cd6bd036825b3.1786448307.git.zirajs7@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Exercise negative optlen in cgroup getsockopt hook
From: bot+bpf-ci@kernel.org
To: zirajs7@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev
Cc: sdf@fomichev.me,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,rhkrqnwk98@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 15:10:47 +0000 (UTC)

--===============7958507019542154891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> index eaac83a7f388..6c96f2d9fccf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c

[ ... ]

> @@ -283,6 +284,27 @@ static struct sockopt_test {
>  		.error = EFAULT_GETSOCKOPT,
>  		.io_uring_support = true,
>  	},
> +	{
> +		.descr = "getsockopt: deny negative ctx->optlen in TCP_ZEROCOPY_RECEIVE",
> +		.insns = {
> +			/* ctx->optlen = -1 */
> +			BPF_MOV64_IMM(BPF_REG_0, -1),
> +			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
> +				    offsetof(struct bpf_sockopt, optlen)),
> +
> +			/* return 1 */
> +			BPF_MOV64_IMM(BPF_REG_0, 1),
> +			BPF_EXIT_INSN(),
> +		},
> +		.attach_type = BPF_CGROUP_GETSOCKOPT,
> +		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
> +
> +		.get_level = IPPROTO_TCP,
> +		.get_optname = TCP_ZEROCOPY_RECEIVE,
> +		.get_optlen = sizeof(struct tcp_zerocopy_receive),
> +
> +		.error = EFAULT_GETSOCKOPT,
> +	},
>  	{
>  		.descr = "getsockopt: ignore >PAGE_SIZE optlen",
>  		.insns = {

A subsystem pattern flags this as potentially concerning: the test asserts
-EFAULT for negative ctx->optlen, but both a fixed kernel and an unfixed
kernel can return -EFAULT, so does the test provide regression protection?

The commit message notes this honestly: "the return value alone cannot
distinguish the bug." The test exercises the kernel-buffer getsockopt path
with ctx->optlen == -1, which triggers a hardened-usercopy WARN on
unpatched kernels.

Tracing it through:

  run_test() creates socket(AF_INET, SOCK_STREAM, 0), state is TCP_CLOSE
  and tcp_inq(sk) == 0.

  do_tcp_getsockopt() accepts len (40) and calls tcp_zerocopy_receive().
  With inq == 0 < PAGE_SIZE and SOCK_DONE unset:

    zc->length = 0;
    zc->recv_skip_hint = inq;
    return 0;

  so err == 0 going into the BPF hook.

  Without the fix: ctx.optlen becomes -1, back in tcp.c, switch (len) with
  len == -1 falls to default: goto zerocopy_rcv_out. The if (!err &&
  copy_to_sockptr(optval, &zc, len)) runs with size (size_t)-1.
  check_copy_size() WARNs and returns false, copy_to_user() returns n != 0,
  so err = -EFAULT.

  With the fix: ctx.optlen < 0 returns -EFAULT directly, all the !err
  guards skip the copy, and -EFAULT is returned.

Userspace sees errno == EFAULT in both cases; run_test() returns 0 (PASS)
either way. The only difference between kernels is a WARN in dmesg, and
test_progs has no dmesg/taint/WARN detection (no references to dmesg,
kmsg, tainted, or panic_on_warn in test_progs.c/.h).

Strengthening it by making the handler fail first doesn't work either,
because __cgroup_bpf_run_filter_getsockopt_kern() does if (ret < 0) return
ret; before applying ctx.optlen, so a non-zero retval short-circuits the
buggy assignment. The buggy copy is only reachable when err == 0, and tcp.c
always converts it into EFAULT.

Is the intent that this test relies on WARN/taint detection or
panic_on_warn, or is the value of the test primarily as a WARN-only
reproducer rather than a pass/fail assertion?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31501873750
--===============7958507019542154891==--
