Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637152AE7A
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787891797; cv=none; b=CI5jD6mIlQ5e8/Wu1sqZw5iUeBak0GLvEWbaz6ERa/7aWYRseVgqtltU4XjbQ3xDZrJ7TuNUXpaJOARwME8at8P7Rnc6wavRCCfEXha+sAWhyMtO1jDk/47mjSp0bWCph0jE/1bplBaRFDx5xhbaB24n6HpxwdSgtwvGlAuYFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787891797; c=relaxed/simple;
	bh=YrFuU2FKlhYzYKcFpV5zfxa09RrzzTXdx33jyuw2sH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KALt4NCD28nBC0bWEqehUVFwctEP3fwPGWhH2oBy78ZpKI+mvZPEcx0HgB02Ul5MhCmAWRo4eQMPjGWkxlorDmH8YW+P2Xpn4EXiASWlPcMt7nQfBmDehIJ8VnCPZ9hrU5NA0vMJfexbrbahfZfA6RaqNRFNr2tym4UuYW+dBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mutNbNnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mutNbNnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16DC1F000E9;
	Fri, 28 Aug 2026 04:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787891796;
	bh=g7pdXT3c9vmi9zIIfZvkU9Cb6fBbdCK720TN1rEWBMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mutNbNnUQqfso2Uj7gkYgoahwGBcKw0zUb2gR25Oel3uy34nAH+Esh8pbtfazRsAG
	 g9tqsncyf/Ltj5V19cVIq1QHHoLSW8TMS6DVYbw0ZUMKKk08FBwaxsZRYykfh/779S
	 lhwcVTK3cDEer4ZW96VjJbzKTc0M+tRsUKb2APjkVkTeobXTnxbIjx0Nw32OAoqPAT
	 H/zkalulAtb2guTMfiz4q4CFxjCnBvQRMhb/wDhqWcvjRoqgrWU4zHDjPT1eIhyWxy
	 B+g1BaqwKf1/bNo57IDVsyYwarWMIPpnAI8dbPoFjOHpQAQRwaEZbIY9udqEiEdZcm
	 Tfk3pDhNPBcMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add test for indirect
 struct_ops trampoline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260828042715.16546-1-yangtiezhu@loongson.cn>
References: <20260828042715.16546-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 04:36:35 +0000
Message-Id: <20260828043635.D16DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free and data races due to statically assigned and uncle=
ared struct_ops pointer.
--

commit 23e6150eb62c7059e7721142219a9a87264e2e46
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Add test for indirect struct_ops trampoline

This commit adds a test case to verify that arguments passed on the stack
are correctly read by the indirect struct_ops trampoline. It ensures the
correctness of stack offsets on architectures like LoongArch and RISC-V.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_tramp=
oline.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline=
.c
> new file mode 100644
> index 0000000000000..5a21aedd02fc5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "struct_ops_trampoline.skel.h"
> +
> +#if defined(__loongarch__) || defined(__riscv)
> +static void run_struct_ops_trampoline(void)
> +{
[ ... ]
> +	bpf_link__destroy(link);
> +cleanup:
> +	struct_ops_trampoline__destroy(skel);

[Severity: High]
Does this call to struct_ops_trampoline__destroy() free the map?

Later in this diff, we see that st_ops_trampoline in bpf_testmod.c is
assigned dynamically allocated memory from this map. When the map is freed
here, st_ops_trampoline appears to become a dangling pointer.

> +}
> +#endif

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 850cf4f830c48..be96bbc1b7c04 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
[ ... ]
> @@ -637,6 +640,9 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
> =20
>  	bpf_testmod_test_struct_ops3();
> =20
> +	if (st_ops_trampoline && st_ops_trampoline->test_trampoline)
> +		st_ops_trampoline->test_trampoline(1, 2, 3, 4, 5, 6, 7, 8, 9999);

[Severity: High]
Since st_ops_trampoline is never cleared after the map is freed, could this
result in a use-after-free?

Any subsequent or parallel test in the suite that triggers
trigger_module_test_read() will invoke bpf_testmod_test_read(), incorrectly
evaluate st_ops_trampoline as valid, and dereference the freed memory.

> +
>  	struct_arg3 =3D kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
>  				sizeof(int)), GFP_KERNEL);
[ ... ]
> @@ -1619,6 +1625,10 @@ static int bpf_testmod_ops_init_member(const struc=
t btf_type *t,
>  		((struct bpf_testmod_ops *)kdata)->data =3D ((struct bpf_testmod_ops *=
)udata)->data;
>  		return 1;
>  	}
> +
> +	if (member->offset =3D=3D offsetof(struct bpf_testmod_ops, test_trampol=
ine) * 8)
> +		st_ops_trampoline =3D (struct bpf_testmod_ops *)kdata;

[Severity: High]
Is it safe to unconditionally assign this global pointer to the map's
dynamically allocated memory during initialization without setting up a
cleanup mechanism?

Additionally, this assignment appears to occur without locking at map creat=
ion
time, meaning parallel test runs could race to overwrite this pointer.

> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828042715.1654=
6-1-yangtiezhu@loongson.cn?part=3D1
