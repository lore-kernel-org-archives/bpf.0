Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0DD72623
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979290; cv=none; b=LTJ8FKam7+gkjHsLrQVx98vv67+RGQ/fduMQ2HpOrl9413/ywcShAvG2rxbR6M9qQjqwkihM1qYmZAZbIgCN0oDeNa+8TBhs3K3oB9dkTAx6KZOoLi1eJR+5d6iwCiE6h0rFrrH1/Twa9IHd/hXQM2rv18psWTyblbl7ni9aXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979290; c=relaxed/simple;
	bh=QRWgqb5CPGqs2lK5Sv2X50m+bsb704XV1bO3mczxvds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6GzTh536Ygd4RISzbS1+yuz4dEfjYi7/vQ3Fyev2jmUtHB55uiyeqYMnia1P6uUhQWjPXOT5Bz1JutX91S+RPvwXpSS3yfg39sYCg9p23OscnIrIsQveVgMG9i+Jg6SbUntiUz3dfNhQI67un7ichY721d80mFyAQv0UIULX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k1LdvAEH; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k1LdvAEH"
Message-ID: <492d8f08-3a63-48cc-8a45-d8ce9d41b896@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778979285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRWgqb5CPGqs2lK5Sv2X50m+bsb704XV1bO3mczxvds=;
	b=k1LdvAEHJm2U2Xm0OoMOCNYDUmsoDnoE6AU6Tbc9GFzmwv8h/QfTJE/5GHkV43geHZ0H+d
	cXx9YPCAoKGXBKBE/eRBvM+y64QGOZNAbaUSCOpl/QmKUpEBq27Td76fWpk11HhfiW6EUh
	LNCXGGTTXa0rXdqrbCFFQ32r91OkdLQ=
Date: Sat, 16 May 2026 17:54:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 6/7] bpf,x86: Fix exception unwinding with
 outgoing stack arguments
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260515225035.821178-1-yonghong.song@linux.dev>
 <20260515225106.824804-1-yonghong.song@linux.dev>
 <DIJSNXM0DL9L.1VDFFWJXB84PU@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIJSNXM0DL9L.1VDFFWJXB84PU@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 8:51 PM, Kumar Kartikeya Dwivedi wrote:
> On Sat May 16, 2026 at 12:51 AM CEST, Yonghong Song wrote:
>> When a main program with exception_boundary has outgoing stack
>> arguments (e.g. from calling subprogs with >5 args), bpf_throw() fails
>> to correctly restore callee-saved registers, causing a kernel crash.
>>
>> The x86 JIT allocates the outgoing stack arg area below the
>> callee-saved registers via 'sub rsp, outgoing_rsp' in the prologue.
>> When bpf_throw() unwinds, it captures the main program's sp (which
>> includes this outgoing area) and passes it to the exception callback.
>> The callback gets rsp and rbp, followed by pop_callee_regs, but rsp
>> points into the outgoing arg area rather than the callee-saved
>> registers, so the pops restore garbage values. Returning to the
>> kernel with corrupted callee-saved registers causes a crash.
>>
>> Fix this by passing the main program's outgoing_rsp as the 4th
>> argument to the exception callback. The callback adjusts rsp with
>> 'add rsp, rcx' before popping callee-saved registers, correctly
>> skipping the outgoing arg area. When outgoing_rsp is 0 (the common
>> case), this is a no-op.
>>
>> Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack arguments")
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Do we need any adjustment for arm64?

Yes, after this patch lands, Puranjay can help with arm64 side.

>
> For this patch:
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
>> [...]

