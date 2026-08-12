Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C83B42F9
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578108; cv=none; b=cWqI8wgsNDEvVqLLOEj55ChsX1y48fBBCsvCvsyuj7p/S3NYeTf6IUmA4wLRymlJDWDHJx74UcjzzFl5y688R5yonIoMQCf0uGjALsfiAByvGVLWzL7FcIrDM4M3Y9i7Lj/6g5AvBHmUNspdmaJ0ErJTuilQiYO5foxPi/hW85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578108; c=relaxed/simple;
	bh=T03RsCeJ+6N44b1Dn5n2fZzSUPULr+u2edCQ7B81Zyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Iv9hSQnU0anpzjLb3EjL+Qh/pX//YcYeOhtr50//77UWacgDJFp3gmCPswbmaN9d2dOvl8kt7RQ+QlR7+Ms8edxGrIwRaDW1f966C7UxmfLW7VWynYhqfyi5WsBdexyULeAD+BmGp6Xd+WDozXuDmDRu6fWYKa9MMINm/eMoi2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlfAlbDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlfAlbDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D6E1F000E9;
	Wed, 12 Aug 2026 23:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786578107;
	bh=T03RsCeJ+6N44b1Dn5n2fZzSUPULr+u2edCQ7B81Zyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jlfAlbDekWWqP596cNdruu3pKlFIRW5ctmYA+ts4aNUkcaLP3qc5LTtGv9MKG0Cgo
	 7K5o7M8JzD8ZA94/2kO3tF8qFxwx2giQDwQCvidfLKRppmz8PS0oxspw22iWRBcJld
	 ACDWkLSygM9gsernNnh/i9s0MX0WT/PFviVRzfFYjMz5ivStBYR4Af9sZb3AxmZPEb
	 sjO1YC0nj9OvK7Mk8FaI2HwAdEEU2iY8/IHTVz8DcOrPxXoO2yFSK+05L8JST+nfvB
	 upB0cLxmM8pYIov2uGs6UuJtGpi4kLeb6xM9m1+/wjS1qEurLQyUIlW25/ZEGqYMIi
	 XOND4RjZ6qBOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 01/16] bpf: Add verifier diagnostics report
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812233326.3575958-2-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
 <20260812233326.3575958-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:41:46 +0000
Message-Id: <20260812234147.02D6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch completely fails to implement the prose wrapping and r=
eusable report sections promised in the commit message.
- [Low] Diagnostic category string macros are defined in the .c file instea=
d of the header, making them inaccessible to callers.
--

--- Patch [1]: [PATCH bpf-next v4 01/16] bpf: Add verifier diagnostics repo=
rt helpers ---
commit 2d39aa0d2b938aedc24539fb306c5c0aabb08c25
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add verifier diagnostics report helpers

This patch adds a small diagnostics renderer for verifier reports and wires=
 it
into the BPF build. It includes helpers to emit a failure header and aims to
provide reusable report sections.

> Wrap report prose at 100 columns so Reason and Suggestion text stays
> readable without changing source or instruction gutters.

[Severity: Medium]
Is this description accurate for the current implementation? Looking at the
code for bpf_diag_header() and diag_write() added in this patch, there does
not appear to be any text wrapping logic or implementation for reusable
report sections like Reason and Suggestion. Was this logic accidentally
omitted from this patch?

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> +
> +#include <linux/bpf_verifier.h>
> +#include <linux/ctype.h>
> +#include <linux/stdarg.h>
> +
> +#include "diagnostics.h"
> +
> +#define MEMORY_SAFETY "Memory Safety"
> +#define REGISTER_TYPE_SAFETY "Register Type Safety"
> +#define CALL_TYPE_SAFETY "Call Type Safety"
> +#define RESOURCE_LIFETIME_SAFETY "Resource Lifetime Safety"
> +#define EXECUTION_CONTEXT_SAFETY "Execution Context Safety"
> +#define PROGRAM_STRUCTURE "Program Structure"
> +#define POLICY "Policy"
> +#define VERIFIER_LIMIT "Verifier Limit"

[Severity: Low]
Should these category string macros be defined in diagnostics.h instead of
here in the source file? Since they are not used within diagnostics.c and
are not exported in the header file, other files in the verifier will not be
able to use them as standardized arguments when calling bpf_diag_header().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812233326.3575=
958-1-memxor@gmail.com?part=3D1
