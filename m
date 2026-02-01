Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB227EC80
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968268; cv=none; b=VfHxlDgvZTP8MPR4a9Dp4QvqDJpRfLwf3+tL8jXYLmubO5zdTcXrXlprykpfnG/RhmdeKYPgDCNsTp2deNB3EwDLWDtV6bXqRuHok2vor2SjY5IvH24fHdNRXIcI4Ytp1RyvgkgJt9awtByu0F3nRqhOb7aG82RLw6aPy5VlsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968268; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYWJCkIlKUk1G1goG0ULkzX0HO0d4eGVt+FGXwqqk8FlY8l556gXhJ895nRQeb8Fyj4iblyJ2+ux+O6Qfb92m7f3H+grqOUfE7+aOkM8PJ+ReK/IfHFzTjqWwroI73/D2XJPTRS6gVWnjr4przI9MjCJL9jVMUpHqtjAV3ckNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKmW2As9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKmW2As9"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82310b74496so2105986b3a.3
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968266; x=1770573066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=eKmW2As9OjOf6JCyNfm10Eg8ftIOOMpoVAtxqX69Y2reXIr5CJbJw2WuiWb+Xd5jmh
         0CJskERJj6QdAYLg3qDyb3KEt4OLfICxfbO4wWZ/hF1DyQUCssMwVCqos0yh6m0lWvBh
         4/h5gL4DhegrZoYLZKVKioXH7pbd467wYXCykU9yG3uqob2uNj1Kaz5nuwb+vRmaUkgN
         iP496TU18ks5Qs1wLgEDbr4eRnLj50iyxl2ajlcmp+NfkeUndgwKyAwVg+jO6wqMic5w
         VAU9j++UfaetZ/xpt101q84Gj2/Xh9nbpMT73k/25jW/TRnsDQBRGgkIyujAE32y+9hb
         YYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968266; x=1770573066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=OxKMj46jYsB9Vl608Bd0R+jkfoECrfz8yTmjnYj8/e/xDaowLzKE7ZvhssZbg4sT0x
         9fklx582BzNwo9b+CKSk1FX5or5Gut1a3S8FyNP7iFYWOjisV+LoE020PxrySLFWU+zH
         ejAalrnL47yznrpIvL0x8pV9PVnhZIr0oN6K6Ix23ki9BPJ/QomTa/B0v+p4fiHCrHJ0
         ezvpG+e9Inxp67Jl+5BI4VT7iaK6ZFnomyRlV3jKGs1aYvKr2WMnnHZMje3U/XVAsmo9
         RQaWU3rRAHe74+oeZz7n1nFpGLUDFC8B7gO0LtxLZR6Bkh/pFe3BgZzYWXXPepNsEIHp
         ZHSw==
X-Gm-Message-State: AOJu0Yw1YCWfj9pbsTKsXpHr4VzObHlyGvkQET6RmwKHcK/VG+bGlfbw
	zn/N3Z9ZTQwc6PLFGh2vSL0EDWc4t0kpVH6lVjiefji3vTnxAAfINGdTajUd0g==
X-Gm-Gg: AZuq6aKVLbE7ar4siG9MM4zLZPtY8hSjgBeauVfa4+A5t6qQtB7uGveMRuHTUT+Hs+e
	9Kx9GkAHhF3EThpvY0Y32fUTTy9Jmesv2k5ndVyCMb0ovF4xGVaw7U4j1KZvawexl2UHhBt9FMN
	DWxFsGJULnp29bb9a3eTiFopomOalOoHMvi++e6Mk9/+yI9ALTz+X8vafTkiUAovaij91OWnVA7
	gIbU2KGdsodcdK4hNkld9KSdE+Tv1r9+UI4DMpxM3b/V+iaKUjgLo+KnfHO9dpdI+lsOEZGW4lG
	H8bw1RuVrtrD3Lgir24Y/Spx5fWjpZyUC7fygRi/M4RcCb+F+pfWc77m8OteFcjm5EVlXfCNeZM
	9kR9oLsIr7kBYGhETKj7P9Dqf/ZhM8kuRiU9EOfwFz7DoT97GiH6ZAHEEkEJ1B+bzCrFJwWq6mx
	U2KQ==
X-Received: by 2002:a17:90b:3f85:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-3543b3d65e2mr9511884a91.18.1769968266006;
        Sun, 01 Feb 2026 09:51:06 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6428371715sm12318496a12.13.2026.02.01.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:05 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 12/16] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Sun,  1 Feb 2026 09:50:45 -0800
Message-ID: <20260201175050.468601-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check sk_omem_alloc when the caller of bpf_local_storage_destroy()
returns. bpf_local_storage_destroy() now returns the memory to uncharge
to the caller instead of directly uncharge. Therefore, in the
sk_storage_omem_uncharge, check sk_omem_alloc when bpf_sk_storage_free()
returns instead of bpf_local_storage_destroy().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c   | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 46d6eb2a3b17..c8f4815c8dfb 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-void *local_storage_ptr = NULL;
 void *sk_ptr = NULL;
 int cookie_found = 0;
 __u64 cookie = 0;
@@ -19,21 +18,17 @@ struct {
 	__type(value, int);
 } sk_storage SEC(".maps");
 
-SEC("fexit/bpf_local_storage_destroy")
-int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
+SEC("fexit/bpf_sk_storage_free")
+int BPF_PROG(bpf_sk_storage_free, struct sock *sk)
 {
-	struct sock *sk;
-
-	if (local_storage_ptr != local_storage)
+	if (sk_ptr != sk)
 		return 0;
 
-	sk = bpf_core_cast(sk_ptr, struct sock);
 	if (sk->sk_cookie.counter != cookie)
 		return 0;
 
 	cookie_found++;
 	omem = sk->sk_omem_alloc.counter;
-	local_storage_ptr = NULL;
 
 	return 0;
 }
@@ -50,7 +45,6 @@ int BPF_PROG(inet6_sock_destruct, struct sock *sk)
 	if (value && *value == 0xdeadbeef) {
 		cookie_found++;
 		sk_ptr = sk;
-		local_storage_ptr = sk->sk_bpf_storage;
 	}
 
 	return 0;
-- 
2.47.3

