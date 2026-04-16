Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D31D5CC6
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362941; cv=none; b=KXyUN7dohoVTXkNVpwevIx6vwwq7Mmqw7ej3MnXVf7euHzRy6mwUjl1/ntU0xtKaOp3qpwaL3JeYW9Qj+0a44piwEIl1pgh6/jxji/7da6T7/aKLlE+fTnJurkaC+VSkwbIq/+hdZrAy6GfJrbMJi5WKxgw25GE6JO+eDxYIDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362941; c=relaxed/simple;
	bh=q96H2y289w9fbuU+NhDDs/a/MzIp7y85zyU5pz4tN6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YcXqfZgiQTgqDL4sTYwboLF+/bQka5Vrxa7yx/F/BN7oetBCWKG+cqBVAFZxBpYxCTGtRQ8arYZcUe8xkKZU03Tjr7QADaErQnoclphhndIPaUPfxN7qhTWpQhxAUyMQc2XZLDrQ5KbFvcihAwF4EZaiGH4b+8JCtQvBNe6+KQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE0f8gmU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE0f8gmU"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfd832155so5759581f8f.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776362938; x=1776967738; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+W/vpusUQHiaTDKMH+oISsU2AULmLrbcqM59LSjN2Jo=;
        b=fE0f8gmU3hcBH9vNG0puZA7Epj0DxjMBVhVcEUx/k4T8grsG8WjoSjpMtJJaDXC5f9
         tEugL4KCsej9GdPyGTfy0FeEWiv9+6x2PtObfF6E7NtZawyCpJEgnBKvekIM8YDjvc55
         aywwkIC9B7jMaRItHy04lx0xPDM1y1ScyT616gRMPoCS2Mix6RQLlpZdWXr8lik8Y2MJ
         clb7pRyPYbY1Fn+boFvyQxu78monvM4CPsp+nkDTsEYmAL9qie9Wxz4md3IWOQkE7VMy
         nHhxHu/ts6gxALG8MPgFf91PlgvTAvDsxzjp3s2IX4MjutEY/wMpqgdkBqkN/D3VcFm8
         9Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362938; x=1776967738;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W/vpusUQHiaTDKMH+oISsU2AULmLrbcqM59LSjN2Jo=;
        b=YvpmuluAuVdDQfda+LVbuffnUTYxLhQoDd8QU2+P4GxgGIOIrmP6pWQCwB2z7U+PS0
         neIssW2Z1xy5oHkyA7CXVqoIgdiDFPJcQw56p8WB3L5V4VGTNlynMULs8x6dOSesELag
         nughhmPTVfJU9UwNobBwXoUeryJGqEWzFzCLicb0SJaypAZ+ZwDM35EwHIFz9+IXDdef
         YMxj60ap/PyVTdbHRVeEoTJab++sZqrdP4SL6lJPLiIQj8o6UOTHbla/HfCDwZhpZ2j2
         4KSGHe+Sg+xpgrmIQrOh8qh8tLMZiDpua/aE2n6Oc+S1T5oAFoU8aRTeJBwdQywRhK4Y
         nA6Q==
X-Gm-Message-State: AOJu0YxAzuNurBfWdhKdjmP6fpWBI/K8WaPAUBlPex2eY4wj1CIyTQgQ
	3DNRM38nAVRfQyaP3vxw5ZBCu3UA0eLfDNE/bhOp3EdYEzg1RyEHOFyu
X-Gm-Gg: AeBDiet2G5gEdzW5xRYP737Celrd5UDkbekdXIGebwO/MMJiQhHtNsUIDrcUZSmYOfY
	SDlHJYRlYFEL2yfEb4E3GiZV5u6BZ1WQqYRX6CK3SV4PPD/k3hckRMk9PHYrVkFSNcbfgBcWZvU
	s7c3eK2D0x7mrmEQswWp1FX3Oanf6qvVaHXANCdl/ZSLXNT7QB2U/dXN4AK1PzZGqil0zFFOgxe
	b1SvuljUQ/BOYjQezsGDAF+6Fus+BtjOBrWSPwPWQcLawAT5k6E6cZsMAixksYmOlSiraw8JW1j
	fseD1cbKG601wLADF5emBAv6qSNSW/V95HY1zF6Sjf5039QQppXfEiDjjbd11Uogzr8EDCv5hZr
	JaWsPA/U2Rw3EYcT6XMeh9hgT0ErXi3ukdTweoTcsEJgnSydwZMSJBJ7+2/IJHnAviMmhZ2cBV5
	CPkYG1GB079uPefYw4+r+4GDog
X-Received: by 2002:a05:6000:2305:b0:43d:77c6:be6e with SMTP id ffacd0b85a97d-43fe149919cmr587962f8f.31.1776362938037;
        Thu, 16 Apr 2026 11:08:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm16144018f8f.17.2026.04.16.11.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:08:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Fix NULL deref when storing scalar into
 kptr slot
Date: Thu, 16 Apr 2026 11:08:06 -0700
Message-Id: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIYl4WkC/x3MUQqDMBAFwKss79tATKOFXEWkxLjWpZCGjYgg3
 l1wDjAnKqtwRaATyrtU+WcEahtCWmP+spEZgeCs661ve/Mrm36Sxrqa7u0iv7rkvbVoCEV5keP
 JBkxlMZmPDeN13fQAGldmAAAA
X-Change-ID: 20260416-kptr_crash-572ae35c4400
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Hiker Cl <clhiker365@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776362936; l=755;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=q96H2y289w9fbuU+NhDDs/a/MzIp7y85zyU5pz4tN6o=;
 b=ujLxUtac6YIltWbpx/6rQPaTs0r/j9TtcMwv1bpAFskYYxjPVITybQM9Uo7DXeWYCb3oNrUiT
 vDnJywQtN7kBq/xQkOQMlEVne6W0jonlu5u8cp4d2B/sDzWJGPdgED2
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

map_kptr_match_type() accesses reg->btf before confirming the register
is PTR_TO_BTF_ID. A scalar store into a kptr slot has no btf, causing
a NULL pointer dereference. Guard base_type() first.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (2):
      bpf: Fix NULL deref in map_kptr_match_type for scalar regs
      selftests/bpf: Reject scalar store into kptr slot

 kernel/bpf/verifier.c                             |  5 ++++-
 tools/testing/selftests/bpf/progs/map_kptr_fail.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
---
base-commit: 009c77e8c29f17614b4f197e08afd91916599dd7
change-id: 20260416-kptr_crash-572ae35c4400

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

