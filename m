Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127838;
	b=WsD35dLwRf6rEEqB3hoAA06SdjGh/PPkICuCAlQTaIlvDkJiRuanJJIj/Q8rKn300dbU
	 RuFKxBqkB2HDfp54v0hUkOsjisZKCEdPihPugXwLALjW9d+zumPqBblpqu6sAG/e5iIlU
	 ByvUSsCHy3V0RUcW71hfLRTa5wzHMYgdbmaldVXxfhhyLayNQtTOtpohguAJNRfFZmBbv
	 Cc/21E5OJQsLa03c3tSjr+Z3F/ET25PV6eJS4Hj8MSqc8lDeCi5GE96jPkYaYa6VjJR14
	 UyJaoEkqmAWitNkTQ8Kue+IE6G1GVlTOOWEDuMm8EbVnmTSlIhh71S/bT/AbkXDK1VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sACfTe4Na+JlV+CFd1ATa/t+vdlfe5Opa1A6pa5jc0Y=;
	b=oPNDiUKnT7n4255eBxQesHDN1C/ynqMP0zCfortci919LYEgEUFhgfGBF1Syp+aPTlhF
	 3cNnuArJLo5YRZSZ3ehKNTqmZhNhfkrFhZ6n+2Fi3c2rnNRKmYEN9NpwBCUek+vKFffTv
	 617zCWrcRMf9bQmfBtrcqUHF+X3GBWsE7J62QDZERdUFkBw09oTrBzNZmYGhop3dSUTpw
	 KWlEiyM0WF7INd+NbqsEmflK7AWbgpDSLo4RDvPT8uoQhC4uj9Ga6RKZlP4ip5XQzUHEc
	 whic8eEdR1DeCb8nrU+1moiNpSYS0iEm/dLsi6gb82minkwa2KlyvM+R+v+g2o3qPQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MkU76MVu;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA52606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BA52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MkU76MVu
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9e53d011eso896995ad.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127838; x=1793732638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sACfTe4Na+JlV+CFd1ATa/t+vdlfe5Opa1A6pa5jc0Y=;
        b=MkU76MVuSG7A5EzTAHySG33PmyoD5De7NiBQg1r3g181Ok8XbjuMl7VNjAjCVD6JzJ
         ELG2Y/rH8rR3FCnLjvZj5hJ5lAh4xKFO2vSHUcubFmPRuwu6jpb56cPI3fj7uDiZNwgZ
         8WzDvGl153/W5oYbAGqw6LpP8gfAdxxZI/vOUDkso+ytcWnqeSK9YohtmmAHa9kTKbU4
         MuvUFHUuKHApNKZPXkXadVC9LeJmVPYH+fy60F70yG4ufq+hI8ZPFHgUa0TqpjOW72oW
         yPMJnNh2J139iiVsy0Wh8Hel0wg4u3aRSJoO/+Z/ciQXPqDEl5WwmUDlckH9ZSNXhDkC
         HpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127838; x=1793732638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sACfTe4Na+JlV+CFd1ATa/t+vdlfe5Opa1A6pa5jc0Y=;
        b=Kz/5/xhhalFtFuhlka8xqdvatA/M/igH4ogRjQFNee+ANlvbP00an8aWaZ/RfUbLRr
         +FOmpuVsnyyWGjhiT1HfHo41ZB2IpcA8i11roMP6yz7Js60hv9lSJyXJrPR4uRbizQzt
         DHQSZH8AiHHhH45AIBR/jqGrzMNmbIxGxYSaLBzqzDnTPjXXzB9RRLGOK6Suaf8jb3s+
         y3EyaOfY9vlZud5V4JXpE2CqhGxBpKpfRJzI2wqDOYHSfu3ZYLe/oWbYAUBRm+b4+N4V
         XPhp85moe6xaueEM4hlDoKNtkQkjp5C39mgdqZbYFX1V46yrbkWdoEzaSylpvLW36Gdm
         wN4w==
X-Gm-Message-State: AFq9FYI9K/u6F/Nqb6oP53jeQdAMcaqXE6TmaB2WsmYbtCjlNmwv6/Ib
	YHSatpev9JJ7kKFCyoHugmxRD+S2eQhZ6GKtai93B3B9Y7YrM/5LOIrTAsHLww==
