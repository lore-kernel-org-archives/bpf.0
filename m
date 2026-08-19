Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913123CEBA9
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121969; cv=none; b=P76rNoBQED2nEOL/GNqXZZfTJNb6IhcMt0SIMb2+Y15lsnr2RrUXU4E9rvb12kEWwY7CKPVuT10y0kpiIr38mMaq+j6boSafuZB/KeQbsLbakRE+qVBKkIxn2RyVneQTRJzyCiMpUmGQfWEim4lpQr+aVLYWQyNzdLNqplbqmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121969; c=relaxed/simple;
	bh=cR9NmeJT7gSwgA/kS0UtQfvo91fdRcH7q/QCqsH6scM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I3UPbRLBAchbE7UFH/V7kSBpalehzjKElvk+oX//CEnR7Kv1DAT41HBQOTPYyNLt158vC2tlAhkS2FbXVgIj/g0nfvl8bCvQlgZwzSiH5rBUwWSaTjThnkfhF0Xs/eHFz/eB8W2XOgC958fqLe5QD/9YAADx6L7PNL/Pee9IUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ/PnVIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ/PnVIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176581F000E9;
	Wed, 19 Aug 2026 06:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787121968;
	bh=z/ndXVph8gOfkiC1fZYX3AbiMMn0GXHna9PhGdhr2hA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJ/PnVIyU+0UziubX7KLrrO9AzQvQZSiJ3v2SVqvnCd9Z3kBh0XTztDKgO5NLlgXm
	 THcD1SE/1BeomRT6wOsY3f2N3FHimmcEKP7Zbq0CxydnmZ+YRMI7SSkpe1R12tB2wm
	 0UM2S0pxano1ADRP+s8AHi9SjS+gK+7btwrSgyhM+zF7nUh7B5iGVBoTXp4vhg6HMi
	 n9eFfqVZTBVKhR99+qYOMMIN0urKq7niKdzOOb2xtYcGrQMcUZYACdrk3ad5QTFkBL
	 7rxiPanNmZBBttSsgJ4T2Nega+9cnnH7ck60ypzK82ayNjxd7031O6H4ARjMeHInoo
	 Iqsbg2QatNjtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add memcg async reclaim
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <052d445fe9d7741729447f1b90277dcdc6541b4f.1787120833.git.zhuhui@kylinos.cn>
References: <cover.1787120833.git.zhuhui@kylinos.cn>
 <052d445fe9d7741729447f1b90277dcdc6541b4f.1787120833.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:46:07 +0000
Message-Id: <20260819064608.176581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Process leak due to overwriting child PID variable with the resu=
lt of waitpid().
- [Low] BPF comment style violation for multiline comments.
--

--- Patch [2]: [PATCH bpf-next v3 2/2] selftests/bpf: add memcg async recla=
im test ---
commit 4779648533dd0e49d1c2f5c9bdbbad1260ba333c
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: add memcg async reclaim test

Add memcg_async_reclaim selftest that verifies BPF-driven async proactive
reclaim can mitigate refault-induced slowdown under memory pressure.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c=
 b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 0000000000000..e990d1fdc79fd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c

[ ... ]

> +	low_pid =3D fork();
> +	if (!ASSERT_GE(low_pid, 0, "fork low"))
> +		goto cleanup;
> +	if (low_pid =3D=3D 0)
> +		exit(real_test_child_work(CG_LOW_DIR, low_data_file,
> +					  low_time_file, read_times));
> +
> +	high_pid =3D fork();
> +	if (!ASSERT_GE(high_pid, 0, "fork high"))
> +		goto cleanup;
> +	if (high_pid =3D=3D 0)
> +		exit(real_test_child_work(CG_HIGH_DIR, high_data_file,
> +					  high_time_file, read_times));
> +
> +	low_pid =3D waitpid(low_pid, &status, 0);
> +	if (!ASSERT_GT(low_pid, 0, "low waitpid"))
> +		goto cleanup;

[Severity: Medium]
If waitpid() fails and returns -1, does this overwrite low_pid with the err=
or
value?=20

Later in the cleanup path, the code relies on the PID being positive to kill
the left-behind child processes:

	if (ret) {
		if (high_pid > 0) {
			...
		}
		if (low_pid > 0) {
			kill(low_pid, SIGKILL);
			(void)waitpid(low_pid, NULL, 0);
		}
	}

Since low_pid was overwritten with -1, the cleanup logic will fail to kill =
the
child process, potentially leaving it running and consuming resources. Woul=
d it
be safer to store the waitpid() return value in a separate status or pid=20
variable?

> +	/*
> +	 * The child has been reaped and its PID can already be reused,
> +	 * so mark it to keep cleanup from signaling an unrelated process.
> +	 */
> +	low_pid =3D -1;
> +	if (!ASSERT_TRUE(WIFEXITED(status), "low exited"))
> +		goto cleanup;
> +	if (WEXITSTATUS(status) !=3D CHILD_EXIT_OK) {
> +		PRINT_FAIL("low child failed at: %s (exit status %d)",
> +			   child_exit_str(WEXITSTATUS(status)),
> +			   WEXITSTATUS(status));
> +		goto cleanup;
> +	}
> +
> +	high_pid =3D waitpid(high_pid, &status, 0);
> +	if (!ASSERT_GT(high_pid, 0, "high waitpid"))
> +		goto cleanup;

[Severity: Medium]
Similar to the issue above, if waitpid() returns an error, high_pid is
overwritten. This prevents the cleanup code from terminating the high_pid c=
hild
process if the wait call is interrupted.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c b/to=
ols/testing/selftests/bpf/progs/memcg_async_reclaim.c
> new file mode 100644
> index 0000000000000..225f0bc667113
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c

[ ... ]

> +static u64 wq_high_cgroup_id;
> +static u64 wq_low_cgroup_id;
> +
> +/* Statistics exposed to userspace through .bss, so the test can verify
> + * that reclaim actually happened instead of relying on timing alone.
> + */

[Severity: Low]
This isn't a bug, but the BPF subsystem prefers multi-line comments to have
the opening /* on its own line:

/*
 * Statistics exposed to userspace through .bss, so the test can verify
 * that reclaim actually happened instead of relying on timing alone.
 */

> +u64 reclaim_calls;
> +u64 reclaimed_pages;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787120833.gi=
t.zhuhui@kylinos.cn?part=3D2
