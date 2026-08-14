Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1B3624D3
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745013; cv=none; b=sJDnqlbyT4WlUqwWDDqdQyNdiQ362bXhrZUudcpiXu7bPdwmZ+okK4Xew6FiXdN0EqsC4Db9lBMnIlct4W+WlMZCYm3pLrO6ua/x94aKt+znJp6ilFc2o6bAICyoP1xGoqRVp2A5XQ9JZ3zpLFYaOUjTxOU0AGqgpUHp1S+oTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745013; c=relaxed/simple;
	bh=hY5VrYdNindfmZb7chxornVQLdtbP2Dxkq7t2oY92Uw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lm773BccFwbsYt9IblufwIHQt2AzcXokrzDRFiKwlpKq2ij2etFxHFdl9TFKgdFHlRF113zRbVBPwQv2NwjwoH3fkLBwGHWhvxDujpL64tE+xXEUG0DQob9kqbHsn1QHBdB5MOkNfHWkxTcJiolSWh3cWNcfpOfiExTOuqqL4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU4VYg68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU4VYg68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D132B1F000E9;
	Fri, 14 Aug 2026 22:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786745012;
	bh=Is+YLncgynQPx3lecRUIbvhI+3j9IdHjZgVdkZTfg5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IU4VYg68Jm9KAJsc17eX19EM8yC7Z9i9vNGvR9XllpwG5TliopnTt7P/St9Lj29Mt
	 QtNULLylj156N90rGT7RpWs0mOwEXYFLXnRgGbxonkP7BTrESjRDnRcNr073wrcoya
	 wmK0yAbI8wl025wqeZlJ9/zx9rH+x+QgJ1miPqxP6Gqz3S5F6HMHpWd6IHcatUrpi2
	 WYxYtZYdWwXlfo+YpvZ2/J5TXunMLs59738lRL6dKIC8kRNGGZgmMW6RPGeqg6vs3R
	 Aoscq01x6VrcjOrIy/i0uK/6wWTRQ7zBpnKo85634K2b2FK9swGSSrlDjqYs55sJ4a
	 xES+FHjzXN3UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Add tests for fault
 prone loads out of RCU pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814215301.709827-6-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
 <20260814215301.709827-6-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 22:03:31 +0000
Message-Id: <20260814220331.D132B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added BPF programs do not execute the vulnerable instr=
uctions at runtime and lack explicit verifier log assertions, failing to pr=
ovide robust regression coverage.
--

--- Patch [6]: [PATCH bpf-next v2 6/6] selftests/bpf: Add tests for fault p=
rone loads out of RCU pointers ---
commit 6d523ae9972a5903a07a65fd29336ef6414702f5
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Add tests for fault prone loads out of RCU pointers

This commit adds new BPF tests for ensuring the verifier correctly
applies the BPF_PROBE_MEM rewrite to fault-prone loads reached from an
RCU read-side critical section. Two new subprograms are added and
autoloaded in the rcu_read_lock test.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/too=
ls/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> --- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> @@ -34,6 +34,8 @@ static void test_success(void)
>  	bpf_program__set_autoload(skel->progs.rcu_read_lock_global_subprog, tru=
e);
>  	bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_lock, true);
>  	bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_unlock, tru=
e);
> +	bpf_program__set_autoload(skel->progs.non_own_ref_untrusted_ld, true);
> +	bpf_program__set_autoload(skel->progs.rcu_untrusted_union_ld, true);
>  	err =3D rcu_read_lock__load(skel);

[Severity: Medium]
Is `rcu_untrusted_union_ld` reliably triggered by the test harness?=20

Looking at `test_success()`, the harness executes `syscall(SYS_getpgid)` to
trigger the fentry program, but there doesn't seem to be a trigger for the
`tp_btf/tcp_probe` program.

Also, would it be safer to use `test_loader` for these tests so we can
statically assert the verifier log output contains the `BPF_PROBE_MEM`
rewrite, rather than relying only on runtime execution?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c

[ ... ]

> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int non_own_ref_untrusted_ld(void *ctx)
> +{
> +	struct rcu_node_stash *stash;
> +	struct rcu_node_data *node;
> +	int key =3D 0;
> +
> +	stash =3D bpf_map_lookup_elem(&node_stash, &key);
> +	if (!stash)
> +		return 0;
> +	bpf_rcu_read_lock();
> +	node =3D stash->node;
> +	if (!node) {
> +		bpf_rcu_read_unlock();
> +		return 0;
> +	}

[Severity: Medium]
Does this program end up returning early here on every run?

Since the `node_stash` map is never populated from the userspace test
harness, `stash->node` appears to always be NULL. If it returns early,
the test never actually reaches the fault-prone load below to trigger a
kernel panic if the rewrite were to fail.

> +	bpf_rcu_read_unlock();
> +	/*
> +	 * The unlock leaves node as PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED
> +	 * | NON_OWN_REF, and the load below has to get the BPF_PROBE_MEM
> +	 * rewrite for it, otherwise a bad address panics the kernel.
> +	 */
> +	non_own_ref_key =3D node->key;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814215301.7098=
27-1-daniel@iogearbox.net?part=3D6
