Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878092C026F
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716796; cv=none; b=e1R9OkBvl8B1ujTGFVOR1zvBi4NJKr46lXgDrQRgVr7m9yDi/vIEQ8p3N0XgtMYIfv7yXfcZo3j7XNOYkZTAjF6viTIWxi8LX1gJHhKRYSqx0Ryz+XwjEdysdYiOD4VoX+kVPQcuEVI3ODtp6NECOddInqgVX/o44dHCj5hXGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716796; c=relaxed/simple;
	bh=EYuL1TpjTP7GskRZcjv7J0rRkPAQ7JQiZ6uga+6jRyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROcp48sooO3XIpR9NXdm/Gn7C7sZepkAYEjIOsKw2pGUoEuwsiHvd37XJ/jw7Koqw1XRJQGFvxRzUhCnQW2Nvrqra6IpTE7YRDL2tX/+biYCT5H/ifHNlRlHtUtEVq/0cAnUYZALjzlOklRr5W817W6bpNpW6n+InGN9h5CwVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=auo4CtAV; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="auo4CtAV"
Message-ID: <e01da3b0-ff72-403d-8f3f-4312d35e6ec7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773716793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=036wom2S+ZCexKW/c/J0NhnHMkPiCEnvGzebmbnfDoI=;
	b=auo4CtAVyO2fgsq8RXpATHqVK54lubJ7H9s86FIzIys6XsPES5Rzmi7qf+ulGpSpwT6JEN
	YzpKy8vtk0afsLlFynZ7xZ1Xqjx3K3KLUIfbwRwwZbzH2psVJsCGiHgB2sPa6zsU+qGybE
	B0me29PInQVxRCb58WSS5hqNrbtb4yo=
Date: Tue, 17 Mar 2026 11:06:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 20/24] selftests/bpf: Add tracing multi cookies
 test
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-21-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260316075138.465430-21-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/3/26 15:51, Jiri Olsa wrote:
> Adding tests for using cookies on tracing multi link.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 23 +++++++++++++++++--
>  .../selftests/bpf/progs/tracing_multi_check.c | 15 +++++++++++-
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index b7818f438d6e..f14a936a4667 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -9,6 +9,19 @@
>  #include "tracing_multi_intersect.skel.h"
>  #include "trace_helpers.h"
>  
> +static __u64 bpf_fentry_test_cookies[] = {
> +	8,  /* bpf_fentry_test1 */
> +	9,  /* bpf_fentry_test2 */
> +	7,  /* bpf_fentry_test3 */
> +	5,  /* bpf_fentry_test4 */
> +	4,  /* bpf_fentry_test5 */
> +	2,  /* bpf_fentry_test6 */
> +	3,  /* bpf_fentry_test7 */
> +	1,  /* bpf_fentry_test8 */
> +	10, /* bpf_fentry_test9 */
> +	6,  /* bpf_fentry_test10 */
> +};
> +
>  static const char * const bpf_fentry_test[] = {
>  	"bpf_fentry_test1",
>  	"bpf_fentry_test2",
> @@ -204,7 +217,7 @@ static void test_link_api_pattern(void)
>  	tracing_multi__destroy(skel);
>  }
>  
> -static void test_link_api_ids(void)
> +static void test_link_api_ids(bool test_cookies)
>  {
>  	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
>  	struct tracing_multi *skel;
> @@ -216,6 +229,7 @@ static void test_link_api_ids(void)
>  		return;
>  
>  	skel->bss->pid = getpid();
> +	skel->bss->test_cookies = test_cookies;
>  
>  	ids = get_ids(bpf_fentry_test, cnt, NULL);
>  	if (!ASSERT_OK_PTR(ids, "get_ids"))
> @@ -224,6 +238,9 @@ static void test_link_api_ids(void)
>  	opts.ids = ids;
>  	opts.cnt = cnt;
>  
> +	if (test_cookies)
> +		opts.cookies = bpf_fentry_test_cookies;
> +
>  	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
>  						NULL, &opts);
>  	if (!ASSERT_OK_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> @@ -437,7 +454,7 @@ void test_tracing_multi_test(void)
>  	if (test__start_subtest("link_api_pattern"))
>  		test_link_api_pattern();
>  	if (test__start_subtest("link_api_ids"))
> -		test_link_api_ids();
> +		test_link_api_ids(false);
>  	if (test__start_subtest("module_skel_api"))
>  		test_module_skel_api();
>  	if (test__start_subtest("module_link_api_pattern"))
> @@ -446,4 +463,6 @@ void test_tracing_multi_test(void)
>  		test_module_link_api_ids();
>  	if (test__start_subtest("intersect"))
>  		test_intersect();
> +	if (test__start_subtest("cookies"))
> +		test_link_api_ids(true);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> index 0e3248312dd5..e6047d5a078a 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> @@ -7,6 +7,7 @@
>  char _license[] SEC("license") = "GPL";
>  
>  int pid = 0;
> +bool test_cookies = false;
>  
>  extern const void bpf_fentry_test1 __ksym;
>  extern const void bpf_fentry_test2 __ksym;
> @@ -28,7 +29,7 @@ extern const void bpf_testmod_fentry_test11 __ksym;
>  void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
>  {
>  	void *ip = (void *) bpf_get_func_ip(ctx);
> -	__u64 value = 0, ret = 0;
> +	__u64 value = 0, ret = 0, cookie = 0;
>  	long err = 0;
>  
>  	if (bpf_get_current_pid_tgid() >> 32 != pid)
> @@ -36,6 +37,8 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
>  
>  	if (is_return)
>  		err |= bpf_get_func_ret(ctx, &ret);
> +	if (test_cookies)
> +		cookie = test_cookies ? bpf_get_attach_cookie(ctx) : 0;
                         ^ dup test_cookies check ? Can drop this one.

Thanks,
Leon

[...]

