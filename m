Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3E3B6C0E
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 02:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031019; cv=none; b=CfjFhDJTw5RWTIfp2uQL7cApnPzwDljo+h8Kn6MjyD1wDYzDedV3Yo6vrILpiDPv8ZWlew4qHWwJhEJXI7G2Xejf0ekAbgGuGz9kFXubHBIBw5mhCVatpsJmtX5K4JJmc5q7vpBJtxYW4o1FN42iq/IJt9v4Dx9wkwTXAvfmJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031019; c=relaxed/simple;
	bh=mC3nudLPrjM6WRt7shbO4oTgaNvbA+nyF2WGUhKktXk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Mjm6S1BmCi9+cYNYBLt6VGMQAIIPUIwOmtKj6520EavXxkCAEMfUEQeNsviWzXAkaMIE52Jx2my062zmdpPZf7WTse1/KuzrVz5RJmKvmBxTaGecppvehY3NblpK4OtIK8nGnvP285YxhlRJ0NjlZr3N9VAxbNxgXA8HVJShNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnVHRAhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnVHRAhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C891F000C4;
	Thu, 15 Oct 2026 02:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792031018;
	bh=ynWpw2DZsdJ2j8gFvl++6JNfnWhfoGbfsuba6rQmEaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnVHRAhKt+lqsCcMQS9S9Y+ZhThK2SWl9X9wAUkHL1L2PNAkskRhjJgLN7GKlLZry
	 CEaC9wb8mI1DCxHqKINfbtqQrx+41OTtkGMdcwPse8LbvolnLZdVovqFzfzwnPS8Mi
	 FOPs3oACtcwQuV1uwXTgxgDN4kagf7CBNxH/ZlsycNF0lYiLBy2FwLuKWjWxnynns1
	 qiZNsrs6ImLZodYifCp/7v22qBJtLno5bK6K09TFhQCt0yoY+DYOB3DMvZyGvgiIrn
	 UY4JMUccVyvXXCdzQqN5XK4fWUI3VmhgjS48nEjhbi30o+kRftMYDpxA1fX7XNo/iu
	 5UyE6pwv9ckGw==
Message-ID: <sashiko-outbox-172145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add a runtime test for
 private stack and stack arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261015021238.5657-4-cp0613@linux.alibaba.com>
References: <20261015021238.5657-1-cp0613@linux.alibaba.com>
 <20261015021238.5657-4-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 02:23:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: test flakiness due to parallel struct_ops attachment
--

commit 30217e3723f8427977b857ce4b668a913d8e6da3
Author: Chen Pei <cp0613@linux.alibaba.com>
selftests/bpf: Add a runtime test for private stack and stack arguments

This commit adds a runtime test for combining private stacks with outgoing
stack arguments. It validates the structural layout via disassembly patterns
and checks runtime execution context across CPUs. It also includes a
struct_ops test to act as a kernel stack control case.

> diff --git a/tools/testing/selftests/bpf/prog_tests/private_stack_runtime=
.c b/tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c
> new file mode 100644
> index 0000000000000..3af24ca8009f4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "private_stack_runtime.h"
> +#include "private_stack_runtime.skel.h"
> +
> +void test_private_stack_runtime(void)
> +{

[Severity: Medium]
Will this cause test flakiness in CI due to parallel execution?

The test function lacks the serial_ prefix, so it will run concurrently in
the test_progs worker threads rather than in isolation.

[ ... ]

> +	ASSERT_GT(tested, 0, "tested_cpus");
> +
> +	ops =3D bpf_map__attach_struct_ops(skel->maps.zero_stack_ops);
> +	if (!ASSERT_OK_PTR(ops, "attach_zero_stack"))
> +		goto out;

[Severity: Medium]
Since zero_stack_ops targets the singleton bpf_testmod_ops3 in bpf_testmod,
executing this concurrently with other non-serial tests that attach to the
same struct_ops (such as test_struct_ops_private_stack) can cause random
-EEXIST failures.

st_ops3_reg() in bpf_testmod.c enforces a single active attachment:

    if (st_ops3)
        ... err =3D -EEXIST

Could this function be renamed to serial_test_private_stack_runtime to avoid
resource conflicts with other tests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015021238.5657=
-1-cp0613@linux.alibaba.com?part=3D3
