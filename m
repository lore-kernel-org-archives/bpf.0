Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511809;
	b=TY3qpdXpld+Gj06xSpMuErOGTuA8oLulBMJIuBFNfvOe0VT/FYVDo1WPhUVnxTymv3v9
	 iyvNgCZEDQyKpr7hGe1qwn9lDspYvhKqdZFjdan3Nz45C15ljrEToEwJ6hb9GzdKFXx3b
	 YUWRJCRUDRman66nzTt7tqGHLx07++w5CMcFQPLjnDJaew7j1pEs3cPT4fO0lPC/MYZPB
	 XgQwBhIzwv0OP2vVcEkaOFLYMG3jeO9zSjziZ3Brih00w3xcH2QD5GoIG6PLIaCbaAWR8
	 nxVTjej4GUdiB/PyPI6jm699tD1tEP+vIK0nD1mehmbxvwpNPgImN0xMi8hYYLhP48g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+aWPSD9WHD2tH5+MNAceVSxEE7AS/jHw0VSgRVclhb4=;
	b=tRbq667jKD2Y/uwgzClYg7WvIHOnIgZ4tdjVadczczN5KGf/rp8OJEeXbniz5BDjj+WK
	 dWO4GqAHvw5KkkMej9u7b5f/E8YEHS8fSRjKGPhbDiFX0jWZW/97rw0c+mlaTGEFAsgtv
	 1GoLKmF7capUQ3rUmS3IK/9PqejBmgrdnNSoOgy0+wgQPsdcwzItzTjo5rTnF8pjGhzBO
	 Ermta27Y6MFk9R/ekpFnaScaW/y47z7BjAInneaD85ZmqA4oRMDJnR7N1aGwhp6JtLNE4
	 LbLY1tPG2TsgUTLs/ohJLyAiJNC7engqintyp/79WAaNiWkdd59OEpgf2r3nJ3p+G9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=rKO8AWay;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28517606A885
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 19:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28517606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=rKO8AWay
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b5ae415f7fso16702b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:30:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511808; cv=none;
        d=google.com; s=arc-20260327;
        b=XCLyvJicsgfk2ClzhKrTuvUh2SNwovDNMwlmz8pAw7uuPNAs6mrOnsd8/BeQ1QKnl4
         diOZ7y5Id0Fz4UWZwJjVQ/N6f+Yx5u3JvcviPkD0dFkNdMjx3DmuN+BAs8fc8Qo/JMqb
         n0fqlc7WyBmOkcPYosOUmwAmDSDqCFftaytkJpc63jSbNj6TrnN4k3DX2slEuZjCy/DG
         D72u1l+cydmsIEis5xrTADdLvKmh4TGHWcrhrSxagn+puJBFToZf6ABqEtIGop3IBXSv
         JuQafT1XIePRSJJf5RHxFzfS55fEAhMRrltYeQNP03Sms5D4JqDd7Nke1FSTjQge6UZU
         54Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+aWPSD9WHD2tH5+MNAceVSxEE7AS/jHw0VSgRVclhb4=;
        fh=mf5EVZun5581mPQ3B6XU/k1UuOq1dtpbkLbT0av5AvQ=;
        b=ffFU0SZS9oC9MT2myUBT66Y+67j2XyNyO++Y6+PJ6E4TiGGcayCpIQzQFt951YdKXT
         iezeN6zB9ArvoSArFAO9ukFKyHx964m/syhTt77iUFtXoT1p0AMj8roxRuaDwb9/1LjV
         /SMwCdngeObSCvbsmoT4XH6vBG01XUQBFFOnlYJxrrHPzt2xtzxelugFYBtrOM6NjvsD
         jioRYXKTNU0t+GhjEHIA2yI31Lm0ny+2vq/HZL7if/Qmp1EJNnw9y2sdtmEJOwIZgWuF
         /WzULrT30UB9zwj8Wmr5FQwrNiaX3UN9kVGxrMoleEWBTlmjuDwE64zzo0kNwwX8nFbC
         cGdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1794511808; x=1795116608; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+aWPSD9WHD2tH5+MNAceVSxEE7AS/jHw0VSgRVclhb4=;
        b=rKO8AWayB+bZ8jG8zMMhbLMXHR8XzxlJO+5tmgHNbwAYW1D3i9CKl52JuvrAf8o/qC
         yNYDUMDiVTMcYsV6uxs0FSLy/ZSMGdoyQUZHREhCBNJ2ocNg6OjMJIZDsd+6tkV6OG8l
         Py0qF6INBfeW1uYrA/v+HcEa28dSpm6yW62XcU+SkvKs5a6NmAOChnPv34lmZXTg7B/1
         1XBJL/4DfPNyi68pi1mFDUOtIxjVQjUOx7gwsYzj6F+ydaZ6DTOclMVsesr9Nnpestxz
         k7c5m238p6wDTmMgs3KR3emyHg9Z/eiU03PJkFXgpkNzGdXfQ735t7q6TjmVg06k1lcq
         pTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511808; x=1795116608;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+aWPSD9WHD2tH5+MNAceVSxEE7AS/jHw0VSgRVclhb4=;
        b=Ckv4ZYr1BEvNdrMZM9M0q7B9mguIVVIZpVkHmz1lGdydu1EYr0qgZCTz9Jis6bqIea
         yoH67SEITtnhaWRgODLa5QNuUDMx5p7IEPTIJDikKGpz33gv4fxCrDBh0oVqsx9NvpAM
         AAqmW4CRFXqvqw2a3SrDAlRT87QqjyrpIdGRMJ9zj6MNscuPjWwwswsx9/GgQFlqou6D
         O53TxiddQxmF4W8AvD+NzN+4cpM5H0DG2m/z0XdF6Ygb10yLXtzdQD2eSDuXIVSPe/as
         /ObB56+Npsgkx5gDrMTd1ewogD4Ml/Bf32eqm7jisvzN6ARfLcrM8qoE+qsjnjSK5l3u
         rYQA==
