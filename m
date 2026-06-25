Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794627B340
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355689; cv=none; b=aKHM6n4C8C4SWh53toMV8BStl4yWfm+z++bvx+eI4yV3G23iYeaLa/JSQEDEMhvJSdjDbmGZ0vHYWovT+Qb4cLNL2ASqbXGFX2uQDCY1BAmK9l2xGEOzPHeF1YoWliJe43vDq9wHiTKbEgEG0HQ0RfCr6DFTUiow2jX2He6olrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355689; c=relaxed/simple;
	bh=z3RKVI7foAs42foz0//KHazdmWQJqkyQG//15zH72vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yf0LwTuhpJljVPdLfWSuLYPFo/sK+IwCdg85YSClblACCkyMBcPqY5YSTce1cVd4Unazoheu7kmCDuWU/l61LyafC8r+uyaC3X/fgnClArUKaCK8MNWjwO8CQURKDb/WrYgfZPij4H100POP2W2f3diQnrGENReUSM/rt7S8pQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QE0DFoFq; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QE0DFoFq"
Message-ID: <f3a0d1cc-9846-4ed4-a8ff-6bf697f28856@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782355686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3yrfODoKiFZcQEzcHoZrPyfA+GkW59uiSJRvLsM7dE=;
	b=QE0DFoFqgwG0WPyRo2vDPSu/Q5GX+WoGgVX7ItsTm2y9GC8+JA3Ai3tA/Qma9R2cgdjFHR
	uNOjkWeQTzf7sgDI8kRqQsSbjWN+syI+vjRJiZ3Tv2BfzaHiN7tozvAwJnXK7bU2cugaxF
	weHJfmHNti5WOGEISW66oTBN3iYZwSk=
Date: Thu, 25 Jun 2026 10:47:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 09/11] selftests/bpf: Add test to verify
 accessing rdonly percpu_array
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-10-leon.hwang@linux.dev>
 <CAEf4Bzbmj-ekwYQ6oGW-BRnzLBDvWgLyn_QsU5g1yNt_8A0H3g@mail.gmail.com>
 <d6bd1b3c-17eb-40bd-af02-e7135db07fd5@linux.dev>
 <CAEf4BzZHC3_oyWyA8zC-ogNFktsGFd35Stst5bswO05O=dL+Sg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZHC3_oyWyA8zC-ogNFktsGFd35Stst5bswO05O=dL+Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/6/26 00:48, Andrii Nakryiko wrote:
> On Tue, Jun 23, 2026 at 9:16 PM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>>
>> Makes sense.
>>
>> I think it is worth testing both positive and negative cases:
>>
>> 1. (read-only) direct access the data of read-only percpu data's
>>    percpu_array map to test the above change.
>> 2. direct writing the data of read-only percpu data's percpu_array map
>>    is disallowed.
>>
> 
> both is even better, but negative test is testing a condition that is
> hard to miss because you won't try to do that in practice )
> 
Got it.

Will implement both of them.

Thanks,
Leon

