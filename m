Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B63DF00B
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047864; cv=none; b=ILiDw2CZpJZyU2TqdFNEapONingWQl1s87A4GZ7Fd4TCLznSl5MbOesE3IAlbqypXTM+LsLhAVp2CgsOJ7dcKGyA1+NtT2SRKVkQGK5R0bDqEj5frxkc8W7FFyarysrklehnD5+B5LTX+LUK5g3Nzlt9FwOT8QlzVHF+aX4nS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047864; c=relaxed/simple;
	bh=rKnGZyadXRPn7+yUgtk6UZv9kH+5IP0bOXa8EOkSS0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+IrSDwKx1CMdFR2jB+CcDg8/VCHNxHJ6i5v+rvXITyD0N8U4OmOJszbacfU3XsHfeDHiyFk6RVE9Mz5ALa58URblsmVyBnHazMz5unCXqWdiFd8T8w2EnTDQdWlxvGE6D6tmJIuYu1T4UX1inUb/QOYwVf/GzRkeG9GbPJdsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=K+S9Wv+L; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="K+S9Wv+L"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12dca45ca21so468291c88.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1777047862; x=1777652662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6Od9QgYAcJsV8ihusavCJrmScuqDKBApgvlcBNX0xU=;
        b=K+S9Wv+Lx4FumHi/iwwLlqeJdpw1H/kIa67Ay1IH9c7VEfD9bxGb5GuxgZFG3t7Id0
         evelc8FXc/RrUozpk/zeh/xh/Iyai7lcZFpXCDee9MiXz5FsVAuKVBgx19sXIAnW4Ppu
         7xJvG9VedojkNJv9FIerT5jXcPSaIGrNqHEQZBCdUjqJ9iwv5391yJRpj6UAaQnYw9JZ
         nakVc6pI+56xRCFObv/yLpGfDu1KwP/hJroI1F7A+zg+m5Van15pmgTQb9m9JccOgaFz
         E2cCUiFEb0Cna/QKzCEqkJXaYf3a16j0VKx36CAC2AWPQ8iSCrHg37alSbRwgHy4fEfw
         101A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047862; x=1777652662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6Od9QgYAcJsV8ihusavCJrmScuqDKBApgvlcBNX0xU=;
        b=cIXZTAigy0v80GGYwoexqH4W/fmmzfdUHXlKBzeW13OD1+/F/8blmInPRVi6gRhDJY
         PQJ6pX9ZdCL8bqYAdzgzya372OsV77noAEvC1AWb6m6uWyous7V/pyjEWCTTVUh8otzq
         JmRn4nAhxyo8+mE8rwF53w18BoiKAmVUBCYKoX8egiBeolE1VGWyxO828l0TL9RsFD+0
         FO8N2gJm77bKJnNW2YTDX4NokjXfIdcmm/pIhA4ou2edmv82DuEQ7+8bGoo+KEhSln3H
         IFGMaJ0eIiLivqzb9L7m+U5R1Pnm5DWb4rMrHmXyXi+b9YVXKa4ZpTFOch5zInrJdMAm
         r+JQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YW9Cd/vFt6oDLqrsPP1Dx/t1En4+2KBruXEJ8vDq1+Ds0IOwPS9sEWN5YDW35jyNh/yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRXBBlhPM/aXn34V/IvsaZdlkibB+O4YVgwhfAQEmI6eTYEiF
	kaKuMev8c1HBZNZKHu7bLWIw+aLnNWK2rCBGh05LGYTIL5V6QDZRh7rvQBVRNI6fef8=
