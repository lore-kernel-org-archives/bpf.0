Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212729;
	b=U7MVaBnS2qgERBmuDpFgWkLnOOSdPq8IaKyU7qUzvlNr4Frlm7SG0ZXy7wkj2g5YenEq
	 c9Ghn9eqwvZfyL1xBf8BIToHMC8GsJxbOJLXcAIg3Aqwf4kJyIicnPIP3pPFMhyA8Rh8T
	 jaxbOqHXWzV3le6k6dUaYjJYrfamtFWOBx5hvcoMyYmWqcIFADf9dZvaVIhv1BuVEDH7m
	 ZNySvAZPL02ChzkSidHNH3r6DU4newZizLXxIAdQcEbjeD370ajh1osWhWUk7lS9fa81F
	 Vu2moFghUA2rYiMn3jBytMjGVzUz45WTBMBuTs2Uu1DuGWr9TkcFG3/gdER5vM5eoWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=LU0Y6smR+VyXGmLRdK9L1gsHW125um2nXKAEWmDt8ZI=;
	b=BVrBp2P8Se2gy0RfyCSooRfnZ4EU47c8NTbIwgXDsy40eTx7rFUGARZgrtCJbjbaSJwu
	 CV0lp+lw3+AIAZxLHHL2yIAvVSx2+obRh12FIcHoc/cASb/FY5azjTOvkxbp4qXZCR31v
	 hrcvXvTceRoNb0Mu42HDQBfTEYiXbdiRZmiW3IBQnSBjLBqOdcTdqlKqihhXblJqTeKLG
	 /ofVsS+f0FlwVDHB4v7mEGGVzmzSoYzxOTtl5CuDAa1bnNqlBOCz0F6u+Jh5bsOPpLoen
	 JHReSKwH2/9Isoep8V/jbZsabxpEEwj11HQ4VyNxpCA7WtpygvTa5Oy7TBKPZCi2zlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1x+CEj8;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F76606A321
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 18:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F76606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1x+CEj8
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso645108a12.2
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793212729; x=1793817529; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LU0Y6smR+VyXGmLRdK9L1gsHW125um2nXKAEWmDt8ZI=;
        b=Y1x+CEj8CQZ12gL4ejMsSqDKQWhAPubDjhaASv5iRG14SoNkqJXbsXBvU51IAqD7iE
         U4BGXOzdTbEAU88gbKMd4fybe66o7c47Dymgf3diePyzzqV5dt0mleRUIp/iuyu9VOyE
         rHeJPC4y6NFRSieBW6QBrhpsnHTPYCVQwcpJgj2dTEaNykz7k1VgwycObolp9aPetx+Q
         k5CJm4aJqIkZ71WuzimN/vuqq0ZGeVmLs74RqoqRvHsoTgpjKDi5yQGIi9rzQGT0RVKU
         mVR8VMwI680st8sLrQ/ZSLUL2KX2Fhg+jQcZbGaHkMtISNFsCSFDJcwqC5uBHtf5Y7xZ
         NgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212729; x=1793817529;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LU0Y6smR+VyXGmLRdK9L1gsHW125um2nXKAEWmDt8ZI=;
        b=aNbJeFGnh3xGml8czyJitedboun7MYookOsrT/dKh3/V7zHuVgl6O1DaSiMQRVym4N
         l8+9PjujzaFFKXn6l1OxgOsNWT3bAeMnsuiza6UTBCjAR5xm73UvmwJyOa3qGTG00NsF
         bpTIunLsfyAZxzRTmBIOStmUKPAXXY8nzJtqgX1Cu29INarvr7cgiXVfiKFOCxgbe+mb
         4g1Dc1/lEOACnMeaq8rLJBFSZxgDZRHJBxVzCjlyfS8/D79ly03rjopkEkzuFnxTze3/
         IpuwixhwF1RaIDQVRR7hQky5NS02DH0EPil/YESypJvdQjgQ9OJycN/SBcNWliPEkDwu
         6u1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYl2ouw4jJ+NGermypkWTzGBJ8+W9lVRWrhWDLIE1piFygQRCO0rUZJlIp2XN7w1TybiM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFIDeSJLU53tYzLOwao1nYJZX39ywSB63SffYhyoDzHXnODU3a
	bNX8gOUJsVTZJiW6kiu5Ms2JQ/YkOsXmt+wobUrvP+BB5BT5P9xcMHxwMsK9GQ==
