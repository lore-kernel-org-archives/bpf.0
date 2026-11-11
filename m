Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365908;
	b=lGVqic17JR4Tl8oOcsf+TQDqi1uCvEcSvAgiV38hZjuV9iJWShPcs4b2131deRsfHWSY
	 P3jvLcCqc7wvckAIGS+gZkLiV4uRDrnD2gO/zI+Ui9yusrAv0aLvXmWiiQGR6ZBdOOHgS
	 UVUOo6Xm14ZZy4lKqv9cWE6Ohy1I8UNAPFlLAMQgj2W2vOvwYlxObyAfnOff/pkr4q5YA
	 ptrSvdokuXPicEEgEBGziHfUJ5JYGgoyfdM7pS29r/udxO5P58jjifKja0YJCZP3k33ir
	 a2LhsBcyFC/qSCO9MMJHDFuhBQm2NxU+V0wSjj2RzWysyanwXCgQuZZ5CwYn9ukfCeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365908;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PeWu9qbTDaD6AUYNBe1UHdE6fcYEbMgUzjHngGTPIKc=;
	b=rn2VlNK1lc3z/s7izIMXQ0f6W6jYe7vxV06Ph1ZcI+8qZemdFkMy4l7UwrTme06AWR/Y
	 t8DPkOUhjSnxWBw2W+h4MjO4zfGA9AUtMNcDDfVbkF8AWqhImbERgx3f3nbbAsd/dUpIF
	 nca1YrbOwv5IxeHbs6O1XsrNHyoBEv3NuHnhiv4PjCFxAAGmwBUmELJ/SQGdQvhL+4SxU
	 d8dOrDuAzXNdej9h/nRSA/WAtuJeBfnHtHGbw2MHwUflEJUQl2lvZX+GuEjRo3fvV4mAp
	 ruCPrw4DFCDfpgPTsu/UZRSYxRrhunypCKI7B+AAp3leVyWHgN1pzPQcp8FMJN9klfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="W1uX4Bt/";
	arc=none smtp.remote-ip=95.215.58.19
Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA1606A327
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6EA1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W1uX4Bt/
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2xQ14q8i4wn8y+T/i0DeDAU8TKCKRdi8NWCJr0SA9QA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794365905; v=1; x=1794970705;
 b=W1uX4Bt/nKxQByt1+kVfi/xFRp80Jj48Zqlgq2r52Z1Iv8Kbk9KoDWBvqa6xWY+/ypwUiSHU
 QDcWCjkvgjdx7VBYmqKXTw0Ibrwtok3LD7TGeQd+eZ39i/7AD2X/4bNQUAFBrjoZ8l1bDuGDuhB
 OfYZX7OwHV0GtslsE+6zr9v4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cadda0c8b6efabd5;
	Wed, 11 Nov 2026 02:58:25 +0000
X-Mizu-Trace-ID: cadda0c8b6efabd5
X-Migadu-Flow: FLOW_OUT
Message-ID: <17511044-f7ab-4c9c-af00-1b30554aa938@linux.dev>
Date: Tue, 10 Nov 2026 18:58:18 -0800
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
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Mike Bazov <mikeba@sentinelone.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 martin.kelly@crowdstrike.com, andrey.grodzovsky@crowdstrike.com
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com>
 <e3f63654-0f7c-462b-b58d-05f3164fe340@linux.dev>
 <DMM2G9OX9ACV.231CHJEPK0OHU@gmail.com>
 <CAPnbwjpQBR-KHwOMG2bo1uhdp22ZW_O5sUj3=vjazVu=Rdnb7A@mail.gmail.com>
 <DMN0RC27TJRM.3KUSPS9QTBV4G@gmail.com>
 <CAPnbwjrX-ywbcgNQSZKE2jiggEOSVCRVw9OLfaksihiVSCoqvw@mail.gmail.com>
 <CAEf4Bza0XDMTxxZeukwRXjvoOOruY49q66xBXnYnuncbeo_Oiw@mail.gmail.com>
 <95e07cae-85ee-4f14-b5f3-070803ee567e@linux.dev>
 <CAPnbwjqw=uxd8UyhEgNjSrpK1DhbB+dex0mGVW=dwuoygqgRHA@mail.gmail.com>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <CAPnbwjqw=uxd8UyhEgNjSrpK1DhbB+dex0mGVW=dwuoygqgRHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 12:43 PM, Mike Bazov wrote:
> On Mon, Nov 9, 2026 at 4:12 PM JP Kobryn wrote:
>> Before moving away from an in-kernel solution, can we consider the
>> direction this patch below takes?
> 
> I haven't proposed moving away from an in-kernel solution. Your patch
> is the same design I proposed earlier in this thread ("This is what I
> have in mind for v2") with Andrii's bpf_ctx suggestion folded in, and
> it's what I've been putting together for v2 (unless someone comes up
> with a better direction), which is nearly ready to
> post, so let's avoid duplicating the work.

Perhaps I could've replied inline to the mention of reusing bpf_ctx. I
read it as assuming the chain was already traversable. After
experimenting with making nesting traversable through the common
bpf_run_ctx, I shared the RFC to help validate that direction.

> 
> beyond trampoline progs, v2 also covers raw_tp, tp_btf, syscall
> tracepoints, and BPF_PROG_TEST_RUN, and disables the per-CPU private
> stack for preemptible tracing progs since two tasks can now run the
> same prog concurrently on one CPU.
> 
> a couple of notes on your patch:
> 
> - Passing prog to bpf_set_run_ctx() churns all callers that don't do
>   recursion checks, and doesn't fit bpf_prog_run_array_sleepable(),
>   which reuses one bpf_run_ctx across all progs in the array. In v2,
>   bpf_set_run_ctx() keeps its signature and initializes prog to NULL,
>   and bpf_prog_enter_recur_ctx() sets it after the walk succeeds.
> - bpf_io_uring_submit_sqes() calls bpf_set_run_ctx(NULL), so
>   dereferencing new_ctx unconditionally will NULL-deref there.
> - Cross-task synchronization isn't needed: a task only ever walks its
>   own current->bpf_ctx chain (and any IRQ/NMI on top of it runs on the
>   same CPU and walks the same chain), so compiler barriers around
>   linking and unlinking the frame are sufficient.

Fair points on 1 & 2. On 3, "cross-task" was originally inaccurate
wording. The intention was cross-context visibility under
interrupts.

> 
> I'll Cc you on v2 once I post it (probably by tomorrow evening UTC).
> testing and review there would be appreciated.

Sounds good.
