Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266288;
	b=cOdjq8AEo87qGsW0laB5usr7UEfGCaCqXqy4tu7Q9omOgM/slsF19Wrld2BR1wyKqvor
	 VXUiWipK6ELQcTvwjJyynYlH2+cKWd4PS9hfCKT/eHSSeB09WC1t6WVdvGQ1MEVjNxzpR
	 70xh1lr8Oz3Lg3kN9y1UCZh5qlC2KBHBteosTIVowySoEHJcgvHcWSAAfVADlcMNhIu3I
	 wajJsHsWSeFdqbQwBnKEWVmpw7AwA0orUumf1PfFPQic5qdvrMEKLWu2Ao4vhUSh2WrlY
	 8NW9vEisJTAs7tDePetoBFzAmAEOL2xOMz3vzBRYMLtAmIIEhR4nJjS1GCM0AtWungw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266288;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ihYFkFEUH2LcCpe8eqRrXvmrLTXtXa0fIIln6xIpDYQ=;
	b=p05JZbsUUY5pLFod+4Mlj5w1JuG5t6UAfKJQEalvsmlZURJptEYLx0F3jGvyZfPcwG5i
	 lmBmvJjlwbAebLmYkyb/M0HXw2T8XvfK4dJa4FaBO0oR9EuVYs/QAHNq2fKH1FQ3obiet
	 qFgqxD76F8fduNra9HWOyTJB/pK/IDXi0mwa0MUUA614zwFjYshvXGcjOnWCuRscLypgL
	 P2e16vIMOcWUeHw1RedQoQuKVd3l2wApAJEDw31JcguHdFksBupGVYsRob1uWAeeaDA0t
	 ARc+q0sEo4sRI4LC+F7yaoQQx3ZBNsSec5nvk1Xqx7tsYxGZCi+9cVGCALWKtbf2KIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w6IYyU5o;
	arc=none smtp.remote-ip=91.218.175.49
Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF7606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 23:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27BF7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w6IYyU5o
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qeIlf74Q1SwhQISt1Gbo8kqRPG0p0EGOvhCsKoDnlJg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794266281; v=1; x=1794871081;
 b=w6IYyU5oj7O1BNZ7/WWxtJ8tAVFdDwlUde9hphrHMLfD04aunCCrumQLcMiJkB/OKovzmebV
 UQRQUzwh8PJn1B/oeG6+N5LgU89c75LepokAwiZJpbDL6jYb8TveydaGKrv+xLWtiP9B3dDlCXI
 7OsqWagfB0y7xmTGWl951LMI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 82150212df963e71;
	Mon, 09 Nov 2026 23:18:01 +0000
X-Mizu-Trace-ID: 82150212df963e71
X-Migadu-Flow: FLOW_OUT
Message-ID: <547975dd-9e47-40e8-b043-b93e2026d288@linux.dev>
Date: Mon, 9 Nov 2026 16:17:57 -0700
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
Subject: Re: [PATCH bpf-next] selftests/bpf: Don't include <linux/ptrace.h> in
 BPF progs
To: patchwork-bot+netdevbpf@kernel.org,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com
References: <20261108163710.1881321-1-alexei.starovoitov@gmail.com>
 <179416380493.1666345.8032685838291433805.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <179416380493.1666345.8032685838291433805.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/26 11:50 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:

Alexei,

I added this patch to BPF CI diffs today, but it doesn't apply to bpf,
and so aarch64 selftests build on bpf-targeting branches and on
linux-next remains broken:
* https://github.com/kernel-patches/bpf/actions/runs/42712433047/job/129485446405
* https://github.com/kernel-patches/bpf/actions/runs/42679811664/job/129371245681

I think this should've gone through the bpf tree. Fixing bpf now
separately will likely cause conflicts later.

> 
> On Sun,  8 Nov 2026 16:37:10 +0000 you wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> BPF CI cannot build the selftests on aarch64 since its image has new
>> kernel headers:
>>
>>   CLNG-BPF [test_progs] freplace_attach_probe.bpf.o
>>   In file included from progs/freplace_attach_probe.c:4:
>>   In file included from /usr/include/linux/ptrace.h:188:
>>   /usr/include/aarch64-linux-gnu/asm/ptrace.h:96:2: error: unknown type name '__u128'
>>      96 |         __u128          vregs[32];
>>
>> [...]
> 
> Here is the summary with links:
>   - [bpf-next] selftests/bpf: Don't include <linux/ptrace.h> in BPF progs
>     https://git.kernel.org/bpf/bpf-next/c/a0a0c785cbca
> 
> You are awesome, thank you!

