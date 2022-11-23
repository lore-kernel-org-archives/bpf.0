Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDECC433FE
	for <bpf@archiver.kernel.org>; Wed, 23 Nov 2022 00:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiKWA5C (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiKWA5B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 19:57:01 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EA0D33A4
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 16:56:59 -0800 (PST)
Message-ID: <201c1603-cb3e-7893-c411-e7949ef8e9d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669165017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=foctROSeplgW3XcR8Drhq60ZgqfxWdGvab695vqO9yA=;
        b=v1FRAvCip+rQtFlk/vFpCupeKfnFvatN4IDIsQ8/teYg7LXfEhPqdZx5pNkIObZFvMQJ2B
        V2uO0YQ9Bn5BLQdULexQRQXb6kbM/Es2ghlVrDWt993ifyIeNJCFMRa8LHErqZlbBsUV9L
        DTYtp7h3W6j8v45DQIz/WqdcSNLi/VY=
Date:   Tue, 22 Nov 2022 16:56:51 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/4] selftests/bpf: Add tests for
 bpf_rcu_read_lock()
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221122195319.1778570-1-yhs@fb.com>
 <20221122195340.1783247-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221122195340.1783247-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/22/22 11:53 AM, Yonghong Song wrote:
> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
> +int task_acquire(void *ctx)
> +{
> +	struct task_struct *task, *real_parent;
> +
> +	task = bpf_get_current_task_btf();
> +	bpf_rcu_read_lock();
> +	real_parent = task->real_parent;
> +	/* acquire a reference which can be used outside rcu read lock region */
> +	real_parent = bpf_task_acquire(real_parent);
Does the bpf_task_acquire() kfunc need a change to do refcount_inc_not_zero() 
and KF_RET_NULL?

Also, some more 'skip' checks in prog_tests/rcu_read_lock.c is needed for gcc. 
This is failing in gcc CI:

https://github.com/kernel-patches/bpf/actions/runs/3527747280/jobs/5917628248#step:6:5624

   ; bpf_rcu_read_lock();
   2: (85) call bpf_rcu_read_lock#26650
   ; real_parent = task->real_parent;
   3: (79) r1 = *(u64 *)(r6 +1416)       ; R1_w=ptr_task_struct(off=0,imm=0) 
R6_w=trusted_ptr_task_struct(off=0,imm=0)
   ; real_parent = bpf_task_acquire(real_parent);
   4: (85) call bpf_task_acquire#26666
   R1 must be referenced or trusted	
   processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 
peak_states 0 mark_read 0
   -- END PROG LOAD LOG --
   libbpf: prog 'task_acquire': failed to load: -22

> +	bpf_rcu_read_unlock();
> +	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
> +	bpf_task_release(real_parent);
> +	return 0;
> +}
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
> +int no_lock(void *ctx)
> +{
> +	struct task_struct *task, *real_parent;
> +
> +	/* no bpf_rcu_read_lock(), old code still works */
> +	task = bpf_get_current_task_btf();
> +	real_parent = task->real_parent;
> +	bpf_printk("pid %u\n", real_parent->pid);

nit. Can bpf_printk be avoided here?

Others lgtm.

