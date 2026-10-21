Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549413;
	b=I/7WMTdUkqfvLQRkVBy7xBSbQp+FfN+GVDdRjyT1r3EbFWTNZ6VJsEFF+pJ74jHq1+4Q
	 UPeRtEo308VixusYNGuFON8dLHvGBVmcBqSFOt5aaramWvmqxh4uNven2RwMOwsWfOZcl
	 7Bi3Vb+WSllwCM2PtMflO6wQe02iHK+mU7mvohRNy8z2RRsbO2TaByYbjlbyo2E1x4onc
	 pYvz20dkRX0ZH0YjtYkrTed7wsh6SAkQJmoy6m/IKe3Aora3am3amDTj1JSvuiXcbRU98
	 75Wfa1UjaOvR9m4f7tsaatNmAwgkmKJn/NWhRib2qLfK1Q+1cjRQ5feJQPx9k2FUtyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549413;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=B8lphOSifg5PX8nlYSTrapvqoMYvG2iX6H0eCr1oYfs=;
	b=NrdgJWkAKMID/HAAQYsHTFnzhHF3yEJO5KoQSR+3F4oRhL+tFfUu4zqkZySVnV8J73s+
	 XzkMj/ZoqTtJ3OEcqTJjYNCIAZXO1S1uLtiX3yflULEL74Kn/FUaYADlBCm/mvQD9Kbze
	 7PJrpBRgNQwYKKYZXGs2KKz8NFVVNzVbue0kYjJ3fGRWQKc6CtCQLAvmDgm/eQjnhEuRF
	 kQ0EsbiddS3SnPmMPVQPdGGNY+79m6W8ndXRPvuWQRICkA/5ad2VBONphd/QmhdhyB3PW
	 8Lk9u9WkTaEcY3pbnGXWqBqIRdc20rTInr9a+DkDHX0pNRoGlY28bXtfNG2BLzROULQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mJR0dfsK;
	arc=none smtp.remote-ip=91.218.175.5
Received: from mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA047606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 02:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA047606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mJR0dfsK
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qh78UdNs3hhRSxjo+cpVhmeG8GQtin9AMjRRaqMlQa0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792549410; v=1; x=1793154210;
 b=mJR0dfsKj0S1/HTRIZ5D6IdeYHBK6zNYZ1mQd0bnslRSXXM6Nrs/LE4tYGAKuc6RSyZu6xfQ
 FaS1EA4tsfwfjvFkcTKXUhqKcKN4LaWvcnzNsd3A9vROzdnpJPAYsA5cY0qjTO7iqSwu0sAnDYr
 5W4lY6JpLBLyiPaVHVmjfcPE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cc6c77ef38f8cd01;
	Wed, 21 Oct 2026 02:23:30 +0000
X-Mizu-Trace-ID: cc6c77ef38f8cd01
X-Migadu-Flow: FLOW_OUT
Message-ID: <1ffe4765-ce81-4ff6-a483-e978dce5b234@linux.dev>
Date: Tue, 20 Oct 2026 19:23:25 -0700
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
Subject: Re: [PATCH bpf-next 2/3] bpf: Reject unwind_goto and unwind_exit in
 offloaded progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, yonghong.song@linux.dev, martin.lau@kernel.org,
 mason@kernel.org
References: <20261020231942.2568163-3-alexei.starovoitov@gmail.com>
 <1cc7789274018beba70932ec8806130f1ff07eed56b62e0afbed41385630e4b7@mail.kernel.org>
 <DMA2VC8SJY0S.8O3PIVXWV2J4@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DMA2VC8SJY0S.8O3PIVXWV2J4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/20/26 5:08 PM, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 04:43 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> TL;DR: Code looks correct; only the commit message is questioned: "nobody
>> looks at jit_required" holds just with CONFIG_BPF_JIT_ALWAYS_ON=y, otherwise
>> offloaded progs were already rejected, so the changelog should name the
>> configuration.
> 
> It's a nit in the commit log. Not worth a respin.

It is a nit, and this particular one might be fine to ignore.

> humans and bots MUST not report nits.

But I don't think we should remove "nit" passes from the review bots.

If people don't read commit messages carefully, and review bots don't
either, then we are increasing the amount of sloppy or outright
incorrect claims in the git history.  Even if only bots read the git
history, this is not good. Over time it will increase confusion and
ultimately burn human hours and tokens unnecessarily.

And also what's the cost of a respin with a bot fixing a bot-detected
nit?  2 minutes? 5?

I get the move fast attitude, but we could at least let the bots do
their jobs assuming we trust them (which we de facto do).
