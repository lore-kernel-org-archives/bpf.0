Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCD383C60;
	Mon, 13 Apr 2026 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104950; cv=none; b=LZ8ja8JIKXrJdja0xuPpyuajbJG1Ub9MBBxFXeZ6Kez7zvHOCzq49hAay4agaYeyUOrKBerWKh2134g7hU9nNRJs8pKLfB8I/AAgKBrNM2XA/af4ygoqOerDsx0M6hx6neFeuNicDcseNz0gHxPIZIBSdCV1SIU6gXKCa8JtYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104950; c=relaxed/simple;
	bh=qyLxzf8Ns2Ft5golu4A1kMhZlxoBRSzZkWlrr38IOZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmY+Fijcyak3evM+tw6WRuSbeUqC9fA6hloa3ok35+egDUvRZ3+Y4gV24rI2uaO0wPzcYZjvJfIK9onezHSVPQa8LW5f1ySj8euhDzwbEwyBeZIskKLrRcpouj71qglBawxAhuPfxsG1PeSvj5g7Z9EBUoylzJpSXKObWdSPiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cZBSYs58; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cZBSYs58"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 226B41A31EF;
	Mon, 13 Apr 2026 18:29:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E99BB5FFB9;
	Mon, 13 Apr 2026 18:29:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE28C104504C2;
	Mon, 13 Apr 2026 20:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776104939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J6w/vm8RhE1QibuAbeZrZpu+mbFZf/j6v7Old22bTNI=;
	b=cZBSYs587EC2pPG0T0zWnt6Rm3YWgLoLQHo/fERZmvyCcXnMbHG6UHv4UW2EhRe6AcwwK4
	rLJqLN0QcpxJ+eU2wnigOQQIs5tEOULYPsd1eLcu1LilosOrM1UCnTdfl+hYwGPMfNEMV/
	/5Ph0br4h41uQYEnh8/FBrJsTvpWOM11sOt/QM2ZTP7geak6StbyhdakN5Z/m5BxbpCjin
	o8OFL6dggWmiW+3fP5D/aD3dYrcXLqeqZdzncuDbmqmu9QPwy6ZHA14bp/bp5laVHfSfBf
	7xNDlnmSlRRrNNIRvXgvQWAu27n6dhrzs7GZ2IUSyjAbZY1p1dja0IfA16reIg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 13 Apr 2026 20:28:41 +0200
Subject: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-kasan-v1-1-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3

In order to prepare KASAN helpers to be called from the eBPF subsystem
(to add KASAN instrumentation at runtime when JITing eBPF programs),
expose the __asan_{load,store}X functions in linux/kasan.h

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 include/linux/kasan.h | 13 +++++++++++++
 mm/kasan/kasan.h      | 10 ----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 338a1921a50a..6f580d4a39e4 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -710,4 +710,17 @@ void kasan_non_canonical_hook(unsigned long addr);
 static inline void kasan_non_canonical_hook(unsigned long addr) { }
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
+#ifdef CONFIG_KASAN_GENERIC
+void __asan_load1(void *p);
+void __asan_store1(void *p);
+void __asan_load2(void *p);
+void __asan_store2(void *p);
+void __asan_load4(void *p);
+void __asan_store4(void *p);
+void __asan_load8(void *p);
+void __asan_store8(void *p);
+void __asan_load16(void *p);
+void __asan_store16(void *p);
+#endif /* CONFIG_KASAN_GENERIC */
+
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index fc9169a54766..3bfce8eb3135 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -594,16 +594,6 @@ void __asan_handle_no_return(void);
 void __asan_alloca_poison(void *, ssize_t size);
 void __asan_allocas_unpoison(void *stack_top, ssize_t stack_bottom);
 
-void __asan_load1(void *);
-void __asan_store1(void *);
-void __asan_load2(void *);
-void __asan_store2(void *);
-void __asan_load4(void *);
-void __asan_store4(void *);
-void __asan_load8(void *);
-void __asan_store8(void *);
-void __asan_load16(void *);
-void __asan_store16(void *);
 void __asan_loadN(void *, ssize_t size);
 void __asan_storeN(void *, ssize_t size);
 

-- 
2.53.0

