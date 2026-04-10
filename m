Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4F2FE042;
	Fri, 10 Apr 2026 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806188; cv=none; b=dvj/1AaBfrvu99NQMATMUMBGaEMvGxItDZy4BuqoQBuhjhofnRse+RtiKVWeQaqydfD5oGqbVD4SK2fsBeTiMoO5A08ddbEQy845JwCjQMM1ITM+BekhZJU9zhBkEHjeHyjLFQKLHYjnomEVOhcHlO+TKpKwxxOun+zRCP7QdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806188; c=relaxed/simple;
	bh=90quZfFp/zNbAfQjmjjkE6kJ1aAxPV/sS/yGrJcPP/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glOr46KkARCli6m7ZrMSPYF8b/eEp8z8+K0Bmcq8T54droD18zdLXl1PRh9Jfn+c5SHO4BnVSlvhn9ruWUhckzZ2bop3Yrq8X2rRlNjogwPMmLh8Fu7mGMCTAsyy0llgY1s1MC1tfqfoILbUEBCDF9AsGrChZlFNbDbgFnY/J+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F66okIR6; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F66okIR6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775806181; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZiYDJH6G5nEZPKa3wnpYh0WEnqoDw7vS63MMN4mBIRQ=;
	b=F66okIR6zit3L6hacXggTwY1zdderGkDs8Sd3IF12yXb8QycUGcEzMjK0RbsloPI3gc9qFX/7OfV+c92iIkIiaXS/ZYmVb8UBVZSjdXSEqljaIDvkWIUPvLMdTqUM2AHRpv0xYzeTyAAj985edT8hnY3TRc4kDqgr88ghbnHHtA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X0kURBV_1775806179;
Received: from 30.221.132.105(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0kURBV_1775806179 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 15:29:40 +0800
Message-ID: <6bfe805e-be0d-4bd5-ac45-1b58fc55839f@linux.alibaba.com>
Date: Fri, 10 Apr 2026 15:29:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
References: <20260327060518.GP6202@frogsfrogsfrogs>
 <20260407-unmengen-wahltag-474557ec0c58@brauner>
 <adUalnAyY9mm1LUr@infradead.org>
 <20260409-vorsichtig-umstand-d417555377e4@brauner>
 <ade2nskzkdcsvF55@infradead.org>
 <d889ed2b-ca34-4e95-ae5b-1d66636b515d@linux.alibaba.com>
 <adfPlQrImtuyhMIO@infradead.org>
 <7a605318-9f09-436f-806e-d4a3bd31b97d@linux.alibaba.com>
 <adiVdIhcgfiIoXja@infradead.org>
 <b3dfc06b-9f9b-4337-be96-a277061517d0@linux.alibaba.com>
 <adihXuFuuS5uoJ31@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <adihXuFuuS5uoJ31@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/4/10 15:06, Christoph Hellwig wrote:
> On Fri, Apr 10, 2026 at 02:46:00PM +0800, Gao Xiang wrote:
>>> It needs to be applied in-memory for every changed, and persisted to
>>> disk on every fsync or equivalent operation.
>>
>> Yes, yet it doesn't change my evaluation: and you need
>> to consider background writebacks too (since writeback
>> will update data and then impact the whole hash tree).
>>
>> Currently data writeback can be applied for each block
>> independently, but if you consider maintaining a hash
>> tree (rather than simple checksums), I guess you have
>> to keep strict atomicity between data writeback,
>> metadata and hash-tree writeback, otherwise the hashes
>> and partial writeback data will be mismatched.
> 
> You write the leaf checksum with each block.  The rest of the chain
> leading up to the root is kept in metadata tied to the inode and needs
> to be written atomically with the transaction commit that updates the
> on-disk metadata to point to the newly written block.
> 
>> Yes, the OOB approach for leaf hashes will help to
>> reduce write amplification, but my current observation
>> is that it won't have any help to read amplification,
>> especially for small random read; overall it depends
>> on the target workload.
> 
> For HDD is roughly halves the number of seeks for random reads, and
> at least significantly reduces it significantly but quite a bit
> less.  For SSD it reduces the IOPS in a similar way, but for that

Yes, seeks can be reduced and if all related leaf block
hashes can be loaded in a single request (even some main
data blocks may not needed) it will help more; in
practice, a POC forming out to measure the numbers between
hashing in individual blocks or extended area may help to
get more detailed ideas.

If it's useful, I think dm-verity can work out in this way
too as a bogus as long as the device supports it (and
converting between these two metadata formats should be
trivial.)

> you need to max out the IOPS, which for most workloads you won't
> on anything currently (and probably in the future) using erofs.

The problem is not always maximum IOPS (I also suspect
there is such real long-term max-IOPS workload too), but
small random burst I/Os with low latencies is what we
usually care much for typical use cases.

Thanks,
Gao Xiang

