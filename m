Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88A2D7814
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149617; cv=none; b=ANFquEiXYlUVfnZK3aiWkMRDsTu3Yz/0C0wSFX06kpMU62G9QRAiMEBKmF+AZIu51+qtfJMO84rJJlZX1Vk+Cx9ZAmpDHHpjDSExD+OadFFj7vil26+v/C2lcJY8ttNHRgIw0a9heIXFKttmjdnY+HBc055gXizzU5viWIuUZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149617; c=relaxed/simple;
	bh=LwwbPqiGs8GnMTOIwIN4prJUjPvNnt8zLdIhfwKLs+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT1KiUMmpqqQvQrlV4GDdsOLH1fIThcLor+AWTZedwhimQ4ghR9pCcjrEhicf6gmsLGC2U/q7s1slwjkKWnkL2QWzgp1aWVNRw+5mrSNRfxnsIjoc1Hm0c4FO/oTHPdZbboU7F+cktKfS6+2zsLa90nCSiJanW6q8NGTDFdWu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkGbQyVh; arc=none smtp.client-ip=74.125.231.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkGbQyVh"
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-7e9feadef81so80561a34.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149615; x=1786754415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjTniCo4IH2rgufgWWcOfE2XKmg3xaz22kPMgpZcVoI=;
        b=LkGbQyVhSCc10QDQYhKJau/ygi3SkPR204sEPIQIAT1OjzlkBz89vaasyGKDSeNYBK
         xnRhOOQ+Kes55+Z4pfZtl2gtsLrTEEi/5byukWLQjgvW90BJrA/lFD7vqm8SxWyPfZ4s
         O+W+jnf7a1lyxRd2R9uHO4X1RFY3PG6wIWQSGdIRScuNigaKQk686TuEgPtrS5hR0x5+
         HNZkqA3t5ksJDIb2dY/eXZx4xqtxUEvqA3LJ6ZIs8lubt/TMAvLLHFAD0E0ISjXOLN7M
         peRawYMa76MHW2O70fdHcQ6Tn4lmk/wFfXhQ+tsOWStuhfijQydW9voGkh/GTb69/KfC
         XEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149615; x=1786754415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjTniCo4IH2rgufgWWcOfE2XKmg3xaz22kPMgpZcVoI=;
        b=UYlJ2JlMIJHNxx05wz2ocX5J4CF/Rggoq3exDAZQJsKwypchQrRtcemnQhGc8PmSbZ
         66mwmdKb2vb6myOyu3tD2GDVViTS9TmZMKm1bKLaI+Syc+W36b3BRj9bTB74dYkicQzj
         ottBaWqnDxNtcFma4BhizrhX40Qx5lU6V0lBPrSkk0iqOW/2Yq2pdVXg/zJWis65ZCh9
         4B5HMRuXGOSTIQo28r0lfwDkP6zDaX5PglJ/fgcV/8+ifUr/L0XFb3vNdbcsaG6a9MeH
         c38ElfSMJJsQ2P3znD4zr4fb8FEoFp307Zwq3XzWh+3GurZURw2v+N7qPyPvYy/ERULG
         AY3A==
X-Gm-Message-State: AOJu0YzFnUHD9i6I5leG3fe6BzNGxhqdkqZHO1bqqzj2xf4OP2nuQZz4
	sfnmthvwqAHLCDGvoyulFGj7d30j1LGJIOJjCm0Zi+MrLZy/KIoSKGN+WkiYaDQ66dI=
X-Gm-Gg: AR+sD13iiqnjtopjEQ8y76HmKXqnf0iAzBV9JVLme28De9SMPnUe7bExPtWt7YtqyLy
	jTjCYop1ZtQL6HQDci+ddXfXB/tkuJTCnuUz8ozpvVlSq6xGwLdF46bB9QXboU3BZ8W/dmxihs/
	VJ5j1JN9VqaMVpFOjzVa3w/MuYP1bfHkGkpzieg/RtWd4m9wluu9K2Fgc7TbxF0qgRo3i1+kVRs
	Nue9avwXc7mOm46F6nUjeRbNw3Yk27TKCE/mqKn9me9FVlz5EyWLHu/ifUIzBzoHqxbgw5W4qGt
	qAzSTLg4jWmH+SC0BLEAbrLpoauGAO0VHf4IDGUTtaEHC+aPrt8YmVeM2xG7piVlhQN4yUKS2rI
	RiAOKPc1kL3b8yoN665lUT8FucZ8HCqVLi0bjcVKDqQSwa4eNtk1IIGguImsIS37LvuD4tn3pK0
	5bQXDw+a3StcW/ZIGQB9aLNnVhi3qyaZGDNsFmtxuA3Z5bLSbLLj1g4wKlz6d4d1ZYCOJXATu9Y
	gi7I4xiX9BCHDD8W3gFVV8nYXcc1aFUIu0rJohWO12fJLoKj5SBJSWPKpsHPC5oIdMFjNs=
X-Received: by 2002:a05:6830:4393:b0:7dc:c4ae:a679 with SMTP id 46e09a7af769-7f1e5e4685dmr16302231a34.9.1786149615004;
        Fri, 07 Aug 2026 17:40:15 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5acbcbsm2363607a34.11.2026.08.07.17.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:40:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 13/14] bpf: Reject tracing/freplace progs for struct_ops with arena args
Date: Sat,  8 Aug 2026 02:39:33 +0200
Message-ID: <20260808003938.3486067-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; h=from:subject; bh=LwwbPqiGs8GnMTOIwIN4prJUjPvNnt8zLdIhfwKLs+I=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqmpHs3H4fLWFsRkft2rJZ/n5Ld8Tef+wbs+c35N0vrT8 va7XUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkcvc7IsHtbRHvEeq7nk18ud7KJWs rVEaZ/lenenH+nH6wtjO5Jk2H4n9ImUb/7ZtO2+A+9gYxK+/7P+KDyY+vh+4s++F25nHJzJzcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Reject tracing and freplace attachments to a target program with arena
context arguments. The struct_ops indirect trampoline converts those
arguments before entering the target, so a generic tracing trampoline
would otherwise expose arena offsets using the target BTF pointer type.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 74592272b124..4bb3102ae433 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19258,6 +19258,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Subprog %s doesn't exist\n", tname);
 			return -EINVAL;
 		}
+		/*
+		 * A struct_ops indirect trampoline converts arena arguments
+		 * before invoking its program. A tracing or extension program
+		 * attached to the main program would see the converted offset as a
+		 * regular BTF pointer.
+		 */
+		if (subprog == 0 && bpf_prog_has_arena_ctx_arg(tgt_prog)) {
+			bpf_log(log, "Cannot attach to a target with arena context arguments\n");
+			return -EOPNOTSUPP;
+		}
 		if (aux->func && aux->func[subprog]->aux->exception_cb) {
 			bpf_log(log,
 				"%s programs cannot attach to exception callback\n",
-- 
2.53.0-Meta

