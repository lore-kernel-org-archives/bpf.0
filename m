Received: from mail.kxxt.dev (mail.kxxt.dev [74.48.220.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D0376486
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.48.220.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785656; cv=none; b=G/3kdYydjNYAA08bdjOTZK/hxI+51wEV+g4iXHBnmT1sOpDyodtemTXAIhsnm9tAJSw8zy9Yu3+FRu9axpjq7wflMrCKODIuAv6E87/O5FAy0xFKRHESJ3TczvmSoEwon3/YTC3qaKE0V8dJxkir5R8/h14szbn26/QIOo52ht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785656; c=relaxed/simple;
	bh=e9g1t+++D1W47ZSMzZf71KrDg1ayKef48TNlXkdIAe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLxG9lKpD/QzEjuyPE3xmPZUCnBZQDq3Xgwj1g1EGYHGDHd80X8L/WydKr0q9oBFjB8OgD3PvoLCW6szd5hjWsr6jiwqQV7DafU36q+yXloNe2VGTpjDQROyQHjcbXz6e3GD7V4oWAFXpaFhPnN9elC1bmaWMLVF0p6CTPppi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev; spf=pass smtp.mailfrom=kxxt.dev; dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b=j3NLlgNn; arc=none smtp.client-ip=74.48.220.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kxxt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b="j3NLlgNn"
Message-ID: <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kxxt.dev; s=mail;
	t=1772785259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nn8g5gHgKMueIA3TGxuPE4nPA1D+2gRsYqnKR9yiGGY=;
	b=j3NLlgNneDkC5yYOkSYOyEkMjitYZmS6Ecu7vNO2Jahx+9nzj497F0E6VMkLB7sGBSTpYQ
	sAzIoTy8O7tMvDhAdNPV7FNlA4X94Xuwto9x7kBZwOxTQI1g8tMvtK/oRwJScxKu9jZpbH
	g9GEr4BfkZuJIOs989PHR13ilgog6N0=
Date: Fri, 6 Mar 2026 16:20:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
Content-Language: en-US
From: Levi Zim <i@kxxt.dev>
X-Enigmail-Draft-Status: N11222
In-Reply-To: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eduard,

On 2025-12-30 15:13, Eduard Zingerman wrote:
> This is a correctness fix for the verification of BPF programs that
> work with callback-calling functions. The problem is the same as the
> issue fixed by series [1] for iterator-based loops: some of the states
> created while processing the callback function body might have
> incomplete read or precision marks.
>
> An example of an unsafe program that is accepted without this fix can
> be found in patch #2.
>
> There is some impact on verification performance:
>
> File                             Program               Insns (A)  Insns (B)  Insns      (DIFF)
> -------------------------------  --------------------  ---------  ---------  -----------------
> pyperf600_bpf_loop.bpf.o         on_event                   4247       9985   +5738 (+135.11%)
> setget_sockopt.bpf.o             skops_sockopt              5719       7446    +1727 (+30.20%)
> setget_sockopt.bpf.o             socket_post_create         1253       1603     +350 (+27.93%)
> strobemeta_bpf_loop.bpf.o        on_event                   3424       7224   +3800 (+110.98%)
> test_tcp_custom_syncookie.bpf.o  tcp_custom_syncookie      11929      38307  +26378 (+221.12%)
> xdp_synproxy_kern.bpf.o          syncookie_tc              13986      23035    +9049 (+64.70%)
> xdp_synproxy_kern.bpf.o          syncookie_xdp             13881      21022    +7141 (+51.44%)

I see that the first patch in the series causes some impact on 
verification performance.
The patch contains "Fixes:" tag for two commits that landed in 6.17 kernel:

c9e31900b54c ("bpf: propagate read/precision marks over state graph backedges")
96c6aa4c63af ("bpf: compute SCCs in program control flow graph")

I have a BPF program [1] that is badly affected by the patch that it no 
longer loads on 6.19.5 due to
E2BIG error.

The program consists of multiple nested bpf_loop calls as follows so I 
think the impact on it is expected.

(entry point) func trace_exec_common
-> (bpf_loop) callback read_strings for reading ARGV
-> (bpf_loop) callback read_strings for reading ENVP
-> (call) read_fds
    -> (bpf_loop) callback read_fds_impl for iterating over the fdset
       -> (bpf_loop) callback read_fdset_word for reading a single word in the fdset
           -> (call) _read_fd for getting information from a single fd
               -> (call) read_send_path which reads the absolute path and mount info


After the patch, I find that I need to comment out the 
bpf_loop(BITS_PER_LONG, read_fdset_word, &subctx, 0)
statement in read_fds_impl function to make the eBPF program load.

Does it mean that after the patch, the verification performance degraded 
significantly compared to older
versions of kernel, e.g. 6.6 LTS? Or is it that older kernels are also 
impacted with the same sort of bug and
currently waiting to be fixed?

I am also exploring ways to fix my bpf program so that it could work on 
6.19.4 and later kernels.
It would be greatly appreciated if you could share some insights for 
fixing bpf programs that are badly
affected by this patch.

[1]: 
https://github.com/kxxt/tracexec/blob/main/crates/tracexec-backend-ebpf/src/bpf/tracexec_system.bpf.c

Thanks,
Levi

>
> Total progs: 4172
> Old success: 2520
> New success: 2520
> total_insns diff min:    0.00%
> total_insns diff max:  221.12%
> 0 -> value: 0
> value -> 0: 0
> total_insns abs max old: 837,487
> total_insns abs max new: 837,487
>     0 .. 5    %: 4163
>     5 .. 15   %: 2
>    25 .. 35   %: 2
>    50 .. 60   %: 1
>    60 .. 70   %: 1
>   110 .. 120  %: 1
>   135 .. 145  %: 1
>   220 .. 225  %: 1
>
> [1] https://lore.kernel.org/bpf/174968344350.3524559.14906547029551737094.git-patchwork-notify@kernel.org/
>
> ---
> Eduard Zingerman (2):
>        bpf: bpf_scc_visit instance and backedges accumulation for bpf_loop()
>        selftests/bpf: test cases for bpf_loop SCC and state graph backedges
>
>   kernel/bpf/verifier.c                     | 13 ++++--
>   tools/testing/selftests/bpf/progs/iters.c | 75 +++++++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+), 4 deletions(-)
> ---
> base-commit: f14cdb1367b947d373215e36cfe9c69768dbafc9
> change-id: 20251219-scc-for-callbacks-d6d94faa2e43
>
