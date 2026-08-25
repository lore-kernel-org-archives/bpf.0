Received: from mta0.migadu.com (out-104.mta0.migadu.com [91.218.175.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0B2F84F
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656815; cv=none; b=NbaF0alrRZTBtAJyQOtkKXfrGVXRZvuDqh7D5QFNjxDo04j0HCp3CdF0Gjy3WrHI2B5SEkTvT+3n2ug2bGLZZBplC3ptVWr/HuYBbXa5B2CqGlZ2wmiipogg7II9y4r1UoM/TXp5X0/p1Y6tWOCWdxPwb3uLHDkrNl4nxbg91u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656815; c=relaxed/simple;
	bh=zqduEjtd8XwVJu7zEy3j+l82hl9wJpaQZSdWvMfA9tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjOzitQCPXGrbtdYDhK/fmDgbq7hs2jLdn8lRxNP4ZjmwJeuxyIIWRm3A5m0D7AkfQEfKMygVqatHLLG6hTRQTSwjgrkKYZZAji62GNRxvcmPoyOaloLDKxt7Dvz7bJC3XsuEwDrc+SnybYgqs1Q+vRcoUsIODbPJMMMhFLkdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H50OGdd+; arc=none smtp.client-ip=91.218.175.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H50OGdd+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zqduEjtd8XwVJu7zEy3j+l82hl9wJpaQZSdWvMfA9tA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787656810; v=1; x=1788261610;
 b=H50OGdd+9qUQ60cqKsbrPbeyNUaMwacVwDTlQX898AoalCIornrgQ6ad5SvYm4PNwUBKJADD
 Bw8dHf7AtX09LP2wi3jf28Oq+afIi3T55r4PFYcVQnar1aos+n+1u7Yaqk1Ny2Jzd6QB138wqcL
 ajY7e4/1eo3QSCKmQFki9IzI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id 0b3c8892de718a1a;
	Tue, 25 Aug 2026 11:20:04 +0000
X-Mizu-Trace-ID: 0b3c8892de718a1a
X-Migadu-Flow: FLOW_OUT
Message-ID: <ab878224-d75f-45e7-b625-39c4f56e548b@linux.dev>
Date: Tue, 25 Aug 2026 19:19:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add a test for arena
 fault-in under memory.max
To: Khawar Ahemad <ahemadkhawar123@gmail.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, emil@etsalapatis.com,
 martin.lau@linux.dev, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20260825094955.83240-5-ahemadkhawar123@gmail.com>
 <20260825104311.84038-1-ahemadkhawar123@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260825104311.84038-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/26 6:43 PM, Khawar Ahemad wrote:
> Addressing the three CI review comments on the v6 series:
>
> ---
> [Patch 4/4] max_entries comment
> ---
>
>> could the 50000 carry a short note that it just has to outrun
>> ARENA_BUDGET on the smallest page size
> Accepted. Will be fixed in v7 as a proper preceding block comment:
>
>    /*
>     * 50000 pages must exceed ARENA_BUDGET / PAGE_SIZE (64M / 4k = 16384)
>     * so the fault loop hits memory.max before exhausting the arena itself.
>     */
>    __uint(max_entries, 50000);


Not that simple.

It also make sure the arean not exceed 4G when page size is 64K.


---

Please don't submit further versions of this patchset. I have already 
prepared a

V6 (the one you sent), and I'm planning to send it myself. Additional 
submissions

from you would create unnecessary conflicts and confusion.


If you're interested in this series, I'd really appreciate your review 
and feedback instead.

I'll also be sure to cc you on future versions.


Best regards

