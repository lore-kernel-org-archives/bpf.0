Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033845;
	b=uzM/HXTWBfEAeTG6guvbQpq2qObsQExgKqKeH+RPEvnnQlIb78lHIMt7bsiCzxKVdSgO
	 kI0xVy/b045sqrhZtTnpynyMApBbaFfBUm7DnMd7X4X/ZooqqbviWmnMRp5B+tOs8Y5Uz
	 ACRNDTrHxAk5bHs41stqzYJfx307XIvxKC4SxbGBvNiz4CRj9CLAMPj7VT4mZ9CM3JIQj
	 4gXG5qTTgbezk1B41Q02fzQFwbT1+EPngq0Nu1s7yS5PUDg8Q2VsUvqyHBgG8hWrViEkY
	 CVayDLU6yOu6imaiahC72wMx/0VI+BBBAhBaCPnF7+Qh5qypltykw2DHxW6Hm3wJOpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033845;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dYxYpvwJMFDqxls+Ax+Touu0EmLmsdQCQDRF4Ck9NQc=;
	b=z0aNcliLDE+oEQuyNBQ3cxw6Gw1RTbzGPGEm99BPhu42p9jRX7lqmT24KYfsjwMUFS5G
	 TdCf+n+7Ah+e93bxrfyL4/MNb3Xw3JbkaKxHn+/EaKKyZ8hTHdkw89s81zhE1MUf8Z3Cn
	 A12FptXI2KpcFvd70oWTcTFuCGMYyi3uAXqeoDwNR7IYbiEId/y8SDJz3yKM48zL9pMY7
	 cyKkl5tjAN84SO5UHVzMeuqVDdxeVpWl3WNAdWrkFp8H+yzZ+npS1VX9jMVAhlGbQR/gg
	 SbVO0ehjbbn9h6znKqXZ/5O+0xFiNkTGwvuXDhva2nH+Z6Ez8E8yyUB0ZaTQ+RZ7J2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=trs+MkHB;
	arc=none smtp.remote-ip=91.218.175.201
Received: from mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F11606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F11606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=trs+MkHB
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RMfTgaRUoiaxEHhsIyG+M65YID8nzE1VG8cCXs9xaO8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793033841; v=1; x=1793638641;
 b=trs+MkHBuRYMexfKl74uHDbv1LW4/oPLL2zFD5FyrhCRxzqtOedaoQv7RrWb9bMvCQ2tn1SD
 BAa1TvT7yNEx8Z1PITIl5Afz7ByVC5KEkWsrz86sfM0OdRb0h25HHffvXIdpoaXvL3rUoZGiOCf
 0QcsR8PfOl0TTP0JWRn8aKgk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5bee8700fe12c375;
	Mon, 26 Oct 2026 16:57:21 +0000
X-Mizu-Trace-ID: 5bee8700fe12c375
X-Migadu-Flow: FLOW_OUT
Message-ID: <fba239f1-febc-4af5-8033-a893f8265191@linux.dev>
Date: Mon, 26 Oct 2026 09:57:17 -0700
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
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-25 7:58 p.m., Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The goal of this series is to load Rust programs as rustc and LLVM compile
> them. These programs keep data, heap and address-taken locals in arena.
> They use trait objects, recursion, unwinding, and loops that have no known
> bound. The test programs are in https://github.com/4ast/rust-bpf
> 
> The series has three parts:
> 
>    patches  1-15   Fixes and a revert. They do not depend on the other
>                    parts.
>    patches 16-31   A stack in arena.
>    patches 32-81   A verifier that joins states.

Hi Alexei,

Just FYI bpf-ci-bot AI review workflow is limited to 50 patches per series.

The limit was set as a guardrail for commit selection logic (to not
accidentally run review for 10k commits). I chose 50 because usually
we ask people to break up long series into smaller reviewable pieces,
and pre-singulariy >10 patches series would already raise questions.

Since the approach to patch review on bpf list has obviously changed
recently, what would you suggest as a new limit?


> 
> Only patches 1-15 are for merging now, into the bpf tree. Parts 2 and 3 are
> for review. The series applies to the bpf tree.
> 
> Parts 2 and 3 can be reviewed separately. They touch each other only in
> patches 51, 53 and 80.
> 
> [...]
> 

