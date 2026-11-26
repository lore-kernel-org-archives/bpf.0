Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661305;
	b=b0WyUUT5m8JwHzcLolsj0vA78Xc5Zge+ZLwsOpWp2mD+w7B3yj61jWkjK6iK/JdFf4Fu
	 CrVHKKw5DXErI6kA7EUaZAq0Etu6CsNOEONIW82+7W7q4ACLPspvspdGjT+Q6/oBr4B3J
	 SEGa3zMkFokzKi5CUBprs/GDcPDErIUdrH0Y0h8DoPjbekw6jKUrn30aB5fPTw8XfNDdm
	 51ZXVj/qYYaErJpz4luZrGtCCEH49VTnkKXjmwLxOep5HoxldTQ0IlEgkqQDj6yFofATI
	 +GaK8BOcRtEfSJikF9ganQaH5bXh1TfUQM7PsQ/NDcpSMj50z492EzyUPcHFaq3g0tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uXsG/J8SjUA+u6xV5gQi3ekCpADG/Nmz2q3u5DO1GSw=;
	b=ObHKdwavW8gOS/uqdi6Bt6i6TjX8Ufc7xtHRTO9kcXEUIXO4pZWvWYt1e66Sk14z8O8u
	 NaBr/m0/KNhYkn6okAQHV/2GlIOjG8qvb5AzSTHW4+71ysXgHMwD2nlSMQR67gG3Ljhg/
	 F6/O6eYsc9VVfrSsnUSTT4Z/retYhlbQn+z/7yLawef2SKBpxQXf8fqCsVsXt1ZFnH+yi
	 pdMjD8ClXYlc6F17/AiK7f6UlWkppaHLsdRlqoyP7LpePB8Kjey4Op0PiRfPHfdbF8KSw
	 o7BejIG9ckCZiSNHM06zW6eNVhJR3JXBG3Qwq9mGr2cXK/hVf1kjxkpXiJuTdcLlkGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWIL7Kkf;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B47606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 02:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B47606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWIL7Kkf
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ccca948203aso4848124a12.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 18:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795661305; x=1796266105; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uXsG/J8SjUA+u6xV5gQi3ekCpADG/Nmz2q3u5DO1GSw=;
        b=hWIL7KkfCL3yaQsFQRKV2YraC7VVF3oAMqKIMdyD7qlk22rGclRIkoua5vlMpTMBr5
         rxPT1fKoNqe54FlsoE7dBShxb0WCzgSMpiLoPk2N93Dc0zNZHGX9eD6E1Lex6wcECS0M
         A+RRExWB5fzKTz1t8NJ4ieU3InEGHWU3TBv8jgNNXp/FGXAiOx0TZa2hoDqb6Pp9+lwI
         gWFOiqYZURGXSvKxHqj2oDh1MmESQqc97X8TuspANrgz+xqlEgKbl2F1HN1RKUVSRIUv
         2FuaOyz9D3e++Xel+ceknSPbtOhxPE5eaIFWuFUEiv80ZwxkNWwaKaEpJ4v5NJ3yN6rr
         3Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661305; x=1796266105;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXsG/J8SjUA+u6xV5gQi3ekCpADG/Nmz2q3u5DO1GSw=;
        b=MMeaPS76matuO1+ZH/gj5JW73UuPjUFGHWoIOGmGbeGwiff8Qcsj8ZR7p88te5DQMI
         RQDvMM2EGgmN8z5lgJVP1xp8YiOuYHwm4PPu3xqsHHTvQR2gQizVFOjUrvBsgbvnUxKY
         GMrxfc/3X0VFWc5ECFK6V3vmsHj74dbNmyfu6DOU33b4YZtljNWawrOC1qi2l6fE5SKW
         tj/DmOyaLr1F4+vtu0SzFrBtC/2+6Dpj7EapfVBZkxFcG9UN/EkPAFwkT5SjoNqo/yPK
         usgL/yNl/7P2jJJ/cbBTzISMitGqeqsIMGR1qc27GAjzKZT4XvXdITfvbehcPqB4FYoE
         x+zQ==
