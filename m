Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983D344030
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674467; cv=none; b=LIbQypLfoIQqStzEydpHiYjyOPUvFX09X4NYe7/oRlGK0odk4NRRwzux4yHLaiyin/jmiMNnzlXm8X80kjnkSFtftxafHPfKeb0wMyUSZtkOkyo4fzaEM9B9Cvyc3+z9V1tqFAOlUy3/kPT3clPRkwzh29NF29/AeSJS34VCCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674467; c=relaxed/simple;
	bh=hVTPV+E/TbbB0Flr/nLpqaet5wjIiYTZpAh1caTu8h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4Va8nkyHQrKcJWK8IqUqW7rpIJfq5fT4FmvdVYdOyFjNqveJhMJzCEUBI9cLyLV1DYkR2XOExdBKnbl5cVK87UyNDHPCXxen75K3wruJacwZteQYFNWyupH+Yvhcj89ho/hBfR4Xx2yjyl+v1LcPXXiqHj3KH4UJ9ZsUvLzV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CU3lwnr7; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CU3lwnr7"
Message-ID: <13b87293-5237-43d3-9f91-33c13041cb43@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780674451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZG4aMaH9HnROS+vLpUfnBWFNRF+eTigF60FCdnGxlg=;
	b=CU3lwnr7dLF/lcnaKkaJnyuvAA8Nxo3qD4VS+Oc2hZ4JJFIEPLI567mvejISPJ/p18VGtg
	Pne7bezX9KkPrqNIvoVD5gO3vtihOLj9Rk3FaLzyLWVLsLAlo0HCOMWRZcFfpweonp3GeT
	UYGbz38W2W7kjrHxQLIZtxb6zUmHM/E=
Date: Fri, 5 Jun 2026 08:47:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Content-Language: en-GB
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
 <20260604-kasan-v2-8-c066e627fda8@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260604-kasan-v2-8-c066e627fda8@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/4/26 1:22 PM, Alexis Lothoré (eBPF Foundation) wrote:
> Add a basic KASAN test runner that loads and test-run programs that can
> trigger memory management bugs. The test captures kernel logs and ensure
> that the expected KASAN splat is emitted by searching for the
> corresponding first lines in the report, hence validated that the needed
> instrumentation has been inserted by the JIT compiler before the
> relevant memory accesses.
>
> The runner covers different cases and settings: in the nominal case, it
> validates kasan reports on basic instructions (on all supported accesses
> sizes) but also when report _should not_ be emitted (eg: for accesses on
> program stack). The runner also comes with a few specialized tests that
> are then not executed for all sizes/locations. A few of those tests
> depends on cpuv4 (load_acquire and store_release).
>
>    # ./test_progs -a kasan
>    #164/1   kasan/st_1_not_on_stack:OK
>    #164/2   kasan/st_1_on_stack:OK
>    #164/3   kasan/st_2_not_on_stack:OK
>    #164/4   kasan/st_2_on_stack:OK
>    #164/5   kasan/st_4_not_on_stack:OK
>    #164/6   kasan/st_4_on_stack:OK
>    #164/7   kasan/st_8_not_on_stack:OK
>    #164/8   kasan/st_8_on_stack:OK
>    #164/9   kasan/stx_1_not_on_stack:OK
>    #164/10  kasan/stx_1_on_stack:OK
>    #164/11  kasan/stx_2_not_on_stack:OK
>    #164/12  kasan/stx_2_on_stack:OK
>    #164/13  kasan/stx_4_not_on_stack:OK
>    #164/14  kasan/stx_4_on_stack:OK
>    #164/15  kasan/stx_8_not_on_stack:OK
>    #164/16  kasan/stx_8_on_stack:OK
>    #164/17  kasan/ldx_1_not_on_stack:OK
>    #164/18  kasan/ldx_1_on_stack:OK
>    #164/19  kasan/ldx_2_not_on_stack:OK
>    #164/20  kasan/ldx_2_on_stack:OK
>    #164/21  kasan/ldx_4_not_on_stack:OK
>    #164/22  kasan/ldx_4_on_stack:OK
>    #164/23  kasan/ldx_8_not_on_stack:OK
>    #164/24  kasan/ldx_8_on_stack:OK
>    #164/25  kasan/simple_atomic_4_not_on_stack:OK
>    #164/26  kasan/simple_atomic_4_on_stack:OK
>    #164/27  kasan/simple_atomic_8_not_on_stack:OK
>    #164/28  kasan/simple_atomic_8_on_stack:OK
>    #164/29  kasan/load_acquire_1_not_on_stack:SKIP
>    #164/30  kasan/load_acquire_1_on_stack:SKIP
>    #164/31  kasan/load_acquire_2_not_on_stack:SKIP
>    #164/32  kasan/load_acquire_2_on_stack:SKIP
>    #164/33  kasan/load_acquire_4_not_on_stack:SKIP
>    #164/34  kasan/load_acquire_4_on_stack:SKIP
>    #164/35  kasan/load_acquire_8_not_on_stack:SKIP
>    #164/36  kasan/load_acquire_8_on_stack:SKIP
>    #164/37  kasan/store_release_1_not_on_stack:SKIP
>    #164/38  kasan/store_release_1_on_stack:SKIP
>    #164/39  kasan/store_release_2_not_on_stack:SKIP
>    #164/40  kasan/store_release_2_on_stack:SKIP
>    #164/41  kasan/store_release_4_not_on_stack:SKIP
>    #164/42  kasan/store_release_4_on_stack:SKIP
>    #164/43  kasan/store_release_8_not_on_stack:SKIP
>    #164/44  kasan/store_release_8_on_stack:SKIP
>    #164/45  kasan/ldx_patched:OK
>    #164/46  kasan/stack_and_non_stack:OK
>    #164     kasan:OK (SKIP: 16/46)
>    Summary: 1/30 PASSED, 16 SKIPPED, 0 FAILED

