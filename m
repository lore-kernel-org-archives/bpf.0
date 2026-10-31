Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483758;
	b=BO8WQj8hl4Xq1CaKdA424McHheD9BYL806mdlHZ5aht8iajjzBY0K1nlfIRd4r+yx/L3
	 BUaOyYkCpU3J6FFWrTtqUu5vy3vZTdusP/UOvOrrebAATG5A7zYdFCDFzUZlhAWntNLhv
	 4P5yc/t3WiZHhs75/FPNbBD/QEqrkeuYYJ9JcL27kmfDNyWggmyGBi5oWkReo1wz7s5BD
	 KLftqP6B41uEHBV/+gG+/F4aGYkVSIhnEApc20LIUvmVMREGVmRdosIcfAUYTI+ju44Ju
	 f/YEHTkRnaSWG0nWTrdPzSI8hhLenjBDL5287tFSKAlbWlofWpJ+o3N1n9HV/AawFyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wDSVlXXj9Bsrc76r4zOIREW8YPuhOLaER4w5brQWvo4=;
	b=Tzjv2ey68PNuWwn4daRu4yNH2V3h57wVdCd6Jit2fqUhesrmgjR3qjniHbAjqVIL6jWN
	 qtuRzKKG/26aM9BjD+8SlYzgNh3frNyXvuXn6XketMbdVYVa8BRvs2q+FGCs3U1/AcJin
	 dKAPrESX8kcTdccTjzjQnjLMwF+XZMpqFGv/LECGeHjvSA6h6ds2W13M0wPqlwYgLgfrp
	 LmI34XqriQM0RfaQ9uYT5GxR8RmwNxE1nFcYLgmOsDnb67TRpX57+d17Ho9JrF64biH4w
	 CFOwYsGSa1cK1mo6gbWgxC+tcmdQ5GgP37/AP6N/MxjlMMsLQkzjBOlI16jX9qjAQRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BDFeGHtH;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50159606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50159606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BDFeGHtH
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so1547652a91.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483758; x=1794088558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wDSVlXXj9Bsrc76r4zOIREW8YPuhOLaER4w5brQWvo4=;
        b=BDFeGHtHTL9cBqb8hpx6Z4G0xCNcBKqp/aR40rqhkGDHnVhXmbLlKYjLHdgLkpj0xS
         iKgGeJqGCho02g/sbH+J+tI18FDqBFUlUXCloazyuX/TII85DhN46gbiR42exo1PP/xz
         gsA20yyT9bu5MJPGn3rL70uD/5iFoaSdm3Dg3crpE+OppdV3GxZ+V/Zsni8p2zoihZeG
         5UcY6rTKXb+nE8nngzHTWaXRgdNSKt8olouQSOD3z/PuHLKJxmQpj9vMLyTN4eaQrMcn
         DixwWmmqCUzqZ1tVG2UfAAY1RVQ0ha9EpDKMP0K8Wsb30Xk2aumHjDfQh3o9ALiEIviX
         Q2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483758; x=1794088558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wDSVlXXj9Bsrc76r4zOIREW8YPuhOLaER4w5brQWvo4=;
        b=KTHIJUk5mva6+iQZciP/7MTfDatEkw1Kf6oKpIV1sm60JiILbgmbiwVVXkZSaIFiQr
         m4JYpVfWxJLO0UFTBSu0c1hNP6I7cT4HFs7UlF7C9paQ6IWfPEzITKcysDy3pCe8lEPM
         x8o6EHuXWr/ki1WGSVhb5xnl6cNVQgrW9bJwcUky+578S35BiweUGHZ93tmAk1qaWcEB
         8yasbabH731jHgQi8RJMOuIBBl/MXP/X5+EXp90DRQrOFqAstJEWA2ItsVGpNWb0JmbK
         Zzyy70U+b3MbxMAN/HIODXERBkXO6q2zvh54Af+cWODThrhtViOqFX12CHW95ft1BPbw
         RgiQ==
