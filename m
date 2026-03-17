Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE132989B0
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717681; cv=none; b=YMHkZQgas2/FMV23WFgSfo2yNkeLDjanhNmKXuT7MnTwpqWVJxygAw6Tb0b5cSNKAanOGjMzwWvZi9aV3pvBZP+PhY7tHhUQdAf/gDTXBjW4oCjUxnQyaO6QJ0JbMh+N+jNwJXmxnDtsLpYEO5D7jCrUK1x0bs9qG+HLwfe2aEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717681; c=relaxed/simple;
	bh=nRVT63U/suVtTwWsOaBcLASXlgFsgbhCbeTu7mw7/Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUumwz+pD/x306ADrWsJ/iqYhx1dpAk4p/qL0Cbl6yoer+vI6AEEHuSOUNvGUm6S6p/ua8PKwcdJUpe7aTxUFUpSJPzcbyoOxsw8KA3gOP0FuTcWThog5/U7Z7Jdg13+HkieYgjTESvascf4eunRFWPe3zUprT1Qb4yXCPZTWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UO64AzCo; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UO64AzCo"
Message-ID: <d1bfc6ec-3234-4515-a68f-ff48ab9c1570@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773717668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19ewDUB5WrZgkPbuJEBh4JSwuTDp05KGi8MJj49q/Hw=;
	b=UO64AzCo+lBEhKeyTAUiTQOZbmoW0lvFin0FXcZGuXBQOxa4QpspmLbRcGRUglLh4UNOtL
	78gLP3W3HwZM35o8V+9s+9o8AVy/wSMXbd2w2iu1LBKoEP/ASurwq3WOBzmmC3ld1C9RCO
	CEKudhLtR8ZKwh/o/xi3pHfxFCzvVww=
Date: Tue, 17 Mar 2026 11:20:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 24/24] selftests/bpf: Add tracing multi attach
 rollback tests
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-25-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260316075138.465430-25-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/3/26 15:51, Jiri Olsa wrote:
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
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 181 ++++++++++++++++++
>  .../bpf/progs/tracing_multi_rollback.c        |  38 ++++
>  2 files changed, 219 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index a0fcda51bb6c..10b8cc6b368b 100644
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
> @@ -649,6 +650,186 @@ void serial_test_tracing_multi_bench_attach(void)
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
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +	struct tracing_multi_rollback **fillers;
> +	struct tracing_multi_rollback *skel;
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
> +	skel = tracing_multi_rollback__open();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi_rollback__open"))
> +		goto cleanup;
> +
> +	bpf_program__set_autoload(skel->progs.test_fentry, true);
> +	bpf_program__set_autoload(skel->progs.test_fexit, true);
> +
> +	/*
> +	 * Attach tracing_multi link on bpf_fentry_test1-10, which will
> +	 * fail on bpf_fentry_test10 function, because it already has
> +	 * maximum allowed programs attached.
> +	 *
> +	 * The rollback needs to unlink already link-ed trampolines and
> +	 * put all of them.
> +	 */
> +	err = tracing_multi_rollback__load(skel);
> +	if (!ASSERT_OK(err, "tracing_multi_rollback__load"))
> +		goto cleanup;
> +
> +	ids = get_ids(bpf_fentry_test, cnt, NULL);
> +	if (!ASSERT_OK_PTR(ids, "get_ids"))
> +		goto cleanup;
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
> +	tracing_multi_rollback_run(skel);
> +
> +cleanup:
	tracing_multi_rollback__destroy(skel); is missed to destroy skel?

Thanks,
Leon

> +	fillers_cleanup(fillers, max);
> +	free(ids);
> +}
> +
> +void serial_test_tracing_multi_attach_rollback(void)
> +{
> +	if (test__start_subtest("put"))
> +		test_rollback_put();
> +	if (test__start_subtest("unlink"))
> +		test_rollback_unlink();
> +}
> +
>  void test_tracing_multi_test(void)
>  {
>  #ifndef __x86_64__
> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_rollback.c b/tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
> new file mode 100644
> index 000000000000..eb27869f551a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdbool.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int pid = 0;
> +
> +__u64 test_result_fentry = 0;
> +__u64 test_result_fexit = 0;
> +
> +SEC("?fentry.multi")
> +int BPF_PROG(test_fentry)
> +{
> +	if (bpf_get_current_pid_tgid() >> 32 != pid)
> +		return 0;
> +
> +	test_result_fentry++;
> +	return 0;
> +}
> +
> +SEC("?fexit.multi")
> +int BPF_PROG(test_fexit)
> +{
> +	if (bpf_get_current_pid_tgid() >> 32 != pid)
> +		return 0;
> +
> +	test_result_fexit++;
> +	return 0;
> +}
> +
> +SEC("?fentry/bpf_fentry_test10")
> +int BPF_PROG(filler)
> +{
> +	return 0;
> +}

