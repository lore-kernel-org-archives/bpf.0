Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33B390CB0;
	Sat,  6 Jun 2026 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745564; cv=none; b=Ihmu4OklloTlLHDymvJ6+OxG4A5xnIzHMqhWSm0o+uMsy8KzafW8F0ZO765BXWJoGEkLNoS8eAfAPfAfhkSDTt9uNcrTxXL6H82Kye6LdkOdcOvniS0340WOd9nuapVXdki7j3qv64mw05i46dFLsur0F/Tb64XcISHEeoVu6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745564; c=relaxed/simple;
	bh=/fey9nILQzxR3op27+ma2fTj/lsexsQ1dR4PWF0h/+0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DVb7D1sYZ29v681qNYR06Wkr7+XC+ViIlbQlmX2/TDu4jNOfzHIHviC2DIKy66KIJckVa7V6QrPO+oLCjIRCnT65h8pCyEkQO98/R2KcAdT+g4NJLr26ZZhKdudWANm2inWh+h29tTiSt9bsAMmr1M7HqH7JyImv6hKw3VZ/xxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJZ99ci7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJZ99ci7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B381F00893;
	Sat,  6 Jun 2026 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780745563;
	bh=/fey9nILQzxR3op27+ma2fTj/lsexsQ1dR4PWF0h/+0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UJZ99ci7VIJxN/L7DAesJt/Xht8ffAWcvEE9Xi8QRQf1gHwTiE5CIXR6a20WhZRNB
	 nGK+pOYYvoQeCVMEJ/eWmQVok7m6Qy5zi4b7JIFuInMEUhNvaLbuPZP7fmxRW0kaZX
	 n6M1Uj9PGUGSu8KY17q0YXIC5Q7EhOUjBW/QAslKC3cu8syrciMSRWiQ5SKzNlP8um
	 Br+wbZWYL8VoF9Kwa63i3sZ2evE5kcGh+u/0nuIg3CcrpIoRYyx0mX9VECtuhmq4cr
	 pxYy+DaB6MxJ/4Dd5fh+iMr7t/WxLD9aiPxtzZEvcENH/uCWMgAEDV31iA894XjRTl
	 9Oi1G2xkmmsug==
Content-Type: multipart/mixed; boundary="===============7208419686952190815=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d32a022041bcaad4e649101b948998b953415f4d8f4eea26422cbc28e0b9dd41@mail.kernel.org>
In-Reply-To: <20260606-c3-01-v3-v3-2-97c51f592f15@mails.tsinghua.edu.cn>
References: <20260606-c3-01-v3-v3-2-97c51f592f15@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add tests for PTR_TO_FLOW_KEYS offset bounds
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com
Cc: gnq25@mails.tsinghua.edu.cn,john.fastabend@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  6 Jun 2026 11:32:42 +0000 (UTC)

--===============7208419686952190815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 89779d897aba..8a3d69e2453c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_flow_keys.c b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c
> new file mode 100644
> index 000000000000..d780a36a6e9a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Bounds checks for PTR_TO_FLOW_KEYS pointer arithmetic. */

[ ... ]

> +
> +/* Equivalent OOB expressed directly in insn->off; this form was always
> + * rejected and is kept to show both forms now share one diagnostic.
> + */

This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem style? The guidelines specify that the opening /* should be
on its own line, with the comment text starting on the next line.

Note: This style issue has been consistently raised in reviews for v1, v2,
and v3 but has not been addressed.

Reference: https://lore.kernel.org/bpf/20260604154507.B5CB51F00893@smtp.kernel.org/

> +SEC("flow_dissector")
> +__description("flow_keys: OOB via insn->off rejected")
> +__failure __msg("invalid access to flow keys off=4096 size=8")
> +__naked void flow_keys_insn_off_oob(void)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27060463888
--===============7208419686952190815==--