X-Gm-Message-State: APuU4Z8Suil6VieAOJDsD10rYv3ZadTt8APnDIql4h5t/lwoD0HOxOXX
	sda9B4OmiYFF1eTI+reqtGlqivrucp29SCOarXnkoQ4Qs9bFQHOgng53
X-Gm-Gg: AZFdTZcJe6KiSe7T7+17rLW0PSMIQc7RdHTSs9/fGHNYxPZChxGIe5SkrhE8vEptcwz
	QwCDl6EyhTIzddbTRtyBBRadDR/lwHsaaD5tKuLCKRQm2A+6BglbW2vTHjDNtH8FdsUsB6rMSxT
	AvRvSDF327iap8fhVf7c28WF2T8l1CeKG5UnR/XEIfQl5lP1fexkI2zC6lEP4KKlZjQx2qFHtGW
	P/63XEQTt7gJTBLhtN42ghpHW+dZ/IriC4H2sHTMPOjBCL/KPdSU8zH1LSYDvNBMuiNxdJMep07
	s/3o8b1SdIthBCA4PUWNsC8Q1RpIAD8IFpPJAm0apYiBWZGBOrWXcBbT2wI5nq7kcV9nc+oaxMU
	yhFRqimyyumdtA7T4rPPzmgJDmyHqj1ftXPVgBxL7LiIfaOJzQVVBQSgehpWxlAMIqgXJU2bEKb
	C8I/cffzwxiJCUDQpOgwJHy6z42A0pRixYG7xmyX1MIFvfvX8ehUXFNbPxTyeo6CiGfFg4NyyTs
	+qEyaO+frMz3BholgVW7LA9G5cNemczymQP7ep5wgpJi3/hHrpyM2oFrhRMt7CWa50I+zGrcKLQ
	JaIMVSjNXaBhHYgoAboAih9A1Wdm+Rg3MqFpXJ5JLFTLnkiC10AQq51XLw7RDiOSXemkMRpgaqQ
	2lnElttQmnR+0LZUxj60w7Qn7tYcpkt+4lw==
X-Received: by 2002:a17:90b:4d86:b0:3ad:4a8b:c6fd with SMTP id 98e67ed59e1d1-3b41c93b159mr16040203a91.28.1795661304665;
        Wed, 25 Nov 2026 18:48:24 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm29193554a91.7.2026.11.25.18.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 18:48:24 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 02:48:23 +0000
Message-Id: <DN4ST2VP3GVF.GGKMH8CNILM2@gmail.com>
Cc: <bpf@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "JP Kobryn"
 <jp.kobryn@linux.dev>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mike Bazov" <mikeba@sentinelone.com>
In-Reply-To: <CAPnbwjpLcyJF70D5j-q23L3TQSFXebB_RndQRmDe+_5h02YazA@mail.gmail.com>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com> <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com> <DN3Q2CZJSC2C.IM2EYLF1NR9X@gmail.com> <CAPnbwjpLcyJF70D5j-q23L3TQSFXebB_RndQRmDe+_5h02YazA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 04:03 AM Mike Bazov <mikeba@sentinelone.com> wrote:
> i tried it, it works when the run that preempts finishes first, as
> with bpf_timer_cb(). With preemption it can be preempted too, and the
> preempted run can go on before it ends:

ohh right. save/restore works only when the runs nest.

> A fix for all of them has to change how may_goto keeps its budget:
> lsm, cgroup and sk_msg progs never go through bpf_prog_enter_run_ctx().
> I'd rather split it out of this series: v4 takes may_goto out of the
> mark, so tracing progs behave like lsm ones today, and a separate
> series fixes the budget for all prog types. Does that work for you?

Makes sense. Let's split.

