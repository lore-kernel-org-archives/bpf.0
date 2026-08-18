Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688147044F;
	Tue, 18 Aug 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058000; cv=none; b=qBvY1Noam5dbJd1BAjDWbHCMjkKkplb8/hLcCp6hfLyhRkjAXZFrdwlDycCLTEfG93cQTT/0FBrwU7wzNNGD6fZzNg8/t3ls2mbWiMUMy8vhTR/a8333BhMy65r7Gx+2rDw/MgImSTVxBtGvV3YsOZaZzfnWKh34T5Rtrp+6Y24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058000; c=relaxed/simple;
	bh=ainfky/nXWXMEKKkASpc7zggthDEO5PsEwUhhUOa4CU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IJslteIZHKuInca+E4b6bESOT7eYf2SwMPSgG/M04pH5K0Uosgqz1Fud+skN9JK0RQbIrwrtva5STyeAofr0rBgkGAAhA4UHmXcRV/2DG58iF8XcZjzaozB3ZRz6+VkV1WjrjKDOievfaBCjzEd2DBmv1RAj4UT584FFrmKO85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu9TI8TA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu9TI8TA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3F61F000E9;
	Tue, 18 Aug 2026 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787057999;
	bh=gCuSerjHTeCuhpJaCUmSScfIw5P3L4pGuGNcnsfCf7E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Bu9TI8TARf6XwhdWg0BgSq50oJpvPbgGk8/opEDh1c10V5MAFnA0JskPxxah0RJAW
	 ictF0AZjAI4t6CZYPnXIm0EiYPMC4EFou9JdK9Kz44R4aOSXd2WWUjQi2ibpOd5mfU
	 TGR/oIBJnyYuTScE4LLVKczsAJS7DctdWgSTU/LUpcsJBUTjAyiVDrQ/Bto+G49d4s
	 Ie4Y/ceLwAaw6LDw83w+ecBuwz0mgKMBXO7nmtHAe9ytb8FYh3bxauHS8FHnBzOC4P
	 PGqkTQU/ByAQdHQlDvcCNmeDkIZMA2Vwza+T+J96gtsb/OJu40wg+r5JE6xf6sKch0
	 kZMm/aP0MzUSg==
Content-Type: multipart/mixed; boundary="===============1927340589354686263=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <03cb49be5020c80050635edeccd5f6703fcaff08d3171e520de7014c9d6f1575@mail.kernel.org>
In-Reply-To: <20260818120308.623905-1-nhudson@akamai.com>
References: <20260818120308.623905-1-nhudson@akamai.com>
Subject: Re: [PATCH] selftests/bpf: tc_tunnel - validate decap tunnel state without false-pass gaps
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: nhudson@akamai.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 12:59:58 +0000 (UTC)

--===============1927340589354686263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> This follow-up tightens the selftest to guard against false passes in
> GSO decap validation.
>
> It validates the expected post-decap state for both GSO and non-GSO
> packets: expected tunnel gso_type bits must be cleared and
> skb->encapsulation must match the remaining tunnel state.

Does this paragraph accurately describe what the patch adds?

The gso_type and skb->encapsulation validation it mentions already exists
in the base revision. Comparing HEAD^ with HEAD for
progs/test_tc_tunnel.c shows the added lines are only the four .bss
globals and three counter increments. The checks described appear only
as context lines:

  if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
      (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
          return TC_ACT_SHOT;
  ...
  if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
               BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
          if ((shinfo->gso_type & SKB_GSO_TUNNEL_MASK) &&
              !kskb->encapsulation)
                  return TC_ACT_SHOT;

All of this validation is pre-existing. The series is a single commit
(530113d..1dc5f339), so this code is already upstream before this patch.

> It also adds explicit assertions that the decap validation path was
> executed, including the large-send phase for GSO-marked subtests, and
> asserts that the large-send marker is reset after the send.

The large-send marker reset assertion mentioned here checks a variable
that only userspace writes. decap_expect_large_send is read-only in the
BPF program, and send_and_test_data() sets it to 0 on both the success
path and the `end:` path before returning. Can that assertion ever fail?

Also, the commit message doesn't mention the 'ethtool -K veth1 tso off'
change in setup() even though it alters what traffic the test generates.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> index 67ba27d69347..08d7d90f7772 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c

[ ... ]

> @@ -374,10 +378,15 @@ static int configure_ebpf_decapsulation(struct subtest_cfg *cfg)
>  	return ret;
>  }
>
> -static void run_test(struct subtest_cfg *cfg)
> +static void run_test(struct subtest_cfg *cfg, struct test_tc_tunnel *skel)
>  {
>  	struct nstoken *nstoken;
>
> +	skel->bss->decap_validation_seen = 0;
> +	skel->bss->decap_gso_validation_seen = 0;
> +	skel->bss->decap_large_send_validation_seen = 0;
> +	skel->bss->decap_expect_large_send = 0;
> +
>  	if (!ASSERT_OK(run_server(cfg), "run server"))
>  		return;
>
> @@ -406,7 +415,18 @@ static void run_test(struct subtest_cfg *cfg)
>  	/* Replace kernel decapsulation with BPF decapsulation, test must pass */
>  	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decapsulation"))
>  		goto fail;
> -	ASSERT_OK(send_and_test_data(cfg), "connect with encap and decap progs");
> +	if (!ASSERT_OK(send_and_test_data(cfg, skel), "connect with encap and decap progs"))
> +		goto fail;
> +	if (!ASSERT_NEQ(skel->bss->decap_validation_seen, 0,
> +			"decap validation executed"))
> +		goto fail;
> +	if (!ASSERT_EQ(skel->bss->decap_expect_large_send, 0,
> +		       "decap large-send marker reset"))
> +		goto fail;
> +	if (cfg->test_gso) {
> +		ASSERT_NEQ(skel->bss->decap_large_send_validation_seen, 0,
> +			   "decap validation executed for large send");
> +	}

Is the decap_expect_large_send assertion meaningful here?

decap_expect_large_send is written only by user space; the BPF program
only reads it. send_and_test_data() clears it on every exit path:

  skel->bss->decap_expect_large_send = 0;   /* line 236, success */

  res = 0;
  end:
  skel->bss->decap_expect_large_send = 0;   /* line 240, all paths */

Every return from send_and_test_data() passes through the `end:` label,
so by the time run_test() reads the value it is unconditionally 0.

A broken kernel, a broken BPF program and a correct one all produce the
same result. Can this check ever fail?

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> index 853bca962910..e9bd1c9781f7 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c

[ ... ]

This looks like a bug fix for false-pass gaps in the selftest. Should
this include:

  Fixes: adb771973026 ("selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32136539422
--===============1927340589354686263==--
