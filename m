Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376544;
	b=zjTEJkGO1ur/c9fwCVuWFjtjtVozPyZMiwDiJCQCqiU2aLEZnj0xSoCbug3/F4MUHtih
	 CkBRYwbT4kfoHpzjHv/nAx3u7SJfgzu5019iJ0Wyy4DsBcLmYKkUVA3cNdLUWkztck8Gu
	 yWa6rhi2QB9s5zB4QB0c1mDY5VNp+yJWEEfBQAhxocVO1Dt4QyTZE7P/MC/eAy62hOdzX
	 H7q8kw9UWUCr6qk5Gmi8E1LNCAB7Ah6QctbxjGyMDBjryvRkq+pY8vDFvLIZ4cGFfxumW
	 AF1ejn5kaSDeqm5lrKOgduhz4AsNU6eKil9VcwLoru+DMfTFAbPqi/SIQdCSTTd/Z5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=maHzIxiaoXc4+gcip25itE7mLfNd2FeiXw3rtdr70PU=;
	b=Z/AmFt6QtzY+QFAIPXk3t49ApDJWOhI06I4Orka3JWigmz/0l6ZVtVRCZlP2HayaKHVC
	 FxaOkddjZvFNcDzuKpErC5t0eeJTOGNeuwJI0DE9AVwzYYtaCJ1lVbPMj0cuRXTl+1sb6
	 V5TiF0XkPXupB6MPJ+wivFO1TbH1+/UDC3I0nX+7OX+t7Lb796nG7jIa/ybTJ3qB5Oc6T
	 hOPE1syjORvIWroZ5KiaYgFq6OPU4Teb+Bt6wIlsxskROA6ogAlAcsgtVgQbbUHgYCx4t
	 t0Zv9ZU4I1BoFxAmhCuv+ROilS+9obCWbiN1OxWz0Gp7m1g022OQ8fLp+UCeUB4tgzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lukasstockner.de;
	spf=pass smtp.mailfrom=lukasstockner.de;
	dkim=pass header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k021m9+g;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48685606A31A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 19:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48685606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k021m9+g
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so18986105e9.1
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 11:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376542; x=1795981342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=maHzIxiaoXc4+gcip25itE7mLfNd2FeiXw3rtdr70PU=;
        b=k021m9+gvs3kB3y5uYWp7Jr4t1X9sPV/lAT7jhS2mybde+sy/n5iU+WXBVC8ErTEN7
         JXb7KRymWwhO2kih2yMkY+oT23hd67By30k22LcSix/9wSDYw63SxITjn5mDqbmBWoPK
         q/+IFuoJ/zTr1PNu6/kcArvj++Tyg6g1bI1r/RZii0LQ/W3nIz/FPDDHw+mcESngwgMU
         wTyrotjP3I6atPk3m5bf3jtlodz9DpSmjPK23xxp1JgQeCct91bhGlh8dKiI04LaP7v6
         jlVRIOEROTbxzjL6AVL0Lh4Ec/k89JVhotqvHAWYxYpUIn07xvcbFbjHJ55O0mgsDMxS
         BnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376542; x=1795981342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=maHzIxiaoXc4+gcip25itE7mLfNd2FeiXw3rtdr70PU=;
        b=I3zHkHSR+oqX+8ad/tQMFw4/aJ6+Tg8YG4mI33FzXUXeUHkHPXIZpegdeWKsKd1igx
         SEHAxlR4zV8iacqzDA10bokTnsC7SGsht6zgJrgS4CUwt+ujlaRCRSnHOzu9OFPlceuj
         9fFqZZuuSBRBwJo2kwRUc0Xa53tNJr23y0soryiikcZeEll/ioC9MOAON3HNnSgXCbqF
         UOfLIT5SQnCKGp6kDuf2iK/jNAR/ZzyXTrMiZNScnxxgZ8fPd74gYg3sOGmBaO3vIWAw
         xjIJGNUaakwdhLzVoQV6MWeONsw+nTR+2Jffx6tgvsCELnTw5hsdt77l7dWsROEaEYDW
         AhWQ==
X-Forwarded-Encrypted: i=1; AL+hErHWGWWAzvaGijgElWYlYSilq8vzQxPakGWdfwtV3I/DJ6jWICeyDWueGqglfVia8AdZWXo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W2LTncnyoQqaESChUCj8CEaQ7brgYFzr5wQpf0zwpoKRixka1
	8n8UEqciv5iby9BGlFmiWY+8rsUYuKf01ZN+VSWg2WdMXPfFCl2T7hPC1YHEgyTXV0s=
