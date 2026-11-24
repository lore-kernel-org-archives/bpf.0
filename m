Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552010;
	b=UOd/wJRTRyDBpkg6YItpNzki/m+HHN9AwX66R7jsXt1Z1cvwU7K91BH5qqcuOuMM0u0a
	 RpkFXnuf+udTVPr1j2E4eDBJeylMZSsQgL8AYerTpUyjAQqDKQsnHof/dE9xBL6FZU038
	 UQn2hb859xaqkt3r1W24dZebojDwtb7LD/6zQ/IP01e+GdTUCr20JBLdb7mwhepmcBdVs
	 IcZoKSGKgi6+eakx7MGm/uB3cMV55rZV7okm8zfDmaap8tOMh0RnzLZGLHWiOYfk3rcbC
	 ZYCpXB0mL/DDZ8jwBs/HN8RI/0X+hNp3AO7af2HpA4gGIeja3s3RYmr1+GJq49m3mLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TpDTZc9RdjJDO+TUClWKBIl76LjEpAqHQHkgkZyC8Kk=;
	b=sr6HxRxRLUjFRF70e1HpKfYE1GC6aP68cuTgz9AXMen/RudksD1w4/GK3Mxyt89fLlA7
	 ggyGNIh46HajhlTiqhqWuLe/4eQPZw/TjBIHMCYe0IpSINX71/XGJlBhImJDqmmFLJnKD
	 K2/LuOu+67w/Tp/OXuari50Dd7Llzz6+1uddK/JdBvUUbyYG+VmWGthl/cXtUsCoOdwjK
	 EId01Aqy6UDLZxxZ9XhgHfPD2GPcF5ppormzGlxi8B5e3AfTKrVfDrHYRG2QS2b9tDDZm
	 HEYDfs/W6JGk2XTSWKbmtp6pZ7zRlWWytXHZRwjKQwIBsp4rWUDJLo585IVVHHobTKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RH3wZrOn;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E8606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A94E8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RH3wZrOn
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cde4b4e936fso2626658a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552009; x=1796156809; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TpDTZc9RdjJDO+TUClWKBIl76LjEpAqHQHkgkZyC8Kk=;
        b=RH3wZrOnD8/J5IZZJGeH0hoDkDf988zkanaCwA1Tsncfd6yJLnI7GT8VASabnTVm3n
         cu9khA+ifG54cQwXUEXrgimg9Z53nRntZJ4klgrJxDo/u3wXAOrhsXl1I/xtHOwCD0e1
         fH6eYKUGPepX02V/2Pk7q5l7y2P6luUm1io1ge6A+6JDbDu2/RPEyQ0yKFVAHkQy95VK
         vZcyY57Er4XzGaqFd47a5VDn89fr4Eox+KjRAw1MGg/Op1Ccl00Rp0HSClnrZXbJxifE
         +ZGAVFkcspa1m/W4E+RegDQcutmUhxkS3jwk9WF1ymVKmRI0J7+9j3+IEX40mxlmGmVL
         BaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552009; x=1796156809;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpDTZc9RdjJDO+TUClWKBIl76LjEpAqHQHkgkZyC8Kk=;
        b=uPnbFNH53AtFCQXZJFFUzx2MkKF0BZhXI0Kmp7lvZc83o2QE4Y3GWGArewXRlGgm1J
         BmmrvMUBJXe9YPNN9u8inF/ReXL5uIydgdGpghFk3wmPOcOBBpYZlycpIbYGKvuoGhn8
         OY5rhfr9sO6IQ5WdIqsilbuE2i5uSE/NTElvMqQ768aEWEGuCMfkKFCkiHVuLIzo+5Fn
         8XJ45N5ExyjYiQgOI8mJIsh3ZZ/H4a7LnGKtqtzIStaM1nlxIIW0hamtIErSHgRSbi0Z
         cepJAir2IhZJpdcOJTV1FBL0gNANwErWhU9Stq+BmrAG8HUtmVQb0x1TmRvGzt0DmB9l
         R10A==
