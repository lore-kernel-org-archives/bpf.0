Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417096;
	b=B/YjLcWkHZEOZvwDJfqN04FHe0ULTsiJmpwDoyClm8gefFM0hQfO5tuyBfBzTcEsgRPV
	 f+iPamRQHXI60JDFQ/QIajRHkXw13oYpqqgNnPffcbRSHslhx+zfGfN1TlgWVfXAi+EaE
	 ++dYNVdZ1q2eu4eLs+9TI/fgXyed5uFYWIRgNkdHwVy41lSo7CDpyEjsvPeDU4gCln/+E
	 gJ3EGds4W8gpJhF6cP9wAHRIehwpRmcivQrXyRe7c0vjIFI+eufOq6+bwr3utKzcHw8qR
	 9jEdSlsHZBsiP+T7Bys9eYT5tUfo/HHaTHX8vck6ymGk0+i0mg3cSOIFCPdu1qOOv1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jRq81+OU1jcNW3QFiLfuhhBTEnv6dBf2fhUpIK5Uj6U=;
	b=3L/cSOyb6y+yXbD6vHmdbug1HKECB3kQKsoHdw7JpupJojbXU3n0iV4thougeYARmOo2
	 XYyqyKVzi1RaqdZdFI6w5HpqiFMgdYWd9plePS9lUbOJ9e/6/EuZxE272b4FvjTOtAj9a
	 p0vAEGXkgMqxbdv1v5gj/53dVWbgvfsk2X3Az2IIVaZavomqrHUwNYprWwAwzeoyQl8SE
	 kgMgINqTvlB/9ptc5xvpa4zP6Pp5GAkgxyPgROin9zrXUuThgx8RNJAgsH0eyqdj2BIN7
	 nXZtzQLALOnvLrHUOoK35ZwAUWULfAxCAlzZpvvxVvu+4KzSgU95mJLNB41GuwbxHWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XNbOmbCq;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBA606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 06:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BBA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XNbOmbCq
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1326206b3a.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 22:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417095; x=1796021895; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jRq81+OU1jcNW3QFiLfuhhBTEnv6dBf2fhUpIK5Uj6U=;
        b=XNbOmbCqkAF+hYMweAKFcFLcBVdACFhf0hQIGU2zoHp7NC0s5YNLPZdVniUmih4u2M
         s2xkTdVMmMjYSMMubg6LXJRtY22AN9Ng+00EkzOKdbIQE438mVdN2cJ0JVG7DdISDtA2
         4NnkLSg7l/F7qaXNqla6T+s3zCt2h7lT1zuOarCUTl0PV6Q+VA7/wUuiuHlJ9zWiks0B
         l0yMxSxZ/fS5s2G2tRlhGCDnmKXY8OCaZFBLKP5Ol1VYHVsIjPnS0TpSnexCLpKGpmnc
         s7Xv1iqDoWExOuvgdVEhnIjuuOTl63Y4Uqmh3G5hQ6jHJLUpYbcHkMJTk6/vwYD/C1sB
         xRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417095; x=1796021895;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jRq81+OU1jcNW3QFiLfuhhBTEnv6dBf2fhUpIK5Uj6U=;
        b=swdLvv1v2CYCWdmPG9Gu04A+BB7iiXor8RpvYzPJjgsRkpbnIznDdPu64d6+4KbHIb
         Qt69AMYgsfuLbUclW8rP5NRZZqRuUrvoF6z1ZWIxocwnEA7WJdSdZeQMqduAeyCImbdH
         gc9GltB1VhyPSMkiORisDpGmw8f0yzd7TudLX300rSLef0wUCFkAfOda2VF8DcheG0hY
         ZtRjhwALbr49aeBLpF9/iACctyD82pe8SWiKNG4dtJUE4HveW2chMzmmuYrCb3J3MSEq
         pXj8EumX+ZHuTRr81rrID0e9FxmPqBk/gTiIIGq7Xczqs0+L8yZEwY5xTtiO+llh47ch
         X+3w==
X-Gm-Message-State: APuU4Z+Z1wLwhquJpN2Sh8yE8aCHvdc0LxGVvPSXyDrO1j84ACZuZHSL
	u9XJi1VMg2tM5rq7WeqRbVwsU+OPBATg56Iga3tyvxMp+S1MBIN54efw
