Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834405;
	b=395+uLPfYnS1iCWsA3u8gE5B/U6b9oFuctaUi7mW6u8BXUfhQoHygB+k902jyojIyVBK
	 cXEVHzUPYMoHgLY+vT5EfcXcWpN9vqQXlDqz8rJ2/OALjToM800RsFu9VsYaTvb42bxTh
	 oDa6khl/BHnh/DF9AFH5cm+DKEewvW5VxYCHx+iG/hA3gclJJwtBX3ZMa7rmL71HEAAQM
	 29qaDy3dU+ZZ2KMZ7mMrwbuJLh8fmerUqhO6/O3NAxFbBz58haEY7q8aUZ9zUN0jztK3K
	 rs5nND5BcPQd1ygBZF+Nc7oXtVSkCmDvapOkxa7w4uooA/x7V4HQQsu4dJ+JL7qadGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=+YV1M9xD+ag2ri/rWUEPchYapjamG4TNE1eJKE+P0Co=;
	b=Rv+Bm5QhWNKQc+gRq/POfGsNSfUTY/mRLCf3ckbY53M+P8Uv3G6X/K5PHUZvAo6bHATl
	 vXqaoMUeAZbGE0kRZ/cFffFOH640kLSOuSzC8S2MMv+Uccg9/bPc4rVSPBRMzykkTaYzn
	 pGgEDtKR+tvygtKEcl37btf8dD3VC0d093FouuaFPBXeNHU6EjSLR9K5KZWaWO3ZrZzkM
	 m0DDzMfr9rBkLoUxNJRttiX5rVNEgTrR3NhqcYNkEc1K8C3e6BjHLzVHl269leLexak2i
	 dOL0Tdg2avkH4lrDC+65ZA9VAbr8yfGBbMwkitUlc7obaAhxTyW3FqUPXN5LMTJe5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eDjF38Zp;
	arc=none smtp.remote-ip=74.125.231.199
Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D7606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 02:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 783D7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eDjF38Zp
Received: by mail-oi2-f7.google.com with SMTP id 5614622812f47-4b39374fab5so3098657b6e.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795834403; x=1796439203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+YV1M9xD+ag2ri/rWUEPchYapjamG4TNE1eJKE+P0Co=;
        b=eDjF38ZpcMRKEn3US4j8YDdhnSk76axcZ1xCjeaWL5/ZlXj6z4XpbxLVXKzlvjqH+u
         OAIyQbRsaiEvdi97GNBisjq1PQa4JHOPPUZktBrVuL2D99uX0X6w+lGXCFd/z/xughEo
         uRRpbfwrWYZH/A4DHvGIKMfIVlD8iIq7qYEcTNas8apbAcT81hWzZoPnJmyJtUJQQiKU
         Rv0x1d0QwxllckaZh5ucWdX6IVE95nWAYtTHkz8+TPpVl1X0GDmTzVNH3xzL2a9PX9oW
         L93Z4Dpg3wFJ/FczTsJV9B9kLe3gqXZ2LqPheyG3Q9JC2d2N/ezfM5CF+4kZDE/bxbwU
         eQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834403; x=1796439203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+YV1M9xD+ag2ri/rWUEPchYapjamG4TNE1eJKE+P0Co=;
        b=wYzp8dg6ZRfv4/cLXywcWV3HuVZmU8dkgvdZnigziIHUgtRLwW2PlXvsML+p73fbcq
         skCA5naz0JhPBMDUgnD93490dXbAc0owhc6g/qfnmCWqp8BBogNE5jRVojaWPffDnn8E
         n/Lh6KSK4gcFXnepR010vd7EuIpmoZugvIrQli0MIiY6uU2wm8+R5u1MDpUlIzhTd3S8
         SjGBt5rf3IHKRwplCMQbDzGKkf5AGoRm3AQN76qYs56SfnsYZOeKA5J3/ev3QifS22yT
         PDc3w9/8H+OErkK/yR2FnzntGBQc4FLOwcbARXDGJ8sItTE/2orrGzbOGN7P4QprnJcC
         RXTg==
