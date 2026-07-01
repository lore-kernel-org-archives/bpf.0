Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAB3C37B3
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948945; cv=none; b=mWtvvXh/KyRK0HXrqEHW4CdQ800o/rqjU3escVKOSQs0CFHmHz9p9QDIsYLyVIzugnDHT70B5pt/dWDboRPjzYaxUwc0AqcYK6tIS1P9Kkbk6gpHbK57PzOErtFWUfF6EBnvdCTcPuiLxs217m0X4OCOexVOZIm0T8/Mn4ADL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948945; c=relaxed/simple;
	bh=ZcZ2Eg4sv8GIoFelOGXJNBamVtu/MNhZ42isd7EwwAA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JnVBkqx3ZJztxESssGDgMyMNVqlHXUQ1lm9KOLo3WywPp5xPklhSLBiu2ChGXClyvnj6K8ATvTn2cR7662/LqxG+Kj3RfUJhjOlGfU1XMfQFhHU9yT/1gnkZEl8y46sJmw84HEugP/yFngcz8oi+XKBJ9AV9cp0LcBQdo5C2M/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6ySf8br; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6ySf8br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507701F00A3A;
	Wed,  1 Jul 2026 23:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782948944;
	bh=A5gMhX175pRdBIFer+eUsh68HhhKJAPdUjNPyhEhISo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=A6ySf8brCWB7u5mk2CN5+L4eWj/c3PIAIGC5PH1c0IjjG1b6cPhpmEzhtVnhDnrQN
	 zYwG3ko/ExnYWssSXn/AZEbdoSG/mp/2xhAagw209M0P9Hm5LOrhZPQDCSOZUCTfj9
	 +U+Bmq6I0EZkFyZ07PadmDUEhpjiAHKitzaH0hDtSo7k7JSno0tZBT5t65IheDffGf
	 JKrCCeI7A8khmW+/5FPgQztuqo/ZUlpK8+HhZ0ode/YGIBuXIk2+t8Bzbiz6/+bFCG
	 QhSGW7YP9VKuviPVdmyX/RP13qmMrjScg1IAhyYP4+vwj8azIdbvXlkKO9M8lLxbQt
	 F1d6y7flus6PA==
Content-Type: multipart/mixed; boundary="===============0329938339531119601=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <234a67445d7e00727c9ecc843adb4eb77d30169bc5c5fa282ca42a4efdf74c72@mail.kernel.org>
In-Reply-To: <20260701225034.12628-2-emil@etsalapatis.com>
References: <20260701225034.12628-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests/bpf: libarena: Fix can-loop zero variable definition
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,mattbobrowski@google.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 23:35:44 +0000 (UTC)

--===============0329938339531119601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: libarena: Fix can-loop zero variable definition
>
>     BPF can_loop based loops require the index variable to stay imprecise.
>     This means we must initialize them from a currently imprecise variable
>     instead of directly assigning 0 to them, like so:
>
>     static volatile u32 zero = 0;
>
>     for (i = zero; i < NUM_LOOPS; i++) {
>             /* loop body */
>     }
>
>     The libarena implementation of this technique is currently faulty. For
>     the technique to work, the variable must not be in a map. This includes
>     the .rodata DATASEC map used for const variables. However, libarena
>     still defines the zero variable as constant.
>
>     Modify the zero variable definition into a volatile variable. This
>     change adds a complication caused by the compiler optimizing array
>     derefences from
>
>     for (i = zero; i < NUM_LOOPS; i++) {
>             val = *(ptr + i);
>     }
>
>     into
>
>     for (i = zero; i < NUM_LOOPS; i++) {
>             val = *ptr++;
>     }
>
>     and causing verification failures. Use the barrier_var() clobber macro
>     to prevent this optimization from taking place. Using barrier_var() is
>     the only way to break the optimization, as annotating the index as
>     volatile does not suffice.
>
>     After that, remove the bpf_for() invocations introduced in libarena for
>     parallel spmc testing.
>
>     Reported-by: Eduard Zingerman <eddyz87@gmail.com>
>     Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>     Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

This corrects a bug where the "zero" variable was defined as
"const volatile u32 zero = 0;" in src/common.bpf.c and declared as
"extern const volatile u32 zero;" in include/libarena/common.h.  Being
const placed it in the .rodata DATASEC map, which defeats the
imprecise-index technique that can_loop loops rely on.  Both the faulty
definition and declaration were added by commit d5327480a12a
("selftests/bpf: Add basic libarena scaffolding").

Should this carry a Fixes: tag?

  Fixes: d5327480a12a ("selftests/bpf: Add basic libarena scaffolding")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28553504082
--===============0329938339531119601==--
