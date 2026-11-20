Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208051;
	b=E6qJSDcAf9FUZ2mUP5MXuEWaDhwdK0pSRAt80jQ9rIEuSAfLIWcPXe7M/vtHr4R9E5Pu
	 FalZ6ft8zyjaiE0a2GqGNAsjVoxOwzu31ptmPZtqouLRFQYP7JiHm3DIQog+YDByg4S+l
	 MkHmKdn0mAzh7uMASzjHQEWInD0TdAv+9JRdTEVcnMqslzW1WuDBrgW8H9DVvA+VA2Pbs
	 TRvQM7Ua8ZQb7JfeWVDbW5GHp6c93AxTdqEn0AUrKveVykxmZ800AGB+HFpwOgUqSVxRV
	 WbLud8A84Frqen86QJuB78ZEIgvWWsgf9eIUNzHt3MFUtowdB0+E/yAUEMEwSQ0n82Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xAVaVpP1ioPhRdgeooaFxSXuEuAwNr9xroZbT+su59I=;
	b=taQ3iWa3aZv+O+TBFDdOKawXanB9+vgYg3CVFZqmRr4kODqFGJrDzMMtuFQA0q/m/Eok
	 BW3sHnns7MljPhDpAoBzRiKZarlIeUfrYKlauym8EKLKm0rse8oAgPSBpg7mTYZQ5DrMM
	 pTPLicLbQAPzykVeGMJ5WGWYKwGy0D8mMhrYHslAuhWmY2LHhrFnnCKGFsHp/D0HJsd3e
	 AIWT6keqQZFEHyInhpd/Q47o/0zeek1xAATqvMVgnG7RRiTRvRVKQtvbNFXJiTVbTAr0f
	 DgAgslQKg58v/hARfy78CwNXOZRxvUBk6E/z0TdI1J6dVsWTV2Y2sdH0zWTzE5iy1Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t+p/pkyQ";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C67260A260C
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C67260A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t+p/pkyQ
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f02ee04378so10789905ad.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208045; x=1795812845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xAVaVpP1ioPhRdgeooaFxSXuEuAwNr9xroZbT+su59I=;
        b=t+p/pkyQpTJgsKAw7K6EKMxn10yQyxEN48+10AagO7sxEl1RhrLb98cZWNajbPz8DE
         KWnwFLLewyFHAtg+IBAAMPoHbMzl2DcELBU9FCkY+VxJ4IVu/tFeVHs/0xaZjU4PdGoq
         sSjv7gZqfInVa9t76/kOCHMVvLahroJaXHDqLlOw1y3jCs6TeY4c41Q+/APnVRaTDh5b
         xrWHLpzvJSjTrujgsXQeEWWl/jUoQ55R0G2i6C6mZ7TtkoYbdWx9TgQevriW+DDLj049
         pbpUn4Oc9vHzUEXDiaqTs4Pudf9C2hfrrLYUZT1K5EkPbnS4oia/8K4/uR8/m6RXfRdx
         Nn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208045; x=1795812845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xAVaVpP1ioPhRdgeooaFxSXuEuAwNr9xroZbT+su59I=;
        b=gYhakK6GOOxSqdKwII+N6Xlytk+Lqx+kEtUdl1icKbgag+O6uRoI7jYlpCYTtDtz44
         2V95BOJ+fcWBinIbha6WPm6TYM0zpT8X5wJKAmPkQhDolbXivR3PgiyS3nhxKor+0S1o
         fAwlgnyp+XeA+gi3+fvRgd0jTumZJqubk+PdQh4vSUDBHsgy+WCLpfo2fLgH36oFQIdo
         Iu65QY43bH5S4bHeT9djtZvNiqK8Sh3QTHaxnDbcOJ+qn24TyexTYmeRCEOwa6le8JUd
         X8u21ELuAOQgsyLYCqBJyIwLCc39+bc0VSUjTq8K1mUd0EgbCv1hWJ9Lb0rb8GCYhFhj
         hTbg==
X-Gm-Message-State: APuU4Z9TYZwNo1XaYjueB7Ir9aTEXiXI6LrdcXItPL4ZQmNc55h+cJoP
	+1Iiknzp1HPsx6gsT6Gu9y1lWnqVNZjoqO5bVdoqRLH/dhfi+TNjXpObjAl86A==
