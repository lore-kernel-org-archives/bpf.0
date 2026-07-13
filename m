Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07201320CBE;
	Mon, 13 Jul 2026 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911339; cv=none; b=DE9hTsSJs9pMejKnkT+XnFxwn0jKXJe7VrwZjuj5as5zigiJCN58fR+wZ1dNvMl+bJhbcVNQtTEDIa2JszegOmBOMJinOPRDLZ+4KUgI2zhZh7g5W3GWs8TK8cIZjkllh8jtEKTu2grtLuUCcWNV9M+8bJLNgz3xy+6Zi2MmQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911339; c=relaxed/simple;
	bh=nsDmopJv61ZtdkJuevuFBgL/0ghQZkO95M/waHmtZmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FfvXmOKq8cu3Q+wyL6hGLmzwYbP+tS4zIQl7Srvn535kPgH4k5xaXfLxA4nrwGfPkaysDYchgu1YQIPvI/j9aD3cApLG9QbdiUU/G0EV3yzxpTHvAN07v1JOXHC8zTZOmMyUG4XHzlfOL0F32hG/A3nRgHv13w3o3E+GshItB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WslQGV4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WslQGV4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510321F000E9;
	Mon, 13 Jul 2026 02:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783911337;
	bh=MwznUtjF0twSqnfMAiTA/YGoecULIgGDrdCEF38rAbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WslQGV4RN2Ekh1WScACchA1kvSsQjFqXIzX0cte4ojfdsQBi8WXNeJ4p/CXRJ1Xeh
	 DmFBmpHw0GHfqwyqfGxvFQ+9NsgPIwX1yGW8QnmqVg38AVJeYhkXR1DMEYTMEbFWxJ
	 WzdKOCuvItTL2+K4TuMHPk2fRBa69ZwUgOXzI7RsgEfmJqMWqNr1ddhylrHk58Fi5l
	 ek5Km+yJTIJGkAAYnWLDpGGHCiQmDldOQKMqr4k07CSW51v1N70KYoyzStjf0TZ5ot
	 jlPBhWwm0bkcDfD/t7KYi8IvYQBI+OvDZs/il9F7YbzomKyv02iZLmuPQ2Nef01bj3
	 sp+9uj0caCR6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHSET SLOP RFC 4/6] selftests/bpf: Add struct_ops __arena
 argument tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260713024414.3759854-5-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
 <20260713024414.3759854-5-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 02:55:36 +0000
Message-Id: <20260713025537.510321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments in BPF-related code must have the opening `/*` =
on its own line.
--

--- Patch [4]: [PATCHSET SLOP RFC 4/6] selftests/bpf: Add struct_ops __aren=
a argument tests ---
commit 9e21274b1ecab24a7e9f15aad54b02d04ae38d78
Author: Tejun Heo <tj@kernel.org>

selftests/bpf: Add struct_ops __arena argument tests

This commit adds tests for struct_ops members with an __arena argument.
It creates a callback, forwards an arena pointer through a kfunc, and
verifies the read/write access as well as attach rejection for programs
without an arena.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena=
.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
> new file mode 100644
> index 0000000000000..75a3a649060cf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
> +#include <test_progs.h>
> +
> +#include "struct_ops_arena.skel.h"
> +#include "struct_ops_arena_fail.skel.h"
> +
> +/* Attach a callback with an __arena argument and drive it through the
> + * bpf_testmod_ops3_call_test_arena() kfunc.
> + */

[Severity: Low]
This isn't a bug, but the BPF subsystem prefers multi-line comments to have
the opening /* on its own line. Should this be updated to match the modern
kernel multi-line comment style?

> +static void arena_arg(void)
> +{

[ ... ]

> +	bpf_link__destroy(link);
> +	struct_ops_arena__destroy(skel);
> +}
> +
> +/* A program with no arena cannot attach to a member with an __arena
> + * argument.
> + */

[Severity: Low]
This isn't a bug, but similarly here, could the opening /* be placed on its
own line to align with the subsystem's preferred comment style?

> +static void arena_arg_fail(void)
> +{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713024414.3759=
854-1-tj@kernel.org?part=3D4
