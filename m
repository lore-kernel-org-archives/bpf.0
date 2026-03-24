Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092E3B47D8
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389582; cv=none; b=pG91lMHxXR0sba72yO1vOXfAKOeGwsDkrTkToHXyLjS6j/iyr+w2zqdZ8hjAMyYELLa5wdO0ZsDXM+82Ep7dPesNRhMfP8WWHdPB93aHTuhL+ScnElCfGnhs43yzfVVbYyR51KVg5wsiMn3mJasBWcEsLtOTkN+C/j2Y2gt1xso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389582; c=relaxed/simple;
	bh=wzICAL4jZHTHe9KI9iF50LUJOOAfbdp6c+k1JBK9vRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5Lla1DwHIEIV+rjWNzSVEqohwWWdoLOfyVwvRhCk5UCvJAjNK3hPvpEe/k4tos/0foD2GhSuE9hc4WDS6p05u6RlLFE7WgERJ4A7X4CUCJ7ME7WSOrD2CKNs5rHEFWBQDrt0FWZx+NaBvbX/Y7gU70+60dTjzQG6S6aMXNnjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0KM3RHI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0KM3RHI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2adff872068so20471645ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389580; x=1774994380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VztcQXKOCV2WyWdTiyXuRv3Zlx2Lqw38402H7Wx45XE=;
        b=K0KM3RHIANL1WTU1LEzu4g/a7FwA4bWEFdZAj70EZLyQkqjqtTAhqKqtJe4SfzvIuc
         +ZQUTwVQ33fKZlc8bAHusBAQ54zyywR+OiJJ+3ZpcRCi/UjsU0onbry2wHI6KNRQJxuO
         jxegjocDsU+zmj1pdblwwGXr+DiFoDKfDOqJulkzqi+OA50rkaWIXGn/QobFCBLTbV2G
         JGiI1lJIlql7D2IAut0LIZn9t1hyXTjzZc1d2C4aJnm58dwsoOPwWTVjJm9mCr/oL87g
         XK0pwT3yXS+UKRyb0qRyGFtFyfmWHj8MSVzqxZO/k3TXpVu12bdFIB7kqj6RFzwAVz2C
         plwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389580; x=1774994380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VztcQXKOCV2WyWdTiyXuRv3Zlx2Lqw38402H7Wx45XE=;
        b=EqfIwUMXZsD1eNxOLcs2+N9IuIxd7nkv+Qu7TTpKE264hF80U9jGBGGXykxF+Tct2l
         fSBj61JtVzo/aCcx+Yxa3ZrMoavLTa1jKgp7WHPmNYtldCfbTJ+tJrJv92iIJxZs32X0
         nqjKnAzMfwQb2ftm17EmLSS0Lzl//gmDPB98isp8h+IWWXG5MYJzUmxGS75z09CEotxS
         b4y1DkyeuJTQE2F87TWFW8z3XGSrvc1RQoVrys0eMON9D1BbY7Qf3wdhlvZelrQ6yweD
         MsfU4vk66I2/smKkH4uaNK69LqJwo01F8ndkOoigqG+kIxniW9fDMeOJU/KXd9zaFd8s
         lhPA==
X-Gm-Message-State: AOJu0YyB1/8Xgw0upT2OBbqGTwFYo3L7FN79UZ+JopeaO7RpWkq8N3HE
	wvLjimnlwU27DXO9n2AlJJLljHD/rNvravp2lBu8fftSGcG399hcyPD0qCOx4Q==
X-Gm-Gg: ATEYQzxBWorafKhZ/tU2AN76Qd/flgVdDdkJgbDK5onRUjyW8VORNqfiKmLaIBGd4GR
	V3WDA+yPXWViLijkyTHyaA0lXB9AfYUOH0tMTBQbjr9+CiV6yNA1MZTHAWKETH4pyPoYx5EvEwM
	tNF+teaw9eU3g6MwpEw4/YhP5Wp+2F60/CaHJrHB+mkfymGzdKoUlMLMM0V4TTevYAecAIXHiNd
	pZvBCpHQzy7YVpyk7AGIa22JMVxOJfWoR/CL/xnoMtBYYJaiRTEeDF9kcJkc0o+0Q97TFN76803
	VGjv0C5ACLAAZvPhFj08xx2+R9gS8PtaortrFJr+2QH4yGFor2soFiT3XFuZVHwJj5csyoM54jL
	eYW72fNepUmJjaNJpV2UWnDF4rK12JLTarMgGUhqV7RefXYAZnvtsS+AscHM3t9QBD92MyqKtAa
	g7UYWvfntqHWSh8mVOHabWMfyQlQEfYJcufe7de9ph+FWfjXUk4fwxllvgo3OGvSud8eyEtUhSM
	Ay11DeCMkP8ZeEyb0wMsuUUuaMXUJG8WaO8QIh+HkzfqqLAdliX/cTeM+7qeA==
X-Received: by 2002:a17:903:fa5:b0:2ae:5e75:3821 with SMTP id d9443c01a7336-2b0b09e707emr11555385ad.18.1774389579999;
        Tue, 24 Mar 2026 14:59:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836554acsm204452075ad.51.2026.03.24.14.59.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 14:59:39 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 1/2] bpf: Fix variable length stack write over spilled pointers
Date: Tue, 24 Mar 2026 14:59:36 -0700
Message-ID: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Scrub slots if variable-offset stack write goes over spilled pointers.
Otherwise is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
and valid program is rejected by check_stack_read_fixed_off()
with obscure "invalid size of register fill" message.

Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
v1->v2: factored out into helper
---
 kernel/bpf/verifier.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 70a100dd4d0c..11207e63c94e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5251,6 +5251,18 @@ static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
 	}
 }
 
+static void scrub_special_slot(struct bpf_func_state *state, int spi)
+{
+	int i;
+
+	/* regular write of data into stack destroys any spilled ptr */
+	state->stack[spi].spilled_ptr.type = NOT_INIT;
+	/* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
+	if (is_stack_slot_special(&state->stack[spi]))
+		for (i = 0; i < BPF_REG_SIZE; i++)
+			scrub_spilled_slot(&state->stack[spi].slot_type[i]);
+}
+
 /* check_stack_{read,write}_fixed_off functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
@@ -5348,12 +5360,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	} else {
 		u8 type = STACK_MISC;
 
-		/* regular write of data into stack destroys any spilled ptr */
-		state->stack[spi].spilled_ptr.type = NOT_INIT;
-		/* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
-		if (is_stack_slot_special(&state->stack[spi]))
-			for (i = 0; i < BPF_REG_SIZE; i++)
-				scrub_spilled_slot(&state->stack[spi].slot_type[i]);
+		scrub_special_slot(state, spi);
 
 		/* when we zero initialize stack slots mark them as such */
 		if ((reg && register_is_null(reg)) ||
@@ -5476,8 +5483,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 			}
 		}
 
-		/* Erase all other spilled pointers. */
-		state->stack[spi].spilled_ptr.type = NOT_INIT;
+		/*
+		 * Scrub slots if variable-offset stack write goes over spilled pointers.
+		 * Otherwise is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
+		 * and valid program is rejected by check_stack_read_fixed_off()
+		 * with obscure "invalid size of register fill" message.
+		 */
+		scrub_special_slot(state, spi);
 
 		/* Update the slot type. */
 		new_type = STACK_MISC;
-- 
2.52.0

