Received: from mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176174AEBD2
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056458; cv=none; b=FpXhXdUQu7iemW1V414y/GzDGMBD5S0DvDNGSOoq/Whiv0F6nejIZ5I/HyNBJtUTLSiy4P3f2nVYDU/lXBMl8HtGKPXbU4GDVtxDCwnov7bHiV+bHS9KrG3V812NAkS1q/m7H0xuqvz7cPEYB/jVVbphiE9ajctGB4JDzzeO3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056458; c=relaxed/simple;
	bh=FlUexysxkL7gwjGtQ4Idy2NPe5vB/TmsTSE1bl5Mhbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9vipah85pMJ6N5GVXqaKtw/9JUuxxEQmdUbBjUZI279+LWol0aDPZRKbocU0owklGt3RaNgNhA+yy21oSNrHbAWVvpD1hojlVwTycmSqvFqMG+sZGU4iUDDNZ/a25pTxTxl0HLD4uhW+uG2I24frJHWWsy+4PB2qWOPAW42Ino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=esILz0XH; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="esILz0XH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FlUexysxkL7gwjGtQ4Idy2NPe5vB/TmsTSE1bl5Mhbo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789056450; v=1; x=1789661250;
 b=esILz0XHezEEijk/7Fh5AfasEDbLpRlvKPTbIQVnw7J7mV/pdqloJdAhU7CPUK4WxpGt7CGM
 Y4iD8d/SkzVjalOcUiBEUG5pjCn0B1EKjPsfLPk91zdUPgzkSTDqFTVR0CD4+dDDjyy9BNesHFm
 OTX8ThTUkYYHwbVTrlIoLzBA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8c94fbf9c7845803;
	Thu, 10 Sep 2026 16:07:30 +0000
X-Mizu-Trace-ID: 8c94fbf9c7845803
X-Migadu-Flow: FLOW_OUT
Message-ID: <5294a257-3b02-4452-b3e7-ad36769c16a4@linux.dev>
Date: Thu, 10 Sep 2026 09:07:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] libbpf: Add bpf_program__add_flags() and
 bpf_program__clear_flags()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
References: <20260903092416.223294-1-toke@redhat.com>
 <261c5e00-31d8-4090-aab4-a633924d336c@linux.dev> <87jyoteb0q.fsf@toke.dk>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <87jyoteb0q.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-10 2:00 a.m., Toke Høiland-Jørgensen wrote:
> Ihor Solodrai <ihor.solodrai@linux.dev> writes:
> 
>> On 9/3/26 2:24 AM, Toke Høiland-Jørgensen wrote:
>>> When changing BPF program flags, applications often need to just add or
>>> remove a single flag. The bpf_program__set_flags() function clobbers any
>>> existing flags value, making this awkward to do non-destructively.
>>
>> I think the whole "non-destructively" language in the series is misleading.
>>
>>      bpf_program__add_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
>>
>> does exactly the same thing as
>>
>>      bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);
>>
>> That is: overwriting the prog->prog_flags value. Where is the
>> non-destructiveness?
> 
> bpf_program__add_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY) doesn't overwrite
> any existing flag values, but bpf_program__set_flags(prog,
> BPF_F_XDP_DEV_BOUND_ONLY) does. In your example you handle this in the
> caller, but you have to take pains to do that (which, judging from the
> fixups I had to do earlier, was not something everyone did :)).

Ah, I see. Yeah, __set_flags() may be interpreted as "set *these* flags
that I'm passing in", which is not the way it works here.

Still, I don't like the "destructive" framing of the issue. More like an
API that may be used incorrectly by unfamiliar user.

> 
> However,
> 
>> Let's call this for what it is: a convenience API.
> 
> I don't mind changing the description - will respin with this change.
> Thanks for reviewing!

np, thanks for the patch

> 
> -Toke

