Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2635E1C9
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753954; cv=none; b=m6MjNB+dtqPiuMYaSZeQ+hOVrfPfgaBjYIGEaz3Zns7j/AAM4YvsiigfxVrtrOAJwOfc/fhRpMf2EqnuZaK6Kl02fIQt5va5/Mkrz6B1bLp5PWGHcSfeRGXM7OzHFIINieDv8hF5zEdh241lbv44z4k3VtGy/MeyMn4DdcZrKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753954; c=relaxed/simple;
	bh=dg97X/e+67WXcWXrY5Xs+7x4fhdd/UomhCbnCgobfSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=puLyNJ1vx9PZMFfPDxrOdLD/+cc3krVI0ofJR6ZPI4owQr++6DRXABpq0M6tB/BjkNMZ2fd9GvvMalNI5Ru4IxMviI7F5WDHDyarc2Ast9awt8oTcnY3DULiKTJlF0UTFxWNowOAKFjFn4/xw2cuJV3yOXjMzPB6y6za9C+wA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wTxFW42D; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wTxFW42D"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781753951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKwvyt3axHXhj8tPc/y9aak92Alj86LCTUNDtn45N0Y=;
	b=wTxFW42D65OP/ixBiK3UKt/6jU9NFiEGwn2JFL03+8RLDbutde5j4CSLHhcDay8XJJQLcA
	5anfM2+bglOjulGPcexKSZxy6LHf1L5PRavulsVLdu+rCh3B7t2nlOvFTZx0JTaVUa5/44
	wxuV3eQpVAJ+dOPXeZbvCQ2rsMFtAo0=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com
Cc: kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4/5] selftests/bpf: Add LoongArch deny list
Date: Thu, 18 Jun 2026 11:38:08 +0800
Message-Id: <20260618033809.98253-5-dongtai.guo@linux.dev>
In-Reply-To: <20260618033809.98253-1-dongtai.guo@linux.dev>
References: <20260618033809.98253-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Some test_progs cases cannot pass on LoongArch and otherwise fail the
run. Add a deny list mirroring the other architectures:

 - arena_atomics: the JIT gates atomic operations on arena pointers
   (bpf_jit_supports_insn() rejects BPF_ATOMIC in the arena case), so
   the verifier rejects these programs early and the skeleton fails to
   load. Observed on LoongArch:

       13: (db) r3 = atomic64_fetch_add((u64 *)(r2 +0), r3)
       BPF_ATOMIC stores into R2 arena is not allowed
       ... failed to load: -EACCES

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/bpf/DENYLIST.loongarch | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.loongarch

diff --git a/tools/testing/selftests/bpf/DENYLIST.loongarch b/tools/testing/selftests/bpf/DENYLIST.loongarch
new file mode 100644
index 000000000000..925005e4298f
--- /dev/null
+++ b/tools/testing/selftests/bpf/DENYLIST.loongarch
@@ -0,0 +1,2 @@
+# loongarch64 deny list for BPF CI and local vmtest
+arena_atomics					# JIT does not support atomics in arena (verifier rejects BPF_ATOMIC on arena pointers)
-- 
2.25.1

