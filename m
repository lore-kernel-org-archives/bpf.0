Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C783BF679
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395795; cv=none; b=Imz+kRQCl05ATV8SxIHx1oaJEzDH76c2sYL7clsz6OzachjQvyFXirkSBeSDCZLjMRj6scnJaRg1fpknisEDx0RXRR/GznVEXvcLRQlYIL1GqL+mn6ebT82s4l5aQhJfb/YaYtLMVRIY46FaR9lAU78KjAWVOI0PzAHNto9XtG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395795; c=relaxed/simple;
	bh=jFG4zz0KgiTuigSww1//MB2R13B1rOXkJi0bLTGjegg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BW+fiVHE+80YduoTArkR42zBuDWju8kufa7f70W61CdyRjHQTZPFpattZApj6PxrUwRpx9308r1u7j31S56vcG7BcDIjVVTBin5yrmiB4euF8bYucwgAgmX/xZ/q0JqQ1v3TM8PPRVxtG8mms/+Y0RjQXUeF6siPmHYWEo/Hby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Az9psUOP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Az9psUOP"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C758C80B57;
	Wed, 07 Oct 2026 19:56:24 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UO8D3__RQkSN; Wed,  7 Oct 2026 19:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791395784; bh=jFG4zz0KgiTuigSww1//MB2R13B1rOXkJi0bLTGjegg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Az9psUOPZAKPpcIyxg3rn67VfCfh6BM/XF1XbO/IzXjIKoq10qcUKezvhvgyN93X/
	 FjR8MU4Ha2loPtNvhGBvLsqWJ57FnreTJfcC1VcbMqd0qKfh/VX1oVGEIPooe538O+
	 rq7UTAY5Yim1EJ5l1DE3MsWfm+8qE+c3phUHe5dj+IwdimKqTj8PjSKGo1SocEW3d3
	 Aqlsm1o6ziNMETumqB0SCC+hvYAQ8gMVGDpIKIa0FnDLtQgQTAsQgrhnMUC08oRxS/
	 BINNELRPljFxddaAY3PPVVDcNp/CzTnM6hWAIYijA4ep2nSR78zUxtVjCwgGZNmNuq
	 dfmw6OlofvQVA==
Message-ID: <b83784bf-7755-4299-aca8-30f76615a8fa@disroot.org>
Date: Wed, 7 Oct 2026 18:56:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 3/3] selftests/bpf: add tests for percpu map flags
 combination
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20261006084604.780456-1-maghasi@disroot.org>
 <20261006084604.780456-4-maghasi@disroot.org>
 <5eb6e22c-7466-438a-a827-d62aa4f46cc2@linux.dev>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <5eb6e22c-7466-438a-a827-d62aa4f46cc2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/10/2026 03:44, Leon Hwang wrote:
> 
> NIT: 'u32' seems unnecessary in the function name.

[...]

> 
> 'i * 2' looks hard to understand.
> 
> Should pass 'void *values, size_t elem_sz', then get value by '*(u32
> *)(value + elem_sz * i)'
> 

[...]

> 
> Can ASSERT_EQ() the first slot here instead of the last? Just for
> readability.
> 

[...]

> 
> NIT: unnecessary_deletion  ->  lru_percpu_hash all_cpus|noexist
> 

[...]

> 
> NIT: unnecessary_deletion  ->  lru_percpu_hash all_cpus|exist
> 
[...]


Thanks, will include them in v6.
