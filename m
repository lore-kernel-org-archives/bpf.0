Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10847275AFD
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994507; cv=none; b=EZR/JkkgT0Y84VVq8oLmTlqloXzVAVDLti6DI0vf4kAJQcJ+Alh8qHRrpUcbQQvtfjmLt4z3+dXaIA3Iz41eXl4nTaCKgpaXd2cqpI/pd/crImpqwXF5rI9oXMOOAwIYfN5ZoZp77/CTL/ivgtbkO0eHnVYaDUGL/1vB8Rp33CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994507; c=relaxed/simple;
	bh=lhl6vB23mjzxM5gLjSdCB9SEVy/US7kQoF4lniPdGjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LYQ7KiDsLBeYUfCxi8nKSKpX1IeXB+qm6be5sdK4dFUXVPcpRAiS7TDDx+XOvfA2qY4zLo5hKiIDdvZVaLW6GHiOd7CY2Ltj2lE8rTQJArGdVdzdioDM9PWxJJakudH7auP/FnvRJj0HynXMfOzva47fUoa+6ZJwAyiBF4wExAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn+OKGQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn+OKGQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774441F000E9;
	Mon, 17 Aug 2026 19:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786994505;
	bh=u5MT5BF4L9vCaMj4BbRKxKAv3UQUUhmMsVwHT7n15SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kn+OKGQjB5opWZva83uOylqHV7SGury+ffYigZODu1MmQ57ssMcu/Urc/9I/0J7Z6
	 9ksKVWkNEUF/7ExUAGUogh4KrVske7kHE/KAeUA0HRqFJgAT2Z3BGWij5e+ukvCKv8
	 GiqcrAfmWcLL2ENt9NgN7ECHwIIE/Bn9035/mAJZuvwHuWHV8QiMdZQQZdP//+Ftq8
	 3iImI39zEQMFzgpjdO5zDRchx5fwFkM1U0nr/dMGZrCCSUt7MvtRBAqJSgYX8fB98g
	 uEDGRxznnjyCYtcv7XVWkiDhMYVkkMcnjBVOBv238cUC5asO0g7DhMvAzzvzObOyt9
	 spZnlQdQ5KhRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] selftests/bpf: libarena: Normalize SPDX headers
 across files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817191616.11071-2-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
 <20260817191616.11071-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 19:21:44 +0000
Message-Id: <20260817192145.774441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The commit message claims to normalize libarena to a uniform 'du=
al GPLv2/BSD-2-Clause license', but the patch actually applies a mix of LGP=
L-2.1 and GPL-2.0 licenses.
- [Medium] Relicensing code authored by others requires their explicit Acke=
d-by or Signed-off-by, not just a CC.
- [Low] SPDX License Identifiers in C header files are improperly formatted=
 using `//` comments instead of `/* ... */`.
--

--- Patch [1]: [PATCH 1/6] selftests/bpf: libarena: Normalize SPDX headers =
across files ---
commit 31e67a726c2a90149ef6d815e971306cd776d717
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Normalize SPDX headers across files

This commit normalizes SPDX headers in libarena by adding missing headers=20
and updating existing ones. It states the intention to apply a uniform=20
dual GPLv2/BSD-2-Clause license across the components.

> There are currently three files missing headers and two of them
> (both originally authored by Kartikeya, CC'ed below) that are
> GPLv2 only. This patch ensures all files in libarena have a
> dual GPLv2/BSD-2-Clause license in the example of other non-
> kernel BPF codebases, e.g., libbpf.

[Severity: Medium]
Is a Cc sufficient for changing the license of existing code? Relicensing=20
code originally authored by others typically requires their explicit=20
Acked-by or Signed-off-by tags to document their consent, rather than=20
just a Cc.

> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h =
b/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>  #pragma once

[Severity: Medium]
The commit message states the patch ensures all files have a dual=20
GPLv2/BSD-2-Clause license, but this adds an LGPL-2.1 tag. Was this=20
intended to be GPL-2.0 to match the other updated headers, or should the=20
commit message be updated to reflect the mix of licenses?

[Severity: Low]
Also, according to the kernel's documentation, C header files should use=20
the C-style block comment format /* SPDX-License-Identifier: ... */=20
rather than C++ style // comments.

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>  #pragma once

[Severity: Low]
This header file also uses the // comment style instead of the /* ... */=20
block comment format expected for C headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817191616.1107=
1-1-emil@etsalapatis.com?part=3D1
