Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69837F8B3
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278127; cv=none; b=YYLPrXhpKk6SwycZ6fqHO4QXZpLa3MwZxtanEKTu6wrt/8zJgr81KUFHITNoMwe4blDrljlT6CH6eTpIBY9+dF8SBuEEJxCdvhFMV4ai2PPyZ/mp7T4tMbKM7g45Fr0nxwe5/AvFO59hBySjJRsPZm1q4qqAmNuedEnFBgjw010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278127; c=relaxed/simple;
	bh=pggxb5klrCa31iAHEsZWCNSyt4ephJB6XKes0lC1k6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhzBqdTFtUik6Vd8AEBwSOaMUgUFxA9kId5NhZv3moY79ufw3xTbZogadN8g4HYVW3D4/a1wyWgz80Ul3Cr/+gbcTsTgBaXAI8v4KE2taSKqQJEUm19+9ujRfVgIfmvZKzHrlTfDqfA0KaX7pKVI8GHjcCPUPdQ2Wu9eeuW7qQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyEnuHnR; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyEnuHnR"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c156c4a9efso9713717eec.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278125; x=1776882925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zru8FySz5AhiaWwf6Upr4P1h7py/Mu2zPj3hDHMgLYM=;
        b=DyEnuHnRLKdUW1s4KNUZoXnr484UprREKCc2SML7w6XJsGOixlVo0j/Yq5AMGlxWUr
         MDYPqRdxuYvGhnOjTxjVq/OTmClpgGZFPoddUp6SZqxKkxa9hV9yRo4fZ570OFcc8Cnv
         njAeM2WYbJyd37/2qon6pXvXcefGcDkTnWNdv3oEw1dTEo2v+mDbguVeUR72rmOSVkWP
         gxtO7lDQ04JL3oOAch7lCk97XTYoi3T9bzLfBi+f64c7urw50xJT6T8ObM3jRCYNGias
         rpOVaxIws/qSeiecYggWr3mO/pgBHoyhIMLBCqRPVLNrFi8kXgvXHEJBk8UGN9OtnD1D
         nDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278125; x=1776882925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zru8FySz5AhiaWwf6Upr4P1h7py/Mu2zPj3hDHMgLYM=;
        b=cneUJe4CAfxOFu2gp5DHyOAZT4feDso7rJEKVsWh1Ca0XQ8Z7QDANivuZppiFA4IRe
         GfgVqVYVmRuKwgPkaP2pXnNYFWlx/VeWGXy2HDSwYwEHA6N38Kaf65vKrdLQD6WnTqim
         mycFkjs13lZ2lOLoWEaJzMi7S5G8IdrHmfalPKXQw6JkHYK/est+z9GwFQFtP5uNp7rA
         5o3c3UheJFrqxE5wRJFwIraqxn/lbLv3F4wM69r33bXpVeZ2Cz0+KtXGM8/5zhWnc5Ex
         dRga9VRJfJwhkIYYTUWktogSI6Iw2EfTkHiCH8GR/1OSmrA2iMiyLOHTv0DYN01EIDjJ
         z6xg==
X-Gm-Message-State: AOJu0YwJ4emYHpG/gMWWGzhc4Yj04eaIpEtobPRpfgOBroBbQul9OCTg
	TDR7ogS64zn5BsdPaBJamksBIcMbsmG/Jjq+OW0N81MnnVa/ONNrLdUW2CVEiKZL
X-Gm-Gg: AeBDieswjNEropDwrhQvz7BVgFLqwvJzZtm0pt6n437ogvk7y4AITl3o6FftDeJ+AW6
	EiBuLDY8TroRr+eQH4IeF+yKJpWkNe1SvbqlhPrGdYq1PHZfNMV+48TuZLRgTKbKHq5YXq6rH/K
	5hoZh6yrDLaIJOeu0XYdnJYNv7ypBqSg1e/QJTFm/t/qkz9PSCNeCAxW/VNAWtQsBtgabj4RXB1
	igpP4Hj6uSaBtfFFiOPGQAdSmhdpntMU1uupVBRrJXRUganuk5KRbEm+hkyXSAExpngVgUBXKd+
	hHthejGqCWozH1+8lAFdZQbv38HXHVaj160vH6KMl7016AIzU6+0zA12iftaRYkGq+d5sntXEdf
	ngsMUL3hdxd5VBP6cLO5N63MoUljqStEvmKqyTPqcgbrq1t9V3HMMmh+EShYHdWdlpaKt23JjZc
	xArmbVGngsdUjMOtyaJIvL1Jl0DKfIsRhCSuipeRiN6bfLy3I6jnYf1+7bx3GZI+LC4jpnGj25O
	lbi
X-Received: by 2002:a05:7300:fb88:b0:2cb:7663:322a with SMTP id 5a478bee46e88-2d587d83e1emr13023185eec.13.1776278125116;
        Wed, 15 Apr 2026 11:35:25 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f960dd1sm3759720eec.25.2026.04.15.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:35:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ctao@meta.com
Subject: [PATCH bpf-next v3 1/2] bpf: copy BPF token from main program to subprograms
Date: Wed, 15 Apr 2026 11:35:13 -0700
Message-ID: <20260415-subprog-token-fix-v3-1-6fefe1d51646@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415-subprog-token-fix-v3-0-6fefe1d51646@gmail.com>
References: <20260415-subprog-token-fix-v3-0-6fefe1d51646@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

bpf_jit_subprogs() copies various fields from the main program's aux to
each subprogram's aux, but omits the BPF token. This causes
bpf_prog_kallsyms_add() to fail for subprograms loaded via BPF token,
as bpf_token_capable() falls back to capable() in init_user_ns when
token is NULL.

Copy prog->aux->token to func[i]->aux->token so that subprograms
inherit the same capability delegation as the main program.

Fixes: d79a35497547 ("bpf: Consistently use BPF token throughout BPF verifier logic")
Signed-off-by: Tao Chen <ctao@meta.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/fixups.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 67c9b28767e1..dd00a680e4ea 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1110,6 +1110,7 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
+		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
 

-- 
2.53.0
