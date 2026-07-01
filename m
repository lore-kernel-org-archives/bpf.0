Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049628DB54
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889041; cv=none; b=VO6QRWRhluE5g1bHI3xkInBPgrDGRNj1AyN/UXTgOrNlSVJWbNIJ1YN1vSiMwLqb8V/slS0pqLKPzMVhKUnJxkehVpTXPZY4TvO6uZ8p1TZE+ejyFdBwz8n1Mo7RkpGOQQHKtqsvLOySyJRtaS51KHjIct2MUb+T6NgBt0ASEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889041; c=relaxed/simple;
	bh=v5hqlUAqqqIWuqB8AKVxFDVbPWO9Yr1oiUSORsVrU8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMlSHWAosEboQ6Oi75jX/4UzDVlIdZqAbX99Nj1RE+uFAlLl/v8hDkzR6WzzRp7eu7FI5mMXMzcXc/O3ko4Ivz83/haUk0/p0hgwINSQQ2MTHoJwjxmQ4wJeOoJfAdQIrwnxRGTUIPsioZi9z/rsOB2Nr4qhKIMKWt/w1TItH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5ZSs0Wc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv20BlP2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5ZSs0Wc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv20BlP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782889038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsPLZhthgeNTmosmvhtfLrcyUwQKZWXNpePOYSm6rBc=;
	b=M5ZSs0WcSfRjFKjJHX4QdmAOLMBjz94XtSV+Tet+hoenuWC5VDl29O/OuGpn+gphcGPGna
	YhcXX7gxjgU0wibSROr6HYTRPUrEqG3Dpv5S/zV441djXMeKfdwMLx5jMavTErttFvJ0ZM
	ZIG8dnFrC0aVgVJ6BZF7P88KelBoboA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-LpXqJLdoPS23CNriZYJ3YA-1; Wed, 01 Jul 2026 02:57:17 -0400
X-MC-Unique: LpXqJLdoPS23CNriZYJ3YA-1
X-Mimecast-MFC-AGG-ID: LpXqJLdoPS23CNriZYJ3YA_1782889036
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4926d371224so2678255e9.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782889036; x=1783493836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsPLZhthgeNTmosmvhtfLrcyUwQKZWXNpePOYSm6rBc=;
        b=bv20BlP27tI4T2IA+W8Aecn6i69YCpcuFBwqxWx06D8APxDhuN5mSIuKmfWwigLxuM
         dJEGj2wqrP8x/GIHzCBYMud+oPapYS3GJZeymKt9E0EtnZdvW21G83j+Rek0BxnEEWWP
         Gnr/iLcC87fICXqUC1jZlwZoEulH5i1NhpdAnA0XBkT1b8RDkrqbixz3FSzYkjCxi49p
         8zDTycOcK4U3wl/M0i+nfOGaoMe7uAuAvutepfEhb6Kra7VIFwjFGrjJJ8XuUXXC+oF/
         65VNLCLg/r6m+pFrYZjzSJ8Ro99vA83nT80kcLBg1DwwTp7rz3YueHoFptV/MXQlLfuc
         d8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889036; x=1783493836;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsPLZhthgeNTmosmvhtfLrcyUwQKZWXNpePOYSm6rBc=;
        b=LymqflmqFD0XSLEJRs9yAzTVQdvoheMczlAuL635Sw8KPgQ51U8PpyI9byeiHZk1Aq
         MEk27vj6e+s6E1kKW9EymCl1EgNndW+l1w84tO80VYKTG11BykoufFQiV9/tsvw55SQo
         GfkragAz545ggbeDNEOqcohO9Moc/BxbVbP3ejfESUNUduRNUys1JxQIr5Brvv+1gmx9
         ruX9gZRBsWhXfD/sqbil/cCAhIoELkJjdll1ry8uf3DekK4AEf6sEg6cXes+TB0dgUUl
         vDnvMtgkdtqQVe7cv6gMr3OMpJGyzApthGbr08vFQ+3h3MuwkEs7Kz8V1bq4rajfYyYt
         grPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9B2I4v1XQfr9ItVCgU6S8FUZz1+BuJDZnep1q8HKMDxuWHmaB2vwVhhhvwtQxTQnBssRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwxxZ2esR5YTo9lE6Brzi23HdGPKSrlbMV3XFB41+2RJUTDon
	TQnkl0b/zlVh5B4KSi1Yi7FsujMyWFKQX+87/UNmV1k9QAun1lmmvS6FeA2SgdeD67AxXdFkcIl
	VJZWV2sR0ZPQE3xHRnBAHh3mvalCkXd3bVav6HtHmImNXIyVd3zOp
