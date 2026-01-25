Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562963EBF0C;
	Sun, 25 Jan 2026 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769339563; cv=none; b=eJf9E2AP6e7jcG3A71TvoRWFD6tHhrZHEGP0G2et9710Er85DXtHO2lAKcVmiOYpu1WSjLitWdka54c3pq/QVLjhi4fmcKvF31/a7jnVf+wIDZYCOr2KjqNjvRNJvxeEfumhfYn8gukGXs7PMk2EcwYh0lnvnk9TBSxTKu2UoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769339563; c=relaxed/simple;
	bh=AYSkijxeGF+takY3OdZiLS2I0WVRee62PXlaLY5K+WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psiutuZbdDIQyI4Lds6FAv3kE0B5CMpBOSxHP86moBNWO+Fmcllemn16w1pcqC8djHFQDn6pqOSgaMxzkNI1Ylf6yfQwBSCmQ0hT+1V2f6Lhbqo17dWI8YaEyl8pk+qSyzbidQtagWIrHXzk9jxtczOZyGeqavM7FTGeJ/Azuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AqPg44DC; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AqPg44DC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n2Dk2IfBO4K6PxEgvwDm+wGUCTn8PWzHrg06FGT1LtM=; b=AqPg44DCdtBETG1+QgaMRFo4IS
	lofl+hgGJQ3QSCiNWHdL/NwDp7c/O2x19tOeIxJrj7uhEIG5PJyaJH0nU6eoiE5dRPYUKg0XYouKk
	HXB0BAhsI7BRdjM8H+bT7ui1Yk6R/V7iKuNyl6/IU0RGRaMTvqjr0Qd5zK3kDikI9uAiFvqh+/0vG
	k4ZQ/p/E0TPLjNeDv4KxngINwlatj2q1BijD7OpksxDuHq4/fuN5NQiz+GQIVyfP/RVfoKVoq3VNB
	0JGkSZ53L1CMhdu7zk6ELH1BhBNv4M5Xac+RikeX0CwK0NaNOSQ1P31Aa3AFCfHblWHaQ6ordf5x6
	nya07Kxw==;
Received: from [175.114.83.198] (helo=[192.168.45.92])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vjy2a-009fJC-3V; Sun, 25 Jan 2026 12:12:24 +0100
Message-ID: <6c9678a8-2f1a-44ea-a28d-36a1ab0ad763@igalia.com>
Date: Sun, 25 Jan 2026 20:12:14 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for execution
 context helpers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 kernel-dev@igalia.com, bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260124132706.183681-1-changwoo@igalia.com>
 <20260124132706.183681-3-changwoo@igalia.com>
 <CAADnVQLS4n+Mnti34aaN9_k08WLV0fj_2AM61x-oApFKwKGihQ@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko, en-HK
In-Reply-To: <CAADnVQLS4n+Mnti34aaN9_k08WLV0fj_2AM61x-oApFKwKGihQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thank you for the review.

