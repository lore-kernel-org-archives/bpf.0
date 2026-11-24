Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501566;
	b=tnVBX2njsHibRQPPCYcRFE2ZEj4tCQKyKkhkZQjRQLymi2y1uFEQzJE73cT6pHnUj47N
	 EzNWom/NJ+q5ZF58bvPJ8NgB8fw0OBNtHoYlDwdT8bFrGiUpqpOl34w9isllH8Fw+UOth
	 Nrgl8Vb7ehgZOOYCc/ScqysMvDLf4d7H9/WJq9CTRWzfECXUoFY4zQSDWrfvPld2vxJa9
	 7XcJ45JpeqOLppWlSBsDc+UrVuefNBkz/2cpdYcG1Hk9KVu8HASCMxFi1EOtfOj5zatXd
	 5Llr/dkkxw7e8v0G2xcjpEgjyHPIof1GW0nmSpnsT3mqVtr5mCE4rna35EiXFS/JpjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501566;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=449gIxytb/HnDdGvFu4T1xW9ukKcixFJk9Iaz+yC4MQ=;
	b=WM8YhxR7B+UKRaInrhrgt50rTCQDF8YXbgic8eL0lvgNkKNB7zh++Q9OgGcTJ0a1XGtv
	 8lup/oDqFKGfx66psiA8VGrgrEyEd/Yp21JBfJN1rv+0pvVa0M5QH9XPei4S7UJS1PT1S
	 F/2RwSzDD0gxUBMVH7ZcWW7zYyUEnEnocltQkUY0G2T4Oy7q8ooo8B/axA+5OnPp8nPRw
	 YxSpWzD50hGTAIEl9wAufVbAeT+RGNgeV3PgSuR3rrpzUvYfKOcDd1CEaelg0hVICgyqc
	 xZnsXgwjjNcZVei/X0+Yofr1BS2Rg7wLATcRwppwb6cYS8mxmSzVkmPO4M4iTBBLNGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YiY8PMaG;
	arc=none smtp.remote-ip=95.215.58.245
Received: from mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D46606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D46606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YiY8PMaG
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0ckwT1MNxjCaUKr8B7kPL7bLosNZahWjCYvLItqr8CY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795501563; v=1; x=1796106363;
 b=YiY8PMaG7++Ddb0Ee2gLc0tCXOFupKJxrViHjNQbiRerL32gCCK0orcnLxhnkdUoWQYpYPmL
 pDEfSSDR3HxImIkpEDnvf+EdMTBhZ5JKmamM7HZJu3BQ7MyZ2W7zbVivpP4dRLlapGntm64aAEB
 HUGqCcDo6Ju8dFKibQwo1gvc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 588e070f590522ee;
	Tue, 24 Nov 2026 06:26:03 +0000
X-Mizu-Trace-ID: 588e070f590522ee
X-Migadu-Flow: FLOW_OUT
Message-ID: <2d330be7-3d8a-40e7-a5f5-3a24c7e434e3@linux.dev>
Date: Tue, 24 Nov 2026 14:25:54 +0800
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
Subject: Re: [PATCH bpf-next v3 0/9] bpf: Add log support for tracing
 link_create
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261123152743.19629-1-leon.hwang@linux.dev>
 <DN308UHY5QHQ.8CJOFGAHVVTR@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DN308UHY5QHQ.8CJOFGAHVVTR@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/26 08:12, Alexei Starovoitov wrote:
> On Mon, Nov 23, 2026 at 07:27 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>  .../selftests/bpf/prog_tests/cgroup_link.c    | 324 ++++++++
>>  .../selftests/bpf/prog_tests/iter_link.c      | 156 ++++
>>  .../selftests/bpf/prog_tests/tracing_link.c   | 741 ++++++++++++++++++
>>  .../selftests/bpf/progs/tracing_link_ctx.c    |  17 +
>>  .../selftests/bpf/progs/tracing_link_multi.c  |  36 +
>>  .../selftests/bpf/test_kmods/bpf_testmod.c    |   5 +
> 
> 1279 lines of selftests for log messages ?
> This is way too much.
> 
> pw-bot: cr
> 
> One row per attach path is enough. It checks that the log gets there.
> The base kernel leaves the log empty, so all four rows fail on it.
> Something like this:

Okay, will update the selftests like this.

Thanks,
Leon

> [...]
