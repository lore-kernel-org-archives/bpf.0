Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242B406261
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567265; cv=none; b=eIu3hSgXjxHOo7fg26alDPTz7quR9h+TMmJJ4iqbb9rNtDZy+laPIuRoQq1SQY6ULxQ9U0YGnD4RvrbCauMJ427z7qUdtkuxyDtuhoE7r5FHO63S55np4ZDlBUPFAb0iCibKJFag/gmrNnIXJYwZNJ4yoOlW0Vr9+/9fJECbd/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567265; c=relaxed/simple;
	bh=A2b42CG6jc7Hbgx9lgLOdBLDKlBvbSbrAcDtokEjdNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joz9vGHnprH7dC2CVOq9VU4XxKUMtyUdo86gDkFibCgmv4LfBvb27O91FNB9asXcF6V6e0Cj56eBs85/APMYrUrBAKYY4l65m4UTLDeomQ9gtjpjFy0Gp/0XbRr9zoh6e1cQ9GeYjpIe9l2/r/trBayM2b+RVclqtsplMQsTTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gV16iYxF; arc=none smtp.client-ip=91.218.175.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gV16iYxF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A2b42CG6jc7Hbgx9lgLOdBLDKlBvbSbrAcDtokEjdNo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787567261; v=1; x=1788172061;
 b=gV16iYxFtGHDxzo6MpsrlzOjV2RYs5NInaE1R4/ZwSdoz/3doCrdsoKAhBwWEczlXPgz09Cf
 kbWvBWEoN3F4agqm6Nf5PVlePPMNnJElKjMKdWEuUISGcvP5XPRgmJSfebS17JLX7t9uApsFmd1
 N+Xpihq2zYENVfPIz2EeKbvI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id 136207cde75cea7a;
	Mon, 24 Aug 2026 10:27:31 +0000
X-Mizu-Trace-ID: 136207cde75cea7a
X-Migadu-Flow: FLOW_OUT
Message-ID: <d485f3e8-e254-4bf8-8619-982df0e160fe@linux.dev>
Date: Mon, 24 Aug 2026 18:27:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] libbpf: Fix usdt attach failure when nop10
 crosses page boundary
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, jakub@cloudflare.com,
 peterz@infradead.org, phoenix500526@163.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260824092847.361683-1-jiayuan.chen@linux.dev>
 <3cbe827e0809b8f8e521cac3f904986e6d885780838a4118da311f40e70b1c2b@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <3cbe827e0809b8f8e521cac3f904986e6d885780838a4118da311f40e70b1c2b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/24/26 6:03 PM, bot+bpf-ci@kernel.org wrote:
>> Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Does the Fixes tag point at the right commit? The -ENOTSUPP attach
> failure could not happen at 41a5c7df4466.
>
> At 41a5c7df4466 the uprobe was shifted onto a nop5 (0f 1f 44 00 00), and
> arch_uprobe_analyze_insn() ran uprobe_init_insn() unconditionally:
>
>      ret = uprobe_init_insn(auprobe, &insn, is_64bit_mm(mm));
>      if (ret)
>          return ret;
>      if (can_optimize(&insn, addr))
>          set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
>
> uprobe_init_insn() accepts nop5: is_prefix_bad() finds no prefix, and
> test_bit(OPCODE1 == 0x0f, good_insns_64) is set. So a nop5 that crossed
> a page boundary simply produced a normal, working int3 uprobe. The attach
> succeeded.
>
> The failure was introduced by the nop10 switch:
>
> 554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop10")
> made can_optimize() failure fall through to uprobe_init_insn(), and the
> nop10's 0x2e byte is a CS prefix that is_prefix_bad() rejects:
>
>      if (can_optimize(&insn, addr)) {
>          set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
>      } else {
>          ret = uprobe_init_insn(auprobe, &insn);
>          if (ret)
>              return ret;
>      }
>
> ee2862439e5c ("libbpf: Change has_nop_combo to work on top of nop10")
> made libbpf shift the uprobe onto that nop10.
>
> Should the tag be:
>
>      Fixes: ee2862439e5c ("libbpf: Change has_nop_combo to work on top of nop10")


ee2862439e5c is correct.

Waiting for more feedback.

> This also matters for backport scope: a tree that has 41a5c7df4466 but
> not ee2862439e5c still matches the 6-byte nop,nop5 pattern, where the
> new hardcoded +10 in nop10_within_page() would be over-strict by 5 bytes
> while the bug being fixed does not exist there.
>
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32712703327
