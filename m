Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D029B78D;
	Thu,  9 Apr 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745473; cv=none; b=l7f4dHVaulePgQrOEu98Z5baLTIteoH+S4SSHNQsrc1hnuxCo+p0NSCB9pJ/Lbqg9kYehu+1YEXQBIorwqEMgSu8qmaxugqf47SdFOlgtOZ5ITb4wIYGPlRJ3IkkdkzACt7vAGJjJ/WTogh02FXJ3PyO2OuOJv+tFky+GqcqPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745473; c=relaxed/simple;
	bh=6DWMFvsSMDfBi+51f0s0BGiwf4kZBzVSyVt4VWnrKrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTU4GapAwBdxabBdtjBPNQPUqzmijCxVqsOccvC7x53zQbhbBeQ30dJS5SSZAfQazYTM4Tv6+NejvdU2q1TSHJUD13UzCSU3rYWmAha2kWt3Nur2w0V21QCSwAB1XoHjnhIANf3gDheXmr1V3xk6AjdHB4bj+9gvV06QeLdrxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vs9L2UCA; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vs9L2UCA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775745468; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E1p69RJjKiJrkHqzfUHfp5KTa/fZVVB2ULuTIqlExdQ=;
	b=vs9L2UCABEOqda9/HNISxuk2Z7lNcQ1UDhyMnhYHjEYrI8bpiLXD0X95XaMYp58i+MqvRy9554RvqFH2MB/L3hSOCCNr3FEmQSPSr0mw0V7hLlYWlFE8rAXfxDwwRE44/tCYOr1PRKT35P+T7zTtbrudEP5eKuaraLj3isrbn/0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X0iXRcm_1775745467;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0iXRcm_1775745467 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 22:37:47 +0800
Message-ID: <d889ed2b-ca34-4e95-ae5b-1d66636b515d@linux.alibaba.com>
Date: Thu, 9 Apr 2026 22:37:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: add bpf_real_inode() kfunc
To: Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260326-work-bpf-verity-v1-1-efe9edc46ddc@kernel.org>
 <acYVjuDOD7NynO9m@infradead.org> <20260327060518.GP6202@frogsfrogsfrogs>
 <20260407-unmengen-wahltag-474557ec0c58@brauner>
 <adUalnAyY9mm1LUr@infradead.org>
 <20260409-vorsichtig-umstand-d417555377e4@brauner>
 <ade2nskzkdcsvF55@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ade2nskzkdcsvF55@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/4/9 22:24, Christoph Hellwig wrote:
> On Thu, Apr 09, 2026 at 03:19:27PM +0200, Christian Brauner wrote:
>>> ways to do full file system verity [1] much more efficiently inside the
>>> file systems, and it would be good to not lock in a specific solution
>>
>> Note about that: we generally don't rely on any verity implementation
>> that makes the verity information itself part of the on-disk filesystem
>> format. The nice property of dm-verity is that the integrity is
>> completely separate from the filesystem format and it's basically simple
>> math that is trivially to prove correct.
> 
> Any file system integrated version storing the hashed in the extended
> LBA data (which Linux also confusingly calls intgrity data) would be
> even simpler and easier to verify.  But yes, we need to clearly
> document what we want.

Yes, you could keep hash / checksum in the extended OOB area, but
I guess you still don't know if the hash / checksum of the
particular data can be trusted (or is changed by attackers).

I think the key point of merkle tree approach is not only for
data integrity but also to distribute the trust between all
hashes by calculating the hash (of the hashes) of the hashes
so that you could get the only one root hash value regardless
of how to organize the container filesystem (meta)data so
that it's totally seperated from individual filesystem layouts
and can be proven seperately and even implemented easily by
hardware/firmware rather than inside the specific filesystem
implementation.

Thanks,
Gao Xiang
