Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F73438484
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238390; cv=none; b=kKKu4QqtBD/JRveEWrr1Vrax61vp4R7W+0jlThad9m87Aob6l792LOxAiAySs6MOFn2H39TbTqPTsKESfNHx8UX0snqu1+3VxPnXN1lFtqmW61nqjcRI0qJoP4uDGNlNfOPWmEJfV46VLnnt7RMZ6rjbkL6BrIFKtUgMoGanwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238390; c=relaxed/simple;
	bh=DOhWPHTOArS4mrHtJtgEtmuk6Kxe9jrINlyIz4DiUt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NM20g8989n7SeU7Tm70Yw/WGdQKp4bKPaZDwHpNjMcz0GhIWL0d0AwT13cdKTOAxM4qSWjwZkMmaKjSneWemk8Ol+xx/+tMu2i+SrEobYnxfw8xlemTNRo9ZGHrAix87tNE96kzacJRbUICTAD/5kRw22SCLig5bjKBIsCDtBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0X4RWHz; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0X4RWHz"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so5005855e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238387; x=1790843187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vi/tokI2txuDvIDPHNdVxf0myayiG0209UOvcPi5IU=;
        b=q0X4RWHzhUnLfYg/q7qZAFLo0oo2T3fnmdASWY39x2K63ORt021GmakUKIip5vygfW
         6WPDOrDzK/y/VEm4Mjy540R9n/SrmUut1rgeVPSbD0kzvQ+ytBzkGc1tH/MQZGkTCUpq
         9uq5jxAjDWQy0FtZyakqDGPQF5eL49/waDcYnE915TPgkDUfP4UYoIv4VTblfwrBEHa1
         b/CcfPaI8c7SuxDwkdX5GfWcH+hWa7Zeu19xMkWSizScRSw+qubJYXKCtA5OHzzGrNtR
         dp1bF3oXmLzlN37kfscnt4e8j2rEnyjfRtqTOteE5j100iG9PsItyC/VxDdJ7GbMCeLS
         V31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238387; x=1790843187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vi/tokI2txuDvIDPHNdVxf0myayiG0209UOvcPi5IU=;
        b=HBuYKjCesr15UazMLcR+HnWGe3enyipsVfexLjP2fpsVfg/TfAUKvBGqdNJvZVdz50
         QtPMxw0jkvsXHS6vKUv1k56yxbi1ZHjYVmd42g0OFi9trSHrefXw3Li59wTwd0nai1fZ
         46EL5BfxvONDz8NpSoB0DKPcuzmbgoJDkVM336mojVzT3RywlPJ4Pfe7EgIuVCdsIalU
         qNF/GhiYDSNb/+VtSb2Cp9mhjFczP3FzPMpmAAN5Vu7J6aBiYw11bYFYQ8b0+eZo3N1w
         CqYN75VBFlWjUhEaMGBGzOl5nEwHzHOfvGOsYkAUJSYPo6+RLiWZxENm+fcfrD2d5+Yt
         oHbw==
X-Gm-Message-State: AFuF++npVnsmaC8EDpBf3Sc3f8LPJPcCSZWZ/jBsf0fhM1eg9PccSJPY
	GZ5fdM62Kxc4YLQ6GuCNOfMCT0fZyHbVOiAK5t03dZQ9xH8cwLbTCipDso7eu1j0
X-Gm-Gg: AYBFou1UFSCMxzXhM6lq9HTB5m6EjhfisXAKIMJSb5s6pGdPdyPbOxZWVrR//38FdT7
	Xczj2kbiLCe+7fkruQfUOc3RU2LZFRHPcmzC95nUWuEOKls4A+L6dPGBR2yIeX2TgAw0AnwLHwM
	cpnpCIA7yQz5B7tW615N0hmCK1gIAsYHzjRtZYDtU33Rq9p36Yi7AMwXut2dwptjM0ZwI1hUR3N
	d7wTGSVoTGfhsGHkcnelpKJzHPVEdu3nGx9nKFBS+sCcOADkSm3bOEht9JXXGxpbqbqZJvMs1JX
	IPItHioflLbkVqU6/ErxRRj5E8Xua4+02qx1yiGqb2z6HLJKohbZWV3kGSb95pD1e+ykCw9ThCa
	zqsGyoiaDzP/c5UJ+/2Ik9fX4iYeqo7bisfuo0vxAFh9P8gyq2Pv2hY50+4irTxBiJG/dysV28F
	pMaFmF8mx9wlvhjSjljLFGCtGz4U/YiRJ0bzgOPAVgjCr7v9r1BMJ1ba5AvcFNxEA8/A6qwQwx4
	uXq1pIayIjd8Ln1EZcT04GlRCoSyYCE+XWJZCdN30A0zzWFR9z+4f2NlKGQvc6SUgT3In6Cdrqr
	LJ5RgvDiigCpBnLuotG8zVb5Ap7auSmRIgQlMA==
X-Received: by 2002:a05:600c:8b22:b0:49f:bbab:aa10 with SMTP id 5b1f17b1804b1-49fe66f13f6mr27131865e9.20.1790238387269;
        Thu, 24 Sep 2026 01:26:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c417sm12176219f8f.18.2026.09.24.01.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 10/18] selftests/bpf: Check that narrow stack stores define no slot
Date: Thu, 24 Sep 2026 10:25:46 +0200
Message-ID: <20260924082607.2695649-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=memxor@gmail.com; h=from:subject; bh=DOhWPHTOArS4mrHtJtgEtmuk6Kxe9jrINlyIz4DiUt8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvZTLNgd5zu6fx/b8Wf6h5cZBfizyx57qr17Rl3Vlb bjXsZ71HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIX2mG/+VHrhTt+nSpopk7 +TFXj5tQS8w1VgUTgb8PxapfeZbOOcTwP8hp3odShT+/l8+R/Tmld9ZNsfCGq/FXeMr5eXW2NBa 0cQIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The stack liveness analysis records a store as a "def" only for the
4-byte half-slots it covers completely, so a one or two byte store near
the top of the frame must not define anything. Add a test that reads
fp-8, stores one byte at fp-1 and two bytes at fp-4, and reads fp-8
again, expecting no def mark on either store and the second read to
still use fp-8.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 7a1a0670f851..f8758eb62dac 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2839,3 +2839,25 @@ static __used __naked void imprecise_dst_spill_join_sub(void)
 	:: __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
+
+/*
+ * A store that does not fully cover a 4-byte half-slot defines nothing, so a
+ * narrow store at the top of the frame must not turn any slot into a "def",
+ * least of all every slot of the frame: the earlier data at fp-8 stays live.
+ */
+SEC("socket")
+__log_level(2)
+__msg("0: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
+__msg("1: (73) *(u8 *)(r10 -1) = r0{{$}}")
+__msg("2: (6b) *(u16 *)(r10 -4) = r0{{$}}")
+__msg("3: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
+__naked void narrow_store_defines_nothing(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r10 - 8);"
+	"*(u8 *)(r10 - 1) = r0;"
+	"*(u16 *)(r10 - 4) = r0;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	::: __clobber_all);
+}
-- 
2.53.0

