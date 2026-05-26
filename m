Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733F03DBD6F
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797584; cv=none; b=JrMtJ8/vhXI6y6+jyMpTZfeWBkHM970QZjIuJlDBs3jdk+hawxli5vQclFcnSXl0aoboS+LjyqkI9QGAzLGtCxIFZnQMreGEPmIvNCiCITxH1Mq2qSlVQdM6FZ3SUXkZnj544V8cq7pFAmOtO0PsAfI7DySX62rG/Mn8tXXuOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797584; c=relaxed/simple;
	bh=r7zcdF8qutzChq8XLk+oXcsBhNew8W4i+fhDiWfimoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZIEDBgsuE3qbf+fayRpiST5gGTr7h0fuVhmYNrASoo18bA1l4JIMyCKMqVs4yVrypGKzXlil9t0a5PCbKabB9Ovj5NimowlKNR3pxzuDzWqPasml4Pcj2xOSolvjVD8lwPEdhAYiCO2AOUGdh+CAGjgOJcKPmoYOO3E6CYp6MDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7YfKdpm; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7YfKdpm"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bcdbb46dce2so270173966b.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 05:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779797582; x=1780402382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ev6aA3Xe6T1Sew1C3oAjJbhgzPbzt+OHYmVBfkfyNE=;
        b=M7YfKdpmXwgDhJ6d+bLNkEtm1UZ7Hec3t5tH+k2FlF+Mk+Jvyh25HX7xTDBwi6/mOI
         w8PW1bq90w5kWcW9ubUqGEjg5sa+rI7puRPcHWrTovId5GDTABgruTcdgVMLfNP2b0e1
         asTvZEh0Tkt1NUyvSAXs/r9IYNi9U0A3QLdNeck/6ohJ0Svr1EBleQPijS0EYCfaoNHM
         mnBSWlggmspb4TZ35ITbAWinNsvJdyw0fiKQzi23oUwhu+czu9/VddRppATAtIoshmbY
         WAtYbYjJ00cBlX+dhco4JZvcKpj3Egrnnn4kh7d7mHVYMDGlua6DgpJmD0gdC9R3cDDv
         RNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779797582; x=1780402382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ev6aA3Xe6T1Sew1C3oAjJbhgzPbzt+OHYmVBfkfyNE=;
        b=LG7u+iytb1jbh88hXQ+sONgfbVKT5NFPWR9wq5L/tDFEDyxKt0RgCMzuq+6CZz21C8
         l8p5C8snAgn7cbDQNY7yqlO7oRueVbK7Ry890cfj6JsbqEO57n6OYIGmJBzbM80dyovR
         H4y8dAO+weLZs5Tbu1ObKenxyuWA9gJWIfJ9omP5rpsnp3VIo/Wc4lhxoxoELmNtxz9d
         Pw9zxEwqfatEaD669pst1QuEmrMC+VC6ViTbLT8sBlCDEvWNZ3Ty7t/0MA7wbKmaHvwX
         9pV17HKAX61nsSuamlm3+6WBt8J3RshWgTS1iw+ORsa/l71RTHUJYGFaPi4eQI7gxz+3
         sXjA==
X-Gm-Message-State: AOJu0YwqU2xCubDDYlqRXJpDdr5TuDhbTSKS8iIoQbomZjmCPZiHMb49
	91pRwYi619nBudMuxSp2PMcyTmr2JTZd0zNFJBjOvR2KVP7tvuuHmutWwn/xESXB76QfYfoMWRt
	+n2Wm702sifJI6m20iw==
X-Received: from ejdbv4.prod.google.com ([2002:a17:907:fd04:b0:bcb:7e65:e5b3])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e99:b0:be2:cd33:213f with SMTP id a640c23a62f3a-be2cd332452mr185324366b.17.1779797581687;
 Tue, 26 May 2026 05:13:01 -0700 (PDT)
Date: Tue, 26 May 2026 12:12:56 +0000
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-1-6750f5859bc6@google.com>
Subject: [PATCH v2 1/3] libbpf: load vmlinux BTF in gen_loader mode for struct_ops
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

