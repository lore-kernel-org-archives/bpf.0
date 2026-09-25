Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD245A288
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324912; cv=none; b=MzUl+NDxGUfAzgbcJgFijcOrcxnmVaTWJsUfj+UvFnckcYh+5ePa6lRANogSx7uMLzFw6FSDfzeY3BGGZA0gguGFz2rVJbQgQo0fdKJmaufo9JSTPjlTaVPJdhMA2+zQr3vMkzSV5e/PAK7CHfGRk0aM1hrGMAHlXvCgX88aZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324912; c=relaxed/simple;
	bh=CPuFVDJOTU7OutoWc8dLFxrNzv6cGAYuwyA9tXGeDYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PiCoLVSWvsHgEtb9I7KFiEf0gjr1snk5I3BnjfHYS3KjOAC9td6XmF/vcdDgeuK6/41s7N3dZR52v/wjFBUAUeIIRvgKh9AGnlZ7Ea/Jdc3kaUJk6AW4LgMXD4VzCLmp7LG0tsDRQhEkzvSdeYVHhQ4n2HakFvPuv/kVGWUuW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXD5rFMb; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXD5rFMb"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488780459e2so610350f8f.2
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790324909; x=1790929709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E84mITt57JkXmzttmcl0sEhhZTJzUF0ZsCknCmIA9JU=;
        b=EXD5rFMbQNe7pcE8b5jdly9LaJXppV2x67HjlUeTkUElLlHZWj5Nl1Z20+ishrXGcp
         lMxxPmOAYDakxKgAe30na3T9TVU+dSDdNfsrrKJD5RfFTSMFFbo7UAJnnlkNMMDLJjou
         15nIcanHNwyWUSWyh46PTUlL8DUIA7T0GyNudQLobI3k5KsoHaEZ4WLV5y1OwLes2bWi
         Iimcm9hEJshPtPmVpUDSy1xGC3qYVaLzxZBt50vEeeCvxXY+gWJsl9vwZG7Ad3KcE9Fy
         KzIhoVuExpdWjRG1VtSzqbGk94gSYUdzHrIneH+H6y+mR3z6j9OaSSgMaDLOM/t8FAOZ
         5JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790324909; x=1790929709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E84mITt57JkXmzttmcl0sEhhZTJzUF0ZsCknCmIA9JU=;
        b=oNtL2WxBO+88dY27U87g8SCNJxona1+CpjxiGt7i93JbxjmQlg62hRgPmCcw5BFUuK
         rZkIfGeiuRN7ED8CGgwop5pgKXh5fee3o4s/6ZU6Dd5NcLnDozvBMbfYLniXYwVxCgQo
         mYJ7AXu2wyobPUYQhHWxIYNXDhGo+F791H7zKgKypSWkeiGV+OFPsx0UqIi6ciTnhvW1
         ePifar3S09MXkQZYP+MhF7UzniZjZ6fUEto2olCFP3+BDTsTLkR8bdPArL4lQrMI0r3C
         qGZ3VF/Su2K+7JlyABGJoewjqa9dP6yzAdT6OiiX2QJJvy6fJ+62JvTVsP00AmBPUh2b
         LA1g==
X-Gm-Message-State: AFuF++n9R8nKxBXu7IcLPvEzP82RVzqJUASIBQ1ogTfS0YsFsKDTiCK4
	/LteZFPEC063qPqx907Cc7GAy7YI499BowlyoRH1I7Z3GJswhz+ZCvja2aWC
X-Gm-Gg: AYBFou01kGz34ArbyisXRvhuxjeSvX2GtUE/7h5LElsFcKlXqFIEujO2GKmmq8kCZTk
	jrdmTl0cVwShr4INiFAbrOeDBKyqtPCY7h4ZZGt3N8uJMVVH2NfFerpEOyeO8nmyaHzCrEQLANc
	e7wqzrxiRDE4As5oH8/dNrGaWdFvwZ87VcleAj2GcslN13jS+lelqfN5CK9dmr6BQvR/Yfjp6TG
	0CaiWL3m+7S3YX49pMP6bmOm6wbFxjMN/zT6a0xByFQbBnKalcCnGX0pRLgkoiqQRuNfBthOqgG
	DFiCCGxsuMCinEDLpdMLS394GP/4wWak/zWplm93gDkYHDEZ4Ns9w3XH38PiAJamKuFM0dkgQ2r
	aTA/h8ujVxaiD/GHR5NfVBk6V9V2jxn3Et8+kUKwRDrfJifnalqdqS/oJTBknqKrmycZWbf/O+T
	tiD+a7p4BcK0ATU698lMKEAuyVPglebFIxtGv8p0/hzMi45DtvfShvVM+P+L8zCFQEP84DO9LnP
	zZIs8gXPvq8JxCXH90NmlUypcQolbnXj6pYr/Ty4Wq4TE5Gb+DrEhl1fzUYk6K/vScv8Xi9a5Jb
	NURw6exFDQ==
X-Received: by 2002:a5d:5f49:0:b0:487:490:8391 with SMTP id ffacd0b85a97d-488717252c4mr9073653f8f.16.1790324908855;
        Fri, 25 Sep 2026 01:28:28 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a36189bsm5142896f8f.21.2026.09.25.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 01:28:28 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Fix uninit read for helper mem args on partially spilled slots
Date: Fri, 25 Sep 2026 10:28:13 +0200
Message-Id: <20260925082814.1554771-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_stack_range_initialized() takes the spilled register path when
bpf_is_spilled_reg(ss) holds, which, however, only looks at the last
byte of the slot. Hence, a partially spilled scalar (on the lower part)
bypasses the check and the following loads:

0: (b7) r1 = 1                        ; R1=1
1: (63) *(u32 *)(r10 -8) = r1         ; R1=1 R10=fp0 fp-8=????1
2: (18) r1 = 0x0                      ; R1=map_ptr(map=rb,ks=0,vs=0)
4: (bf) r2 = r10                      ; R2=fp0 R10=fp0
5: (07) r2 += -8                      ; R2=fp-8
6: (b7) r3 = 8                        ; R3=8
7: (b7) r4 = 0                        ; R4=0
8: (85) call bpf_ringbuf_output#130
...

When executed, it dumps the uninit four bytes:
	RINGBUF: 01 00 00 00 ff ff ff ff

This is the same root cause as the non-fetch atomic case fixed in
commit 5a84b4424db8 ("bpf: Fix uninit read for non-fetch atomics on
partially spilled slots").

Fix by only taking the spilled register path for the bytes marked
STACK_SPILL, so the rest of the slot goes through the usual checks.

Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c495dc9070de..5c8626215ee6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7484,7 +7484,12 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-		if (bpf_is_spilled_reg(ss) &&
+		/*
+		 * Only the bytes marked STACK_SPILL hold the spilled register.
+		 * The rest of a narrowly spilled slot keeps its previous type
+		 * and must be initialized on its own.
+		 */
+		if (*stype == STACK_SPILL &&
 		    (ss->spilled_ptr.type == SCALAR_VALUE ||
 		     env->allow_ptr_leaks)) {
 			if (clobber) {
-- 
2.34.1

