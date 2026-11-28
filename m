Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830512;
	b=slemkuRIX0YwLouPvCnjDDorW2kBW1rIhUqCUj/0GgOA6c6oLedaGasSIoOofb0b3Sin
	 Xp4AHl49dYisFVQkZ5AWqBvkvMzuVlnRRuEejio6b85T1K9A9g5HfU0P3LCEpKWO+4mzn
	 YGZ1UAXj2WrzxMBy8tuP0VJXIW7bGo24q82554Yz2vqZDCnhBBDr6duMR+qe4JRWpPC0z
	 qOIU4ZqmlgPfgJgI442Srim65TWVF+Dfj8JBXbajS2jM3aQL1uuoAseCtdgHAj1k0iJYM
	 +sn4F9CFRY7MPaku7ZiRfBT+LbggFcHhhkVtX+lgwQ0BCT4yo8IQaJzFj6s5ibCXZYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=21r2hb/jryykCmBdAXC3ICR29YFM48iOqHSTEFvPQaE=;
	b=aZhhm+VsQM4OmlYlGV3bnI/r2kxJveEybZSIduEMb9MLBWg39xYr7i5E+V3XSeJfiYGR
	 xNO/HUjUu55VFlg1lIizqYoF5LRhuqqBDInqgOy8w3i9vXGaaYtKWF9HSwLFN7htsFkpA
	 K4wnhOThafQYjetrvUlJe9vOObWy2O6zQwQzBlLXIMZRKlj0bD+/jBmKgHLywX4pWphlM
	 v0nyC9Z+Ht5TjEjNh2GiLcjyELPIkoxF1dfhhuqfEekcNfUca+1kyEfc41C8zLNU9jIUd
	 bJmH++3/QrXzIatdHpQatN+1FaI79OqNTX1AWSdxFpqsqmSshODg1SFEbLtVdhEERvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PFCsrOuh;
	arc=none smtp.remote-ip=74.125.231.139
Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B0606A31E
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A42B0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PFCsrOuh
Received: by mail-oo2-f11.google.com with SMTP id 006d021491bc7-71b7aac1211so1190002eaf.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 17:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795830510; x=1796435310; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=21r2hb/jryykCmBdAXC3ICR29YFM48iOqHSTEFvPQaE=;
        b=PFCsrOuhKvYWkecKExagreSZMqNIYx1J9I4Yf4CUrLdWpMnVcm/nOL25IFScfnTlDG
         EbehVJaCCimcsR/2V1R7vnG1t4qDYbdszIYo7hyfrQn8m+Afr+apqdbHuknMNYo39Wao
         AcXet7EkLqfv91/xOUshEi+N7lscAIojxeCM8xXhdKGRn11ZrgKgY1+S2XfIZjkEV31/
         c5M9HmOkN/S8uafflqaubnEL3hWG8548wZiXvnxbYdzKxH6hY6SeXJS+aikJ0mcdS/3T
         AnYsPsFTFIsfOboi5rt+NK7/tezwqPdGkP8Co3XBJEInvKX3aUa1J1sbas/eMwv5MQit
         simg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795830510; x=1796435310;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21r2hb/jryykCmBdAXC3ICR29YFM48iOqHSTEFvPQaE=;
        b=vR59gWtJAHOtixLxpFtWF3K8EnOkmtmmacEpt/OPoPGV6PVSwOGVS+McyhsuOXRIso
         g2CNYLbfWLB/gxiimJRq/TL20AtIrBSsIAA3cGzOljoB9P5BF8D0eofiyx63OB9qrCQa
         5H1FekJYaz04l89jSH4aoneBy0jNIv8OIVjzKDinh7QTWPUcHJao6sSWNa0AYmSgJ0PH
         xT+g23mwERpT/Tbcus+NeeHdFYqfjgHRPzUaa0lcTXEOYu6RauUykzneW1CznYdP+gt8
         rc/Phei5JIb9/e/cJ1xvIRQHHYQ+rpA1EHNbLvyBvHCHq6nFaHJQXkVxZExe5gsJMP9G
         goUw==
