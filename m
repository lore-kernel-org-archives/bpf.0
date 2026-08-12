Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD343FD0B;
	Wed, 12 Aug 2026 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537138; cv=none; b=LMK9Ao+AZQ1pGYf3JVxNXCS48U01xD2o6bBhUr/WDAzG9l00MUIchCyZfsFU0+PX7sXQr1MC25qBZxDNTTCFxj/ByLTXTxcqkoXoip3n+VARHbApukP6WWEkkk11yRGdTz7MA1BH6WjKMfZG2X+g6xlGt0EzCn+sKXPB8CDHNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537138; c=relaxed/simple;
	bh=QWn50Oylf+681fTCx1IsYlRTZNh/g5E52GPeIeYZuHE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Nc0u8AcWNp2cTwsF0Jg5lE97rRjN+GQSeuDlSu0rZKLqQyWunl+gcdBDF7bTGA/Y4exY8va/LIJhqZtr7EPswTE1SyLC025GE7sBYhoHKzbsGdXZjHu5f6qHc8WZm5+ujffbUMG7dmfMrA31H9zLdj3vf7gXyfpbDl0rz+uTzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkl+pLqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkl+pLqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2FC1F00A3F;
	Wed, 12 Aug 2026 12:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786537135;
	bh=9yXDvA+BC1z5uaBcOf5IKbQODG+1aW8vyjmoSLm/JXc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nkl+pLqJ/gG/BgchBtj15AuCWYHmx0/s4+kjMLBSIS58gmI2lta+jTX+/2SC44IOP
	 A46OIfxyPaAM6mQRAEQXnvQlrIqZWmmYkD56CoMDWvEDE7wsbDgzhw15r9UsTDy3bw
	 hbD8CQRFknMHKHRUZC7uvt3B32RNPh7iuTj986xgDyrLlbNyUisvLELo5UQ4rcaFvf
	 1iFWs7fi+EhjYAG1QZZ70Hx5Yq4oSWa9SpQi2TB6F8K0Qfz2V16oLzGCYAH3DzFZlu
	 pfu7aL8362F5JqOBNd3hjsz6OvJmP0as4mKV+AIhDj4CNa1BaXXdj2kJDezrlQgPoH
	 NIWt8pWPrFjpw==
Content-Type: multipart/mixed; boundary="===============0942110370436710155=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <16d139f5b77313ab4f14b656d2d885ad96641f699019b86d7f0ee59a0b6cd0b4@mail.kernel.org>
In-Reply-To: <20260812111140.7762-4-tasos.papagiannnis@gmail.com>
References: <20260812111140.7762-4-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Test linux_binprm user memory kfuncs
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 12:18:54 +0000 (UTC)

--===============0942110370436710155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
> new file mode 100644
> index 000000000000..3d5080a3975e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c

[ ... ]

> +	if (!child) {
> +		char *const argv[] = { "first", "second-argument", NULL };
> +
> +		skel->bss->monitored_pid = getpid();
> +		execv("/bin/true", argv);
> +		_exit(errno);
> +	}

[ ... ]

> +	ASSERT_EQ(skel->bss->str_arg0_ret, 6, "str_arg0_ret");
> +	ASSERT_EQ(skel->bss->str_arg1_ret, 16, "str_arg1_ret");

This isn't a bug, but could these be written as sizeof("first") and
sizeof("second-argument") so the expected lengths track the argv[] strings
defined above? The literals 6 and 16 mean anyone changing an argument
string has to update three places.

> diff --git a/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
> new file mode 100644
> index 000000000000..679363811edc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c

[ ... ]

> +	invalid_flags_ret = bpf_copy_from_user_bprm(args, sizeof(args),
> +						    (void *)bprm->p, bprm, 1);
> +
> +	copy_ret = bpf_copy_from_user_bprm(args, sizeof(args),
> +					   (void *)bprm->p, bprm, 0);
> +	if (copy_ret)
> +		return 0;
> +
> +	args_match = !__builtin_memcmp(args, expected_args, sizeof(expected_args));
> +
> +	str_arg0_ret = bpf_copy_from_user_bprm_str(arg0, sizeof(arg0),
> +						   (void *)bprm->p, bprm,
> +						BPF_F_PAD_ZEROS);

This isn't a bug, but would an obviously out-of-range value like ~0ULL
read better than the literal 1 for the invalid-flags probe, given that
BPF_F_PAD_ZEROS is also 1? A reader has to look up the flag's value to
see the two uses are unrelated.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31592551940
--===============0942110370436710155==--
