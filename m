Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CBEEB3
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716709; cv=none; b=HoAIO4U6MqSf3pyjq85hDNNLg3hjSCS9aDiav8tX9ek9rJljknv7dTQpnM/NQM9OCpxhh421TE/H/4PfqaHHdA+0eLjO0wE0xpik8KCLmsXh0ArL7ivjMW/3XESeycMeqFTurNW3wyQJ1USgskmvpG7VDYEBNSblz5Aj0MtoT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716709; c=relaxed/simple;
	bh=Ifuig6/SDB2VvMYkgxQgcrzZfuhs0MKNNNS/qFY7+rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCH34H5wlj7HwmzBp05R4B4pmPN2X2+rLns7j5XnG4fZZzpsn2KBDRuH+dK+sHjiIXGSyEQ8YwTWU3ZxFP5G71Y0GIDJOEVzm7ZOoQeqrmtJqhv8wdUKI81x4yYYV5de+AW9qdum+0qQ55Cca++SHLDv/Ew6R74Z4d6DjOu1j1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jT+QJXHV; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jT+QJXHV"
Message-ID: <39113fe0-2e9f-4f11-afe9-efb676a48149@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773716705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3K8xqYYujevrwbpcWTaZzUPvFrMA65gfvrfVnV2ncmg=;
	b=jT+QJXHV4cxl6Kcpmbw3P5yPL2XxyKvkRR7itBxHxO6fMxHySTppPMx2XCIu8xjqlyB00U
	cCKx/7WMklGyLP9d9tp/CHxn9lIlXxuxJIsUXIBwg9d3gx4Suf3jq03gNbt1OOytGFBOSK
	kQyM6/Scj+lMZHJdLyVSDBjDilwPuIc=
Date: Tue, 17 Mar 2026 11:04:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 17/24] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-18-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260316075138.465430-18-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/3/26 15:51, Jiri Olsa wrote:
> Adding tests for tracing_multi link attachment via all possible
> libbpf apis - skeleton, function pattern and btf ids.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |   3 +-
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 245 ++++++++++++++++++
>  .../bpf/progs/tracing_multi_attach.c          |  40 +++
>  .../selftests/bpf/progs/tracing_multi_check.c | 150 +++++++++++
>  4 files changed, 437 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 869b582b1d1f..e09beba5674e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -485,7 +485,7 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
>  LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
>  		linked_vars.skel.h linked_maps.skel.h 			\
>  		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
> -		test_usdt.skel.h
> +		test_usdt.skel.h tracing_multi.skel.h
>  
>  LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
>  	core_kern.c core_kern_overflow.c test_ringbuf.c			\
> @@ -511,6 +511,7 @@ test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
>  xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
>  xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
>  xdp_features.skel.h-deps := xdp_features.bpf.o
> +tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
>  
>  LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
>  LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> new file mode 100644
> index 000000000000..cebf4eb68f18
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include <search.h>
> +#include "bpf/libbpf_internal.h"
> +#include "tracing_multi.skel.h"
> +#include "trace_helpers.h"
> +
> +static const char * const bpf_fentry_test[] = {
> +	"bpf_fentry_test1",
> +	"bpf_fentry_test2",
> +	"bpf_fentry_test3",
> +	"bpf_fentry_test4",
> +	"bpf_fentry_test5",
> +	"bpf_fentry_test6",
> +	"bpf_fentry_test7",
> +	"bpf_fentry_test8",
> +	"bpf_fentry_test9",
> +	"bpf_fentry_test10",
> +};
> +
> +#define FUNCS_CNT (ARRAY_SIZE(bpf_fentry_test))
> +
> +static int compare(const void *ppa, const void *ppb)
> +{
> +	const char *pa = *(const char **) ppa;
> +	const char *pb = *(const char **) ppb;
> +
> +	return strcmp(pa, pb);
> +}
> +
> +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const char *mod)
> +{
> +	struct btf *btf, *vmlinux_btf;
> +	__u32 nr, type_id, cnt = 0;
> +	void *root = NULL;
> +	__u32 *ids = NULL;
> +	int i, err = 0;
> +
> +	btf = btf__load_vmlinux_btf();
> +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> +		return NULL;
> +
> +	if (mod) {
> +		vmlinux_btf = btf;
> +		btf = btf__load_module_btf(mod, vmlinux_btf);
> +		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf"))
> +			return NULL;
                        ^ vmlinux_btf does not get released.

> +	}
> +
> +	ids = calloc(funcs_cnt, sizeof(ids[0]));
> +	if (!ids)
> +		goto out;
> +
> +	/*
> +	 * We sort function names by name and search them
> +	 * below for each function.
> +	 */
> +	for (i = 0; i < funcs_cnt; i++)
> +		tsearch(&funcs[i], &root, compare);
                ^ tdestroy() is missing to free tree nodes?

Thanks,
Leon

[...]

