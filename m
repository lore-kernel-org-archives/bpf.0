Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2533BBFAE
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998353; cv=none; b=u3uIUJAjroL3JByJyx8l730oF3XQjqduSHMLxBN9qGmti8HjzOxxtrH9xm/GTbSsSaYA2GVuN1LdltffCM7jAaYBz4c3vwbod4MhHc1Eyrrw+4hCeJS864qKVMbdOYWnkQ4ZffRmpCqsZayJDUdQwxNKghH8K/IOaya5uDlvx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998353; c=relaxed/simple;
	bh=WZOrc40c8mf+xS0X2WYf+F4xqSw8kNTlD24NyZlBvUo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AM9ZbN/03O2/YNW+K647KTkmPqWMiAIa3Kwmastnl9wYdwa4z0PaHmm1u7DAAltO30PIyFe8Bc9gvwt4eZ6pegYohJhP/0/V80nPzvydLe41+3S/+EIhQXxRlaXU6GymhWtWqqFuBj4JDrySrDP5M+jqe+gzH6zK2kHhtS/8zG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5tZ9mc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5tZ9mc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC67C1F000E9;
	Mon, 17 Aug 2026 20:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998351;
	bh=RjE0rCX19M54zziZHn1BVumIyN2seC7W4hHLzO25Bd8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=D5tZ9mc8hQ9GGWhx6Z8TmdpXX3Ju2z25cyLEwHmf4RhuYjpfWhUmh6rekhiSzvUtP
	 yBoweMkWfBjnvbBbRPEjqtRguwhYuguemh8GWm8aXqi/JU/6I2x4qbCfv9J+mb1y05
	 t1PviD0v7dtdPvXPMbvEqhWMG08n903ZJdzfAq/3cTvU1L3Plzj8YRpeFbvTz7wf8j
	 MOmksshsKXitqaQwNFgKJWoxCFL9siyUkrukyJ5zaQ3i4EzFt/YrhuMf6NZVUqxWtn
	 V6K8a5TOcASVZgtzN9oVKVUb/vKIq3iY1QqA8J8yoeG+Gilgz1CeDupZZ7nu7pS8gc
	 qgtbD+IUUV2Qw==
Content-Type: multipart/mixed; boundary="===============7511222645804119623=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <49d90f8604abbf8f1e0ae7699bfbb9a02bc8edb69c5b67f8925166bfd681969f@mail.kernel.org>
In-Reply-To: <20260817191616.11071-6-emil@etsalapatis.com>
References: <20260817191616.11071-6-emil@etsalapatis.com>
Subject: Re: [PATCH 5/6] selftests/bpf: libarena: Add a benchmark for malloc()/calloc()
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 20:25:50 +0000 (UTC)

--===============7511222645804119623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh b/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
> new file mode 100755
> index 000000000000..10afe4d52ebf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
> @@ -0,0 +1,31 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ./benchs/run_common.sh
> +
> +set -eufo pipefail
> +
> +RUN_BENCH="./bench -d3 -q"
> +
> +summarize_libarena()
> +{
> +	local bench="$1"
> +	local summary
> +
> +	summary=$(printf '%s\n' "$2" | tail -n1)
> +	summary=${summary#Summary: }
> +	printf "%-20s %s\n" "$bench" "$summary"
> +}
> +
> +header "libarena sequential malloc\n"
                                       ^^

The argument passed to header() includes a trailing '\n' escape, but
header() in benchs/run_common.sh uses printf's %s conversion, which
copies the argument verbatim without interpreting backslash escapes:

    function header()
    {
            local len=${#1}

            printf "\n%s\n" "$1"
            for i in $(seq 1 $len); do printf '='; done
            printf '\n'
    }

So the two characters '\' and 'n' are printed literally rather than as a
newline. There is a second effect: len=${#1} counts those two extra
characters, so the '=' underline is 28 characters for a 26-character title,
leaving the rule two characters wider than the text it underlines.

header() already emits its own leading and trailing newlines, so the escape
is not needed. All 23 other header() call sites in
tools/testing/selftests/bpf/benchs/*.sh pass a bare string with no escape
(for example, run_bench_bloom_filter_map.sh:8 uses header "Bloom filter
map"), so this is the only caller that includes an escape.

Would it make sense to drop the trailing \n?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32062809860
--===============7511222645804119623==--
