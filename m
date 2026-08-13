Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC43E9580;
	Thu, 13 Aug 2026 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623214; cv=none; b=MlkSfhJUIvwVIrvuV5NRnBKcqfoEuFEvBavRX9YC/ZEP6p0E73hh6dADLguz/S3IJeAFOY5gFEnk3TqWzVcK+gmeFKyJY6xbDDCLuRnYzj0J9C6PGsfjWQAykIVCYrgahlAPIudPCjU4Ce98JKXIQA1BfN4HYVs/T05Zqz0bA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623214; c=relaxed/simple;
	bh=xd2yshB4cbgQuie+zGOnc9K62XJm2x5vteMyq0kq2Y8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=W8XMun00MQXSc+iDJHRCCDGRJ9trAYrHD7W7xTbINGPpbrKflVH2HAKLjFbP1pL2op83V7hpPhPhP89FcKyHlIT2tmtLbVjveuqGJc+6yq5xWIVIOweb/CN7AxRj/2mEXcXGhFz4ln8ilem2amD5fDTsxUKWEJjfJqchlVKnQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDAWPJT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDAWPJT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9731F000E9;
	Thu, 13 Aug 2026 12:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786623213;
	bh=OM9+A8vnL0s1np8df8ef2EVZMpfPbA3gcCn3ztSyKf8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mDAWPJT1r9mnewC8/rgUZ25DR7eFlpiGBxVzLNFVQ7tI2lX17C327lwih4f5T8/wy
	 6jWh82MtO/8P5T7TQbTIy+sIkpdPjk3XdNI6QOBIRwsy7GYCi4QdyJ69zBVkCUEIu2
	 aZLBti0T2r/M5EQLFmL6M9acJxErmviMnUIIU8x1DymED2LW/FFQS2NNZv/FCLjfbT
	 FUl4nTj+ViKTgGv/hIM7JsRV3Y5+UYID0By1UCj4MEgGOeBKXz9NUS/biqt7dSjXC2
	 mHvnXC+jzZ0EZ8MiXM/qmBDOAjsITx0SDBo+uD3536W2yaTjtyl5reTEu7B93cE0hs
	 P6Mvlir8up6YA==
Content-Type: multipart/mixed; boundary="===============5122878881276464828=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <62274a8d6156015b945bc8e7b5b8c2962332b104e3484a5a2d0e0b0c95b531b1@mail.kernel.org>
In-Reply-To: <20260813110540.103550-6-mahe.tardy@gmail.com>
References: <20260813110540.103550-6-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v7 5/5] selftests/bpf: Add ksock test for async callback guard
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,mahe.tardy@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 12:13:31 +0000 (UTC)

--===============5122878881276464828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> new file mode 100644
> index 0000000000000..d6dc20b8f95bb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Isovalent */
> +
> +#include <unistd.h>
> +
> +#include "test_progs.h"
> +#include "ksock_wq.skel.h"
> +
> +#define CALLBACK_WAIT_RETRIES 1000
> +#define CALLBACK_WAIT_US 1000
> +
> +void test_ksock_wq(void)

This commit adds a new standalone test file for the workqueue guard check.
The same directory already has prog_tests/ksock.c (from commit a529f8c4d088b
two patches earlier in this series) which is the home of the ksock kfunc
tests. Notably, the immediately preceding commit in this series
(75ef545fdff15) added its negative test as a new function inside the
existing prog_tests/ksock.c rather than creating a new file. A subsystem
pattern flags this as potentially concerning: should test_ksock_wq() be
another function/subtest in prog_tests/ksock.c, consistent with how patch
4 of this same series added its case? The split means the ksock feature's
tests are now across two files with generated test names 'ksock_lsm',
'ksock_lsm_verifier' and 'ksock_wq' rather than grouped together.

> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct ksock_wq *skel;
> +	u32 callback_done;
> +	int err, i;
> +
> +	skel = ksock_wq__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
> +		return;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_wq_start),
> +				     &opts);
> +	if (!ASSERT_OK(err, "run ksock_wq_start"))
> +		goto out;
> +	if (!ASSERT_OK(opts.retval, "ksock_wq_start retval"))
> +		goto out;
> +
> +	for (i = 0; i < CALLBACK_WAIT_RETRIES; i++) {
> +		if (__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
> +			break;
> +		usleep(CALLBACK_WAIT_US);
> +	}
> +	callback_done = __atomic_load_n(&skel->bss->callback_done,
> +					__ATOMIC_ACQUIRE);
> +	if (!ASSERT_EQ(callback_done, 1, "workqueue callback completed"))
> +		goto out;
> +
> +	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
> +		  "workqueue create rejected");
> +
> +out:
> +	ksock_wq__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
> new file mode 100644
> index 0000000000000..16a1873d132ed
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Isovalent */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_experimental.h"
> +#include "bpf_tracing_net.h"
> +#include "errno.h"
> +#include "ksock_common.h"
> +
> +struct ksock_wq_value {
> +	struct bpf_wq work;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, u32);
> +	__type(value, struct ksock_wq_value);
> +} work_map SEC(".maps");
> +
> +int create_err;
> +u32 callback_done;
> +
> +static int ksock_wq_callback(void *map, int *key, void *value)
> +{
> +	struct bpf_ksock_create_opts opts = {
> +		.family = AF_INET,
> +		.type = SOCK_DGRAM,
> +		.protocol = IPPROTO_UDP,
> +	};
> +	struct bpf_ksock *ks;
> +	int err = 0;
> +
> +	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
> +	if (ks)
> +		bpf_ksock_release(ks);
> +	create_err = err;
> +	__sync_fetch_and_add(&callback_done, 1);
> +	return 0;
> +}

[ ... ]

>     selftests/bpf: Add ksock test for async callback guard
>
>     Because the kfuncs are going through LSM hooks, allowing their use via
>     workqueue callbacks would expose the wrong credentials. This test
>     ensures the kfunc are preventing any use from these contexts.

This isn't a bug, but the changelog says the test "ensures the kfunc are
preventing any use from these contexts", which reads as covering the
whole kfunc set. The added program exercises exactly one kfunc from the
workqueue callback, bpf_ksock_create(). The other two kfuncs that carry
the same runtime guard, bpf_ksock_connect() and bpf_ksock_send(), are not
exercised from an async callback anywhere in the tree. Would it be worth
either narrowing the changelog to say the test covers bpf_ksock_create(),
or extending the callback to also call bpf_ksock_send() on a stashed kptr
so all three guarded kfuncs are pinned?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31694719067
--===============5122878881276464828==--
