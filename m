Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53948123D
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519505; cv=none; b=g1Rg8iHFyew+K0iKDZwMYZYZ9EUPNDsEvkm8oJHJaKMZwVIsfF7BwWOaXvM7Pafbx7fxVYuLoVLzEHFGb8MuwQvYSo/Fk+GOSiwQSKfKTE/o4YLhqZ/Fr0FTRDU0XweV7vSTpRGtBLmBXV5Y50A1MER/G9WsQ0wO26BdILlkuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519505; c=relaxed/simple;
	bh=UErhiAlzr8WjMoBRENwt/AEHPbueyU1pd5tdq23Ux3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8NC9Uz5+VSKOdysvQBP/exAO4NTMyJBUOfVGkyGIQdAU9esfY1Fn2DEhyMzn9cLJ71O/MaiJpfCZ7XEA9sUkO40Fv9ti7o9HWjQqAm7O1Gz5zShlrkrD069IxUDN9VBsKFUhgB8rxZThQ8kac65kYVewRa5zNPBIO89JQEyFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFIB7euh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFIB7euh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso7530575ad.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519498; x=1789124298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=cFIB7euhW/DhRND+ISPXgptzdey+XjnRWiEP6Cm7kIE9Hrpfez9VwAvWG8xanG7BjY
         cGNCFO4UgsfEueOALXL+tlA7r3z5i5bJ+LRxDmeKql2VNWtbDrC1w1Itl5/Wp9Ye1Dk5
         NQy3cTMVZ4Q4G2btulOSvL5ro52JSBOjW6tAHM70XO9Sj5yUidh/V9VfEtihIYXuQFJQ
         VF23nJsM1j6Q6WH2ELTHZgdDNOD3sa4L+D/CDDqQZ+hVfNc+HeoVFqYwaJ8wB/qDcK+F
         HJ6x2rs1h+U2elj0ULb1tycJ1NxbkvgTm3QZwWYMr2Hwv1LisWwhbsUth/Oey555LaiZ
         OV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519498; x=1789124298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=e4QeGX/OrEba2lNNNwdtFUQGkjJJpa5BA5D6xLhM0EHbezF3/RrF6SmXPcL9Ty53lt
         1lVfLkVIvt+X13DHZAjSdd2A3r+W5PM8mMzr/xO/JD1nZ0xiyJDvYapBb9ILqG7SgJrN
         MAyJvSCNpbV/uF52aGuldEXvegr0LJmLgWGlbvSZHGIO9A4XrPWjN+SnYaoyD7IGZ60S
         /mShuHg06sP79hz/1bGvr+g+XjI2b+XHiE1Z6UAQWcuABjcxU7DLMMYFl4FewqJuZt4F
         TYYUDrIbwVuB3O6W0nQYpfOgn4rdSNDzSBBRVX5ZvHoPorNI4qvh50PHG3yj50BA871F
         PSzA==
X-Forwarded-Encrypted: i=1; AKwUvBz3BfocaHMuZLDUhKJIzgxGVrM9w3xHtZH/ijh2AaTe9aOA8UR8nsFJ41XPzKdiiVLoKdk=@vger.kernel.org
X-Gm-Message-State: AFuF++mzykp2Jmhm48xdSz6WVQAod+6dqqmGVODsGYRnSWpZ/qyGfe6i
	UBaK0+wKLkBMoo6RIZK1vKalzqwHHfe8eFi4etH88hSSgkTQvIkDQMPJ
X-Gm-Gg: AYBFou06d9rXLdfGXeE3PU/mEJvqA6IBEHPp/ZZMaLH5aMTuHBo4GzHoavNo/viRa/s
	qJx/DKuP9oZY/kFoerCzh03i6++O7Dh+CarN3DQgFEkEkNeWH9WhgeBxB2h3pwltBZ7sguKKhkr
	7VI6lckeKXnpkqzmmJ40bxRS8hGKovZx1PWY6nbwJqTAU5xgFjARmKeS+xZyvMMaSA6VDGqOObp
	mv1UCMB3WgwFjCOUnf3yBBoWIPlrg6FmHReOhS/EA7epUIvWicBkn+2dpmx/nRwJSDBl5DBnMos
	D1uNazMlvAixsyI2JD2okDtlvwr2MhYPyOyDcx/ws+Dsv7+Vm3UNsQoVXl383dSlKstOJi8sKvR
	2i+EG3QR8GzF2wVubB0CyMuFhhP5nnmIK0tSFNEln4ZoI27BPAe7ARPekIbzat3qe5BS/c9OBOh
	Oj1QVxJtQqiuL2+vTHK8XJt1SDBEbT9xR4izy8M3Xu+vhaLwef/O2SsuBCTsQDwfFe92wP/lEld
	s690BbycXJs7OXT3mOE7yShqQ==
X-Received: by 2002:a17:903:37c8:b0:2d9:50:a91b with SMTP id d9443c01a7336-2db12667eeemr81520455ad.16.1788519498125;
        Fri, 04 Sep 2026 03:58:18 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5523091eec.18.2026.09.04.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:58:17 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 5/7] sparc: net: fix typo "evalute" in comment
Date: Fri,  4 Sep 2026 16:27:35 +0530
Message-ID: <20260904105743.39799-6-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105743.39799-1-hemanth.selam@gmail.com>
References: <20260904105743.39799-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "evalute" to "evaluate", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/sparc/net/bpf_jit_asm_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/net/bpf_jit_asm_32.S b/arch/sparc/net/bpf_jit_asm_32.S
index a2e28e0464a3..81430f065ac9 100644
--- a/arch/sparc/net/bpf_jit_asm_32.S
+++ b/arch/sparc/net/bpf_jit_asm_32.S
@@ -195,7 +195,7 @@ bpf_error:
 	/* Make the JIT program return zero.  The JIT epilogue
 	 * stores away the original %o7 into r_saved_O7.  The
 	 * normal leaf function return is to use "retl" which
-	 * would evalute to "jmpl %o7 + 8, %g0" but we want to
+	 * would evaluate to "jmpl %o7 + 8, %g0" but we want to
 	 * use the saved value thus the sequence you see here.
 	 */
 	jmpl	r_saved_O7 + 8, %g0
-- 
2.48.1

