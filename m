Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC527057D
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017714; cv=none; b=NMflaqpDzusEdE0OLlgovb0h/IEQKV92qx5QtmgLW6Mgqnz7XsFNqCZ3pBrnC9FQGU28pSJe6XeubmRXMbAma6w9gzRokNTFuu6uPatojF0uR/v68TxotgPBsmtLZspe1jFeG13yLjibxiN8iVythsD7xWhVwrd8qBIvIbsfiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017714; c=relaxed/simple;
	bh=yIUMYmULBNvWO32YqflmPiaNdoqO8JYYs8sy4hCZPro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FSfa3EPLLEOCh8Xeyy4vbzDXH8Kvja+Lfvc9dqXTUy22JU1FQojEkTmaG8ZL+e5N5/+hFpyEriXMtGBGskYqCzr2nBrSf2L24T2F+XkGKha77T3BgNL3Dk9Q0dH6wOnJ7z9Ouw7u7FtWOkLf/m654b3mpFpbQ1MGIb6LIYV46qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEiR2V9S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEiR2V9S"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so10614845e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 13:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771017706; x=1771622506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kp68oSHxEAA3CemKcpfbbHeRk2urH/F5/LLivXi3RI8=;
        b=PEiR2V9SL/E8nSLkm5n3eX5G0dgMidIwSzIWV5kyHNwBziAPKu9O3indzp+nF+e+X4
         UdF3/mrbDsXT5WSyif3d/+6yQQT9zBcxvLJg3zPM6MVuLb5JtxmDYJZSjKOhtlkjwm7m
         cajcfb/G2Pd5i0+cPEE2+p2IPAOHTzMNAom9pthF8zMmZrK0a0N6UWTabjbbyOVtpBGJ
         2efy17PhWUna0cX/hQkl4SobfmER/G6BaSYuvsC0AWWkNTnI91ltmwHlMj4bE5WwKhOm
         LqNe8H6bMVO8MUUmAz6aieqBOvNjkhdUFuAvsV5lOBx8lXwK1HHnnOMzxbjujdW9vWwL
         qKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771017706; x=1771622506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp68oSHxEAA3CemKcpfbbHeRk2urH/F5/LLivXi3RI8=;
        b=AES6jJETG4eROILzdlLXbA8rkKMD3yUKzJbC7qqehXsiya0HIsmbUOdBSgnC5kOP6k
         Clp7RWPR7F6NZZulfVSeFKSQMrMS3RLyaTraxrz8I48UzReW6WbStmGXa3VQJ3NC6vx8
         d+MuKFztZHykMaL29AmMreR3fReK8jnDJqq3FR1riDOtCjcUAJ7QS6UY8JcuPHpDFWfn
         VSewm+q8wmdXLqgkLLqCvfOFQ87L9D8h18ZJ1nLNhTzCoBHxd5OotgERWEYrASHx1byy
         vnaS7Levw1e5tYrvGk2ij9c88ScDtXENIBbLLe0+gKVSyDQ7btuHXLMRsLLna2Gx5jmg
         mjSw==
X-Gm-Message-State: AOJu0Yx/xZAI4hqDSMR5JXhY6vRnTIY5bugNSFU7oWZetiPGNBzy4wdI
	hdfkK7EcezAnbmJ9iThglRkWCuhYkrkkzfmL8lpJ29N/7ewyAqYTjn0idH+9Ow==
X-Gm-Gg: AZuq6aJii05fzFVBFc4nrkeiYAyOU0GZPdkPyYQRHlS8N+P4YFGImcAOviYgeY6R4xp
	Aa+/Big46q/YPYxP3/LtqTwdhuwfqPUe1nJctFdEc9EUbVVg8NrYEqLACkJQ6291+pof65rHPFs
	mFspReXjA2LPoarGwo3oSq4H98SDykH1As3HTpi4FjsGgo1Sr9fTXH4DpQz9d0fpWdkScfT6EtE
	oXOtf/clsYSvSJoE/lG8AP1nRmRnvPMXUEkvlV1wD7mVV/yZp3miIxuZQgixNQfjZMZ9l6WaSW7
	jwlVLVlrI3fAUzclinfycVLNK5nhtlrhtFvSOzfbvRFc6V3qPdCGfTWXNM6DYtX0Hqn1c4CztqS
	9AsnhMZQPd9t79Iqads/Y/6vzSFXwdN34INa0bGv8rpyi94nMPbeWaS1hab/SadvLK+inXAYxtA
	dtXengJu0b7hfM/Z/mbinRfXJ4Wq5ATzIfV+ptUJmtNw==
X-Received: by 2002:a05:600c:1986:b0:483:71f9:37f3 with SMTP id 5b1f17b1804b1-483739ff8cdmr57677355e9.1.1771017706230;
        Fri, 13 Feb 2026 13:21:46 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a420b1sm22979635e9.28.2026.02.13.13.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 13:21:45 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH bpf] bpf: Add a map/btf from a fd array more consistently
Date: Fri, 13 Feb 2026 21:29:49 +0000
Message-Id: <20260213212949.759321-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The add_fd_from_fd_array() function takes a file descriptor as a
parameter and tries to add either map or btf to the corresponding
list of used objects. As was reported by Dan Carpenter, since the
commit c81e4322acf0 ("bpf: Fix a potential use-after-free of BTF
object"), the fdget() is called twice on the file descriptor, and
thus userspace, potentially, can replace the file pointed to by the
file descriptor in between the two calls. On practice, this shouldn't
break anything on the kernel side, but for consistency fix the code
such that only one fdget() is executed.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/aY689z7gHNv8rgVO@stanley.mountain/
Fixes: c81e4322acf0 ("bpf: Fix a potential use-after-free of BTF object")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d4afd571761b..dbaafb64d3bd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25372,9 +25372,11 @@ static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
 		return 0;
 	}
 
-	btf = btf_get_by_fd(fd);
-	if (!IS_ERR(btf))
+	btf = __btf_get_by_fd(f);
+	if (!IS_ERR(btf)) {
+		btf_get(btf);
 		return __add_used_btf(env, btf);
+	}
 
 	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
 	return PTR_ERR(map);
-- 
2.34.1

