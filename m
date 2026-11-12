Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480324;
	b=C7zvSPrEmbItTe4QqzKakSavp7KAOVsv93QfhAEl1j5VGCJv1hnVUK5dc5w9un3RYsiv
	 b5soZmIml7heKPhX7ag7MYHZ0KSNJeO4FwQH2LgGMWCcz34Iy/y7ZnY4oHkCqJpwAKY4Z
	 OT5D8M1ih/B5yUKY8+5Re+pkomAy+7uRkxFhjbXYZTMiDnHOaT7l/0YfLodvFi+8Ah8ne
	 7A9Rf4a0OGZEP5xKRByUvV9JpltEZ3AUg3cqYXZK7gooaIfYTUO3NZpqs7vnsvxEkTK4b
	 aSEdmoccBPu9WIYm716QVPTcBHSb10ofDfaom5VVybXafnN25SmhIMIdCOC5peI9EDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
	b=KfaGEIs3b9Mx6pUETiiJi6GBOkf2jX0CGrEjr8JlhSd/J0tZEVz/DlQux0UjKSJVy2mz
	 VQFawpW39Ybybvul5nmhZfM1fb1TbARsFtFtkeBD0jSFnQFB0v+b7pp9isoDhh2+R4B3X
	 rF2GE8nfGLkoMJ37bdby3gkj741rbCpXVWTGRkKQW8VDqIgGiSKOJb6VKhE9RvjbLAskF
	 OSCT9i7CaVoTSVf+wCyry9ktT8TqF67j8tAfqY+VLtxDslE9L4vXfBhAaVXiz0xYOLpmS
	 h446gPKXx3ZpFnYDTUFwEiinRjysz37Dhmweyss3iVy3te2uoEcdKV9zK9wgoS6T25g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Zp09kXBl;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6B606A327
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B6B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Zp09kXBl
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3720addb068so7337894eec.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 02:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794480323; x=1795085123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
        b=Zp09kXBl3tmzhNDXnluIDoVu4hJxPbk8hdtimF2khZPOnmQNb/S51ybbT4EWDLGxFw
         Be7xVzGkqwAHxCgQynyRwNUgCxhCFxrW3KOQASvFTF9D8v9z5Ty/Z1wOAnlUMbVzE4Go
         RWxAo8OlK4tyKB8j6Qr7/bQpjb+eWhQrynqXYzLMO/fX+PBfZdj1SoaL4IBkHxGx3rjg
         mVHJPVd0NHLJYHqnhTFUjKsz2XzQFt1cG2JrXhnnmVTqrUwPrdc8l7KrkRFHqmzbjUAQ
         D8vzOQKHC5fSAMhWu8rcUEyk7QBhECesNnISmx9JsCfbfMYsY2GZ9zBZS2JUP9fCcIAv
         Om5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480323; x=1795085123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
        b=WzCJg4Pe8ba1uglneX0zOUOgjY/5ITmvedVKG8PE492bl0+dw85v3Z7HtU6trYqYyk
         J8rk+q/VVlxpNoIoFwZGkK+3PnWUim7VK/T1ohmZHHtWtY1mDcAo5ME9OxmOvBVwrvml
         Pg00j8xfapfgv3aXP8CCZ/e6aL4DvwSq4aKqCVk6f2IITTuPLqlKP0V8zs1N9Zgoq9JN
         HT9MqYOn+8f2XdKOdAMhY0RiaXaWpnAVFLeRpnrMyuQKIbDedreGcfP/izQc9tB6+7lv
         Yikm7pmHJvdKS7Mp8r2zWHKYhHaZjTMQf3aVVNyiuXYB7bIssDl2ofLAOGdCMN8yuwTK
         KLuQ==
X-Forwarded-Encrypted: i=1; AL+hErF0M1VLnqepU4ryTD2QSN1NqEPqjl/5hSQpt9aVAojPaKuMMrkkjeRdAoLvu73/NQALds0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wttfgAxyjo+bdEgxM+Xaoddi1AXI8GTLQ+1j7ywcXasN1O+La
	HnF/1RaP9Og4f40wnnE7Oi3WND7zV2TurVzdyQEHtwKG0588+SkiTmn2Ze13MH2L7go=
X-Gm-Gg: AYBFou3xxTqlUxSeGfSgunluOsO7b4OhRuhu7rfKQUepzwAZ7l5kZjRqCQrDag7MLCE
	M9a+qKmFr0wOMBoljgw4/qNjO3AK8iRWa92REkw0hcBXpcvYJVTGhSeu0Wfg+nPSEtolCr9pnTf
	QnPTypFD0UY9J0figkA+i0bTsm28bQBlNI2mbW2VzZUvairOkRPveFYHRZ/VlXAORb2V2xLkzWx
	BuJN9hVQSxAwlwY8hlnXe61+z2fMVwnd3lEzS49f0WHnz/R0pN3VeDj/gHAs+WAJ5PSBHkulKkn
	y78y/Y4JutRK80W3Ux8mZB6HJy4Se3qouH9F60qzIey1VaJaFxmi3hGstFB339/P0EFnf05QCPV
	GkGYN3CKoC4CzXIfFWzWsnL7Cb89prcJwDdJqmAp86S1gUWFnyDOsXrvEe6CDXNr4IAb9nrk4fp
	gvVHbKnNyM5csS/z5N2o82w2e0f06x9H9PVoexkaD3R7eHfIYtCp6129eoNwQndWNLCM4+aQbxO
	G3epRK0/uY/ElJ9/rmIv7UrxJegNDxTVmvqtWtBix6pfbOul9zEitV+VA3AhvShfkB0ONzWUpSt
	E/wxsfu7GVqkfRyFIv494Rze1zhFPqLaTCVrnKAo3NDfxdDdgu87iTiLwWLQ0mFmCvQ=
X-Received: by 2002:a05:693c:69c8:b0:369:fe81:a575 with SMTP id 5a478bee46e88-37686756684mr5116143eec.35.1794480322588;
        Thu, 12 Nov 2026 02:45:22 -0800 (PST)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3772121e654sm13228694eec.2.2026.11.12.02.45.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 02:45:22 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	oleg@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	broonie@kernel.org,
	cuiyunhui@bytedance.com,
	dave@stgolabs.net,
	david.laight.linux@gmail.com,
	jszhang@kernel.org,
	tglx@kernel.org,
	conor.dooley@microchip.com,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v10 9/9] riscv: select HAVE_CMPXCHG_LOCAL
Date: Thu, 12 Nov 2026 18:41:49 +0800
Message-Id: <20261112104149.38589-10-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20261112104149.38589-1-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
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

Now that RISC-V provides this_cpu_cmpxchg(), select
HAVE_CMPXCHG_LOCAL so mm/vmstat.c and lib/percpu_counter.c can use
this_cpu_try_cmpxchg() instead of serializing per-CPU counter updates
with local_irq_save() and local_irq_restore().

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20260826010748.zphu3wh2hlm4t4o2@offworld
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bde1f1885038f..458ef01e926a4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -155,6 +155,7 @@ config RISCV
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_BUILDTIME_MCOUNT_SORT
+	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
-- 
2.39.5

