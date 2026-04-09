Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29743E121E;
	Thu,  9 Apr 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752969; cv=none; b=sZxnXiZJxN6cLO5dJ4tFSFu5sMUTselYachP4x66IAYkS8jbvTL7e9K30YqckPJhoVjY/vosH4rathXlI6QlIavlp3fmmxwmLy0pYMyWFgBfhcJDP8AF6WRKhXaUjPh4wG27tErDiFw9CBQWLUaNU3nl5ERefsQJXMsuw6h1XMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752969; c=relaxed/simple;
	bh=e1GHiDQnkG4+YvwWHr7dIxPUJxi6f+Qdj1U6S+A7/nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfA3yp/5+vnPv9P1Jqujt59viNR+qEESmaN295/tp/pnoJ3UsLoUo/ssacQuPr7FW8OL/W6c1hzmNSL3m74tHJahpsmOdMgsKlchCh3XT4QO36L6V2UCNlD6UMhqdwkxUy0cYAbkZ8jQLXj/TzMnBBUUeT/xJTmI9hAHGYNZY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ppVhnp1U; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ppVhnp1U"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775752964; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pE5SZZCM2jccwKUAfKn+9wZt7IDDnmDc748Kcij0lMs=;
	b=ppVhnp1USo2khcubGRe+eZfMnwjpWlbEL7iiz4PLqonw2WQX+rFPA+PKA3dzkzVJ9BCbiadb0KX1jRKlujg6msk8QdSGvIio4VMoOsxqgfc/DJXH6IEATWWmmr7Smc1fy0DLPCh8pkUrj0g3gdkcMkPNFRgpm8RyExIzeCe6+O4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X0imraz_1775752962;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0imraz_1775752962 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 00:42:43 +0800
Message-ID: <7a605318-9f09-436f-806e-d4a3bd31b97d@linux.alibaba.com>
Date: Fri, 10 Apr 2026 00:42:41 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <adfPlQrImtuyhMIO@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2026/4/10 00:11, Christoph Hellwig wrote:
> On Thu, Apr 09, 2026 at 10:37:46PM +0800, Gao Xiang wrote:
>>> LBA data (which Linux also confusingly calls intgrity data) would be
>>> even simpler and easier to verify.  But yes, we need to clearly
>>> document what we want.
>>
>> Yes, you could keep hash / checksum in the extended OOB area, but
>> I guess you still don't know if the hash / checksum of the
>> particular data can be trusted (or is changed by attackers).
> 
> You'd still need to build a full merkle-tree out of them, but storing
> the leaf hashes in the extent LBAs means:

Yes, the leaf hashes can be stored in the extended
LBA area.

> 
>   - a lot less I/O amplification

But not quite sure recently how extended OOB data is
kept within the physical media (I remembered in the
early years each page of raw nand flashes has
several-byte OOB together with the user data): if
it's along with the corresponding LBA main area, I
guess it has to read extended data among multiple
LBAs (but the LBA main data may not relate to this
partcular I/O) in order to verify the hash of the
hashes.

>   - a sane way to actually have verification (including authenticated
>     encryption) in a writable file system

Yet if considering modification, it need to move up
the tree and recalculate/update all hashes until the
root hash, it's not a low-overhead task TBH, and need
to apply to every single on-disk change.

Thanks,
Gao Xiang
