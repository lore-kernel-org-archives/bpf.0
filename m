Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87B3B388C;
	Tue, 15 Sep 2026 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482689; cv=none; b=aa94TC9mAUDK7Q/6F6r0/K+2kMBKTfqm6rPhT3ujuMzB2LJz/yqNQ4bAv53n4dqcHeeBgNRdSIkyY+svjxyqr4V2/UfrgPMhVII0sqzKHC24cNy7lLFysFlACHcSoZ50kEsi/DPo368uTDCpqyj1q6Rjr0q+WuV+KmKdPZo5Vc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482689; c=relaxed/simple;
	bh=+kBGqe8h4w8eUaxlwskTO/ZRJxZ8AMVDWo2sTnpYJrw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AZR4gYieiWNhdMOfxhxEQPY+VW+6Q5y1/hw2w5a+YUT9pzi2es3iHa54MFt0iUXJxXnNocR/KtNRUcDOZSlQn7R/7fBZL5isW9kTzf3GnnlES2O/1dbdG7awjzaPLDgW1aH4Ixs/GkVWjYsw+p9l9r+UcrhBGta3B5ZzPH03Z6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=jqH42mZz; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="jqH42mZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1789482656;
	bh=XFtpK+hFHFYONy2lQaPpAqFbvrO8GHLT/QT6zQQRxts=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=jqH42mZzUZ2GTyCt1RYK+47kPBdw5i+w2ryL1sPT9FcPDMxi5AlieHOmql/WQu8Yn
	 rz7rVm7V1Vr5f38QhLXIbmLYBeU4W4fBHBpIpMsaSf0sDHvJaERoSKh/JrQw8Cxvtm
	 UWl5vS2Lhpp0kT1H2BvmkWqwxCU324IQQoV7KP+s=
Received: from [192.168.178.125] (pd9eaaf06.dip0.t-ipconnect.de [217.234.175.6])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 68FEUtsS023932
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 16:30:55 +0200 (CEST)
Message-ID: <3a3a99dc-b554-4b5d-a004-67454e66e5e0@tu-dortmund.de>
Date: Tue, 15 Sep 2026 16:30:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: hawk@kernel.org, netdev@vger.kernel.org,
        =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Cc: kernel-team@cloudflare.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Chris Arges <carges@cloudflare.com>,
        Mike Freemon <mfreemon@cloudflare.com>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Breno Leitao <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20260612083530.1650245-1-hawk@kernel.org>
 <ed63c31c-0d05-4532-bed6-23b7608ec5e2@tu-dortmund.de>
Content-Language: en-US
In-Reply-To: <ed63c31c-0d05-4532-bed6-23b7608ec5e2@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 15:25, Simon Schippers wrote:
> On 6/12/26 10:35, hawk@kernel.org wrote:
>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>> latency by dynamically limiting in-flight packets in the ptr_ring and
>> moving buffering into the qdisc where AQM algorithms can act on it.
> 
> Hi :)
> 
> I worked on my implementation of DQL coalescing that lives in
> dynamic_queue_limits.{h,c} and wanted to share it so we can consider it
> for the next cycle. This is because in the next cycle I would
> like to add BQL support for tun/tap as well, in addition to veth.
> Is that fine for you?
> 
> I think it is in good shape. It uses the same logic as the v7, but
> every new field fits inside the existing dql struct, and drivers only
> need to call the usual netdev_tx_sent_queue() and
> netdev_tx_completed_queue() to use it. Patch 3, 5 and 6 are the same
> as before, only 1, 2 and 4 are new. Benchmarks looked fine for me.
> 
> There should be no regressions for other DQL/BQL users. I paid close
> attention not to break the dql cache lines or other logic.
> coal_usecs is now configurable per queue via sysfs and also via ethtool
> as usual.
> 
> While working on this, I found a missing barrier in v7:
> There was no smp_rmb() pairing the smp_wmb() in __ptr_ring_produce()
> before dql_completed() reads dql->num_queued. This happens to be safe
> on x86, but on other platforms the read of dql->num_queued could be
> reordered before __ptr_ring_consume(), triggering a BUG_ON() in
> dql_completed(). Fixed by adding the missing smp_rmb() in veth_xdp_rcv()
> before completing.
> 
> Would love to hear your thoughts on the implementation!
> 
> Thanks,
> Simon

Hi! Any thoughts on this? Do you want to continue this series?

Thanks!

