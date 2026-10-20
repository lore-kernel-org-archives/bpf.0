Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538393;
	b=kNOLwIlKwxZ4dTh0Y+kPL0t9M3aLuJnYUAZahLtwPnE7KGmucH4jCRxUiCXOM0g0k3JQ
	 QAwUBxP2oQYMC5AKN9F6FHRXvexjFNb/LWmDozQTBX+9ysmrm7sC3tBcmZ1ENsAO/K8zz
	 kYnx84NJNzYobPlFlJ/rMIKNaH1OM7jBI+dxLJALVkX4V/og1iSRBHZenrNxw71zZBqHx
	 +sWXnV+hIZl0tkUdSy3zoJrZfxtqTc5cOmpinpWCqHFt71c+VVQVocvRy5ZcyqqHGTd21
	 lNw/hqQXDbb5e3OS6CGyBdIT9XA6SaUyiFaJYd54CzGu+T7AO2HseHUL0+puizdCf0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SG5BacMW/8GY1BLub3UBBtaXQ74qa466hh0xtJGHpt4=;
	b=1A+zEB8bRu3dMNJqI8r8K7Asi9b8wyYnHlp1stF5hbQXkLsX1RgIQyC7ogPth5+EnhUt
	 MDDVhxuGnjwgkgQl7L98TKXVvIPM2EkEFV+im5oty6lsZOOsizwgF75zWTHFQ/ILrnOFi
	 zhlT/X+rSJO1/UvU4gjnimdC7jJvA7c7b5y2ZTATTTaBGWghD31JLaXS0hWtRbzEcaClD
	 M9tuW9+Lgzi/s3/w18PHh/hejpOFpGpcpODv6Ag97X6G4g4+eIkzZRPZhDrrut+QBm8M/
	 fvaSnqPsqRKZi8iwDWw7FXFyJDiT4v8mMmiqgMY5D3irKJIHmnm5A3JtmNYY76Eqtjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CmWqHsaG;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1526606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1526606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CmWqHsaG
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab41538192so130929a91.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792538392; x=1793143192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SG5BacMW/8GY1BLub3UBBtaXQ74qa466hh0xtJGHpt4=;
        b=CmWqHsaGQzerc1iWckOZ3pHA6bpw7wjdEgmPolHa/uZwB3uoQ0RA+yCDY1Ma1ZHFDR
         RrIekQoA7JOO1P90M0ziJl0a4qjZdsGfeqxJlCIWqA8gdKq2opSJEPVZL5zUl3OOqCOw
         KIjnwLhh5vczeCE4o2jlITGeoqVPNMCzFVSHokfVPaLbwQbXgr8mN2m6nCc9C9Yd2Gzc
         XPEHlXL0w2UrIDq/RGIn5kh4qTkNUOYvkjlhKEFOOiH62f+4IwxRPvPEiv3Mrula52HE
         NlfkEJmWgDFodp+3M8fVYvGzZD5T+Nse/W5iow6UBbLsGrYTfwINm492sMapn2szeCRh
         R9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538392; x=1793143192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SG5BacMW/8GY1BLub3UBBtaXQ74qa466hh0xtJGHpt4=;
        b=lISnRXbVDkSQt4xarMz/QodVKqZ8DFsnBtuybOSkSu4tk6MBPlvssVEpTdEXBUmjLb
         WL//d1mxNUScYZTKdgrOYllhFqdNQuOGy3QHa3RBFYCZaJEB/xkIy0sYwQ9qzzivvg2A
         6iPrMy95v4o1b/Em5FLWdXUSlPS+OJqQZNaAU9h0eKJbT92uEfV1S3y2Z0x6yG01kKOm
         5vIGHQu9o+4/9W0gDSYA2wkj8HPSCcsRczuMcCcsWm1E/YY4yQ+lbez+Wtt8ArE/Vl3Y
         bUcd0hPrI2KtelGr1644Z9wmvS0VBDRWicUW65i1W5ON8NKm7gqKsDAbJQSsdmoAUWhe
         /cHA==
X-Gm-Message-State: AFq9FYJKDGNhVb/bNT3ih6W8ziuQJHGdwp/SCy2sDW3SWbMk4bYr6MFx
	RN9UIjjLns+21J/HeEFdfcCWFPRemTPa0ivdEuEmtURa5FLs7cnhDqAp09EteQ==
