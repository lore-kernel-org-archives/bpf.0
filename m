Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A6346774;
	Wed, 12 Aug 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555542; cv=none; b=ae49xIILo+8Pqyjh466enHaOxFSRxImkKXcLBnPx7+jdZrMPTym9wjhmHEo2feY6DL4blsAYmL7y/RvRycFYmARQL3/UXaLkR5tBiF0mEoGuWw1w9bJptvkFPwCWvRfCS9jcVw1pAEBjWh15MZ2fFUKx6PtMNoe9ulALmfDdOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555542; c=relaxed/simple;
	bh=UB01S17FxM0GzAZO4pxigoj83yBpJJiVtJ+XiTkxwBs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fjT9ElVQ431QpKQloGkxtFJa1VjxK9Dkk08cMHeJdRdH4Adgleg4LmIaeyBK0kFl1GXrLoaM72W0i6fBLNEvMdESrE/3WJT886on8gWCPBioc4O/dLlTzJ81jVWTZ508Qg0XAi0IZWU5TSLLfTyyAutJQ2ODdr8FzmjVaBiNji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgfD4gRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgfD4gRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5381F00A3A;
	Wed, 12 Aug 2026 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555541;
	bh=vDcxUzhSv3GmcxaDdbxxy6vbrwkkt9jjhHzz22/Tc+c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PgfD4gRn3lB83Mri/NdIQHCOg6pTWQa0DcrtHyYaLPOFoYYvgQFvCc6V1yTUag/KN
	 WtrQtJ27m2oxbQYbe8CrAJJrPExIfhEdqQ0Q5fME34ErAZfbKeE4T7vf+phwUkiHOW
	 B6Puj6o5lVj6GRqQ1ryWVQkROZfhbsYO6BM7kUw1PcxXebABPE9l823arjvmwinj5r
	 hSaJUkzI2bYic9I0L07NZ+2mMdE5tL/79bxM3BiXrHY5bciHE6GA6bkKvygi5cu0wu
	 M8h7yixkJ0bseZnhGninq9YJoO4tiOvSxev2+ss54xfj69WESRDn3l+PFrhGgwm4Oc
	 rx2AJvy64bggw==
Content-Type: multipart/mixed; boundary="===============0546768212165924625=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <427cd292151a90f499819620700c9c582f1b63348d91d8727eee4200c268200e@mail.kernel.org>
In-Reply-To: <20260812154328.72834-6-mahe.tardy@gmail.com>
References: <20260812154328.72834-6-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add ksock test for async callback guard
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,mahe.tardy@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 17:25:40 +0000 (UTC)

--===============0546768212165924625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> new file mode 100644
> index 0000000000000..5b9c6cc303922
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Isovalent */
> +
> +#include <unistd.h>
> +
> +#include "test_progs.h"
> +#include "ksock_wq.skel.h"
> +
> +void test_ksock_wq(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct ksock_wq *skel;
> +	int err;
> +
> +	skel = ksock_wq__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
> +		return;
> +
> +	err = bpf_prog_test_run_opts(
> +		bpf_program__fd(skel->progs.ksock_wq_start), &opts);
> +	if (!ASSERT_OK(err, "run ksock_wq_start"))
> +		goto out;
> +	if (!ASSERT_OK(opts.retval, "ksock_wq_start retval"))
> +		goto out;
> +
> +	while (!__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
> +		usleep(1000);

What happens if the workqueue callback never runs or blocks? This loop is
unbounded, so the test would hang forever rather than failing. test_progs
has no per-test timeout, so a hang here would block the entire test run.

Adding an iteration cap (e.g. a bounded retry count followed by an ASSERT
on callback_done) would turn a CI hang into a normal test failure. For
comparison, prog_tests/wq.c uses a bounded usleep(50) before asserting.

> +
> +	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
> +		  "workqueue create rejected");
> +
> +out:
> +	ksock_wq__destroy(skel);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886
--===============0546768212165924625==--
