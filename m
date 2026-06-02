Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF63845A7
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433178; cv=none; b=KBuWw+z/6QXUbjWnpP79lFWZyuhFY3EhC9P7h8+T1Ex08Ci6O/TvvQvyPtg9aAChzjWwqDLrCfJRYO5k3rFBhDxEMBYAmCN1mSrAFxgd7eIw15h67UlrRZSnbAcdRlfmqpYZvXrNS+nJq9zQT4CzOdPBJd9NAq5rZjE0VsDuYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433178; c=relaxed/simple;
	bh=ga1aB17ntL79MOPRtpxzjO6aLV18ItfeLCRtlyiaiAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSvANkZbXMVW4tRKX4VIF48j5uJ0GInLhY1Mait9K6kBGbV8SQrbThrPaJALKv/rnYug1pv9tOV7n1N8rbvP7Stk1kia2kjiyYrtS2nyPfgu6+H/rgJ0FPosGrlDqtDwofZvYEGoOB3gYVT4IFYmKFktxIRRYH6bkv0VUHRzyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2ilUoOm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2ilUoOm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b3637b90so9486755e9.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433176; x=1781037976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vimfmm1FBkLbHULTqa6OxnSjhwN21YXtlrUewdCK/TA=;
        b=V2ilUoOm9Pb/bEfdoWRw53G4FQ+9n6VACgeO/QMToEemKpbitpvzmeZrdosxnDjB6Y
         xQNUk8TKEzGwWkri4ihZsJWa7uYDPMurISyUUrcN9qaGLYdjJpb/IUJ8051OowENY8bp
         /JWww5jpnCTU/MOw232JTG8YvI44sa72EtLayMwm2eB3PP1Vb/x5eKVYesfdcB5rzFha
         xnOiBw/ihH4VdTheh5pjWZW8Kpg7JnIasX1B6Tu3+h+baAlmJj2QzDfjgdRaYKs9UR7r
         ebO2pCr432T7/TNWmvy8oXRVR1zpMuwzDqGLajr3CDJ/W1LOZ+mgLMnyA9k717Z8tlVq
         D/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433176; x=1781037976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vimfmm1FBkLbHULTqa6OxnSjhwN21YXtlrUewdCK/TA=;
        b=CIPyjIVySVpORPp5+tPwzeOYt4hF8sV+0Y+zAeYn/kT4HI/fcMfATZRwB9qhlp2xCV
         D75EESGVI0YBhA3dkLrbEJo7nPgjotfI3zoNwlQNdlQF/4qw6dAh3WvvKdyFEitlmQyl
         EgwXhVCLOHtzWyPSOOTwtXUuhNgwmWYSuHwltmDhdfYGbHJtlz3uN20uNZY2hU42SPm8
         fgX8N7XXgx9DPjAtIq2ZzP8gSPR3Dabo3ioKo3OTc5rTxs63YDcB9gu/vEFVOSWBywrP
         Wr2p8dDICOGiin8U69VQ5WUz4zxkYHGk+6OiVuZpDi/Bd3CjdNoZQz5/O32gMp8TRScj
         22yQ==
X-Gm-Message-State: AOJu0YyS4Yvfl/+k5AzQ8mFkgtQcFelp/T4pJbVP62QRVWOWbzf23nWs
	5e6YOvc6jTRhTKvI3xZXCR3ofJyD1y7iLU3mq0Cdf1yDwte7W1S4WLEH
X-Gm-Gg: Acq92OF3OZpjOUlpgIDD7pnP6l85/QacGurnOnpqfqFw96Dl8KIDX3weS6YKJi1QICS
	X9fAiB2kFGLm8VZCY2yVIv5mCj1Ua+OZ99fvQE3NzGyow/Ruwyw1Cz1m+GcHW1ArJs0bpQdR8uT
	EGPdNw92Vd6Sj/Z/geFLUoXciong/EPUmfHHIE8NFApSoT6HyHz+lX2qlNt7KAHMEIiYzNs0TNB
	R0SKDKPRw6AkKMStBOu0ejxPYrXLKQ1t+Li2y82GK9WJ59JiFiM3/psnTSp/ftKLlehjtNvAhZh
	az9q0vj4aNZXS7PPiksQfV6UMQG8uTlqMMru1oMKVjbPn6yI8QAREh74xrZThWb+rrHwKaEg7qg
	SNOMdG/2DPSh0O1ZGCeozzrz+U1yV3e4B1l2FE6r1D2tm3cb+5hmoGJluLLDI2Xr80VbFGBhXE+
	327QnHppBRiwaEBsTNj1KD9++a
X-Received: by 2002:a05:600c:c10e:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-490b5e839bdmr6027175e9.4.1780433175845;
        Tue, 02 Jun 2026 13:46:15 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm2219233f8f.24.2026.06.02.13.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:15 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:36 -0700
Subject: [PATCH bpf-next v6 07/11] libbpf: Support resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-rhash-v6-7-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=1419;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=eiArZpQjhMU2X8BztxYH8ee3r0EFLa9BsZJ65DtQqCs=;
 b=zgsAE91ByDFu9flxRgBl7TCEyOzyzp0DjgUyFrIP8+ij79govI0+e9q5EfixgJIIezZ3xDx8i
 5jRb4LUUF74BA/iLWeo7wedPsFgvcvHln2XsMB/ARXLH6nM/q8I9ylP
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add BPF_MAP_TYPE_RHASH to libbpf's map type name table and feature
probing so that libbpf-based tools can create and identify resizable
hash maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ab2071fdd3e8..1354bcbc8b30 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -192,6 +192,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
 	[BPF_MAP_TYPE_ARENA]			= "arena",
 	[BPF_MAP_TYPE_INSN_ARRAY]		= "insn_array",
+	[BPF_MAP_TYPE_RHASH]			= "rhash",
 };
 
 static const char * const prog_type_name[] = {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index b70d9637ecf5..e40819465ddc 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -309,6 +309,9 @@ static int probe_map_create(enum bpf_map_type map_type)
 		value_size	= sizeof(__u64);
 		opts.map_flags	= BPF_F_NO_PREALLOC;
 		break;
+	case BPF_MAP_TYPE_RHASH:
+		opts.map_flags	= BPF_F_NO_PREALLOC;
+		break;
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
 	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		key_size	= sizeof(struct bpf_cgroup_storage_key);

-- 
2.53.0-Meta

