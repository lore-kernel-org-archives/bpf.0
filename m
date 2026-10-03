Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C2395DAA
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791026166; cv=none; b=Kq+5YW/KyQ7OZWFhlZ9+9/qv9uczhql2oeKpLaPTyFxs9EcCvfnAAYvbwajJ5Zbo//HDSTba6fy2F5CmLXp9TKom/8u+1enFMXfwHgELgjhJ3pZ5gCv1SbTYMIIMUmBCUUCWQcXpL2+8GxN6Tjso+LaD9PR1bMxenhTqIH5Uqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791026166; c=relaxed/simple;
	bh=7xxXDcUde6EpFAuOg1k05rK7RmlUKHgkwvpPXJYnI1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYUKoyYMQirZAD+zKksO8fmvxA+bTpYWdbt1IOZZZApKD019JI8CnyJK6v11wVT01XmcKrI0j1Tl/5t6klvAJy+N9uSw6d4LjYyP3UGDjqztgp/mh6EuWXOWDjJMEhaN0cX5LzHeyFiDv2tsNSecB/1KnpOne/4HjRkJmXyZjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p00Iw8b0; arc=none smtp.client-ip=91.218.175.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p00Iw8b0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7xxXDcUde6EpFAuOg1k05rK7RmlUKHgkwvpPXJYnI1I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791026161; v=1; x=1791630961;
 b=p00Iw8b0Rro/s7jnrxit53ePEcVdn5/pE5F9NusamLeiK4Q/8X3FywVmFOHQs0RF/6UyJkFh
 1CpufYptL8gkLnNANcGKA1IoayNjp6cA2k2fs2s2n/oFyekWBYg68/HJUET8yL/qWwCFJWNXRi2
 iT1K7x5HhzbgtNRpFbs5PJzQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 3f83462abb89ba21;
	Sat, 03 Oct 2026 11:15:51 +0000
X-Mizu-Trace-ID: 3f83462abb89ba21
X-Migadu-Flow: FLOW_OUT
Message-ID: <f3f0a7a2-9a91-4cb6-8cc2-4e5b0b914a1f@linux.dev>
Date: Sat, 3 Oct 2026 19:15:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 0/3] block: Introduce a BPF-based I/O scheduler
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20261003042748.33795-1-kaitao.cheng@linux.dev>
 <DLV3OID9H5E8.2W0GIOP8FHJRN@gmail.com>
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <DLV3OID9H5E8.2W0GIOP8FHJRN@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2026/10/3 17:36, Alexei Starovoitov 写道:
> On Sat, Oct 03, 2026 at 12:27 PM Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
>> PFQ gives us a concrete policy to explore how well the UFQ interface
>> supports more involved scheduling decisions and to guide further work on
>> the framework. It has not yet been used in production, and further testing
>> and workload evaluation are needed.
> 
> Third version in six months and still not a single number.
> v2 got replies from the bots only.
> Without a solid use case there is no point in polishing this.

Thank you very much for your review. This is a fairly large patch series,
and I have gone through several iterations because I was concerned that
my approach might not align with the community's expectations. I wanted
to get feedback early so that any architectural issues could be corrected
promptly. I am not seeking inclusion at this stage; I posted the series
for discussion. When I started developing this project, I wasn't entirely
sure it would work either, so I have been writing and testing as I go, haha!

I have actually run some fio tests locally. Initially, moving the I/O
scheduling policy into BPF caused a substantial performance regression.
After three iterations, however, the current implementation can match
the performance of native schedulers such as mq-deadline.

It also performs comparably to the none scheduler on slower SSDs, but
there is still a substantial performance gap on fast NVMe devices. My
analysis suggests that this is because the none scheduler can frequently
bypass ordering in the ctx queues and issue requests directly to the
driver (see blk_mq_try_issue_directly). I'll try to optimize it further.

I am also exploring and testing real-world use cases, which is why I
developed PFQ in the third patch. Next, I plan to evaluate PFQ with
foreground/background applications and with co-located containerized
online services and batch workloads. I may be able to share the results
in the next iteration.

>> In particular, I would appreciate suggestions on the boundary between the
>> UFQ framework and BPF policies, the struct_ops interface, and request
>> ownership and fallback handling.
> 
> One global ufq_ops for all disks is not the best shape.
> I'd do it like bpf_qdisc.

Good suggestion. I'll give it a try. Thanks!

> The ownership is the bigger problem.
> The request sits in ctx->rq_lists and in a bpf map at the same time
> and the kernel relies on the prog to keep the two in sync.
> The prog holds rq->ref. rq holds q_usage_counter until
> __blk_mq_free_request(). One request that the prog didn't return
> from dispatch_req or left in a map and blk_mq_freeze_queue() waits
> forever.
> sched_ext has a watchdog that kicks the bpf scheduler out.
> Something like that is necessary here too.

When the BPF scheduler leaks an rq reference, system I/O does indeed stall.
However, because the requests are also kept in ctx->rq_lists, everything
returns to normal once the BPF scheduler exits. A watchdog that kicks the
BPF scheduler out is necessary, and it's also something I was planning to
implement. Thank you very much!

-- 
Thanks
Kaitao Cheng

