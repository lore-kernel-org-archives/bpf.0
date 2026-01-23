Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C441EA84;
	Fri, 23 Jan 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155072; cv=none; b=Dtgfe9Q7Q65gQcuwmLu2WP8xtGdfz2+6xRN3MraYbK/h2tbvOqHvmJPkT2MX5UFrPbjnAaODvpZCnPWbiMCJRDAtRMDOxqBPlmwERcW9jLobUtuHSmhF9PhyKFKxbF45bJ3cCi32V9ccmNJlp6CdDh0C3yrZqLa2Uuj+tMeMxiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155072; c=relaxed/simple;
	bh=YG46esQt9Jg/6w27OTE+7JkxGKvOrFrFMxKupSuzJ/Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t1ssQAMgYOCkr+3yi96t5of2VN6FXr/BSwF5HexDKuPDw7d96TD9JTEsdPd2KdFFGYfF7tSzgQ464xGQ9liYMh2w6N/RpxpnWcXcIg35KaMfnEIH/8p0FTkbvLaa/lVTAcAnX0MpVYriCKA4Ajm5CEatp/BVATpPyMpDugpR1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usbQ8lft; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usbQ8lft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6ABC4CEF1;
	Fri, 23 Jan 2026 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155072;
	bh=YG46esQt9Jg/6w27OTE+7JkxGKvOrFrFMxKupSuzJ/Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=usbQ8lftuF8+2Rf8hQj8NuRnCiqzAoJYgm3QwK8+EfSrR7awdGqd4hxJ0NSegeyI7
	 hn8BEnqhEu3LRFAd4Ysd0SIRjQO6YRvXSUAfkW1JvqPlz1FdJqMEB1kXpsSGEE0m/I
	 OkB+2Ic6wR6FcghivPgFePboWHmy1DzJCOoVaEnNprqriqOAp73coXB920/iEQygQh
	 UzN46dDYgIpjUtJneIVWZwsvAg2UXqZLgmDhRHo48qp9XlvD6TKSWIdxIYMAf63Xmz
	 yJrFk90iBjE858GRFRU0bHFJCV+bgSgoUJywD6nLcP/uPLq2fe+owAf7IsJ4uDJ6dU
	 BvgrOrE2n85nw==
Content-Type: multipart/mixed; boundary="===============8460079455577535595=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28d092553ad40300324a21ccbc1dfd89f06283ca4801a5196e993f11e1522e71@mail.kernel.org>
In-Reply-To: <20260123073532.238985-11-dongml2@chinatelecom.cn>
References: <20260123073532.238985-11-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v11 10/12] selftests/bpf: add testcases for fsession
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,dsahern@kernel.org,tglx@linutronix.de,mingo@redhat.com,jiang.biao@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 07:57:51 +0000 (UTC)

--===============8460079455577535595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
> new file mode 100644
> index 000000000000..f504984d42f2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 ChinaTelecom */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";

[ ... ]

> +__u64 test6_entry_result = 0;
> +__u64 test6_exit_result = 0;
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test6, int a)
> +{
> +	__u64 addr = bpf_get_func_ip(ctx);
> +
> +	if (bpf_session_is_return(ctx))
> +		test6_exit_result = (const void *) addr == &bpf_fentry_test1;
> +	else
> +		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
                                                          ^^^^^^^^^^^^^^^^^^

Is the bpf_fentry_test1 symbol declared somewhere? The code references
&bpf_fentry_test1 but there is no extern declaration with __ksym in this
file.

Other BPF selftests that take addresses of kernel symbols declare them
explicitly, for example get_func_ip_test.c has:

    extern int bpf_fentry_test1(int a) __ksym;

And kprobe_multi_session.c has:

    extern const void bpf_fentry_test1 __ksym;

Without a similar declaration, will this BPF program compile and load
correctly?

> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581

--===============8460079455577535595==--