X-Gm-Gg: AfdE7cmxiv0Yl4IOpZDYqjLYGEpQHWMbzpWHsH/ZJlLbWNsevXwHqfLnVTFePiDS+PV
	Btwiqr24QeljPr6dkYqLpuJz12z0Y+CkKQE/883QOhWnemLID+mThoA2rW8tF5fRm9HFwWeif3i
	5SiocGd/fb7ik6y7gM5Gth4flxI/twEbsKYpy8FZyHGdbJyMH68VVFXrY9cLHn0nsclxxNaU6Xg
	mqSEQ+DCopSvM5M1MiUjI3MXFmuNa4YS8ZzUrZn5eHXyfMNpvG8i/RFxDHArElFg1ncnn3rGbOR
	fzEquYkm1RbX2mlA2SCpt9mJB3p2klOaDMv2GQRxVeA8L5htzs7quzwwSRsqYyXVCp17sDLL4Q=
	=
X-Received: by 2002:a05:600c:5749:b0:493:bc4b:b8d with SMTP id 5b1f17b1804b1-493c2bb968dmr2658775e9.39.1782889035983;
        Tue, 30 Jun 2026 23:57:15 -0700 (PDT)
X-Received: by 2002:a05:600c:5749:b0:493:bc4b:b8d with SMTP id 5b1f17b1804b1-493c2bb968dmr2658495e9.39.1782889035417;
        Tue, 30 Jun 2026 23:57:15 -0700 (PDT)
Received: from [10.43.17.14] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef1807asm32048695e9.1.2026.06.30.23.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 23:57:14 -0700 (PDT)
Message-ID: <45022e92-7840-45c5-ba30-a276d736505f@redhat.com>
Date: Wed, 1 Jul 2026 08:57:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Introduce an instrumented profiler using BpfTrace
To: Aaron Lewis <aaronlewis@google.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 seanjc@google.com, dmatlack@google.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org
References: <20260630141152.3757722-1-aaronlewis@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630141152.3757722-1-aaronlewis@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 16:11, Aaron Lewis wrote:
> I am proposing this patch as a simple way of turning BpfTrace into an
> instrumented profiler. This approach has come in handy for me more than
> once, so I felt like it could be useful for others as well.
> 
> I am not entirely sure where something like this should live in the
> kernel tree, so I took a chance and put it in
> "tools/bpftrace/instrumented_profiler". I am not attached to this
> location, so please feel free to recommend a better place for it to live
> if this doesn't seem appropriate.
> 
> I have included two samples as examples of how a trace can be set up
> (`kvm_trace.bt` and `vfio_trace.bt`). The included Python script then
> runs over the output of these traces to generate the final profiler
> results.  Example output can be seen in the patch itself.
> 
> Aaron Lewis (1):
>   tools/bpftrace: Add a simple instrumented kernel profiler
> 
>  .../aggregate_bpf_results.py                  | 318 ++++++++++++++++++
>  .../samples/kvm_trace.bt                      | 197 +++++++++++
>  .../samples/vfio_trace.bt                     | 315 +++++++++++++++++
>  3 files changed, 830 insertions(+)
>  create mode 100644 tools/bpftrace/instrumented_profiler/aggregate_bpf_results.py
>  create mode 100644 tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt
>  create mode 100644 tools/bpftrace/instrumented_profiler/samples/vfio_trace.bt
> 

Agreed with Alexei, this doesn't belong to the kernel tree. For the very
least, the provided bpftrace scripts depend on a specific version of
bpftrace (e.g. they use macros, which are only available from 0.24). But
we could certainly consider it for the bpftrace main repo [1] or the
user-tools repo [2].

Looking at the code, I'm just wondering what value does the Python
script provide. Wouldn't it be possible to do the same in bpftrace
directly? If so, then including such a tool into bpftrace could be
relatively simple.

Thanks!
Viktor

[1] https://github.com/bpftrace/bpftrace
[2] https://github.com/bpftrace/user-tools

