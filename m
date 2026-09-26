Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A03115A2
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465710; cv=none; b=o/o8h0BUdmgQ8jqny0YY8+d3oUAR5KpIQ4wzLPmmvXIuQ9sgsY2FjGmx6/gwHHeU1YU3sASRAo3x3E3ocQyjbqFLDSWa8mVf2RQ7DVwHbypU5dUj0pq2i5E3Wio/X7fZZen1Cf2DLg1nukA8Y934nyvQ5xL14nK88qCoWiOpX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465710; c=relaxed/simple;
	bh=2rNJDHfOW2p7j7GCkrsuh26HCgn4Rd7xe8kOmmM5IbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxRNmIU3SsbkhlrJWz9yQTGPvREXYpmzCf0grmFBe0RjuBumgZIgZR2dy/2UOJjosv+Z5FMNAziUYeAhCeZo79HhKmGtvQe8F38nUlFSlxe4unwBYV5iNsev6NPKp5xr/LBMTJO9dQFH4hKts7l9q0F8AqFXeal57Y0pwNOHL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgsVdy6q; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgsVdy6q"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-4887965533eso708377f8f.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465707; x=1791070507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffPzEJ7aLG+OHHdPln95opM3kiTTgM5QgsUXRpas4ko=;
        b=NgsVdy6qTgW44scUBqpcFF1Tq1AHBO8XZDbviyzSK/F/Bl7mi0h7yt+JlTtublQuX/
         CTB7tNf3wMc/CMJCkm1h9STDAK40Uhx4JSp3PX8ESJb4/sUb1aUmQwyEyy2iJqXJNZA2
         REnHWXTtb/748897J6Z3M63HIQRWWuDFb+00IGlx20KmhRVBzr+NMcuxo2Ea+nJ0fmWy
         OF5WRgJI2K6jUl5UxPFcTH421R+6xrgHQGhEM1smODp5ODdpwwHPiPNr/RDeS8z9mp/0
         XUEyVdZpHbSBEL4Exfaa6l7TMXQkObzdmY0RKMUNAEmZyQlo3Q7B7V1pxW4yasu+sihP
         auGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465707; x=1791070507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ffPzEJ7aLG+OHHdPln95opM3kiTTgM5QgsUXRpas4ko=;
        b=EubiD+iGPuhz/w3c+o1lpn+6D0CmDU2iSHYAPHfo7yMiiyetClrqDS3BqLhQjyOQvq
         oq8r8Hsm6nPWx6ly5ujFQV4NR+JSY4kpqt+0PhQTplYLDaAOr4b4H968a7aSE4ufGLSz
         9pZ+toaVkp7hWbjNsCXc8EEllb34R91Z4n3LOgettyIme5K25Z1g7xx23RPbXRHOjoeY
         w3sJiF57zBJF0lVIvSig/Qoj2AX0OZ9JFNwIdBI3QmPavVIDtyhAhhGeG75U7HJyV0wD
         VQUX1spXAH5nTpFneoaMeMvYrCVl6rYsUUmlvoMW+MImzDf5a7Hs1LVaDc7xowRZ3zIP
         GyeQ==
X-Gm-Message-State: AFq9FYJZgF7U20E+xcWBNZoM3hH+Vh0plkJ1MXMD6sJL06j+mhC1C6sy
	u5nwYyh0WDOp1Vb3uoi9gPeHYAVW9nA2bWnWaxBv/4U5sfriTX1Ypn7d4C35Fl0c
