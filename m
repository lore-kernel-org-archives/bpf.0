Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B2451999
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052978; cv=none; b=H/BsJNcEyZ/zKZVowJ00E+xSEpv4Tp5FJL0eKBqEzbadIBbRks51jnaVeRJOI5MBb5y9K7xwklYjjDVoaGyTSz8a6RJ6Dmsr4gw0GEqTHfNVpo9VXQ/Ve6ooIVkbvyz+EeH7Zc4PaAPvCL2DXH8/0lBa4bZOwWlXxW7o2GvEZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052978; c=relaxed/simple;
	bh=GhhGfXj9vBQXSVmw4rl57l0G/4iCN2Zbc0/UO/Tbdyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YauxRMHPx5alYA8L+LLy1DpOgbl1OkD0+OBXowV+4Vl7AnueG+naweRPfCTHWJj8nrKq8FjYiNVhK4+DYkgQo5BzdZekfbJTdUoTxaWsFpqqQmeUphig3BAjOfu7v1+BmvLaa8oJ5RsYyaPVtFzK5iPUVG+/W7jjrTHddoRNPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6mXoM0z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6mXoM0z"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso6405125e9.2
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791052964; x=1791657764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZGoz0Gc1L+br4jm8tbpJBdxBSRHrIPgq8dt3xJ4aBQ=;
        b=W6mXoM0zYuzkg+0t7qmFwx9IOs1gD+tagod0GJl8GbXXEZ46UgL3hZmKiMkKI2127s
         IB5LOm6rTWeU+P5f5DrPPGGFiuzihPxBnWVCol3qSIWXDJz8eZUX01hKmoy23yOgXu1Y
         Xe/tOiwov9X7fFtMI2EK7jvEO81TQ9gYB6u02U4IPGYZWKPwTJuSy4Zq6T3dcEX5iLfv
         WQwuVGMkGLXo7nJ0meovY2rZbgRfMjx4jqd02AvjrvU9SkT6hGI52p9iT7OetrIlJv/9
         /4EpXb33NUdQI6iZ4qkNRC5yzMAWvTHe3K93P3m4pGceEYw6s7aWb489sFTpiszy/eZR
         8GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791052964; x=1791657764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZGoz0Gc1L+br4jm8tbpJBdxBSRHrIPgq8dt3xJ4aBQ=;
        b=SK/cws4cI2RPCYMjKuwnbu89ewiBoqxGK8B88JxpRui+1enDETkKfiqZ0/n9RcAGvI
         Ca/4RXHm2gaIlObwBf0abooTnJBgDiqjAGO1LQuwhEbQYRRwIo5cFIbbxJE8ekxVX3lZ
         3PTh6MfitCzVd0Pmf+J6NUfziAUUbNB4+p2++9LCPlev1L+bWDnoy/hWxYr42Gz2u63d
         NUVyhR+o5el3M3iIHqNnf1F9m55C2wytIffxljdS66ebnYcC14sz2ROQUPT7qUBMWPEt
         nPz9PLJXh0ABysessxhk4imThiTdSWoYmd3VAXlKBOj0vlAIyjPSm3n6kiWMh7TpF/18
         O/bA==
X-Forwarded-Encrypted: i=1; AKwUvByhuLijm9oSWe27eH9mBr/BX/GgzMeAOZlOKzuqEveFwSnCHWj9L7ebv4UfWQtAh3BCSkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m4kepF7OUBpkMQ4jLFBKLpvZys0CIcozKJ/gyG9Y4ZOSK5aZyT
	l7fq9DOnzkJgQJYd2yurdwhsjPtY1IwJ+OvQ2AOEGQbFoIgqgF5lwtuq
X-Gm-Gg: AYBFou2UJJjgfOrVakT97C5EQRiYqRcXzg/NNFgkv4gP06AWv6nHmy1S25NpGKTuV4F
	D7+PN97tPyqsu6vS3HQEWUCv10LrzdHkhPYo1Bt72Ac+PxXZBvLrC393/pLfQ8vaiqI4llbVnp7
	C1WpgjQPZRBFoIPEGOdItsdlxiLgAhAHnr3LpqgFxwoVt8+BItTKtm96Sz1q/gJqXBh/qgXdQ0P
	IlWqaZJdjX4PK9cfmhw+IlQXQjZBBcdu8xv6k/C4yg8q37sHcHDBLHU2pJUWUlN4jO+2w0D8Ned
	IlOaGArW8spS24sxStH9Px45huh4ZPXjF5AhjZyJpWMOUHlSd6BD7zXlcQlUAW4ebcJx5Z+NuyS
	FGO6LmWro1a/N72NV0rZYDhm0gj95zr+nwULL/1dAKKZ1SfVhIKvQ7o06mWz6w1vp0DBG/NVMo5
	qifEA22jODkKYlPu+7Cvh6vWYASiC8txTTBtILPK0DSJJrgmOBMQQ5siKywVbbIe5NQREvZb7o7
	a+vUPr7lGPdnfRrcxdeYMV0NmAD6lEUiIR1bVtW80QKfpqbg53cBPD0wRpshmLgnNCEzD/ibVji
	6g2bTYPbvJm+WgX4hwBxs5DyHXhXCXyrK9YnSFb1Yr0GMTesYq5+p6OXbxz/42fmOtoZ7YRXSkp
	M5g==
X-Received: by 2002:a05:600c:1f84:b0:49d:17d4:d6ad with SMTP id 5b1f17b1804b1-4a1680fdbc3mr46273435e9.23.1791052964121;
        Sat, 03 Oct 2026 11:42:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm259072935e9.11.2026.10.03.11.42.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 11:42:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Abhishek Dubey <adubey@linux.ibm.com>,
	Dan Carpenter <error27@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc32/bpf: return false from bpf_jit_supports_fsession() on ppc32
Date: Sat,  3 Oct 2026 20:42:26 +0200
Message-Id: <20261003184226.76740-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_jit_supports_fsession() returns bool. Commit 92258b5bf1ec
("powerpc32/bpf: Add fsession support") made it return -EOPNOTSUPP on
ppc32 until fsession is validated there. The negative value converts to
true, so the verifier does not reject fsession programs on ppc32. Such a
program loads, and only attaching it fails because
__arch_prepare_bpf_trampoline() returns -EOPNOTSUPP on ppc32.

Return false instead. The load then fails with "JIT does not support
fsession". Tested with a ppc32 kernel on QEMU g3beige.

Fixes: 92258b5bf1ec ("powerpc32/bpf: Add fsession support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202608010958.cYfBCQAC-lkp@intel.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7a612688e7a2..64e70f3226b2 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -539,7 +539,7 @@ bool bpf_jit_supports_fsession(void)
 	 * for fsession and trampoline on ppc32.
 	 */
 	if (IS_ENABLED(CONFIG_PPC32))
-		return -EOPNOTSUPP;
+		return false;
 	return true;
 }
 

base-commit: e767a4ea70a3992c37ed604157d32f0dfbf9b1e3
-- 
2.53.0