X-Gm-Gg: AeBDiesVc9CQXm7MOqBuMdBlxD3HwNFf7Jo5cOwpG6jCwFrc4cAWuiJcV+KoNXYiOhR
	PA1SX06qjOo9/+k7KlU/PkjZUHAEVjXZWtu9StzQbmSUf6Snm4vxCsHfjvb8maylLJRIaYpCkC8
	+/SRpT143QebU/pm+hDfBxNbCgktyfBRLGOqS8MeDReh5urNl9frpCmvdZnrroiQ5wv5hFQrJ57
	wy4C55Zmzjy4h7g62b2xVXsVd9nJqTErIVYFodM4l+IppJVb9XbYNq3j3tT68HSxF0BYXuM9NQv
	xqNuUE/8vZjuBuGGhKDY73I/RIZ3rNSgho0e9Q/qI0SWjVNr46WgeO7+NpOLddoLvGZy0jXM3ia
	z1L+TdHXO298n8KU4H2XRqKjDVjL7kLC2lsela10AkaPNlTWI+v648ivPmpNnbPLnlfv//Hnqep
	LRsznFsY/1Puc4Uijwp/OuwS5jKTyO3OB23rGc+0o6lz7eSs5V8lZUUj1w9bQozJjk5GS2VqBZA
	xVO2zIONJIhoqgWUHNZ4g1dTXI4qzoOYFA=
X-Received: by 2002:a05:7300:8607:b0:2d4:94cc:eebb with SMTP id 5a478bee46e88-2e477c9bc50mr17941859eec.13.1777047862086;
        Fri, 24 Apr 2026 09:24:22 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::1:eae7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8aed43sm32348927eec.26.2026.04.24.09.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 09:24:21 -0700 (PDT)
Message-ID: <fa0b5704-21ae-4011-be0c-97fab3a026c5@davidwei.uk>
Date: Fri, 24 Apr 2026 09:24:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 dipayanroy@microsoft.com
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
 <20260409183509.0b24dea6@kernel.org> <20260412125917.4fa8fc8d@kernel.org>
 <ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260416083146.0bb94d2b@kernel.org>
 <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-04-23 05:48, Dipayaan Roy wrote:
> On Thu, Apr 16, 2026 at 08:31:46AM -0700, Jakub Kicinski wrote:
>> On Tue, 14 Apr 2026 09:00:56 -0700 Dipayaan Roy wrote:
>>> I still see roughly a 5% overhead from the atomic refcount operation
>>> itself, but on that platform there is no throughput drop when using
>>> page fragments versus full-page mode.
>>
>> That seems to contradict your claim that it's a problem with a specific
>> platform.. Since we're in the merge window I asked David Wei to try to
>> experiment with disabling page fragmentation on the ARM64 platforms we
>> have at Meta. If it repros we should use the generic rx-buf-len
>> ringparam because more NICs may want to implement this strategy.
> 
> Hi Jakub,
> 
> Thanks. I think I was not precise enough in my previous reply.
> 
> What I meant is that the atomic refcount cost itself does not appear to
> be unique to the affected platform. I see a similar ~5% overhead on
> another ARM64 platformi (different vendor) as well. However, on that platform
> there is no throughput delta between fragment mode and full-page mode; both reach
> line rate.
> 
> On the affected platform, fragment mode shows an additional ~15%
> throughput drop versus full-page mode. So the current data suggests that
> the atomic overhead is common, but the throughput regression is not
> explained by that overhead alone and likely depends on an additional
> platform-specific factor.
> 
> Separately, the hardware team collected PCIe traces on the affected
> platform and reported stalls in the fragment-mode case that are not seen
> in full-page mode. They are still investigating the root cause, but
> their current hypothesis is that this is related to that platform’s
> PCIe/root-port microarchitecture rather than to page_pool refcounting
> alone.
> 
> That said, I agree the right direction depends on whether this
> reproduces on other ARM64 platforms. If David is able to reproduce the
> same behavior, then using the generic rx-buf-len ringparam sounds like
> the better direction.
> 
> Please let me know what David finds, and I can rework the patch
> accordingly.

Hi Dipayaan. Can you please share more details on your testing setup?

* What are you using as the test client/server? iperf3 or something
   else?
* What do you mean specifically by "5% overhead from the atomic refcount
   operation"? Some specific function?
* What are you using to measure? perf?
* How many queues, what is the napi softirq affinity?
* How many NUMA nodes? Does the problem only appear when crossing?

Thanks,
David

> 
> 
> Regards
> Dipayaan Roy
