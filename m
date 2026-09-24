Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563BC3F788D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267518; cv=none; b=LXw7zRnsEMNCUu1fIRRZejqSNRhX2zkazF3WQEG3ARSM0nVHzpqBavOtGt/Alt75I7/yKJ+SmYF1pm2jdLYyTbj0knrgRXTXHxvJl4h5/xKEXShtuFlHPKAekm/6Mp2f6zT4xPscZCajeXInJhWhxi47/2MYyxX5LveRKuzCWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267518; c=relaxed/simple;
	bh=99rSoC5riNouHcQYWMT4yxgoWA31Yw2VJMXt1k9+Zi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aof5lndr7pS5T6Amf12/CVGHIQh2axjPtpFdM/3oDqgiSPZfzyAjK4VpwjionDXdY4dptTgcsqte9BFamJyrdfC0Lj+JraYOdnfDOi8sPXmw/gGoovmm5Yz8i6rmzrL7KWjD7I9JBCtWe1EhcpuhkX+j3fzPYZcwCtuMMt48WWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lpv7cSf9; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpv7cSf9"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-495437bb891so41305e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267515; x=1790872315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfX3gLvZXy31RogjuBhvkhO3/5/bYjD/aCrgO4xnFv4=;
        b=Lpv7cSf96LMNuLflfn/UwKMbN4/JyocSYFzmrSWb9i25Kh2X3XREW47hXCgt2+lufo
         boQWSe5DcXB8YFihJieMKlAcJTVJCux9SdgjppD7wVyfIFX/52TR30mT7Fh/ohojffdd
         FdAs4QFijxmnRTOz5PU8lfL3M1ZKkDVwUAKfYP3+EklVZ9HDFRRcFHAEXrEC1SfFkBhL
         ueqWMKOCdNVyTZM18ZEBFe3Sm+2mvK/Ae/k+kI32LJNZeJhMJcrsyeT7FcbIqqvuYjaG
         ZWAu8U1taYMCjglwx4ygiA6UuqBRTsvg8/eWENqaktOx27O57o3snm1Qwp8krAInHGpu
         2cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267515; x=1790872315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UfX3gLvZXy31RogjuBhvkhO3/5/bYjD/aCrgO4xnFv4=;
        b=uPwx26kHSRBT8l/ta9/JceM2ZlNsMKD9AqHlCH+H7msBuPuvbG6IYyoIG0dwLCtay9
         0rBknQW2aM5BnPGN0vbHv7SPbzKHfBSTZuFFPGV/alF0GsetUCWkhJsNXOnzON72D87h
         Jt8OyHplZibCo681nAko/os+mVsPgCtoR4L5HZE5jYHgIUz1tkqPyVgzYHcKSB3hNKPk
         dDr0RaAErl7gAq6/eGSNcAEZJxy/oxes07ikrcC6viaxrZddcynYdNZWM27bdsiKmeVJ
         j4s/uVbRF2nep3PG0i3AzOgwDDmM6RLK9b2Gd954tRgG9u7QQhAmvNnNq75SzRND04KG
         Ya5w==
X-Gm-Message-State: AFuF++nrYrgt5nJAT+MTun5uWXPrdsq4LAeHG5RmHtZ3ySygZE2wrTWr
	T+GZHyghiUxfiZikSJB5DiGTh5lQOqzKdryyw77bSic2vWqUDa6t/tGSi3Ude81i
