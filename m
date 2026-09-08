Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5E025EF87
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846606; cv=none; b=jtvTSW9Ofe2n4qq+awDfvLDHOWbSqeSUxzefLv4C+zT7ZjiGi0gdEwY604BSKkw37RyVgiAWVGLYHtDhgLszC7eDC5dZQH8jZoEF8aXSqMPTGjrDNLHzFv6n1ZKFKIGMXOse0+lGx8WqvtdfAMwN2hc9iuZA0IPkcOKzQJAG4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846606; c=relaxed/simple;
	bh=kuRqLYU/bVAolAtuT0lNsNPBb3H44v+1z9+WGNYvrCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVq1rszQfeKmPbPaM7NXCH3DkdxEjuFrNMfJ/zcKIbOJe6nUyDL/nMK2iXFoIwySYHs/tzJCrhPsuGgX7a8/UuyrN9e7Yj32uAtTioRQxrOLbVMBHOQ60ZlM+scgCo/XUf5T3l030wAKpiW9pJvnNre5UQhMshDxzglMPL3Rh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwXXfTsY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwXXfTsY"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso3530579b3a.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846604; x=1789451404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
        b=XwXXfTsYF9cY8pkPapoKPfNcuODFHqV39MRPPaVSTVQ7sUfNQAzjiBC1pRVbrdsBbJ
         LUgj3Ryp9o/LvD1CQXZQfaz2zXpEgD/QlfEC0tat+2D+QTKwfG8//8Ch2zgXYbKfndYA
         Nmiq/pICe1U6XESPT4L8IXwFuWML+RCA/AINdeZ6+adJcUCVLvDKu3lusM6F8U/2392A
         QsRlMc0aPzKBsP9wWcjTUIH1tBrwdqXSVjKCVsB1GW5enT0YBlWzG+SWwsMhnf5VDuqQ
         vsUhak5j8tFnxVzKI1pIoutlfrDMEhCs8JE2iTZc+rbp1uZoNC00GF0r58DwVgf3dHvI
         NkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846604; x=1789451404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
        b=K4q0MsD40U6fUlcAvif0d8nf1vz5aFwtgIN1ac6LGz+jGPP/4m7G3cHEa8e4WqXuK5
         oVvg7FhHludj/i9zlsHe1gVx6Wupgt8Xoa3XdBqSpB+ibdQK6C+89eOkPe652nzMgr3f
         Vu/M/bnaqhAR2/xmM4ZFqEe3UhoA5CtwbMAQiwNUoYU/ck+tMGoThvAULaX3cpsTNq21
         PRtudYw0K0XUolFBirry0/O3D0M4JcPZnmR/JT+UrI+rKLrAtBpbzVSIQqVCqCkfu6c9
         woGfS+CuKaJygv71M/tD1Ks3aAgRQz8vp0NF26r8/IHePN98bgk7H/7nrRiHFcw4XtOD
         vm6A==
X-Gm-Message-State: AFuF++lIrZEGAgicIHEhs249H6fmSXKCaGNiXQrMzKN+va9yx5nRAFKt
	pOHVbaNUInOlvM5PApZtlyDrGtnCGsD4OzC6Coqt/CATXW6mU1QNnoK0
X-Gm-Gg: AYBFou0wAJda8+SDCYjhQn48vOel6l9GzOhloOyOsDfMmOYqkqt5rvAlw6T4HMjG63G
	8x+APct0isNPBgMmSDp1VL7n7JS2rlWxNA+H+394A98vOmtzl7lP8PtmxfuPO6nnFoxrwpLqs9s
	9/D4VPNK+EY4Kxid7COTQ07+DMRPh3xCCGhS9d3zw+YO/Mb216EUY7jJ4HDmndhk5lfjNbT58Eg
	GcpjCGktES2A3iYcGnNky60wTG8zqd95nrCjx25Dp1FMD5Hc27Y40XWYjTwHF/ZUyCVW41ShjK4
	J0jql3Y0PWN8VLkzllHnM3VcMzS/w3388EPuwwnBVtzv3KXn+n6VKBtXYYGPXy6vqW5vyFXoT69
	KDlGNGvGHE98rMXQncNoA7qWln3bn7X1ZV/sK0slbXHm+KooTAlKIpfDiHoNesEztBj9Ddp3kUB
	w5M8iO+PmfVU5plx/zkhGAqaV4zSu/YwfZLhd4htwiW/kuWdlYNAcCEbGaWtNOLUzExc9SeSeIZ
	ZF+IvQ9To9bpuKoCoqHhiK8
X-Received: by 2002:a05:6a21:7989:b0:3da:421e:40f3 with SMTP id adf61e73a8af0-3da421e4978mr36173588637.17.1788846604363;
        Mon, 07 Sep 2026 22:50:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:50:04 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH bpf-next v4 7/7] selftests/bpf: fix repeated words in comments
Date: Tue,  8 Sep 2026 11:18:53 +0530
Message-ID: <20260908054853.13820-8-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop repeated words in comments, reported by scripts/checkpatch.pl.  Only
touches comments, no code changes.

The subject prefix changed since v1, from "selftests: bpf:" to
"selftests/bpf:", to match the rest of the history in this directory.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
index de656b69d13a..fb50ee4ad097 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -204,7 +204,7 @@ static __always_inline bool check_asan_args(s8 __arena *addr, size_t size,
 		goto confirmed_valid;
 
 	/*
-	 * Wraparound is possible for values close to the the edge of the
+	 * Wraparound is possible for values close to the edge of the
 	 * 4GiB boundary of the arena (last valid address is 1UL << 32 - 1).
 	 *
 	 *
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index c6699159dacd..e44a979270ea 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1511,7 +1511,7 @@ __naked int checkpoint_states_deletion(void)
 	 * would get equal to one of the explored states and thus loop
 	 * exploration would be finished (at-least for a specific path).
 	 * Verifier evicts explored states with high miss to hit ratio
-	 * to to avoid comparing current state with too many explored
+	 * to avoid comparing current state with too many explored
 	 * states per instruction.
 	 * This test is designed to "stress test" eviction policy defined using formula:
 	 *
-- 
2.48.1

