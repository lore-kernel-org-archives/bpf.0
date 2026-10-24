Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792825528;
	b=USv6k8/JDkKBhkDicoWJEpmEDeuBeFXyLHGcpvkEbqpfRyGlUkiy81mnroMFuq+vgJcj
	 CumBiwe9LFvwUtWkl2LusH60wtLKgswD8dwVV9Liheiwu/Fx1Og7EX7U/Q4EyhuG5Ipeq
	 O7bHTx/jsvFohmnnRAtgDO1hjREWNBylQxOgt5IiUq1hOES57bti6jss1LVTKCx6/O+Dw
	 IoIzdfxtlLj4FkdfetIfOTnQzNsQ29jaEyiSJSPJSm+fdZA/hm655U9jxXnYaRC48TKlM
	 VYauXHb4OQQK5l+AJcW2cXHtP6sQA8Xe59cyJ5cqI1pV+Ap7bVKFdiNHnh+Sjm82doQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792825528;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=rAuzurPfsLQhSEiLbgaU/pfbgL67ZN11Nrab8/1fyE8=;
	b=QoRJr7UyZE8mxACpwr8hPEv1maDdXFR7fCkYQ3YaG6sjrTTGic73rvpe4H60ZSE+EtDe
	 Zk8tIfyHxI98YjRRMW4iDe63Yu2htK2w3cA7cvC/4749twr4HfoQK2UOy5frmMMOxy03i
	 FHJbprrIgKu/qIVKlmiiIwYQDp5eLhkvp9EvMei51/wofuvtj+sZq59e94PAoIW0HORYa
	 gYPEERlGq64fZdODdG7GMExuax1kOLwutJt+UJX9nPqfpQFzVm0+84KrcqhJZnluEOLpY
	 aCNbD7SeBFQb9tL4Zpzxm6sl2aIMjcUOq2DKJ4sIK4igOr+49nv63NgRPadF3rBn5UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbR7RRDy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDD606A31A;
	Sat, 24 Oct 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbR7RRDy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637B61F01825;
	Sat, 24 Oct 2026 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792825527;
	bh=rAuzurPfsLQhSEiLbgaU/pfbgL67ZN11Nrab8/1fyE8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TbR7RRDyKk7k20qZjfNpSBmbfuECJu/WQfwP2rVMhAoTTHCsnaQyaNGie8bCVqgtH
	 DIkrKoG3DwOIQBfRuLcMFtBEBQ61RJkcmcGhnzKtp+2Qt01XORo0sp9aqXBqLrxSph
	 tiajVXiLwzrToRWyWWaWyDI9ohjyL/ikt+pHdV60pD+oKKT+xaf+8ThtA3UaMnpGGH
	 g/9HfLMP2CEsV8Pp+Oan0z8HJiNbESeAcULccpn26NlOBTou1JYq8ClHB/zsO182NM
	 UoG3VG9KW4rRTh8Jbvc3nfn7IIpxEMbEfU4vMMsW2B87XZvsRLlhq3h7aj6bf8YVcN
	 6Hf1qEZiU9pnw==
Content-Type: multipart/mixed; boundary="===============2269967893526965054=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4fc72796a6ccf2acff87fc27a0f73bb64b74199cad21829b1c6a59fbf0b474d4@mail.kernel.org>
In-Reply-To: <20261024062329.264086-1-hackerowskiy@gmail.com>
References: <20261024062329.264086-1-hackerowskiy@gmail.com>
Subject: Re: [PATCH] bpftool: fix line info in multi-function CFG dumps
From: bot+bpf-ci@kernel.org
To: hackerowskiy@gmail.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,hackerowskiy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 24 Oct 2026 07:05:27 +0000 (UTC)

--===============2269967893526965054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: fix line info in multi-function CFG dumps

TL;DR:
- Selftest's expected string likely never matches: it doesn't escape '>' in
  "skb->len", unlike the DOT output
- Even if fixed, the check may not distinguish fixed from old code

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_cfg.c b/tools/testing/selftests/bpf/prog_tests/bpftool_cfg.c
> new file mode 100644
> index 000000000000..7d5b80927b65
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_cfg.c
> @@ -0,0 +1,41 @@

[ ... ]

> +void test_bpftool_cfg(void)
> +{
> +	struct bpftool_cfg *skel = NULL;
> +	struct bpf_prog_info info = {};
> +	__u32 info_len = sizeof(info);
> +	char output[MAX_BPFTOOL_OUTPUT_LEN];
> +	char cmd[MAX_BPFTOOL_CMD_LEN];
> +	const char *expected = "return\\ bpf_ktime_get_ns()\\ ?\\ skb->len\\ :\\ 0;";
> +	int err;

Can this expected string ever match the bpftool output?

The DOT output prints source lines through btf_dump_linfo_dotlabel() ->
dotlabel_puts(), which escapes '>' as well as ' ':

    static void dotlabel_puts(const char *s)
    {
        for (; *s; ++s) {
            switch (*s) {
            ...
            case '<':
            case '>':
            case '|':
            case ' ':
                putchar('\\');

So the line "return bpf_ktime_get_ns() ? skb->len : 0;" is printed as:

    return\ bpf_ktime_get_ns()\ ?\ skb-\>len\ :\ 0;

The expected string escapes the spaces but not the '>', so it contains
"skb->len" where the output has "skb-\>len".  Would the string need to be
"skb-\\>len" for the strstr() in ASSERT_HAS_SUBSTR() to find it?

As far as I can tell, no other part of the visual output contains this source
text unescaped, since print_insn_for_graph() escapes '>' as well.

[ ... ]

> +	err = get_bpftool_command_output(cmd, output, sizeof(output));
> +	if (ASSERT_OK(err, "dump program CFG")) {
> +		ASSERT_HAS_SUBSTR(output, "cluster_1", "second function in CFG");
> +		ASSERT_HAS_SUBSTR(output, expected, "second function line info");

Even with the escaping corrected, can this check tell the fixed code from the
old code?

In this program the main function is only two instructions (call; exit) and
helper() is longer.  With the old function-relative lookup, the basic blocks
of helper() at relative index 2 or higher already resolve to helper()'s own
line info records, because their global insn_off is also 2 or higher, and
those records all point at this same source line:

    return bpf_ktime_get_ns() ? skb->len : 0;

So that line probably appears in cluster_1 before the fix as well.

The commit message says the selftest "checks the second function source line
in visual output".  Would it discriminate better to check that the main
function's line, "return\ helper(skb);", does not appear in cluster_1, or that
the helper() line comes right before the first instruction of the cluster?

> +	}
> +
> +cleanup:
> +	bpftool_cfg__destroy(skel);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40071369261
--===============2269967893526965054==--