X-Gm-Message-State: APuU4Z9LWsMAvAcCdjdCOH6Ste2RuXWTKT366WnRn0moTfForoFTOZ22
	6gkvsAkCmJnIS2FLQn3EVhK6fcEQbb/pddCF+6gE1HNPLHLHqW5qkDrUZ4bi8g==
X-Gm-Gg: AZFdTZcFeXaHzj0UolAP/c4spfgHO2ei6fPAN94xgJiEPakVjqxmmjo5EhdGiPDphoD
	tFId88k1iFgtcSe7ApZRqoZ3vmIrQ3aB3lPYF/LqJPTEn/0L/5xeg0QUt9ZTPfzeBjRexwpPJTU
	/eddu0r0ZN/wYtx1mQyvUnjuJVZ9Z04or5Emvz2uOiOr/XIhO1AhECu2iZTrrnjxYYaJ3JNsorh
	PJY6XjPJIWP6t9j7S9FHcGSTkbyI6XqiLs6gbOJyadqYrE32eiFfmuKRNmJjXTBT/8taqAFEGjU
	wZa2V+8bAZKELM2lq6ra6DgIcXIutYioaRMQNaSOEUq1cBA3QIrxIfXV5q2TkyWQHjSNRm+jRJj
	N/OR7h6tz1Ufh0zCis7ldtrNEGiYSB9xW5q6V3bWy26Louelo6sRAY3knOW0eOHAYFLPNXnIOMq
	Jxjw2ljc1hoLrXgiflJyrmzoTptVPZdK3FPA3Fr1lueN5xjSCq0sMco2DJdjezpoAuii384Lbql
	lwZGYbeVB+4Ifw+E6Dm+tXQq1VmMjdI6z20Qf+D7RM9zo4XIU9KmwkIjyWW2S0emYg1/k/ZNBlf
	BlzhzGqFvZ818Nl0lH04qqKStuBtW6sWmWePk9fJUD8xcesv7rkZD3rxpLwUudP7Bf2dEtpCdyZ
	0TJMnN8Kc6dhV0CwB/sgoAvya+wTWEcqqCjU=
X-Received: by 2002:a17:90b:5289:b0:3b0:9bfa:72ac with SMTP id 98e67ed59e1d1-3b41c908147mr10850061a91.21.1795552008788;
        Tue, 24 Nov 2026 12:26:48 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm26712524a91.16.2026.11.24.12.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:26:48 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 20:26:47 +0000
Message-Id: <DN3Q2CZJSC2C.IM2EYLF1NR9X@gmail.com>
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
In-Reply-To: <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com> <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com>
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

On Tue, Nov 24, 2026 at 08:10 AM Mike Bazov <mikeba@sentinelone.com> wrote:
> Timed may_goto sets the mark, so a may_goto loop would run with
> preemption off for up to 250 ms, which you ruled out on v1 ("with
> may_goto they can take 1/4 sec"). Move count and timestamp per
> invocation, in bpf_run_ctx, so that may_goto needs no mark?

Well, since you brought it up, let's fix may_goto overwrite issue
as part of this series.

may_goto's count and timestamp cannot really move to bpf_run_ctx,
since xdp, tc, perf_event progs and async callbacks
don't have it. In bpf_timer_cb() current->bpf_ctx is NULL or belongs to
the interrupted prog. 

Keep count and timestamp per-cpu. Call bpf_timed_may_goto_save() in
bpf_prog_enter_run_ctx() and bpf_timed_may_goto_restore() in
bpf_prog_exit_run_ctx(), like bpf_timer_cb() does.
Then the preempted run gets its count and timestamp back.
For progs that enter this way skip this store in bpf_do_misc_fixups():

  insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);

With it cur->owner == saved is false and restore does nothing.

