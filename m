Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56F21255A;
	Tue, 23 Jun 2026 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229562; cv=none; b=hVIiSMBuv7+ohJMcs8TzsMaWdRAddz8PpMvc82VlM0NXGvZ41ZWxi3Jz2V/ibgvf1mXQQyyufMONYUbAFzVhI11n/s2jDZncz2h72ELgmdnz3hQyK83tpkha4PtYIKBjBsKmfgyyCr3Ul9sN7sXrYiBKjhiSy2tGqM2uDSif8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229562; c=relaxed/simple;
	bh=3bvzU5bXJ+CLiGk2PE303KNEwq96TiaewCU0WdkUfWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOTzQ/++qghkDwayI81vfaY5y9i4OzDAvwoZJf7bRJo83qDkgy2oFrf5FEqGPHcOgKs/uodrjeLyocMec1dxblS/Lewxa1t4vYlm1IN+z691YAX7QUVN+XC4Kq8otSMwpCL6bs82QHjYelZzbgxW9QlKqD6p2Mwvft+11ZPQP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=j6Cdtdj1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j6Cdtdj1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CA5E1758;
	Tue, 23 Jun 2026 08:45:56 -0700 (PDT)
Received: from [10.1.27.69] (e127648.arm.com [10.1.27.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52C833F62B;
	Tue, 23 Jun 2026 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782229560; bh=3bvzU5bXJ+CLiGk2PE303KNEwq96TiaewCU0WdkUfWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j6Cdtdj1VI3Gw0KVPlxmi7gT4c56LqNWoE3c7pyoJQWYwAyx5OOOW22DuRgDlTomx
	 4QNd2bVbr7uQ7n0eEJt/Y+vP1W3bM8HZ9VJGor+P90JaTCY9WjRUd/pH+Q0MUgwn7U
	 R2VyuCv2DZ3+YaI3Tf6lH1OzFzVJ2B2YEQdCG8VM=
Message-ID: <43d5e4e0-eddb-4a7a-87df-180b9048a038@arm.com>
Date: Tue, 23 Jun 2026 16:45:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Print deprecation warnings only once
To: Breno Leitao <leitao@debian.org>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com
References: <20260623-scx_warning-v1-1-14bf218f4bd9@debian.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260623-scx_warning-v1-1-14bf218f4bd9@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 15:38, Breno Leitao wrote:
> The deprecation notices for direct p->scx.slice/dsq_vtime writes and for
> ops->cpu_acquire/release() use plain pr_warn(), so they repeat on every
> scheduler (re)load and flood the kernel log.
> > The slice/dsq_vtime notice is emitted from the BPF verifier's
> btf_struct_access callback, which runs once per write access and is
> re-evaluated as the verifier explores paths, so loading a single
> scheduler can print it several times. The cpu_acquire/release notice is
> printed on every scheduler enable.
> 
> Switch both to pr_warn_once() so each deprecation is reported a single
> time, and add the missing newline to the slice/dsq_vtime message.

I guess this should be warned for once per BPF scheduler like
sch->warned_deprecated_rq

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  kernel/sched/ext/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f648..708eb9024cb25 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6988,7 +6988,7 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
>  	 * run past the BPF allocation. Skip for cid-form.
>  	 */
>  	if (!sch->is_cid_type && (ops->cpu_acquire || ops->cpu_release))
> -		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
> +		pr_warn_once("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
>  
>  	/*
>  	 * Sub-scheduler support is tied to the cid-form struct_ops. A sub-sched
> @@ -7806,7 +7806,7 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
>  		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
>  		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
>  		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
> -			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
> +			pr_warn_once("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()\n");
>  			return SCALAR_VALUE;
>  		}
>  
> 
> ---
> base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
> change-id: 20260623-scx_warning-0df49c442afb
> 
> Best regards,