X-Gm-Message-State: APuU4Z8/2NmU7cZ/ylBTvI3wCkcLaxPFPCwGB+94Fy+VAWOQ1gRovvTG
	4xSLF76eASC1JX8SrKcKq6sxadXqcdYXQNgRzMwSGk/nfcwQzD/dGSvVLE2qDiWPNOA=
X-Gm-Gg: AZFdTZenNgwKn5LbOLBXY3k5W8LOAsrDPjK6PkSMPh0UhBnxyiUY6YpbToneU/h8MBE
	Y+3I98zEagprX7dPadk0qKmF0ESPcPsroxhfZk6iZzxOYhBN2AL5ZAF1oQ3IHRmCyXyLJuFtIlF
	hdnxRSqUIIp2wX/o3Y3zgusZTkEuvcfp8aB/yKQT2UveJpVeEtRVeJFfvUDY44Ca8XMkiG6bIYq
	jBQGFCd7xckty0Y4jwTd+K/vLjn/P7ABztHm6jV0V4CbXV1iRD2lFb+SK5lHgimjRmD+tSXkmzh
	HcCbmETTU+E8L/MurpYOMTwCHAaFo63NGXjZJn8rw+eTqa7wztRFc1C1dqKdtW9hzIu2Q90suer
	+V3dsnNyj19FlXAsD3Sd+YytqTh+u8GMbKvHhfNS7uPCuWhuL9MXjHsluUy3VcfpZTxoGMCN2Gt
	cLBnklbRbVBXrMOpd740I+rgHrXVoZ0Kq4XD72sp4mia7yto1jtRPFlcy0Ir6KsD3DP5kEu3gVK
	aXKs+AFrLCCFaMitwgLTbSQbeAtkAsZMBHOvJ3BjOkjpAmGClS/NjnF6l3Y7re6BWX8tmekku51
	g0TfReesBnL/e9v/EfJUfcB7JG+6bpwaNa6IQ6UR5AYva55NTqYfJWmK8cKn/EuaQn9NfmgCORs
	dTj0lpid0Y7fcOyMzFyG+Svx3lorgRAL4gVg6
X-Received: by 2002:a05:6808:3501:b0:567:d689:9b62 with SMTP id 5614622812f47-57a037b96e8mr29415803b6e.0.1795834403462;
        Fri, 27 Nov 2026 18:53:23 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4f::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a2eb50d63sm19929493b6e.0.2026.11.27.18.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:53:21 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 1/3] compiler_types: Emit a BTF type tag for __iomem
Date: Sat, 28 Nov 2026 03:53:15 +0100
Message-ID: <c4f497b6646542ba7d856ddec7d912b680b017bf.1795834380.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795834380.git.memxor@gmail.com>
References: <cover.1795834380.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; h=from:subject:message-id; bh=CHaP6k63JJpG2wxpySBkgkJiMm4kbFlqyFVEkSg4BZQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZvLiaepZo119sSTc0ovPN7to3d25ltD3W9mKnmC9ROSjrO+ PHqvo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNplGZk2BxeOWc6//KnJXPXirv96f t9neN7wYOvfl90UvIspq5ZcIaR4VgDo27Dium77j9m4lyfEDore2WE/Pzmx+VLP0jfderr5AcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

__user, __percpu and __rcu pointers carry a BTF type tag, which tells the
BPF verifier what they point to. __iomem pointers do not: outside of sparse
the annotation expands to nothing, and in BTF such a pointer looks like any
other.

Define __iomem as BTF_TYPE_TAG(iomem), so that BTF records which pointers
hold the address of a device register. The next patch uses it.

As for the other three, the tag is only emitted with CONFIG_DEBUG_INFO_BTF,
a pahole that supports type tags and a compiler that has the btf_type_tag
attribute. The attribute does not take part in type checking. With the
config of the BPF selftests, vmlinux BTF grows by 892 bytes for 27 tagged
types.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/compiler_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..8cfa555664e9 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -67,7 +67,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # else
 #  define __user	BTF_TYPE_TAG(user)
 # endif
-# define __iomem
+# define __iomem	BTF_TYPE_TAG(iomem)
 # define __percpu	__percpu_qual BTF_TYPE_TAG(percpu)
 # define __rcu		BTF_TYPE_TAG(rcu)
 
-- 
2.53.1-Meta

