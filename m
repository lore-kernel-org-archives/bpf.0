Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806893;
	b=D+E3AMdGQ6PqmxiA2G83dZkesYbRxeQNuvBw9KMtxIZPIDbERCn1RQEHyV4N3rI79auY
	 HsUg/lwTqdlrd/sy75ih/vKy4Y42M8wIaQSK32LvjVqHbYC7EHRmxBKWNVLqOqaTh4gee
	 6uyMEMzAxzRsJOPQqJG4ELQR480fuHO93OD+kp8NoWQngVQrw0LPjs9jQxk56TtTJYatM
	 0ruRmPoaTNdjSaRjqEyWGZngmTUyN3cCsU5tYjPotH9ryfJF+pBzCpJXFEzUMpjZhIV4o
	 Lxil54ZOOGf8zW6ozS/NlxKaDA58BgcxFwEnQMy8Cv7eMTBn+T5dUQgXC58WHmdc3pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sVy1DLt8tqxiA0mD3KYuViL2ycpG4LNnv4DdzQGd/N0=;
	b=IkEF+xL4UWavM8msdC9KdhIEdDHbnG1wxCvcL8Xcyuq7IiFrNGHeex9CDa9stQX9Btj7
	 fsVr5EYdIoJ2ZXmDv3Z5C0F4zbPHs2aOmr582JRonrDIFU6TkNUCWqjAMisJcfn5+pVrT
	 szOnfHK9wMkl3WBM4NiU9PRdHVuGeoWwEpOV6Csa9L7BogLxp9wHnZw9wZUHm3R/3k8le
	 nvvPfcVh++w9U2M59/tOdyhzcDllVah0PZE1uvTIXOWVo715ZDohRh/wt6+R643tRC3Qx
	 V1r0haxFsDUE7EjhhE7RqVtUr63a0+9w+jLrMz7AjcIjXjQbYJzk88GAjq5i3/pARLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNspuK2z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29452606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNspuK2z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4941F01825;
	Sat, 24 Oct 2026 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792806892;
	bh=sVy1DLt8tqxiA0mD3KYuViL2ycpG4LNnv4DdzQGd/N0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gNspuK2z+sn+bEGBg9F1v4o2EKizksrbH8X0LrzCYWYYSKihvVKmz0vYBDFMqNuJs
	 bpr7WNHCXqFye0EUO5GCMu2OoY5Vzkp0dJCChISJMNXTOJ92Q5p6EW3sLQ+M/WFLsJ
	 uUTAg6/nn6v1NftchY/+RxXH83zOCbo+T9pZAFYvFi9LrdHotFoI8d8ENMkR7xA4bS
	 Nurtra7VgVTTWXqCXoQH5os7QjweYpNdH9i+rXtSMcrUWaTjT6TWcJpLKE8WuGkioe
	 CrQn1cWRJv2QbdDNOzgzS4PK1gf28AUU62xlVpc6622ikRjjh8pENSZKKe5efwRBD2
	 eDmIRjzL2GG3g==
Message-ID: <sashiko-outbox-183497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 5/7] selftests/bpf: Cover BPF program load
 strategy transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org
In-Reply-To: <20261024014514.2959514-6-andrey.grodzovsky@crowdstrike.com>
References: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
 <20261024014514.2959514-6-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 01:54:52 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: redundant standalone load_type test duplicates autol=
oad test
--

commit a706cefdc370f05d909294879af1c74efbca1c5c
Author: Slava Imameev <slava.imameev@crowdstrike.com>

selftests/bpf: Cover BPF program load strategy transitions

This commit adds a standalone load_type selftest covering BPF program load
strategy transitions between disabled, auto, and manual modes,
bpf_program__set_autoload() compatibility, and the manual load and attach
cycle after the object is loaded.

> diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/t=
esting/selftests/bpf/prog_tests/load_type.c
> new file mode 100644
> index 0000000000000..7e344c0b04450
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "test_load_type.skel.h"
> +
> +void test_load_type(void)
> +{
> +	struct bpf_link *link =3D NULL;
> +	struct test_load_type *skel;
> +	int err;
> +
> +	skel =3D test_load_type__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_load_type.c b/tools/t=
esting/selftests/bpf/progs/test_load_type.c
> new file mode 100644
> index 0000000000000..3d9b81691d7ad
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_load_type.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +bool prog1_called =3D false;
> +bool prog2_called =3D false;
> +bool prog3_called =3D false;
> +
> +SEC("raw_tp/sys_enter")
> +int prog1(const void *ctx)
> +{
> +	prog1_called =3D true;
> +	return 0;
> +}

[Severity: Low]
tools/testing/selftests/bpf/prog_tests/autoload.c and
tools/testing/selftests/bpf/progs/test_autoload.c already exist in the same
directories to test bpf_program__set_autoload() and selective program
loading using prog1, prog2, prog3 and prog1_called, prog2_called,
prog3_called:

tools/testing/selftests/bpf/prog_tests/autoload.c:test_autoload() {
	int duration =3D 0, err;
	struct test_autoload* skel;
...
	/* don't load prog3 */
	bpf_program__set_autoload(skel->progs.prog3, false);
}

Since bpf_program__set_autoload() is a thin wrapper around
bpf_program__set_load_strategy(), and commit ("selftests/bpf: Cover BPF
program manual loading") in the same series also adds
tools/testing/selftests/bpf/prog_tests/manual_load.c and
tools/testing/selftests/bpf/progs/test_manual_load.c with the same
prog1, prog2, prog3 raw_tp/sys_enter programs and post-load manual
load/attach sequence in manual_load_verify_main_cycle(), could these
bpf_program__set_load_strategy() transition checks extend test_autoload()
in prog_tests/autoload.c or be consolidated as a subtest in
prog_tests/manual_load.c instead of adding standalone prog_tests/load_type.c
and progs/test_load_type.c files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024014514.2959=
514-1-andrey.grodzovsky@crowdstrike.com?part=3D5
