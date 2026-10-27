Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059451;
	b=P4cnQGhEVc7Z+QDifijTE13f77nte/rrvWz3MXMOoU57L54rnUPHdRzhpjEs4ZprimrG
	 PGbSkr13yHHxuahc+N/OU9z6GtAL6qSdWoA0fWNYCFPHw+iqpVJuu+0z8Ltxe1gvud68d
	 bnjWGuM1t+5lNN6RdkfoubfJqNri/MJ8NIoF29i6zeIJSXe9XHx8omG6Pd+Vk9q4BvvNm
	 uLztBcb+d5pnrYM4QBk5EWi7bFNV+L8LNssKy765DT2KdhWu9rtS/pwERaRzuo7E+9HLo
	 huSM6dtL7P8kmsP3ElzFDR8GsqG6+c48SJZOHB5by0AZ8GLVjoDVRDnBg1F0h7ZlR9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059451;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Msno5cSRpuMAs6wj81BItGvtCMI0plrWFLYPRXrvWdY=;
	b=yGbXYw1Pu3SjVs5iC+DKnZ42YRfTXMujR7hAoybAU2BVf5nrHF9tbSHU2I02vEsDNZJm
	 iBeRmbyswp18sYgpxHAk3S5bJ0tmbSZfJtQcezH97zj4Q3S7MBiZTIBmbY6eFJe28znXS
	 JapznnikB8Ch+5sTDVY4xEEZiJ1GC+jqeJLPRpG9jDImxRu7cyhdjLgWiX+NP35uFAzZ0
	 VkX8U7T3LNHZ0srr3N4cpGqqymkfcAq2Hge0gb40yWXeAztK8RKnDErlOzEwEclcVI2+w
	 Von5w0+dqxNYv3b9RU1xxyf7WpAwMxSONSNk35t+rlqIoV4OSD7OyoydFpPWKg0u3vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XtNdLaGi;
	arc=none smtp.remote-ip=91.218.175.175
Received: from mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E08606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 00:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E08606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XtNdLaGi
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VO14hEUXLDhBzYweiS5ywuk2yUCXWgT9SRC3HcxCQMg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793059448; v=1; x=1793664248;
 b=XtNdLaGizzwci9wHDD4POTT637AKAfyyytcst91eRJRChVY+Ou1yj/0Cm12x2PJjd3PTQSJx
 aE23rSPRV1gSs/QZHuMWCJo8fFCTwQocrFhEQxO4Fm6cm4tc65pO0515+8cMg20uwvBiaXgGx9e
 JD9AoSGxHILVgMf+7bGXM7s0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ae09bd6725ce0871;
	Tue, 27 Oct 2026 00:04:08 +0000
X-Mizu-Trace-ID: ae09bd6725ce0871
X-Migadu-Flow: FLOW_OUT
Message-ID: <f9aee9b2-0010-44b2-afb4-0be3958b332c@linux.dev>
Date: Mon, 26 Oct 2026 17:04:02 -0700
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
 <fba239f1-febc-4af5-8033-a893f8265191@linux.dev>
 <DMF6AVOBX25C.28Z0NJS6CEB3J@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DMF6AVOBX25C.28Z0NJS6CEB3J@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-26 4:53 p.m., Alexei Starovoitov wrote:
> On Mon Oct 26, 2026 at 4:57 PM UTC, Ihor Solodrai wrote:
>> On 2026-10-25 7:58 p.m., Alexei Starovoitov wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> The goal of this series is to load Rust programs as rustc and LLVM compile
>>> them. These programs keep data, heap and address-taken locals in arena.
>>> They use trait objects, recursion, unwinding, and loops that have no known
>>> bound. The test programs are in https://github.com/4ast/rust-bpf
>>>
>>> The series has three parts:
>>>
>>>     patches  1-15   Fixes and a revert. They do not depend on the other
>>>                     parts.
>>>     patches 16-31   A stack in arena.
>>>     patches 32-81   A verifier that joins states.
>>
>> Hi Alexei,
>>
>> Just FYI bpf-ci-bot AI review workflow is limited to 50 patches per series.
>>
>> The limit was set as a guardrail for commit selection logic (to not
>> accidentally run review for 10k commits). I chose 50 because usually
>> we ask people to break up long series into smaller reviewable pieces,
>> and pre-singulariy >10 patches series would already raise questions.
>>
>> Since the approach to patch review on bpf list has obviously changed
>> recently, what would you suggest as a new limit?
> 
> I didn't know that there is such limit. I'm not sure there is a good limit.
> Maybe whitelist it by known developers with commits?

The purpose of the limit is to guard against unintentional blow up of
compute and token cost. It's not infinite.
Are there plans for 10k-patch series?

I'm sure we can come up with a reasonable limit for a "reviewable"
series.
