Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F90946EC69
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590465; cv=none; b=BecRHRAJ/YEwh4TaNtMz0rmqxa/55cYRsL5nKhPkYcmehaWOsX2LN5+x7H/NAefi3bN+QHnFAgm4tBS0Cad2OriUmC2KeRSliENhy5qXOl7bPDxEZADqU+a70oCoI23vSQWZ1AEkH2svvUswXjKta4GVS7BLy7urxwXdZlqPMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590465; c=relaxed/simple;
	bh=z5caGpnSLZcZyv/oL9Xzb96iC4DLRdrttzTfOksp8M4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XMNGkBSNH10MGUS38apoZ4VVRzBxIJN9k0jxbQlAx+I3SoGDFMhSfON2DztzA/hB2JSdPbhOayLLQcFZp7fbLupLBV5f1ZNmdjm+ZAOs/3wYEFr3l8TDcTol30ExlE1nfJOmpxdzfKQEFwG6wO4RodJA6S1CJoEFk4wMtfvY0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX0md6cF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX0md6cF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10901F000FF;
	Wed, 16 Sep 2026 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789590448;
	bh=Lf6tFSqEBUW/qIiT62YS7vILvUdd3s2GbGvO2rDO1lo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SX0md6cFn2DfDmZqOHshgqSxuOSdIqzk51xIYZiu+yaxGiZAJh3XsNa+ujpOTe+NP
	 y6/pPR6DVI2ALlecuBgEAnszFBq9/7/rCtoCiCrmQkNJFyEz3DZrD1of0/XC1HdTza
	 hOrPwnak1OmI4wAxfLUe1neeRi4f6xVHCh3CZTbYVaMQ4thzLENBPrJiEkBGw49rRV
	 9hSm8Kq321hblUM5b2gVGZSwrGSi3pfaUAqLTTAHk3+60E3Q1fTzlw3Z9xCa14nn+u
	 BUUKBIL4zILra3ziWidhMYV1ZKKvIlfNwMEBOKRlQ9A0RAjjX5B7hw3AZ8q8tRTwaE
	 WR4QneZzTFV+Q==
Content-Type: multipart/mixed; boundary="===============6553350345123458605=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8c46a2c0328cd0f42c01d0b21aa47f8e9d6304474eea35f87ac0dc0a21023f95@mail.kernel.org>
In-Reply-To: <20260916192805.3991983-4-memxor@gmail.com>
References: <20260916192805.3991983-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] selftests/bpf: Cover generic __uninit output initialization
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 20:27:27 +0000 (UTC)

--===============6553350345123458605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 7732df9bc8701..4a9affe81ee16 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -55,6 +55,7 @@
>  #include "verifier_iterating_callbacks.skel.h"
>  #include "verifier_jeq_infer_not_null.skel.h"
>  #include "verifier_jit_convergence.skel.h"
> +#include "verifier_kfunc_uninit.skel.h"
>  #include "verifier_kfunc_packet_access.skel.h"
>  #include "verifier_ld_ind.skel.h"
>  #include "verifier_ldsx.skel.h"

This isn't a bug, but the include placement breaks the alphabetical
ordering that the rest of this list follows - "kfunc_uninit" sorts after
"kfunc_packet_access", so should this move one line down?

> @@ -221,6 +222,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
>  void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
>  void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
>  void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
> +void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
>  void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
>  void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
>  void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }

Same ordering question here - should this also move down one line to
maintain alphabetical order?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index fd2c0cdc91b18..dfffbdff06fa9 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1316,6 +1316,27 @@ __bpf_kfunc void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
>  {
>  }
>
> +__bpf_kfunc void bpf_kfunc_test_uninit_struct(struct prog_test_pass1 *out__uninit)
> +{
> +	out__uninit->x0 = 1;
> +	out__uninit->x1 = 2;
> +	out__uninit->x2 = 3;
> +	out__uninit->x3 = 4;
> +}
> +
> +__bpf_kfunc void bpf_kfunc_test_uninit_mem(void *out__uninit, u32 out__sz)
> +{
> +	memset(out__uninit, 0x2a, out__sz);
> +}
> +
> +__bpf_kfunc int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in)
> +{
> +	int value = get_unaligned(in);
> +
> +	put_unaligned(42, out__uninit);
> +	return value;
> +}

This isn't a bug, but bpf_kfunc_test_uninit_alias() uses
get_unaligned()/put_unaligned() which are new to this file. They currently
resolve via a transitive include chain (linux/filter.h -> if_vlan.h ->
etherdevice.h -> unaligned.h). Should <linux/unaligned.h> be added to the
include block so the file doesn't depend on that chain?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35141528669
--===============6553350345123458605==--
