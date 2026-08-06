Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F30442368
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049357; cv=none; b=NjSwRGFe37Wg0r593l5acn9URdXxh1wyy9SonuXKMgsl8B+2Js16mSv0esILs1L5gvsmbWyoCSGKjWRJutlE6cBu0B3Ii6hoG7+vZ5JaxnFvCWspCfq8xv5MCJm4lsLnWkuMjWDAfwkeC0hz+oMECvx1nfOklXocl+leAcrbxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049357; c=relaxed/simple;
	bh=rxpftPomi862vIzKJh6g47R+KnlgGWK1eCGvOxzV5tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5RgAMbi8YnZ+Joou9EHHs7OVe7gRX7t4teGWEx7sxZph268xScdEXOxnCf/i8rZV3/LA/i8BYBLr8LyOgXMaBOUdWlM0R3/39tExUcqEWlwvg6D+6YA71PE87rp5cIisHMEWCEzo6g1I5K3WmE/ev7JVxIoZ18elClWigTIyzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hxF4cmI5; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hxF4cmI5"
Message-ID: <986e6f4e-4b51-4440-a37c-9624906d7370@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786049350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wAaFw1mXFIl9L2E5NEpAHbpxu9pur1S/NqkSEZ+weP0=;
	b=hxF4cmI5Gzrhv0swUigw5HxtGbtduIrlBwKOpcnpY30TDjJDjjqGRix/uIHwa7oPiLScpY
	ts04Bx6SjtL+icVqAvDTQgFC7C0uHo1CKQmo0XoKKu0gEhboHo3b/bhxKCL28B+UqqipkO
	F5oJEm709V1yGDFCNjrBDXv9gbsLH2g=
Date: Thu, 6 Aug 2026 13:48:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/6] resolve_btfids: Deduplicate BTF after
 btf2btf transformations
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
 <20260805230648.2354989-2-ihor.solodrai@linux.dev>
 <8225c3b4b2077c0fc5a86678d410e68ac6939017.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <8225c3b4b2077c0fc5a86678d410e68ac6939017.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 12:05 PM, Eduard Zingerman wrote:
> On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:
>> btf2btf() adds new types to the BTF: the KF_IMPLICIT_ARGS transform
>> synthesizes an _impl FUNC together with its FUNC_PROTO and copies of the
>> kfunc's decl tags. Nothing deduplicates them afterwards. pahole runs
>> btf__dedup() on its own output, but that happens before resolve_btfids
>> sees the BTF, so any type the tool itself creates is emitted as-is, even
>> when a structurally identical type is already present.
>>
>> Call btf__dedup() at the start of finalize_btf(), so that base
>> distillation and the by-name sort both operate on the canonical set of
>> types.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
> 
> Hi Ihor,
> 
> I'm curious if you had a chance to measure how this affects the
> resolve_btfids running time?

Yes I did. tl;dr is +30-40% runtime for resolve_btfids:

  0.18424  +- 0.00174  seconds time elapsed  ( +-  0.94% )   without dedup
  0.257003 +- 0.000473 seconds time elapsed  ( +-  0.18% )   with dedup

So that's the bad news.

The good news is that it shouldn't grow, because most of the dedup
time is just walking BTF. We emit very few types.

I think it's worth taking a hit, because a non-normalized kernel BTF
is a petri dish for bugs.
