Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723E286D4D
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360939; cv=none; b=GJrc/ZUjoTPxyLDWBv7/z2K0Aw3am5wsqPTgpWfdN2wRIOSBV0UmDx2BfevbX1MotSFx1QMqglGXhz+/EsMzWDDOkTRlNow4DdBY0XWb0F2FSNs8xHngWxzo7wOeIK0T/xTb3QRWIqF+Jo59jDDfjHZ/5qWARfRmRqLaxL6kmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360939; c=relaxed/simple;
	bh=IO2cIZeh0eueHLUy6z3YWVmYOZRUMUf/7pIzd9m8Kn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJrx4fm6HfDK19YSJ07+G2pQ08yP3ObvlucJO2JuUgupZ9Fi2wKUJY1wqeRN2og8fXpcTXCYdRx/gR+qKCu7PF+vzo5QX4W403BZfbk5/rHL7rdO/CgoiPaoTVODPdlh1dLQd6B/hPIiu4ZXKgreCB3GGn7MsMWfRR2rgPwZPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oJb2UVV5; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oJb2UVV5"
Message-ID: <8c1527fd-7c57-488a-b4a6-3b763f3b5746@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771360934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jEHpWQCR0URevObzP8/KcPWP3187ax1m2TQb7+v11Y=;
	b=oJb2UVV5kYxKFizOkD1wdGSFrChwRtvVryAdOD31XJqv7Rylpmo3Vrcjh+N8qeh69zlt9Z
	I7ct+376LPuiqnlhy0+wWG5+NDqh8SyB4MQlDwEFTLEjMOnvzkgjgt3VGtndNWCe+HePYm
	5+ZipyVwNGAqSvD6hTxQz+3jgc6DM2s=