X-Gm-Gg: AZFdTZdZzYJMnbAgNDu/I2WJ1lgIScgjF8qpS9VtqAQBWIoGBwLbv4YtfuOWIHaok0C
	PWCg3odd8I0OX8EyRhDnMaK6YaqILLokv4CkrPwPTif0g86aRqeWZze9OMlk8mkxi5+o5fJPyKh
	mvZ1s6rEf0XTfbHFW/OAIrJPJwVmir8J7Zu4aNnjEm7p63h/14Y0C1iy2rb65GxVbJqaowGNdj2
	SAdujuU3p38u+b1KsqzX5jHsQ2ecD1zo9xNYGbkj5bHzBBMTmQnmpC6OKI2rp8QLQliTYEW7E53
	ta5/RCDn3x69AqM3QrLMf3PNSM85QtOOpmRunsFA8tOUIb9u9/bWBMGLDtEHpGhrZ/8zX4agA4H
	3uS4yjKp62B/SEgs8LAnHgw6iKlyv9rasn1rbkFVEoO5wyunDlMtiU543aq6xpFhtKcThXl/daG
	ZsU13h9czu+mM8Pb18/Jo5xI2rE9W0hSS5klAlwrxgzffk/DoA3gER5DnF9ecU0BnRJ9Kd3uyaa
	/YxZ6iEudlwYw+yZwjuxef26b2LYNZzmqMwG3bWHSXFVPVgj64UehsDG7GXolMvH72tiA/vKyml
	2UY7RjFAHyZVAJs9pgcc5sw6JhOIFD1XxHuaXDmnyEY1BeHHMAQ9YkdbXBhIlLbOwdulP0fEKaR
	KfjwXr4ZReE2Ok+uewKcctiJ9iqRD9lQ6xnkIGMA3ABNYZYzjAeTxl3qVljHyRlV1NAZMVaZfZp
	8=
X-Received: by 2002:a17:903:4b03:b0:2ed:ebc:460f with SMTP id d9443c01a7336-2f03f2118f0mr46208475ad.33.1795208044838;
        Fri, 20 Nov 2026 12:54:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1276c5sm19970595ad.67.2026.11.20.12.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:54:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 41/49] bpf: Refine the copies of a number that AND or OR splits
Date: Fri, 20 Nov 2026 20:49:49 +0000
Message-ID: <20261120204959.614908-42-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

maybe_fork_scalars() splits the state when AND or OR reads a number
that is 0 or -1. The copies of the number are not split. The two states
forget that the copies go with the result:

  w8 = 0 or -1
  w2 = w8; w2 &= 255          state A: w2 = 255   state B: w2 = 0
  if w2 > 9 goto out          only B continues, w8 is still 0 or -1
  r2 = r8; r2 &= 255          split again, a use of r2 = 255 fails

A split is a jump that is not in the program. Refine the related
numbers as after a jump: w8 is -1 in A and 0 in B.

Without bypass_spec_v1 a join does not relate two constants again. So
the copies are not refined there.

A program with this code in a loop goes from 11 passes to 1.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/equation.c        | 18 ++++++++++++++++++
 kernel/bpf/verifier.c        |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index df4a46cfa04..bb20fde51f0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2533,6 +2533,8 @@ void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_
 void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
 			bool taken);
 u16 bpf_args_with_equation(const struct bpf_verifier_state *st);
+void bpf_equations_fork(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			const struct scalar *part);
 void bpf_equations_next_trip(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			     u32 depth);
 bool bpf_equations_subsume(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index 387156696ee..86b2c08c698 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -1040,6 +1040,24 @@ void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state
 		refine_diff(env, st, &untruncated[0], &untruncated[1], op, true);
 }
 
+/*
+ * The insn is checked in parts. In @st the operand that it overwrites is in @part.
+ * Without bypass_spec_v1 a join does not relate the constants again, see join_expr().
+ */
+void bpf_equations_fork(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			const struct scalar *part)
+{
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct scalar bounds = *part;
+
+	if (!eq_env || !env->bypass_spec_v1 || !eq_env->has_expr[0] ||
+	    !eq_env->operand_expr[0].coef)
+		return;
+	scalar_bounds_sync(&bounds);
+	refine_sym(env, &st->equations, eq_env->operand_expr[0], bounds, 1);
+	propagate_bounds(env, st, false);
+}
+
 /* The largest sum of two arguments of a call: numbers, or offsets of pointers. Modulo 2^64. */
 s64 bpf_equations_max_sum(struct bpf_verifier_env *env, int regno1, int regno2)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 94499fdaaf9..146718823e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17637,6 +17637,8 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 		__mark_reg_known(reg, 0);
 		__mark_reg_known(dst_reg, -1ull);
 	}
+	bpf_equations_fork(env, branch, scalar_of(reg));
+	bpf_equations_fork(env, env->cur_state, scalar_of(dst_reg));
 	/*
 	 * The insn is done with in the branch too, and what gets to the next insn is a state
 	 * like any other. At this insn the branch is a part of the state that is looked at:
-- 
2.55.0