X-Forwarded-Encrypted: i=1; AL+hErH2UKaDLdYRM9eIQsmJZOlJS0pZLRy/Uou4ivBRy8DM4IErPObj8iHD+BEGaF+A06S7lNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GV4fXTk5hhNuCWjchnGZRzx6Mo89iSSE0AErkps0fqJR02auw
	wIRZ8jW1Wu6A2AHB9VBimEBARTRRhDPFVhhq74+9IAIJwFwM00v1j90o
X-Gm-Gg: AZFdTZfYFjSl0R3vkxdta7rVP6gWTRsQr22h7OEfUgtjR9/f0VdPowI16JGbBintIz5
	FlhHojPnrp29/yPwGOEH2OAvw0PpTE18HSAIcPgWVIjM15DsSr/IIccblcpRwC/SpcXlsaDI/nK
	OIGYSu7/pIGsAEbNt1blBpnekehvHxltcBCD7TqcwKgkagwfeWdMhRwvLxydz9nKO6XaCGrx/Uy
	FpgkuHDYqoUj/Xu4dqVlhLg8fL+tBmi7O5/kMefDPRLppzwSlaJSHhfg9Xg4zdK9GUU+IKg6Mhd
	Q6y+27XFRBhnl3XbrrHUjSMCDaJkNwqxgzsQOH5r6MVxHqBFgoZYYvG8NAZRdX6h5Mit0JJ3WAn
	i3PswKKD8HUSKqC3LLiJiv2bjXwl9Bm/ZygrD6UvopNbsUNMIqmnGy4/MSieyFYfRpmZJgi7HEa
	DNOFfx2BVVxji1WpJR8jGf8sTDCODOyfrJdB2JcHGRclrTSDHq93Y0jtxcxQHJcMffFyuypchrK
	POFsc2enpxlFF1lwrEhl4MYKn7VH9UW50fZHFDmBpx6ihK1Eh1t//CLgPJwLb53bv8nZggdreSl
	9udnHF2yL7mSPTDwVSlXNwGyvK0haZlp8vVmIk2G9qLRIEeyeHI+/qH/VifHAEsZH4K0uLlH1iG
	GK4DUBF61lpaC4kqjKGU9GvGNi+0TGJqSDGOZ
X-Received: by 2002:a05:6820:f034:b0:71b:3fec:38a6 with SMTP id 006d021491bc7-71b3fec4b36mr20333111eaf.12.1795830510586;
        Fri, 27 Nov 2026 17:48:30 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:57::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380bdff9sm17750840eaf.11.2026.11.27.17.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 17:48:29 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 02:48:27 +0100
Message-Id: <DN6GS9V7A3HS.1COD0JUQQDHQ@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Andy Lutomirski"
 <luto@kernel.org>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, <kkd@meta.com>,
 <kernel-team@meta.com>, "the arch/x86 maintainers" <x86@kernel.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
X-Mailer: aerc 0.22.0
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <df69ab5d-bc97-4651-8668-a2b3e4bb272a@app.fastmail.com>
 <DN437OYZ5FGP.20VLV7ZEXQ5YY@gmail.com>
 <5f46d1c1-fdce-4f3b-9d56-675a822b2d65@app.fastmail.com>
 <DN4X9KVYMONH.VHKD1QED1BUQ@gmail.com>
 <03275761-8de2-41be-92fd-8e3012a87eeb@app.fastmail.com>
 <DN5K8Y9824AE.3GPOE0WP9ELFN@gmail.com>
In-Reply-To: <DN5K8Y9824AE.3GPOE0WP9ELFN@gmail.com>

On Fri Nov 27, 2026 at 1:18 AM CET, Alexei Starovoitov wrote:
> On Thu, Nov 26, 2026 at 09:30 AM Andy Lutomirski <luto@kernel.org> wrote:
>> Okay.  So maybe there should be a nice patch set to *fix* it.
>
> [[...]
>
> The main point that it's orgonal to this patchset.
>

I was wondering whether one concrete improvement could be to emit BTF type =
tags
for __iomem annotations in the kernel, then reject accesses on BTF pointers
formed using such walks in the verifier, so such programs would fail to loa=
d.

I think in practice, at least for BPF users, this will close the issue.
