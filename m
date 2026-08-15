Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73C3D9557
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778454; cv=none; b=DFan1yzymT1WVxl8jqiEgfbW+2X1HohuZsf73E8UzFDW7y4z8ueS27n4KJzQrEzDD8tysdI/prEVxL7cDKm6SMcNHmH2smQp6DAmjm2lrNslvU5ygeXwlUQ8nzQCSfb6mQBaWzkpY+G3p+qVx0dd5qriLvswVKDeJIH4B+D6pqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778454; c=relaxed/simple;
	bh=AKq+fUavcN79v0x4I6r1IIu5s6HmjYTRWYJZV3vZNNw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kYyX3w6PVxD6oSRhZUEhEhfHYqyb3cAq8dm3tN4ghxsmi8TobDQAURG/AMl0IEktzQbdMJLvugSQKoGa/aEzBvKVj3SZFmQ2Zr2YzbyAjKl/69uBMzYFWSO97auAPjGegv5GyY0BG1A2Ex8QnSu95v0wXbC44zA9Im3ylThLEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccKIDwdt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccKIDwdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9C71F000E9;
	Sat, 15 Aug 2026 07:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786778452;
	bh=zblDnYY4e1Ad9aRuKaeuVdVbwarAY9K2NpLpjNeALhI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ccKIDwdtDY6yUb4tKdjiAYFVYqayCut8H2xw87tSF713XVVWdeYVvlGhlWLfThsRy
	 vP1L6M9a4KxTpPu+U0vp7wCuT+1xwEOcfGFnXk1gtJnGxyJNncPfwSRwr6495WGBsC
	 +CINoEZ/v2fvikM3CcBr157fAbfAr5GbjgxETA/jTqZUFx9qeaTAwSNzZ7oR/ZmndR
	 /7oiXezrOKOnS3JTXlid3DdbwUH7bcnInWZnaRaUXilNfeqxFhKGRfXG2KkihrIK89
	 kO3KO3FXM1L8QvYqftufFvRP1WMlptnESfRima00GTuxwhged5D8y3HOnrjIoJgg64
	 6XIUAqbf42vAA==
Content-Type: multipart/mixed; boundary="===============8925107373797471283=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e8ef2022e3d16ceddc37652395938a544fc4f44526ac2018fed7bb43215afa6e@mail.kernel.org>
In-Reply-To: <20260815064612.378577-2-memxor@gmail.com>
References: <20260815064612.378577-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 01/14] bpf: Add verifier diagnostics report helpers
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:20:52 +0000 (UTC)

--===============8925107373797471283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> index 000000000000..e75753552a4d
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> +
> +#include <linux/bpf_verifier.h>
> +#include <linux/ctype.h>
> +#include <linux/stdarg.h>
> +
> +#include "diagnostics.h"
> +
> +bool bpf_diag_enabled(const struct bpf_verifier_env *env)
> +{
> +	return env->log.level & BPF_LOG_LEVEL;
> +}
> +
> +static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
> +
> +static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
> +{

This isn't a bug, but could __printf(2, 3) go directly on the
diag_write() definition, as in log.c and verifier.c, so the prototype
does not need to be repeated?

> +	va_list args;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	va_start(args, fmt);
> +	bpf_verifier_vlog(&env->log, fmt, args);
> +	va_end(args);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============8925107373797471283==--
