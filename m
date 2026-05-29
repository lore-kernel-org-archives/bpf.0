Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB6340402
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021768; cv=none; b=nyt/h8UIiZs8naQGuKPErziHGZfnr13B3moWerlMP7KU1c0Ykk4v6EhjbApjLk5v67ehSmMHC6VUSyBnnMdU/jxLaAAd4c5k13Qtv7HlQ1oDeGr63dfzZbVwEf3fcvs90SNXCd64piIT4Dz4MCXB1c5Aez2d76Sx3dUGa3ztPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021768; c=relaxed/simple;
	bh=qWg2frpAZt8l1Zul6DzO16a2HG9D85OXlWC8L5G46As=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sxow11dwNDV+m6KXnQcEkTfyHkUdK9NWiPzhdD/+U7DhTZqhr0PWINkwVbY7tgPRs4wSPZeicOPzTOEtVkIJf4Mac7IgdsG+4s0f5xnlypLQRXYfOF2Wr4U9+tYNdDdfxXl3Aa7krmb3/lPuL+zPWBY82NBdSVTVue+AfQVnMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRg8m4JE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRg8m4JE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A551F000E9;
	Fri, 29 May 2026 02:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780021766;
	bh=kEewS98WkIVwnlb1nuJC70XVdGM3QrEjNUZO7KNg8HA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CRg8m4JEFmbk6aathHke+uNXn4Xn7l9mAE7rCPMUKRpV1J47Jh65xdrS5Ork9EizX
	 k7MQPh8QnTW6XP6O3+5TaIwyaCj2wIMpDVHPKibG6pjoa6aXdBr+qDdSgK/gQq7DZF
	 ZItoTKb7bUe7kWSKz8AqAAbw0/R45MpBNt71v++nD24PfAp/Ia47a2KjJBMs5co1uY
	 c5nVyFhcynkG30cCXaNV8AMlaCN9vjP3FQqqtDplR+29kgp3dDzGDVqAYTXvn4eDBY
	 YbCtvAKJ87zQ7ksDCpjow4uDs+g6h/Hyn1Fv450sSODPfSXDpnO4tvbfCu6KS2ROGA
	 PjvPEfwfQPnBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 11/13] selftests/bpf: Test using slice after
 invalidating dynptr clone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529014936.2811085-12-ameryhung@gmail.com>
References: <20260529014936.2811085-12-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 02:29:25 +0000
Message-Id: <20260529022926.39A551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit adds #includes and RUN_TESTS calls for three new BPF ske=
leton headers, but completely omits the corresponding .c source files, caus=
ing compilation to fail.
--

commit 3e0cbdc36c0aac54acdb8e69cb8a14baf7548c43
Author: Amery Hung <ameryhung@gmail.com>

selftests/bpf: Test using slice after invalidating dynptr clone

This commit adds a test to verify that invalidating an original dynptr does
not prevent a BPF program from using a slice derived from a cloned dynptr.
It adds the new test program and updates the bpf_qdisc test suite to run it.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/t=
esting/selftests/bpf/prog_tests/bpf_qdisc.c
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> @@ -8,6 +8,10 @@
>  #include "bpf_qdisc_fifo.skel.h"
>  #include "bpf_qdisc_fq.skel.h"
>  #include "bpf_qdisc_fail__incompl_ops.skel.h"
> +#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
> +#include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
> +#include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"

[Severity: Low]
Does this break the build when compiling this specific commit?

The corresponding source files for these three headers are not present in t=
his
patch, which will cause a build failure. It appears these files are actually
added later in the series in commit f9d9931d5afe8f4e515a543c5a58e4dec2ad1899
(selftests/bpf: Test using dynptr after freeing the underlying object).

Could these includes and their associated RUN_TESTS() calls be moved to the
later patch to ensure the tree remains fully bisectable?

> +#include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"

[ ... ]

> @@ -223,6 +227,10 @@ void test_ns_bpf_qdisc(void)
>  		test_qdisc_attach_to_non_root();
>  	if (test__start_subtest("incompl_ops"))
>  		test_incompl_ops();
> +	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
> +	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
> +	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
> +	RUN_TESTS(bpf_qdisc_dynptr_use_after_invalidate_clone);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529014936.2811=
085-1-ameryhung@gmail.com?part=3D11
