Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508035AC2F
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334231; cv=none; b=n8xeLpPOnehoEgz6zUQ7VIlxVs/OlF+HxUdVyvY9TCqcT0hsdNgmWX8K6w0/9Jo0l4JvrMulH4Nz4zBma1PBii6Llp5YrLf9Lt8p44U4ZP1lpADZOPGguXaGun4l78actgXsi+z9zeAGS/odBfQaUCS5E1j9Vc7FFtMIJz0AKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334231; c=relaxed/simple;
	bh=+wo7NbGlwo9RnXOxjxEDelrCNb+djGtQfcu00JcNAx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMbrvL7xytKpj9lkRZx0cV7JeZlpppDe06xo73Arvd2sT2ZvBaaIIZvRqbexwM8glkqpkx+VxENY9cdzcYlVhW80VdlBieNk72IrRehq1nTFX2I5Pnu2UFPB9Ho27f7UYmSMERNbFLKP+fu9z7s4Y97M24rwq82th5EHiH3cg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVa/71ya; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVa/71ya"
Message-ID: <3e5ebcc4-4da6-4269-a5ff-4f2cb040e0e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778334225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tp/8kWFkcX0CcCb+oT2JyD5t0wxYrvUf09kWIHYlriA=;
	b=ZVa/71yaFoR1TymNFu1aECrtuhmlo7pCEJtR8ZaY8hv6QUTzMVOZMDTkJ/TEc2tCQFDfSn
	IIEO1GkMo4gpQytZ7Uq8H9K2QcVvKcDcPzodu2cW8eVqY2KjGu9YsBHxVmoFStnqdYEyY3
	cvoIOHm5l5sG0Vcjtzs9+Yna0aTyF/g=
Date: Sat, 9 May 2026 14:43:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 00/23] bpf: Support stack arguments for BPF
 functions and kfuncs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
 <DIDHTRIE6MGC.2SQ974UZ2EQG1@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIDHTRIE6MGC.2SQ974UZ2EQG1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/8/26 8:06 PM, Alexei Starovoitov wrote:
> On Thu May 7, 2026 at 2:29 PM PDT, Yonghong Song wrote:
>> This patch set lifts the 5-argument limit by introducing stack-based
>> argument passing for BPF functions and kfunc's, coordinated with
>> compiler support in LLVM [1]. The compiler emits loads/stores through
> ...
>>    [1] https://github.com/llvm/llvm-project/pull/189060
> Please land llvm bits.

Just merged.

