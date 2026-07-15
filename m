Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE048AE2B
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130903; cv=none; b=O6ICbGsUhmptx52tcmzmg0zcXS+BvEb0JkoZGwyeLJhduAFX9VuTiVHe/hH84AN/wvGnvyhSuOIwOh3ePTctRhBly4w6ljYjlPIahnMf1PK/SXDdbIAAdgrephQKuasHTeJ5kpguftrBLYKAjlKDtxD/BTBvdhk335OYE/eJ6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130903; c=relaxed/simple;
	bh=kAhvEIViAkC+5ZqCW92kwKzeea6/VXeP6+ess1LAPgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qgj+r7GxN0QuZ1d0SS04OEWBvSK3jFJVWoX2A6Nj+U3wuuxnVx0KaOilerZApp5QL5FhuyIz+UhKxDct4gPxuVbPhM9C6p+R0m+JRGrGdWo+R6w+YA1T+kieY0JPsHd4yA9iLfbdoL4RmhMRq+mFuqsG4+COCUFR6Iv1up6/OKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n851PkYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n851PkYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C5F1F00A3D;
	Wed, 15 Jul 2026 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784130902;
	bh=sGvOfqES3LVzQe/KY6jYUXJdg6uBVeI36z/uMPtvVpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n851PkYkp/vvV1Rx0jNhMI6NXzhlXYwbm9l0bueG8Tx2c+01MkyjjP1Scf2f0ZNfH
	 bjqWkVyJBRCGU8F9WCRIxOZ6y0QRYtYvk91DjXPG1isag3bjDgfxWedYadp6S9nY8C
	 t2p0LHTFPm215lLgfoFB9+64ovuEpJTks22b/JxITQ3SGd5IMLXM/zQrlQcE8NtbOq
	 InXrsZaLNDwvSuKNrghv2AZfhdUHpWSqWi4NqEwXNZN8O59txuOG2+SIzIuU0WUCNF
	 hAq84qnjls2hBFwwckY4g8qfDmvQPgLh6NnLAlMAlNDArIpv47ish5sbHOycby9yI3
	 OfBl7HhMkQmeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 6/9] selftests/bpf: Add tests to verify
 global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715153254.92010-7-leon.hwang@linux.dev>
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-7-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 15:55:01 +0000
Message-Id: <20260715155501.C8C5F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `test_global_percpu_data_subskel` selftest fails uncondition=
ally because it asserts `var_cnt > 0` on a subskeleton that is generated wi=
th zero variables.
--

--- Patch [6]: [PATCH bpf-next v10 6/9] selftests/bpf: Add tests to verify =
global percpu data ---
commit c5a32c0630bc8d9b3aedfc264c75289a1f8e6d98
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify global percpu data

This commit adds selftests to verify operations on global percpu data in BPF
programs. It tests various libbpf APIs and skeleton behaviors for percpu
maps. It also adds a test to ensure live variables of a subskeleton do not
include global percpu data.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel=
.c b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
> new file mode 100644
> index 0000000000000..8aebd533d86b5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
> @@ -0,0 +1,37 @@

[ ... ]

> +	if (!ASSERT_OK_PTR(subskel->maps.percpu, "maps.percpu"))
> +		goto out;
> +	ASSERT_EQ(bpf_map__type(subskel->maps.percpu), BPF_MAP_TYPE_PERCPU_ARRA=
Y,
> +		  "percpu_map_type");
> +	ASSERT_GT(subskel->subskel->var_cnt, 0, "var_cnt");

[Severity: Medium]
Since test_global_percpu_data.c only contains variables in .percpu* section=
s,
and the subskeleton generator skips percpu array variables, will var_cnt
always be exactly 0 here, causing this test to unconditionally fail?

Would it make sense to either add a standard global variable to
test_global_percpu_data.c (e.g. in .bss or .data), or adjust this assertion?

> +
> +	for (i =3D 0; i < subskel->subskel->var_cnt; i++) {
> +		const struct bpf_var_skeleton *var;
> +
> +		var =3D (void *) subskel->subskel->vars + i * subskel->subskel->var_sk=
el_sz;
> +		ASSERT_NEQ(var->map, &subskel->maps.percpu, "var");
> +	}
> +
> +out:
> +	test_global_percpu_data__destroy(subskel);
> +	bpf_object__close(obj);
> +}

> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c =
b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> new file mode 100644
> index 0000000000000..54380dfb11a5a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +int unused SEC(".percpu.looooooooong");
> +int data2 SEC(".percpu.data");
> +int data SEC(".percpu") =3D -1;
> +int nums[7] SEC(".percpu");
> +char run SEC(".percpu") =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715153254.9201=
0-1-leon.hwang@linux.dev?part=3D6
