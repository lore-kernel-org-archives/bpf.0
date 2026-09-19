Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BE2DA756
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789836156; cv=none; b=VESyjh/mUUlrNgVKo3hEJCDat+v9MpAlu3MTve6glBJKttTFWVL/APYAKd6LmG2znytdzS4WtGFn601rLmtykUAp+sIPtic3Ji4tKoTAxcsYYEQvMZiLgZuWL9o9EDnx612eCRJtY59rityfkkdMKJ3qJgp+D6Wn3SpQzWlXyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789836156; c=relaxed/simple;
	bh=JVJEG10QpxqFEwdyZIB38MLFPe88JI7zrVfyq5LZbbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oB7afok4+A1JkMXoNW5zU7Xhqq9zsNmkKl/LcW4nSgJdPFp2QRWvpvLDOL5f/IDzo9k1GJ3yXq+NoWMox41nISgC8q+dX5ajtVV69fifK9dcHoCW0U8NQvwjHZKCXi9/VBn0Alr3oyZ+TugtSKUaiUjmMsUbwd6cKWiaXScLfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEweOOHH; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEweOOHH"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea34f01so1476883a12.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789836154; x=1790440954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zge4203G5fzA0HJcctJxiqb2PSA8Yppb6wTn6T3YJOk=;
        b=TEweOOHHVMP9PFdkcDKlsUZCCflpcERYXc/O5ZEd/6OkK/QB+VZPiNJAunamJ9ttqw
         Lmv8FVbN9hsicn6Y9zPy1Bz+7HG9syusnpZWt46YS2cnD0BndEH+fHeVF5SQ6nJ6Pq/8
         VjdpV2bVNLSfayjfKeIzFMVLxLs4HtZf+Zhk0G9NrmB8BM1kZJ80gc3BhSjffP/PTbj2
         hm6Rrzvmcsb6CwJYhhcg0QulKE870vSaXBh7rpNnusjs/J2IGdKGGpLoo5HJiJ7zyJaZ
         oTbSNcuVeZ+Je3mW8mcJNgnDDPxjIcMD5mUhApnpEEwUqqEbYkmprdXYoRAkCEI9EuQq
         VSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789836154; x=1790440954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zge4203G5fzA0HJcctJxiqb2PSA8Yppb6wTn6T3YJOk=;
        b=eAUp8ZRtwpg8LlLdB4yrCpuvp71hi2FC3JCd3pJb/VWeRJ4fojzqr6JJm7iBAQAJ2i
         pLx4CR/ST+GXSgcRYeqSez1bNBBeK+EpD/OMYu6G2n0YmrU+T91USNXZDAMPzyFKZmaS
         +nxrGwy417K6/zZMcVJI5Ak4D8+BQds9jB0Ugc16cdVkT9MYsozRWinqR8R8DrJ3AThd
         wFOyGe+rcsvFtKS981S4aeLJHpLufEtyLfyz+QS3XflBeI/pFY+EYtDPboJNyA5dM/QU
         zT4fGkAWNmhvlKjWdIpPu16WrO7vJ6F1z83WaFkB3BVk4kFJtT51nzstyn7OpB8oV1QY
         Arsg==
X-Gm-Message-State: AFuF++kkitSJHGvA6HexnTc+tf0pd2YSngPlWzwnAyaj+/HYpD7M1P0a
	HngBDoAbJt/Vmb1iViV2+QcfeCaBjeHlajKe8gqe0awo7rEe/2Yrqfeinev3HP2z
X-Gm-Gg: AYBFou3go65D+JzG4it1S8l1fMB19B+vo+H6vLDv+TPbaEwX5sYGx5Fg9KzEVtBc1Kf
	n+hLO+jcHpluYoFpnLKsF8yJrP/tM7xPkq/L/LIqS/WM1mcNqmCTYd+kWisAtxiJ9EOCO33p2tk
	GmwSvwr1XgQOoCemmNy7HqegOBkByBI5rcWSJjBUK+KJvHVlWAX1k0N1tPr/DRBAEAk6SQcBOde
	Cp69+sXz29/TqN1curVx27IGF6+mkeMdbuSsJk6tAQzRpVTs67UFLL2bUTW4QmxiR/TEf1xP6lk
	Q/WsRBS4F00bSV0W7oZ+8vAhyG1mFJvVjFwqdR5w5bireaSK18DuwnDdt0J9mWe12ScZNQnPsWg
	7QwSRTSaGzKUQh8YtfHeyiyEAwlwyZWJWgRkx5rE454nvKOei4kxyzm8pDw0cm7hbCjuTbmj9ej
	wKLn7Y8YZNCX0P+0gXntb4Vgkm8+90ToV0gsD/xfp0K09z+szA3UlcyUQeSXoGa9mbpMnZqOHBa
	5bcuKi5oXUujK8Hn0bKUnSZViySh1oTuU6oqteyefLTFV4J9A==
X-Received: by 2002:a05:6a21:9204:b0:3cc:ebeb:3efe with SMTP id adf61e73a8af0-3dd8c424e26mr10214174637.9.1789836154499;
        Sat, 19 Sep 2026 09:42:34 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:51:102d:5562:18f8:11da:acda])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3311a6e5sm7104245eec.7.2026.09.19.09.42.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 09:42:34 -0700 (PDT)
From: Abhinav Madake <abhinavmadake@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Abhinav Madake <abhinavmadake@gmail.com>
Subject: [PATCH bpf-next] libbpf: Return -EINVAL from btf__align_of() for unknown type ID
Date: Sat, 19 Sep 2026 22:12:29 +0530
Message-ID: <20260919164229.95154-1-abhinavmadake@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf__align_of() passes the result of btf__type_by_id() straight to
btf_kind() without checking for NULL, so an unknown type ID
dereferences a NULL pointer instead of returning an error like the
other btf__*() lookups do.

BTF parsed from raw data cannot trigger this, since btf_sanity_check()
rejects dangling references. BTF built with the btf__add_*() API can:
those only check the ID range, so a forward reference to a type that
was never added, followed by btf__align_of() on it (directly, or
through the recursive struct/array/typedef cases), crashes.

Check for NULL and return -EINVAL, matching btf__type_by_id().

Link: https://github.com/libbpf/libbpf/issues/983
Signed-off-by: Abhinav Madake <abhinavmadake@gmail.com>
---
 tools/lib/bpf/btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 908bd3442..d15bc09ac 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -986,8 +986,12 @@ done:
 int btf__align_of(const struct btf *btf, __u32 id)
 {
 	const struct btf_type *t = btf__type_by_id(btf, id);
-	__u16 kind = btf_kind(t);
+	__u16 kind;
 
+	if (!t)
+		return libbpf_err(-EINVAL);
+
+	kind = btf_kind(t);
 	switch (kind) {
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
-- 
2.47.0

