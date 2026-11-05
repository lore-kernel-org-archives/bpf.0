Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901383;
	b=PXyEIyA6zby7IA9YVS6NBheIaliISfMAEBoG6DspTBxmfF58eomtw5QxMPYk32P8yhhF
	 /xOUrCGt8a5m3L7eEUc9tvp5OQYqOtylaK5FNlYK4n/DYCi1HfxolLJ3ggbXf2glKiZvF
	 KVacOEEOkcU7u6RnU/ijIy+7/uptpiGcc2krZBlk4G67MuSPwnxABHKyp8IxIQMA5RNA2
	 I0iZ3CAp7A/C2oxqKMgDRgO1c/e12jgAj7FkAta+VHgrDySMGx/Fv34omTxUIKBZ9xeWf
	 JI0GHkpb8vLY/9vMxhFK/QbrngkpTIDdYLX9cm/k4FTilRhte2bwDRvwpyG18wggJ5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901383;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=c9l3GCx27vWCzWprqBUpZF8ewdrrLXW/RA/zgGEtIsE=;
	b=yATBs14GLD37mIQBsYpeVdL7rw8sUzZLSWiYAzvoUuNXjVLs83wG7UVj8FunRObzK0nQ
	 5IONoyayNYIUb0uGYOPko6yE+HBAYeT4mhFx8GD/dV8Rgrnsy+x+qTkx1rPG43IT0vo5w
	 Q+ehFPNYgsJMmiR9jktZZr9QTm2+HwYYkbSrLo0d/1x2uK08BklxYjI/0w8DfaEs0x+QS
	 3JRcBT6SuTgIFGm1DjKxfudaGIzGSbqeLWrDByTja0fPyjj1NqpqNv6rHK8bkXUe7ejNB
	 gVjZEeFS/UkHrKkuHy7wwjm1z9xqlordOSoDNH50cJz+L7/YxcIHg5pF0Clp8EP7rxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.164
Received: from mta0.migadu.com (out-164.mta0.migadu.com [91.218.175.164])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8FE606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C8FE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FaUkFUcHuP3BiesPQYnJEtWy77nW5jWOpPkoZ46/VDg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901375; v=1; x=1794506175;
 b=vhGOx06MUin+6IT6RcCDaNLs8FswwfRHcwxD5UprIwZuWACBn7FcbOWvYCWI2TIF8g6AonrQ
 NMbTaSfvKz5Iindtkfj8xEC/yfkjvLYXKrkB9ctLXnPvdSPA8t1EmnaiRLrUiVP8DQ6gPebHuPX
 kBVV1UCzbhXmbH2kHiP+952Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bb547c92f083d415;
	Thu, 05 Nov 2026 17:56:15 +0000
X-Mizu-Trace-ID: bb547c92f083d415
X-Migadu-Flow: FLOW_OUT
Message-ID: <53ee72a4-a5f7-4a7d-8a0a-fc3fc8804d75@linux.dev>
Date: Thu, 5 Nov 2026 09:56:07 -0800
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
Subject: Re: [PATCH 1/2] tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE to
 1024
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
 <20260922225526.1554758-2-vineet.gupta@linux.dev>
 <20260924100040.GD4121339@noisy.programming.kicks-ass.net>
 <1e223334-b371-487b-a60a-7f1f5c007f7e@linux.dev>
 <20261105122648.67abbe1d@gandalf.local.home>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261105122648.67abbe1d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 9:26 AM, Steven Rostedt wrote:
> On Fri, 25 Sep 2026 12:32:49 -0700
> Vineet Gupta <vineet.gupta@linux.dev> wrote:
>
>> For submission, would you take this up as reported-by me or do you
>> prefer I send a v2 (your authorship and SoB etc) ? No big deal either
>> ways just not sure what the std operating procedure is and nuances of
>> all the tags etc.
> Please implement Peter's suggestion and send a v2 with the tags:
>
> Link: https://lore.kernel.org/all/20260924100040.GD4121339@noisy.programming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

I think you have some catching up to do still :-)
This is v1, we are currently at v4 [1] with Peter's suggestion and 
further split up for ease of backport and use of new rcu_scope 
constructs as suggested by Masami san. It has been Acked by Andrii [2] 
and Alexei [3]

Thx,
-Vineet

[1] 
https://lore.kernel.org/bpf/20261021174406.2891598-1-vineet.gupta@linux.dev/
[2] 
https://lore.kernel.org/bpf/CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com/
[3] https://lore.kernel.org/bpf/DMAUS3F32198.M27YWDF2F3UV@gmail.com/