X-Gm-Gg: AYBFou3XJ2mippDgy4wzbwFJYHZjiJJ+00wERe76DHJFkdEhcx4Z7pDPXpbxB0AeVAS
	rnsKN6/rBE+Ifhe340KUoB2d9+WuFOpenZn4OBKqkNFrel6iHjn6lgzxQzXydzj/BHnpcHkyo2u
	B36yTSLuEhMD9iJE0lHHYXYeFyragZ2CTVsioW3DOLHx9fV4EX5riMlmXAmsOXax2cBl8mlLvpN
	e32SOol2Kd5C0ADEvs0o0R18gAFhFQVNpV5+DeJQHMEoMbNHrkHpsUDeV7zox1VeE7gVmuzLNBs
	u2eXWt4AtPWkTEcc2W33GAAgMQp/aptkoEPnxsp33zV1YBwHyams4gVlXK/bQdIE2DLQvfzSOJt
	aDTifLaT1S7RanDXl68SCaBDcOyUwsMMOr5idpSIiWY1122lJGr8m/YaMVgtSxHa+Djbm0fJvQJ
	voVi9ELrUcqVR+vfcQZYC6OMUz5Ajcjw5DdhPVVuhrzHhX0DOG2UQ+ENsBr/2S0JoZXSk815cre
	eHQL1Te2DVGBJd5DhVWieoj1ZNHsW+GVJxbqHvoSKUrIK4hEl4PcUqdiAcxgCjmxTxIvWUnEb6U
	+qpjZbcQlbG8xR/P3FSFSualYLuS90HYdhHF9Q==
X-Received: by 2002:a05:6000:3c4:b0:487:afe:c154 with SMTP id ffacd0b85a97d-4887169fe5dmr18255377f8f.40.1790465706851;
        Sat, 26 Sep 2026 16:35:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64f9bcsm16973277f8f.32.2026.09.26.16.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 01/16] mm/vmalloc: Add get_vm_area_align()
Date: Sun, 27 Sep 2026 01:34:39 +0200
Message-ID: <20260926233503.3114147-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2841; i=memxor@gmail.com; h=from:subject; bh=2rNJDHfOW2p7j7GCkrsuh26HCgn4Rd7xe8kOmmM5IbE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWIzMjPbPxryeoV65e/aL5507UMj+ueP7ghNbxefUr U9uX3iio5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNxbGb4p/XKbkpk5rNpjFt9 vM64bb7uuPPNwXVdps4vRXce4r7PeIOR4U35G8HXO/drFFVtSXUVNy01Dkvql36RG+dqIGr+YdF FJgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a variant of get_vm_area() that takes the alignment of the area's start.
The internal allocator has supported an alignment all along, through
__get_vm_area_node(), but every caller of the public API passes one page, so
a user that needs a naturally aligned region has to over-reserve and skip the
slack in front of the aligned address, wasting up to the alignment in virtual
space per area.

BPF arena maps are about to reserve a 4 GiB kernel-only region next to the
existing arena window, holding one power-of-two slice per program struct
type. Each slice is placed at a multiple of its own size inside the region,
which makes the region's alignment the largest slice size, so that a BPF
program can turn any 64-bit value into an object address in a slice with a
mask and an add. Reserving the region aligned avoids carrying 4 GiB of slack
in every arena map.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/vmalloc.h |  2 ++
 mm/vmalloc.c            | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index aed121d729b0..e8aa955fe062 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -246,6 +246,8 @@ static inline size_t get_vm_area_size(const struct vm_struct *area)
 extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
 extern struct vm_struct *get_vm_area_caller(unsigned long size,
 					unsigned long flags, const void *caller);
+extern struct vm_struct *get_vm_area_align(unsigned long size,
+					unsigned long align, unsigned long flags);
 extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 					unsigned long flags,
 					unsigned long start, unsigned long end,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bea9f76ed7e7..b70e4e27ec36 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3301,6 +3301,25 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				  NUMA_NO_NODE, GFP_KERNEL, caller);
 }
 
+/**
+ * get_vm_area_align - reserve a contiguous kernel virtual area at an aligned start
+ * @size:	 size of the area
+ * @align:	 alignment of the start of the area, a power of two
+ * @flags:	 %VM_IOREMAP for I/O mappings or VM_ALLOC
+ *
+ * Like get_vm_area(), with the start of the area aligned to @align.
+ *
+ * Return: the area descriptor on success or %NULL on failure.
+ */
+struct vm_struct *get_vm_area_align(unsigned long size, unsigned long align,
+				    unsigned long flags)
+{
+	return __get_vm_area_node(size, align, PAGE_SHIFT, flags,
+				  VMALLOC_START, VMALLOC_END,
+				  NUMA_NO_NODE, GFP_KERNEL,
+				  __builtin_return_address(0));
+}
+
 /**
  * find_vm_area - find a continuous kernel virtual area
  * @addr:	  base address
-- 
2.53.0

