Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795438017;
	b=pKGTrsCeNAuCO12fhLUsJD/+3+4AiLpRP0/WypDtGcoVskE65PkqlJIjx0lkCd903juH
	 f6Gxjx9q0tv7gHbjficOotu2pNXPTAs/OEfrRwcgye9iFLI98wdl/xqA+xrlHd8sI68+E
	 h1bC6SrpTT3vnfhM24VdizRI1zB5J60YHPotlpmQ1TDXMYndKC+YEkzfyVvVJW4kzcef/
	 aOtSLY8s30cDcTynrbFRNBJ5Zgd2oVN/Y+mx7A1Va6jxqFSCK6u7w4UaSEFnaeLp6wc3p
	 1FEMw6NAz3f7HoBYJAGHwM8UhGfAKt3ZAxHNnz6KIPvkn0ynK7j67kSUiED5XbxKQwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=KDkZDqK4FJQoP/w58gPsz+MrboHrJj/4Mpu9CUS1Qq4=;
	b=433Jpq1jDzsN08XXTupQ6ls1fgNknNUCOLjQ6XBfgYntS6gjiNpaV2gHNILSv6/P6nuL
	 JGb9C2spS4ShIwwEkNEHX9+MqcycQufclkv7YHlRkIxtJPp3bTR39q6gP9o+Fpuwj8rfx
	 fUXWVVgrTAhBT9fP/dUMJLdd0hwp0IPOlWeNXkzcpuu8kS8nPacMfujt9+dtWGj4Hz1yZ
	 9msap2ghr7PxeatZl5ifylRlpSByRc2wsY81U3HclOu+m4NaqHOtRjz/uSsZtqWc1Lr3/
	 JzvxWwYf+rg5BadLKgGPhRegCo43tExF/vz4OcSpw7BWzwq76T0Ltoa0zvBu1+M2ACQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=pXRgNTbM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ABE606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86ABE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=pXRgNTbM
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b4166b78b7so405752a91.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795438017; cv=none;
        d=google.com; s=arc-20260327;
        b=fWj5YWwoaVoNlvkgi/rXQ/v93AvRrG8A6AgNvthxhVlCyNhoWw5xn/jf9vbfO+I3Jk
         mpM4qcDxkvESSSeQ+eyGTnIYx5V4BDFB8Bk9D87gNoaHTNJNJsImw8OVwv3XMJC7AaGz
         P8QwhcwTlVbdK2FoA0wxrhQmgbTikOh0lQnLf1rMnOQ2lshqe2v9bWTgyeB0y39YylMS
         1HpZP8QqjsfouOY9ImAMQJHubN3XlTYRUDQzsb3V/drAzj72l5aD7FvkZfr8GI+WxkiJ
         9BkTkhzgXQzPwadZflxRiehvTSRgN8DSwz27OIiyswzrB7T9SCQG3BwkMPA7B2hYfAYI
         WdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KDkZDqK4FJQoP/w58gPsz+MrboHrJj/4Mpu9CUS1Qq4=;
        fh=8eq3ztitMJBYgSYh6HDwNK6V/619uyvVfnQL+guejOY=;
        b=NyRuhwG7gKgBLmo4u22G+kmIv/B+Y+0Uw6iJCkUi2lXj8Tew8/1gaKpBNV4+ij6y+b
         yFaWqzb/T7gaEdjYjbqG9Hq999oaBp01x85TcqYWuJDV7ibu9lduX1tOuHAU02LExkna
         nGIT1kLNYYgOpQfS+9sGNIws72KaUdycVdRZkGkm36CDeC+y7clPTWaUx8ilylx5K8KK
         w+qhy9nxYsGqZTDeCq38Z6GxYK+PBYcgpbRb0jMPedl0RoiTsH09KaAsDdMAhf9AIWrE
         Geh8U2RMDIXzF2UfyBCuWnf5qBlpx4ipVW+SOx+M0pZr1NCadWKkdxBjR11gYsO7a+9T
         UEwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795438017; x=1796042817; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KDkZDqK4FJQoP/w58gPsz+MrboHrJj/4Mpu9CUS1Qq4=;
        b=pXRgNTbMkIXjMzPbu17WG0l8GOiu3EuIwmuf+7ud7ElnfnYfbsWUT2RU3cBhoqc+Eo
         bPFK6qFLclLuIIC2qPTWHHWgmZZc+SbwdqrzmoLmuBtwv/Iht3ZwAUYgH+427EUwKdTK
         o6qvchedkYZ51RSKw1no5KmHPSRDyIGHlka7H0VBYETPlwEmN2WlLbtuLivJfxlYA2H7
         ++524aGwTcmBv1zCW/4QY0SP1fL+PHgNqCL/2z3yPH3TnhcgortPr/5cG6OXrsSFPfWD
         iuaobfvQheHH36CQ4jUyTfxB7iNoiwQdk0PKfN18G51O9AZh0f5egpBN3lq7KgqYcEzj
         BcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438017; x=1796042817;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KDkZDqK4FJQoP/w58gPsz+MrboHrJj/4Mpu9CUS1Qq4=;
        b=L0EmOh0ExAVgIyHUA+HZ9wEkR8d/izhyIe2nMFKBIsQ1XFpNoVRXmxKrrVVhbEa0SI
         Re2zfSaA8JThbrQCMy4mBm/5DKXJhHE1OvobnDdVEbjOsIcF7EcCvlhPkOsdTARTezma
         gNjc+cQGd1H/5jOOp4SQQ/5+MjUZbHkRXNNlmQ9Z/P7tttGucI8SmsuTMikuThnY7Zic
         oU4dwPqq7WTEad612y7AIzswLtMe2S520/Rk9dEV9b5Tv34GE3XBU1xISNpnpoouzzIg
         X9+whAx02YDDvPHjthzB8bzUMIUAzuk0IEJwG1clTMP3+JiQS+E/WUyM5tNDouckjFKd
         HZfQ==
