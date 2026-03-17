Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F431448E0
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782162; cv=none; b=gYske46LXT3SMyLoOL+OC7JiSm1dvgwNoaJ+R4Rp06rCsuYujXSB5jmHbnY4oHPc9tZBgzBofFpW5JntNwHLYnfPWCL59fHGz/KhMOzQq5KrwHj40ysg2Tmk13rmaZPmciEKOo8NDm1lKm96p9FwntPtvnpR9Wg7WaQcPU5VQEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782162; c=relaxed/simple;
	bh=oHEnGLh9N2LLoDz99piIaEWaL8/Bf9UUiMYWCsM4X8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbjTtJbxou3rxz27tYBA4pn8df5yXaIbP4Owzn7An9Xm43UqvpnEtyze+Ubvd9h8hxS3KqmiZQNXn4Cs9ndBoqrjfTrxEOHb5ItBXlkRn2aM65AqD2J4WOQ10JS/xe7bMi76K6Tol2QMqJSDtEbsvfiSPwGkhrEXtDYVLfbP2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjyGZrt2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjyGZrt2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so55330275e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773782159; x=1774386959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bSUIvqe14Q60BVjfPKT//D9DMw5P8r1DogS31kSgPE=;
        b=PjyGZrt2z9hkX9sQzGCq99IudybyJqgPvVQxek2UgD3f6yfCTGoxsEuF9RCOsN5liP
         htdBbefkmb/auAZoW0ifFkm0813wdT17TMO0fkcC2sF9UNhh12RY18t0dK3cRVxl7ck9
         UdW9ih9RGelOfVnFNoTWE3TL/B5boJm/JkTCVqX89w0IEfrORBFPqE2Z8UpLAzyz2Xaz
         M4iYkSIUL+vHlR4hkwZwDox/mhhh/ZmsBwpLXurgXtjFLOKgcO8NxaKeWIWyIND4M9qA
         W8GMfE8Nb6uc76/fAIeFk/9C23IpXfsLwFSKjpRHin01vx6l5geqaa3TvK8VkHTuGKl7
         Q/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773782159; x=1774386959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bSUIvqe14Q60BVjfPKT//D9DMw5P8r1DogS31kSgPE=;
        b=JnHKCvaO5im4qgtyozUCcbZ/yfrTfob8dCbhcShn7BHZdWfXRBNmrikra1o9Cz3u/6
         T97AbD1pkIXFgfrpwGs+Ckz8CKxsqjlR5lA4nKpcq0trAmH9fx98P8CG3I/ELux1Mht5
         BL498A32+9p2vTfkvgwS9RqS7Bsz6hbWz6N7JT2FEoklZBX+4AwtRF9sX/T9KxrXuqQ0
         oJwQwowaotwU51slgo7AB2S+RtmhI7SaG30VpSB53rSdtq+V4mFCtMKyCkS7KWmNOQd7
         tJChhCwkBeoVahV/EOfkU+G7toJzCnEA4LiYO1KMe4yaCisxyVxTxgUtlSYKCCh/sNHh
         rWSw==
X-Gm-Message-State: AOJu0Yz46L1zCFtkXwjEawuEO1hznfrohZWoM6TgJdat84sB4dOaUDhm
	MRwfH1+OoYuH6itklS5+2jCKHBODUbAd9Dyu5v3IucSoLt2ySq1QTUHJpFV0sMw=
X-Gm-Gg: ATEYQzwHf+B3LkIBkQpA3y2Qs0Zq0BCJEju7iZXWRNWzMQW5d2/NdHuWXsavLrzHQvR
	heFnZ30m+3ba8QuFf4rXHV5nDSfHarngY7l/w0k/3g+Lj9Em7XM8/gjwh1bizKjpKrqgBzRUP7e
	N7zTIgpEhy3Fct9dCK9jY9s20+tfJdj0voQNEx9YeoBVX+W5eKtjwIr6cRNPGAcdt9a75WoWj5F
	1zBxpuhb6oxC8snwsYzDUQNmHcSy6ywD5yA4Jrhbt0u/v6A1VEAd3IU9GG1arHMDG+39z8FU9NA
	4DO20Jr3yeFwWK3SLGyG8e0JnOdkeWmEMNM0qC2QQmkoWfvCUPTPS1YnzaS2gvo8/s3GIxecXzz
	BiakogN0gcQrG9CYG+32x/k6wOtrInIeGqwGQ7dKp1fiZb34iv+O9UpdjYM2flA2QKu6SxZEsDA
	zAFwcdlFJLURXEpA==
