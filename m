Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC64C653A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542931; cv=none; b=rp7/G4ijPoLAUKvRnQe9JByiRb+gDkf51novwoK2AkWBJ5WwIPOtgiQ2kcNko9eirKFPc3PH6jmpKTdd/Zm+pSBs1Sh9O5jGKUr2AWU1HuksW/JEKIdTID8YGNYT1w9lkkoiINo1L+ew+DdemF+02ShjmmTersz7tljsjwgyabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542931; c=relaxed/simple;
	bh=WhU4mGaRxmrNBGnNRYEwAXnRihon/IYcjXpo7mtRzbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwGjxCmp0QnHmJlvs8kBe39vdeLleSqmKSTlTkBL2qQCCUAhxzVohUAPRvxe1NsgnPMS+pcFCZanzQbsBvMQnmLH2D65likL5uSJVul/sywAtAeFDllFgTjKQAvUh9f3Xh2kvunBFcBNjOKcUyktIW+ILfLz103TxW5Tk+MOc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkgDTDr1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkgDTDr1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381b831d535so6250308a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542918; x=1792147718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HmAfc92Wb3WOCu3XqccLlYPhg13/9MXQb+YYptp9dOQ=;
        b=pkgDTDr1F1Whyac1S4h3RpE0AtTlhe74Hz/f1+F7QcmpuVgG2P0oXh2ezcnVAWDH7u
         YHSJS8Ze5oaepewXja3ZszKUYhlBKiutJl0j5OdpxzCNTBfwuha4EHTJsG3Vl3MR9TMk
         VED78F0kTNr+vE8sQcK+O2n+nixXGqGfJjkGSNXBoTB5+DqUNDNIgPssLy66RHzvRMLs
         7fBYZuXX2+B1EXNzYHZqiOdWUzmAhGw/TgQX5ATphM068o6C7anfVj3jKaw+bHRX8ohP
         t7L0rAIVVb7H3DDTcOAzZTSpHLYkpNOHjZfODRSaP515GcGaT/wTFn1nJB8fbDgWACMu
         mUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542918; x=1792147718;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HmAfc92Wb3WOCu3XqccLlYPhg13/9MXQb+YYptp9dOQ=;
        b=Vn6cTJMxouRVMKqOOkmweCRxlIQT8v85vbKyH6OFcvfoCbMUYkgERmBg4sx56GTuB2
         ts6Sz4fw4feVUvw9L3c5Tk5ysU5gcDD/ji+1JYhqNp7srkLNM2k9MCtoGBvoDeDI7jDW
         +Le/TaX08B01nHrxUC30pbvGlO1HT26sSRcITLbVGeOd2dRYmfWatAGJk9hFjmYQqrPO
         bFWCxWijy1pFAOh3JYfa0MRfcVV8pgRi9l530CnjzE+u0vWNEqgIOPQWsNbO6X27ouPU
         41H7ewItuZMfcJasdWrai4G5a11llrTKPmRMxYTt1FIA+ge8kSJfE9hIAvcy7PbB7EcX
         psuA==
X-Gm-Message-State: AFq9FYKvtN2AHrvJaya9ixGwMh+e2QiNppXEWJFZKY2UKjYgnmX3Ggsg
	oFZWE2FMUTFs8N4lZt6/g0lE61A1Vssv/9fpajBpt4sXoPTLem6n5ucurNSABvA+
X-Gm-Gg: AYBFou1mH3FjgHZ/5t3ZyuYbAuTIMDdoO4+AGUE1Q/GSuAJxlLpadXh6YXrnxHhxe+C
	Ez3l38TfgXyDNj5nhOn8F/yBQIHJJ2c1alV8nvTTN0SbaZAluaBxC3IUokTY3nJjGrB2KPaQ7s7
	qchWhYvdPiMhW2xCpYtmQR9K7IrxSBEGtdFFzFX39LQkswUdOjd/3APqA8LALMgaenNXkeYvwTs
	Y96FXg2ztPiXKcR56MClC3Ge6BJAR9Kj5zsXM5zTZOLb34OcgECNP8eYkPwsaJiOylbQPBbRnNP
	2UWaPiYyJy3QFpbr00KaUL1VAwb2rS8Fho9+VmGdQgDDbWXWhyObb+DVABMNHsFuoscWzagy84r
	90oRpe/ZhjgK+AEf1xPiFWJK0PUaMsTwTu0VnyX41OZtkQIrPQr86Mh4EZZuXiCOJIuLeFp0+xY
	D4RIqgJlWadACFZLCexbR81L/ufcgmL9gEnC/VFhbdUPmXBt3MLV6VwHAhPMgJuieL7YwsQrClD
	TTwidjsfibP7mg=
X-Received: by 2002:a17:90a:ec8c:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3ab3a9a8d8dmr1493131a91.25.1791542918269;
        Fri, 09 Oct 2026 03:48:38 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 26/51] bpf: add bpf_mark_reg_known_scalar()
Date: Fri,  9 Oct 2026 03:47:44 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-26-bcba9bc53ac9@gmail.com>
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

Provide a helper to set a register to a known scalar value for use outside
verifier.c. To be used by SCEV widening logic.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bc901d649472..c7b7c8148205 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1353,6 +1353,7 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state
 void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist);
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg);
+void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm);
 void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg);
 int bpf_grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size);
 void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 585303d28690..743fc2f3c24b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2057,6 +2057,12 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	___mark_reg_known(reg, imm);
 }
 
+void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm)
+{
+	__mark_reg_known(reg, imm);
+	reg->type = SCALAR_VALUE;
+}
+
 static void __mark_reg32_known(struct bpf_reg_state *reg, u64 imm)
 {
 	reg->var_off = tnum_const_subreg(reg->var_off, imm);

-- 
2.53.0
