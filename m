Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29F35E1B6;
	Fri, 29 May 2026 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780027080; cv=none; b=YFoZhEckGy50+dWmxLnNTf+Pn3uH1OpApndDUH1E/pQtx6RcN4j2gO82tBFx1pQrUMQQbHvu8/FRhvhyjqXj3Vj6gl+Q+l2IZsbCmKZFdpLMoUJrX8vx2tHRul2DINB5QtGvfpXQH9uI5i58FME5tL4oMWX6k+X5OEeoXMRVcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780027080; c=relaxed/simple;
	bh=Oyeoxe1XzpOqRaa89dE431wIMRydupXVkaO/ZY1IBxE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mRtDw56NzPnNaZkFVHKbD86xTVscXYVWA5L3rbYmhp55oMCvuioW9dOkLL9pNUMmISoSK60JaamxiAPqkR90/ggkdX7fKmGmiSlbdlxALINeHqHL38TAFMP92Ujon2+xz+MqWgf4+kzJZ/iGO4QC08EQeofZDTElLqX91V6LGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoAQVJyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoAQVJyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A490E1F00893;
	Fri, 29 May 2026 03:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780027078;
	bh=TF8oMuyolNgIYhK+/+aFl6olLARMqck5qvrRMxXKrSM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SoAQVJyi4H5AJiu4rSmit8l96dzm/O2Upq5sJU3c9mL+tOuazrXA1l5UkmhtOV2xw
	 nmajanA1l/K2v5mwg72AxlGTqPxWFtaCEVxtMe8MDHAQbv5kAwAcl98kaB7xVPXSiu
	 Hh5Gkd+zhgSIYGaXqVqw2xCYs4/JrS3+oAaPIjAxQBdGub39rqGscjkpH1tko2x8Fg
	 NtNHSulYt7FdyVr8jRkw+QAqD1aqyz4mysArnU+hN90oelMauQg47aMMPl/3iDybO9
	 cDgnB54LLlbE1UX3lBR0SGNQyK8uqoq6QrZkZfgw7smQu9YxJjcl4kvqdBA/Z1LFjT
	 XCpcqc61lJXyw==
Content-Type: multipart/mixed; boundary="===============3412909997394935995=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2a681961e97de6243f45aec51ba3ab8051055d1daf55c2f2b5ae2a31ee7f2d66@mail.kernel.org>
In-Reply-To: <20260529031604.888137-1-chenyuan_fl@163.com>
References: <20260529031604.888137-1-chenyuan_fl@163.com>
Subject: Re: [PATCH] selftests/bpf: fix token tests for bpf_object__prepare() probe_loading
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 03:57:58 +0000 (UTC)

--===============3412909997394935995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The bpf_object__prepare() function internally calls bpf_object__probe_loading(),
> which attempts to load SOCKET_FILTER and TRACEPOINT programs to verify the BPF
> environment. Without these permissions in the token, the probe fails and causes
> the tests to fail.
> Fix the following test cases by adding SOCKET_FILTER and TRACEPOINT permissions:
> - obj_priv_map
> - obj_priv_prog
> - obj_priv_freplace_prog
> - obj_priv_freplace_prog_fail
> - obj_priv_btf_fail
> - obj_priv_btf_success
> - obj_priv_implicit_token
> - obj_priv_implicit_token_envvar
> - obj_priv_prog_kallsyms
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

The commit message describes adding SOCKET_FILTER and TRACEPOINT
permissions, but the patch also adds bit(BPF_PROG_LOAD) to the
obj_priv_map test and bit(BPF_MAP_TYPE_ARRAY) to obj_priv_btf_success,
obj_priv_implicit_token, and obj_priv_implicit_token_envvar.

Could the commit message be updated to describe these additional changes,
or should they be dropped if they are not needed?

This fixes failing token selftests but does not carry a Fixes: tag. The
tests began depending on the probe permissions once they started routing
through bpf_object__prepare(). Commit a024843d92cc introduced the
bpf_object__prepare() call into prog_tests/token.c. Should this include:

  Fixes: a024843d92cc ("selftests/bpf: Test freplace from user namespace")

> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
> index f2f5d36ae00a..25a76e09a3c9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/token.c
> +++ b/tools/testing/selftests/bpf/prog_tests/token.c
> @@ -1168,8 +1168,13 @@ void serial_test_token(void)
>  	}
>  	if (test__start_subtest("obj_priv_map")) {
>  		struct bpffs_opts opts = {
> -			.cmds = bit(BPF_MAP_CREATE),
> +			/* BPF_PROG_LOAD is needed for bpf_object__probe_loading */
> +			.cmds = bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
>  			.maps = bit(BPF_MAP_TYPE_QUEUE),
> +			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
> +			.progs = bit(BPF_PROG_TYPE_SOCKET_FILTER) |
> +					 bit(BPF_PROG_TYPE_TRACEPOINT),
> +			.attachs = ~0ULL,
>  		};
>
>  		subtest_userns(&opts, userns_obj_priv_map);

The obj_priv_map test is meant to verify a token restricted to
BPF_MAP_CREATE. Widening it with BPF_PROG_LOAD, SOCKET_FILTER, TRACEPOINT
and .attachs = ~0ULL relaxes the very restriction the test was checking.

If bpf_object__probe_loading() aborts the entire object load with -EPERM
under a confined token, is that better handled in libbpf, for example by
treating the probe -EPERM gracefully or skipping the probe for objects
that have no programs, rather than expanding the token privileges in the
test?

This was raised on the v1 posting and does not appear to have been
addressed:

  https://lore.kernel.org/bpf/20260529031604.888137-1-chenyuan_fl@163.com/

> @@ -1177,7 +1182,10 @@ void serial_test_token(void)

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26616379941
--===============3412909997394935995==--