X-Received: by 2002:a05:600c:630f:b0:485:531d:28b9 with SMTP id 5b1f17b1804b1-486f443841amr18529435e9.14.1773782159021;
        Tue, 17 Mar 2026 14:15:59 -0700 (PDT)
Received: from jacks ([197.38.195.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaffbbdsm87580235e9.15.2026.03.17.14.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:15:58 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
X-Google-Original-From: Ibrahim Zein <ZeroXJacks@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	gregkh@linuxfoundation.org,
	Ibrahim Zein <ZeroXJacks@gmail.com>
Subject: bpf: verifier: fix integer wrap in regs_refine_cond_op() BPF_JNE case
Date: Tue, 17 Mar 2026 17:15:48 -0400
Message-ID: <20260317211549.1716141-1-ZeroXJacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In regs_refine_cond_op(), the BPF_JNE case narrows register bounds
without guarding against wrap-around at type boundaries. When
umin_value equals U64_MAX, incrementing it wraps to 0, producing
an inconsistent bounds state (umin=0, umax=U64_MAX-1).

This can be triggered by constructing a register state where:
  r1 = unknown_byte | 0xFFFFFFFFFFFFFFFE
  -> var_off = (value=U64_MAX-1, mask=1)
  -> constrain with JGE U64_MAX -> umin=umax=U64_MAX, tnum non-const
  -> compare with BPF_JNE const=U64_MAX -> wrap occurs

The same issue exists for all {u,s}{min,max}{32,64} variants.
Add explicit boundary guards to prevent wrap-around in all cases.

Reported-by: Ibrahim Zein <ZeroXJacks@gmail.com>
Signed-off-by: Ibrahim Zein <ZeroXJacks@gmail.com>
---
--- verifier_orig.c	2026-03-17 16:56:43.000000000 -0400
+++ verifier_fixed2.c	2026-03-17 17:04:02.434335000 -0400
@@ -17055,22 +17055,30 @@
 			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
 			 * below.
 			 */
-			if (reg1->u32_min_value == (u32)val)
+			if (reg1->u32_min_value == (u32)val &&
+			    reg1->u32_min_value != U32_MAX)
 				reg1->u32_min_value++;
-			if (reg1->u32_max_value == (u32)val)
+			if (reg1->u32_max_value == (u32)val &&
+			    reg1->u32_max_value != 0)
 				reg1->u32_max_value--;
-			if (reg1->s32_min_value == (s32)val)
+			if (reg1->s32_min_value == (s32)val &&
+			    reg1->s32_min_value != S32_MAX)
 				reg1->s32_min_value++;
-			if (reg1->s32_max_value == (s32)val)
+			if (reg1->s32_max_value == (s32)val &&
+			    reg1->s32_max_value != S32_MIN)
 				reg1->s32_max_value--;
 		} else {
-			if (reg1->umin_value == (u64)val)
+			if (reg1->umin_value == (u64)val &&
+			    reg1->umin_value != U64_MAX)
 				reg1->umin_value++;
-			if (reg1->umax_value == (u64)val)
+			if (reg1->umax_value == (u64)val &&
+			    reg1->umax_value != 0)
 				reg1->umax_value--;
-			if (reg1->smin_value == (s64)val)
+			if (reg1->smin_value == (s64)val &&
+			    reg1->smin_value != S64_MAX)
 				reg1->smin_value++;
-			if (reg1->smax_value == (s64)val)
+			if (reg1->smax_value == (s64)val &&
+			    reg1->smax_value != S64_MIN)
 				reg1->smax_value--;
 		}
 		break;
