Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780F503BD7
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378443; cv=none; b=I5MzVPk9Ms29hocdzxD5xOPl4kAoajrxgz41nO6m6qpB2BwsKkEP6O++/Ff1x6vOlYtxOFq6v0lPwXNUuoXZC6E68bM0An0d5Ah9Xt7Spa4s+ors2Ap4x9Vx7lJM6QVDwNtEU21lru8mAMgN7z0fYi7Ud33/U7WvZygd12wCG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378443; c=relaxed/simple;
	bh=mnr2716YaHPAO0nVOSdHC3VsliESQNKqJupXjuPmYD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oc1F+kQxfQjVWA+VhqLv6Lhy9OeOl9VR9C+URNq+N8Ohi+ehV8LZ3t27HaV13usfXK26TMNG1EW+wutsvBKm/l9pQJUf6m51QNwe9eaAqSwvDpXrQW9QNbceOiIvKCpuhsRdtV+DvcR/9acB1alLcNRILNk1QfXBYSyXtnQzYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=pass smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks.com header.i=@anyfinetworks.com header.b=eG0OZXE+; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks.com header.i=@anyfinetworks.com header.b="eG0OZXE+"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8eb39a8edso866003e87.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks.com; s=google; t=1790378439; x=1790983239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=olvTM2tN3VJg9EC4QPtcU4S00qD0Qhx+5j+KpH00jBY=;
        b=eG0OZXE+HDfyTTRd8OhYMu/SPKKQ7hAHP/UGAvY7wIr6uIBvFpPaH4sCSWo7uJFgum
         lR56AYZKtA1yom0ftqQlLkPVQxbwO9PCjNWE46wzG13S0DExpqxVlMlsA1H6D+Ey+07n
         YHnny9nIdA4y3CVnJN+yol7SlA92GIJAbkErYNEWUbM6B3A2pzhTNoRqNtXpX0do+wuO
         DshpeRNrlYnDdpPiw6LTDMFvO6j9SA2JUablqsPlrMUT8b3bU7MYpRu3lzPtw0TtgjvN
         5lBGWHii4qhpq+jg526tZqK9hFYy0FDnsvWCtLNTIkPJzpmyLf3GGUa4BYKnV9O55Ikr
         Z3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790378439; x=1790983239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=olvTM2tN3VJg9EC4QPtcU4S00qD0Qhx+5j+KpH00jBY=;
        b=NEsT/MWerPn9eLq/hbi7tljz+XIGk0FqvM14/MlpPl5SnhT7+nTcMk5efI+401m+vQ
         3XxdzUrEJjHBVgr43JYFWv5lRx9MxZOmgKoeQqJUDpaZ87bzvOyc1fUj7Jvm1V9l35Jw
         Ahpg7wG88M5QtvAEEAZsAqQKlTVhXD6737dqzEgga7CdvLFFjcnLKrh0dxIaOu81q6MT
         0k+1jkcE0q4VIQwSIsG5ilYwq89ETiL4ijvRzp/a24DpqJDXLhPGuOu2z0ib5uJoXcgi
         GDtsEC8zvyCN9TuVWHBzaX7wO/rbUJvywDzpKnao1BAP1E3HAbkJni4r3JjNMMZcM2Uo
         ftZw==
X-Forwarded-Encrypted: i=1; AKwUvBz8Ic25InB8X3RtkrmFzD9T6u7bTVB0nLLjzSyR2JBsqOr6+jBeoSQ/lEq+Fs6r7HNKJHk=@vger.kernel.org
X-Gm-Message-State: AFuF++ml1mzBg9+j/UxkF1Xg1aDA7Pm8D9EXzCKr6jbDtl62dHYkU8fy
	TmfGXTYk6AVSeNNMce7v4exO04DROBon2UUoT4qKi8gi5xQ/u4DYcHSWybZsuD0Jo2w=
X-Gm-Gg: AYBFou34UIM62CjcHPCBPpgtkvpqU6cA465QIqcoDYsM1uLy6/ZFmCpDiBOX8g2FLvf
	A6IuWH4V7b54SfQMWaA667XSGfM/e+9eIOlBHyYKq/prTYzB2vVsC8SYPJM/IKDkM4uz5FKyPEn
	ZqrISihlremwfuu8vJNOMVjsVURvvoP5ufROQHFRKBQ4MimsSlL01MU9VjwMug2HpOZKZZxyy4Z
	ivttTF+mnGD3q51IhsCto31qECPCaWM3OHxq4QbnGa2JkAHsnpO0St4CSxgrbf4UHBhdy2ctKT/
	I+i9oYe0WhUWWdALEB+3M+XGa6qAm5zi5LBPWjEEoKym5devsu/1N3Kks6nSkM4WHh0QN+LWYcu
	knsjIUJgvlXUsauCCZAeCdwDVR7rME2Dr/EYnAe9jiA8b88cLov0XEV+RluZa1SpLT9w0fwIC7l
	rzYIyCLviNRM9yjXypK1E42dOEitWNFjGKIeMAf0A6zx9cmJuDsjIOXwur8xtjATxirxi7i/+85
	HLp0n4B2D43U/zsWPydJ/F2jY77B95tbhuxt64ODmo=
X-Received: by 2002:a05:6512:668b:20b0:5b6:1a7c:59d3 with SMTP id 2adb3069b0e04-5b8df0d0059mr1857582e87.45.1790378439335;
        Fri, 25 Sep 2026 16:20:39 -0700 (PDT)
Received: from nuc.. (78-69-188-101-no600.tbcn.telia.com. [78.69.188.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6af81cfsm875260e87.40.2026.09.25.16.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:20:38 -0700 (PDT)
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
To: tsbogend@alpha.franken.de,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	paulburton@kernel.org,
	main.kalliope@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	philmd@oss.qualcomm.com,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 1/2] bpf, mips: Add JIT support for unconditional BSWAP
Date: Sat, 26 Sep 2026 01:19:31 +0200
Message-ID: <20260925231932.1063678-2-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925231932.1063678-1-johan.almbladh@anyfinetworks.com>
References: <20260925231932.1063678-1-johan.almbladh@anyfinetworks.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unconditional BSWAP instruction from the eBPF v4 ISA was not
implemented. This caused programs using the instruction to fall
back to the interpreter.

Implement the unconditional BSWAP instruction.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 arch/mips/net/bpf_jit_comp32.c | 4 ++++
 arch/mips/net/bpf_jit_comp64.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index bbbe4a737825..158e69718c09 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -1701,6 +1701,10 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MOD | BPF_X:
 		emit_divmod_r64(ctx, dst, src, BPF_OP(code), off);
 		break;
+	/* dst = bswap(dst) */
+	case BPF_ALU64 | BPF_END:
+		emit_bswap_r64(ctx, dst, imm);
+		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index b04b68fa5ace..8359ad3f6992 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -876,6 +876,10 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MOD | BPF_X:
 		emit_alu_r64(ctx, dst, src, BPF_OP(code), off);
 		break;
+	/* dst = bswap(dst) */
+	case BPF_ALU64 | BPF_END:
+		emit_bswap_r64(ctx, dst, imm);
+		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
-- 
2.43.0

