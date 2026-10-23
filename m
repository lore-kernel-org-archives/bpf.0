Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786437;
	b=yxIZJ1W3IMJuNu7ldD7AdQDhPFfNJaiuVcYqcJrT0kB0v8NNmxLuuHbC0q7G6d+tiIAv
	 iBCZw9rZTdaUd34XT4y4VEGNdQYjEDuzmDnL40ZiG5pQDacBBI1xh0vZTUiU9U9Jdn25X
	 DNvOiPDcCSpudpfIarFcnqpsCMNnXq03EOm54SsdUpn+LEFNBaFKGwI0dj7YtruHJJR5P
	 qGz01ZjMnMsqmsPlyXFN/2a52bOUa7sjnfhBfmvAQDK+UtauHuXXGy2Q4e/57PUcLWJnE
	 r3rih5kqAGsDDklTTyFRxZGio3/lM2JQLdHcMqkNalFoCERDuzBZGlY5e08lp8km+QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786437;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=O8zJuP0Ot29cykJumEd36/jpkmF637YijXUmNxlxlHs=;
	b=23mSq4wk+y/OBkzUHsJ9nqmceVGfZfT/KW+NxI+aK5bqkjqSR6halEk2zUKxZBIhEVm3
	 wQ2BBRIUhghW5kcDEpjVaSPMz7FilAVDid32Inkt+AAPDqmtIdUB7q/rprCr9GXuk0gyn
	 4vyw0VE7PM3J63RY673HAJUhWBopb0qQRzHt99HaYdBF57KD6V1I+1cIVUrJtyJwTjIXl
	 T1IIoLN8zk17jHriP/g4TbeDejkdCo6O18UfrDuMOfsFKhtsRoeX31HU316iqAanugOlw
	 aUfLmQCr06zep3b/4kZY05HYmRXrYpwuUVeA2qogHQ4DZGdrlHKIzoD9JZvdlDxFQcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k+14i5YI;
	arc=none smtp.remote-ip=95.215.58.107
Received: from mta1.migadu.com (out-107.mta1.migadu.com [95.215.58.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AF606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 20:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C17AF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k+14i5YI
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=a03eyxrKrab9+L0DXSFejSIOg808W4EwyuwEhzn7A8s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792786428; v=1; x=1793391228;
 b=k+14i5YIoMGofBAbinKbqriTBzZ7I/nNyTRHolKAOY2lqcgeqobVo3VIULim4XRAG++QMoAC
 JikSP4S3Ch+xzqD11WJwd04hHYZXJa+zfyMgbg5kb1k0sqEB0Gpu6LkSOEDEtmIMt0IazLO3CH2
 aoghGWuy63mQG7wnK1PCB0n0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 830156828f935bad;
	Fri, 23 Oct 2026 20:13:48 +0000
X-Mizu-Trace-ID: 830156828f935bad
X-Migadu-Flow: FLOW_OUT
Message-ID: <75b66acc-354e-4cd2-b9cb-4c22e8a02635@linux.dev>
Date: Fri, 23 Oct 2026 13:13:41 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
 <20261021174406.2891598-2-vineet.gupta@linux.dev>
 <CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com>
 <20261023143816.48163575@gandalf.local.home>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261023143816.48163575@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 11:38 AM, Steven Rostedt wrote:
> On Fri, 23 Oct 2026 11:13:44 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>> I presume this will go through Masami and Steven's tree, is that right?
> Yes, but it came in during the merge window, and since it's just a speed up
> and not fixing something that's broken, I was going to let this go in the
> next merge window. I rather have a change like this sit through a full -rc
> release.

It is a speed up but not for optimization sake but to cure rcu stalls in 
production at Meta. IMHO it should go in sooner than wait a full release 
cycle.

Thx,
-Vineet
