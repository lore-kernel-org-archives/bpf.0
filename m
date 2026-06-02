Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE93D6463
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394779; cv=none; b=ENRVZolkglYLvKQY9wmYT2AkPFMYFpwJI+bXySKEK9xvhQQZH5B9kYSdtnMSObZREs2FxvdpAIbayVWxOFKSkFLKJOWpgbNU+CPiZncT0puW14CfYfh67vU43KL2h/IRbU5zIv3ZrzELZm2bLl6HK9zO5qbYVqUuZ6xZCrunhhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394779; c=relaxed/simple;
	bh=pINKjYoL6IMUywK8A4HglYR5ZxGdrPQv8OVjLpOkwIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=geY8yPMmr3bA0iYFEYnrnKGBhXNMtf9f88Lw5IIvUHzNfjgmmVW541RT958CYSxgetc0M9v06/6SyQ5IjhAiDDYMZQ3boIGTAYJ8ibDHCOTZx/yNAJtoKaMHvO4XCHbs8tL+orvVseE/eoIc22aWtyGTSYFThGD2yOPnffKGGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSyLauRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSyLauRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969041F00893;
	Tue,  2 Jun 2026 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780394777;
	bh=FKMk7awqgqsU4JhAY3VxMKsaAmqP2aDtdiIWh75TSsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bSyLauRdm7yYUpeoAmhAZE2arIfvPylhntJUwU6iu6WfndtYxAzluXrGlAXGQL3XL
	 zgnhovUXLOf399GCWa3ceQEm6QtfnjKQxKa9qv1P2Y60yNvlCffs4jNdlmWnSq11GB
	 K0ikUNnIZ3FqqERRHN9XrBLWhVipTbhM1o9CUezgKog/CBWT4sNATQcSboIbYOJdOv
	 R+aFPbcCRIbkiVdwKrSoyriwK4avBsJs0NxQn6+voKOgSaftUsosoPG6DcDIZapopH
	 82lu9xEgD0J89Zo2/j59s5SamMh4OzWxUhMcZ9jXpmQx2LoZLoGGG33Tr7OcG46j9j
	 GRknRYPdOlZmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for kfunc
 implicit arg injection
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602093836.2632714-3-chenyuan_fl@163.com>
References: <20260602093836.2632714-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 10:06:17 +0000
Message-Id: <20260602100617.969041F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The multi-line comment in `struct_ops_assoc.c` violates the strict =
BPF subsystem comment style guidelines.
--

commit 0131da78b5d91ab9b0a63c8ffd845ab004048c55
Author: Yuan Chen <chenyuan@kylinos.cn>
selftests/bpf: Add regression test for kfunc implicit arg injection

This commit adds a positive regression test to verify that the injection
path for KF_IMPLICIT_ARGS kfuncs works correctly. It uses inline assembly
to contaminate BPF R2 before calling a kfunc associated with a struct_ops
map.

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools=
/testing/selftests/bpf/progs/struct_ops_assoc.c
> index 68842e3f936b9..ed0084453d560 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> @@ -103,3 +103,43 @@ SEC(".struct_ops.link")
>  struct bpf_testmod_multi_st_ops st_ops_map_b =3D {
>  	.test_1 =3D (void *)test_1_b,
>  };
> +
> +/* Test for aux injection with stale register contamination.
> + *
> + * This test verifies that the kernel correctly injects the implicit

[Severity: Low]
Could this comment be updated to follow the BPF subsystem style?
Multi-line comments in this subsystem should have the opening /* on its own
line, with the text starting on the following line.

> + * bpf_prog_aux pointer for kfuncs with KF_IMPLICIT_ARGS.  The program
> + * uses inline assembly to contaminate R2 with a known magic value
> + * before calling the kfunc:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602093836.2632=
714-1-chenyuan_fl@163.com?part=3D2
