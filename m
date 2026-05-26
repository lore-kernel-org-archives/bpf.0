Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D003D649F
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804941; cv=none; b=E40g9lO71w7lTXLHXt+bFwR34V3zbidy1I871DqHDhfAMV1AVpFBXwwvuxH+ziAyHsxEJQ/0UQvKRRZUf8OHFOfuLFmFs/Bgy5CdR7NtatuhIoH/5Gv/MjFytLDUicUJuwCl1M+scJ/JkI+L/AHvZsD1OmgEUKRVVHQ/+w8cqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804941; c=relaxed/simple;
	bh=r7zcdF8qutzChq8XLk+oXcsBhNew8W4i+fhDiWfimoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uzP+A80yJfLotqG0f7ytLd1DQrfLTTlmOSy5RvYtVUGC7KCkuWmQGWrnikJCfXbT51ilIMmgybpcN0gqoTaYOtcVjammSKCQVrc6HQIiuPhffcgNYI5nKUgRaC2zbr8F3u1xYVQ0u0AXOK+5Ds+XJ/En0rIo7z+p3TzZOD6p7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iteVPtF3; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iteVPtF3"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-688b057233aso3503379a12.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779804937; x=1780409737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ev6aA3Xe6T1Sew1C3oAjJbhgzPbzt+OHYmVBfkfyNE=;
        b=iteVPtF3xk7Ykwf3qZcSj32wywLJxB4dVFfRcmAf3qSilkwNIgq1HUQrw6KWKMY8z7
         7tA0rz5Xcq+uQdEZizE6qLbUZ3vAXg7nZCu7iMlmur/4pAHN3X0jKXE9GOPZqlF3MYm4
         62UCsEHMguB+3KGhiDCuFDtyoQL7MSuuwkWAl9sya5anOe1ez+zcdA0SHR8Ku2rgCRpG
         qSsKg4nRTxMPQ181DIinvajfdOogb+TJURR5z81piKwmxvoi/K9Pa9KmzBRypPGKUrA2
         0YDZeWFyvuunCf0gZP7V88kmkT7CW2BOTtkJ3wOhR+MhDw/rbuIAVU2CAvUE2QhOF4tA
         81Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804937; x=1780409737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ev6aA3Xe6T1Sew1C3oAjJbhgzPbzt+OHYmVBfkfyNE=;
        b=llyoNFL5qAtftOST+yei27/nSvy9H+tD2GM0sUETtxAyPdZZG1aqiOeWZl62nn618z
         g4u9PAUrEoB0MqK/kivI6e6K7DSU5a56Uf+Z56f6+oHLvckGQMJOl/mj8DbJxQsgvxkN
         FtRZVLwxw6zkkQ9W2firpiY+n+wYp5UWD/zAJ7kor4S60WPCCfp9epbWwt9jzJJ29hqW
         rM/fQCXmZ8429SN3JCMQ0nc9kDf8Qa1LYMZf1NRgA6nMHIlk0nZLhLQY9Uco3aiGHLWp
         PYOVAkn1qgeOg78ccr7NDrqEqpPoQcn/iB79E43wiMwlcdGmJeP2qdc7hvVkI6wnwi9u
         MPGg==
X-Gm-Message-State: AOJu0YxReZI1OoDptu1DrcRXNrFlbm9Kvw6qFABFGf7zOfc88UUTolJh
	Y8lX+tuXiEkNNtDs7wGy1PYtP4twwo1pkC5grALuR+OqhEgMvS3ukVNswbrW5ym00Z6K+JsPrEd
	+2ikVjYB/vfaOhgXO6g==
X-Received: from edk1-n2.prod.google.com ([2002:a05:6402:4041:20b0:688:fdf7:74b0])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5293:b0:67f:97eb:b0ef with SMTP id 4fb4d7f45d1cf-6889c476e4cmr9916226a12.15.1779804936629;
 Tue, 26 May 2026 07:15:36 -0700 (PDT)
Date: Tue, 26 May 2026 14:15:34 +0000
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-1-5b4fa2a5e1a4@google.com>
Subject: [PATCH v3 1/3] libbpf: load vmlinux BTF in gen_loader mode for struct_ops
From: Siddharth Nayyar <sidnayyar@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, gprocida@google.com, 
	maennich@google.com, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

During light skeleton generation (`bpftool gen skeleton -L`), libbpf
runs in gen_loader mode. Previously, `bpf_object__load_vmlinux_btf()`
completely bypassed loading the kernel vmlinux BTF (`obj->btf_vmlinux`)
if `gen_loader` was active.

However, BPF `struct_ops` maps (such as `sched_ext_ops` maps) require
resolving the kernel-side struct type IDs and member sizes at
compile/skeleton generation time. Without loading `btf_vmlinux`, libbpf
cannot query the kernel BTF types, causing light skeleton generation for
`struct_ops` to fail or omit crucial type information.

Fix this by modifying the check to load `btf_vmlinux` even in
`gen_loader` mode if the BPF object actually requires kernel vmlinux BTF
(e.g. contains `struct_ops` maps).

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a80a018fc7d..cb1b7ea884a7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3590,7 +3590,10 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
 	int err;
 
 	/* btf_vmlinux could be loaded earlier */
-	if (obj->btf_vmlinux || obj->gen_loader)
+	if (obj->btf_vmlinux)
+		return 0;
+
+	if (obj->gen_loader && !obj_needs_vmlinux_btf(obj))
 		return 0;
 
 	if (!force && !obj_needs_vmlinux_btf(obj))

-- 
2.54.0.746.g67dd491aae-goog

