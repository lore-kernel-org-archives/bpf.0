Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121757;
	b=xJg6T7Ar0TFa8I+btUipMTHitWwwWj7QeLNPWwORP4bpW4aOXLuEDzEFgBLSbzQHtTVU
	 MmqRmvrkfCECoUwijD49VTp4HuTXIKo0Bis6zD9xqgF2r5YrKx1BVWamPZ+5vjSj/TKTD
	 eLT48aJkFywBuGDxU3jQJ5S4H0bHiPjcwehhqd5sEZEQ2R3KeitJM8GadOI0e1QqUfWzv
	 hcKbXtph6JZmrrumdPJLBoRW/gYYNXfnRxivmQla5zrUil5yVU1/52JSqF3dJuVnf3MOH
	 lNRRTXbhEgv7a8LuTsOWrEmtP2/n1pi+l1DKBHZ6JvULkcTpJ8v+puSyLAqclhIg3zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121757;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=RAn8N6gSfkVa4V0mSBkwOuD+bKCvbb3xoXf3f4G383I=;
	b=aYOAc7zQffMjOim2VBfoTlMglX7PgkpuB0K/vq8s9OH7cKcfkAVGe2tbLxPgRhuNVJ6S
	 e3duQXrxEp6OJbxtKFBoPgi85c0TR3qKCKzuRUS9QHqWg3plAHVJ398z07AR6kO5HT56e
	 rcl3LrcZSHtjLWh+nQRdfl1FP7myY2+DGwJR0Aj9WdsRT1AnDmpiIydNm5g/bFbvc2WCw
	 D6FbTbdfuiYCgXgvwuBd8QMDkw9fQtzNX6RyIijz1gjpaxrAPi660TiR/+H1IpSRrRhYa
	 ZGki/NmzhoyvPhYQ0WE9OEyCUCLLfFP0oKbO5DsBHE6QoQgIcycmLp/ySxe5fyLLwVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cdj+Xl3b;
	arc=none smtp.remote-ip=91.218.175.84
Received: from mta0.migadu.com (out-84.mta0.migadu.com [91.218.175.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16095606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 20:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16095606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cdj+Xl3b
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m1boHPeRYAz7gh4uxsNHGhcag9dpvPIeasTIYyTZheM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795121753; v=1; x=1795726553;
 b=cdj+Xl3bjcjTHQV2+Fddn1jTus5cPouyUcbZnMkY7/1ut9KJ4b5Ea8X3Udi1Aa9gPlbjpxXT
 HgV/zjPDkhf1FFuWXhcKLTlCqy2XwkP+aLg8P0tr4Jq7nb78W06g2GfAX6QB1qVoexnEiUswAsU
 RPwOHE9WbOC3DxeIqythObBY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9cc57f456e8289a7;
	Thu, 19 Nov 2026 20:55:50 +0000
X-Mizu-Trace-ID: 9cc57f456e8289a7
X-Migadu-Flow: FLOW_OUT
Message-ID: <b3270941-35e4-4b30-ae0e-9adff152bf5f@linux.dev>
Date: Thu, 19 Nov 2026 13:55:45 -0700
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
Subject: Re: [PATCH bpf v2] selftests/bpf: Fix bpf-gcc CO-RE relocation in
 verifier_sockmap_mutate
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org, ast@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Sechang Lim <rhkrqnwk98@gmail.com>, Michal Luczaj <mhal@rbox.co>,
 John Fastabend <john.fastabend@gmail.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117122417.340562-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261117122417.340562-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 5:24 AM, Jiayuan Chen wrote:
> bpf-gcc fails to load test_trace_iter_unix:
> 
>   Error: #766/6 verifier_sockmap_mutate/test_trace_iter_unix
>   libbpf: elf: skipping section(3) .data (size 0)
>   libbpf: elf: skipping unrecognized data section(18) .comment
>   run_subtest:PASS:obj_open_mem 0 nsec
>   libbpf: prog 'test_trace_iter_unix': relo #0: insn #0 (LDX/ST/STX) accesses field incorrectly. ...
>   libbpf: prog 'test_trace_iter_unix': BPF program load failed: -EINVAL
>   libbpf: prog 'test_trace_iter_unix': failed to load: -EINVAL
>   libbpf: failed to load object 'verifier_sockmap_mutate'
>   run_subtest:PASS:unexpected_load_success 0 nsec
>   validate_msgs:FAIL:1014 expect_msg
>   VERIFIER LOG:
>   =============
>   0: R1=ctx() R10=fp0
>   ;  @ verifier_sockmap_mutate.c:124
>   0: <invalid CO-RE relocation>
>   failed to resolve CO-RE relocation <byte_off> [4] struct bpf_iter__unix (0:0 @ offset 0)
>   processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>   =============
>   EXPECTED   SUBSTR: 'cannot update sockmap in this context'
> 
> GCC only applies preserve_access_index to types that carry the attribute
> themselves. The anonymous union holding the sock pointer doesn't, so the
> CO-RE access stops at the union ("0:0") instead of reaching the pointer
> ("0:0:0"), and libbpf rejects the relocation.
> 
> Fixes: e16c83fa764f ("selftests/bpf: Add negative test for sockmap update from non-sockmap iter")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

CI confirms the patch works:

Failing: https://github.com/kernel-patches/bpf/actions/runs/44576883691/job/135760256786
Passing with the fix: https://github.com/kernel-patches/bpf/actions/runs/44083943280/job/134048457373

Thanks for the fix!

> [...]
