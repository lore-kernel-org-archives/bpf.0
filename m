Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792869059;
	b=t2H4kdwFKaNuUivDmQWHhHOQ+pJzWtYPeJ1WHRJV6x9Co/oTm32SCEr6Wd7ffegO1QjJ
	 UUaOlIZeITRwZfHQTF4tF8hpRbk4R/eZhj9OYe9yhQLPvQW1ytF7TvzEQJx7ikayTlDCe
	 cJxmxphNM5+rcfDKbRHZLgrXRMWsCBFP8VMul1sSNdV0VTmPfE7heZH86zopyZXwkhbgp
	 IW7+yP5mzD/SNFjBLzeUZ4K2tWw1Hjm+XtyXDhV2/To+B0kyZj3QlnOE7b2dnlJyECQL3
	 hqJFfrZj5u3qJ7Td8QUCUG000e3m810bqyPyeNpx0nboiYpoWG1aHv9NbndQUskAGjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792869059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=nVucqO+dngc22ikE2zAUDlFuvbiER2Os3JrCGkcijHk=;
	b=HFsr6iWSEUgSCWQicK60wkkj0GlTOBaGjHnnUrsmBbPDrWO70SxwtF9y+TC3VeL56x85
	 3xs0sU1yK/RfPCP6mWSvuir00OJCLWZuwrO1Klhpn68a2Np6QvxiusawH5KPXsYBOtrgl
	 SO0Ya8terZerk/xEX7Utw1E2xByzxE7dgCUvSKxglNIScmhHeK1H3a5YsHVgUaY53x2Z8
	 Jk+4INoSg7H8Xy+3V0Vwk8apGpSaBhPisZbvsnc640A0Zj1HAbHNrMPMc62S+2l2RsQPO
	 1RVqXYYCgpQToxpEzSxvNQG8Pd8MX8nbIa1K+AtUmKDWLIZSpnHoZSGmdHloxfAsDQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dEFe+WJz;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6188606A324
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 19:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6188606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dEFe+WJz
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso1038667a91.3
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 12:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792869058; x=1793473858; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nVucqO+dngc22ikE2zAUDlFuvbiER2Os3JrCGkcijHk=;
        b=dEFe+WJzHB9ljtLNZVtVqlWxITP5Y8P2RxeaG649D1Ci4CTcqfcNvVV2iq9IUftbCU
         WY+vIM3DvEYtvcPxIF9tKquFn1KFXpU44fUuhsgPp7pj18uuyQcPoIVHndBcMqIwfgaI
         UrZ1i4srYzoHsr6X1oOASsP8j6twbxZGIH2u9jeEG/5N7BNR5jbqpK21eEgF4Y5MhVtl
         KvVJGMdlcGitXkOjlAvP/RNiVvfo9f8oNBvUN12XsqeqaMmmTFnrA9RWt4EXBtmDr3aR
         iT7vgRpqCPC9DhXrowR44cSGFO143Kf4tztndd6Llxddt1CP7csvK03BvKr6F6zcPZc/
         2X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792869058; x=1793473858;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVucqO+dngc22ikE2zAUDlFuvbiER2Os3JrCGkcijHk=;
        b=x2fxHJs2mqUgUMD0hHN20dDs+cYyyegl3iBjaqTB4lmme3e5NcXE7JMoKzY2sFjVgT
         yya4Kc2m9ZWH7KUaZJewcug76JU3nzEt3Ji9hUdGIXz3+HOGNhlufRPBzkDlBTfVEoUj
         CCIVYBZQX1o6XHOFLrOMPdUki918lziosIxRnrVZYL+rBkac3Qnbt2kvUdx8gkDvG1Yp
         ISfNjkBjWwCRyfOkpxrJjELjRGPFAh7YplhfmoxmKTkxRoRdGD8E6LsZRgMAz23+HigZ
         SB0qSYimOBPfEwm0VdwfIBZQWK/VKbD1CyUVSOd2JTkD1QPZN1oBLxz+ey3Hn5u09nsC
         gR4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxEsmoi0ne0bB55Y6V+Hua9MNHweM1P/M9OhWeUEVkMeLz/Tvn//tm87rSKzals0kuklZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0JPY85rWenaiYAig+B4pcUnSezbUXlS+fFSbnuCk/B4oPtoyv
	Ttf1oGWUjvcDtGL6xpp2NqLvdOBqO9p/udq4TU7T5ZoOqrIWbeJV9hpFaG4Iug==
