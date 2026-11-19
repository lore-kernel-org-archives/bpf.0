Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051085;
	b=zaI5HixTNmM7WxuJTD7zze1GuLn3FcBI+ugTX6ltAjya887mg3S4SZbLpz0bY23sShR1
	 XOngTaw3oIMkDuoyAXmLIuKlPFP9eh/+I9EZjSXp0S+zkwT7+feUUwRgxK+xp73FQ72Wa
	 QM/W8RwwC5NMopDkkWvs/VWoh2JMtHpm5i3zrIhSB5TK/tbGZrqTWOgKG1VjF/l/unH4T
	 j81JufZUbUNsI9A/z1gVLKtEuYIqg9PvJ31+ERv+7tS3d7vvwtlD7/TWdpR5CPSWGXfKb
	 zM+a6PwXEd9yMmMF/APkhWkTO59cQSltk5uHfCwsp6h/CwvQ9TcOatmyBwslDuTrB8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=IidocJDbGJXK47j+zgIJSmib9dFoFVHbL0vp9LH6UT4=;
	b=Fk+nGRvZFwKbDzCGCcnS841fqiPCjkWkJBJAQOcUP0K9KOQ6Hsd4OqxIf9Illl6KGBcE
	 Z26IjlcA6cy1SmIUxoT0HSSezXKHOsKISzlnJcUwKDmGpHJAWSs5cN0E73CV7Wv/yppuE
	 QHk4Ui7oNwqk0Zqy13sJBfcDZYGVpUrwED1LpGcOs8z2SoNcFp4fNfRenB3mWfixQwi7L
	 czb+1NjJ7NbYQTCqrxTnTryuFy7Dy1ukISI4ZxM9jNyuhQt+e/k4b8hqM5kl5jeg9+LZg
	 Y1CjVWu3IaMJwdfnKocGUgV1K5x79CIUeycXwJZ1hejlYd38vb4iOyUWJ66tYLzkATQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Jojg/YbQ";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CC606A331
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978CC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jojg/YbQ
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2efd7259872so9969315ad.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795051084; x=1795655884; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IidocJDbGJXK47j+zgIJSmib9dFoFVHbL0vp9LH6UT4=;
        b=Jojg/YbQOeRzdIBj/fYFrVukt/Ls5lmcD3GIUXCppGRqv7lbjgwn/oENJLpDieve8V
         bVKsmCrsy2wQSnCAS6ZXVPCQI1dLYQPHRvHtc3Q5JJJlGWSopr1dNRFskyxafkgaKhGi
         KkFEbrHK+AOEOmxxNVH+ue8SObZ71SgCVeAu1OkZxPeQgJDkdeoBvEQ3w8nY+r03XHLH
         0sYeRSUJujeK+Fd8sNjcbFgTwTWiUiDn32GpAMu+Ya5Wed0yYA+CE7c11gvrTUCg9Ke+
         S1F5shdZ7InVWMZLJ5+9thwOYBpXQv6jEcTVOly45bAvdLU2afbXNfBvz9hQZRYmk1fm
         hLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051084; x=1795655884;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IidocJDbGJXK47j+zgIJSmib9dFoFVHbL0vp9LH6UT4=;
        b=r1rycXxr+UdYYt5/qSCYWX8/iRXe+pY4MTNyhC10CCiykuI/SF7pGG3WVIJ0g9doV8
         o/eeerBl/Yc5fASec7JWDiXSyx62dy7KSQtNyKmYZcqyAGFyRCTwa6hJsIYdhRdz2W9c
         r4zABoScaX8jZzUDdu5PnZhGl1vCNbHKYuPUaJsrpz6Zvj50sARo9ZhRvcMY2FvHWs1q
         I6RDfP4sA0NHXmBAx7LREhOho24pJh6Ks0BRw3oiU7DwUvhH40Bdvcm32VLpoKN7Ephy
         eKg5YnA44Lgd5nNoZ0mCS9mojCytrFHgiJwz7aTZZFc6iSZVX99B7yAjHs1yCauLXFgm
         Sodg==
X-Forwarded-Encrypted: i=1; AL+hErEUaLTCwqiWd3Nr9bwVWmV5Fuvp1NZNdporQqdxnkM2VKHyWto7B2pvjbfJwyig8LF3XhE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lUp1EVhsINYRNp2q2MHg0g0omQqOIs96P2bcmJLhYr6/cbGBL
	2RwGwu8Rg6+8+zjbRCqds6A++zHqjBHUObLFhnfHd/zDOvrmK+ukk0Y1
X-Gm-Gg: AZFdTZeEJGKy1ank3MdPPf4bPVaydFIw+d+WBAlaCnNbc5Yp3M52conW5cWS5CGczEL
	s9QMxK7ZQn9+2N/zbw4FiQaO8GQ3A1Ef6UMx0Weu0LpwkfP8YrWO46q02pn1lTGlMdkDfy8QGw8
	7tYBaccQ5OoMREaFX5vv6Zk+NM6NeUNR1gs3mo5+WuvMTE3xpnhF7tpSrxnFRB3Tc1x35QAOdtX
	ScFz6+oDhqsyTu6qnq8tY6y6ZWszYBFAawnpRbrbk7Yo1YRanNZxVPLH5NR7MqS7p1wTi50WnNV
	wxC4RtkEp+nHe7/ymh2eicb7Uf8iBCZhpYXMnhlbEv3aWTRLryevehC+6Y5ad2Oh0sRjIJ9UE68
	Jyqpqmv7IOBKheSsWtV9u7ubkD1ZYpXnyXIdWa2FlsgnGNDCh8fCuyflHRrgMPH3u6Ov8STWhZf
	2gnt0h8X6/Wb4rnrl8QK+s/PeVOcllYDvLlFTSaya2M7BMZIOudVfMxXSF8EZ7EXv4nNIhJgRD1
	eOed6ssUo0Cjadzv6m55+HNZtzbjaFPYIvtPk7d8L1vwJ5KOO1y4lvO1/j+j5pVcWH3qKVOMjJH
	WlSrE9SZ480CipbT2PKwohOfXXSqhvOgGxAJoR83aF+4N05527VRWQsKik0Jq7NC9zedFNzj0wj
	QfsSK43GF1iUGLVV3oO2PAgjPwLYHd4hRTQ==
X-Received: by 2002:a17:902:d489:b0:2f0:943:1178 with SMTP id d9443c01a7336-2f009440af6mr27265855ad.32.1795051083737;
        Wed, 18 Nov 2026 17:18:03 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6182330sm20533265ad.36.2026.11.18.17.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:18:03 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:18:03 +0000
Message-Id: <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ryan Roberts" <ryan.roberts@arm.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>
In-Reply-To: <20261117172341.3152407-1-ryan.roberts@arm.com>
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
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

On Tue, Nov 17, 2026 at 09:23 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> The arm64 JIT implements BPF_NOSPEC with a speculation barrier, but the
> interpreter calls barrier_nospec(), which falls back to a no-op on
> arm64. Programs executed by the interpreter therefore lack the
> Spectre-v1 barriers assumed by the verifier. Contrary to the code
> comment, kernel-wide SSBD does not provide this protection, since it
> mitigates Spectre v4 rather than Spectre v1.

Nack.
In bpf-next arm64 has no interpreter when the JIT is built.

