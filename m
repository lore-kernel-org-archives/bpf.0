Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0C14A60F
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785475149; cv=none; b=Ekz4IbHmsSURZfOWXasdTQ9xtyAYqTWn9RXi9BzzRdcIu3zcvh53xrGWiEZLlsJwQGH07HJqGIawXV+B6rDbM1IHDk+dNUf0RkPp+9YXQGi0Dwbe/L2cq0tzYLM7ZUWcYbrSfyxY8YHTtWDCCD4ErC5ObH6QUB8mIxYIodpnrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785475149; c=relaxed/simple;
	bh=Xl40XVAbl5/NEfxk8jBsC+ldmXn8QF0CTbVLOG5vVak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpKMlcE5U9FQyOwA/v2OrYz9qrlplijy+Tq2utUg/rf0eIvFC3Q2I4b5Pbi68VuakWH/3J4HZZhgtlphdHO0H/BGOVPKkKsKcdRm31C/LhsfPxL62Mt0bCeIf6VyL3sp4GQvawEUbJ0ZvYkr7+LTMul3EkQzFWfwuotc5V1x/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hk8TxX8i; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hk8TxX8i"
Message-ID: <6ccbcd6b-ef0e-41d8-a5a4-80b7e94c7fd6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785475143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9w+5s7rfo24271BZftg+qqsMB69AhQoZJfr2nqQsJY4=;
	b=hk8TxX8izVpu5swD9haQQPntp1QZZfKasPOxoobkBvtgc2AiqrKhl4/xBr+Bh42EwAqOxA
	qk0BQldKNcFoTnrPh89FrLaOOGMEyrJWK2Ngm3J+RE3/QGNDtTPlWg9HiNr0/uEjREoO1B
	Rp2CBsnl5rTWQeOxUbapFfEJ7Fca39A=
Date: Fri, 31 Jul 2026 13:18:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/6] bpf: Optimize string scan kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Rong Tao <rongtao@cestc.cn>, Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
 Viktor Malik <vmalik@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260728145727.45153-1-leon.hwang@linux.dev>
 <20260728145727.45153-2-leon.hwang@linux.dev>
 <CAEf4BzaDhyPm4ERJi_0BTW3jLaqVfYybLKDWg6Pub2=8Ca7P3A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaDhyPm4ERJi_0BTW3jLaqVfYybLKDWg6Pub2=8Ca7P3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 31/7/26 07:17, Andrii Nakryiko wrote:
> On Tue, Jul 28, 2026 at 7:58 AM Leon Hwang <leon.hwang@linux.dev> wrote:

[...]

>> +
>> +               if (char_at <= zero_at)
>> +                       return pos + char_at;
>> +               return nul_is_match ? pos + zero_at : -ENOENT;
>> +       }), err_out);
> 
> looking at the above code, I'd say it's just not worth it. Too much
> code and complexity, IMO. For the absolute majority of BPF programs
> this small speed up won't matter, while for those BPF programs where
> doing tons of bpf_strstr-like operations is the essence of those
> programs and has a huge impact on the performance, they can basically
> implement and maintain this complexity in their own code base.
> 


Agreed on the complexity concern.

Let's leave the str kfuncs as-is.

Thanks,
Leon

>> +
>> +       return pos == XATTR_SIZE_MAX ? -E2BIG : -ENOENT;
>> +
>> +err_out:
>> +       return -EFAULT;
>> +}
>> +
> 
> [...]

