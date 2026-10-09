Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110A2749DC
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563944; cv=none; b=ALUS5WcKehNj3ggOMLRloDpBgKuTyRQNKGskZpllWW1HfRSx1go1JSWvkw5PlNGgFTcE4lxciRymPRGEkVCUGzKlEWPgQuVfmCVr//fOOlIG5ywvs71VTh7WU2+6pSNfxMv0Wz/P21gg/gElnG39aRTvepaELPNQfhaOVzB7ImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563944; c=relaxed/simple;
	bh=2kGLUYEClmKPKTPxWBwetLsiowXRUtWKT3Hr9vxYvAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ml9PBgjfz7TOQs+yxGpIEINWBDax60wkgmkEaR7yvPiO0VG+E7A+BtUhqfVh/M7eN4GHNvxvNMq5puWJdPjz+aY7lAVSO+8PnCwi76vR3qTs3ZvzOOv0uVs1bWk0nFrCCommWlTRoCS/Zi1APGjXzRwXN6KEyQ7oSF4lg2YPg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J+8gLjcW; arc=none smtp.client-ip=91.218.175.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J+8gLjcW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2kGLUYEClmKPKTPxWBwetLsiowXRUtWKT3Hr9vxYvAA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791563941; v=1; x=1792168741;
 b=J+8gLjcWIxCDxxC/2IfV/ZWtfXuEBkGDloxeJFkNV+EHvLOqM4Kyiuuu9Gyx9vyUY83MjdNs
 YlWEIasWZzKsygr/mIeLxT2DY48TDLKpEzGmDSBbxEcmqp/2akMECj4E5igb2PfFTzAztJD7PMi
 v68/J1/7HCam6KlQhVx3AwoU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8714190fded7bacd;
	Fri, 09 Oct 2026 16:39:00 +0000
X-Mizu-Trace-ID: 8714190fded7bacd
X-Migadu-Flow: FLOW_OUT
Message-ID: <271f7ba8-df38-4c8f-b59d-68b52ee998e9@linux.dev>
Date: Fri, 9 Oct 2026 09:38:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vma: keep the unlinked VMA off the file across
 unmap on mmap hook failure
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
References: <20261007101800.58d50b1b20a10738e630bfd5@linux-foundation.org>
 <20261007194708.2009-1-okerixx@gmail.com>
 <e139339c-1e55-438b-86bf-0960ad4029f1@linux.dev> <asjQQF_Ok1TZPm1M@gremlin>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <asjQQF_Ok1TZPm1M@gremlin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-09 4:31 a.m., Lorenzo Stoakes (ARM) wrote:
> -cc slopper
> 
> On Thu, Oct 08, 2026 at 02:48:07PM -0700, Ihor Solodrai wrote:
>> BPF CI caught this bug on linux-next as well:
>> https://github.com/kernel-patches/bpf/actions/runs/37736351874
> 
> Nice that it caught it!
> 
> Is there a way to automatically notify patch author that when it happens? Does
> it bisect, etc. or just green/red?

For linux-next it's just green/red now.

We've added it to have an "upstream merge will break bpf" signal,
because it happened regularly.

For bpf list we run on every incoming patch, so regressions are detected
quickly. Not feasible to do that for *every* upstream patch, we'd need
much more compute.

An auto-bisection is something I thought about, but never got to it.
These days with LLMs this may be easier to set up though.

> 
> --
> Cheers, Lorenzo

