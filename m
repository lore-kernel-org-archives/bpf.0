Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10B2F8E8D
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959134; cv=none; b=fEIrg3WvNFTmAWjBxElzsm/Z8WPtYW/j5DMsWuJJ+7xYju2ZUfsr9tWrCpqeVLhC9fcysYNwdKjr9I1vpNjw4Kh1ETpd79j+46hkU5fMzsVD5CrJSlaIWTyLCv0FqX0A2/K3ha9UOzeijy62ipv3WWrV1D8mK/D9mihuEw7TiBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959134; c=relaxed/simple;
	bh=DbUXG4TTEBNVRHK8jUWgnmK48IhZirjakIZAQtKW1A0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7jDus2M3Rzcwp84vOsy/Eq/DY60hby7NTSveIccRowplsPRTNHsK+BiyjHNWHaM7QGEQDXasu7lpcoUT/SiTG6oeRQmlC5lW8q1WXFTj8Z4IsLRRPxk4BGoEsnxjzavmIyT52RM/L//DSTu82Uk5tUEzKms0Xf4p1TJWlo/T/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=klC7Dfcx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="klC7Dfcx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBFT7UVCiA+ebieOlHk0IAtV4TSScjRXp6MUi9P9uLY=;
	b=klC7DfcxjvjmkATsTInsKSMBRCOTW2OKKZ99HlXtdpssDcgIRQISDk6j/qabdQOaRneYjB
	IOSEi/f0QqyEBYPliUF302FYNdghl98bx0KWYFliEyPsUx+6ypcSdpNmlbkOfFtElLtFdj
	TlYQi+5DhU+/kllsosuiL1GCxAbdYXg=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 11/11] selftests/bpf: Add LoongArch deny list
Date: Thu,  2 Jul 2026 10:23:22 +0800
Message-Id: <20260702022322.51033-12-dongtai.guo@linux.dev>
In-Reply-To: <20260702022322.51033-1-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Add an empty test_progs deny list for LoongArch, mirroring the other
architectures, so BPF CI and local vmtest have a place to record cases
that cannot pass on LoongArch.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/bpf/DENYLIST.loongarch | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.loongarch

diff --git a/tools/testing/selftests/bpf/DENYLIST.loongarch b/tools/testing/selftests/bpf/DENYLIST.loongarch
new file mode 100644
index 000000000000..70cc007e396e
--- /dev/null
+++ b/tools/testing/selftests/bpf/DENYLIST.loongarch
@@ -0,0 +1 @@
+# loongarch64 deny list for BPF CI and local vmtest
-- 
2.25.1

