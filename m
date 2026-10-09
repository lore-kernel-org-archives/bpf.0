Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089AA33BBD9
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510602; cv=none; b=nIJbjXJOP4YHlxWCnXA9QzxqGm/3uIExWIFYJ9FZ1Y7EkaRzDMyfneVY4AquO94dNEu6RUwnP1co6VkHyc1BRepVM+2JIPaYZmgvkYUza0tlNKgSx4y15iyDT5q/uMS+2iaynkGgEeeC68QKGS/SYBOUO1UvAQNHGSSAvmtVZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510602; c=relaxed/simple;
	bh=X0vtE7OZH4JLFTpicfwaCIuiPS6LueobfsdoRdEygVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/YpGzJ7zj534iui4xG9zhxsxIrjDk2YU+bGcY3zh1SsM+siiUkl3J2VP15GwN2pvxh+oCy0RXDT0C8DC2WbFJnBVXiHxPweF2/pUAmhmqUEvmmQKsHPNmGgWERTf39ObjX+dag7j9eUiAcrc/fGFSVA5X/C40h+FLIGJ/T+Mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqa4H4dX; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqa4H4dX"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3515f9a5d25so1917267eec.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510600; x=1792115400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LhBtwauxvVTRUojS6sPANeKDuX63NmNWC78ZgjKXm9U=;
        b=Kqa4H4dXfgfgIK8Dxd9pUeb8nxhVaI7cNu5nzddv6A9wrkVDLHN+P3ZW4kJhMXODqt
         Y06eJPfnsqnUaNQ2GG/sEUmegu8pqlhqK627fhgkx5ec4XjWt/TmzXq8wI9F6QWV5I4I
         HhxYyEb9FQ3b8I0O2rDapGzVfNV738nVjQ9QU1mzjNyT1ht4qw70v9eKSXctUQiD73BI
         JDONm2GAxz5VH5W7wU6pkPK1lGjdtbtxCDixobojUa9OBySJ9KEPgrAxE0Uh9mqxOeIM
         oRQfnG801hdDSRt7r+PL3QbpJhI0QLmKiUU2rPeO7nER0BrLwUA/DjZjaFMjL/0ZBinK
         +d1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510600; x=1792115400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LhBtwauxvVTRUojS6sPANeKDuX63NmNWC78ZgjKXm9U=;
        b=ej+mXT4TlmrJ2OtupwUh2lKKvZNYBa4AmJ4FziGzXH9YttC5z2MhT033fcjivsPPqF
         c+WR0LW00QRKQ8Vz5SrgLi0GN0xWIgzukOignrEgkOMUGi9oPpVl5+FdR2oTK6fjF9QC
         ppx/PzH+sxwCav7KnmrqfSRSfdN2BIM09A5s1JxH9wkFw2rOtEpPX1nYay/Eglr3197w
         q2/BPPx8+a/epUJdF+5OCir7UVK8fNODT/S8Rw0EVuS94rp/2ImotnGL9CxlUazLw0AR
         zBPpBB7YoLCIHzl4dOiltDi6SE3V61OXAFDTjYy387MLV/nNg0F2f1YOR2QRX6MrMTfi
         IcYA==
X-Gm-Message-State: AFuF++kEOo3AhQedokdGtKBAWTwnDh969P/6n9dHpIyOEcwelXx43zrp
	TK44IZ4GtPFYaZAgKQPqRY5yEYg698hzBBrMJ1qPSLbwoQcc2Iyd32HE
X-Gm-Gg: AYBFou1XhvRXDTWelW2+8DRGmw5LQiWYz9ZodOjay82XCVRsuijFu1T2KZ0Wzw2QBei
	Y9bTJo6ihJYt/PW8u9lNjgL/gCwGoxsE918c3rQL4TEoafdHQ/FSoGQyAoyhnUQCRscKgOSrGu/
	z9yWQV3KPjKQXcsK58pe2FwIY3hlnONzGORMM51bmv4x9j8JMmfVfn9nrbCZ1PtMw7D8i/druND
	u+XGqolVDIPUCUGmxlXlkU47UzE50AZSFl+BIK4wHIjp3Cg3P5TnWJXhGOV0F2nFfFyKCTeS58F
	A9mrz400sGJ3SofDuGP1Yaw+phejojZai3XXLkz6Nzp8GQL4uB3QY/s4UYsYyP+/koVIoHRSvvl
	tzLwDtL9cIii+DKfBMjdgCdpoH4rVGYep6fiCyK6zgt8cJ9hx1UXy62iRoaltdjJ9L1LdqMe5tN
	DT7+xzvwWPldSCMCRVEFyWGDzfW2UtocEL0/v/i22F1BzuuOVM7fVpPTl8LzcuGz30+Q==
X-Received: by 2002:a05:7300:fd03:b0:351:4866:255c with SMTP id 5a478bee46e88-3537e058277mr1162820eec.32.1791510600015;
        Thu, 08 Oct 2026 18:50:00 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1d6e6sm1984845eec.24.2026.10.08.18.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:49:59 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 09 Oct 2026 09:49:51 +0800
Subject: [PATCH bpf-next 1/2] selftests/bpf: Return the lock error from
 buddy_init() of libarena
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-selftests-bpf-libarena-nr-cpus-v1-1-e726ccc66fc6@gmail.com>
References: <20261009-selftests-bpf-libarena-nr-cpus-v1-0-e726ccc66fc6@gmail.com>
In-Reply-To: <20261009-selftests-bpf-libarena-nr-cpus-v1-0-e726ccc66fc6@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

buddy_init() takes the buddy lock, an arena spin lock, to put its first
chunk on the list, and returns -EINVAL when it can't.

arena_spin_lock() fails with -EOPNOTSUPP on kernels built with more
than 1024 possible CPUs, where it has no queue node for every CPU, and
with -ETIMEDOUT or -EBUSY otherwise. Returning -EINVAL for all of them
hides which one happened from the caller.

Return the error of the lock.

Fixes: b1487dc1b181 ("selftests/bpf: Add selftests for libarena buddy allocator")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 2490ab1396de0..7bb99a7cb63ed 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -576,9 +576,10 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
 	chunk = buddy_chunk_get(buddy);
 
-	if (buddy_lock(buddy, flags)) {
+	ret = buddy_lock(buddy, flags);
+	if (ret) {
 		bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
-		return -EINVAL;
+		return ret;
 	}
 
 	/* Chunk is already properly unpoisoned if allocated. */

-- 
2.43.0

