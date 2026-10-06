Received: from mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE650282F18
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791252738; cv=none; b=Kxyt9iio0O74EFkyaNNvvvTWW4N44akygdrdzvAGeZlLwdLTEtf97znitdssjY0luVN8lVpPih8uSWFEybCOjEBk+gF9gelRxnG99qM+GZPdGnqdw5TWlG4/zGWgbuBMXBMNYMHQfIaz9NP72NO3L+QWvoI6PULWWHwu1KmsKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791252738; c=relaxed/simple;
	bh=DhAv/YdfKlh+t4wcmYH+cLI+9CGs2VHTk0Pq0K8bdfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I09ejFDloI1bgm67hWGLbRRAueTgZgJ9w1Lnx522EERpLkwoBbSRN6kuQ46D3LN/3OhF0MxWspT9VU87wMjwLwyYwHtDujPPNsxub41gXZRp60UysWZzw3p4UN/Mr3q18f1h23oOWBeg/I1dakoXLPrKlJBYZVTJ5IOZ7ZIbKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aAtfRRAZ; arc=none smtp.client-ip=91.218.175.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aAtfRRAZ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DhAv/YdfKlh+t4wcmYH+cLI+9CGs2VHTk0Pq0K8bdfc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791252732; v=1; x=1791857532;
 b=aAtfRRAZNCGNxKORyE1rL5DkTdNlHfPWpUWD/Vu4MkhreXXOFS8Ze9z5dJP7FrvX6dXPUTDK
 6q85zhjZDUn/WsDPhSv5jBR6XLayIBzTqlq2mELV1n2VATctxntOzf8LSXPF0ecr6Qj8Cj0jGCh
 N4DdtQFZNggIfB8E57Qxnm60=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7a34e0de51f20aff;
	Tue, 06 Oct 2026 02:12:11 +0000
X-Mizu-Trace-ID: 7a34e0de51f20aff
X-Migadu-Flow: FLOW_OUT
Message-ID: <29ad3e60-1404-4240-8167-222cc0c684f2@linux.dev>
Date: Tue, 6 Oct 2026 10:12:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 3/3] selftests/bpf: add tests for percpu map flags
 combination
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20261004111007.3216186-1-maghasi@disroot.org>
 <20261004111007.3216186-4-maghasi@disroot.org>
 <935fb19c-e8e2-46a3-b933-9d8e9d1cf746@linux.dev>
 <2c50da80-5c48-4bcc-a497-64d6a1a80b1c@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <2c50da80-5c48-4bcc-a497-64d6a1a80b1c@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/26 23:19, Masoud Aghasi wrote:
> On 05/10/2026 04:12, Leon Hwang wrote:
>> On 4/10/26 19:10, Masoud Aghasi wrote:

[...]

>>
>> After reading test_percpu_map_flags_combination(), two helpers are
>> needed to verify the updated values. One for updating with BPF_F_CPU,
>> another one for updating with BPF_F_ALL_CPUS.
>>
>> Thanks,
>> Leon
> 
> Thanks, I will apply your comments to the v5.
> just regarding the is_hash_map, isn't it better to keep it as an
> implementation detail inside the function and avoid introducing an
> unnecessary invariant for callers to maintain?

I think either way is fine in this selftest.

Thanks,
Leon

