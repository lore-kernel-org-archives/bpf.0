Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0A466B70
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432454; cv=none; b=j953PcG8J+oJvLgxvfRgsLsUUQSqiJxz/JjFaq+NvoMie2SlKPGXY4Q8EAzVZWz7cu2D4WAA2Y5vE5RFnutPigIhOi1RgrFDBtxFPhfY/4elUWtw9V5DkConbedtb8Cc76eGDqxjRCKpzA+SGe5VO40luvWAFW2IYQ0YLTlbrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432454; c=relaxed/simple;
	bh=tHuIJLAxQ9w5BnpgeLaFFxOisuZeQ1tZCcshkCYMwU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z628CekNh6n7Rz3H0S7xTgAnx9qY9t83QafjhETMHLXoz/7InhME3YY7qh9k/2YCBqEQeqQhkElrdJxpcbixx5sxzfCFpKTZout7kXymKSU0d8ofX5agKRUtEOyy1sVgno6KZWU52opdNfqkXJ81Fma0ay4w3uFFJJ2KtTIQ4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OedxfIJS; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OedxfIJS"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso975445a12.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432452; x=1791037252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcpZPe85Z2cA2oFhs90y1NZzOIJkDihLuGeCHukreQw=;
        b=OedxfIJSL8WdZZm0eMrkwnpzBLOc4UaGW1BKr9mvPkDDzLOu8LcInZc8qWJS9bTcLJ
         8jM8FfzGd65hbI6Gv2jJMnrJagbrexbGiMHZcV5aQnqudxG9B4lHjOAQiSDPThhnxW58
         jXVQALayBfy8t/XRaGwKtJeCLjtx1saZffNKpVk2M4SVh62RT5KunKY8jEjBpYcjlY3v
         tdJrHjqgtqQ0MKYoSlA/kJ0cahIHr5NACzwavTBrSHPbqCfVCTeafHY0KAqLMOvOoHmW
         9LLkkLWt5EdcUr2dnHJHK4QlAs0gTvPJo4BJqLQAMq9IwosyDzW/j+rIUyBdYYXiO211
         cUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432452; x=1791037252;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcpZPe85Z2cA2oFhs90y1NZzOIJkDihLuGeCHukreQw=;
        b=jPbVhNUSRhavUB6BNw1oLTsNKyOQDWfPm6Q6RYXBMrfSCwqJvl2eqNZ4AE8yxYrdtf
         x1vWZnZGWTP3ond8A/L2bw5wLZ9+DGwHMyhz5IWzlzhl0N4vjcg8mtDsJCZv7bxxzhf7
         ohVMZe/B/LOM6DZljokiH2hEvXqzL+iir+4vaT6aoJbR375+4h3frEH7xzpHOZPS1qLG
         xIoSzxRdqU7d1oRf/jj1lCiheOHdNWyN+dpeXH0gvZKSyRWrDDnaHIHVMz0EJAp1CAhX
         uGOGKRD4Bs+J9+vOs6IaThrgKl9OwHSAPPbW2Aebjnm+83Addqz+RIewX/GymIZhYhsl
         Ncmw==
X-Gm-Message-State: AFq9FYJRutR1og5jcoFegUUfJpvJkPvHLUF7m0aDkZuiVyBhoEqqS+Kn
	nwtg8/gow3xfA7SYrsdxqw6OSoWi0FhHG/R3X2+u9bGiPIa3Ocd/0UMwzbduM7VJCV8=
X-Gm-Gg: AYBFou0hfhTcTQZQmhesXK0RoAm2TXfpGuCdQcKZzbDYouhn/oENHoPISbsQD3IE0fE
	TMiLH++VerAxCC/kk7YGF4vPoy64V7vrtJyYVjdLW/Il1w26UwFj3wZUsIWxrk56+w9PS5uI2I+
	NX25p7uWJQd43f+TBllwToTt6+n9HJ+jWPeqcZCn/LsPLoz7nrtBksxH3UxsMzNsHr+h32guQVG
	XwoZejn41Xqa0aKMzY9BZ8gB20F4qkqba7rnhgL3RW/dnC0x8RI0NNcNolKDJ2FZmtZjlWEFigQ
	V2yYNH+IxKr2huA2DQqWCeU6wUcUIamIY559d0u+q/vK32bvkyx/EgJ4g0zTs4B22M/JZxDhPpA
	6IsDsEh6Qz9Ldn4AkdzY0PbiJiqkoUaG+Rw6x4KJppd8cOWObAft7dvolbAeEoCILz79mxj8KJL
	C4baFOzOVO+Azym04VTIcn61m6oeh7Xk9/cYYy68GjuhIcRHxxbFh9rOtkTu9ociCL1GCORgH2d
	TMQCmzb0aKWgmwxSk8uogIk6EoLauwPk9JJ1Qz55A==
X-Received: by 2002:a17:90b:50:b0:39e:5c88:ce10 with SMTP id 98e67ed59e1d1-3a0bb443ff8mr4339529a91.0.1790432452075;
        Sat, 26 Sep 2026 07:20:52 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 06/36] bpf: add tnum_alignment()
Date: Sat, 26 Sep 2026 07:20:04 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-6-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Used by the SCEV widening logic later in the series.
The verifier checks alignment for some memory accesses.
When SCEV widens a pointer or an index variable, it must retain
alignment information in order to allow array access.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/tnum.h |  2 ++
 kernel/bpf/tnum.c    | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index ca2cfec8de08..16682248f963 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -134,4 +134,6 @@ static inline bool tnum_subreg_is_const(struct tnum a)
 /* Returns the smallest member of t larger than z */
 u64 tnum_step(struct tnum t, u64 z);
 
+u32 tnum_alignment(struct tnum a);
+
 #endif /* _LINUX_TNUM_H */
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index ec9c310cf5d7..1f620facd1b7 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -317,3 +317,14 @@ u64 tnum_step(struct tnum t, u64 z)
 	inc = (filled + 1) & t.mask;
 	return t.value | inc;
 }
+
+/*
+ * Return the number of trailing bits known to be zero in a tnum.
+ * Return 64 for a tnum representing zero.
+ */
+u32 tnum_alignment(struct tnum a)
+{
+	u64 v = a.value | a.mask;
+
+	return v ? __ffs64(v) : 64;
+}

-- 
2.55.0
