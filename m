Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA23612F1
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162218; cv=none; b=X6+EEfUCKv1W8m3s4xOo6R6dJmIEDO78Nv2EiU5VJnew4RXl2cuL1YCfX85baf3T+2id/PYMNxPCF+oxNZhP5wcB6IeDi4oi94gn/ys4dKviFuyYHHxwwnDq6bHuEMy92WD2KDqN16kEoFDllv2369yffmh8NOv7H1xQXY4ej+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162218; c=relaxed/simple;
	bh=zQluGuRRtApwDFp21xqhzyryik4r/ZAKOi+ORg3NjAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lKWTj6SiQ/rEkADvHnlrNsLuuvbLDRQKjMc2kjDtclViwF0NTrDNuGi3gsYspZ5wYddvFl/M/5dRo9n0AwIDvUmCeO0nQOirMhVtRCwOXlyKdFXpa6dZ3OOfrM5xk5nxZPndI8VE61lFE9Vj88HRNCacDOz4xGzdEhQo2ZEV3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXB70ym4; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXB70ym4"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-697bd74b960so1224222a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782162214; x=1782767014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ns5X+D71ZxXVm0DrzK3nQabza2bvz+El2s+KZqwRgy0=;
        b=QXB70ym4TGxmocB5bnmOaaGloGZiUr8G2kUirUAZJzetnW9JBb6s6+CC+5t4GfU72E
         6NOKMCaFdy6odvg35XOKZyGayzQZnaba47uv6uOq3lSR2yAHNRLJe2KlgKvjRSTKSmiF
         yaQ+mO2sW0kPUFsC4ZabKbzd2eehsacUEb3Fiekz8Zq8Jxjs5hCK2III6I5/1EoD21wc
         xvVzbZLj1mQYRE7hs3e4I4lDa7PzRma72M3d3T6DHfZHGq/xSUaWqG87iM+YhBM7JHsK
         4BfWF/SlJlE+G6qhckPBV28mB1+TB5gd3NHApnbMFOxptF5C3Q89U47tjIjCp6JhYbz5
         lRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162214; x=1782767014;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ns5X+D71ZxXVm0DrzK3nQabza2bvz+El2s+KZqwRgy0=;
        b=s34tJZpfHfeyxfRbU/Iye6votNtgavXfimg+CGWOFYqVCTbNy16lGlIFDE5cTo526Q
         RU37bjoyeiM7oo5IYEis5QZg6w1NfFIvbqTSX7CNbmcKJTOro+5oMT9IKgRq0IwgKZxj
         t7NXsVdZfmjktOt0mpum0NqRizQPZEKcqAkRbrn5upGX8B7I2P2IgcKobhAHlSXgS7Wh
         2WWasb824BlsRYoiRRkbrK609z2+9Kvp5fGL+Wmq4bsvzj9DHoGo+YnhgFeBIFJtCAh/
         mXV1cnSFJsqPSaieIOP4odnFAwakbL7ZCU5jurf4nq4njw+psitSaToSLb9Qkd62iwgA
         hDIw==
X-Gm-Message-State: AOJu0YzdpmRcCzbNoJHGmdE8UHcQejRQRKGL1kbk/NYLTnl/ZTqnGTbo
	rL51O4XF+Vczkj2sC8F1A5PF557T4GIbDXUo/DBmR0EkaTwJbUD4EzHBODA5j+KvbO3oU2FuKau
	CvIibODw8VJB0eDlVqA==
X-Received: from edfg24-n2.prod.google.com ([2002:a05:6402:a258:20b0:695:f68c:74f4])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a291:10b0:697:7f69:306 with SMTP id 4fb4d7f45d1cf-6977f6904e1mr3125965a12.7.1782162214287;
 Mon, 22 Jun 2026 14:03:34 -0700 (PDT)
Date: Mon, 22 Jun 2026 21:03:20 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABejOWoC/x3LQQqAIBBA0avErBuoCSS6SrQwHWtILByIILx70
 vLx+S8oZ2GFqXkh8y0qZ6ro2wbcbtPGKL4aqCPTGSJcr4BRD44Y5GFFZ4Pv7Th4dgT1ujL/oU7 zUsoHC6oHyWEAAAA=
X-Change-Id: 20260622-bpf-lskel-fixes-cafd1a83dec2
X-Mailer: b4 0.14.3
Message-ID: <20260622-bpf-lskel-fixes-v1-1-7c09a1585ba4@google.com>
Subject: [PATCH] libbpf: fix weak kfunc name suffix resolution for light skeletons
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>, Matthias Maennich <maennich@google.com>, 
	Tiffany Yang <ynaffit@google.com>, Neill Kapron <nkapron@google.com>, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

When generating a light skeleton, libbpf currently records the
unstripped name (e.g., `func___compat`) of kfuncs into the external
symbol records.  However, the kernel's verifier strips suffixes and
expects the essential name to resolve `bpf_ksym_exists()` correctly.

This breaks backwards-compatibility fallback logic in light skeletons,
as the kernel fails to resolve the suffixed kfunc and evaluates
`bpf_ksym_exists()` to 0, falsely assuming the kfunc is absent.

Fix this by passing `ext->essent_name` when calling
`bpf_gen__record_extern()` for BTF_KIND_FUNC. For BTF_KIND_VAR, the
behavior is unchanged, preserving suffix compatibility.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/libbpf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1368752aa13c..421bfd5e159d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8309,19 +8309,25 @@ static int bpf_program_record_relos(struct bpf_program *prog)
 		struct reloc_desc *relo = &prog->reloc_desc[i];
 		struct extern_desc *ext = &obj->externs[relo->ext_idx];
 		int kind;
+		const char *name;
 
 		switch (relo->type) {
 		case RELO_EXTERN_LD64:
 			if (ext->type != EXT_KSYM)
 				continue;
-			kind = btf_is_var(btf__type_by_id(obj->btf, ext->btf_id)) ?
-				BTF_KIND_VAR : BTF_KIND_FUNC;
-			bpf_gen__record_extern(obj->gen_loader, ext->name,
+			if (btf_is_var(btf__type_by_id(obj->btf, ext->btf_id))) {
+				kind = BTF_KIND_VAR;
+				name = ext->name;
+			} else {
+				kind = BTF_KIND_FUNC;
+				name = ext->essent_name ?: ext->name;
+			}
+			bpf_gen__record_extern(obj->gen_loader, name,
 					       ext->is_weak, !ext->ksym.type_id,
 					       true, kind, relo->insn_idx);
 			break;
 		case RELO_EXTERN_CALL:
-			bpf_gen__record_extern(obj->gen_loader, ext->name,
+			bpf_gen__record_extern(obj->gen_loader, ext->essent_name ?: ext->name,
 					       ext->is_weak, false, false, BTF_KIND_FUNC,
 					       relo->insn_idx);
 			break;

---
base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
change-id: 20260622-bpf-lskel-fixes-cafd1a83dec2

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>

