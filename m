Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508436;
	b=0c3LtjCLWbYhqk2RUFXYn1hv8enoNxa+61iDu8VxN0niJU7MEqOXp1vsGm0vcKWBV3Yo
	 LN2Nk+pPUr1gviZuMKaKxdAJj2KsxG0RUa44Xuk6MIHW6E+EqqBD1YMSyE2ww0XWLIlxR
	 s6WMmgFDGSB5HgOy/hmJgiUEiB8vO09haGn9f/R/s3VuWdWM4E2XMw2mDQstNQvbl+zEB
	 7huyzYF6W1V0A5EeMy70Em4bB9zPMk4nWo2XZl1deCI92C3DAjniWNEkWIvQSiNHyr+gP
	 5VgQ9zlJjOBHUmHUPPW9UrWFSaB/GsqM2IblHFgztUNpM+TUIPmBbU/KCy3bxb6NRoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0T59pX0NBuc6eb0M//aPEdCc6M8d0Cv25oKr0gLdXm4=;
	b=YlPhgbSKsBia74ajmrIVwqQJapSgc/Z4uAW8UkZDh8+zkmaMsLiUFFdeI8ZPtRfkjr26
	 +CZvPMqx9H2sb1I11nSwrhyDxtTLnC7Ev494rxSY3UU5xOpiR1jKGbx2xrFUTU7pKFKX3
	 bf+iP1B/achbVnrk/XbZZcqqCm/fpxrOgsA7ciPlTYMq1QolmQ525I8sQmd9025zZuPCG
	 kGDq+Lgub9yA+jjA6z88Rs5UVhvqesmsgXYnBWz75L3aCyuMtL4B99pEpQG8ymeS/MfqD
	 3eJqJu52b6aEOY69yzstOC+zrfKSrPDGTSLcLdMITOR6TqOn1Lwwku3IQS3QvVDPsuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imxi032c;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC1606A8A5
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25CC1606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imxi032c
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c50604721c8so6042266b.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508434; x=1795113234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0T59pX0NBuc6eb0M//aPEdCc6M8d0Cv25oKr0gLdXm4=;
        b=imxi032cS0x76ZjKJFrnJjVcpa4j/RetctXMOzH/RAoNujK81/PGf3OD9XVYf06OD1
         vMOvSOHUE1wes4tjT1uZAJSvdzXng96OWh7uXcoizRID5Qg974oCg9DJKqHlfSgvn0yB
         HHIrjDSMWAnaoz6IMUo/apC7uFmgXX5uqLfubomxF6t6a6FERmpTCCxABUYjEawULXD8
         klCWqBM5uZl2TzEOtDF8+awi/vDwXsGP9mrDUvkQ3x3dvy2DALPta8aXV3ALMPfppqQt
         QWVUBf5h/qbYDOLqSp+D8Q1sgXktGZ452oL3iWWjvUjnOjMKtiaDUjnMGMQH8PY1ThWJ
         yVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508434; x=1795113234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0T59pX0NBuc6eb0M//aPEdCc6M8d0Cv25oKr0gLdXm4=;
        b=dHQU37rRrHCiJLGp1b7MhMSo0MbZVmoKliD6u51SmcxN48lj6sms4JFpJAtApAAQMs
         B7lj7lssC47Gb1sdpfRxqsPb/Qb9AcSSuynvUjdXL+0feDKH5qJnwyp1bHX9r1wKaKhI
         JzGWYEq35RxCi6gkUSJI87DKvycv/GfxbwXdqIES6t9TI04iUHvswA51T1kwGyhyfZVS
         clRtuHbKrYXwfAYI60zR8WUqZuaA81B6n5PkJYfpCEXJCSTLIjneg47DnfvQvY7BIr3U
         ucG1fi/U/QvNwwkFrBCsRzPxs9lp5jvLvMvGJVL+0lPC6gyJ7VNw42c/GP07qInuofD6
         zBLw==
X-Forwarded-Encrypted: i=1; AL+hErED8Ldj/IfUPhvNN4LUOKbsyvYThPYsVgfpz6ClRaQ0gQRH+yb7vi6jSmXrYVnnNi7pl9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F14fuvUmJqCKrtZCOwJHC+AXsBP8VcfsnTINkW4JnfUWnR2EL
	zxwxhyiCZ5ZhtQ4eZv8s5gxnQ8fkdZHKNJYsFiiGEZ/FhkwElJNUZ3rA
X-Gm-Gg: AYBFou0ZO2a/+aul1nYQW4T0idp9NpOmvUYWxYER3rOfQZP5L14xlL69ji8ajebbXXs
	bLKP1TMv1GMydRCLPUiamFN6NLU+DiyTV7BNwsgUhaMUJAR+pJFOYOI3Jw1s0uL69bt52Gi6qGQ
	Yg6RFQ5ZtylLON6q6XgUKCvoh1WwvDcTa0fKwkUmbtuSIiaGgXxJJZv1L3YPhZNcQnVNSI4puh4
	QqH0/EyrXtsO/37gQFhRssSyA3gJCNzoiq1uVjLO77TW2HD7pxJnljPYMpqYJTfSBSG193dqSEt
	NHm1TlyjsDxjVdBD8ujd3R1W0/5JYUqPppS7pHbRcusmFi6OksriNPNdM0JO00lEeutJKClE01n
	tnRw2qcU8zr6Es3ggawqIOamJZ2dp5fns2/QObFT3LIUAbk8glKcxOsokAOwif8lrhPJAVEGeWy
	8E8PGLluN/KsG26dXmmNEE/oqNnKbKsTAx4ICtaI4hYHj8DBn6EwYGgBh55Rhg1v2hbtxNv8S8/
	zs6GzaEsNQ+bIJFRQRyinRRzZJbGmLv2fvtSp3c/Tx2CP6Y6GHKp4Azg/ZSQLhk+7fI7UcoBDFC
	LQNo4zvSvbLp8uzP
X-Received: by 2002:a17:907:6d08:b0:c34:e9fe:82ed with SMTP id a640c23a62f3a-c50963d803amr9289866b.28.1794508434209;
        Thu, 12 Nov 2026 10:33:54 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b236edsm6328666b.23.2026.11.12.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:51 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 03/13] jump_label/x86: Avoid decoding instructions for
 jump entry size
Message-ID: <avYGjyj9-g5jugTt@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-4-jolsa@kernel.org>
 <20261112083945.GF2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112083945.GF2668804@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 09:39:45AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2026 at 08:49:06PM +0100, Jiri Olsa wrote:
> 
> >  int arch_jump_entry_size(struct jump_entry *entry)
> >  {
> > +	const u8 *code = (void *)jump_entry_code(entry);
> >  
> > +	if (code[0] == JMP8_INSN_OPCODE ||
> > +	    !memcmp(code, x86_nops[JMP8_INSN_SIZE], JMP8_INSN_SIZE))
> > +		return JMP8_INSN_SIZE;
> >  
> > +	if (code[0] == JMP32_INSN_OPCODE ||
> > +	    !memcmp(code, x86_nops[JMP32_INSN_SIZE], JMP32_INSN_SIZE))
> > +		return JMP32_INSN_SIZE;
> > +
> > +	BUG();
> >  }
> 
> Does this actually generate sane code and checks code[0] first for both
> values before it goes and does memcmp() ? The naive translation would
> suggest it does not.
> 

nope.. you're right, I'll make it explicit

thanks,
jirka
