Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C936E484
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209327; cv=none; b=F/pYLecLJySZQtwWHTAXVx6HlSFRMZczgjYgnvDLn8k5OaFzNYwkgMx4bgpBehwisQdeT1TugW7JAxD6m7q8Yg7LTtJXaa0EmycktaNqzLK7h/8sC8BTqroZWCUXg3qwSOGyKp9EKVAzOA/c0FARaetALq9M3zvulkYpvvCM0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209327; c=relaxed/simple;
	bh=pZkGyJopL74VE7VjsYav1R6gjjaDsoahje4YVAHTnSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFX1SgOUkeZ1XvWyqQ8OhdQbRgzMIhFWSQE+ZerKPqFHhA45a1X1TWfoCGQQv7sVksigFpT/0F/pPxrc2yo7mbQBpYfYihOJNx48OGf+rwDm4jUgYrBp6Zl77WIcbkd2Xw0O4dy0iLPpyJSdxD5Xv2tGE9uwZtJTrMY641/Bkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r91+eaR0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r91+eaR0"
Message-ID: <3953e554-9bc4-419e-ac9f-aea3b9fd7b80@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782209313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFD9Jph6crM5nRNftF28H4XfKyHcXZ2YzNtJaYuppo4=;
	b=r91+eaR0Nr0qBjKAaIQNfjey8g1pvhMtE6060+u+/4sxIjmf49565VJ6VfPj5dZttupYHV
	zM/D7QCVFqHmq5f8eB7nx1yxlVJkJ0tTpdeMbsvP18UebzM5PUE2LIGyk6uMLXgmqXAH2w
	Dd2HaygB9kXSGGrslxF8VMxUS+tbKDM=
Date: Tue, 23 Jun 2026 18:08:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net, bpf: check master for NULL in
 xdp_master_redirect()
To: Ido Schimmel <idosch@nvidia.com>, Xiang Mei <xmei5@asu.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Jussi Maki <joamaki@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Weiming Shi <bestswngs@gmail.com>, Ido Schimmel <idosch@idosch.org>,
 David Ahern <dsahern@gmail.com>
References: <20260620201531.180123-1-xmei5@asu.edu>
 <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
 <CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
 <20260622155854.75977aac@kernel.org>
 <CAPpSM+Q4O704OaUAXqKpL6ffvudTfqzzLzLExziUExgvxQWmxw@mail.gmail.com>
 <20260623065218.GA378121@shredder>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260623065218.GA378121@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/23/26 2:52 PM, Ido Schimmel wrote:
> On Mon, Jun 22, 2026 at 04:34:06PM -0700, Xiang Mei wrote:
>> On Mon, Jun 22, 2026 at 3:58 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>> Can you double-confirm that this triggers on current HEAD
>>> of linux/master ? I thought commit 2674d603a9e6 ("vrf: Fix a potential
>>> NPD when removing a port from a VRF") was supposed to prevent all the
>>> torn master fetches. Adding VRF folks to CC.
>> Yes.
>>
>> We have triggered the crash on 56abdaebbf0da304b860bed1f2b5a85f5a6a16a0,
>> which is the latest for net.git, and 2674d603a9e6 was applied. We can
>> still trigger the crash:
> 2674d603a9e6 was only for VRF ports, so it doesn't help with this case
> (bond port). Also, the problem that 2674d603a9e6 fixed is a bit
> different. We had a NULL check after netdev_master_upper_dev_get_rcu(),
> but the issue was that this master device was not necessarily a VRF
> master.
Agree, it seems that 2674d603a9e6 only focus on VRF side.

>
> Looking at __bond_release_one(), assuming that
> netdev_master_upper_dev_get_rcu() returned a master device, I believe it
> must be a bond because you have a synchronize_rcu() after
> bond_upper_dev_unlink().
Right, synchronize_rcu() only guarantees that the master device is not freed
while our RCU reader is operating on it, but it does not guarantee that
we can successfully acquire the master device. We still need NULL check 
here.
