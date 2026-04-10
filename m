Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2E35CBC3;
	Fri, 10 Apr 2026 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803567; cv=none; b=aFIr1U/ox/wXCscAhgcZ1iLf49Xfd53o20mt3rytBfk3cuDr89IYCFd4tPnl276oU1f6fFdRL6bO+EsUU+CydxPRSq4RB4+Z3GwBKlQvUk1N9TgZWB0H+flxB1/C3ghOFN4Xx2nZ/MpHipU451Kmw7YYDomOGDPxnATwOzHKhXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803567; c=relaxed/simple;
	bh=iQzlLilWtocvd6uLsezDvskuGvJwo2dkB/xIWOyud2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srbls7alPkvv86En6vmsVSHKiLWKWVq8usRr5Bqyy7pNobalP5Z2MyGI2MduNFwT+MR1j8XD+oKHcuLoGxoNSC7q+v8ptEh3k4jss1QiR/Na1iglPKiri+asH1VzNS4DVypE0igSFLN15oAqnl98ntS1Pl9vmZx9AYWy1Ij2gwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UFYkrM6T; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UFYkrM6T"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775803562; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Et5kuzAgXyxKomaZmeSluAIe6eBbOj9IAO1Yolsuvzg=;
	b=UFYkrM6TpY7Z50PromvhFw4v3mYb/eNs5KOXKxIL/jP/oRnVo6Bjj9agbZyq2/In4hWI1RuPCKUUGg6PG9MMDsmOY3jhB5T44WGdo2kr2qc0ZYuEycg35u8qYNaQ6JioB+efBufE3AGWR1GDzoSFQ5lJ7lKwyaKLTgvIos4YvN0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X0kUbGL_1775803560;
Received: from 30.221.132.105(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0kUbGL_1775803560 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 14:46:01 +0800
Message-ID: <b3dfc06b-9f9b-4337-be96-a277061517d0@linux.alibaba.com>
Date: Fri, 10 Apr 2026 14:46:00 +0800
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
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
 <acYVjuDOD7NynO9m@infradead.org> <20260327060518.GP6202@frogsfrogsfrogs>
 <20260407-unmengen-wahltag-474557ec0c58@brauner>
 <adUalnAyY9mm1LUr@infradead.org>
 <20260409-vorsichtig-umstand-d417555377e4@brauner>
 <ade2nskzkdcsvF55@infradead.org>
 <d889ed2b-ca34-4e95-ae5b-1d66636b515d@linux.alibaba.com>
 <adfPlQrImtuyhMIO@infradead.org>
 <7a605318-9f09-436f-806e-d4a3bd31b97d@linux.alibaba.com>
 <adiVdIhcgfiIoXja@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <adiVdIhcgfiIoXja@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/4/10 14:15, Christoph Hellwig wrote:
> On Fri, Apr 10, 2026 at 12:42:41AM +0800, Gao Xiang wrote:
>>>    - a lot less I/O amplification
>>
>> But not quite sure recently how extended OOB data is
>> kept within the physical media (I remembered in the
>> early years each page of raw nand flashes has
>> several-byte OOB together with the user data): if
>> it's along with the corresponding LBA main area, I
>> guess it has to read extended data among multiple
>> LBAs (but the LBA main data may not relate to this
>> partcular I/O) in order to verify the hash of the
>> hashes.
> 
> For HDD it it is stored next to the media, and doesn't introduce
> extra seeks.  For NAND-based SSDs it typically is stored close to
> the data as well.  NAND pages are significantly larger than the
> exposed block size for any modern SSD.

Ok, thanks.

> 
>>
>>>    - a sane way to actually have verification (including authenticated
>>>      encryption) in a writable file system
>>
>> Yet if considering modification, it need to move up
>> the tree and recalculate/update all hashes until the
>> root hash, it's not a low-overhead task TBH, and need
>> to apply to every single on-disk change.
> 
> It needs to be applied in-memory for every changed, and persisted to
> disk on every fsync or equivalent operation.

Yes, yet it doesn't change my evaluation: and you need
to consider background writebacks too (since writeback
will update data and then impact the whole hash tree).

Currently data writeback can be applied for each block
independently, but if you consider maintaining a hash
tree (rather than simple checksums), I guess you have
to keep strict atomicity between data writeback,
metadata and hash-tree writeback, otherwise the hashes
and partial writeback data will be mismatched.

I won't say it's impossible, in short I have to say
it's just not a straight-forward task compared to the
previous data checksums, e.g. for XFS, maybe journalled
COW approach has to be used since it's hard to keep
such atomicity for XFS without COW.

Yes, the OOB approach for leaf hashes will help to
reduce write amplification, but my current observation
is that it won't have any help to read amplification,
especially for small random read; overall it depends
on the target workload.

Thanks,
Gao Xiang

