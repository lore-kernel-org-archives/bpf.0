Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CEB46D569
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786654; cv=none; b=byRAOdK1iVrJqJVgKMDN+R0+w3d1GaWcFhbYIWfeZfU2/WC+efXZqtAICHDqRRy6GG38geQMqakHwqwUs5aE6FOfzV/RwfzmMxnl2Ymtm59mW1zvcypp2s7T93q7yFLpJgZjlm/9zq6c5V0bi2QcYhAIKOqnOjcDdE23LBnGFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786654; c=relaxed/simple;
	bh=RsIRhU3fuzQ1FzW3NLw2k4A8bkvzZvAZm5kiGkI7VmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1Gi/s4AZu+1dyE0gM3G6ryh4CPO1VxJOgQvTD8InDLcCllSQpL0+hPVdtUPb88YplHUw3uTuzudNwTQ6wTnQv6LTtDXZDPSM/YBBt8Q0KkucezN7oHKGOkHOqkBz0Nh2jp9DFdpT7B9xii66rm+45v3WQo3qOS6YJtIwwMtv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e85Xly22; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e85Xly22"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b1afdf98dfso2223683eaf.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786647; x=1789391447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YbtunuovUXhQ3toZibAc74QEskqK9dBj5W16bCvaNz8=;
        b=e85Xly221Y2mLFQCScZHe5OTAHN2uWHONJMVGXd4WSpkeFCTYa2ZT9oRZhb1VN1JRT
         ho2XmGxfuLgtuFVXslkVogSjEIL8dQY6VDGe0JobBsFl2IHi5cOu33grAcLnmjvStJDQ
         3eWE163eKc6w+SSQ0vEt24PmRP5m7uKTNdg8/XaXGw7xVCS3YMb8WcCQzf1oO+68JKun
         VN4MNrI9e2c9nB8jpyb2Z/WqnZBM2YuDcsnhqdMNt2z+i0H6stvx/xjnU8Xj0599khIN
         LSipP3I3J3/osSECjFPkd2HfgaJS6ggy4HQGbyQEz9v2BJ4ppPJ0MFGeCnMas2kIlEEe
         9NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786647; x=1789391447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YbtunuovUXhQ3toZibAc74QEskqK9dBj5W16bCvaNz8=;
        b=K9BPTARzIxz0cbyTEB5YSwDG/wLM05I8wc91eUWUv0Hf8fsTnQZoV6us97QI9KWw5C
         B9FMVUmmdXIZ/6dDkcuA0QhxHe0eJq01EdQmvCC9bGRIPvvgko9RuYwFDvrl5iv2KtXr
         8BBiNn+hPiG/BfM7Kx5ku31x3GiaHdm+yDbt8Ou52UCKUIbXE+GV76BEyt6+MtTcuhJX
         cJEB1E7XSTiLHQwtdA112P8IAVCdHhbHxzeDmvdx8P6B2yNYYdMiAGK42VTmjwZDIgbZ
         q6EjGncMDLexTS5KzUzNTw9e2uer77Gs3+2MT67pgq1q3xgeYf9o/am3iwfBe3pFe4S1
         ertQ==
X-Gm-Message-State: AFuF++kKLim/+cACCapv+CXcJTdg/1qjMAMeQLzX1mPUsMZwZO+weHmX
	2c6BnvyiuGt1ArdNwcQFvxTSHVpi9MzUPu6z6lK6sdyHu0iFwi/MGtU52yXVheIb1bYLNQ==
X-Gm-Gg: AYBFou3kTyReJa5RnQgooTm7s/+Fn2TqgcWrtKI9wRBpanUBAV1MQ4k5D0FyErNAG0d
	fCc0WYOzxSZdvMCMwgpgRNnBtHF7heVJq8EA2ytP09qUjDm7v9bFx6CnUVlmFn6LVq2n0Dx1dQq
	trmdyRN2XNk8BH1Kstha8wC419GIsDgK4bjijcdYQ19BHaAItWl1cWoNR6V2zP0JOOcEUN4g3Ve
	CUrGRyL0FRK8637LLFJ4xRMjaVaS0IVfxOY4KOg0rnlzAsNLpzRDz7xPm/rsiCyyeK39tZ5gBdW
	ZrXMVGg5jx+ELLhM0EQd6mqq1AyKHgUpPOoWZ8JKCGv1gXLvB//q92bgGMfO/opCpuakq0DArbW
	IdDO4oDRZ/ng+zBFqgCASR5RTlVjLUFoQ016Fk2DQgNlXlmv0/l9lVPAnTfeq2yh6fpoA2SK6uE
	tvi0kxdL4gBz/LcprxhZukXZ+m6hniKLk0D+W62AKMhOqrAu+cRpjJvYLcU5xcsFV0rBu0nOAUT
	dmn/JerdFPUPDrS39dnPo+k9do=
X-Received: by 2002:a05:6820:4cc8:b0:6aa:de29:651 with SMTP id 006d021491bc7-6b6fbcd091cmr13492828eaf.16.1788786647458;
        Mon, 07 Sep 2026 06:10:47 -0700 (PDT)
Received: from HKG-A3-RJYWAR2VC4M5B7A1.. ([140.245.43.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm27853445eec.12.2026.09.07.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:10:47 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf 1/2] libbpf: Fix array comparison in BTF dedup
Date: Mon,  7 Sep 2026 13:10:20 +0000
Message-ID: <20260907131021.34343-2-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907131021.34343-1-caomingpei@gmail.com>
References: <CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com>
 <20260907131021.34343-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_dedup_identical_types() reads both array descriptors from t1,
skipping comparisons of their referenced types. This can incorrectly
merge distinct structs and corrupt CO-RE relocation metadata.

Read the second descriptor from t2.

Fixes: 62e23f183839 ("libbpf: Improve BTF dedup handling of "identical" BTF types")
Closes: https://lore.kernel.org/bpf/CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com/
Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8417de92d028..41cc3140925f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4827,7 +4827,7 @@ static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1, __u32 id2,
 			return false;
 
 		a1 = btf_array(t1);
-		a2 = btf_array(t1);
+		a2 = btf_array(t2);
 
 		if (a1->index_type != a2->index_type &&
 		    !btf_dedup_identical_types(d, a1->index_type, a2->index_type, depth - 1))
-- 
2.43.0

