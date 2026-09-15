Received: from mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DEE42AF86
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490093; cv=none; b=NLTN/eVZv5UKmbpYV8jAWcCdBkoyxQiBk8XnC+f1nxwI9JIDirEJTzOGKBFhjBHyeOE5EfQtIyNyFI+IAqQ9ehN9KJYP9xOz5kagJr6GvnHLpkqH5bGPLa0bifPxSR9Puv10L0Winkr8G9m8xZS9+BKu4Uqe+eYsLAr6bI16j6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490093; c=relaxed/simple;
	bh=B0tzIgaG6JGKZCjr1ffoCRr52KAPNSy6oO2D1sP8PJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ0HA0uThPe1zBV8qo+Yjk2reAvm4j9cRp7jqZ8Z6k/Ye0M6bnglR55ZQGk1wywRLCcMjviG4MmLFJwsjlGJBZ6nZ31Wc81M9IZ0DNgBtgegZwDd8YgXsvN/6bkqRFYuoHyIoGkKeMQl2dlAyJYJ/1+Jj5nx3hCNN2//JcZM9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vmoHqFJ8; arc=none smtp.client-ip=91.218.175.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vmoHqFJ8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B0tzIgaG6JGKZCjr1ffoCRr52KAPNSy6oO2D1sP8PJ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789490089; v=1; x=1790094889;
 b=vmoHqFJ8p3xZuDW5RmkgyPLujGc8Ppw5O4CFq2EyiGgqNj9AjYpl7l1YBoZt5WYhxSKVZ8FT
 sTeSUP7jLzLni0+PjMsc6Jy0t1DXJgKxSWRGOsbBgxCerj2but0ZZ5V/TmoilC4xDffEjjT++dv
 R4F3dni6CeYMnuQLOMkcSt+8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 456883709b6d14ba;
	Tue, 15 Sep 2026 16:34:49 +0000
X-Mizu-Trace-ID: 456883709b6d14ba
X-Migadu-Flow: FLOW_OUT
Message-ID: <a6f41d17-62f0-4ba6-a8f0-bc18866d2784@linux.dev>
Date: Tue, 15 Sep 2026 09:34:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/cpu: Initialize boot CPU cpuinfo defaults
 early
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, "H . Peter Anvin"
 <hpa@zytor.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, kernel-team@meta.com
References: <20260814235134.3461435-1-ihor.solodrai@linux.dev>
 <20260814235134.3461435-3-ihor.solodrai@linux.dev>
 <20260915023115.GFaqit8zcWHGkAdHD5@fat_crate.local>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260915023115.GFaqit8zcWHGkAdHD5@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/26 7:31 PM, Borislav Petkov wrote:
> On Fri, Aug 14, 2026 at 04:51:31PM -0700, Ihor Solodrai wrote:
>> early_identify_cpu() clears the capability array, the CPUID table and
>> extended_cpuid_level, but the architectural defaults for the rest of
>> struct cpuinfo_x86 are set only later, in identify_cpu().
> 
> And I would've stopped here. I don't think we care too much about a CPU which
> doesn't enumerate CLFLUSH. Or is there an aspect I am missing.
> 
> I mean, you can say something along the lines that now things like
> ->x86_cache_alignment are more correct but I don't think you need to go that
> much into detail.

Ok. I don't think you're missing anything.

Should I respin with fixed up messages?


> 
>> [...]
> 

