Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A3EC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 23:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA5221841
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 23:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="K7OFVRJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfBYXHG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:07:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45621 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfBYXHG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 18:07:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so5189623pfm.12
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PLy8Q/kKDZNhVPiFUQfiBNFYoAveBr23/jPaPV1ZMkU=;
        b=K7OFVRJXZdGt6y6Ao6OVwptUk7e83RVxIlviuaxwmKuQ4Tgbr+9jxn7eAwTt+qVWPI
         fMRvpoXs2xyRR4AQkLaxlixNll7E6SNQSLGLLKETEGe/4ofjnRePVYeE86FIKBf2nELY
         kjYm3PP7Ca3W4UpE0ZvWqPS3bODdEmCD4SbqmHhOM8fesdhaVR/CBQ1Jpuhl+NgZIG6x
         xaingpHzHmVMbKtYfK3w69fw4braUNI/C5I/29I4zlZK+ZphnvgdFdG747G7smCs/E8z
         /1h77DHWU34TfOjD7ViDtwYLH+cNH1LHq1bOYxQxoH+G+D5Gm5sEO1p2UjsgercbbTc9
         2GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PLy8Q/kKDZNhVPiFUQfiBNFYoAveBr23/jPaPV1ZMkU=;
        b=TgWK5XvaGlPSWC2CaCQNzwqMR3JzSw2p5Se9vnQnMe4PQB4HdTU7IHlpZN7Oe+X4SJ
         oyQCPZO/MGQA1sBN68jBQKE/6Iqw5wKdDggFOuqDMcEhA+MnAp16SwDVyNM84QrQUgRw
         fVFaTJjckfWDREy3J3mJgsfx0Hsuuyl7H4MINgsuUwUxgR1ppGSbofrYSYp6PutLodgG
         QAtPgQrvBvkMbuT4bZeUR1JS5md47GEwvur1kAn0+x63zKNRA7jZYMOIoz6jHbL9obJB
         ntDduC0228Go1oQzuWOZqlo6XU0yG46+t2oh1JQvO+XXwPgaEzXdpml6J8XSY7q7GtLj
         phNw==
X-Gm-Message-State: AHQUAuZ7UgluFGKQ15R0Y9rwVd5Y4OMTvBdIembza5K77mzJiOxIYUXQ
        28xdRLpEk5n+z4DCqnH+BHu0CQ==
X-Google-Smtp-Source: AHgI3IaEaO9F8soH/YLfSN8JHiuMO5Djcg6OoG9Ed/HnOXab8L2lw0Q6pvth4yS/kvdAdZD3lFYj8g==
X-Received: by 2002:a63:a70b:: with SMTP id d11mr20870144pgf.213.1551136025022;
        Mon, 25 Feb 2019 15:07:05 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id p78sm16150721pfa.84.2019.02.25.15.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:07:04 -0800 (PST)
Date:   Mon, 25 Feb 2019 15:07:03 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     davem@davemloft.net, daniel@iogearbox.net, edumazet@google.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: enable program stats
Message-ID: <20190225230703.GB32115@mini-arch>
References: <20190225222842.2031962-1-ast@kernel.org>
 <20190225222842.2031962-2-ast@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225222842.2031962-2-ast@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/25, Alexei Starovoitov wrote:
