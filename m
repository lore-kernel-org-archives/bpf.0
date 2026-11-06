Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998343;
	b=Hp2CRv0bp4ZHCfXwBCYDZIQigjbRZz/yB8oij+dsG2Q/ZFiMzeB4mu9lShxNB2QwMA6n
	 69aDa/yFoq7Hi25raNZJF8tgrrAtddAjNAgdRgpo8C72AYKRY3qVCUzYvrRioC3hNg8+3
	 1uo9k6ZdqeZoHu8v7shZBzpJORIzhQuKcbzgLd6GrcBuiONWtbtFC4+HOFzeySdTtclkw
	 owtQdJGVZQTZzwHCTO85bSqQrQrhbh6Qx+4ZRHpniLjUOTVsvo/k9ER5Jb7xmlBVZMr7Z
	 jVKjl6phce0DB8Ea5uRtxJH4iUyg80i6b7HTzj3224PGrh66VQC41sqMZSGEvvKlLDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EBN/xCnp/8GohhExG8p2CJhgpS6H5k9nu5w5MsfDJqc=;
	b=L0rhwogSBCU6z55a9EK1CaKImESms+55Hbye7AOw2UkTtCn1Xo1Zj5SbSH1z1rJpiFaB
	 xYEz0J5gHpaskgIgUA3hM9R7upa/3zGEojUoM/VxG8FOk2K6WXZFoC00/jMMMIiplj5qk
	 nYpydzLzaZGNh+OOANYL6c6Df1gm/wjY2Zs1jqPiYcPmHOU9PabkBaG+fKwbBI4ugy4GG
	 XBbMR/Nh9KCtwIF92LMDtaYuXX9WmNGZEbNEvEVQn7f5WZYoR6R7XR8qFeBXXvL0U3a0k
	 AJHglNV8S1fxtLuiSnIJXWjAld+Ss6q+lN86ZMA4UlN5LXX6/hwpqZs8j2oDORTHdZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rP47Yk3s;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0D6082BEB
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB0D6082BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rP47Yk3s
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso10247735e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998341; x=1794603141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBN/xCnp/8GohhExG8p2CJhgpS6H5k9nu5w5MsfDJqc=;
        b=rP47Yk3sh1K4+PEzUxNA97M14ZZ1QFYAELMiqRp/JrZR0X9MzKusAuPt+VhMR8dws+
         RHh+qIw+8BTaLrvikt+u53rz+2vZrJ6eyWV2EGVfDizKKbvFdasba9clcWtownAA/TSB
         TR2zBRZgiuPC1sqiokTfZyuzxufmB2FhgH5OGvKf8Ku2q0O+QG8hySe68LwmekOIzfle
         ubEqvuenLKK0a9AvoyC+QWP6Joi4WPR07y6nfshhFK/IaxyhvyqV3ibfn0MtJ7LAARQF
         EiyIDxcuZz2/noHCJFofagKVOf2D75cuJbqYcjI8/+7LbGV/4iBpG4FcPQeUSHog5A3n
         6P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998341; x=1794603141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBN/xCnp/8GohhExG8p2CJhgpS6H5k9nu5w5MsfDJqc=;
        b=gmMQKH9VVYDJX8GacWgMJx1QSkAkAz0ht67HnyYCPqqk9MDf5i1s8sS9Hvy61pAe1c
         rdMIOLnEhhbY0sa59KbLfPZexobaWw/HQL6xTeHEd/QoXD8xnya+Fr/uMu8VxJzaMzai
         ed2+BGa1WeAN3JXFZbbkFumrW/BpxeIZkEnujwpewhd3qC5dTVgRRwBJAXePds3euPiM
         LRCzIkA7XQMFoam7CDZWessg2wUHLKzuNqoaNbej7OYh3beZn9Vj7pGwS7+FVFYjR/6c
         YpjWie8m8FaavToXcwk19ZUYVL/GjozZLQkCOp9W9KTAcPiQJHle8nPTzlwJZAPliBr9
         Yg5w==
X-Forwarded-Encrypted: i=1; AKwUvByYNckaKHTNmCpuEg336UTKAUMlghWJsZ+3YW3fYlPbbwsiOxaMw0/RgNt+dyyZIU4fOdk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5RZZ2gvUBTwF55gfc98F7ZcQ3ADH6XNMaG2l2vBBEMBIuIxlG
	O4s6/Kpt3sziW6VoMOiIueWzVMrCglTcv+6itvXWQ2b6aLtLcFfSxfagw3F9Rg==
X-Gm-Gg: AYBFou1Hmg11Lp3Pb2XI7054loOGAW7Fl/LESUa4FX+CzYpIm/e0SgEnvtCSIL6oEUE
	JgI0naFmzWvNRwhxhkXeO28WgbCjT2PdHeO0Hs6z+JNAxut1rftwXbGGbeRoCB7QL7tabhpZrSh
	D3QbWgv23Md4EcuW2l+5AlL2CzPWvWg2gf1KGMBbba7Y8QkChVyVuuU1O0NoZBwToMx508kBbKg
	4iNblxD12DT6oLLblqchcZ7X3WrPSu8LNvqcWv+GOz4PtcGtkRjqM/x32CG8TxMUI3vLSLNnVTK
	CrNY9y0YrEYbGPssq/hQkWccH3MjBoSk2EGCxTiLe0z27umCkf2G4IvoJAUgUGIbpoQ/8IDuAr+
	ckIj4csXlYGd+O10b5EnELiJOTsWiomGbGaPEz3iD9GsndzCXlR/SYHY5NN1ctn6qrjv/12+Ubr
	D7qTZcKuiJ4sOkLy8oiCMtYBkaf2U3jxTEZSOZarlebKWuB89q9q7dlatw/tUsUxmfXO0dPnlcV
	EL1fj5YUsrtU8HgBK2DvJ5A132oVhNajpyqpiJ1Ch+UKJyt7yGhMWYU5psbEX+I3ni3dHXEYJKs
	KMRafyhNSVLFH9gnAzzpUzR/uidZOSjhg/o/hPf5QssVaqo=
X-Received: by 2002:a05:600c:608a:b0:4a2:1364:252a with SMTP id 5b1f17b1804b1-4b6db0d07dbmr63129425e9.3.1793998340666;
        Fri, 06 Nov 2026 12:52:20 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:20 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 17/18] selftests/bpf: Enable bpf_scan_ir in the config
Date: Fri,  6 Nov 2026 21:03:06 +0000
Message-ID: <20261106210314.1767267-17-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_scan_ir plugin is off by default. Without it bpf_testmod has no
fixtures for the plugin and fmodret_retval skips. Enable the plugin in
the selftests config, so CI builds and tests it. Kconfig ignores the
options with GCC and with clang older than 19.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 49dfe939467c..5461c32cd3cd 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -11,6 +11,7 @@ CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
 CONFIG_CGROUP_BPF=y
+CONFIG_CLANG_PLUGIN_BPF_SCAN_IR=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MLDSA=y
 CONFIG_CRYPTO_SHA256=y
@@ -56,6 +57,7 @@ CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
 CONFIG_LIRC=y
 CONFIG_LIVEPATCH=y
+CONFIG_LLVM_PLUGINS=y
 CONFIG_LWTUNNEL=y
 CONFIG_LWTUNNEL_BPF=y
 CONFIG_MEMCG=y
-- 
2.43.0

