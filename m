Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB82765E2
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957848; cv=none; b=EJqEX7C1LpmMhHA6G++EloVsjfnL2KhNhNf7jucihrM9nKkE2CTIW2utcjNTvnbU+6Di5OCuBaP+eR0GwLFle5EO1hspBDMHVPdfAi4eVayfIp/H5BnmwmkNQSevesmuS6rIAsGdLgbxQjDEeqkAwP8tBhXp/eKt0i844+669Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957848; c=relaxed/simple;
	bh=E+pKCmp0VzFP/xoEkvrqOEov1+7/6grZ9hbK9uC2kaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dw73kKxRXnfp2HFQcfGKHm9ZrHgsdMDejB//Hy7/M9K2V1WQ9BvUVuF1XKlW17yBHju3VQRC/PwgA3zufHPKfYVqBAbl5awqqCqPzI49i3kx5PUKgfEbuQorPJ7IegNHKe3e4PmQRsOjxayZljmcv8dQuld2fY6xYKMPxuVq4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx08HuLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx08HuLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03BA1F000E9;
	Mon, 13 Jul 2026 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783957847;
	bh=E1cTg0JX7M2/Fl8qruX+/A0LdT83kHENlVe0p7S5QEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cx08HuLX1QiVFsJe7pkTM/f7KFZGoezlDj/np0JiTnP/eqBpYBFZ10PYRthlqDxMa
	 5kIK8TOOWW5GrFKySSnPqnJzlQ4ZLE26TNQKvv/BZ0+w9w7GofKgrvW/lqpVRB7ATN
	 sgc7rU73QA9fasyrmoUrKRlgJCubmSktNpKlbZQ265R2hJw8EDqNJq2GnyYHf/Yo9/
	 JhLO/lV9wnBeIElyYIJM5y9DmYv5MsgBR6XOlWeey0WryS3rG7DmHCPxJ2d1yl34jM
	 0Fw5D+FO9FZ0dCjD+r7MVOKqhs/BjHDHIEUX54wRg+ds64SZZZiHNacXmJD0+j2b2Y
	 9JaOglgMndtkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 01/17] bpf: Add verifier diagnostics report
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713153910.2556007-2-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:50:46 +0000
Message-Id: <20260713155046.E03BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The static functions `diag_report_reason` and `diag_report_suggesti=
on` (and their dependent static functions like `diag_report_section`, `diag=
_vprint_indented`, etc.) are defined but never used in `kernel/bpf/diagnost=
ics.c`. Additionally, several `CATEGORY_*` macros are defined locally in th=
e `.c` file instead of the header, making them inaccessible to external cal=
lers.
--

--- Patch [1]: [PATCH bpf-next v3 01/17] bpf: Add verifier diagnostics repo=
rt helpers ---
commit 1babdf2fc54b5272d1520095320e5a3cddaa9347
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add verifier diagnostics report helpers
   =20
Add a small diagnostics renderer for verifier reports and wire it into
the BPF build. The initial helpers emit the common text structure: a
failure header plus reusable report sections.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> index 0000000000000..6d28a3481cfa5
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> +
> +#include <linux/bpf_verifier.h>
> +#include <linux/ctype.h>
> +#include <linux/slab.h>
> +#include <linux/stdarg.h>
> +#include <linux/string.h>
> +
> +#include "diagnostics.h"
> +
> +#define CATEGORY_MEMORY_SAFETY "Memory Safety"
> +#define CATEGORY_REGISTER_TYPE_SAFETY "Register Type Safety"
> +#define CATEGORY_CALL_TYPE_SAFETY "Call Type Safety"
> +#define CATEGORY_RESOURCE_LIFETIME_SAFETY "Resource Lifetime Safety"
> +#define CATEGORY_EXECUTION_CONTEXT_SAFETY "Execution Context Safety"
> +#define CATEGORY_PROGRAM_STRUCTURE "Program Structure"
> +#define CATEGORY_POLICY "Policy"
> +#define CATEGORY_VERIFIER_LIMIT "Verifier Limit"
> +#define CATEGORY_VERIFIER_INTERNAL_ERROR "Verifier Internal Error"

[Severity: Low]
Should these CATEGORY_* macros be exported in the diagnostics.h header? Sin=
ce
they define the expected categories for bpf_diag_report_header(), keeping
them local to this .c file prevents other subsystems from accessing them
when calling the API.

[ ... ]

> +static void diag_report_reason(struct bpf_verifier_env *env, const char =
*fmt, ...)
> +{
> +	va_list args;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	diag_report_section(env, "Reason");
> +
> +	va_start(args, fmt);
> +	diag_vprint_indented(env, fmt, args);
> +	va_end(args);
> +}
> +
> +static void diag_report_suggestion(struct bpf_verifier_env *env, const c=
har *fmt, ...)
> +{
> +	va_list args;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	diag_report_section(env, "Suggestion");
> +
> +	va_start(args, fmt);
> +	diag_vprint_indented(env, fmt, args);
> +	va_end(args);
> +	diag_log(env, "\n");
> +}

[Severity: Low]
Will these static functions trigger -Wunused-function compiler warnings?
Since diag_report_reason() and diag_report_suggestion() are defined but
never called or exported in this patch, they could break the build when
CONFIG_WERROR=3Dy is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713153910.2556=
007-1-memxor@gmail.com?part=3D1