X-Gm-Gg: AZFdTZd4RZcJDEtamGdw+H7qkKHgpFAvjiBaOP/WxD50oR78RuNXcOyT3K2LSsOtCei
	gnlpfNZHFOYPUEkdaXuDdXfxJhbA+CsIqkW11xQixVh3tM6BbbdAwek5pH8hQ3oECuJagGbyfL6
	WXgh0Htl/5KsXpOdOgiZS6LIQRB4jUgaI/+x7Li8QMWOcqeu9RO/Pu0znC1dvx0DDgPi8pp122P
	N/Y7Zr/zllafy2AJq0NJotYmJp8zgPUTz4v8Di5Ck9EONkeA9lEceiPAHk22U7Iq7/HOaCBxTS5
	zzFAfQVDwo84vhfDEcQnXyDwm7jTSRAZsL6+HMlxYP7yzNI9Rm5DzfBfGai3dtTeS+a7AsSBuVf
	In/txCas+rFF8T+UrP3EWeMYejxz25mkS20c9885vQiX31WPpSObjMEHWEDy7MRXw4JKTANa79q
	gw44IhcvqveZdyyHv+8Kf0f/j9VsIxar6pNPsU6JTnKGiwyljN911T9qEEZfUUbCURhT1qwuLN6
	a2Fzp0T5aJGR8brQSC61R48j+4wsp6STlguGqcsGih4E89NaFazpH7YFiS3EXBflOiCXOBx5ytD
	s4wBXupVrrt9Tu76UlF8kij/qXTbn14oEnn+ZL39OocOFf7kzQsLpygAFA1H0EtduVj8Nb+x0/M
	wK4sZ26sFUPdXBliVXwoMTkuujnSP0goN2w==
X-Received: by 2002:a05:6a20:b40a:b0:3eb:b31f:3558 with SMTP id adf61e73a8af0-4014bc4a481mr9510489637.32.1795417094602;
        Sun, 22 Nov 2026 22:58:14 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c908a56acfsm4327684b3a.23.2026.11.22.22.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 22:58:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 06:58:13 +0000
Message-Id: <DN2E8Q9V38IF.3O738M7NGLSAL@gmail.com>
Cc: <bpf@vger.kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, <kkd@meta.com>,
 <kernel-team@meta.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Borislav Petkov"
 <bp@alien8.de>
In-Reply-To: <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com> <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local> <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com> <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local> <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com> <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local> <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com> <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local> <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com>
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

On Sun, Nov 22, 2026 at 07:56 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> On Mon, 23 Nov 2026 at 03:55, Borislav Petkov <bp@alien8.de> wrote:

>> "the only line of defense is for is_bpf_text_address() to really DTRT."

Boris,
SMAP stays on. The SMAP branch in do_user_addr_fault() runs only with
AC clear, after the CPU refused the load.
A wrong answer from is_bpf_text_address() can hide an oops,
but it cannot expose user memory, so your concerns are unsound.

> In fact, for kernel address faults, we already invoke it for exception
> handling. This change would simply extend that to user address faults,
> optionally for BPF code; otherwise, we panic as usual.

Not quite. See:

  fixup_exception(regs)
    search_exception_tables(regs->ip)
      search_bpf_extables(ip)
        bpf_prog_ksym_find(ip)    progs only, no trampolines
        search_extable(ip)        exact match of the insn

Here is the alternative

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index aa88370..9fe8705 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1263,7 +1263,16 @@ void do_user_addr_fault(struct pt_regs *regs,
 		     !(error_code & X86_PF_USER) &&
 		     !(regs->flags & X86_EFLAGS_AC))) {
 		/*
-		 * No extable entry here.  This was a kernel access to an
+		 * The CPU refused the access. If the BPF JIT marked this load
+		 * as one that may fault, skip it and zero the destination.
+		 */
+		if (!user_mode(regs) && !(error_code & X86_PF_WRITE) &&
+		    ex_get_fixup_type(regs->ip) == EX_TYPE_BPF &&
+		    fixup_exception(regs, X86_TRAP_PF, error_code, address))
+			return;
+
+		/*
+		 * No other fixups here.  This was a kernel access to an
 		 * invalid pointer.  get_kernel_nofault() will not get here.
 		 */
 		page_fault_oops(regs, error_code, address);