X-Gm-Gg: AZFdTZeY5fize2UJmTvZsZNyTKY/H0Z3C4AJ4JUx/jf0wrNq5M/C9jB/eELRnMQfgwO
	0fTFg12TJWlB/xVQ/buoqhbz1Od7j214pL2m3cJw3sG3g9zXEyRiVZIISZimqqimkAvTeIFR3T6
	L5cEuSwg3UemZ933ub3Q0tOymnAKL+U3aIY93Gx48EY3rQbTL37rAdAv7KBCGcjJsAj7PGrg5Tc
	RwTsyNsLZZA6LEMPII+Yl1ApcsEcPsgSf1g7P1HQMhfAuV7X5cZ/ZNkYXlUUmIXe1sOFhlnmLwZ
	BhdMvVCj3Ia6pWHUNZkIR8en6TE5oH27sKZU0E7JfMB699Q1TbdX8ZpXVlriqZ+f4zbtzkXe0FY
	+ol8bxKxsV60gpKDhO9d+xfoNrvWtMyM5kvlqP4b6bh2FoKiDL+GNFQT1Kx8Wa1EB+e1YCUpmIW
	Uf2km8ERkybGhBgCR/vGz3245695spem6UEBoYPiS1BBb9ftwphZQWuhsejs5QTPUWOOJVW5Vkq
	5yRwRc1SZRKJUx9FMT2ONulJDB0efFNtwhUpdyVHGvnKLy+Ei/KogPaBmV91//rl4ZcVj0JHthU
	nIajdHJQDBw+Eu1BWSdBQBLE5HPXApEVnGFaHsvt3qGe/Tda0tAMflfYszkfWs3h2QeH5GDpJNz
	R
X-Received: by 2002:a05:600c:a085:b0:4a5:26b8:4507 with SMTP id 5b1f17b1804b1-4bb8881e6c6mr204049325e9.21.1795376542396;
        Sun, 22 Nov 2026 11:42:22 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:42:22 -0800 (PST)
From: Lukas Stockner <lukas@lukasstockner.de>
To: Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Lukas Stockner <lukas@lukasstockner.de>
Subject: [PATCH 0/4] powerpc32/bpf: fix BPF-to-BPF calls and instruction folding
Date: Sun, 22 Nov 2026 20:42:01 +0100
Message-ID: <20261122194205.218543-1-lukas@lukasstockner.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes four bugs in the 32-bit PowerPC eBPF JIT.

The current function prologue/epilogue assumes the calling convention for
main programs, while generated calls follow helper calling convention.
Therefore, patch 1 makes it generate a helper-style prologue/epilogue for
subprograms instead.

Patch 2 and 3 are needed to fix the additional arguments in subprograms.
Currently, the fifth argument is not being loaded in the prologue, and
all of them may be overwritten by register reallocation logic when they're
only passed on to another call.

Patch 4 is for the 3-operand folding logic. When the second instruction
uses the same source and destination register, the current folding
doesn't work because it will end up using the previous value of
the register, even though it should have been written by the first
instruction. We encountered this for the case of verifier-inserted zero-
extension MOVs, but it also affects other ALU operations.

Testing:
We found these bugs in an eBPF-based CLAT program on various WiFi APs,
where it would trigger kernels panics on PPC32 hardware (e.g. Enterasys
WS-AP3715i with Freescale P1010 CPU).
While working on the fixes, I tested in QEMU on g3beige using small
reproducers (generated by GLM 5.3 Flash).
Afterwards, we backported this series to v6.6 and tested it on the
WS-AP3715i, and with the fixes applied the CLAT program now works fine.
A previous version of this series (before some cleanups) has also been
deployed on several APs in production without problems.

Lukas Stockner (4):
  powerpc32/bpf: fix argument passing for subprograms
  powerpc32/bpf: fetch fifth argument in BPF subprograms
  powerpc32/bpf: mark all argument registers seen in function calls
  powerpc32/bpf: don't fold MOV into instructions that use dst_reg

 arch/powerpc/net/bpf_jit_comp32.c | 43 ++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

-- 
2.56.0

