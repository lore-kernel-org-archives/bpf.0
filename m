Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE73D3498
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786862438; cv=none; b=awe5z4Wc2YHueQ1TuoikL+AmS74u+XN435eIiWOJFJ74fHMTuc0HTiU5+y/7Ey9wtV+bnD5otbXnue1dZzZe75WYIAkGpUztmI1DzxbAK0aUWGvtYheKcmbLLPsi0JoFL79C7/kTq7XocFDqKesGH2iJN7OUUYkD437rEe7F1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786862438; c=relaxed/simple;
	bh=odpugJRcyKAsN4WjpLNXC2zjr/ZBxp7CK1JMAFjrIPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jNzimK1tVinF9Pjqp2afyz7YJo7CMSSM2PhH/aF+4InGN6wYyD24QOSkpSgP11ZKwfKiljYw4deCp3jfqEzGIYjooc2uzoytmp87PcGG+UhLKPUjWEaWS4wu8nhcIrZIRpAZaF830RgSbpfqBFMQRy5+BOD6KyFa+uQlCwNNOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewjXOke6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewjXOke6"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1926827a91.2
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786862437; x=1787467237; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=odpugJRcyKAsN4WjpLNXC2zjr/ZBxp7CK1JMAFjrIPY=;
        b=ewjXOke6lNaLebqapdX7ko5lFZNjBmPsKs7ittKwLwx4qVFKpnMhGH/sv88N6EAy2K
         KrbxAvBqID40Catlb+UKQMNJ6MfEwwBrjgWwe2hC2l97Hw1hA4TomciWgt538NZZdtwZ
         LK1jaY+D0puMOonhpDEx/cmDQJZd6geQV2mZFvk6QS8myROPQsKledfI63MaMA202Jaj
         sWPNUyKegFQKVSMU8ZLogCuL2aIFym1Wl2GVjOM3zSGvoIcimY+XdSiJC6GUCyMGoHSk
         xc4nlNByF0tMdhddmfhMw5+w/klm4+yRqx3Q4Je2+352r/mDXaodj+fwXYsbT6BUzt+X
         1LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786862437; x=1787467237;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=odpugJRcyKAsN4WjpLNXC2zjr/ZBxp7CK1JMAFjrIPY=;
        b=l7+D5HHtWF9MLutdoDVLV+P8LlBnoHQexCQmuWz/lQtRlf1HDiyS7mgqrAmANFH+AZ
         X29UBO5Ci3iwDXI/f8VA06TI8antttvXf7pB8YAtYW/EtGvvO91xUjimbr1FCjgrZKWQ
         lP/oe71K5QwSNoMZ8PeI0P54ZWlfJp3CBviKM3ivaVrujUWu6k0lJWulGb6s2RxP8Gle
         50nlzIL+FFsb2GVuR6dejIHnqAF6k6A1ObPQD2TbUqaDQooL7enjaAsl/ZviIRnQ9Kr1
         EPkrrZYlKRo9Fu5yrwSHK+r1/XROr+tINY6/rJznyvFiPGhCPHshECioPwv6Mm3W8wSS
         dk0A==
X-Forwarded-Encrypted: i=1; AHgh+RrDInFuHz5O6dBpdRlp35v6JPhcd0Miz1dVqbQoIua7yBy6wgsWKtwQ2SPOcnvfSrxwLLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7s9SBLPx8M18CjTRlgfg1kApbdOzNzsSHNhKc2uAisD/xahX
	rG49Itfn4ues4S7XS9F5s6ubSfVfMTe5N7blg+hnC+aTqo/qwKJZv3XO
X-Gm-Gg: AR+sD13RXZR+sX0op0JEUGEbHZshDYNpGgsWqQhPXSGn6EqhE7cEjyiUri/0FFsqzT/
	A/L/eF1YazDKdBEkkRMn1TDFLNjdweYlPeXYNocQBT5Xo31GGJdBb3XSH/jKM0HlFkYzylyKvOU
	VPn6lfeFB1bVpw0qcke5/lX0lys1P+4t7yeWX7s5X1NOaz3xlxZDXYEv55DVj4g6zQjqFG6xH6u
	iXarDC0S5ydI3/nfazNCyx/XDj0QY6mfH1VzpXiQSc54hbNVcAv3la8PxpCzNMlNDyQ9yLvb6v+
	OKWZehIgEwcStdcsIuHy2747eKVIj8WDQeVZ7hjz4t165nBpd4mAtprtXMGM5Mot2g6PDS3PTdO
	zyv3peqZMUV15BGgWOuThuueHVY+vQlodTpIMc8BSXJ1QThRIaWg8HYcXiyJHXgXAmWMrH2GdMf
	VzVUfPXPwVqaVluY21xqgrw/JkThCI/kvN4JGBD6IHF8bfFlUYw8pYcMpIAi7sV2PKo1AC8VXfz
	CdSab6OBtJgpIrxUD923rW2Poc=
X-Received: by 2002:a17:90b:2248:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-3933b87a743mr16195037a91.11.1786862436819;
        Sat, 15 Aug 2026 23:40:36 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3953202e9ddsm676437a91.17.2026.08.15.23.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:40:36 -0700 (PDT)
Message-ID: <f00742a12513967cade44c47a6cced73db4a5292.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 05/14] bpf: Use canonical stack argument
 names in diagnostics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sat, 15 Aug 2026 23:40:33 -0700
In-Reply-To: <20260816015746.2632990-6-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:
> The main diagnostic identifies the first outgoing stack slot as stack
> argument 1 and the sixth function argument. The causal history instead
> labels the same value as stack arg6, making it look like a different slot=
.
>=20
> Render causal-history targets in the verifier's canonical stack-argument
> location form. The first outgoing slot is now shown as *(R11-8), matching
> reg_arg_name(), while the main diagnostic retains its fuller slot and
> ordinal description.
>=20
> Link: https://lore.kernel.org/bpf/eb1be5327d136b7e5bd6d68e76fef6de20c4079=
0.camel@gmail.com/
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
