Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF6175A5
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519836; cv=none; b=TqtwnvdEmFknv5mXf4HH0XuUjn56PZ95GSrhDo6XhTIwM0Fh5ayvI51IiqEBLaujDaYhvfIrueAI8Gt0XFQ+3/Xi2dDM8GKpZDG8emNThxXL7XQlMoce0d3YLvQL5Xg7RtcpGJaPd73nTSb8ZDCgdb+FngoUzJJXlXLRA3BS62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519836; c=relaxed/simple;
	bh=Zljin9KUHHldpoeST9Sonquw4yr0R26j8elLC7106tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYY3TK00JWANamA0mK5X6zsDMoc2Noq0bXt7YhRwCqD73/S4rda8j8TjIMJQII/A8CpV61tMOTseKqW0ZZkHaJJA/jE2R/Syh9hBI0Ro5USaQBnrkSDCbekWVumlBnK8w1Dpq/N3sw1EgiBnuB3WiaDidACRtk4eM6ierXFAYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g5fmw3KJ2zKHMXG
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 11:29:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 407A94058D
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 11:30:25 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgD3XPvQzPJpUSMzAg--.2948S2;
	Thu, 30 Apr 2026 11:30:25 +0800 (CST)
Message-ID: <c8c10717-f6ae-4fd2-89eb-0d745bff474a@huaweicloud.com>
Date: Thu, 30 Apr 2026 11:30:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 3/3] selftests/bpf: Add test for large offset
 bpf-to-bpf call
Content-Language: en-US
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, emil@etsalapatis.com, puranjay@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
 <20260429171904.107244-4-tangyazhou@zju.edu.cn>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260429171904.107244-4-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3XPvQzPJpUSMzAg--.2948S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1xArWkur47ur47KF43trb_yoW7Wr15pF
	1vgF9xKF97Ca47KF17CFsrZFyrKFs5Z34UAr48Zrn8AF1UAr97JrZ7KrWUJFyfCan7Jw1F
	vrW29343Gw48AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j7l19UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/30/2026 1:19 AM, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> Add a selftest to verify the verifier and JIT behavior when handling
> bpf-to-bpf calls with relative jump offsets exceeding the s16 boundary.
> 
> The test utilizes an inline assembly block with ".rept 32765" to generate
> a massive dummy subprogram. By placing this padding between the main
> program and the target subprogram, it forces the verifier to process a
> bpf-to-bpf call where the imm field exceeds the s16 range.
> 
> - When JIT is enabled, it asserts that the program is successfully loaded
>    and executes correctly to return the expected value. Since patch 1/2
>    does not change the JIT behavior, the test passes whether the fix is
>    applied or not.
> - When JIT is disabled, it also asserts that the program is successfully
>    loaded and executes correctly to return the expected value 3.
>    - Before the fix, the verifier rewrites the call instruction with a
>      truncated offset (here 32768 -> -32768) and lets it pass. When the
>      program is executed, the call instruction will go to a wrong target
>      (in the landing pad) instead of the intended subprogram, then return -1
>      and fail.
>    - After the fix, the verifier correctly handles the large offset and
>      allows it to pass. The program then executes correctly to return the
>      expected value 3.
> 
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
>   .../selftests/bpf/prog_tests/verifier.c       |  2 +
>   .../bpf/progs/verifier_call_large_imm.c       | 66 +++++++++++++++++++
>   2 files changed, 68 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index a96b25ebff23..b27f4d4e2bd4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -22,6 +22,7 @@
>   #include "verifier_bswap.skel.h"
>   #include "verifier_btf_ctx_access.skel.h"
>   #include "verifier_btf_unreliable_prog.skel.h"
> +#include "verifier_call_large_imm.skel.h"
>   #include "verifier_cfg.skel.h"
>   #include "verifier_cgroup_inv_retcode.skel.h"
>   #include "verifier_cgroup_skb.skel.h"
> @@ -170,6 +171,7 @@ void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); }
>   void test_verifier_bswap(void)                { RUN(verifier_bswap); }
>   void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
>   void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
> +void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
>   void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
>   void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
>   void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c b/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
> new file mode 100644
> index 000000000000..1e2c8addc582
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +int call_happened = 0;
> +
> +/*
> + * 32765 is the exact minimum number of padding instructions needed to
> + * trigger the verifier failure, because:
> + * 1. Counting the wrapper instructions around the padding block (one
> + *    "r0=0" and two "exit" instructions), the actual jump distance
> + *    evaluates to N + 3.
> + * 2. To overflow the s16 max bound (32767), we need N + 3 > 32767.
> + * Thus, N = 32765 is the exact minimum padding size required.
> + */
> +static __attribute__((noinline)) void padding_subprog(void)
> +{
> +	asm volatile (
> +	"r0 = 0;"
> +	".rept 32765;"
> +	"r0 += 0;"
> +	".endr;"
> +	::: __clobber_all);
> +}
> +
> +static __attribute__((noinline)) int target_subprog(void)
> +{
> +	/* Use volatile variable here to prevent optimization. */
> +	volatile int magic_ret = 3;
> +	return magic_ret;
> +}
> +
> +SEC("syscall")
> +__success __retval(3)
> +int call_large_imm_test(void *ctx)
> +{
> +	/*
> +	 * Landing pad to handle call error on kernel without the fix,
> +	 * preventing kernel panic.
> +	 */
> +	asm volatile (
> +	"r0 = 0;"
> +	".rept 32768;"
> +	"r0 += 0;"
> +	".endr;"
> +	::: __clobber_all);
> +
> +	/*
> +	 * The call_happened variable is 1 only when the call insn wrongly
> +	 * go back to the landing pad above.
> +	 */
> +	if (call_happened == 1) {
> +		/* Use volatile variable here to prevent optimization. */
> +		volatile int flag = -1;
> +		return flag;
> +	}
> +
> +	call_happened = 1;
> +
> +	padding_subprog();
> +
> +	return target_subprog();
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";

Acked-by: Xu Kuohai <xukuohai@huawei.com>

