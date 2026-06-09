Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EC242D6A
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019609; cv=none; b=hqEg6/ml3nQu054S6jHd+qgKIgy9ItsGjLWoNPqzJ6UElxyRO/jALMrDi1CVtglQywDc1ZhvveaTf0g4gSq4W60JKo9/ZmoiylD9S/PctqPUUIP0sLTrfWPsK6sg02iqHN3JhFURE4c582nhBSxGt6dc1+IxPPdoMKfjMCz8s2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019609; c=relaxed/simple;
	bh=MsVmNFSYIsjxe17qO4ZLxMZRQoo1HKXWv0fxWQbkWIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PRUMpK4CsylAIn5y1v7rwH3jPM98TXb71ODa1FxXIrE8cpvzmXtyYwzQINQ/FZR3m6rha5723p7msx8onphZCfJ8OM65V+qBvbffBppfhxJ3sI5kd6sg6zdMN6aeDGfroh0Sgiae+qRHhjh4Rq8oc+blBdM9d02B5AEy/RQ5/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iruBYU4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iruBYU4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED4F1F0089B;
	Tue,  9 Jun 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781019608;
	bh=GAu3zLcE60mowJWm/Melsm2f/TIX+km9nC88x4yn92w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iruBYU4NbN3rM6cjLQV/i6/xJRmXCi00o9DnWnF8IidAzvrS6VMaZJttaT8Hqfo7T
	 fRmdipuBg90PNcXd/Gpo7us+2/pooDfsDwpVJ+dD5udULygQcZLL/3zVg3mDMqPJQO
	 ovm5BFztXGgFh2d3BejU/hpH33B730JvshbH0SuKZhtbMy11nKS8uzsN38UKXQMueq
	 qhrVlrJQHNh6pdnLe77WKgRvLm6LPniAy51RdnJGIDVCRt7UA46oonsk/N3HyAhTWP
	 x8gISNj8J4N2ie0MOGC+2FTlTXHx0Ux280gkIiR6WGDZhPnQt2AffeQ2+ChFWiDsUz
	 GJbN+A8lZVA+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add cross-subprog gotox
 target coverage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609-f01-02-gotox-bpf-next-v1-2-b441d63a1559@mails.tsinghua.edu.cn>
References: <20260609-f01-02-gotox-bpf-next-v1-2-b441d63a1559@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:40:07 +0000
Message-Id: <20260609154008.1ED4F1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `check_cross_subprog_gotox_target` incorrectly expects =
`bpf_prog_load` to fail with `-EACCES`, but the verifier actually rejects c=
ross-subprog jump targets with `-EINVAL`, causing a false test failure.
--

commit f7ef2af9b62d2a415c2072928a61150823abda72
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
selftests/bpf: Add cross-subprog gotox target coverage

This commit adds a gotox regression test with two one-entry INSN_ARRAY maps
to verify that the control flow graph handles indirect jumps correctly. It
ensures that when a verified path loads a map whose target points to another
subprog, the program load is rejected.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/t=
esting/selftests/bpf/prog_tests/bpf_gotox.c
> index 73dc63882b7d5..866b4a14ccb7c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c

[ ... ]

> @@ -393,6 +417,52 @@ reject_offsets(struct bpf_insn *insns, __u32 insn_cn=
t, int off1, int off2, int o
>  		close(prog_fd);
>  }
> =20
> +static void
> +check_cross_subprog_gotox_target(struct bpf_gotox *skel __always_unused)
> +{

[ ... ]

> +	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
> +				insns, ARRAY_SIZE(insns), NULL);
> +	if (!ASSERT_EQ(prog_fd, -EACCES, "cross_subprog_gotox_prog_load"))

[Severity: Medium]
Will this assertion fail because the verifier returns -EINVAL instead of
-EACCES?

When the verifier inspects the gotox target via check_indirect_jump(), the
target fails the is_cfg_indirect_jump_target() check. This causes the
verifier to explicitly reject the load with -EINVAL.

The memory access itself passes the verifier's check_map_access() bounds
check since it reads from a valid offset, so we don't get the -EACCES return
value here.

Should this test expect -EINVAL instead?

> +		close(prog_fd);
> +
> +	close(bad_fd);
> +	close(good_fd);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-f01-02-got=
ox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn?part=3D2