> JITed BPF programs are indistinguishable from kernel functions, but unlike
> kernel code BPF code can be changed often.
> Typical approach of "perf record" + "perf report" profiling and tuning of
> kernel code works just as well for BPF programs, but kernel code doesn't
> need to be monitored whereas BPF programs do.
> Users load and run large amount of BPF programs.
> These BPF stats allow tools monitor the usage of BPF on the server.
> The monitoring tools will turn sysctl kernel.bpf_stats_enabled
> on and off for few seconds to sample average cost of the programs.
> Aggregated data over hours and days will provide an insight into cost of BPF
> and alarms can trigger in case given program suddenly gets more expensive.
> 
> The cost of two sched_clock() per program invocation adds ~20 nsec.
> Fast BPF progs (like selftests/bpf/progs/test_pkt_access.c) will slow down
> from ~10 nsec to ~30 nsec.
> static_key minimizes the cost of the stats collection.
> There is no measurable difference before/after this patch
> with kernel.bpf_stats_enabled=0
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf.h    |  9 +++++++++
>  include/linux/filter.h | 20 +++++++++++++++++++-
>  kernel/bpf/core.c      | 31 +++++++++++++++++++++++++++++--
>  kernel/bpf/syscall.c   | 34 ++++++++++++++++++++++++++++++++--
>  kernel/bpf/verifier.c  |  7 ++++++-
>  kernel/sysctl.c        | 34 ++++++++++++++++++++++++++++++++++
>  6 files changed, 129 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index de18227b3d95..a2132e09dc1c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -16,6 +16,7 @@
>  #include <linux/rbtree_latch.h>
>  #include <linux/numa.h>
>  #include <linux/wait.h>
> +#include <linux/u64_stats_sync.h>
>  
>  struct bpf_verifier_env;
>  struct perf_event;
> @@ -340,6 +341,12 @@ enum bpf_cgroup_storage_type {
>  
>  #define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
>  
> +struct bpf_prog_stats {
> +	u64 cnt;
> +	u64 nsecs;
> +	struct u64_stats_sync syncp;
> +};
> +
>  struct bpf_prog_aux {
>  	atomic_t refcnt;
>  	u32 used_map_cnt;
> @@ -389,6 +396,7 @@ struct bpf_prog_aux {
>  	 * main prog always has linfo_idx == 0
>  	 */
>  	u32 linfo_idx;
> +	struct bpf_prog_stats __percpu *stats;
>  	union {
>  		struct work_struct work;
>  		struct rcu_head	rcu;
> @@ -559,6 +567,7 @@ void bpf_map_area_free(void *base);
>  void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
>  
>  extern int sysctl_unprivileged_bpf_disabled;
> +extern int sysctl_bpf_stats_enabled;
>  
>  int bpf_map_new_fd(struct bpf_map *map, int flags);
>  int bpf_prog_new_fd(struct bpf_prog *prog);
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f32b3eca5a04..7e5e3db11106 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -533,7 +533,24 @@ struct sk_filter {
>  	struct bpf_prog	*prog;
>  };
>  
> -#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func)(ctx, (filter)->insnsi); })
> +DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
> +
> +#define BPF_PROG_RUN(prog, ctx)	({				\
> +	u32 ret;						\
> +	cant_sleep();						\
> +	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
> +		struct bpf_prog_stats *stats;			\
> +		u64 start = sched_clock();			\
QQ: why sched_clock() and not, for example, ktime_get_ns() which we do
in the bpf_test_run()? Or even why not local_clock?
I'm just wondering what king of trade off we are doing here
regarding precision vs run time cost.

> +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> +		stats = this_cpu_ptr(prog->aux->stats);		\
> +		u64_stats_update_begin(&stats->syncp);		\
> +		stats->cnt++;					\
> +		stats->nsecs += sched_clock() - start;		\
> +		u64_stats_update_end(&stats->syncp);		\
> +	} else {						\
> +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> +	}							\
> +	ret; })
>  
>  #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
>  
> @@ -764,6 +781,7 @@ void bpf_prog_free_jited_linfo(struct bpf_prog *prog);
>  void bpf_prog_free_unused_jited_linfo(struct bpf_prog *prog);
>  
>  struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags);
> +struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags);
>  struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
>  				  gfp_t gfp_extra_flags);
>  void __bpf_prog_free(struct bpf_prog *fp);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ef88b167959d..1c14c347f3cf 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -78,7 +78,7 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
>  	return NULL;
>  }
>  
> -struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
> +struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags)
>  {
>  	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
>  	struct bpf_prog_aux *aux;
> @@ -104,6 +104,26 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
>  
>  	return fp;
>  }
> +
> +struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
> +{
> +	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
> +	struct bpf_prog *prog;
> +
> +	prog = bpf_prog_alloc_no_stats(size, gfp_extra_flags);
> +	if (!prog)
> +		return NULL;
> +
> +	prog->aux->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
> +	if (!prog->aux->stats) {
> +		kfree(prog->aux);
> +		vfree(prog);
> +		return NULL;
> +	}
> +
> +	u64_stats_init(&prog->aux->stats->syncp);
> +	return prog;
> +}
>  EXPORT_SYMBOL_GPL(bpf_prog_alloc);
>  
>  int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog)
> @@ -231,7 +251,10 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
>  
>  void __bpf_prog_free(struct bpf_prog *fp)
>  {
> -	kfree(fp->aux);
> +	if (fp->aux) {
> +		free_percpu(fp->aux->stats);
> +		kfree(fp->aux);
> +	}
>  	vfree(fp);
>  }
>  
> @@ -2069,6 +2092,10 @@ int __weak skb_copy_bits(const struct sk_buff *skb, int offset, void *to,
>  	return -EFAULT;
>  }
>  
> +DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
> +EXPORT_SYMBOL(bpf_stats_enabled_key);
> +int sysctl_bpf_stats_enabled __read_mostly;
> +
>  /* All definitions of tracepoints related to BPF. */
>  #define CREATE_TRACE_POINTS
>  #include <linux/bpf_trace.h>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ec7c552af76b..31cf66fc3f5c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1283,24 +1283,54 @@ static int bpf_prog_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static void bpf_prog_get_stats(const struct bpf_prog *prog,
> +			       struct bpf_prog_stats *stats)
> +{
> +	u64 nsecs = 0, cnt = 0;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		const struct bpf_prog_stats *st;
> +		unsigned int start;
> +		u64 tnsecs, tcnt;
> +
> +		st = per_cpu_ptr(prog->aux->stats, cpu);
> +		do {
> +			start = u64_stats_fetch_begin_irq(&st->syncp);
> +			tnsecs = st->nsecs;
> +			tcnt = st->cnt;
> +		} while (u64_stats_fetch_retry_irq(&st->syncp, start));
> +		nsecs += tnsecs;
> +		cnt += tcnt;
> +	}
> +	stats->nsecs = nsecs;
> +	stats->cnt = cnt;
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
>  {
>  	const struct bpf_prog *prog = filp->private_data;
>  	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
> +	struct bpf_prog_stats stats;
>  
> +	bpf_prog_get_stats(prog, &stats);
>  	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>  	seq_printf(m,
>  		   "prog_type:\t%u\n"
>  		   "prog_jited:\t%u\n"
>  		   "prog_tag:\t%s\n"
>  		   "memlock:\t%llu\n"
> -		   "prog_id:\t%u\n",
> +		   "prog_id:\t%u\n"
> +		   "run_time_ns:\t%llu\n"
> +		   "run_cnt:\t%llu\n",
>  		   prog->type,
>  		   prog->jited,
>  		   prog_tag,
>  		   prog->pages * 1ULL << PAGE_SHIFT,
> -		   prog->aux->id);
> +		   prog->aux->id,
> +		   stats.nsecs,
> +		   stats.cnt);
>  }
>  #endif
>  
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1b9496c41383..0e4edd7e3c5f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7320,7 +7320,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  		subprog_end = env->subprog_info[i + 1].start;
>  
>  		len = subprog_end - subprog_start;
> -		func[i] = bpf_prog_alloc(bpf_prog_size(len), GFP_USER);
> +		/* BPF_PROG_RUN doesn't call subprogs directly,
> +		 * hence main prog stats include the runtime of subprogs.
> +		 * subprogs don't have IDs and not reachable via prog_get_next_id
> +		 * func[i]->aux->stats will never be accessed and stays NULL
> +		 */
> +		func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
>  		if (!func[i])
>  			goto out_free;
>  		memcpy(func[i]->insnsi, &prog->insnsi[subprog_start],
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ba4d9e85feb8..86e0771352f2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -224,6 +224,9 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
>  #endif
>  static int proc_dopipe_max_size(struct ctl_table *table, int write,
>  		void __user *buffer, size_t *lenp, loff_t *ppos);
> +static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
> +					  void __user *buffer, size_t *lenp,
> +					  loff_t *ppos);
>  
>  #ifdef CONFIG_MAGIC_SYSRQ
>  /* Note: sysrq code uses its own private copy */
> @@ -1230,6 +1233,15 @@ static struct ctl_table kern_table[] = {
>  		.extra2		= &one,
>  	},
>  #endif
> +	{
> +		.procname	= "bpf_stats_enabled",
> +		.data		= &sysctl_bpf_stats_enabled,
> +		.maxlen		= sizeof(sysctl_bpf_stats_enabled),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax_bpf_stats,
> +		.extra1		= &zero,
> +		.extra2		= &one,
> +	},
>  #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
>  	{
>  		.procname	= "panic_on_rcu_stall",
> @@ -3260,6 +3272,28 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
>  
>  #endif /* CONFIG_PROC_SYSCTL */
>  
> +static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
> +					  void __user *buffer, size_t *lenp,
> +					  loff_t *ppos)
> +{
> +	int ret, bpf_stats = *(int *)table->data;
> +	struct ctl_table tmp = *table;
> +
> +	if (write && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	tmp.data = &bpf_stats;
> +	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> +	if (write && !ret) {
> +		*(int *)table->data = bpf_stats;
> +		if (bpf_stats)
> +			static_branch_enable(&bpf_stats_enabled_key);
> +		else
> +			static_branch_disable(&bpf_stats_enabled_key);
> +	}
> +	return ret;
> +}
> +
>  /*
>   * No sense putting this after each symbol definition, twice,
>   * exception granted :-)
> -- 
> 2.20.0
> 
