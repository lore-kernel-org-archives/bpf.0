Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50B361DB4
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103210; cv=none; b=SKSFo3z1mvR+Lb4GF1nehXARZu2EmzoyVL/mfD1GsozgzC7eF7EG3aZcp1DpR8AUA4ykYly6L5zH9cg+TzphYePAxygon4+5P5i8yZZDXx4AYlTcE0Ba+6tPhn5IH20D72z49FGhSAxEoIMhrDdHXaRBWLbZQkn7C+fOL5xONBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103210; c=relaxed/simple;
	bh=EZ5L9/8vCKGwNhWhMjSjHfJAz1UuMsebK0N3Q08CBDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL8QmUNDZy91QQxyt7F3JHoXmWIGMJug4bc/VCeD8OD4Qhvq9Ukqqiy+SHXypFX6JT1tV2dRePxnegjSdQ89GEC/x0rI8RWAO/3u1eiGOikDZx65BmlsfHZ9P2f3Hrt45j4zIG5vTKsU4QNZ1HmTLOFoR9Rxa/iqIABgCT2EH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nwQ6P4pw; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nwQ6P4pw"
Message-ID: <f0342ed8-e390-4913-88c6-4c707017be00@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775103196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyDssAxOmEqYRcnBxOmr1uAqXti1Tp5or+KW3X9Gg88=;
	b=nwQ6P4pwOqzDhTpFlILFqdJtGlw21yGf4JISxn72gQGKv6pobyypFbyVSmyxNwvqmE2K+1
	WFVWyU62MJKsius6dxf/ckqhZzvxx0nHd1vXm94Qk6jYZ65uCh8i2z3sC6u3vviGurJkx4
	1MiF4Sn6zLfogeb2YP9XR2DicnnDJEg=
Date: Thu, 2 Apr 2026 12:13:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject sleepable kprobe_multi programs at
 attach time
Content-Language: en-US
To: Varun R Mallya <varunrmallya@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
 yonghong.song@linux.dev, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260401191126.440683-1-varunrmallya@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260401191126.440683-1-varunrmallya@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/4/26 03:11, Varun R Mallya wrote:
> kprobe.multi programs run in atomic/RCU context and cannot sleep.
> However, bpf_kprobe_multi_link_attach() did not validate whether the
> program being attached had the sleepable flag set, allowing sleepable
> helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> context.
> 
> This causes a "sleeping function called from invalid context" splat:
> 
>   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
>   preempt_count: 1, expected: 0
>   RCU nest depth: 2, expected: 0
> 
> Fix this by rejecting sleepable programs early in
> bpf_kprobe_multi_link_attach(), before any further processing.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>

Acked-by: Leon Hwang <leon.hwang@linux.dev>

The cover letter is missing, and the change logs are missing, too.

[...]

