Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060045;
	b=GQLVvYMs4dAmu/KCYOMUhqOo6jFgB7d/R9wvhYYod23MYf1Oeb3b1IJQjnkT231PKpJN
	 Mw/nTrG59L+K0UxnIsSszk6A9Zv3QBx0dlAsrLzYFx1U9QiYnKNCPaK9/PcncWJpaakP9
	 8od7aH+A/9u9Z7hIT2FQ06ifuikxPcMIYQMpXEDsU/UdVCKVuQaQu5rQsSz16oPuHxeo7
	 3MeDuMXQE7J0ACV5fUjoH7Zhml83/szR6X2kIh264vHXhDNioaH9BeqgM0fp5IWJ3L2mT
	 HoFoUP2rWjDbiAxgOHXDLQqbwBAvCUY0gd9Y6pAkaXkJmOQj/YgNs9aSdYp6O/ySanw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060045;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=mvzEX4dJeDfc3Yo3ldIUMAnH3zlRQe5ylS+OLUuj5hY=;
	b=nZC51Kby9uVPhKmYM8b8viNL4fXFp/0J127ihlKxXBRCr4WYhOMUTPGVZkM1T7f+oVVo
	 hTtlxzuD6TSrcLDqsBsKgxIo+Lnw7Rb3pzcP421wbIU5zM4g0lbXsNoFOxs/Pbb474ei1
	 keETticMb0L6JZnphvxPfx8h/D/ntPvu+QA5u1saRNOzSRcAvOSZ+aZLyyRb1G2jRf3WO
	 z8B5LAsRN/z525LwIzdaQi48mJ2PtIqZABoYBsyxmX51fa/PlND5rYiFcADsBXbySWARg
	 rLwS83NUVkb4vGXxGaJp4vyrQD02TlaPiq6fsNDTZENhJp6OijFTkBaGt6E0q5nWDkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vibBuiyi;
	arc=none smtp.remote-ip=91.218.175.105
Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F809606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 00:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F809606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vibBuiyi
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hp5YMPoRlbZKCD1LLT2HgWhmfk1kjfPiIrf0KZfdt8I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793060042; v=1; x=1793664842;
 b=vibBuiyi+geqS4xAF7LSVzlO5QgfQw7MdI5uY68MZXSn9PDinr6dno0A4zofL0l9kihckYJK
 iwzghxqbeKzENSG6vtXEL1tWlt/JWlsJq2RklAKiM7t5FR1TFU1OJZURkRCM21qwTk2mxZDn0LU
 3jvc4u0EopRRikCAVd6APtfM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f4c582b3c3521e01;
	Tue, 27 Oct 2026 00:14:02 +0000
X-Mizu-Trace-ID: f4c582b3c3521e01
X-Migadu-Flow: FLOW_OUT
Message-ID: <fcff36b6-6069-4e29-b2a4-d1ea5dd9a094@linux.dev>
Date: Mon, 26 Oct 2026 17:13:58 -0700
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
Subject: Re: [PATCH bpf 00/81] bpf: Stack in arena and a verifier that joins
 states
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <fbb26ce0-00a0-42ba-abc6-82c3c6201d8a@linux.dev>
 <DMF64ZG294VY.LCU9YQI054U2@gmail.com>
 <5c042467-6aca-48fd-b5d5-e7705e65a158@linux.dev>
Content-Language: en-US
In-Reply-To: <5c042467-6aca-48fd-b5d5-e7705e65a158@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-26 5:01 p.m., Ihor Solodrai wrote:
> On 2026-10-26 4:45 p.m., Alexei Starovoitov wrote:
>> On Mon, Oct 26, 2026 at 03:28 PM Ihor Solodrai 
>> <ihor.solodrai@linux.dev> wrote:
>>> This series shouldn't land as is. It's not ready.
>>
>> your bot didn't read the cover letter :(
>> that said that parts 2 and 3 were posted for review only
>> Only Part 1 is for landing, but parts 2 and 3 depend on it.
> 
> Why not post part 1, land it and then post parts 2-3 as RFC?
> The review was done for the full series, that's the whole point of
> posting the series, no?
> 
>>
>>>     * ask your development bots to ensure that verification of prod BPF
>>>       programs (bots can pull those tested by BPF CI from github
>>>       artifacts, just ask) has not regressed, and that there is a path
>>>       for updating existing programs to work both with old and new
>>>       verifier
>>
>> your bot is wrong again. meta progs are not public.
> 
> That was my mistake, I thought we publish the objects as artifacts.
> I'll see if can do that.
> 
> But even if they don't become public, we run veristat on them as part of
> upstream BPF CI, and those signals shouldn't be ignored.

And by the way, just in case you're not aware: you can trigger a full CI
run with veristat jobs and AI reviews in kernel-patches/bpf github repo
if you have a write access there (I believe you do, lmk if not).
Just push a branch to kernel-patches/bpf repo and open a PR against 
bpf_base. This should be enough for the bots to iterate.

> 
> Also bpfjailer was open sourced recently:
> https://github.com/facebookincubator/bpfjailer
>> So test on meta progs the whole set had to go as a whole.
> 

