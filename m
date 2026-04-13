Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BE3AC0C6
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070240; cv=none; b=MONCf2AWo0w+KxQkiR63bHl9trTcjOQrLIFJ0Q6l+PiZFMAlVfR80NPoYc0ntiCa7XR/DSJZtQ+hHe2uhoiki/aEdP/qlCmRr2KE5gpBUPBBj2xHG6ma6IZ7K5UniHSfT+7i3xXrLUXXCUKj8whbpPpEyedzQ4uyNftvi+aNmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070240; c=relaxed/simple;
	bh=yFYSaWaZUUSnh5YnIVSwhkNkUTiNfk4BmASf6PVx5Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iu+9Pit7X2zB7ieXAe9ST2cXYZbCyRK2BX2FXcWMLw+1V8r8g5hTiVnqfEQL2zlCwvw/l4jFIyj4Lm+PecbUGM9uWqz4DDJMQxcygmIe/L5Wa3lcEiOKy9jYrbV7dEHbbRPEl31kMmukLX09ZmEIW0IDRXdUUKVjwWTbEj32rfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rimQT94w; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rimQT94w"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f0fc82c76so1015552b3a.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070238; x=1776675038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HgQLeWF7VlhHIfIZRtJl8ZFwFDqdHrW7SrqKeazeFA=;
        b=rimQT94whpNPrkjbusDTwEiP4f1d3zYsCLj2Hk44iNY8/ntpUma3mMMuGUcHbJpivZ
         gz7x3ugJjM5CsR0bmSF73uBJxggq7JZhvUXJ1W7j0sMNsmflirN42HhnV5FZjGzfVAIO
         3bTVMXDiDpyqjVKk3ySg1Ic+kroTqEx2Oa0UQChK9fgbuz0uHbGp9D7yLgI802xk3cSl
         Bk+CyOhtzbx+MA232xd8LFKDE9nm12/Cm4hKnBVtX04djerzJ0JZo+b+pyVJcNHGzGID
         VlWm7QC5zBkPG0WqlLFNWzTY5OsC7IpEFFdYchm4QZTZjBYMS6Ee2bJeEAVLTJT1utev
         Zqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070238; x=1776675038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HgQLeWF7VlhHIfIZRtJl8ZFwFDqdHrW7SrqKeazeFA=;
        b=baur+6K8REtcA9p5aj3Fom/j1/L0kjtYx4szg7TqTChB6ODleTXvwAyFPgNIeLkpNO
         oZ9Lgqdqcn0+qAArlFuFq2QmTlJSnEKoQlkmLmL2w/xfYlNzrUMLeZUuX1Ako025RhTn
         ZR/H1VT7tV6nq9zjxX0QmDTk5dnq7/Yz4W20lGj6NmBWk16Vpv3/xPI2/Havuwx6bUcA
         H+EH/eFWkdqZ+7QvnO81JLa85ITz6HsZLcXnu7R635v3wqYaYuseAYwxfuLO4EqFMC3Y
         wfmW/pTV375z6ZRLcTaEkgqqwooDcZmnjDwU3W14EOovKvwnpTnJVI4155Fr/5LtFvmG
         mYHw==
X-Gm-Message-State: AOJu0YwP8PIWfFo/80z+Paz/dz15pVwQoJbO4jCdLkeRwXZ1Criv1KrC
	A5CIKHQ1RdK7ThlPpeCjIYcID802CFaz3Qnk0PSIzrLEFHpgNeTvEk/mT2HjTA==
X-Gm-Gg: AeBDieuafluCyALhCCpFIQw8RJa6tHbfnK0khNQrQIG0OBS4HBnW7zE4vVKG/w96rC+
	/1P+Ne/gLYLwAhHkS4XcUk8e8rhWzeA+LDvU6nrxKdpqwnljHjmoLPUSVrSwZeIEl8vnVKGq8Gh
	3jE8I6UAaV5GLF/tgoyDF7K7o0tHM7w0UREDSIX45YVn/qm2utmPnfQhFGCqAdcM4MwOxU2Qtf5
	y3q6BP44RwDyk1XFTaEy1Qud8JeVsi//OE41/qmlSdgnbGb6RDQotc7ZprGKC9/HYvDArcykpuT
	Q1EPhmOf/YbTGaLVqbH4Skp6uyDEsksCTUXld2Dnn90gg4OWlnJncVqF5tVGuxFVssl95VeYCMS
	LJJoJ4okgWPg1GClH4MxPYstJZ9Z8h2f1zfhaHYZLhJM5CYzPK0kxgOP164w1KC3s2p+ZG5y0qO
	TBJxV5YtX9DGCiFBRFMCRmgIYTU4NkD4DsPEYHbTjcD1k4Xpi6BPjtx8SGODs3QZOQ
X-Received: by 2002:a05:6a00:9457:b0:82f:37e3:ae6e with SMTP id d2e1a72fcca58-82f37e3b11fmr3572887b3a.31.1776070238496;
        Mon, 13 Apr 2026 01:50:38 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f3de3e829sm2736973b3a.5.2026.04.13.01.50.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:50:37 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] bpf: btf: reject division by zero in btf_struct_walk for zero-size flex array elements
Date: Mon, 13 Apr 2026 16:50:33 +0800
Message-Id: <20260413085033.71952-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_struct_walk() computes `off = (off - moff) % t->size` when handling
access to a flexible array member. If the element type is a zero-size
struct (e.g., `struct B {}`), t->size is 0 and this causes a division-
by-zero exception. On x86 this triggers a #DE fault resulting in a
kernel panic.

The BTF validator does not reject zero-size structs: btf_struct_check_meta()
passes trivially for vlen=0 structs, and btf_array_resolve() skips the
overflow check for flex arrays (nelems=0). This allows a user to load
crafted BTF containing `struct B {}; struct A { int x; struct B flex[]; }`
and then trigger the crash when the verifier calls btf_struct_walk()
during program load.

Fix this by adding a check for t->size == 0 before the modulo operation.
When a zero-size element type is encountered in a flex array, return
-EINVAL to reject the access.

Note: ARM64 is not affected because its `udiv` instruction returns 0
for division by zero (no exception). However, the resulting incorrect
offset computation would still be a logic bug.

Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 kernel/bpf/btf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 71f9143fe90f..f25009ea0d89 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7103,6 +7103,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		if (!btf_type_is_struct(t))
 			goto error;
 
+		/* Zero-size element type (e.g., empty struct) would cause
+		 * division by zero below. Reject the access.
+		 */
+		if (t->size == 0) {
+			bpf_log(log, "zero-size type in flex array\n");
+			goto error;
+		}
 		off = (off - moff) % t->size;
 		goto again;
 
-- 
2.39.3 (Apple Git-145)

