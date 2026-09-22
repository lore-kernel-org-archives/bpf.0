Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70F33F589;
	Tue, 22 Sep 2026 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086615; cv=none; b=MZFPm+rOWLgwMzc4k2RHybVsE5oIptbQuTXOockGm6mTn0UN6q/MCtS7m2ASCzTU0TnGYW3A9uPVRIKdBytBiw3pQxliJF2TKC2P3aNcvy4JqoHDVYkX3+iazUCg1r7EB40EQv5FDZVGwHnHKWKaMaRNkhd2g/wk8HUa2wF+pnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086615; c=relaxed/simple;
	bh=L/LCEmV/UYkCSascsQtkQrkmEltbz9KiQAg8kh5cVG0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bb5IJ6Gm+5g6gGRsa0O5nY9KB5GdlNT1siu3RcxPjQDVsDgJQL/7WbIKtMahjVWhV/gk/FdbAwOKTM86/EnpakQBwmKXOuwZP7FlF+2X6fvUAv8KfpSGo76dXPUwfJCduwi9T0sRg64/N6o9N5rfX/tAQWIbkIGrKnoCfSzkX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfZL6OxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfZL6OxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176901F000FF;
	Tue, 22 Sep 2026 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790086613;
	bh=V8yh8KrJJLzU6gKefEwrrapB5wwWj7nqm0eP3QIiW38=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LfZL6OxFMxvUhDY5jz3rVf3IEeD//bfSz4Bvzt8QlsOC9nscwcH3kekqyxzaDSZMU
	 k9Qa1lHMcehqqc69kauR3amTXv/bh468rI2hOlMXdOw34mLvZxoWlkgux1XJi+aTs+
	 t4PHyP4uTcMKsGtl2Z7X0VG2C2RpWDZZgbgF3/9467FZ0HwID1VczUE4BBQVZ8VQfj
	 DHi/khgUEEUnyE7pi5aTZxwGWpbc/L4hn2mXKqYrdNPoBbQECFjwMQjd4CnrKDZLOW
	 qOqo2PYyuFHRRDawFmfpVNPle3ZhwaeAoM2ARuE3KTekWRT44r2I+FS4mgZHJN+HUy
	 YwsxLzROiclUQ==
Content-Type: multipart/mixed; boundary="===============0354108412572357667=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ee510141f44725527b6a2f60cae4323f26ecde36d3a592ba997648de45c80134@mail.kernel.org>
In-Reply-To: <20260922-module-stubs-v1-1-abe465a24879@suse.com>
References: <20260922-module-stubs-v1-1-abe465a24879@suse.com>
Subject: Re: [PATCH] module: Add stubs.c for CONFIG_MODULES=n module_put_and_kthread_exit()
From: bot+bpf-ci@kernel.org
To: petr.pavlu@suse.com,mcgrof@kernel.org,petr.pavlu@suse.com,da.gomez@kernel.org,samitolvanen@google.com,ast@kernel.org,daniel@iogearbox.net
Cc: atomlin@atomlin.com,john.fastabend@gmail.com,linux-modules@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 14:16:52 +0000 (UTC)

--===============0354108412572357667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea5..4c7bd7f9f8898 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h

[ ... ]

> diff --git a/kernel/Makefile b/kernel/Makefile
> index 1e1a31673577d..08a94594975d2 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d62c0f74cff5e..193610e20a4a8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> index 50ffcc413b545..72fd2972eacfd 100644
> --- a/kernel/module/Makefile
> +++ b/kernel/module/Makefile

[ ... ]

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad06..a8bf803afa813 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> diff --git a/kernel/module/stubs.c b/kernel/module/stubs.c
> new file mode 100644
> index 0000000000000..81e66c02260c8
> --- /dev/null
> +++ b/kernel/module/stubs.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +#include "internal.h"

This isn't a bug, but does stubs.c need "internal.h" here, or would
<linux/kthread.h> plus <linux/module.h> be enough?

kthread_exit() comes from <linux/kthread.h>, and struct module,
__noreturn, and EXPORT_SYMBOL come from <linux/module.h>. The file
doesn't appear to use anything that internal.h provides.

This makes stubs.c the only consumer of that header outside
CONFIG_MODULES=y, which future internal.h changes would have to keep
working.

> +
> +void __noreturn __module_put_and_kthread_exit(struct module *mod, long code)
> +{
> +	kthread_exit(code);
> +}
> +EXPORT_SYMBOL(__module_put_and_kthread_exit);

This isn't a bug, but since stubs.o only exists for CONFIG_MODULES=n, is
the EXPORT_SYMBOL() reachable by any module, or can it be dropped?

No loadable module can resolve this export when CONFIG_MODULES=n. The
macro still expands (producing an .export_symbol entry that
COMMON_DISCARDS drops at link, plus __ADDRESSABLE()), so it's harmless
but has no consumer.

kernel/time/posix-stubs.c, cited in the commit message as the model,
exports nothing.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35733170542
--===============0354108412572357667==--
