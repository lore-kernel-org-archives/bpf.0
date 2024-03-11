Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E4199AD
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150909; cv=none; b=H94/0qFk9wZ7nmbXbZERsRKLJ1cWCxsIulbGqHr+OxtS8rwm7Kk+qyiLVko8y2nEmdkI8Tob+U9cCwZ2r3PRPzlgl077pk4pt0RNj5F6xI8W0B7EOZTcnQZqtZJpS9JgGvyLt1AfRtcXSXarFeicNGNJTplDXHeyyg7hac9S4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150909; c=relaxed/simple;
	bh=5/qiiXwZTYdXODnxnJTgNllc8AomJcW2umJjIPgjH2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKyNwFzu1VhcA1eaTAYO5Kn1Lw03oAs2GUKVv8joFjHyjfjbtxapX2y71L3yRcdLR4kEuUfarzrvLelT0FmW4YB/wuj8iTYJijEq/dR0sbed69+XH5tWwOh6w9JuWuNVu3ZcZU40yYHOBCQ7gBGBPBuHWArBL8Vay2Pi0CoTGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kg8KKzce; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kg8KKzce"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710150897; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=5/qiiXwZTYdXODnxnJTgNllc8AomJcW2umJjIPgjH2U=;
	b=kg8KKzceM1XioczzNUXfI708VV2/l1OpccdorDnmT4KBJQkBpmFxdg4hEl52jBZcLnDqPl+nfmu3nDSWDiB/NnYnRXOwFuemJefCXpp3AnnesHEh/qDtv4CYelxXohi7XKgnoKNEPjZJHc1mrgnpioRHy2AwCxZzxIFe1umvIbE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2F3SYm_1710150896;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0W2F3SYm_1710150896)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 17:54:57 +0800
Date: Mon, 11 Mar 2024 17:54:56 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"a.mehrab@bytedance.com" <a.mehrab@bytedance.com>
Subject: Re: [LSF/MM/BPF TOPIC] Inter-VM Shared Memory Communications with
 eBPF
Message-ID: <20240311095456.GA40084@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <CAM_iQpXzAYFES62Cbj8PoGqr_OW=R+Y-ac=6s3kmp5373R7RzQ@mail.gmail.com>
 <20240304095947.GB123222@linux.alibaba.com>
 <CAM_iQpXKi3tYb+5O=NRi_C-eGCRYiZgk96=egFaKAPa3KX8joA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_iQpXKi3tYb+5O=NRi_C-eGCRYiZgk96=egFaKAPa3KX8joA@mail.gmail.com>

On Thu, Mar 07, 2024 at 07:52:52PM -0800, Cong Wang wrote:
>On Mon, Mar 4, 2024 at 1:59 AM Dust Li <dust.li@linux.alibaba.com> wrote:
>>
>> On Fri, Feb 23, 2024 at 03:05:59PM -0800, Cong Wang wrote:
>>
>> Hi Cong,
>>
>> This is a good topic !
>> We have proposed another solution to accelerate Inter-VM tcp/ip communication
>> transparently within the same host based on SMC-D + virtio-ism
>> https://lists.oasis-open.org/archives/virtio-comment/202212/msg00030.html
>>
>> I don't know, can we do better with your proposal ?
>
>We knew SMC and it _is_ actually why I have this eBPF based proposal.
>Sorry for not providing more details here, since I just want to keep
>this proposal
>brief and will certain have all the details in our presentation if our
>proposal gets
>accepted.
>
>The main problem of SMC is it is not fully transparent, LD_PRELOAD could
>work for most cases but not all. Therefore, I don't think introducing any new
>socket family is in the right direction at all.

Actually, this is not really true. We have introduce several ways to solve
this. The best way I think is to support IPPROTO_SMC[1] in SMC and using the
same eBPF infrastructure as MPTCP has already contributed[2].

[1] https://lore.kernel.org/netdev/20231113045758.GB121324@linux.alibaba.com
[2] https://lore.kernel.org/all/cover.1692147782.git.geliang.tang@suse.com

>
>(There are some other problems with SMC too, for instance, it requires more
>than a 3-way handshake.)

Right, but I don't see much performance penalty because of the extra handshake,
setting up the share memory is always the slowest part in a share memory
communication model.

>
>And I don't think there is any conflict or overlap here at all. Our eBPF-based
>solution relies on the existing inter-VM shared memory, no matter it is ivshmem
>or virtio-ism. We don't propose any new way of sharing memory, what we
>propose is merely using an existing one and building our solution on top.
>
>In fact, we believe our solution can be on top of your virtio-ism,
>since it is just
>another flat memory region from our point of view.
>
>Hope this helps.

Don't get me wrong, I'm not against to your proposal at all, I like it.
I just hope different solutions can be seen.

Best regards,
Dust

>
>Thanks.
