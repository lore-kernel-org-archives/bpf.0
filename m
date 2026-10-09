Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6F4C6507
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542937; cv=none; b=DjZhEldZ54nAUBQxbYdZM3t2oPiSrPT9ltdziIjWhuwb1i/aINAYIlzLbwaYMclFXInImXqiGZIGZ8Pmohcgu0/e8D/zYxJ1aNqnP7muCCzk1+/1eQwZm4MHNyTyeuweSRwTO2AzrRs8Yiwua1JCmmN3TJ3YwhRjvmf2v2k5XCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542937; c=relaxed/simple;
	bh=ZfAusdGzVz+TyIcHagoUOPe2WsqdQwd48Wj3ohdAlPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnXEQ0sif3S++VzIaqmylnpmcUqF5m5z/Wle2+wt6H/OdpphVrPDhuEDEizFVNS5/yLqfvPaKR8pok/NG/UMWuuj4zeD/yW7JW8VR5TbfEC4XYDo7+oOsEf4I3GTSFFQIogV0DShq9wlEQ6wRZUVSiXIgE+mml0RUPVU96Dx79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9JKT/ru; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9JKT/ru"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so2403780a12.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542921; x=1792147721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ayXpDddk0SowV1JclG2s2JhzsaYW3pxlSJwTCFM2D3Y=;
        b=C9JKT/rud3OBAraWeAOY/ns4Ii+kkQE1R07eA+nLKPoJAfpq1N4kXj3EwH7Kr6ihIO
         Vkj+hBdc4fon8GQ2Fx27Z+PoDX6frzi6uWP+fT5aSaje1l38RdyF5qWB7oV6KldHCPgT
         ZwKGRV9/cLu4wwABSB2GAUSzRjNYeq4tDt7mJPc30oGcUefctRiBWSnb3ZBvEHRj6N5d
         yzI5PEB4aiPIDNRGe29zIFbUS0FjRykymk/59BWcnzfGwRycv5OTT//1TKtL/Tq9O0P6
         HMFQpvrG2q20KhiMTgl6voXU6Y+pnY4hF+Mdf7SKIWZXyNjiyTu8+/Ed2BpD8dK3PjCf
         F67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542921; x=1792147721;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ayXpDddk0SowV1JclG2s2JhzsaYW3pxlSJwTCFM2D3Y=;
        b=al8eIKWTqmINf5xriStwHMJb1nna9cti2J6B31LLOLAXSOG9Y1Io5afz3IUVfKuPVu
         igV1Oy9Vq1TEYCXFUY0fij29s3olvwgpl/P8tKEj8Vx4jYe3TGGBVBy04Mm0g96DAPta
         j7C2NtTXMSczEoOqiBQcahJK/SMhQ+ItOlBKXpPIyYfLeyJs2HcRkAToFIvdeFQ+UEpn
         hP/skMF4p0SmAVEDcRNWv04eAqCpImMM6tp9nFXWopaZGsKuufuHdggycAHCHgCDTyCd
         EjVe7VP4lrbB7E8iJYYGuRM5VhBZXqWXIKGWxwQCwqKGWqFaqplwiCHF4CxmJJNet9S7
         +Gcw==
X-Gm-Message-State: AFq9FYL9s3mGvuS9mzpgtm0zUash8V1YOjdvqR8FbIErS5eXtxb8M/14
	XYiuUtPBsRBjdavu/tmRixIqk52jrFerOhqFWKVwMUdTPo2cJFMpOyMtW7VgHwV8
X-Gm-Gg: AYBFou1baZ/qPzUGonrU0bXIZT4+OkvCovouycqoa/pT2cdQ8jEUjMpaaau0glElb9a
	PJ/FJ/AZSRdcOhxdCrtK65WvUQFSYyO/x+pjiLDZmUXIHp+SjbfZ+r1m4g8kuG9QXcxZLD8tSuf
	eIcS6KZtfP5zNymUhUhvXhaZytnYec/BzrCSzmkpKmerRBy/JeFdJ/Y7gObVXZKHw+CCTv9V7hi
	o0hJoWsqJp4MeUMaT0Nc5WpcXmpKfA8PPbxBhVh8QPOWpqCxFScK710n6E88gwGHi3i6UupQVUF
	1SevN+O5TtBR2hulQDx9MLP/RL0aalZdJ5n+YX7hYc91O6iRCQ26tR5uk3JpsOaBpHiT62YKf44
	I8Bjq/XZZFj4aIQz6cXsntZzotuA925TTFTWJ4FG/1VvEGkcEMWedHHToOmRK1mIqIsiKJXhbQW
	XZ/xEfjV3ANQJ7PlOFcBvt3Nrf1RRf1mCZWcZVKuXhtErCsyaTwz5zPYpt4KskaI4hQGS68loGh
	wmIklkVc+E4gIZKhsCA+gdoJG0=
X-Received: by 2002:a17:90b:534f:b0:3ab:2d17:51d8 with SMTP id 98e67ed59e1d1-3ab3a99f162mr1437771a91.37.1791542920742;
        Fri, 09 Oct 2026 03:48:40 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:40 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 30/51] bpf: add bpf_spill_size()
Date: Fri,  9 Oct 2026 03:47:48 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-30-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A utility function counting the number of STACK_SPILL slots in a
bpf_stat_state instance. For use by SCEV widening logic.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 9 +++++++++
 kernel/bpf/verifier.c        | 5 +----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6daa0c826f25..7fb1e315de48 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1420,6 +1420,15 @@ static inline bool bpf_is_spilled_reg(const struct bpf_stack_state *stack)
 	return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL;
 }
 
+static inline int bpf_spill_size(const struct bpf_stack_state *stack)
+{
+	int i, spill_size = 0;
+
+	for (i = BPF_REG_SIZE - 1; i >= 0 && stack->slot_type[i] == STACK_SPILL; i--)
+		spill_size++;
+	return spill_size;
+}
+
 static inline bool bpf_is_spilled_scalar_reg(const struct bpf_stack_state *stack)
 {
 	return bpf_is_spilled_reg(stack) && stack->spilled_ptr.type == SCALAR_VALUE;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf0722752e76..85971f9c09c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4247,10 +4247,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		bpf_diag_mod_begin(env, &state->regs[dst_regno], reg, BPF_DIAG_MOD_WRITE);
 
 	if (bpf_is_spilled_reg(ss)) {
-		u8 spill_size = 1;
-
-		for (i = BPF_REG_SIZE - 1; i > 0 && stype[i - 1] == STACK_SPILL; i--)
-			spill_size++;
+		u8 spill_size = bpf_spill_size(ss);
 
 		if (size != BPF_REG_SIZE || spill_size != BPF_REG_SIZE) {
 			if (reg->type != SCALAR_VALUE) {

-- 
2.53.0
