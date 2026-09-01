Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E41407590;
	Tue,  1 Sep 2026 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285336; cv=none; b=McbUsepePaD+H043nOXIWPvyQYUEHgofQD46GT73TurFNvi3vcrx3ZHcNV9Jj+f30VILntK49jV+zk9YPlWpNFXt/d3sNvMqbaTZBRx0H1NgahbWzPr0OiDzzOuWN/91btQKIYxf6jZ2cqe8mpOLgwVYExKyp90FIWVmrco0dks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285336; c=relaxed/simple;
	bh=sLsyVKjCOsbOwfs0ZWj6TUW4UMPnJlMpEhJ2zg8Weko=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kE9MnMafByLnMyrbjfaOJagmQ5HET38HRFhi5cqwQSvQNZvZuWLiUxESj7YIkLGDtw5HdDHSg1Z/gKsD62KdlDGYEH1i7YKDqQt6c1386dzWUpxytd8aflkV0vz1ftbiN4iOb9kwUAv91IKID1p+H49wEw9DCnH2VfOgdsVi038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PB/PVsWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB/PVsWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072CF1F00A3D;
	Tue,  1 Sep 2026 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285335;
	bh=BpUDJcUbsLdX+wGlpzo6I/ykfm2/n0t0iz+YN1wVgxI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PB/PVsWGoufVlPoxSn3LDZP97Dh6x+LoogwnwDekn9OKNGfVp3eLNPXGnht+oEDZy
	 OehUngPe9n19MEBf/uMEb8mpp/LB1RiRBh8IRiIlBdNECA3T0/1fXeT60cN20JUeaw
	 4Sme6xFv81QExN5UETdbIyeH9rEAZMJvOKftsgesgPH7l40OuKo3anbKaZnU2sDs93
	 JzD6NHXf8WoriCl0HtA2Udg7/6bxv9BhAUILNj8g2+8LIeMfA9RQo7kzYMpH9Yn3kN
	 uUhOPYxV8KnCzutqlaejMEJdJRu9qUtSJjvnq/lAsa+UgZ6q2uHr2Ewk163sJVRRKy
	 cgoWLlmFLaPvw==
Content-Type: multipart/mixed; boundary="===============1976455805660586543=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a0d7493495b2eb2f49002916c4d38e1451f8c03bc574092e92a26ac01336991@mail.kernel.org>
In-Reply-To: <20260901165757.801449-7-alan.maguire@oracle.com>
References: <20260901165757.801449-7-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 06/18] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 17:55:33 +0000 (UTC)

--===============1976455805660586543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit e7a800a771162d1c8e3c4ae6c2032fa58e5ba5d9
> Author: Alan Maguire <alan.maguire@oracle.com>
>
>     selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
>
>     Ensure that location params/protos are deduplicated and location
>     sections are not, and that references to deduplicated locations within
>     location prototypes and sections are updated after deduplication.
>
>     Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

The commit message states that location sections are not deduplicated,
but the test contains only a single LOCSEC and no second LOCSEC to
merge against.

A single LOCSEC survives dedup regardless of whether the
btf_is_locsec() exemption exists in btf_dedup_new(), since there's
nothing to dedup it with. Adding a second .locs LOCSEC with identical
contents (or an identical btf_loc record) and asserting both survive
would directly pin the self-canonical branch for BTF_KIND_LOCSEC.

The test does still catch total breakage, because BTF_KIND_LOCSEC has
no case in btf_dedup_ref_type() and would hit its default return
-EINVAL if it were not self-canonical, which would trip the
ASSERT_OK(err, "btf_dedup"). However, that doesn't distinguish "LOCSEC
is exempt from dedup" from "LOCSEC had nothing to dedup against."

Would a second identical LOCSEC better verify the "location sections
are not [deduplicated]" claim?

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> index 9d6161151593..34ca20f88afd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c

[ ... ]

> @@ -554,6 +554,113 @@ static void test_split_module(void)
>  	btf__free(vmlinux_btf);
>  }
>
> +static void test_split_loc(void)
> +{

[ ... ]

> +	btf2 = btf__new_empty_split(btf1);
> +	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
> +		goto cleanup;
> +	btf__add_loc_param(btf2, 8, BTF_LOC_PARAM_REG);
> +	btf__add_loc_param_value(btf2, 1);		/* [8] loc reg 1 */
> +	btf__add_loc_proto(btf2);			/* [9] loc proto */
> +	btf__add_loc_proto_param(btf2, 5);		/* param value */
> +	btf__add_loc_proto_param(btf2, 8);		/* param reg 1 */
> +	btf__add_locsec(btf2, ".locs");			/* [9] locsec ".locs" */
                                                        ^^^^

The type-ID annotation on this line is off by one. The comment says
/* [9] locsec ".locs" */ but [9] is the LOC_PROTO added three lines
earlier (also annotated /* [9] loc proto */). The LOCSEC actually gets
ID 10, as the VALIDATE_RAW_BTF block immediately below states:

	"[10] LOCSEC '.locs' vlen=1\n"
		"\tfunc_type_id=4 loc_proto_type_id=9 offset=128"

Traced against the builders: btf2 is split on top of btf1 (7 base
types), so btf__add_loc_param() creates [8], btf__add_loc_proto()
creates [9], and btf__add_locsec() creates [10].

In this file the /* [N] ... */ trailing comments are the only mapping
from builder calls to the expected raw-dump lines (see test_split_simple),
so a duplicated index misleads anyone updating the expectations.

Should this read /* [10] locsec ".locs" */?

> +	btf__add_locsec_loc(btf2, 4, 9, 128);
> +
> +	VALIDATE_RAW_BTF(
> +		btf2,

[ ... ]

> +		"[10] LOCSEC '.locs' vlen=1\n"
> +		"\tfunc_type_id=4 loc_proto_type_id=9 offset=128");
> +
> +	err = btf__dedup(btf2, NULL);
> +	if (!ASSERT_OK(err, "btf_dedup"))
> +		goto cleanup;

[ ... ]

> +cleanup:
> +	btf__free(btf2);
> +	btf__free(btf1);
> +}
> +
>  void test_btf_dedup_split()
>  {
>  	if (test__start_subtest("split_simple"))
> @@ -566,4 +673,6 @@ void test_btf_dedup_split()
>  		test_split_dup_struct_in_cu();
>  	if (test__start_subtest("split_module"))
>  		test_split_module();
> +	if (test__start_subtest("split_loc"))
> +		test_split_loc();
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============1976455805660586543==--
