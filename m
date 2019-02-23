Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D2C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 01:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B666B20700
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 01:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfBWBHD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:07:03 -0500
Received: from www62.your-server.de ([213.133.104.62]:36982 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBWBHD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 20:07:03 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gxLmK-000541-T3; Sat, 23 Feb 2019 02:06:57 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gxLmK-000Po4-NA; Sat, 23 Feb 2019 02:06:56 +0100
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
To:     Roman Gushchin <guro@fb.com>, Alexei Starovoitov <ast@kernel.org>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20190222233644.1487087-1-ast@kernel.org>
 <20190222233644.1487087-2-ast@kernel.org>
 <20190223003434.GA17559@tower.DHCP.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8de20612-c32a-9370-254d-9ebf1df78efa@iogearbox.net>
Date:   Sat, 23 Feb 2019 02:06:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190223003434.GA17559@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25368/Fri Feb 22 11:32:58 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/23/2019 01:34 AM, Roman Gushchin wrote:
> On Fri, Feb 22, 2019 at 03:36:41PM -0800, Alexei Starovoitov wrote:
>> JITed BPF programs are indistinguishable from kernel functions, but unlike
>> kernel code BPF code can be changed often.
>> Typical approach of "perf record" + "perf report" profiling and tunning of
>> kernel code works just as well for BPF programs, but kernel code doesn't
>> need to be monitored whereas BPF programs do.
>> Users load and run large amount of BPF programs.
>> These BPF stats allow tools monitor the usage of BPF on the server.
>> The monitoring tools will turn sysctl kernel.bpf_stats_enabled
>> on and off for few seconds to sample average cost of the programs.
>> Aggregated data over hours and days will provide an insight into cost of BPF
>> and alarms can trigger in case given program suddenly gets more expensive.
>>
>> The cost of two sched_clock() per program invocation adds ~20 nsec.
>> Fast BPF progs (like selftests/bpf/progs/test_pkt_access.c) will slow down
>> from ~40 nsec to ~60 nsec.
>> static_key minimizes the cost of the stats collection.
>> There is no measurable difference before/after this patch
>> with kernel.bpf_stats_enabled=0
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>>  include/linux/bpf.h    |  7 +++++++
>>  include/linux/filter.h | 16 +++++++++++++++-
>>  kernel/bpf/core.c      | 13 +++++++++++++
>>  kernel/bpf/syscall.c   | 24 ++++++++++++++++++++++--
>>  kernel/bpf/verifier.c  |  5 +++++
>>  kernel/sysctl.c        | 34 ++++++++++++++++++++++++++++++++++
>>  6 files changed, 96 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index de18227b3d95..14260674bc57 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -340,6 +340,11 @@ enum bpf_cgroup_storage_type {
>>  
>>  #define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
>>  
>> +struct bpf_prog_stats {
>> +	u64 cnt;
>> +	u64 nsecs;
>> +};
>> +
>>  struct bpf_prog_aux {
>>  	atomic_t refcnt;
>>  	u32 used_map_cnt;
>> @@ -389,6 +394,7 @@ struct bpf_prog_aux {
>>  	 * main prog always has linfo_idx == 0
>>  	 */
>>  	u32 linfo_idx;
>> +	struct bpf_prog_stats __percpu *stats;
>>  	union {
>>  		struct work_struct work;
>>  		struct rcu_head	rcu;
>> @@ -559,6 +565,7 @@ void bpf_map_area_free(void *base);
>>  void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
>>  
>>  extern int sysctl_unprivileged_bpf_disabled;
>> +extern int sysctl_bpf_stats_enabled;
>>  
>>  int bpf_map_new_fd(struct bpf_map *map, int flags);
>>  int bpf_prog_new_fd(struct bpf_prog *prog);
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index f32b3eca5a04..7b14235b6f7d 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -533,7 +533,21 @@ struct sk_filter {
>>  	struct bpf_prog	*prog;
>>  };
>>  
>> -#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func)(ctx, (filter)->insnsi); })
>> +DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
>> +
>> +#define BPF_PROG_RUN(prog, ctx)	({				\
>> +	u32 ret;						\
>> +	cant_sleep();						\
>> +	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
>> +		u64 start = sched_clock();			\
>> +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
>> +		this_cpu_inc(prog->aux->stats->cnt);		\
>> +		this_cpu_add(prog->aux->stats->nsecs,		\
>> +			     sched_clock() - start);		\
>> +	} else {						\
>> +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
>> +	}							\
>> +	ret; })
> 
> Can we bump "cnt" unconditionally and gate only the "nsecs" calculation?
> 
> Why it might be useful?
> If the performance cost is too high to keep the statistics gathering
> always enabled, it will be possible to measure the average cost
> periodically and extrapolate.

In general, having some stats and timing info would be useful, but I
guess people might want to customize it in future even more specifically
beyond number of runs + time it takes. One thing that would be super
useful is to have some notion of __attribute__((constructor)) and
__attribute__((destructor)) support in BPF which gets then inlined into
prologue / epilogue of program. E.g. such infrastructure would allow to
mark an skb and measure time it takes through the BPF prog till it hits
an exit point somewhere (without having to explicitly code this into the
program everywhere). Other examples may be histograms or p99 latencies
that might probably be useful. Feels like for monitoring more ways to
program would be nice and to move it into the BPF insns sequence (e.g.
enforced globally or by choice of prog as another option)? Thoughts?
