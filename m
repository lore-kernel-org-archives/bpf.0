Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4464AA4
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290689; cv=none; b=m1FeRC6KIRG7JmCuRtI5pymk3fUr85tV8OWJRjfsJYWe3PUKhsn+QsL+LimUG9EUkGEkSYfaqUmbHwo5AiZgNx0Lk5IIyGyvTJLr3H2AqdUi53ZYK++QOL5HGskDFLBrSg2/8VYNvv9S7nRZvwA5rW2ZlWkapaXJu/OuZ6HYRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290689; c=relaxed/simple;
	bh=xaMrsgLn1mGJvnKD+Uw8OG71lAWaPMfIM9vGiuHbHTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bsvDF18AwzkbFevTKvseQXlTJLwMmH1EaJze++jUmkRUxaXQHP7XqJtNOAhhL9To/JV4US8XcrG4+SwA76gzQHG+i+2o5ZPQoaJSaR+fe1UqzeKoPb5dFXT6OXKviiQlzAJ+7GyJXOFKfgNTo372hXHy/Mrg7E/CxRttcjlvTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZa+TqoQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZa+TqoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E7DC2BCB0;
	Sat,  9 May 2026 01:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778290689;
	bh=xaMrsgLn1mGJvnKD+Uw8OG71lAWaPMfIM9vGiuHbHTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PZa+TqoQ89+kH/o5jYswFw5m0lWmCbPhRvFsoR8HZMW8iNtuJfX4p6DvUBCSMBLy3
	 QTHJBu6qNliHL9GXtLmMspwjI7XpBMUhsjpWdaiFKjSHmQFiNYNflZYmKWdaoT7vUn
	 5YCt1W8yGmCZeZms/BScMCbuLyPzT3Q+2PYdp9Btsh1J3hj1TPfokuV2iyu0U8x6WN
	 TtaAnT5SQQx7SIUnTVp5WlL6Dip/HZ6MYEwaFTObnvhlOOZi2UEfWYOL7UHgOBYkMi
	 AtW5Kx7sGJ586ROJmhHxaK/62JyTAShG6WHd9uV3jmaRLBn39rmSrhM09s6QalsYmB
	 8OTbqwyeS9ZNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 19/23] selftests/bpf: Add verifier tests for
 stack argument validation
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213145.1139004-1-yonghong.song@linux.dev>
References: <20260507213145.1139004-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 01:38:08 +0000
Message-Id: <20260509013809.18E7DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The tests in `verifier_stack_arg_order.c` are never executed bec=
ause the file is not registered in the selftests runner.
--

commit 6834becc44d439e99d840e596d30164699006d53
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add verifier tests for stack argument validation

This commit adds new BPF selftests using inline assembly to validate the
verifier's logic for stack arguments. It covers positive tests and various
negative tests for verifier rejection and pointer/reference tracking.

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index a96b25ebff234..aef21cf2987be 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -91,6 +91,7 @@
>  #include "verifier_sockmap_mutate.skel.h"
>  #include "verifier_spill_fill.skel.h"
>  #include "verifier_spin_lock.skel.h"
> +#include "verifier_stack_arg.skel.h"

Did you intend to include verifier_stack_arg_order.skel.h here as well?

>  #include "verifier_stack_ptr.skel.h"
>  #include "verifier_store_release.skel.h"
>  #include "verifier_subprog_precision.skel.h"
> @@ -238,6 +239,7 @@ void test_verifier_sock_addr(void)            { RUN(v=
erifier_sock_addr); }
>  void test_verifier_sockmap_mutate(void)       { RUN(verifier_sockmap_mut=
ate); }
>  void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill)=
; }
>  void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock);=
 }
> +void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg);=
 }

Could this be missing a RUN(verifier_stack_arg_order) entry?

The patch introduces the new tests for load ordering validation below,
but without registering them in the selftests runner, it looks like
they will not be executed.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c=
 b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
> new file mode 100644
> index 0000000000000..671c79969c6cd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D19
