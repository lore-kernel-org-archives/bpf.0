Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B637C0F8
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010845; cv=none; b=l7l/FIar3qphBudi4O0lelCeVZAO5Sf5B/DMoYEdjeVVInGnRvtAJZqQ6O7LYapdLi8IPyatgMyv7wk3n9FudCIzSU+7BVGeZ8YMQ5+/jI2apnjQ07GDmSW5uBOVyoQ9cJ+mmYSnJZcTflzJ+BZe4HSWdrZZK/LMih9b52jSroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010845; c=relaxed/simple;
	bh=R3McmVYvDRD9I77uQQcNO1g3VHISEkneMyLCGEA3TB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fmm4r54W5swk5b+tsF0QovjX+dWqySKfAmrOgnwonadzkcdhy3+HRg+TSxbqJNMK3JzjZ7dCMZkTnmmxc9yG6sRlJVSkDSyF5M5VHiDcgJ2oMnvFM6AbZ0kGS5JIU+o/GWqvt2MCrN80bWp4hYuKxG3H1EGkP8CT2TeHpGI6lwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIT/jo5e; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIT/jo5e"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8861544696so880579166b.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 01:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772010841; x=1772615641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AfljrNH9qdxqKmIU4kvMc13BAHxSq/ttgbIGBHEUq/E=;
        b=dIT/jo5eS2nVFQh655OrNxr2bxmCHO3AiR7gQGRcS/JoG04NHCloVg4dMvTze97JYQ
         ei/4Znp+dgVz8H6vfYPVjPKrfwp0Bj4lgbygY+Im/C3tC+22hpaOsWRn7hJCGN8SyMl7
         TBf8px4wQNbRwXPnMbG8wJzFfplW6STA13NJaLNuWBGahDRDq+sg0OJbZ9em/zKLtwjl
         OuyWFzSaBjepSB+1FaH8nX/PJkcjoBhj882WP8B3LXZ1k1HRKRUs6Ia3hpfMc786EiJE
         Vnr3iIn+eSQBSdoq+RfTDLhXYHlxo5OulUsfC+JD75fXbSvNNXCorZ66Yf1cVvIFtXUa
         j56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772010841; x=1772615641;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfljrNH9qdxqKmIU4kvMc13BAHxSq/ttgbIGBHEUq/E=;
        b=Kk/BQ2dhJmajRPJD0mAKE6INZV33lavfww22UeSaF6E1fYSrA/jpV9O+GaZEnsBmtP
         WX1dB3oMsFnQYjRmVref56wcfR+2B2QrbcXR7a7lm/YfGVhHDUXLV8R35jIYZTMlTn9D
         F28k3YXiocN8oPb/fK4H+GnWgsGp1X2hWIkktqKhYdNvtL7j8nnUlRwpDahwuxQFht9J
         akHsnttrKkgyD3pmIwfblrXtmX5tDNvTzdhJ3ydWe8IwXjm3BScfqbN6+/bzoacTD+BA
         8X/zfnU7bk8FRoUCRaOrhglzm25UG+N6/f9Taxy6Qruiebo0bNOrLcxJbbd9HLNHlMZk
         7UNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6NAU90iL2UjNe4ok9GoBmXKfQ52UP0ypQ3lkJ580jpf3ouvRkqG4S+5gfX+zFdDFNCic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kJOsh2NQlrqVxBxO+HcMyQbOI9NMLXraJz30yXs0C301ykPm
	dil5N1H1yur5ZUXhJq2O7uSuYdeqhBcmXiFjMR7y3/mssG4EDkyfzM0yJV00I6tQTKB4aiyvj0r
	ZWg==
X-Received: from edvb20.prod.google.com ([2002:a05:6402:1394:b0:65a:19ec:9a9f])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:d06:b0:b8f:a26e:dec4
 with SMTP id a640c23a62f3a-b90819557c5mr995121566b.7.1772010840499; Wed, 25
 Feb 2026 01:14:00 -0800 (PST)
Date: Wed, 25 Feb 2026 09:13:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260225091359.3299924-1-tabba@google.com>
Subject: [PATCH v2] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
From: Fuad Tabba <tabba@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jean-Philippe Brucker <jpb@kernel.org>, tabba@google.com
Content-Type: text/plain; charset="UTF-8"

struct bpf_plt contains a u64 'target' field, but the struct itself is
often placed at 4-byte aligned offsets in the BPF JIT buffer. This
causes UBSAN to report misaligned-access warnings when dereferencing the
structure.

To pacify UBSAN and signal the compiler about the layout without
over-aligning the entire JIT buffer allocation, mark struct bpf_plt as
__packed.

No functional change intended.

Suggested-by: Will Deacon <will@kernel.org>
Fixes: b2ad54e1533e9 ("bpf, arm64: Build branch-target-identification-enabled BPF trampolines")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 356d33c7a4ae..fc8c74c29bd6 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -98,7 +98,7 @@ struct bpf_plt {
 	u32 insn_ldr; /* load target */
 	u32 insn_br;  /* branch to target */
 	u64 target;   /* target value */
-};
+} __packed;
 
 #define PLT_TARGET_SIZE   sizeof_field(struct bpf_plt, target)
 #define PLT_TARGET_OFFSET offsetof(struct bpf_plt, target)
-- 
2.53.0.473.g4a7958ca14-goog