On 1/25/26 12:37 PM, Alexei Starovoitov wrote:
> On Sat, Jan 24, 2026 at 5:27 AM Changwoo Min <changwoo@igalia.com> wrote:
>>
>> Add a new selftest suite `exe_ctx` to verify the accuracy of the
>> bpf_in_task(), bpf_in_hardirq(), and bpf_in_serving_softirq() helpers
>> introduced in bpf_experimental.h.
>>
>> Testing these execution contexts deterministically requires crossing
>> context boundaries within a single CPU. To achieve this, the test
>> implements a "Trigger-Observer" pattern using bpf_testmod:
>>
>> 1. Trigger: A BPF syscall program calls a new bpf_testmod kfunc
>>     bpf_kfunc_trigger_ctx_check().
>> 2. Task to HardIRQ: The kfunc uses irq_work_queue() to trigger a
>>     self-IPI on the local CPU.
>> 3. HardIRQ to SoftIRQ: The irq_work handler calls a dummy function
>>     (observed by BPF fentry) and then schedules a tasklet to
>>     transition into SoftIRQ context.
>>
>> The user-space runner ensures determinism by pinning itself to CPU 0
>> before execution, forcing the entire interrupt chain to remain on a
>> single core. Dummy noinline functions with compiler barriers are
>> added to bpf_testmod.c to serve as stable attachment points for
>> fentry programs. A retry loop is used in user-space to wait for the
>> asynchronous SoftIRQ to complete.
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> 
> ...
> 
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "bpf_experimental.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +extern void bpf_kfunc_trigger_ctx_check(void) __ksym;
>> +
>> +int count_hardirq;
>> +int count_softirq;
>> +int count_task;
>> +
>> +/* Triggered via bpf_prog_test_run from user-space */
>> +SEC("syscall")
>> +int trigger_all_contexts(void *ctx)
>> +{
>> +       if (bpf_in_task())
>> +               __sync_fetch_and_add(&count_task, 1);
>> +
>> +       /* Trigger the firing of a hardirq and softirq for test. */
>> +       bpf_kfunc_trigger_ctx_check();
>> +       return 0;
>> +}
>> +
>> +/* Observer for HardIRQ */
>> +SEC("fentry/bpf_testmod_test_hardirq_fn")
>> +int BPF_PROG(on_hardirq)
>> +{
>> +       if (bpf_in_hardirq())
>> +               __sync_fetch_and_add(&count_hardirq, 1);
>> +       return 0;
>> +}
>> +
>> +/* Observer for SoftIRQ */
>> +SEC("fentry/bpf_testmod_test_softirq_fn")
>> +int BPF_PROG(on_softirq)
>> +{
>> +       if (bpf_in_serving_softirq())
>> +               __sync_fetch_and_add(&count_softirq, 1);
>> +       return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index d425034b72d3..1b04022859b7 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> @@ -1164,6 +1164,33 @@ __bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
>>   __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
>>   __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux);
>>
>> +/* hook targets */
>> +noinline void bpf_testmod_test_hardirq_fn(void) { barrier(); }
>> +noinline void bpf_testmod_test_softirq_fn(void) { barrier(); }
>> +
>> +/* Tasklet for SoftIRQ context */
>> +static void ctx_check_tasklet_fn(struct tasklet_struct *t)
>> +{
>> +       bpf_testmod_test_softirq_fn();
>> +}
>> +
>> +DECLARE_TASKLET(ctx_check_tasklet, ctx_check_tasklet_fn);
>> +
>> +/* IRQ Work for HardIRQ context */
>> +static void ctx_check_irq_fn(struct irq_work *work)
>> +{
>> +       bpf_testmod_test_hardirq_fn();
>> +       tasklet_schedule(&ctx_check_tasklet);
>> +}
>> +
>> +static struct irq_work ctx_check_irq = IRQ_WORK_INIT_HARD(ctx_check_irq_fn);
> 
> Nicely done! selftests should work in PREEMPT_RT too
> though we don't enable it in bpf CI.
> 
> I was about to apply it, but the new tests fails on s390:
> 
> test_exe_ctx:FAIL:hardirq_ok unexpected hardirq_ok: actual 0 <= expected 0
> test_exe_ctx:FAIL:softirq_ok unexpected softirq_ok: actual 0 <= expected 0
> 
> The existing bpf_in_interrupt() also works on x86 and arm64 only.
> When it was introduced it came with pretty weak selftest
> commit 31329b6 ("selftests/bpf: Introduce experimental bpf_in_interrupt()")
> so it's not really testing anything on s390 and non-x86/arm architectures.
> 
> So just add your strong selftests to DENYLIST.s390x.
> get_preempt_count() on s390 looks like this:
> static __always_inline int preempt_count(void)
> {
>     return READ_ONCE(get_lowcore()->preempt_count) & ~PREEMPT_NEED_RESCHED;
> }
> but get_lowcore() needs asm.
> So it's not going to be easy to make it work purely in bpf.
> Let's punt it to people that care about s390.


Regarding the s390 failure: that makes sense. Since the
get_preempt_count() logic relies on architecture-specific register/
memory access that hasn't been implemented for s390 BPF yet, I will add
exe_ctx to DENYLIST.s390x in v3.

I'll send out the v3 with the denylist update shortly. Also, I will add
comments to those helpers mentioning that only x86 and arm64 are
supported.

Regards,
Changwoo

> 
> pw-bot: cr
> 

