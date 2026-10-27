Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059304;
	b=V4pLEeMqbrCwf9sp78LgE6fPYeGydxlgvnrPWlE6ZNl8WOpKwLczCGiNoUvXXkZWM3tc
	 u1e8rhnTgZv6qj0NL7kt0KoIrsonrRDrmg7ojFCK/EpB5JPq1Yp6S+X1W/Ps3p95lppSh
	 mv4L6R3P+ciJ+IUnDXcdlLPn2QCsupQXZSBjxIZMDrZ2YXS2xtFtlvBNNSbrTET5KdEh4
	 e8/3Reb4iezc8HL3Lwu1OiHWtO+RN2vPcvBEe5xsHzksWZrTKUOkStR9yCpR3i6F75/dX
	 kfmtk/jOuy+0HwvqSjcscAKJOR/qWIPx/yULLo6S9hHF6hI0CZbkEkeznctLTsw16sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059304;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=NK2QGtfUYWe9vgs7VX7DVUz7KX6l35unbjPA3QItnLA=;
	b=dczBgTDu5yFGyfnJt4nKCeIfe/rS6ODYZ0O9rVOwxN/y4D4H/Iqm1YC87UbyGmJlGVMO
	 jz/d6FUaaU2/AXa5x+o00mb5d59+g0Y5EfcDikZWrvJBrB+ADpGflfWUhh2UMXYbQb1Rh
	 ux9ObLHEC7T8G/geSV2QW0RovUqFxIC9vsiBT1E8p0XvwgaC5ucevChcdiy99W0efI384
	 zkNJDv/QCdGpzxsCKwJUy+5ZlmOlzjTDckgD5Xc61MlxcYBuwCBZSCZnk/d+EQ5TqZ+PQ
	 zyFcWxAFWNt1wzGJBoeAgpsLBoue5FOWVsJkkkwrgbZTQSJ17agPQzXSSjkF99Oo1yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J3UrSagN;
	arc=none smtp.remote-ip=95.215.58.100
Received: from mta1.migadu.com (out-100.mta1.migadu.com [95.215.58.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC3606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 00:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DAC3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J3UrSagN
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A4HVJVp6MqruJ5rTwb4NlZCuSWIgUG19ZnL3WNOdxmI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793059300; v=1; x=1793664100;
 b=J3UrSagNl2GDlccuEPWeDu4IshaiuNp9nQ+fA7T6Ivv85OVNrIq6IKmYq19QA569EKqpe204
 WD0Frc/c4+FfYE3ZmxqlJSnpR6dE+Zr8ahbD06O6n9hxuERRDggpbZC/KpeXEtdxqBFP0rFzjzQ
 UgjrTuC1D7Q+IuJ6MNMpPr6M=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id be91d234283c3abd;
	Tue, 27 Oct 2026 00:01:32 +0000
X-Mizu-Trace-ID: be91d234283c3abd
X-Migadu-Flow: FLOW_OUT
Message-ID: <5c042467-6aca-48fd-b5d5-e7705e65a158@linux.dev>
Date: Mon, 26 Oct 2026 17:01:27 -0700
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <fbb26ce0-00a0-42ba-abc6-82c3c6201d8a@linux.dev>
 <DMF64ZG294VY.LCU9YQI054U2@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DMF64ZG294VY.LCU9YQI054U2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-26 4:45 p.m., Alexei Starovoitov wrote:
> On Mon, Oct 26, 2026 at 03:28 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>> This series shouldn't land as is. It's not ready.
> 
> your bot didn't read the cover letter :(
> that said that parts 2 and 3 were posted for review only
> Only Part 1 is for landing, but parts 2 and 3 depend on it.

Why not post part 1, land it and then post parts 2-3 as RFC?
The review was done for the full series, that's the whole point of
posting the series, no?

> 
>>     * ask your development bots to ensure that verification of prod BPF
>>       programs (bots can pull those tested by BPF CI from github
>>       artifacts, just ask) has not regressed, and that there is a path
>>       for updating existing programs to work both with old and new
>>       verifier
> 
> your bot is wrong again. meta progs are not public.

That was my mistake, I thought we publish the objects as artifacts.
I'll see if can do that.

But even if they don't become public, we run veristat on them as part of
upstream BPF CI, and those signals shouldn't be ignored.

Also bpfjailer was open sourced recently:
https://github.com/facebookincubator/bpfjailer
> So test on meta progs the whole set had to go as a whole.

