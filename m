Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291B3932E5
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779621989; cv=none; b=WjDfdl94ZTjabNC7oeIXxn3iXOkfd01aHVVd/R/Bq0fAjJWO+9+nS+jrRwl+ZqkbyVSLklGpXzT4OjhoesR4JmRvYOFJerou2Yn2iqjWmJjCowi/Owchnv9S6vvlMD4d4vdY6oVt5MtyJaKc65sz7YifzmAV7XueMV6FMFffUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779621989; c=relaxed/simple;
	bh=ExACihDekxLSPsqgDibJrobiJD4XJFS40y6mHhqXPT0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MNK1jZP16WMdaHn9m6AFAqnPVtym294tUopzLwTEadPx3g7J1B9gkrg2kyQTA0/XK+P6n+2EskXPGMga+ypM6HWJV+nRxScaxeFWEZCy8q4m3jetwxCYLOtH9B3YBuJGgv6y8CCCFDu/QJ3z2OWaRr11lgpB4/ROz1xFVl1RvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6GC5jYv; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6GC5jYv"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bd9a6aae530so496969366b.1
        for <bpf@vger.kernel.org>; Sun, 24 May 2026 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779621986; x=1780226786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9j5OH5xq3CsNCSqzz0wS7YBquuJgdXdFMQZ6Lkbh57s=;
        b=W6GC5jYv1kpBLLqHolwrEyw27FPulDpKhiy2LVyzcVmHX54iHEzTiqr05FWH4wFJkY
         62r0D8Bgjm2ZLdcXrCkTBBjm9vPPkfnbwelu6ljrKIzzeoLm0LWPZsLl2XaaUEtGd9iy
         cesm2XG1KEtzUTXy2cOQ9Qjun4XB2sLJo/huzgj3siqB+WDixXqw0Qh4W1PsJ8ud/Llc
         tK8BlBbT6jiq7cmOns1LYNRDMPBWLsZ861Nkhb463HBqARQCDfGEVvfadjueRu7QAK0R
         K1VsbHmwtDUdgNjsdXXZZ9Bx4tjSk0BRSn9oRsIE8d/VJnS3E1huGePFBIN3L4B4B/tQ
         px2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779621986; x=1780226786;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9j5OH5xq3CsNCSqzz0wS7YBquuJgdXdFMQZ6Lkbh57s=;
        b=E+Xt7qi/89QVgarMXDYDIgUpgIepqeaZh8/Ltf5CL6sQhCtizp6wSVcKTBRL9S/JSk
         xta9TGBvJLq1Sl3Z3O5C4DLJ9qfp2KS7XGVg2oJsfnG/495dk1hpDmIO2+Ylmje83Ryo
         ElAj6qOFi1MUPU/h64lzezBMdDqBcur22QMYa4nL1MtpTcOtrr0okOg9fejB7qjCOQFf
         QAgoSKR8QtOtqyfvB+cQG1frz6zUX3SB0j9VkX64dBzP0MrBZQATtNFCMQmj6ziR2mpk
         lQxBJZyOC68pfUvCPnZCIAZ1B3KkODpMi0A6cmpmDASQR/nvQHFE115v1RlWs9WFP0SE
         GF6A==
X-Gm-Message-State: AOJu0YwAdCaV2M0GqP4nFnspjLZeuEQFFl9ZiZsIdASDchU14ZKQStk+
	WrJo6H6r3l5ajJGDir3MqJi564s+4/O2cvaFoWPEgUHxnnDMugJUHcVmPwNILJEqcyanJ2NjB/a
	/q5ua8NmRWDBacGfTEg==
X-Received: from edqi20.prod.google.com ([2002:aa7:c714:0:b0:678:e4b0:ff8d])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:890b:b0:bd6:6b24:49d with SMTP id a640c23a62f3a-bdd2a5058f9mr626807266b.32.1779621986097;
 Sun, 24 May 2026 04:26:26 -0700 (PDT)
Date: Sun, 24 May 2026 11:26:07 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAE7gEmoC/x2NQQrCMBAAv1L27EJN11b8iogkZlMX0k1JtBRK/
 97oceYws0HhLFzg1myQeZEiSSucTw283lZHRvGVwbSmby/GYBTn5oAxWY/LFEW/K7pPQFEcWZ8 /zxmn5BmJBrp2ZC31A9TgnDnI+p/dH/t+AIBNW0h8AAAA
X-Change-Id: 20260522-libbpf-load-vmlinux-btf-in-gen_loader-mode-4474834aa467
X-Mailer: b4 0.14.3
Message-ID: <20260524-libbpf-load-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com>
Subject: [PATCH] libbpf: load vmlinux BTF in gen_loader mode for struct_ops
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

---
base-commit: c6e99c10fd9855082568cbd71bb2cc5dc90eda53
change-id: 20260522-libbpf-load-vmlinux-btf-in-gen_loader-mode-4474834aa467

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>