Date: Tue, 17 Feb 2026 12:42:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 04/14] selftests/bpf: Refactor bpf_get_ksyms()
 trace helper
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-5-ihor.solodrai@linux.dev> <aY25gB6NDmlPJPUB@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aY25gB6NDmlPJPUB@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/12/26 3:29 AM, Jiri Olsa wrote:
> On Wed, Feb 11, 2026 at 05:13:46PM -0800, Ihor Solodrai wrote:
>> ASAN reported a memory leak in bpf_get_ksyms(): it allocates a struct
>> ksyms internally and never frees it.
>>
>> Moe struct ksyms to trace_helpers.h and return it from the
>> bpf_get_ksyms(), giving ownership to the caller. Add filtered_syms and
>> filtered_cnt fields to the ksyms to hold the filtered array of
>> symbols, previously returned by bpf_get_ksyms().
>>
>> Fixup the call sites: kprobe_multi_test and bench_trigger.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  .../selftests/bpf/benchs/bench_trigger.c      |  9 ++++----
>>  .../bpf/prog_tests/kprobe_multi_test.c        | 12 ++++------
>>  tools/testing/selftests/bpf/trace_helpers.c   | 23 ++++++++++---------
>>  tools/testing/selftests/bpf/trace_helpers.h   | 11 +++++++--
>>  4 files changed, 30 insertions(+), 25 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
>> index aeec9edd3851..7231b88cf21a 100644
>> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
>> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
>> @@ -230,8 +230,7 @@ static void trigger_fentry_setup(void)
>>  static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
>>  {
>>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
>> -	char **syms = NULL;
>> -	size_t cnt = 0;
>> +	struct ksyms *ksyms = NULL;
>>  
>>  	/* Some recursive functions will be skipped in
>>  	 * bpf_get_ksyms -> skip_entry, as they can introduce sufficient
>> @@ -241,13 +240,13 @@ static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
>>  	 * So, don't run the kprobe-multi-all and kretprobe-multi-all on
>>  	 * a debug kernel.
>>  	 */
>> -	if (bpf_get_ksyms(&syms, &cnt, true)) {
>> +	if (bpf_get_ksyms(&ksyms, true)) {
>>  		fprintf(stderr, "failed to get ksyms\n");
>>  		exit(1);
>>  	}
>>  
>> -	opts.syms = (const char **) syms;
>> -	opts.cnt = cnt;
>> +	opts.syms = (const char **)ksyms->filtered_syms;
>> +	opts.cnt = ksyms->filtered_cnt;
>>  	opts.retprobe = kretprobe;
>>  	/* attach empty to all the kernel functions except bpf_get_numa_node_id. */
>>  	if (!bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts)) {
> 
> hi,
> 
> missing free_kallsyms_local call in here ?

Yeap, thanks.

> 
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> index 9caef222e528..f81dcd609ee9 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> @@ -456,25 +456,23 @@ static void test_kprobe_multi_bench_attach(bool kernel)
>>  {
>>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
>>  	struct kprobe_multi_empty *skel = NULL;
>> -	char **syms = NULL;
>> -	size_t cnt = 0;
>> +	struct ksyms *ksyms = NULL;
>>  
>> -	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, kernel), "bpf_get_ksyms"))
>> +	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, kernel), "bpf_get_ksyms"))
>>  		return;
>>  
>>  	skel = kprobe_multi_empty__open_and_load();
>>  	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
>>  		goto cleanup;
>>  
>> -	opts.syms = (const char **) syms;
>> -	opts.cnt = cnt;
>> +	opts.syms = (const char **)ksyms->filtered_syms;
>> +	opts.cnt = ksyms->filtered_cnt;
>>  
>>  	do_bench_test(skel, &opts);
>>  
>>  cleanup:
>>  	kprobe_multi_empty__destroy(skel);
>> -	if (syms)
>> -		free(syms);
>> +	free_kallsyms_local(ksyms);
>>  }
>>  
>>  static void test_kprobe_multi_bench_attach_addr(bool kernel)
>> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
>> index eeaab7013ca2..0e63daf83ed5 100644
>> --- a/tools/testing/selftests/bpf/trace_helpers.c
>> +++ b/tools/testing/selftests/bpf/trace_helpers.c
>> @@ -24,12 +24,6 @@
>>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>>  
>> -struct ksyms {
>> -	struct ksym *syms;
>> -	size_t sym_cap;
>> -	size_t sym_cnt;
>> -};
>> -
>>  static struct ksyms *ksyms;
>>  static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
>>  
>> @@ -54,6 +48,8 @@ void free_kallsyms_local(struct ksyms *ksyms)
>>  	if (!ksyms)
>>  		return;
>>  
>> +	free(ksyms->filtered_syms);
>> +
>>  	if (!ksyms->syms) {
>>  		free(ksyms);
>>  		return;
>> @@ -610,7 +606,7 @@ static int search_kallsyms_compare(const void *p1, const struct ksym *p2)
>>  	return compare_name(p1, p2->name);
>>  }
>>  
>> -int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
>> +int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel)
>>  {
>>  	size_t cap = 0, cnt = 0;
>>  	char *name = NULL, *ksym_name, **syms = NULL;
>> @@ -637,8 +633,10 @@ int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
>>  	else
>>  		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
>>  
>> -	if (!f)
>> +	if (!f) {
>> +		free_kallsyms_local(ksyms);
>>  		return -EINVAL;
>> +	}
>>  
>>  	map = hashmap__new(symbol_hash, symbol_equal, NULL);
>>  	if (IS_ERR(map)) {
>> @@ -679,15 +677,18 @@ int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
>>  		syms[cnt++] = ksym_name;
>>  	}
>>  
>> -	*symsp = syms;
>> -	*cntp = cnt;
>> +	ksyms->filtered_syms = syms;
>> +	ksyms->filtered_cnt = cnt;
>> +	*ksymsp = ksyms;
>>  
>>  error:
>>  	free(name);
>>  	fclose(f);
>>  	hashmap__free(map);
>> -	if (err)
>> +	if (err) {
>>  		free(syms);
>> +		free_kallsyms_local(ksyms);
>> +	}
> 
> I think we could just call free_kallsyms_local unconditionally in here
> and fix callers to free syms pointer? seems easier than adding filtered*
> fields to ksyms

The strings in filtered_syms are ksyms->syms[i].name pointers (not
copied). I didn't want to do another strdup, and I also didn't like
passing three out parameters to bpf_get_ksyms().

So I decided to consolidate the data gathered by bpf_get_ksyms() in
struct ksyms. ksyms->filtered_syms essentially is a view into the
ksyms->syms, and it can be unused too.

Does this make sense?

> 
> thanks,
> jirak
> 
> 
>>  	return err;
>>  }
>>  
>> diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
>> index a5576b2dfc26..d5bf1433675d 100644
>> --- a/tools/testing/selftests/bpf/trace_helpers.h
>> +++ b/tools/testing/selftests/bpf/trace_helpers.h
>> @@ -23,7 +23,14 @@ struct ksym {
>>  	long addr;
>>  	char *name;
>>  };
>> -struct ksyms;
>> +
>> +struct ksyms {
>> +	struct ksym *syms;
>> +	size_t sym_cap;
>> +	size_t sym_cnt;
>> +	char **filtered_syms;
>> +	size_t filtered_cnt;
>> +};
>>  
>>  typedef int (*ksym_cmp_t)(const void *p1, const void *p2);
>>  typedef int (*ksym_search_cmp_t)(const void *p1, const struct ksym *p2);
>> @@ -53,7 +60,7 @@ ssize_t get_rel_offset(uintptr_t addr);
>>  
>>  int read_build_id(const char *path, char *build_id, size_t size);
>>  
>> -int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel);
>> +int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel);
>>  int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
>>  
>>  #endif
>> -- 
>> 2.53.0
>>
>>