X-Gm-Gg: AYBFou2GJGdpnj8TG7+sW8BjdL5feEj0YpFXKzG438p6V7sOPhC2M4xMnyfX9ovQzbX
	bamxTjmKCK7s/2QspJVMdfi2XmHNXGuxv6SxAGF7HMP9nS8m9qGOwdMfKKAXeYg/x3extdmhTXO
	x1Bh/Hcmen7gxMJGh/QYj0qGmXfZSIDQHsCMvJBbAyWmy/yu/NLSeGqjDGQiAbrZ19/4Unp5Zk/
	v1KmnA4FdBX4oIbotWdA2MX1EaE1OUcA5D1Y/6J9E1KgZD9dwAcGO5vF7iX3fMX6p0nRT8pmWWU
	X4DyNbp59b0AauUMYEwqkNa9hxOxjZfslF1/pYgDQ+B5QhpuNKHkej1uYBQiYqBwu7mIfmiOi04
	MsEW9RENunKZR+nsiaBf/wh+AOeeuRJJQWOSwnBSP7ieM26bJHPFKdgOcK8pb1tpx+wvUixjRmR
	VYDhYvzPUtC9/Oh2aQDkB3g+tdEG2LQbMANsD/VRA5PJ0hNEWhIJBAH1GJTUGV7n253ZtSuYABu
	lMtoz7roL1c5/TaFntDZXvMcuqpwIKX9oTcKSh6aFvmUd79p1Nmeltc1GvKR1jphlKxA2Q+Lt/b
	tYZIB4Ialbn6T6I7DSE0flHtLuHacWWMqhPhmCLroqpt+NujIKaR5htqNpS682z4v3OQPmt7VpT
	s6VMwmw==
X-Received: by 2002:a17:90b:17c1:b0:3ac:8af9:4a77 with SMTP id 98e67ed59e1d1-3adea8952f8mr2236502a91.10.1792869057991;
        Sat, 24 Oct 2026 12:10:57 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb27a1bsm3571909a91.15.2026.10.24.12.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 12:10:57 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Oct 2026 19:10:57 +0000
Message-Id: <DMDB1EESN4U0.KLEICFNC4NUP@gmail.com>
Cc: <andrii@kernel.org>, <jolsa@kernel.org>, "Menglong Dong"
 <dongml2@chinatelecom.cn>, "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH bpf 1/2] x86/ftrace: Use jmp mode only where functions
 are aligned
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <bpf@vger.kernel.org>
In-Reply-To: <20261024073712.1074591-1-daniel@iogearbox.net>
References: <20261024073712.1074591-1-daniel@iogearbox.net>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Sat, Oct 24, 2026 at 12:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Bit 0 has that meaning only for the direct trampolines that a dyn_ftrace
> record can point to, so jmp mode relies on every other target being even.
> Select HAVE_DYNAMIC_FTRACE_WITH_JMP only where it is, with
> CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT or without CONFIG_CC_OPTIMIZE_FOR_SIZE.

Disabling it for -Os builds is not great.
Can we fix the users of ftrace_call_replace() instead ?

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 17d6edf..654c3f2 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -190,11 +190,11 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	const char *new;

 	ip = (unsigned long)(&ftrace_call);
-	new = ftrace_call_replace(ip, (unsigned long)func);
+	new = text_gen_insn(CALL_INSN_OPCODE, (void *)ip, func);
 	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);

 	ip = (unsigned long)(&ftrace_regs_call);
-	new = ftrace_call_replace(ip, (unsigned long)func);
+	new = text_gen_insn(CALL_INSN_OPCODE, (void *)ip, func);
 	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);

 	return 0;
@@ -503,7 +503,7 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)

 	mutex_lock(&text_mutex);
 	/* Do a safe modify in case the trampoline is executing */
-	new = ftrace_call_replace(ip, (unsigned long)func);
+	new = text_gen_insn(CALL_INSN_OPCODE, (void *)ip, func);
 	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
 	mutex_unlock(&text_mutex);
 }

