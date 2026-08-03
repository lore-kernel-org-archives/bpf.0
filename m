Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD2432307;
	Mon,  3 Aug 2026 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781886; cv=none; b=ifdDJ6q2p124mGKiyDEU+zbES3X4AbfOGOO7ybHnjaTcRAckZGrHIHuQQG7Xv7YicWO8xCNjYsX8bL7kvFZiccHXAZpOsIuwWliKUbhMVDq4M524vknO2pfxLrfc3Raqt6eAAfPhXJHZ5ktpBwmbFoReNXAxNnCO3InPqFGKXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781886; c=relaxed/simple;
	bh=HmIJvyNNE0fE/mZLy9R7gtnDURgawm6IlO8ZHT5lwoM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KsVauv6Vmw9SKa0VBW+C/AYhMZSaIrvSdCRbvn+dOTYYatjYDFIrj34UJ1/0OV0OPiKn1nqF5ZFWqGBTKgmHMrMpTGX94rZfxE/dX3AdTQxZzizcXCIoJ6JesSn0+T8TrEFm3J5fyE9ATcRzRo+qmF5P649exAFkW7uB77s/LVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ8wPQYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ8wPQYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6341F000E9;
	Mon,  3 Aug 2026 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781885;
	bh=PQZkygdq85Yf1Sk4vFNan5SABqtDfIJnpArYbLk8EPA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BJ8wPQYHVp64HmOgc5eYCy2ysir1v+iA6pMK4iTrD8w15/8vGTJf0IE8U6krKvy7M
	 hfbAkjzIry/UZ7IU8vP+fH8QE8k/maSLNzqVJbBbYEov8NUTN8sIBT1yCvNvY6Q0om
	 ZcuhRdAu+ZZfHCyVgIIX9QfJSaGpR7W5ioB2ufFgFGG0jv5qITqTB1yotct3m4d3bR
	 nd+A9nvESIt2XLFg6eb6JTKrZUTjRyMxT2P9Nngg1RFfE/L9Fppjv0hll1sMQeY/A9
	 QCUZ7oDmXIKqwZWlMEWCsG6qXBHqnjghB2JH+yAljNk2uQhadq/nebzqrAKpJEPgpm
	 OogjI/8yN+k4w==
Content-Type: multipart/mixed; boundary="===============6256206886796735116=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f910f39ef8d23c65d047c7a42cd13962e882364c72e38d4aaac836d37f698f21@mail.kernel.org>
In-Reply-To: <20260803170251.1898102-4-vineet.gupta@linux.dev>
References: <20260803170251.1898102-4-vineet.gupta@linux.dev>
Subject: Re: [bpf-next 3/4] selftests/bpf: report failed subtest count in test_progs summary
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org,ast@kernel.org,eddyz87@gmail.com,andrii@kernel.org,ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 18:31:24 +0000 (UTC)

--===============6256206886796735116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c

[ ... ]

> @@ -1726,12 +1731,12 @@
>  	fclose(env->json);
>
>  if (env->not_built_cnt)
> -	printf("Summary: %d/%d PASSED, %d SKIPPED (%d not built), %d FAILED\n",
> +	printf("Summary: %d/%d PASSED, %d SKIPPED (%d not built), %d/%d FAILED\n",
>  	       succ_cnt, sub_succ_cnt, skip_cnt, env->not_built_cnt,
> -	       fail_cnt);
> +	       fail_cnt, sub_fail_cnt);
>  else
> -	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> -	       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt);
> +	printf("Summary: %d/%d PASSED, %d SKIPPED, %d/%d FAILED\n",
> +	       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt, sub_fail_cnt);

A subsystem pattern flags this as potentially concerning: the BPF selftests
guide asks that test binaries emit TAP-compliant output via kselftest.h
(ksft_set_plan()/ksft_finished()) rather than hand-formatting their own
summary lines with printf(), so that kselftest runners and CI can parse the
results uniformly.

test_progs.c has always had its own reporting framework and does not use
kselftest.h; this predates the patch by many years and converting it is far
outside the scope of this change. The patch only widens one existing field on
an already ad hoc line.

The changelog acknowledges that the field-format change means "anything
scraping 'N FAILED' out of it needs updating." A search over .github/workflows,
.github/scripts, ci/, tools/testing/selftests/bpf/*.sh and Documentation/
turned up no in-tree parser of the test_progs summary line.

Does this output format remain compatible with the consumers you're aware of?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30836252778
--===============6256206886796735116==--