On my qemu run, I got a bunch of failures like below:

[root@arch-fb-vm1 bpf]# ./test_progs -n 164
test_kasan:PASS:alloc test ctx 0 nsec
gzopen /boot/config-7.1.0-rc5-gec86c8156bd6: No such file or directory
test_kasan:PASS:open prog 0 nsec
test_kasan:PASS:find rnd_hi32 prog 0 nsec
...
All error logs:
test_kasan:PASS:alloc test ctx 0 nsec
gzopen /boot/config-7.1.0-rc5-gec86c8156bd6: No such file or directory
test_kasan:PASS:open prog 0 nsec
test_kasan:PASS:find rnd_hi32 prog 0 nsec
test_kasan:PASS:load prog 0 nsec
test_kasan:PASS:open kernel logs 0 nsec
test_kasan:PASS:get map 0 nsec
test_kasan:PASS:set map 0 nsec
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/1   kasan/st_1_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/3   kasan/st_2_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/5   kasan/st_4_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/7   kasan/st_8_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/9   kasan/stx_1_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/11  kasan/stx_2_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/13  kasan/stx_4_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/15  kasan/stx_8_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/17  kasan/ldx_1_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/19  kasan/ldx_2_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/21  kasan/ldx_4_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/23  kasan/ldx_8_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/25  kasan/simple_atomic_4_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/27  kasan/simple_atomic_8_not_on_stack:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/45  kasan/ldx_patched:FAIL
run_subtest_with_size_and_location:PASS:find test prog 0 nsec
run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
run_subtest_with_size_and_location:PASS:run prog 0 nsec
run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
run_subtest_with_size_and_location:FAIL:report should be generated unexpected error: 1 (errno 11)
#164/46  kasan/stack_and_non_stack:FAIL
#164     kasan:FAIL

I checked the subtest 164/1,

For

         ret = check_kasan_report_in_kernel_logs(klog_buffer, ctx,
                                                 test->is_write, access_size);
         if (on_stack || test->expect_no_report)
                 ASSERT_NEQ(ret, 0, "no report should be generated");
         else
                 ASSERT_OK(ret, "report should be generated");

the ret is equal to 1 as klog_buffer is empty. This caused the failure.

>
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - simplify tests by just manually poisoning test areas with a dedicated
>    kfunc
> - introduce one prog per covered instruction family
> - make sure that tests do not consume kernel logs (use /dev/kmgs rather
>    than klogctl)
> - add tests for stack accesses:
>    - marking correctly set when there are diverging verifier states
>      leading to different memory types
>    - marking kept in sync with prog when it is patched
> ---
>   tools/testing/selftests/bpf/prog_tests/kasan.c     | 356 +++++++++++++++++++
>   tools/testing/selftests/bpf/progs/kasan.c          | 382 +++++++++++++++++++++
>   .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  22 ++
>   3 files changed, 760 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testing/selftests/bpf/prog_tests/kasan.c
> new file mode 100644
> index 000000000000..adf61e230ec9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +#include <bpf/bpf.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/if_ether.h>
> +#include <unistd.h>
> +#include <test_progs.h>
> +#include <unpriv_helpers.h>
> +#include "kasan.skel.h"
> +
> +#define SUBTEST_NAME_MAX_LEN	128
> +#define PROG_NAME_MAX_LEN	128
> +
> +#define MAX_LOG_SIZE		(8 * 1024)
> +#define READ_CHUNK_SIZE		256
> +
> +#define KASAN_PATTERN_SLAB_UAF "BUG: KASAN: slab-use-after-free " \
> +	"in bpf_prog_%02x%02x%02x%02x%02x%02x%02x%02x_%s"
> +#define KASAN_PATTERN_REPORT "%s of size %d at addr"
> +
> +static char klog_buffer[MAX_LOG_SIZE];
> +
> +struct test_spec {
> +	char *prog_type;
> +	bool is_write;
> +	bool only_32_or_64;
> +	bool needs_load_acq_store_rel;
> +	bool skip_multi_size_testing;
> +	bool skip_on_stack_testing;
> +	int run_size;
> +	bool expect_no_report;

expect_no_report is not set in the code. The only usage is in

         if (on_stack || test->expect_no_report)
                 ASSERT_NEQ(ret, 0, "no report should be generated");
         else
                 ASSERT_OK(ret, "report should be generated");

> +	bool rnd_hi32;
> +};
> +
> +struct kasan_write_val {
> +	__u8 data_1;
> +	__u16 data_2;
> +	__u32 data_4;
> +	__u64 data_8;
> +};
> +
>
[...]

