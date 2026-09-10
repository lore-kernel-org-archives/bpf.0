Received: from mta0.migadu.com (out-242.mta0.migadu.com [91.218.175.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4334A3AB
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789016432; cv=none; b=Osk8IKGPTwPLvCfmzEa2MhUejBGDphB0UhwwOJxHVrQ+aFdUGd+A/7sSFKQ8VGve3e40u8Om2Jfn6ZY9aQukLqxijshKcfpHTudsHOx4a8XO+XF29kXWpA3kyEwQfwiOEQ7zv6Fn/QRxT83nvjEBhEtvIuZulBqhStjmogpUixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789016432; c=relaxed/simple;
	bh=NZfSQsLOHAiY2kIeMn9j02TOWHpXBQxHHQ5+rUxbFNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUTRV3+QU0J8ahlWbf/mb6vI4f/wId1jl0SRGohJE9B3kclMK8s1G8JJraJEx8A9x9FutOOhZ5YnJ2PHfMtIlUL2ljJUGL/BoyXSwZa1I9RkxgDoUk9PfobGE65WXCobRToVc90RJX+xBiBsM0TbhLfeirYphELJzb2BowZZOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XYBzoTbu; arc=none smtp.client-ip=91.218.175.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XYBzoTbu"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NZfSQsLOHAiY2kIeMn9j02TOWHpXBQxHHQ5+rUxbFNI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789016428; v=1; x=1789621228;
 b=XYBzoTbuBZkC8FE2CBJ1K1/hghzmsFbH3aUe+QiAwOFUsx014Aqew/QnQ/BfOerq733/1mm9
 Lad9cGJbOzQSVRF9JD9mgmeTcTs8K+AbJfVBa4sVW+xvVYZgQvIVNF5+p0/YS8PlOSNlTyCT44R
 72yOdTh4CWKgNx71iZoZOCls=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2f87827b12b268bf;
	Thu, 10 Sep 2026 05:00:06 +0000
X-Mizu-Trace-ID: 2f87827b12b268bf
X-Migadu-Flow: FLOW_OUT
Message-ID: <7f3e237e-ac5c-46af-ae21-8b437a099fe3@linux.dev>
Date: Thu, 10 Sep 2026 12:59:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
To: Nikhil Ludder <nikhilljatt@gmail.com>,
 Emil Tsalapatis <linux-lists@etsalapatis.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 horms@kernel.org, dsahern@gmail.com, hawk@kernel.org, razor@blackwall.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
 <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
 <178898653497.1776876.10402414041023036972@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <178898653497.1776876.10402414041023036972@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/10/26 4:42 AM, Nikhil Ludder wrote:
> On Wed, Sep 9, 2026 at 1:18 PM Emil Tsalapatis <linux-lists@etsalapatis.com> wrote:
>> Bot is right wrt possible lockups, please adjust the seqlock
>> accordingly. Also please
>> add your full name in the SOB.
> Will fix the SOB in v2, thanks.
>
> On the lockup: I don't think it can happen here.  neigh->ha_lock has
> exactly one writer in the tree, __neigh_update() at
> net/core/neighbour.c:1495, and it already runs with softirqs disabled:
> write_lock_bh(&neigh->lock) at line 1384 covers it through
> write_unlock_bh() at line 1524.  A reader in softirq context therefore
> cannot preempt the writer on the same CPU and spin on the sequence
> count.


Yes, no deadlock.


BTW, if an IPoIB device can show up here, dmac is already truncated 
today and

the packet can't be forwarded anyway.

Shouldn't we just reject addr_len != ETH_ALEN instead of open-coding the 
copy?

Then you can use the native function instead.

> The same pattern is already used by the other lockless readers of
> neigh->ha on the tx path, neigh_resolve_output() and
> neigh_connected_output() (neighbour.c:1610 and :1639), and by the two
> recent fixes this patch follows, 57549ab90791 ("net: bridge: arp/nd
> proxy: fix reading neigh ha") and b824059a673b ("vxlan: fix reading
> neigh ha").
>
> Am I missing a writer path?  If you would still prefer a different
> form here, I am happy to respin.
>
> Thanks,
> Nikhil



