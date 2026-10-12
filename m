Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAC30F819;
	Mon, 12 Oct 2026 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823601; cv=none; b=E7BekS/p3JXFql4+kSNQ+n1N4CKHxzClGUgLYR0MoKGWjUJ+EROUYktwtEyRsRD0CVPiIAGenLl+XuFau1jun1UqSK1x/UNnz2IqFs5V4inGiva/yCXJVT7D5P+ANKRCPkl0yBynFbUF1wqwsCI09IIB9/k0VfjsdQxp5wgyfeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823601; c=relaxed/simple;
	bh=5zENGPe8/0XslURT4jDzB8tq67voIgRyEYOUi5kfJeY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qabsGQ5wbHARAike2c4cW7hpBjULWik1iG8IedNUrLACof9LBQcfXSceUlyNoRWUrmsfvQhlmam2XI0hydyOhpdXT9+owv9AnOGorwLJPLLFAI/OeVqrpH9i+G8e3BtxhdSNFlo/FfEuMGLtXG5y2ceP4C0BTrPx73BY7ly1IEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0yVan18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0yVan18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FE51F0089B;
	Mon, 12 Oct 2026 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791823600;
	bh=Ywua7kqyZdUR5WkW0XphExSAu4IEMeLbhmJLsB28M10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C0yVan18E8xG4NUR6RwngJoHcCm1lX9s2ElPwyF/xAx9rYMIJ8epGwpSy7+9cQaT/
	 BkxSnLmlJ0BgH9C0njkUPxKGRRPFPOrnqo2ThUv6qTAZ2E7e+7+kyfSnqvW3WJSZG0
	 ucIqcBwNS/aVtJyRpKPhyIeMdq6omwh8RsnRdygdhNs+mnrYMo3E6Li6rNQ1XQ/GQI
	 qtFSGGzCI0DICU7y5b07l71b7CNx0QMNbSfkVwfOtTBOovE80gIhzvGl84/COYGoOd
	 gSYqVruOWvEltCBB+CcCO705go0EpEWqXdOfhjVGJlHyiDcKPXOc5oIyKUqzG4yK8Q
	 u3qn2cCAlnLrQ==
Message-ID: <sashiko-outbox-168428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 18/21] selftests/bpf: Add tracing_multi bpf
 prog rollback test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261012154024.29423-19-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-19-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 16:46:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: selftest tracing_multi rollback logic relies on unreliable =
FD ordering
--

commit 00cadf9aa091042698069799ffcf7faa2dd5e6a5
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tracing_multi bpf prog rollback test

This commit adds a rollback test for multi-attach fentry BPF programs. It
sets up two targets, pre-attaches to one, and then verifies that a subseque=
nt
multi-attach to both correctly handles the busy state and rolls back.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/too=
ls/testing/selftests/bpf/prog_tests/tracing_multi.c
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -1308,6 +1308,67 @@ static void test_attach_api_bpf_prog_fails(void)

[ ... ]

> +	first =3D target_fds[0] < target_fds[1] ? 0 : 1;
> +	second =3D 1 - first;
> +	fds[0] =3D target_fds[first];
> +	fds[1] =3D target_fds[second];
> +	ids[0] =3D target_ids[first];
> +	ids[1] =3D target_ids[second];

[Severity: Medium]
Does this code incorrectly rely on file descriptor order to predict the
kernel's internal sort order?

The kernel sorts the targets based on a computed key derived from the
program ID and BTF ID: ((u64)prog->aux->id << 32) | btf_id. While program
IDs monotonically increase, FD allocation uses the lowest available FD.

If a lower FD becomes available (for example, closed by another thread or
process) between loading the first and second targets, the second target
receives a smaller FD but a larger ID. This reversed order means the test
will incorrectly predict how the kernel sorts the targets.

> +
> +	prog_fd =3D bpf_program__fd(skel->progs.test_fentry);
> +	lopts.tracing_multi.ids =3D &ids[1];
> +	lopts.tracing_multi.fds =3D &fds[1];
> +	lopts.tracing_multi.cnt =3D 1;
> +	pre_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY_MULTI, &lopts);
> +	if (!ASSERT_GE(pre_fd, 0, "pre_attach"))
> +		goto cleanup;
> +
> +	lopts.tracing_multi.ids =3D ids;
> +	lopts.tracing_multi.fds =3D fds;
> +	lopts.tracing_multi.cnt =3D ARRAY_SIZE(ids);
> +
> +	fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY_MULTI, &lopts);
> +	if (!ASSERT_EQ(fd, -EBUSY, "bpf_link_create"))
> +		goto cleanup;
> +
> +	prog =3D first =3D=3D 0 ? skel->progs.target_1 : skel->progs.target_2;
> +	if (run_bpf_target(prog, first + 1, "rollback_target"))
> +		goto cleanup;
> +	ASSERT_EQ(skel->bss->test_result_fentry, 0, "test_result_fentry");

[Severity: Medium]
Can this assertion pass without the rollback path ever being tested?

If the FD order doesn't match the ID order as mentioned above, the test will
pre-attach the element that the kernel sorts first. The kernel will then
fail immediately on the first element of the multi-attach request. Because
it failed on the first element, it never proceeds to attach (or need to roll
back) the other elements.

The test_result_fentry variable remains 0 in this case, meaning this
assertion will pass and silently mask that the rollback path wasn't
actually exercised.

> +
> +cleanup:
> +	if (fd >=3D 0)
> +		close(fd);
> +	if (pre_fd >=3D 0)
> +		close(pre_fd);
> +	tracing_multi_bpf__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012154024.2942=
3-1-leon.hwang@linux.dev?part=3D18
