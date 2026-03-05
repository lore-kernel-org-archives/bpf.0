Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0929B233;
	Thu,  5 Mar 2026 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772695813; cv=none; b=EP+uP7nfzdhyEVapxK1DPxJ1pHlwOTCjxz714U8y6pQnfEe111NWjihoYEl46ohvKVzZdFXHXMG1i0RhMa34obxSzK7/ydeDo5bNDc9AYyAKWLMjpTQF7S6ECeuS1AKmE9PQo64mQguin/MHfIz+9yheHod3thKsUdPhoeF/Piw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772695813; c=relaxed/simple;
	bh=lTzC3DOe3FWjuf5axLH/2f9FZMU8FQpjojeYB+xavQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5KU7hCxfGcdqX1oxkb1tkkc39zDqBltYqFu6Q8j2oWVNjucBmhubzkrwJ1qYA324mW1kt26Y8kIzNBbMKoYcIvdrcRN8Dj9Iv+Ywh0abHGZGg1Cqn5BA2GBsETpVfs9LYl8AjHZN/bvLF8x/jdgx/+VnyEWwRhG5GVDW9+qNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pHM8ePeM; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pHM8ePeM"
Message-ID: <30ebc83a-8f17-44fc-89a6-037e826f6c70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772695809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zkrpq1MReRvWW8x3HssiZAsOMiRgFEXzVCzorhAJJaI=;
	b=pHM8ePeMJgcZM1DJ2exaS0Qv+n3ixnbXF/93qDO5dpmKJYldHGKWCfFP9BV6+Dubqx0a5x
	/4CNALdZmDXPAhrxbW/hOHU6v8mwSM7v8YjYIkAIS1/Pdw4TKy+O5Qw+puu2nlvr+yK8nG
	ZBEXTzS18s3P0ioRo6u7y77YCACMR7o=
Date: Thu, 5 Mar 2026 15:30:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bpf-next 22/23] selftests/bpf: Add tracing multi attach
 benchmark test
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
 <20260304222141.497203-23-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260304222141.497203-23-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/3/26 06:21, Jiri Olsa wrote:
> Adding benchmark test that attaches to (almost) all allowed tracing
> functions and display attach/detach times.
> 
>   # ./test_progs -t tracing_multi_bench_attach -v
>   bpf_testmod.ko is already unloaded.
>   Loading bpf_testmod.ko...
>   Successfully loaded bpf_testmod.ko.
>   serial_test_tracing_multi_bench_attach:PASS:btf__load_vmlinux_btf 0 nsec
>   serial_test_tracing_multi_bench_attach:PASS:tracing_multi_bench__open_and_load 0 nsec
>   serial_test_tracing_multi_bench_attach:PASS:get_syms 0 nsec
>   serial_test_tracing_multi_bench_attach:PASS:bpf_program__attach_tracing_multi 0 nsec
>   serial_test_tracing_multi_bench_attach: found 51186 functions
>   serial_test_tracing_multi_bench_attach: attached in   1.295s
>   serial_test_tracing_multi_bench_attach: detached in   0.243s
>   #507     tracing_multi_bench_attach:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>   Successfully unloaded bpf_testmod.ko.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 178 ++++++++++++++++++
>  .../selftests/bpf/progs/tracing_multi_bench.c |  13 ++
>  2 files changed, 191 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index d64d90f4e086..585d6b646d20 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -9,6 +9,7 @@
>  #include "tracing_multi_intersect.skel.h"
>  #include "tracing_multi_session.skel.h"
>  #include "tracing_multi_fail.skel.h"
> +#include "tracing_multi_bench.skel.h"
>  #include "trace_helpers.h"
>  
>  static __u64 bpf_fentry_test_cookies[] = {
> @@ -543,6 +544,183 @@ static void test_attach_api_fails(void)
>  	tracing_multi_fail__destroy(skel);
>  }
>  
> +/*
> + * Skip several kernel symbols that might not be safe or could cause delays.
> + */
> +static bool skip_symbol(char *name)
> +{
> +	if (!strcmp(name, "arch_cpu_idle"))
> +		return true;
> +	if (!strcmp(name, "default_idle"))
> +		return true;
> +	if (!strncmp(name, "rcu_", 4))
> +		return true;
> +	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
> +		return true;
> +	if (strstr(name, "rcu"))
> +		return true;
> +	if (strstr(name, "trace"))
> +		return true;
> +	if (strstr(name, "irq"))
> +		return true;
> +	if (strstr(name, "bpf_lsm_"))
> +		return true;
> +	if (!strcmp(name, "migrate_enable"))
> +		return true;
> +	if (!strcmp(name, "migrate_disable"))
> +		return true;
> +	if (!strcmp(name, "preempt_count_sub"))
> +		return true;
> +	if (!strcmp(name, "preempt_count_add"))
> +		return true;
> +	return false;
> +}

These names intersect with the list in trace_helpers.c::skip_entry().

It would be better to move this list to trace_helpers.c.

> +
> +#define MAX_BPF_FUNC_ARGS 12
> +
> +static bool btf_type_is_modifier(const struct btf_type *t)
> +{
> +	switch (BTF_INFO_KIND(t->info)) {
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_TYPE_TAG:
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static bool is_allowed_func(const struct btf *btf, const struct btf_type *t)
> +{
> +	const struct btf_type *proto;
> +	const struct btf_param *args;
> +	__u32 i, nargs;
> +	__s64 ret;
> +
> +	proto = btf_type_by_id(btf, t->type);
> +	if (BTF_INFO_KIND(proto->info) != BTF_KIND_FUNC_PROTO)
> +		return false;
> +
> +	args = (const struct btf_param *)(proto + 1);
> +	nargs = btf_vlen(proto);
> +	if (nargs > MAX_BPF_FUNC_ARGS)
> +		return false;
> +
> +	t = btf__type_by_id(btf, proto->type);
> +	while (t && btf_type_is_modifier(t))
> +		t = btf__type_by_id(btf, t->type);
> +
> +	if (btf_is_struct(t) || btf_is_union(t))
> +		return false;
> +
> +	for (i = 0; i < nargs; i++) {
> +		/* No support for variable args */
> +		if (i == nargs - 1 && args[i].type == 0)
> +			return false;
> +
> +		/* No support of struct argument size greater than 16 bytes */
> +		ret = btf__resolve_size(btf, args[i].type);
> +		if (ret < 0 || ret > 16)
> +			return false;
> +	}
> +
> +	return true;
> +}

NIT: can we avoid copy/pasting the code snippet from libbpf.c?

Thanks,
Leon

[...]

