Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF24A3F07
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680892; cv=none; b=Beb4+dbIw9EfmdbC2S4n2ZNoRffDZVZJIavMq9Wq/vjrvFNLrsxfCbIiV415UIGo3f4oWRMCO7+ZbopiGaT8PurthvtcncofAMcPIXTbA0028FNmK4KTlWxaAnvOCs/Vz+ifi6snPlvaH0wbm3byy0yIvJUUm0Qqd90JuIGocbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680892; c=relaxed/simple;
	bh=lAI97H9jgIKhcnrb4GgY/KVxha5U0bRQ9b4nHhy4xGQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YC5DO7iIzi+KQ0gUMklGEiDjz3ZkTtmUbxNuXQLd4L3Er7RRl4jVhcFsxL142gsOYSRG4cBk7jS5mQa0xcF35Mw/MiBR/YfIOYPCpJWSBMMQgqcOoSsBbtzPrJMbzObsj0YssAy9HB6i7JvZ5+GsiNB9dwE3+kHZ9NMpvN6dWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlMXIdRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlMXIdRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4BD1F00893;
	Thu, 17 Sep 2026 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680890;
	bh=ikww3bH643Go6af+Pwo47E8bbLvtZGD+gipytte7E1E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LlMXIdRpFimhyod3uSkIiNJPS5hOUTTgl4SUsCehyBWbY+0xgAmMWS7YktvxEVE8f
	 NGAk6ZAzl9OJcMRIaVp4Y7KPxo1bqgDBprw9iHfrxtfY4BN72UzaDgwm6fYTdvCbq5
	 t9BptVX8nI8V2j2Y0YuLTPBZluzUaq6N8uqpoG1qe9W0h9X+ADOReF+ePONVZoAklz
	 tEd4bLm7e09E+YKzTjYJyrDJBC9YoUtHAaDBodv2Q4Bd+NNmYLQ7xox30/wXkIYQcy
	 AdM7a9057E4eAKfIXQHs571Yufhju2XlbviIpoPYxdfV3Ao8mRQgCTMgtZwpu6ci+A
	 XfceenxrQ6UPw==
Content-Type: multipart/mixed; boundary="===============0650344551547110026=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a7e109909f2eb592efd164d60c23693f526daad413171f11efbc4fdee34c66f5@mail.kernel.org>
In-Reply-To: <20260917203040.3150212-6-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-6-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 5/6] selftests/bpf: Cover BPF program load strategy transitions
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:34:50 +0000 (UTC)

--===============0650344551547110026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
> new file mode 100644
> index 0000000000000..55ca53685863c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/load_type.c

[ ... ]

> +	/*
> +	 * leaving MANUAL for AUTO must restore autoattach (regression test for
> +	 * the autoattach residue bug: set_load_strategy(MANUAL) clears autoattach, and
> +	 * nothing used to restore it on exit)
> +	 */
> +	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
> +	if (!ASSERT_OK(err, "set_load_strategy_auto"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_AUTO,
> +		       "prog3_load_strategy_auto"))
> +		goto cleanup;
> +
> +	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog3), "prog3_autoattach_restored"))
> +		goto cleanup;

Can this test actually distinguish a correct implementation from a
broken one?

The comment advertises this as a regression test for autoattach-restore
behaviour, but prog3 enters MANUAL with autoattach already true (from
bpf_object__init_prog() initialization), and the test never changes
prog3's autoattach to false before the MANUAL transition.

The libbpf implementation restores from a saved slot:

tools/lib/bpf/libbpf.c:bpf_program__set_load_strategy() {
    case BPF_PROG_LOAD_STRATEGY_DISABLED:
    case BPF_PROG_LOAD_STRATEGY_AUTO:
        if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
            prog->autoattach = prog->saved_autoattach;
        prog->load_strategy = strategy;
        break;
}

Since saved_autoattach is always true for prog3, the ASSERT_TRUE check
would also pass if the restore arm were the broken assignment
"prog->autoattach = true;" instead of the correct
"prog->autoattach = prog->saved_autoattach;".

The discriminating case would be:

    err = bpf_program__set_autoattach(skel->progs.prog3, false);
    /* ... transition through MANUAL and back to AUTO ... */
    ASSERT_FALSE(bpf_program__autoattach(skel->progs.prog3),
                 "prog3_autoattach_restored_false");

Without that arm, does the test check what its comment claims?

> +	/*
> +	 * confirm the restore also holds across a MANUAL -> DISABLED -> AUTO
> +	 * round-trip: AUTO and DISABLED share one guard keyed off the source
> +	 * strategy being MANUAL, so autoattach is already restored at the
> +	 * MANUAL -> DISABLED step, not by a separate DISABLED -> AUTO one
> +	 */
> +	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
> +	if (!ASSERT_OK(err, "set_load_strategy_manual_again"))
> +		goto cleanup;
> +
> +	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);
> +	if (!ASSERT_OK(err, "set_load_strategy_disabled"))
> +		goto cleanup;
> +
> +	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
> +	if (!ASSERT_OK(err, "set_load_strategy_auto_via_disabled"))
> +		goto cleanup;
> +
> +	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog3),
> +			 "prog3_autoattach_restored_via_disabled"))
> +		goto cleanup;

The MANUAL -> DISABLED -> AUTO round trip has the same property: it
re-checks a value that is true on every path.

[ ... ]

---

Regarding maintainer feedback from v1 (January 2025):

Andrii Nakryiko raised design concerns about adding the third autoload
state. From the v1 thread
(https://lore.kernel.org/bpf/CAEf4Bzajxh4xvg-aCaBhLQdNOZdhwceYUD2UsCcWku4ZBca_Hw@mail.gmail.com/):

> In general, I'm not too excited about these complications, it's
> error-prone enough with just normal autoload (true/false) logic and
> various interactions between different features. Adding the third
> 'may be loaded much later' state just doesn't seem worth the
> complexity.

He suggested two alternatives: (1) breaking apart BPF objects with
shared maps using bpf_map__reuse_fd() or pinning, or (2) using a
prepare/load split API. In a follow-up message
(https://lore.kernel.org/bpf/CAEf4BzZ=-r7AkSGhru_NMxPcXDLmkVpTiQrBxUvsgq-LE0Lk6w@mail.gmail.com/):

> [B]pf_object won't become multi-threaded and dynamic program
> loading/unloading/loading again cannot be justified. Best proposal
> is to use libbpf for ELF handling and relocations, then take over
> program lifetime outside of bpf_object

While the v3 series (September 2026) reorganized patches and renamed
DYNAMIC to MANUAL, it still implements the third state that Andrii
expressed concerns about. The v3 series has received no human reviews
yet. Has there been further discussion that resolved the maintainer's
design concerns, or is the current approach still open for discussion?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35272462686
--===============0650344551547110026==--
