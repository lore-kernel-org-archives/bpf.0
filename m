Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888813C5522
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373430; cv=none; b=j+j8SRrbfs3GpHxXK0ebZMifeivwBYXhczhaTYPPDEXSYWowIgjM+/LLngOny8kFqCZMB7ma9VtC5fh7IKqg+vHb3N0xut/UOJv/RwKARxKhc6vSKWurSetgqwufWIyGN5aEDFY3m7ZOF1UY521nOpuc6Rfi1UtB42G1Wc5Kjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373430; c=relaxed/simple;
	bh=XZZtuD3AiMHbsfDSoEgx48YdqoFNpCKxKghr+xutvqw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=HbRUCr4DoHVwyWb+64Xkcz/ZxNDaKB8Zc18ZRHGi8dWUpcLAv/K3B/SH0ukIC5YpLNLSaT4ONn/wWRahMq3x6tID6IuC+7LI9xQlIIvilal7vc2sJ/U5YUU9OrLGvw94legrXWNgnk2TQESScvx9Ee+cAW19t6fmb95I8vQ+JEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZEdXa0z0; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ZEdXa0z0"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so844054a91.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790373426; x=1790978226; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0GMtx0b07qOSOknabE/8SRczIKyF/geWunUef3Vm4k8=;
        b=ZEdXa0z06LyklGQKgg/miw9iueja6lxEq5ZbDLIJUWfsvOKsatM18ygacHMRT62uCH
         EpS3ttWz9vQ41afSczdDgqhKF31bU92TxfkiL7aB2kmjcdQh5zr8+0V7S5P4XG3VzEk1
         gDpMna6F0p74x39pYsQ65FOb3QY3xWxhWTn8woP/lNzkEL2HoJAzgjbAkDfjZRF7CpzP
         4dkBFz8Jr4oC4OeclckEjOUgDV2UQcxbmpVFs8lr9OPSQh+Lic2OuuRQxortIFPfRAqd
         wg58i8whu3ogIGfCRQaFDL4ufoTzdwWRomkKfFBH/C7GfVfbLoR3W3uxt5QHrqdPZJ5i
         81kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790373426; x=1790978226;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GMtx0b07qOSOknabE/8SRczIKyF/geWunUef3Vm4k8=;
        b=LzOCblUWjLknAYQ3bP6C1lNzV7T6fxHs5rXuF+IL1z31l0dHr8qOMKtz2ZxToF93Kz
         yiS1xTZ+UXQR2UN9gWYBn4pIDXzzbOrIbxa3yI4RqYOaN3FloyhrKfwGsDmz7w8/FF0K
         Hnp8lue8NAVyBI1QY/IzGBy10Sr109gPzwQbZL9Ho+Avpgy3RqtsZerBHk748TA6cDtO
         ZH25l1//VARg+/d9t465ifLV20btq+Ocadq2jrWjGxCVEEHiYROMmY6IREeQfloozahc
         WR6xuMkhwemYJ1f7k3/dVwxXJsKj3460trLCznPyguIkoWO9hboK/Jx2Hw2O8atn2FXP
         HS4g==
X-Forwarded-Encrypted: i=1; AKwUvByzxxqrkZ+7FOj2YDXmyDrQiJvsk4xniRDYuRqfRbRYJrEh/UfRLaetv84O96+uzCHWHrs=@vger.kernel.org
X-Gm-Message-State: AFuF++kGzZczujZeeySGhjn8Idl1CMdJCCyJSCOmP798BV3jluozQMA0
	GDVmIw8cI9GggExYQAGK86R6us4twkkqsjFMcnb+WGDP6Mv96XRHZoScQK8I75+iitw=
X-Gm-Gg: AYBFou2Ku6DZwJlTOQVySHbXYQ8n9ZNwGVPaUy0cHHbna4bDB7Od8ydZfAFzGUU5TnA
	6H41DVfU2FYscp57rx5196IPxZz8V8MFtDW0gGmwXy0KEmDpvz/cLJu6dpimst+6txe2Slly7Ld
	aYOf2ZeJo0SdOZwbKUTyifQLh+aUThUKYxiaL7lDip8X4Lls4OSCyUdtKv8LzXLR1wbfgSpR5dH
	bXbAZHB69AYsKweuc/3Oz+x06xXzbnWJxyblTrxsdPig8FDGdRqe7jYH3uVk9LR7Uh7ZMWTFU7M
	vmJgA6VmQNc7hkuxMoN0bVvY+n+6Orte3lFTCoDN6epB2nmZNSwwnXPf5ncDNXLCkU2nNm095Qm
	G/xZAT6Pq4FD+zouP/rZtCt9dRrM0Moaivl3KcxOVCgRS8s+d+vx8f3uR+TBi/WSN1ZHxstdWNT
	7erhDuyqFixfbvqSPq8ZP/IalIy1Vb+IR9P6qyoWvT/qlslwtFk3AcoTjo6AwDhWl49UJ9xE5nT
	YQOSSh72ooenMIoDBzHRnPsR9vimATt3sCyT/E6PQE=
X-Received: by 2002:a17:90b:52c4:b0:3a0:bdd7:f1f5 with SMTP id 98e67ed59e1d1-3a0bdd7ff10mr2524455a91.13.1790373425534;
        Fri, 25 Sep 2026 14:57:05 -0700 (PDT)
Received: from localhost (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm12967238a91.14.2026.09.25.14.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 14:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 21:57:04 +0000
Message-Id: <DLOQESM8SNGA.2ASMGV6KHJ4WB@etsalapatis.com>
Subject: Re: [PATCH bpf v3 3/7] bpf: Add sleepable arena page allocation
 path
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
X-Mailer: aerc 0.21.0
References: <20260925203939.4105-1-emil@etsalapatis.com>
 <20260925203939.4105-4-emil@etsalapatis.com>
 <DLOPQUOW1A97.1KXFXSEUUNSFT@gmail.com>
In-Reply-To: <DLOPQUOW1A97.1KXFXSEUUNSFT@gmail.com>

On Fri Sep 25, 2026 at 9:25 PM UTC, Alexei Starovoitov wrote:
> On Fri, Sep 25, 2026 at 08:39 PM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> Since allocation now happens before range-tree arbitration, concurrent
>> callers can allocate pages for competing requests. Bound the aggregate
>> number of pages in this pre-arbitration window to the configured maximum
>> size of the arena.
>
> The pages are allocated with __GFP_ACCOUNT. memcg bounds them already.
> Let's drop nr_pages_inflight. Seems like unnecessary complication.
>

The nr_pages_in_flight is there for the edge case where multiple concurrent
allocations in the arena inflate memcg usage close to the limit, then a non=
-arena
related allocation fails/triggers OOM. If we're fine with that happy to rem=
ove
it since it's a bit of a tacked-on hack.

I'll replace it with __GFP_RETRY_MAYFAIL on alloc_pages() so that the alloc=
ation
doesn't accidentally trigger the OOM killer. AFAICT it can do so otherwise.

>> +out_unmap:
>> +	if (sleepable)
>> +		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>>  	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
>>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> -	if (mapped) {
>> -		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>> +	if (mapped || sleepable) {
>> +		if (!sleepable)
>> +			flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>>  		arena_free_pages(arena, uaddr32, mapped, sleepable);
>>  	}
>
> v2 leftovers? It doesn't depend on sleepable ?

Yes, I will remove that part.

>
> pw-bot: cr

