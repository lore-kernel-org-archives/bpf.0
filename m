Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E7359A91
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421174; cv=none; b=X7kpPnzH7xyDkxOCnvk6MqkyAlLJQUwGtRNZw3mItl9oQcr+uo+fi6AsDjMrTcFnzE+PGwHJDDYSvcn57vsJixsN8tFvNOKeK6+oScS9uxqm6tyWiqp6Pc9H8jzrWoec63OCyImNWQh9hTp9kA8q5MNK12a9vj/c0WuXbp/meMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421174; c=relaxed/simple;
	bh=RS1a2jKlP6Um4pXoIf8TpbSTmqLpWTcBdNQYy3zRYvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3qUcg3Dkibburi6DpRgT5/i7UhO14DdCxtsHZi0FOUDx0Z2u5cW7xPKfs1gb3wIujWx0+atZ+5cyr1wE2Q5jRlkDDAGPjlMfzm+bL3nPl+k7Wk8om4FLmzSGfMLQ7EGKewmZdPRZmJoRy4Gzm3B5Ep44u0U1hAdjlwEUuBewMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iyrot6vf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iyrot6vf"
Message-ID: <f222748c-69ce-4c63-826b-4f2d67fd4ec9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774421171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8m1UlG3iIRRlBgtvoGcNRikdN9p/VlMBfCiS8LBaYo=;
	b=Iyrot6vf5QPJwj6J9bNehiB3NQv30fQxskEqAe6/VU5N9+DXb1UzEg1MIgNe9tdPk7xwSw
	9c5oqJ9Gy9ThW0C8e+/Re16YTGNQ8KBUqqJDRWVSASODyURcHsL3LLZUpwt+A3pga90i1n
	XrrxrpPvIk0z4LCZFMa7PKBY/4/vyfc=
Date: Wed, 25 Mar 2026 14:45:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv4 bpf-next 25/25] selftests/bpf: Add tracing multi attach
 rollback tests
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
 <20260324081846.2334094-26-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260324081846.2334094-26-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/3/26 16:18, Jiri Olsa wrote:
> Adding tests for the rollback code when the tracing_multi
> link won't get attached, covering 2 reasons:
> 
>   - wrong btf id passed by user, where all previously allocated
>     trampolines will be released
>   - trampoline for requested function is fully attached (has already
>     maximum programs attached) and the link fails, the rollback code
>     needs to release all previously link-ed trampolines and release
>     them
> 
> We need the bpf_fentry_test* unattached for the tests to pass,
> so the rollback tests are serial.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 213 ++++++++++++++++++
>  .../bpf/progs/tracing_multi_rollback.c        |  43 ++++
>  2 files changed, 256 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index 6917471e329c..6ff0f72f8c46 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -10,6 +10,7 @@
>  #include "tracing_multi_session.skel.h"
>  #include "tracing_multi_fail.skel.h"
>  #include "tracing_multi_bench.skel.h"
> +#include "tracing_multi_rollback.skel.h"
>  #include "trace_helpers.h"
>  
>  static __u64 bpf_fentry_test_cookies[] = {
> @@ -669,6 +670,218 @@ void serial_test_tracing_multi_bench_attach(void)
>  	free(ids);
>  }
>  
> +static void tracing_multi_rollback_run(struct tracing_multi_rollback *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	int err, prog_fd;
> +
> +	prog_fd = bpf_program__fd(skel->progs.test_fentry);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	ASSERT_OK(err, "test_run");
> +
> +	/* make sure the rollback code did not leave any program attached */
> +	ASSERT_EQ(skel->bss->test_result_fentry, 0, "test_result_fentry");
> +	ASSERT_EQ(skel->bss->test_result_fexit, 0, "test_result_fexit");
> +}
> +
> +static void test_rollback_put(void)
> +{
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +	struct tracing_multi_rollback *skel = NULL;
> +	size_t cnt = FUNCS_CNT;
> +	__u32 *ids = NULL;
> +	int err;
> +
> +	skel = tracing_multi_rollback__open();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi_rollback__open"))
> +		return;
> +
> +	bpf_program__set_autoload(skel->progs.test_fentry, true);
> +	bpf_program__set_autoload(skel->progs.test_fexit, true);
> +
> +	err = tracing_multi_rollback__load(skel);
> +	if (!ASSERT_OK(err, "tracing_multi_rollback__load"))
> +		goto cleanup;
> +
> +	ids = get_ids(bpf_fentry_test, cnt, NULL);
> +	if (!ASSERT_OK_PTR(ids, "get_ids"))
> +		goto cleanup;
> +
> +	/*
> +	 * Mangle last id to trigger rollback, which needs to do put
> +	 * on get-ed trampolines.
> +	 */
> +	ids[9] = 0;
> +
> +	opts.ids = ids;
> +	opts.cnt = cnt;
> +
> +	skel->bss->pid = getpid();
> +
> +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> +						NULL, &opts);
> +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> +		goto cleanup;
> +
> +	skel->links.test_fexit = bpf_program__attach_tracing_multi(skel->progs.test_fexit,
> +						NULL, &opts);
> +	if (!ASSERT_ERR_PTR(skel->links.test_fexit, "bpf_program__attach_tracing_multi"))
> +		goto cleanup;
> +
> +	/* We don't really attach any program, but let's make sure. */
> +	tracing_multi_rollback_run(skel);
> +
> +cleanup:
> +	tracing_multi_rollback__destroy(skel);
> +	free(ids);
> +}
> +
> +