X-Gm-Gg: AYBFou3nEiEr6lFMAQvn8EpYukguC7pY4MwxaKp/dqG/LoIkjd5znSQGBoYDHteHluW
	Q6aQb7/2IXdi+NFJHdjm3qJxIqMsJ/KsQ93MR7lT9pZ6vo7RPdHeUNCbtdepeeJnacCmkZraEfw
	EpKkX2AKleJzZ7zArrUVFtI87sR+rDKh1Vntq1IXWHejK667Lma/doYedJupJZmdI+9lwupG3f0
	0StxvC6qOSmOu6wcFDKmXeEW0mWTld/Vod/hJGRjcRjaImvZBFRdqjm6UO485WWmFfYtft/ItgB
	cm+8yVcB4N6rQX0HN1cohwhMKKyw+zapDcb13/ArCilS7OqP3tKXnE5fXWOK/psZ1zPkuD/Kztm
	8dvImHzY5y+RjGmf2mguLC5sVJe2XHoMZPxa4bpFPNpcOlUJBYsDnaDK7qW6/T3lP6PYfU3fMdX
	ysUkJvWFj98ig05cRY++yDGZ9G0RBLcfuM7WFXO41j+hd5quxJMyczbhlXy+MZA1SP/PbQcZo/A
	MCDyMTS0cwrQ8Bx1YRgWzrh1Q4y7UddbC0AiOo+aPt9Y80qqJc1EQeNHManQgvrj5J+cPf4INLZ
	CjLwzczoZtQr7YI6BLhmCXpmMZckRNuDiEc7t9LhMrDJC2SKU5rfbF1uHM1Ucuco7u3A9OjKsuY
	0ekfONqcNi3In4jb7HB0CvO6wGg6XfCciW1rnX8VtGLcYlQ==
X-Received: by 2002:a17:903:1247:b0:2e9:5b20:1c22 with SMTP id d9443c01a7336-2eb00085e6amr2826525ad.8.1793127837777;
        Tue, 27 Oct 2026 12:03:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c34c1csm13195195ad.46.2026.10.27.12.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:03:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 07/19] bpf: Clear delta of a register that scalar evolution widens
Date: Tue, 27 Oct 2026 19:03:02 +0000
Message-ID: <20261027190314.1440199-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

After 'r3 = r8; r3 += 4' the verifier knows that r3 == r8 + 4. The two
registers have the same id, and r3 keeps the difference in reg->delta. When
the prog compares one of them with a constant, sync_linked_regs()
calculates the range of the other register from the difference of the two
deltas.

At a loop head scalar evolution widens a register: it replaces the register
with its range over all iterations. Then the register is not linked to
other registers. scratch_widened_reg_id() clears reg->id, but it does not
clear reg->delta. A subsequent copy of the register gets the stale delta.
Then the range of the copy is incorrect by this delta.

    r3 = r8
    r3 += 4              ; R3=scalar(id=1+4)
  1:                     ; r3 is widened: no id, delta is still 4
    r4 = r3              ; id=2 and delta 4 in both
    r4 += 1              ; R4=scalar(id=2+1)
    if r3 > 10 goto 3f   ; R3 <= 10, R4 = R3 + 1 - 4 <= 7
    if r4 <= 7 goto 2f
    ...                  ; not verified, r4 is up to 11 here

The verifier does not verify code that can run. Use clear_scalar_id(). It
clears id and delta together. Move it to bpf_verifier.h, so that scev.c can
call it.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 6 ++++++
 kernel/bpf/scev.c            | 2 +-
 kernel/bpf/verifier.c        | 6 ------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e3f7a0b3bad3..7baeb831281f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1313,6 +1313,12 @@ static inline bool bpf_is_force_checkpoint(struct bpf_verifier_env *env, int ins
 	return env->insn_aux_data[insn_idx].force_checkpoint;
 }
 
+static inline void clear_scalar_id(struct bpf_reg_state *reg)
+{
+	reg->id = 0;
+	reg->delta = 0;
+}
+
 static inline void mark_calls_callback(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].calls_callback = true;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 04d4962448e2..3f7534cda47a 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2391,7 +2391,7 @@ static void scratch_widened_reg_id(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	switch (base_type(reg->type)) {
 	case SCALAR_VALUE:
-		reg->id = 0;
+		clear_scalar_id(reg);
 		break;
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c1070aba621b..8139e41ace00 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3824,12 +3824,6 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	return is_pointer_regtype(reg->type);
 }
 
-static void clear_scalar_id(struct bpf_reg_state *reg)
-{
-	reg->id = 0;
-	reg->delta = 0;
-}
-
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 					struct bpf_reg_state *src_reg)
 {
-- 
2.55.0