X-Gm-Message-State: AFq9FYIzwTwmE4WCGGRa5HF5MIGuIUMksIEpjsAapMfIyx8o71C07LWI
	cZ5hgDyVoOudL26ax3tqFYfdhHkqjY5oTWhCbRBBB9CW9Z4pR+va7XoX+/qv4Q==
X-Gm-Gg: AYBFou1WwMKI8XXglj9HUtv/PltuY3ZwTgz3/N2pSN2QoK77RI/cQIq8sknOvk0mlGc
	GpA4+k9JSOsqRB609qxXjyxgPAdn7n+yBqb/BsW3uN9jcuta0wKT1Bnq3EILcS0hCCTqMzc5kpO
	BrYmt5rpFwIu96+rnSp2tyWNiBHYJEz5fsYNacGBGNMWkqnQlyut2kyl9FA3LqU/+qekb1N4qfD
	k+Ci4knUNg0AJqS+wDARwRILH6+GYqzgINsbXZ8CndtWmIzPHMsz4hVyo1CpVb5oiPopyl5anSf
	Z3JmyTDx3pVhLAJcPB+w4390ke8nBM5LaN0vVkkVaXMTCrjkOr8uZSGem9NYQnR5twdau1TXrBM
	2k3zMv03wrVvHMnmIyeA5xnJS5eN84r6YoIXafHC5Y5AHDjXU3Um42n0BZ/yA2fVM09horAKLUS
	4s55ynwREdnnMLjc69LO1AdulizhaPdzaT+pJjl4GvxImj4muKTLmEgKMeqYUxz4qcmqpTCFDuP
	Koq/YFKCbrGRqfAJJCe1w49ngK+V3BtoZjE6SLXTmktvhd3x7oHO3EhlW3BnMoRrEpw1KbjREy5
	+KyKQu2qS6JPvhvfYR6M0boHsB1ClOXhogOw5PmAkjnvmBGjuDGMyFGN5S8BrOrbXjpdmujeIJs
	L2ADn2I7MbLpV0UwPyZZj2RgFJ6dA7ssekIUaoy6a1wEF4Slp+03JcdEJdkpnI9Kyr68RdTnupA
	==
X-Received: by 2002:a17:90b:55c5:b0:3a4:ad5c:d48a with SMTP id 98e67ed59e1d1-3ae8987e75dmr5445306a91.67.1793483757530;
        Sat, 31 Oct 2026 14:55:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm12761032a91.15.2026.10.31.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:55:56 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 2/9] selftests/bpf: Don't cast a pointer to .bss in arena_htab_asm
Date: Sat, 31 Oct 2026 21:55:36 +0000
Message-ID: <20261031215543.682284-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

arena_htab_asm is arena_htab.c with BPF_ARENA_FORCE_ASM. In this variant
__arena has no address space, so arr1 is in .bss, and cast_kern() is a real
insn. cast_kern(arr) turns the pointer to .bss into an offset in the arena.
Each of the 100000 stores to arr[i] faults, and the fault handler of the
arena skips it.

Remove the cast. In the other variant it is a nop. The prog takes 67 ms in
place of 950 ms on a kernel with lockdep.

With one time slice for all may_goto of a prog, may_goto stops the loops of
the old prog after 250 ms. The test does not see that, because it looks at
the first keys only.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/arena_htab.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
index 81eaa94afeb0..80cc14bb1c0f 100644
--- a/tools/testing/selftests/bpf/progs/arena_htab.c
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -34,8 +34,6 @@ int arena_htab_llvm(void *ctx)
 	cast_kern(htab);
 	htab_init(htab);
 
-	cast_kern(arr);
-
 	/* first run. No old elems in the table */
 	for (i = zero; i < 100000 && can_loop; i++) {
 		htab_update_elem(htab, i, i);
-- 
2.55.0

