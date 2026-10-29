Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268697;
	b=FIR5/a6PEUlnsxdWqs465a1jiE7GnUGwDRekPJ3NtJJlp+ct40LhPxM8Lfs1rGoDhfL5
	 5A8RMg39eTsrzXzYf0dS0rcoluMjLh8MUceB4VnQqzUqXbOtmB8yWeKYfLCYhePqheLhH
	 FGBPkt4K9zqFB03u+p2LjWbCkVEspF6xl9mb/QH2k+kg+OOXocLgv5YlaDUn5BXFdibs/
	 YTDhvJLC4TUR01QuYuVXwMwBprUi5uH+v0uqMgRw5XLnQV0eqDWADY2eWe0ej2SdFOMJR
	 QrDcHZGNGBqm1eTDgbr2iFnw4ChdQ3RAs51WEz+Rlv4br2kPHjPKHd3mJ53VzUmCNxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268697;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FAoeFjOhHMIomvSZEyPcUceFOZEousEjiVEkUk7cB2Y=;
	b=BmEDXBI6++dyuWlYO5qOuQBiUpfjRL+y1SiXyq3nTCpnKwSCJQz62+ui2/0k7TS66ieZ
	 iKnKkJ12Rf3CW/4BP/2scJRyrs6CR+xchr+pg0yoLbGv3JPnYui8IzSi3OftrlZAznALD
	 /eMxfccj7DQOl9YV1W4Ono5cvCGNQTZSEc7v3AhWAInV+nY69Uj66Rf/dBw8UMJxSDFc1
	 YSzGGiutbTNTCScWoSdXn9QCphLaafXFKXrl0/AKsNulAwqMPiIs2D/w4bVVDgQJxlc5u
	 El0IT1qql7G4iG0+g7Z/gdzZ+ckQ+kKRnQ3IzIaJs1LYAKxEJdhvS8trubdDgpQbA4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W5WC4w0c;
	arc=none smtp.remote-ip=95.215.58.190
Received: from mta1.migadu.com (out-190.mta1.migadu.com [95.215.58.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C60606A326
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 10:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C60606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W5WC4w0c
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O6pECeJaIkk7IfSov1GVY8i4R6cQbSZNmIkkj1P7D6Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793268695; v=1; x=1793873495;
 b=W5WC4w0csS4VEBLZ2tQ0uytPiTEYb99WY1GvVsXg6l0O8ex/VRZXKkrvDBct7VCmR2++I9yt
 J1Tzsp1mH2e0cfsCaugOhV+bVlES9qtmuDXLzyvlpvaYXbNsekpoZ3NVes9FyZF9eS3QIzsbDxr
 13N8iOXXWc173Mkp2JmAx2cA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 73988b42a70c48c5;
	Thu, 29 Oct 2026 10:11:34 +0000
X-Mizu-Trace-ID: 73988b42a70c48c5
X-Migadu-Flow: FLOW_OUT
Message-ID: <895cb52c-1542-4ff7-abaf-844a73126fa8@linux.dev>
Date: Thu, 29 Oct 2026 18:11:25 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, josef@toxicopanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 linux-kselftest@vger.kernel.org, cuitao@kylinos.cn, ameryhung@gmail.com,
 alexei.starovoitov@gmail.com
Subject: Re: [PATCH 2/5] blk-iocost: add BPF struct_ops cost model support
To: Tejun Heo <tj@kernel.org>
References: <20261028143534.135968-1-cui.tao@linux.dev>
 <20261028143534.135968-3-cui.tao@linux.dev>
 <0753eaa990c954aa56a0c5fa8ba302e2@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <0753eaa990c954aa56a0c5fa8ba302e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Tejun,

在 2026/10/29 04:09, Tejun Heo 写道:
> Hello, Tao.
> 
> On Wed, Oct 28, 2026 at 10:35:31PM +0800, Tao Cui wrote:
>> +/*
>> +/*
>> + * Deliver iocg_init()/iocg_free() to the cgroups already online on the
> 
> The comment opens with "/*" twice. clang warns "'/*' within block comment
> [-Wcomment]" and CONFIG_WERROR builds break.
> 
A stray line was left over from an earlier edit. Sorry about that.
>> +			/*
>> +			 * A blkg which never went online never reached the
>> +			 * radix tree, so it must not receive an init either;
>> ...
>> +			if (!iocg || !iocg->pd.online)
>> +				continue;
> 
> blkg_create() adds a blkg to q->blkg_list only after radix_tree_insert()
> succeeds, so the blkgs skipped here are the ones blkg_destroy() already
> took offline, not ones that never reached the radix tree.
> 
You're right, the comment described the wrong blkgs. It goes away with
the walk, which I'll drop in v12 together with the callbacks.

>> +	if (!disk_live(disk)) {
>> +		mutex_unlock(&q->rq_qos_mutex);
>> +		blk_mq_unfreeze_queue(q, memflags);
>> +		blkdev_put_no_open(bdev);
>> +		return -ENODEV;
>> +	}
> 
> The guard() suggestion from v10 was only partly applied. This unlock,
> unfreeze and put sequence is repeated on three error paths.
> 
I'll fold the reg error path into a single out label. Detach no longer
needs the freeze after the v12 rework.

>> +	/*
>> +	 * Scope the mutex so the tail bdev put runs with blkcg_mutex
>> +	 * already released: dropping the last device reference can
>> +	 * reach disk_release() -> blkcg_exit_disk() ->
>> +	 * blkg_destroy_all(), which takes q->blkcg_mutex.
>> +	 */
>> +	{
>> +		guard(mutex)(&q->blkcg_mutex);
> 
> The bare { } block isn't necessary, and ioc_bpf_detach() has the same
> block with the same comment. Can you drop them?
> 
I'll drop both.
>> +	/*
>> +	 * The attachment is checked under rq_qos_mutex first, so an unmatched
>> +	 * detach exits without freezing.
>> +	 */
>> +	mutex_lock(&q->rq_qos_mutex);
>> +	spin_lock_irq(&q->queue_lock);
>> +	ioc = q_to_ioc(q);
>> +	if (ioc) {
>> +		spin_lock(&ioc->lock);
>> +		matched = ioc_attached_model_locked(ioc) == ops &&
>> +			  ioc->bpf_link == link;
>> ...
> 
> The same 11 lines check the attachment again after the freeze. The check
> under rq_qos_mutex after the freeze is the one that matters.
> 
This goes away with the freeze removal: detach becomes a single
mutex-critical section.
>> +/*
>> + * Pluggable cost model interface for blk-iocost.
>> + *
>> + * A BPF struct_ops implementation can take over the cost model of one device.
>> ...
>> + * offline and its free. Both callbacks are called with ioc->lock held and must
>> + * not sleep; the delivery points nest inside queue_lock except for iocg_free()
>> + * from ioc_pd_free() in blkg_free_workfn().
>> + */
> 
> This restates the attach mechanics and lists the call sites. The comments
> and descriptions in general are still long and narrate mechanics.
> 
v12 folds everything back into blk-iocost.c, so the private header and
the long interface comment both go away.

Thanks,
Tao

> Thanks.
> 
> --
> tejun