X-Gm-Gg: AYBFou2teBsX7Ow1V/MxyfjkiPZ0MMVPJGzsrqEnlE2aPVm3wguPnjO74mxSQIaNb6z
	8vKm593gl4QfH5urbhVgRajE9sx7ESilg6mxXqamX7BZTOic/PoNJyCsEsBg/Xgti2cdHmLKP8Y
	POI00y2ezlPcXCTKct7dFPffYc0DntRHfh6lBR44xMj3Dfg7+jXKqwOy/aAVfORAJokisZkHcdO
	Mw+WnMCU1vX1i/hHKJ1IyyefadZk0IrTnI8ss4bh8QYZskrA7ko3SPE9OWAU1mHDydc0awaGy4v
	0A5Wh4VMwsTdzvhpL2CSS0P9Q+eE54OA+tDbjg/huESq+I3NJshpjrg6FH94sn8rt3W/RziVn3+
	zQ9pde2ISpN8b4I2dUjE8QigCMuQTFQzcv16LFYimpqELwH31kbgxrYO5qHW6N5RktJ9AuOkMWr
	BsKKH5E3Ov6k57Gjh0d96OzxyKz/mxnfEleikZnqssEnGpQlt8bRYvyFoEQ/0rMO8r42EWSVj7+
	yFqioTPvKTKqbRcSEkWQBpOpIaZliCpO4HRIpmv35yrg4h6740d8rj0Mw+BEBhhZt2sl0v2aSdV
	UAk1afF1OkHQKKFdIPOGe+TkeRYdCFO+sq8OfXAmFAG5OGL4
X-Received: by 2002:a05:600c:55da:b0:49f:d91b:f468 with SMTP id 5b1f17b1804b1-49fe66f1cb6mr45905585e9.10.1790267515504;
        Thu, 24 Sep 2026 09:31:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6456f8sm195629f8f.26.2026.09.24.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:31:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 05/18] bpf: Track scratched stack slots with a bitmap
Date: Thu, 24 Sep 2026 18:31:19 +0200
Message-ID: <20260924163144.1945455-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=memxor@gmail.com; h=from:subject; bh=99rSoC5riNouHcQYWMT4yxgoWA31Yw2VJMXt1k9+Zi4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur76tNB+N3GoWKsM4uX9vau+wN4++F9fLqdfta5Q5+y VwbKGjZUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkcXcTIsMk6+yX7Af624jmn XjhLmrSZzs+9923+8s6dZgH/Vz64JcfI8PCrjeydOUU1gf96io4HxE5uMrFviHOpf7cw807WXM4 drAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The set of stack slots touched since the verifier state was last
printed lives in a u64, so the log could only ever mark the first 64
slots of a frame as scratched. Make it a bitmap sized by
MAX_BPF_STACK_SLOTS and go through the bitmap helpers for setting,
testing, clearing and filling it.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4b69737e1d42..a179551247de 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1090,7 +1090,7 @@ struct bpf_verifier_env {
 	 */
 	u32 scratched_regs;
 	/* Same as scratched_regs but for stack slots */
-	u64 scratched_stack_slots;
+	DECLARE_BITMAP(scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 	u64 prev_log_pos, prev_insn_print_pos;
 	/* buffer used to temporary hold constants as scalar registers */
 	struct bpf_reg_state fake_reg[1];
@@ -1509,7 +1509,7 @@ static inline void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
 
 static inline void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 spi)
 {
-	env->scratched_stack_slots |= 1ULL << spi;
+	__set_bit(spi, env->scratched_stack_slots);
 }
 
 static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
@@ -1517,27 +1517,28 @@ static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
 	return (env->scratched_regs >> regno) & 1;
 }
 
-static inline bool stack_slot_scratched(const struct bpf_verifier_env *env, u64 regno)
+static inline bool stack_slot_scratched(const struct bpf_verifier_env *env, u32 spi)
 {
-	return (env->scratched_stack_slots >> regno) & 1;
+	return test_bit(spi, env->scratched_stack_slots);
 }
 
 static inline bool verifier_state_scratched(const struct bpf_verifier_env *env)
 {
-	return env->scratched_regs || env->scratched_stack_slots;
+	return env->scratched_regs ||
+	       !bitmap_empty(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 static inline void mark_verifier_state_clean(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = 0U;
-	env->scratched_stack_slots = 0ULL;
+	bitmap_zero(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 /* Used for printing the entire verifier state. */
 static inline void mark_verifier_state_scratched(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = ~0U;
-	env->scratched_stack_slots = ~0ULL;
+	bitmap_fill(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, int spill_size)
-- 
2.53.0

