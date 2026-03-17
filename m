Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871D26ED40
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716977; cv=none; b=KeUD5vOfrwvgJenpeJ2Mb/OiFyBLQspfR2OjeY+4LillVy8vDZtvJF+o7ZO9jcb/VgGqTHzEN3zrjXEYu3jKyqCAQduqzVvkm80kT/iSAGjpe4ce5YtndF89tqhvN/ER20efwzaDktn3SkZ31qa3hck5dAI5vAUJgUOpy5QlcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716977; c=relaxed/simple;
	bh=kNtpa/Z7x6yVNQEMifgwBJcrDXNK1LY31jj7PvIaM4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHY1RMHl5Z9eWiGb93Ig9KW6C4WdXiAbuHM309ZKk/T/esDE7BQehvMyDD4RBFHzNtMMCPm+K38EMS5aDwMySH83zOjFLiXQ1CN5QUQ4Q3oAoohmdf/bbqkK9A0oE8aWoZQbTdErbmmjTewD4xIsiqynueG/PyK4re4nVrVu/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aI79zvzW; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aI79zvzW"
Message-ID: <ed557f33-7f5b-4af2-aa4b-8afe22b55a57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773716974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xs3+6/MXCtPlx2ImZw4K3N5Mm4UPOgMLSwu+E6RGNb0=;
	b=aI79zvzW3r6d0+qq68ypEZLag68FteDUn0kHnVwKfpSV7miWhuKMiB7zqxsa5h2mrwza/v
	WkZ2ivk0EZfdXMFNasnXmyISi5hG5x0SYJpvO3NHaIg8l6z2m/9yVLsbfa3aNujUXHa5xR
	JbjecjI2L2EhkxT1VQn0Rszin6e0qZo=
Date: Tue, 17 Mar 2026 11:09:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 23/24] selftests/bpf: Add tracing multi attach
 benchmark test
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-24-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260316075138.465430-24-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/3/26 15:51, Jiri Olsa wrote:
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
> Exporting skip_entry as is_unsafe_function and usign it in the test.
                                                 ^ using

> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 97 +++++++++++++++++++
>  .../selftests/bpf/progs/tracing_multi_bench.c | 13 +++
>  tools/testing/selftests/bpf/trace_helpers.c   |  6 +-
>  tools/testing/selftests/bpf/trace_helpers.h   |  1 +
>  4 files changed, 114 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index 9f4c5af88e21..a0fcda51bb6c 100644
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
> @@ -552,6 +553,102 @@ static void test_attach_api_fails(void)
>  	tracing_multi_fail__destroy(skel);
>  }
>  
> +void serial_test_tracing_multi_bench_attach(void)
> +{
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +	struct tracing_multi_bench *skel = NULL;
> +	long attach_start_ns, attach_end_ns;
> +	long detach_start_ns, detach_end_ns;
> +	double attach_delta, detach_delta;
> +	struct bpf_link *link = NULL;
> +	size_t i, cap = 0, cnt = 0;
> +	struct ksyms *ksyms = NULL;
> +	void *root = NULL;
> +	__u32 *ids = NULL;
> +	__u32 nr, type_id;
> +	struct btf *btf;
> +	int err;
> +
> +#ifndef __x86_64__
> +	test__skip();
> +	return;
> +#endif
> +
> +	btf = btf__load_vmlinux_btf();
> +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> +		return;
> +
> +	skel = tracing_multi_bench__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi_bench__open_and_load"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, true), "get_syms"))
> +		goto cleanup;
> +
> +	/* Get all ftrace 'safe' symbols.. */
> +	for (i = 0; i < ksyms->filtered_cnt; i++) {
> +		if (is_unsafe_function(ksyms->filtered_syms[i]))
> +			continue;
> +		tsearch(&ksyms->filtered_syms[i], &root, compare);
                ^ missing tdestroy() to free tree nodes?

> +	}
> +
> +	/* ..and filter them through BTF and btf_type_is_traceable_func. */
> +	nr = btf__type_cnt(btf);
> +	for (type_id = 1; type_id < nr; type_id++) {
> +		const struct btf_type *type;
> +		const char *str;
> +
> +		type = btf__type_by_id(btf, type_id);
> +		if (!type)
> +			break;
> +
> +		if (BTF_INFO_KIND(type->info) != BTF_KIND_FUNC)
> +			continue;
> +
> +		str = btf__name_by_offset(btf, type->name_off);
> +		if (!str)
> +			break;
> +
> +		if (!tfind(&str, &root, compare))
> +			continue;
> +
> +		if (!btf_type_is_traceable_func(btf, type))
> +			continue;
> +
> +		err = libbpf_ensure_mem((void **) &ids, &cap, sizeof(*ids), cnt + 1);
> +		if (err)
> +			goto cleanup;
> +
> +		ids[cnt++] = type_id;
> +	}
> +
> +	opts.ids = ids;
> +	opts.cnt = cnt;
> +
> +	attach_start_ns = get_time_ns();
> +	link = bpf_program__attach_tracing_multi(skel->progs.bench, NULL, &opts);
> +	attach_end_ns = get_time_ns();
> +
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
> +		goto cleanup;
> +
> +	detach_start_ns = get_time_ns();
> +	bpf_link__destroy(link);
> +	detach_end_ns = get_time_ns();
> +
> +	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
> +	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
> +
> +	printf("%s: found %lu functions\n", __func__, cnt);
> +	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> +	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> +
> +cleanup:
> +	tracing_multi_bench__destroy(skel);
> +	free_kallsyms_local(ksyms);
> +	free(ids);
> +}
> +
>  void test_tracing_multi_test(void)
>  {
>  #ifndef __x86_64__
> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_bench.c b/tools/testing/selftests/bpf/progs/tracing_multi_bench.c
> new file mode 100644
> index 000000000000..067ba668489b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_bench.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdbool.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("fentry.multi")
> +int BPF_PROG(bench)
> +{
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index 0e63daf83ed5..3bf600f3271b 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -548,7 +548,7 @@ static const char * const trace_blacklist[] = {
>  	"bpf_get_numa_node_id",
>  };
>  
> -static bool skip_entry(char *name)
> +bool is_unsafe_function(char *name)
NIT:                       ^ should const char * ?

Thanks,
Leon

>  {
>  	int i;
>  
> @@ -651,7 +651,7 @@ int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel)
>  		free(name);
>  		if (sscanf(buf, "%ms$*[^\n]\n", &name) != 1)
>  			continue;
> -		if (skip_entry(name))
> +		if (is_unsafe_function(name))
>  			continue;
>  
>  		ks = search_kallsyms_custom_local(ksyms, name, search_kallsyms_compare);
> @@ -728,7 +728,7 @@ int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
>  		free(name);
>  		if (sscanf(buf, "%p %ms$*[^\n]\n", &addr, &name) != 2)
>  			continue;
> -		if (skip_entry(name))
> +		if (is_unsafe_function(name))
>  			continue;
>  
>  		if (cnt == max_cnt) {
> diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
> index d5bf1433675d..d93be322675d 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.h
> +++ b/tools/testing/selftests/bpf/trace_helpers.h
> @@ -63,4 +63,5 @@ int read_build_id(const char *path, char *build_id, size_t size);
>  int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel);
>  int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
>  
> +bool is_unsafe_function(char *name);
>  #endif

