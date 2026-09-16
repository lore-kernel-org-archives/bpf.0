Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1222389E07;
	Wed, 16 Sep 2026 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541131; cv=none; b=uwdAKWG2G2AtTOUfH1kJ19ogzP+Hp6lgl/hvoZIsrW5dRcrzavrh6QtGXYKfRNX3GcJixVk/infXKbf8hyKABHhHVD13KZnQ/uKsNo3fZmctrtOqr58Cy5vdKaQ6pyKqqeyHdC8lsLCDh5bK2dtxSvdLaSWGu7XnarOTODSK6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541131; c=relaxed/simple;
	bh=q1IsMRmPA7Ces1FEWyRaFCf4gETSf0lnjlirzRbWkr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJd1PntMMe6YGfEel2GLVLw65xxMA6WiOzRYJ1tvrrxFwel8hyA/9jbzuGgm3qwnk4ZexP6PpDxFzGjDdJqqmJ8qU9UFE3tRivym2sTKYk2LknxRO2GWXFFqxuxzxwMa19IkdMgsavfLS+FVOWZ4lL5EXLGVKOWKROgPCwZ+mfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a24crPNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a24crPNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A1F1F000FF;
	Wed, 16 Sep 2026 06:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541130;
	bh=7kOVTiaKYllY3V4jp//C0OkA7X2Eu1Ktbsk1TPaoM6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a24crPNBYsEfOEPT/HpbL+mpioy8f3iQuz4Nz1u26GkugTTzG14UBioK8Uk7W6gSg
	 YvUD8Ud5FPp1UScI9ycz3EejphPLRe6/6LJet1tgutFl18vtzbPq9118b48PibSXZz
	 ZT83Bx4zlie3HdLIAI4PbrybL1+gvc2a4lKe0s2Nk+5gk+2dlTnMTd25RIn8/leSyy
	 1SlL/G3o3gPAnkY38dk6niz30hOJwSlShJrMou7kUns/yb2+iDF4XQ7CErnn/062ad
	 xNCy4/ra59OyG/FU2tE65R86Yqm0TVVR29AJXeMBbhjRsVTySB84cc450YqcvG6/Tl
	 4ojbSxqK6sIgw==
Message-ID: <a184d9c0-aa3a-4d00-9a0e-e7a1d9d344b0@kernel.org>
Date: Wed, 16 Sep 2026 08:45:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support
To: Simon Schippers <simon.schippers@tu-dortmund.de>, netdev@vger.kernel.org,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Cc: kernel-team@cloudflare.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Chris Arges <carges@cloudflare.com>, Mike Freemon <mfreemon@cloudflare.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Breno Leitao <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20260612083530.1650245-1-hawk@kernel.org>
 <ed63c31c-0d05-4532-bed6-23b7608ec5e2@tu-dortmund.de>
 <3a3a99dc-b554-4b5d-a004-67454e66e5e0@tu-dortmund.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <3a3a99dc-b554-4b5d-a004-67454e66e5e0@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/15/26 16:30, Simon Schippers wrote:
> On 8/10/26 15:25, Simon Schippers wrote:
>> On 6/12/26 10:35, hawk@kernel.org wrote:
>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>
>>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>>> latency by dynamically limiting in-flight packets in the ptr_ring and
>>> moving buffering into the qdisc where AQM algorithms can act on it.
>>
>> Hi :)
>>
>> I worked on my implementation of DQL coalescing that lives in
>> dynamic_queue_limits.{h,c} and wanted to share it so we can consider it
>> for the next cycle. This is because in the next cycle I would
>> like to add BQL support for tun/tap as well, in addition to veth.
>> Is that fine for you?
>>
>> I think it is in good shape. It uses the same logic as the v7, but
>> every new field fits inside the existing dql struct, and drivers only
>> need to call the usual netdev_tx_sent_queue() and
>> netdev_tx_completed_queue() to use it. Patch 3, 5 and 6 are the same
>> as before, only 1, 2 and 4 are new. Benchmarks looked fine for me.
>>
>> There should be no regressions for other DQL/BQL users. I paid close
>> attention not to break the dql cache lines or other logic.
>> coal_usecs is now configurable per queue via sysfs and also via ethtool
>> as usual.
>>
>> While working on this, I found a missing barrier in v7:
>> There was no smp_rmb() pairing the smp_wmb() in __ptr_ring_produce()
>> before dql_completed() reads dql->num_queued. This happens to be safe
>> on x86, but on other platforms the read of dql->num_queued could be
>> reordered before __ptr_ring_consume(), triggering a BUG_ON() in
>> dql_completed(). Fixed by adding the missing smp_rmb() in veth_xdp_rcv()
>> before completing.
>>
>> Would love to hear your thoughts on the implementation!
>>
>> Thanks,
>> Simon
> 
> Hi! Any thoughts on this? Do you want to continue this series?

Appreciate getting poked :-)

I will not have time to work on this until after October 5th.

If you Simon have time, feel free to submit a V8 patchset with the
barrier fix mentioned above.  I should have cycles to review and ACK
(except between 26 sep to Oct 4).

We are still interested in getting this merged. Notice the bug fix from
Jonas 60db47f02bfa ("veth: fix queue index used to wake the peer txq in
veth_poll").  We are running XDP on our veth production interfaces, so
we didn't notice this.  Still, we are currently waiting for this fix to
get fully rolled out, before proceeding with the BQL variant.

--Jesper


