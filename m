Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127405;
	b=tP0UNahGL1hI41GAoTE3mvjwslgJ8HpGzT9SdFlcihLImk3Mcxa+RyeJtslOzm00TBtJ
	 eF1OeTBDi7pIhV9BeBS4Y5ERwsChr4yd/ahbAsVksJHK4tCr0P/15ppnwOE24Bv9X84oo
	 fiqjFsuVqTGcCG6V0dOeelXB07+nah1gviEtyiEinvIsgz94FwM8LE1wPo0quyAMNXMMX
	 uxkT5AK3yLHZeqUezZ9J9DTwa7k1u5T5wKGvg9+30tef9d4BDuDYIIk+buJ73LtKXFLj/
	 3WL7kDCEUiy9ITXBRSYMbNew1dLDm4ppIoB1JPiVEBEzNhA2y0OXP5lV2SMUdxTwpog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127405;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PAsHlrKspx+iFNr2pdz4faPpej0PByWphtdAdAsaCnE=;
	b=Dj8X5C1PhaGTWaxqxzbeG7UgOXSDUBSI5Aq+3RXkLCRNKhx599qX9AT4EQRA+9CD78MZ
	 kPe3JsQOM9yOT4LkggwCChPObt+roNwsMcU3N8g7Vpl7fFfhKqLRvw8OffGgWMpcBipxH
	 TcWtFpIHI/u3EcO96xZa6aA5fvJJFQQoVvNJ51gIZe9LGJc8GNYl14eUtetW5B30huJNf
	 3e5XlbNSRBnl0r4USY/H4bjmhbT2T6phXzebZ8Kh2qVXqb2rvCc8FZm6EpPwUMi0pzj3X
	 uQ05fIeETVrzG9EI+M0rA/swYpZ61htE/epdZOMlc1RFMzW5WVzra7WXqsAnc8HXg/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etuYKQjc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA7606A325;
	Thu, 19 Nov 2026 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etuYKQjc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ACF1F000C0;
	Thu, 19 Nov 2026 22:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127405;
	bh=PAsHlrKspx+iFNr2pdz4faPpej0PByWphtdAdAsaCnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=etuYKQjcK1oYRgavxX4Vr/1It0/68fKPeJ0q42zp97zkbuqpSoo7LJm/QNVOHxOwc
	 b8Ym8Zo4yZTr4SmSi7NOgTM6UPixP8g8KfLpkCb/AYOAexpA7KTI5oH9B8u9mpxCvF
	 13W+b/d08aWloyfTHJTW5PT0zf6rArwpF/vBv+RGFeCSTavzlU/WMzU2giDheNbqRE
	 mFQ+TMPf7281WByKHkNzFzxYEGFh7qzxBiPWO//2hKVyhQjFZqKYXkkq6fltxYLOi5
	 VVOjirT+hB+/YBbAFerrT/p3gmN2xGDothWbM/apV51tFEyFd86yLhNe6FPxcUIexu
	 kAml1vbXlN2FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773E03808209;
	Thu, 19 Nov 2026 22:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Fix bpf-gcc CO-RE relocation in
 verifier_sockmap_mutate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179512740429.3899857.16134777898494454791.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 22:30:04 +0000
References: <20261117122417.340562-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261117122417.340562-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 rhkrqnwk98@gmail.com, mhal@rbox.co, john.fastabend@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 17 Nov 2026 20:24:13 +0800 you wrote:
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
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Fix bpf-gcc CO-RE relocation in verifier_sockmap_mutate
    https://git.kernel.org/bpf/bpf/c/7543d8d314b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