X-Gm-Gg: AYBFou1K1MZ17JLZpqQRRBnNzWYv/mxHL0Owy15mnCQxtoUTr+jEWBTlhTHp3pC/ul+
	5uKRwwL1ENZrSAFVxwBi/W9Sqj/ctIZMY+ltYvwJP+Ut1KOxFltO89P/gXSAmhVuwrOrnHZzy7i
	iDanWsXmvqoaNIz49IJSacurjxaMXKKojCpyCF2JhPq8sKNfm5SHd7ipRouY4VlRnWcsMIKX9Lg
	M5qTgMLUlEMhPx59ZR51hPbk8/KkN/1hXOfoE8W6+6xOH3xbJ/zxfWqSHouVkpouEQa91SMi8c5
	2KwtuP2ZSAcXCfhW6udxwA58EFWzpcp1LooQoYoDri7hOR/Gvdev75NAVqdHU5Up1x8c/CBoHqV
	uxinhsFzZgNOaWCRjYOkqSH5UbkMVNpMzvRW/TIscseNYtQxdVvXveygQ0Guo3TfnAyk31+RIzH
	wfmBW3hGADfqa6KbZ4zeembNckH6dPiKuv1ntPv3jaS+qgRMPS25ilNo80fE+xsMJxuyju6Og3r
	AYu8SyqpZm752FOdb3JgZFaX6JVYTClKQYiTva0Rz/hKPPeuhcHl8MbUe1aRUdSCXSH/DXYxZqW
	QF4E6jdsyX6XyodkX27eQk7ZEpoHuwqL954UuBsBaMYF4qT/QO45rQ==
X-Received: by 2002:a17:90b:3908:b0:3a7:3474:b1ee with SMTP id 98e67ed59e1d1-3ad8708ad2amr305946a91.60.1792538392074;
        Tue, 20 Oct 2026 16:19:52 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813de463sm1295714a91.13.2026.10.20.16.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:19:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next 1/3] bpf: Make unwind_exit of an exception callback exit in JITs
Date: Tue, 20 Oct 2026 23:19:39 +0000
Message-ID: <20261020231942.2568163-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020231942.2568163-1-alexei.starovoitov@gmail.com>
References: <20261020231942.2568163-1-alexei.starovoitov@gmail.com>
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

For the verifier unwind_exit of an exception callback is exit. For JITs
the callback is a subprog, so they emit the lookup of the return address.
The idea was that the kernel calls the callback and the lookup finds
nothing.

But an exception callback has no frame of its own. It returns from
the frame of the main prog that threw, and the kernel isn't always
the caller of that one:
- An extension returns to the caller of the subprog that it replaced.
- After a tail call in a subprog the main prog returns to the caller of
  that subprog.

When unwind_goto follows that call, the callback goes to the pad, and
the pad wasn't verified with it:

  r6 = 1
  call a             // can unwind
  unwind_goto pad
  r6 = 2
  call b             // cannot unwind
  unwind_goto pad    // stays, since the pad is not dead code
  exit
pad:
  r0 = r6            // r6 is 1 for the verifier

An extension without unwind_exit can replace b(). When it throws and its
exception callback ends with unwind_exit, the pad runs with r6 = 2.

Both JITs ask bpf_prog_can_unwind(). Let it say no for an exception
callback.

An async callback has a frame of its own and the kernel is the caller.

Fixes: a2d274771321 ("bpf: Add unwind_goto and unwind_exit insns")
Closes: https://lore.kernel.org/bpf/sashiko-outbox-179498@kernel.org/
Link: https://lore.kernel.org/bpf/5f24cbed1ec4a6a0ecd0b834d738c48dc9eb64362be4fa50dfb0eaddfad928b3@mail.kernel.org/
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 arch/x86/net/bpf_jit_comp.c   | 2 +-
 include/linux/filter.h        | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b3efe0668e86..326e9e1dea0a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1273,7 +1273,7 @@ static long bpf_unwind_fixup(u64 lr)
 	e = search_bpf_extables(ptrauth_strip_kernel_insn_pac(lr) - 1);
 	/*
 	 * The verifier made sure that unwind_goto follows a call in a prog. When
-	 * the kernel called an async or an exception callback, it's exit.
+	 * the kernel called an async callback, it's exit.
 	 */
 	return e ? e->fixup : 0;
 }
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d3ab36281144..6a2fe3d0039d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2552,7 +2552,7 @@ static u64 bpf_unwind_target(u64 ret_addr)
 
 	/*
 	 * The verifier made sure that unwind_goto follows a call in a prog. When
-	 * the kernel called an async or an exception callback, it's exit.
+	 * the kernel called an async callback, it's exit.
 	 */
 	return e ? ret_addr + e->fixup : ret_addr;
 }
diff --git a/include/linux/filter.h b/include/linux/filter.h
index fccd8db33647..e0218e677a1d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -267,9 +267,13 @@ static inline bool bpf_is_unwind_exit(const struct bpf_insn *insn)
 /*
  * The caller of the main prog doesn't tell unwind_exit from exit. An extension
  * is different: its caller is the caller of the subprog that it replaced.
+ * An exception callback returns from the frame of the main prog. After freplace
+ * or a tail call it returns to a prog that wasn't verified with the callback.
  */
 static inline bool bpf_prog_can_unwind(const struct bpf_prog *prog)
 {
+	if (prog->aux->exception_cb)
+		return false;
 	return bpf_is_subprog(prog) || prog->type == BPF_PROG_TYPE_EXT;
 }
 
-- 
2.55.0

