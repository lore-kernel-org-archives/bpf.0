Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153ED2E974D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782881355; cv=none; b=YpzASNPJsLCQmADo1roOVi58ylxU2jyZJ4MU3o7Mu/cWCtXjlix/DexRHUs7H7Kmn86PhxzZnO6e5q8CPc9Ac4cxm1cm9MucmioQw2gsxJVYgCPOX9qD1YNPYnyL90AMeCnyGZDHElgpPqUYF2FCA7ch1NN8vUkH6U8lKkL9yD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782881355; c=relaxed/simple;
	bh=nV9x2pjJRXiBjCIQsQELDTPsQRdqyJhMYg9qsBaOT4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwNbGJ/VNUd3/f8ljYSbQ1n0bX0wBR0NVRMMU+beqFeawEWtXbABi6c5jFAuFnzVif86YZJloZgM0VDDrKDBf4ji4YWGH3F53plnXT++Zuyuee62XoNqtKlit48qtscEJKwHQ8dwTDQWGnlB00vnArb8IlUzd59AGWzuPgnZC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T1oaSd8c; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T1oaSd8c"
Message-ID: <e3a91acd-2b4d-4e93-a3bb-a0e9ee5ede0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782881342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VzfTSU/LJugefpT+9c9ezhpJItWxOxPIKamlZ67+v3Q=;
	b=T1oaSd8cWqVw0VwHzXfYohvE3+w2XmfwdGfq9TMtAvb/zib51tCRZo1R2nLwLRA9BelXIa
	3RcEztCcj9VeBSZ+Pa3i7MTkt99HN3+YiEIN8Lu628puVZMwuyKbot0tbIWomwjvEGtH4A
	tEm+4cQeQcTjLsb4vORPAsJENqizilk=
Date: Tue, 30 Jun 2026 21:48:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 0/3] bpf, sockmap: reject a packet-modifying
 SK_SKB stream parser
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026-06-19 7:44 p.m., Sechang Lim wrote:
> A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
> which can chain skbs through frag_list. A parser that resizes the skb
> frees the frag_list segments that strparser still tracks through
> skb_nextp, leading to a use-after-free.
> 
> A stream parser is only meant to measure the next message, not to modify
> the packet, so reject a packet-modifying parser at attach time.
> 
> v5:
>   - target bpf-next instead of bpf
>   - add Reviewed-by tag (Jiayuan Chen)
> 
> v4:
>   - https://lore.kernel.org/all/20260619062959.3277612-1-rhkrqnwk98@gmail.com/
> 
> v3:
>   - https://lore.kernel.org/all/20260618102718.2331468-1-rhkrqnwk98@gmail.com/
> 
> v2:
>   - https://lore.kernel.org/all/20260612123553.2724240-1-rhkrqnwk98@gmail.com/
> 
> v1:
>   - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/
> 
> Sechang Lim (3):
>    selftests/bpf: don't modify the skb in the strparser parser prog
>    bpf, sockmap: reject a packet-modifying SK_SKB stream parser
>    selftests/bpf: test rejection of a packet-modifying SK_SKB stream
>      parser


Hi Sechang, all,

This series broke test_maps (test_sockmap subtest) on the bpf
tree. Currently on BPF CI the test fails on bpf, but passes on
bpf-next (it doesn't have the series yet).

test_maps fails with:

     + taskset 0xF ./test_maps
     [    8.352378] clocksource: Watchdog remote CPU 2 read timed out
     Failed sockmap unexpected timeout

See test_maps.c:995 in test_sockmap(): the 30s select() times out and
test_maps exits 1. Note there is no "Failed stream parser bpf prog
attach" message, the parser attaches fine.

The series was merged into bpf on 2026-06-26 00:42 UTC

CI runs:
   last good (pre-merge, 06-25): 
https://github.com/kernel-patches/bpf/actions/runs/28158326456
   first bad (post-merge, 06-26): 
https://github.com/kernel-patches/bpf/actions/runs/28210181858
   recent bad (06-30): 
https://github.com/kernel-patches/bpf/actions/runs/28475936023

Confirmed locally reverting the 3 commits and rebuilding makes
test_sockmap pass again.

Could you please help investigate?

Thanks!


> 
>   net/core/sock_map.c                           | 20 ++++++++++++
>   .../selftests/bpf/prog_tests/sockmap_strp.c   | 31 +++++++++++++++++++
>   .../selftests/bpf/progs/sockmap_parse_prog.c  | 22 -------------
>   .../selftests/bpf/progs/test_sockmap_strp.c   |  7 +++++
>   4 files changed, 58 insertions(+), 22 deletions(-)
> 