NIT: keep one blank line here.

> +static void fillers_cleanup(struct tracing_multi_rollback **skels, int cnt)
> +{
> +	int i;
> +
> +	for (i = 0; i < cnt; i++)
> +		tracing_multi_rollback__destroy(skels[i]);
> +
> +	free(skels);
> +}
> +
> +static struct tracing_multi_rollback *extra_load_and_link(void)
> +{
> +	struct tracing_multi_rollback *skel;
> +	int err;
> +
> +	skel = tracing_multi_rollback__open();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi_rollback__open"))
> +		goto cleanup;
> +
> +	bpf_program__set_autoload(skel->progs.extra, true);
> +
> +	err = tracing_multi_rollback__load(skel);
> +	if (!ASSERT_OK(err, "tracing_multi_rollback__load"))
> +		goto cleanup;
> +
> +	skel->links.extra = bpf_program__attach_trace(skel->progs.extra);
> +	if (!ASSERT_OK_PTR(skel->links.extra, "bpf_program__attach_trace"))
> +		goto cleanup;
> +
> +	return skel;
> +
> +cleanup:
> +	tracing_multi_rollback__destroy(skel);
> +	return NULL;
> +}
> +
> +static struct tracing_multi_rollback **fillers_load_and_link(int max)
> +{
> +	struct tracing_multi_rollback **skels, *skel;
> +	int i, err;
> +
> +	skels = calloc(max + 1, sizeof(*skels));
> +	if (!ASSERT_OK_PTR(skels, "calloc"))
> +		return NULL;
> +
> +	for (i = 0; i < max; i++) {
> +		skel = skels[i] = tracing_multi_rollback__open();
> +		if (!ASSERT_OK_PTR(skels[i], "tracing_multi_rollback__open"))
> +			goto cleanup;
> +
> +		bpf_program__set_autoload(skel->progs.filler, true);
> +
> +		err = tracing_multi_rollback__load(skel);
> +		if (!ASSERT_OK(err, "tracing_multi_rollback__load"))
> +			goto cleanup;
> +
> +		skel->links.filler = bpf_program__attach_trace(skel->progs.filler);
> +		if (!ASSERT_OK_PTR(skels[i]->links.filler, "bpf_program__attach_trace"))
> +			goto cleanup;
> +	}
> +
> +	return skels;
> +
> +cleanup:
> +	fillers_cleanup(skels, i);
> +	return NULL;
> +}
> +
> +static void test_rollback_unlink(void)
> +{
> +	struct tracing_multi_rollback *skel, *extra;
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +	struct tracing_multi_rollback **fillers;
> +	size_t cnt = FUNCS_CNT;
> +	__u32 *ids = NULL;
> +	int err, max;
> +
> +	max = get_bpf_max_tramp_links();
> +	if (!ASSERT_GE(max, 1, "bpf_max_tramp_links"))
> +		return;
> +
> +	/* Attach maximum allowed programs to bpf_fentry_test10 */
> +	fillers = fillers_load_and_link(max);
> +	if (!ASSERT_OK_PTR(fillers, "fillers_load_and_link"))
> +		return;
> +
> +	extra = extra_load_and_link();
> +	if (!ASSERT_OK_PTR(extra, "extra_load_and_link"))

Should cleanup fillers here?

Thanks,
Leon

> +		return;
> +
> +	skel = tracing_multi_rollback__open();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi_rollback__open"))
> +		goto cleanup;
> +
[...]