X-Gm-Gg: AYBFou0YcwoxJX58J629e5YfeN/pOxkSoYDFCCO5FY7llqtxLwqaGFLl132I4p3ga8a
	KK0Wo0FRAzjgI+hunTNt57mvrkJHexpFjpBQG2J6tWDzOZeHEJrlA6PetD4HvIaWrUxrnZppOJe
	G13xBJ0L935nVgcO+aFfl9zqKSm22sDToBhW40UFltydpXNusbhfnbQjBrnDU+rut4x19FOQvvM
	uOCdMrwkje4QiD6jq+O2V0oZVzB8X/2oWRWTg/bPYvQUI/6JIYM4geiWWwKU8rLtdhNE9JHDQFK
	zQWTnF1bFQbIVIbdgVPAtrTeJDb7JC0q4z/LKM5ohZ7HFbFVCxym83mpPPuZrxihnd1rTP1JW4T
	zrKhHk6J0dNmLKPdnldzpK84r7WFbW/yi5VQM+AOnbOBsTiAKTDXgJF2tmeQP6SnMABe6JvaMhI
	pIo4xepOa6ej0CHfVeVmGKu5krrSpebNBTC5nwrUfUl0pH5wnzWmCq/q0CqV1irzdbseR/IDURe
	UbdXiLILI4gMDLNRY2vSdfZJinpMOZJo/ALQMLm1Gs6cDVkGXBVJ9oplI5qH2cithaUQaQmwXjx
	5tvpKigisKhJ3mZTouMFEJgiLXzsFacNZtJQuodDPClJbmO/XXJT5qqtMCn2nIab3bhBF0zd1qT
	XpYgv2wcI/EiSobopK2ZtPGxIMJOb9v5G1g==
X-Received: by 2002:a17:90b:4c49:b0:3a0:516d:9f88 with SMTP id 98e67ed59e1d1-3ae580cd137mr2392847a91.26.1793212728666;
        Wed, 28 Oct 2026 11:38:48 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9db612sm607914a91.17.2026.10.28.11.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 11:38:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 18:38:47 +0000
Message-Id: <DMGOUYN7S2NQ.PLCLQA04Z3VI@gmail.com>
Cc: <memxor@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 07/21] bpf: Move the division magic number
 computation out of the x86 JIT
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <puranjay@kernel.org>
In-Reply-To: <20261027182445.1156335-8-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net> <20261027182445.1156335-8-daniel@iogearbox.net>
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

On Tue, Oct 27, 2026 at 11:24 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> bpf_magic_udiv() and bpf_magic_sdiv() compute the multiplier and shift
> for the division by a constant and have nothing x86 specific, so move
> them to the core for the other JITs to use. They divide 64-bit values by
> a divisor only known at run time, which a 32-bit kernel has no inline
> form for, so they come under CONFIG_64BIT like the JITs which can use
> them. No functional change.

emit_div_const() in patch 15 has a copy of 35 lines of the x86
emit_div_const(): the divisors to skip, corr, pre, the second call of
bpf_magic_udiv(), the check of the shift.
Nothing in there is x86 specific either, and it needed
commit 73a5accbfd21 ("bpf, x86: Mask the shift counts of the magic number division")
already.

can we move that part to the core too ?
Then a JIT makes one call and emits insns. bpf_magic_udiv() and
bpf_magic_sdiv() stay static, and riscv, s390, etc. don't need
a third copy.
