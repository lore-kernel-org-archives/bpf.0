Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71032BEC27
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716830; cv=none; b=c5H9yQkrFj9uGV9RLaABqB2b3aQvQY4Wo6KxuBqIi7AJFIboFVjSjyK8ltr+HO7h58uSHwd6IlsbCbOrf4+IfaZBo3ae6zTlbJCVFOFiWpMP3YCPzE95hyV+c6uyEdo79TRb1Nm8z2yDqMnAABRIDZm77wWmUabVcWCilyNtzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716830; c=relaxed/simple;
	bh=/U9hRL9OR+3sWIw35OZk5xNZYIZrPc2vSZq7QX7ZmHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuByZ+qHNmC9Bu7IwN2OVts6NOqpDQfg7LrFFmEBaXWv0enhfJNIyK7thJNHo9aktCL6M+j2CV7Wvpbxa1t9qWFp8S2eXMmP927fL/tRXP2Dw6EYHKkGH1W6E/aVIEzF3iTiVOrImizRskxUP+ULKV+LS1fWctB7OAcnERCsQN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9mu+DsH; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9mu+DsH"
Message-ID: <58218abd-dc9e-4197-93eb-5bd0d6c99863@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773716826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kS9Atjb5qj9tYeV2+48XHx7qHyB+zmadZ/MtNbHh4o=;
	b=I9mu+DsHXSdvWpRPDL2zZdPo21XzdBvQLW4y6DXGNhwsC9PJmRPSwVPuHa4XGEbvxYeSL1
	BMZbW4KL0y9OoBb3LFFWJM9YTjflEgWb3sz2OCIcsi41W3YJKvmsIEWtxtfW8CLrdIeyOg
	PppL4eVbRa4bxekJAMYaAtOfKcIiXiU=
Date: Tue, 17 Mar 2026 11:06:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 22/24] selftests/bpf: Add tracing multi attach
 fails test
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-23-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260316075138.465430-23-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/3/26 15:51, Jiri Olsa wrote:
> Adding tests for attach fails on tracing multi link.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 74 +++++++++++++++++++
>  .../selftests/bpf/progs/tracing_multi_fail.c  | 19 +++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index 04d83c37495b..9f4c5af88e21 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -8,6 +8,7 @@
>  #include "tracing_multi_module.skel.h"
>  #include "tracing_multi_intersect.skel.h"
>  #include "tracing_multi_session.skel.h"
> +#include "tracing_multi_fail.skel.h"
>  #include "trace_helpers.h"
>  
>  static __u64 bpf_fentry_test_cookies[] = {
> @@ -480,6 +481,77 @@ static void test_session(void)
>  	tracing_multi_session__destroy(skel);
>  }
>  
> +static void test_attach_api_fails(void)
> +{
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +	static const char * const func[] = {
> +		"bpf_fentry_test2",
> +	};
> +	struct tracing_multi_fail *skel = NULL;
> +	__u32 ids[2], *ids2;
> +	__u64 cookies[2];
> +
> +	skel = tracing_multi_fail__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi_fail__open_and_load"))
> +		return;
> +
> +	/* fail#1 pattern and opts NULL */
> +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> +						NULL, NULL);
> +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> +		goto cleanup;
> +
> +	/* fail#2 pattern and ids */
> +	opts.ids = ids;
> +	opts.cnt = 2;
> +
> +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> +						"bpf_fentry_test*", &opts);
> +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> +		goto cleanup;
> +
> +	/* fail#3 pattern and cookies */
> +	opts.ids = NULL;
> +	opts.cnt = 2;
> +	opts.cookies = cookies;
> +
> +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> +						"bpf_fentry_test*", &opts);
> +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> +		goto cleanup;
> +
> +	/* fail#4 bogus pattern */
> +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> +						"bpf_not_really_a_function*", NULL);
> +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> +		goto cleanup;
> +
> +	/* fail#5 abnormal cnt */
> +	opts.ids = ids;
> +	opts.cnt = INT_MAX;
> +
> +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> +						NULL, &opts);
> +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> +		goto cleanup;
> +
> +	/* fail#6 attach sleepable program to not-allowed function */
> +	ids2 = get_ids(func, 1, NULL);
> +	if (!ASSERT_OK_PTR(ids, "get_ids"))
                           ^ ids2 ?

> +		goto cleanup;
> +
> +	opts.ids = ids2;
> +	opts.cnt = 1;
> +
> +	skel->links.test_fentry_s = bpf_program__attach_tracing_multi(skel->progs.test_fentry_s,
> +						NULL, &opts);
> +	ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi");
                                   ^ test_fentry_s ?

Thanks,
Leon

> +	free(ids2);
> +
> +cleanup:
> +	tracing_multi_fail__destroy(skel);
> +}
> +
>  void test_tracing_multi_test(void)
>  {
>  #ifndef __x86_64__
> @@ -505,4 +577,6 @@ void test_tracing_multi_test(void)
>  		test_link_api_ids(true);
>  	if (test__start_subtest("session"))
>  		test_session();
> +	if (test__start_subtest("attach_api_fails"))
> +		test_attach_api_fails();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_fail.c b/tools/testing/selftests/bpf/progs/tracing_multi_fail.c
> new file mode 100644
> index 000000000000..8f769ddb9136
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_fail.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdbool.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("fentry.multi")
> +int BPF_PROG(test_fentry)
> +{
> +	return 0;
> +}
> +
> +SEC("fentry.multi.s")
> +int BPF_PROG(test_fentry_s)
> +{
> +	return 0;
> +}

