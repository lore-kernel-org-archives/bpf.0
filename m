Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A137B036
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812270; cv=none; b=mAu6ZHSgjNBO60Kk/U3v2u5td6G8ZWuAC9JFT3Lv0kckVfA14cO4pdZg3GhwaT+2FLIQEExMTbpznK7Py29B+cXdxkNqTRla2lSXTLWm8dnRUhoPYgz8hWFodjE4HVoMT2U1W9MTJgAkrTP14YdxS5Nf5MN5ThWQvjM+5P2b2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812270; c=relaxed/simple;
	bh=8SMkAqyj4XDGjwe99QC9Meej2GWQwsvGXdhFZXInRFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azchWHQ3gr3uF4FldQZV7vPedJI7eacosjS3VoyuAeKdZFP3/5Zzg2Hzf5+BvBxnpKdz9TRnq9Xu9umThX4nwGqroA42yaB1IXGuCweVC4UihCKBCLSUwIqzoXr2DtieCR+z6LtHa8ZMaaQknHOGzFMiURga5VcD5oDuhLwPScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGcFugxj; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGcFugxj"
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-49e2cb73ba3so732690fac.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812268; x=1792417068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2TA6s7HNT6Ke3bahJ4TDSgpdNnFuQbfCaq5PpS6jqU=;
        b=jGcFugxj48H+KFVNoG8LMjjYgRGEwOFglE4EXqWezyYPN26543KesAgTtwHe4GMF5K
         6Ih+TdoNab0zJQjX3NP9Hskb6OItiIhjXqdR7oKEae7ENzYWpaKwyfO0b86bJS1U1puV
         K/nKbP4wKLJEVrvF00vnqe0owcJQ1E35U76zLIwa88y6Rbgu6oQ7Xc1v/LAW0C0GBEAG
         yw3Po3422HpEa1dDDJquGiWqcKGhOfn7/Js2DRIJtSzdY203QqgYwbe7lXOSlnx6KzUD
         3KAM2/zo/AmW9To7G5M3/wtaL/xa7qqkwcFm0SQQxiC9bPuOt8Ds68aziaAvKydMNRCJ
         b5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812268; x=1792417068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2TA6s7HNT6Ke3bahJ4TDSgpdNnFuQbfCaq5PpS6jqU=;
        b=j66HOsOxSkll2HWmSodr0P11WYbOrT4V1zf3eKtUFU5DNoaBfzkblPl+M1T79Ake0s
         Fe5UD7KgOUAPiu/1HfoUzynroz3E09J9989mEYnMbs/wFZCSMw+HOcvKrQi0YuyPXOLW
         34F7FEY2BOmteCf1Uux3f8b5gCOllhnch463Y1hfhokJCEbWATBt7nQaozfTMBmYgGk2
         6q0f/sri8UeUrt28O0POsifPClAxpOlrGSJVFZxJCLmqDDNZIlB0U1INbwN1Wabx4nUz
         oVevfMcY0xodpKob3UGII8MLFP+RUknt4y+pIC3R9s27UsHKifL7j7K2m2+VryYGaK7w
         gdCw==
X-Gm-Message-State: AFq9FYJVgOfeq9azlvwxRpoO0zR39q73RL+6W0sX1QfItJKSqzTbrztU
	rsM+uPMxc35Kew9iFV/GVL+YL8T39IfURiPOrcvEHNzhS/BEapp78+39z8Ucjxk5Ia0=
X-Gm-Gg: AYBFou286nQeRHS0blExi3JCEN75eoBpg2ah0aebodnTvBaezil0MnBPYBPiAnHKYl5
	tVzZXJirZtRNVSPMWc5l3/ipdYaehHFzlvFpSEdDKa4PtfHogR1PHDdOpw5gw760Sm0NF/TRMNV
	2z1XtZGZSGbRTSixuxjkCyKYcgrkZTaYNEW9srklvfdnanDrBNuoWyJEo0rqKE3N1kHHhnsSK3I
	prZT3rOr52wdXINCT6FFIC8RNSxGbJ6JhvTtiVyEIO/dj/aiLP0fSOfATQehSiV66pDjWtDYuFO
	TMjL4/hyBwBiHCZcGDnIa0ZsXoQbXoXHIyUldZdS1BuhQ9t0ZP49RvXO0QGCZ3ub8k9xcMxknW6
	VjNKKGo9hxcQYustOz05oTyEzTLPQh/viFUzSr+pxxgqK2oNP2XK81qbpbMCXaVgOSLZHkspZkJ
	Pw/u9IJnSN7N1k2YmGQ1e8YFHlo6UhLl13cXVLwEbEBhXolbm6NnmvH2YMWuCWDRSS3ugWpk78Q
	FJz3Vj6QaaFX1vRJgHpLFbMNSJchXSgpFsxGloiVE6ZbfQ8BcfJa8lRwwQ4f31O+pF7J5TWz3qc
	YroYog==
X-Received: by 2002:a05:6870:e45b:20b0:4a6:a925:e13 with SMTP id 586e51a60fabf-4a6a9251d65mr937915fac.14.1791812268120;
        Mon, 12 Oct 2026 06:37:48 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a865a441sm8419380fac.18.2026.10.12.06.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/10] libbpf: Render the arena type tag with its address space
Date: Mon, 12 Oct 2026 15:37:06 +0200
Message-ID: <20261012133711.4030594-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; h=from:subject; bh=8SMkAqyj4XDGjwe99QC9Meej2GWQwsvGXdhFZXInRFY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMw7WH73DI1d4K9H+9tPbOXn2541KipbUz9/xLPB114fqx Y7vcO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRzyUM/5S9ogSWpmzW2eB2VNvi+O t1y8IDdicbdp4puSFTbvO7qoXhn3XbyivepXva9wndYRU1bX+2el2VkNR3dubSSW8c1wspsgEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A kernel struct member tagged __arena reaches a program built against
vmlinux.h as a pointer in the kernel address space with the tag as an
attribute, struct scx_cmask __attribute__((btf_type_tag("arena"))) *cmask,
so the program casts it to the arena address space before dereferencing
it, although the verifier already hands it an arena pointer.

The tag denotes a pointer into the BPF arena, address_space(1) to the
compiler, so render it as such: __attribute__((address_space(1)))
followed by the tag attribute as before, which keeps the dump faithful
to the BTF. A program then reads the member as an arena pointer and
hands it to anything declared with its own __arena without a cast.

Nothing else changes for consumers of the C dump. Skeletons strip the
modifiers of variable types and never carried the tag. A compiler
without casts between address spaces still accepts the declaration and
only a program touching such a member would need a cast there, as it
did for every arena pointer before.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 996e61b5f11f..7dedd3975c39 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1595,6 +1595,9 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 			name = btf_name_of(d, t->name_off);
 			if (btf_kflag(t))
 				btf_dump_printf(d, " __attribute__((%s))", name);
+			else if (strcmp(name, "arena") == 0)
+				/* the tag denotes a pointer into the BPF arena address space */
+				btf_dump_printf(d, " __attribute__((address_space(1))) __attribute__((btf_type_tag(\"arena\")))");
 			else
 				btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
 			break;
-- 
2.53.0-Meta

