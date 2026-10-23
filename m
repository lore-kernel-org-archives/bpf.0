Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783672;
	b=V+KkdNGLY3p+uH5IG3MAHi9bi/1+6hF73A+RSqU8AtUeLxIub9t4NRgVPIlS/wAcjv5U
	 6gqcayzSUszu+/Aezta2OELj0jRu4k8Yj+XIIMLXTd46/grT2cdsTc41t2OGvQkFZ5Nfo
	 1o8sehzGwyQCCdH4myVA7r6Pf/zcy//qzBSUxtCW1IySAs3tQ3Gzv65rE2Dpf02FfJvHF
	 0MKd65uASynf9jbpren6/Y6Hf0mOmE5iMyyd40Ej1Kpk/rl+XKvJ4T7lzhzQ2euhwrvXi
	 A6KSDoS0Wq26YcUh+4gBJlCkSpU/UG1uIzmFgrM2lrU3o5nWkl24dTwENbiy0/A8j8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783672;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:Cc:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=rmNL7EwrRaslbfYEi5j/mAu2eKu9jULT6loXYTduEYQ=;
	b=D6LUYHC8w+RCXXpn/bjh24nn/D7ZVfu/C9GYaiLgzLfaZq4ZJENF0H1r2cCzEe1EDOfY
	 ET4bR1xgOcGaClgcvrz9QiduyzY/swTqJ9I6GxFWR8H9vQck+C2jPBKzkiV80qfucbxwc
	 FkXptwqI2plCt2mMyo0LXkejYZT3OInVkYEsmFH+1XTmrkUirQQcUPn1NcWmn6e65Yu9f
	 rCHTT1eLvI8wqjfMPAQ9BXxx37LrCmTIyMZJqTnIVncqMGh/WWXTxAPyvb/77twCXFNlg
	 tMxOdDEufLSa+RaptYg+B2Ka/6i1MbK8ypN+DnUfGTDSkm6UUwHNPtjr4ue6TA/8hwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hTh2EPnn;
	arc=none smtp.remote-ip=95.215.58.232
Received: from mta1.migadu.com (out-232.mta1.migadu.com [95.215.58.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84D606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 19:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B84D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hTh2EPnn
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lc7mBRhsQeQEvtaX14L+4Bmvql5UNc3XbLUHtlVST3Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792783667; v=1; x=1793388467;
 b=hTh2EPnnscTNHvThLrSPXv0BcdLT6LJ9JQ+grUaueWkhDbhtVFgGshuV3JE7C0OZD/SuvTne
 z7+Ub2RrXpx+zTjG0JLk7EIKByjItOqIDvCaSU7TcdgOxPIhwIxYpg5FehsgSSQRYUwIF2XRnSj
 End77DJg0/3NCqPilIX/tZqk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ae4ea0f91ec5008a;
	Fri, 23 Oct 2026 19:27:47 +0000
X-Mizu-Trace-ID: ae4ea0f91ec5008a
X-Migadu-Flow: FLOW_OUT
Message-ID: <69794757-5b55-4796-8388-35a074842708@linux.dev>
Date: Fri, 23 Oct 2026 12:27:42 -0700
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
Subject: Re: [RFC] reworking the review-prompts subsystem guide
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Chris Mason <mason@kernel.org>, sashiko@lists.linux.dev,
 Roman Gushchin <roman.gushchin@linux.dev>, ast@kernel.org, kuba@kernel.org
References: <91e21331-ed6d-4ac0-b237-b01aeadca2d1@app.fastmail.com>
 <f8295279-7af7-4b3e-bc9b-112bfc49816b@linux.dev>
Content-Language: en-US
Cc: bpf <bpf@vger.kernel.org>
In-Reply-To: <f8295279-7af7-4b3e-bc9b-112bfc49816b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/26 2:22 PM, Ihor Solodrai wrote:
> On 10/2/26 12:04 PM, Chris Mason wrote:
>> Hi everyone,
>>
>> I've been updating the review prompts, and you can find my current work here in the subsystem-build branch:
>>
>> https://github.com/masoncl/review-prompts.git subsystem-build
> 
> Hi Chris,
> 
> I've set up "shadow" AI reviews for BPF, taking advantage of our
> existing bpf-rc infra. It's a copy of the entire BPF CI pipeline that
> we occasionally use for testing of the CI itself.
> 
> [...]
> 
> I just pushed, it'll take a few days before we get any real samples.

Hi all.

Got results from a couple of weeks of running the subsystem-build
branch prompts on bpf list: 272 patches in 50 series total.

TL;DR: BPF bot will switch to the subsystem-build prompts. There are
no regressions in findings, and overall the results are quite similar.

Chris, IMO you can just merge subsystem-build into main.

Some stats:
  * Same outcome (review posted vs clean) on 90% of commits.
  * Medium/high issues: posted on 7.4% of commits, vs 5.9% before.
  * Low/nit-only reviews: 10.3% of commits, vs 15.8% before.
  * Cost +6%, same wall time.

Interesting findings:
  * Old vs new prompts differ about as much as two runs of the old
    prompts do: on an unchanged patch reposted in the next version,
    production reproduces only about half of its own findings.
  * The new guides are consulted in every review, but only 3 of 114
    new findings cite a guide answer, and the old prompts found those
    too. No clear wins attributable to the guides yet.
  * The new prompts no longer produce the "A subsystem pattern flags
    this as potentially concerning" items (mostly selftests style).

Overall, it appears that prompts tuning becomes less important vs base
model improvements, at least in the context of searching for
regressions on patches. As long as the core intent is expressed in the
"root" prompts.

The analysis was done by AI, of course, so grains of salt everywhere.

If anyone's interested I can share the dataset and analysis details
separately. Let me know.

Thanks.

> 
> Thank you for working on the prompts!
> 
>>
>> [...]

