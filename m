Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4D3C872C;
	Thu, 15 Oct 2026 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792033148; cv=none; b=QJOB5gIPbjQqQRhJU6z0dAV7KM11KD2SysUDSI/hycru7k/5FxIdReo4BruBTUdvxSmTNf03tswvVF0bhaYbdZkSDtu2/mQNJIqxLaJMdgyydPHJZsHJleSUCEultfYNtP4wC6iYJkHqzxqR28+wDG5KuMtc2uzXd7AQ0u/s5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792033148; c=relaxed/simple;
	bh=65cFJqlE0dnr79eN1YWPSz9NkZPgd3p/LElMzQexptA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RBb127I1j4ex/eQFHugQWL0A+fTLAxgTVkzzD1V34tOBJAfjkXLc5Reu8LDI65q3f5H4mO3EftjoyX20tTD5HSXMUaErLQ/2bXqghVRLRh6cKjuragVriSqe5p2lLnCQ1L6kKMElpVEqF73AN72nygYvruntO/8mwwcMA1xhAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS3EaB/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS3EaB/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38BF1F000C5;
	Thu, 15 Oct 2026 02:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792033143;
	bh=gfDjOBLmxrlrBy8q3VjBAy3QGHQDlpDU+Qz9C9H7BZI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CS3EaB/tIK1WQyuloanL69f8rx3TfAB+dijR+TAdHTMGW6GYcQMQWfvBqM2+pOR9t
	 OQClVC/NMH9TdUncLsifO8KJT+bdNWCrjWPVTOhXBRlvzF6BrGMRiZ9RL50V1Z0mb+
	 Rpv+FlzkshFfKdX0ZkLkEP6Eok8Um+axZENoVC9dXl+ZGrDJgAPlMi0nuo+6N30cHW
	 T2SK3VUBTShncU6DyaaEYAdWh7SiPPoSO1ZQyYChTTyLlx6+ZDy1DagGeHqOjjEaxN
	 szTZA42C5OZ6R5D00Tg8wPbY3AKkURFNOknlWjhwhS7hm/XV6cMZM1siPfjy+VMx0N
	 NwvCNx6cGCPTg==
Content-Type: multipart/mixed; boundary="===============8938492152272236540=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <721cefcbf3b4af0f1201432225ebcf6fe25a35948a581b9da360a43b6a102810@mail.kernel.org>
In-Reply-To: <20261015021238.5657-4-cp0613@linux.alibaba.com>
References: <20261015021238.5657-4-cp0613@linux.alibaba.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add a runtime test for private stack and stack arguments
From: bot+bpf-ci@kernel.org
To: cp0613@linux.alibaba.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,bjorn@kernel.org,puranjay@kernel.org
Cc: eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,pulehui@huawei.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,luke.r.nels@gmail.com,xi.wang@gmail.com,shuah@kernel.org,rgbi3307@gmail.com,guoren@kernel.org,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 15 Oct 2026 02:59:00 +0000 (UTC)

--===============8938492152272236540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add a runtime test for private stack and stack arguments

TL;DR: Test issue only: the new private stack selftest calls test__skip()
without printing a reason, so a SKIP doesn't show why. The review says this
may be acceptable, since other tests do the same.

> diff --git a/tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c b/tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c
> new file mode 100644
> index 000000000000..3af24ca8009f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c
> @@ -0,0 +1,83 @@

[ ... ]

> +	if (!skel->rodata->has_stack_args) {
> +		test__skip();
> +		goto out;
> +	}

A subsystem pattern flags this as potentially concerning: a selftest that
skips without printing a reason.  Both skip paths call test__skip() bare,
this one when the compiler lacks __BPF_FEATURE_STACK_ARGUMENT
(has_stack_args is false), and the other in the non-riscv64 branch:

    #else
        test__skip();
    #endif

Without a message, the test shows up as SKIP with no hint whether clang
needs to be upgraded or the test is only built for riscv64.  Would a
printf() before test__skip(), like the "%s:SKIP: ..." message that
test_loader's run_subtest() prints, make the cause visible?

This may be acceptable as is: test_progs does report the test as SKIP, and
prog_tests/stack_arg.c and prog_tests/struct_ops_private_stack.c also call
test__skip() without a message.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38671177164
--===============8938492152272236540==--