X-Gm-Message-State: APuU4Z+jBAoObMi0afRZmKyC0qDIrZruCoM8r6t90RTxX/+VpSwp2RB/
	L+J+swqgrIqqkyJE93UBfKP/vPb8RpymcZej4mVy9PBaqIRDxK2R8JXhcfYuGILorA1YlcWY3Ww
	PVtBZUdgMhHu0ubbjADSi0w9NgMbJ8hhTT6KsRAEMHg==
X-Gm-Gg: AYBFou04D4gqp6MNPccfRPOi9xwN+C/8iJehksmB2DtzF+tUv9AgGF2hfdIbQanlp2d
	3f2oSAVyinEN2bPDb6+3u+V3toP5qWTh7x8FChwV9mZrhMM88RTh8M8k5Y8Je0KLfMlXquY+PBc
	J58Tamw/mKO/sPju8U820IH3q6PRQ+IziXl462ZrRGeXuPooAs17AF0NXiDUTDu6V08BmxcEDwD
	xRvAHmVu6MbfX3fQAA6uf6x7QzKo0tcWYG548dIhS+xATJnOARtmkQidPoh0xBS6SPb7g6bxk5L
	NGP6ka4Ud2KrWpoUePZLPQG9Z5EpYdiE2YUn+8sA0GYkDtWUCO7kBHMVvY9MXox7whQLXuO3byy
	tEFuCa755QxbgdxXcUiC7B7XqFM1pdlFvdMPJAwLI+oKvQ8xMsVhFAeY=
X-Received: by 2002:a05:6300:6d94:20b0:3e2:86b6:9c03 with SMTP id
 adf61e73a8af0-3f7a71a6831mr168905637.2.1794511808209; Thu, 12 Nov 2026
 11:30:08 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
 <20261111-bpf-preempt-v2-r2-v2-2-9d8f6b952ad2@sentinelone.com> <DMSTTWR4MAET.1VEV3R66S7ZFY@gmail.com>
In-Reply-To: <DMSTTWR4MAET.1VEV3R66S7ZFY@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 12 Nov 2026 21:30:12 +0200
X-Gm-Features: AclHuK_9VqK3YuMSfLM4sy6-SrFdHB6b2EbD_ZgdfLZ2b3zUmDfAu99epYN-nG4
Message-ID: <CAPnbwjopkQo2vp07xyPyk+bMYVbCNy3+y_sU_Ot4B6GhHcwuAw@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v2 2/5] bpf: Check program
 recursion per task via bpf_ctx
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is an existing bug. Today it takes two or more progs.
> With this patch A, B and C can be in one prog.
> Doesn't hold the series, but I had to mention.

Thanks. I will note in the commit message that the series makes this
reachable with a single program.

> I don't think we will be sending them to stable soon.
> This is a big behavior change.
> Backports only after next merge window.

Understood.

Thanks,
Mike
