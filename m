Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32223DDB15
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167302; cv=none; b=HGW4a8G0Jv377GQJsAz4J9GGXaRV+JUCyznNm0pkiTZvHw6f9f/QoejVvrELtRaBtHPyzAVPh2J2AEhatLQFn6IUP2wyE8B9qNduRRsKr+Ui/i7lsZXh15Ym71ytyqskYkwRXMEUXwr2DgqI4R6dwpJ+7xjRq76mHq/US73z4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167302; c=relaxed/simple;
	bh=SsfH22QCc1+tcqa53rOpKAKx1+S/J8G7Ap9aAdxoQ+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CgBBcSdZ+SI+fsM8DnYRRYFjY8LumjZkBYgm09LZ2uvbyZDDiunYnUQjwuzALu+E7mnf2NxGWQ6U5L//U4IjZGyb30SpHTkbAfewb9LOohIg+VecQH9Z8RWkEnyqxc06rlXY6pIedRSEjG0FQ/tT0MlmgwFffFRI0L7UaO6FPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxqO0pak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxqO0pak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298AC1F000E9;
	Mon, 31 Aug 2026 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788167300;
	bh=OIpkojZgF7w7pQ1pEVIgP7XVychpX1uHwRfYxONQh44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QxqO0pak834b6kwVrAjVSg0uh+KIkI03ZfkLcrQYsmHxrf3T8BPP7kapgyfoo2q4F
	 IpC2jZ9z2a7sW2aqhdmTeg6z4KCrML+sNE+W1HeX4GlvvFeGMmpsq0Jt4Yx+e7EUgA
	 LuVFFXWDLHLz6Z1L2nUeImdkHmbgHofXt4Qe4ZEdq/pQDGATxVNsSYWzJuFQrG+A3G
	 Lw6jLkQu49QrWDLq+krwigybWaVkBPNXGvu5yHIIwgW+d9nMdH64HqlqmnD8g12+wI
	 NnpWRe6LV4RwrpJI4jezHsj8n16uOOb3buja/tSG1k8nlYTDJE7TqLiAgV+mJ6FQS5
	 ivzW5zCzQPoMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add test for indirect
 struct_ops trampoline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831085705.13747-1-yangtiezhu@loongson.cn>
References: <20260831085705.13747-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:08:19 +0000
Message-Id: <20260831090820.298AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The introduction of global state (`st_ops_trampoline` and its mute=
x) in `bpf_testmod` causes parallel test breakages, permanent DoS, and Use-=
After-Free (UAF).
- [Medium] Removal of `RUN_TESTS` drops declarative verifier failure messag=
e matching, masking verifier bugs.
--

commit 932e6a2ea3847d584c9e377639c762f03a9fe713
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Add test for indirect struct_ops trampoline

Add a test case to verify that arguments passed on the stack are correctly
read by an indirect struct_ops trampoline.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi=
_args.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args=
.c
> index 0f321e8898620..7f6f9d61c9e07 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
> @@ -3,7 +3,54 @@
>  #include <test_progs.h>
>  #include "struct_ops_multi_args.skel.h"
> =20
> +static void test_refcounted_multi(void)
> +{
> +	struct struct_ops_multi_args *skel;
> +	int err;
> +
> +	skel =3D struct_ops_multi_args__open();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_multi_args__open"))
> +		return;
> +
> +	err =3D struct_ops_multi_args__load(skel);
> +	ASSERT_EQ(err, -EINVAL, "struct_ops_multi_args__load");

[Severity: Medium]
Does this replace the test_loader's verifier log parsing with a manual
assertion?

By dropping RUN_TESTS in test_struct_ops_multi_args(), the test now silently
passes on any verifier error (such as invalid BTF or a missing map) returni=
ng
-EINVAL rather than validating the exact failure condition. This masks
potential verifier bugs.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 2380b6cbdeadc..8f0744e6075b3 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
[ ... ]
> @@ -1691,6 +1694,18 @@ static int bpf_testmod_ops_init_member(const struc=
t btf_type *t,
>  		((struct bpf_testmod_ops *)kdata)->data =3D ((struct bpf_testmod_ops *=
)udata)->data;
>  		return 1;
>  	}
> +
> +	if (member->offset =3D=3D offsetof(struct bpf_testmod_ops, test_trampol=
ine_stack_args) * 8) {
> +		mutex_lock(&st_ops_trampoline_mutex);
> +		if (st_ops_trampoline) {
> +			pr_err("st_ops_trampoline has already been registered\n");
> +			mutex_unlock(&st_ops_trampoline_mutex);
> +			return -EEXIST;
> +		}
> +		st_ops_trampoline =3D (struct bpf_testmod_ops *)kdata;

[Severity: High]
Can this cause a permanent denial of service in the test module?

This assigns the global pointer st_ops_trampoline to map-owned memory (kdat=
a)
in bpf_testmod_ops_init_member() without establishing a teardown hook to cl=
ear
it if map registration fails after this point. If a failure occurs, the
pointer remains dangling, causing permanent -EEXIST failures for all
subsequent tests.

Additionally, this logic actively rejects concurrent map updates across all
parallel test executions.

> +		mutex_unlock(&st_ops_trampoline_mutex);
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -1720,11 +1735,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_=
link *link)
>  	if (ops->test_2)
>  		ops->test_2(4, ops->data);
> =20
> +	mutex_lock(&st_ops_trampoline_mutex);
> +	if (st_ops_trampoline && st_ops_trampoline->test_trampoline_stack_args)
> +		st_ops_trampoline->test_trampoline_stack_args(1, 2, 3, 4, 5, 6, 7, 8, =
9999);

[Severity: High]
Could this lead to a use-after-free?

This dereferences the global st_ops_trampoline which may point to freed mem=
ory
if a previous map update failed or if a map was concurrently detached. Since
the local ops pointer (kdata) is already passed directly to bpf_dummy_reg(),
is there any reason not to use ops directly here instead of relying on the
global state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831085705.1374=
7-1-yangtiezhu@loongson.cn?part=3D1