X-Gm-Message-State: APuU4Z/1KdA5BFZVxuObWP90AWghhPbWv8tmuc5Y4COht4ai9/oDRkv3
	6CCPiD1JwZHBpg0tcf4bEE1Xa43qmxvguu3ylqacal2Chas6LXHMluyGSsh0zFrpdBYQobZtnHw
	vvIugupX6hgO3uODhftno63nvSm1NkInyFxFGcUGPTA2UQMksP1aqr/Rn7Q==
X-Gm-Gg: AZFdTZfxZXWq85mnu1x2ERA6d8ESKT0cyFtJ0BRZ21souNWvsrTAJc2s36RlJQIWk4Y
	JmwN4l8Y7gSrRTUyofWv969jzIB4zY7cBv5JT2H19dGWNcT4VCkoTHHMULwxhBNYTUtvGYSq07a
	9FIrZl0iGXfmpHn1mgIagonW+NezPWteulmzdRQqCdtja5WY/UH7p0FgUaCraiYmzeB/kMRAD9O
	BMJugwZID0rRxAMDSU7icqCjKgtDQF2+vwxVYxGUEMfG6hFZPBrwJ12oApT1NzwOrLx3VRYjdTo
	iBw9iO59kyfu7qBdzkTor8oP5QbnpIhTa1Um8cIgUOabxpBqFxwDPZTR7jvtMD7MPBBUsWEXnaT
	mVwGtVti3sORHx96XiQ1rNbOXxF9Xo/VvYDpcxMdBr5J4yyFyMOFD31uX
X-Received: by 2002:a17:90a:e705:b0:3b0:9e2c:9b55 with SMTP id
 98e67ed59e1d1-3b41c803ae0mr16166809a91.2.1795438016707; Mon, 23 Nov 2026
 04:46:56 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-5687f2b53b57@sentinelone.com>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-0-5687f2b53b57@sentinelone.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Mon, 23 Nov 2026 14:46:59 +0200
X-Gm-Features: Aa3M54p4sO9o8A2kmO51dBuRGf5c0KYrhMd-49WQIyuTD5aiNinuGhI6siMAx_M
Message-ID: <CAPnbwjpJ6z9SQPGS-hOezBeE6fRjD_bo2aCFAnKT0N0en=WPaA@mail.gmail.com>
Subject: Re: [EXT.MSG] [PATCH bpf-next v3 0/4] bpf: Check recursion per task
 for preemptible programs
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A friendly ping on this series.

One update: I measured the per-task array from the v2 review
against walking the chain. It is not faster. The numbers are in the
3/4 thread.

The question from the cover letter is still open:

> One question: the marking is automatic. A flag that the program's
> author sets would avoid the second trade-off, but existing programs
> would keep losing runs until they are rebuilt. Which do you prefer?

Either way the program marks can be reduced later. Each has one reason:

- Timed may_goto: its count and timestamp are per-CPU memory that
  every entry resets. Possibel solution would be to keep them per
  invocation, in the stack of the main prog.
- Per-CPU maps: a run keeps data in this CPU's slot until it ends.
  Turn preemption off from the first per-CPU access to the end of the
  run, as Alexei suggested on v2.
- Tail calls and freplace: the target may use a per-CPU map. With the
  access itself protected, they need no mark.

Thanks,
Mike
