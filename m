Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496E38E129
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417467; cv=none; b=kdgg0TKwvd6ThVRZrTcRfUMdHcwEfLaK24KpMKTTDAmrCYPYkPYoZeDSf4y4VMW2hxo6dKRXj5iitkXgWD+gDW80qfWQAxTJv0o2v/P84Sjh4c25jvnEC7pwLtrP/mz4sjemdSGuzi86JJEb61+13tN1863Q25ZpHKi7vNzUoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417467; c=relaxed/simple;
	bh=zWsEA9ZkvK4j1l8N6CxYbYZKplVfMciC0EzaUn3GRvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIEIQsC3ZrkV3TqVGHN8Xk5mUiEoeQylAB58Rq1k8obnFX9oFto88tlX/CWArGs49nrmVmhsyua2i4cQMXweRwRM3h4rFiAe78fXwRVe0Qn0FXVS4nw8TZWGzviEnTzzm8In7yG6B2GSwBtwrJwXsWEmLUy+lbD84MXzNF1Caqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IuNSQaZz; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IuNSQaZz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783417453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FeECPxqcKBDpzwrgafVGQXP8D8lqlIet8e1AayvBXk=;
	b=IuNSQaZz5J6PPB6yzhkLld4+RHm8oIR9u7m+xCymRkouHWG4KzU+TWn747xuE4vfXvprn8
	XbdQlWXUYmORydBqyVT6NRniq7Q9t1uaYogIRNeaNtn73hViQiZdnc6c8q1GyhQNDfFPCU
	WmV81hLKLht0auo40hmDWCqyeA2g1uk=
From: George Guo <dongtai.guo@linux.dev>
To: yangtiezhu@loongson.cn
Cc: chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel@xen0n.name,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 01/11] LoongArch: BPF: Fix tail call count pointer offset for arena programs
Date: Tue,  7 Jul 2026 17:43:54 +0800
Message-Id: <20260707094354.319438-1-dongtai.guo@linux.dev>
In-Reply-To: <d7f2c8d3-4a46-e978-5cce-f59b84e632f0@loongson.cn>
References: <d7f2c8d3-4a46-e978-5cce-f59b84e632f0@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Tiezhu,
Thanks for reviewing!

> This introduces a runtime helper to dynamically calculate the stack
> offset. If another optional slot is introduced in the future, this
> helper will need further adjustments.

Fair -- that's exactly the tradeoff. This patch was written to be the
minimal, obviously-correct fix on top of the existing layout (arena slot
above tcc/tcc_ptr) so it could go to the bpf tree as a standalone,
backportable fix. It does mean any future optional slot needs another
"if (...)" in the helper, as you say.

> Please see the following simple and long-term solution, just move
> the arena slot below TCC context slots, this ensures a constant
> offset, reducing complex runtime calculations and eliminating extra
> instructions.
>
>   LoongArch: BPF: Optimize redundant TCC loads in epilogue
>   https://lore.kernel.org/loongarch/20260630022705.11536-2-yangtiezhu@loongson.cn/
>
>   LoongArch: BPF: Move arena register slot below TCC context
>   https://lore.kernel.org/loongarch/20260630022705.11536-3-yangtiezhu@loongson.cn/

I read through both -- the reordering is a nice fix: with the arena slot
moved below tcc_ptr instead of above it, tcc_ptr's offset from $fp stays
a fixed 80 regardless of arena, so the original hardcoded macro is
correct again everywhere and the runtime branch goes away entirely.
Agreed that's the better long-term shape.

One thing to work out: this series (patch 5, exceptions/bpf_throw) also
needs an optional extra slot for exception programs, using the same
mechanism as arena (it currently piggybacks on the same
`ctx->arena_vm_start || is_exception_prog` check your patch 2/4 would
replace). If your reordering lands, I'd extend it the same way --
moving the exception-program slot below tcc_ptr too, rather than adding
a runtime check back in.

Where does your series stand? I'd rather rebase this patch series on
top of your fixed-offset approach once it's in bpf-next than have both
land and immediately conflict. Let me know what's the best way to
sequence these.

Thanks,
George
