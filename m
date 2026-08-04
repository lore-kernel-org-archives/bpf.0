Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9B47125F;
	Tue,  4 Aug 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865578; cv=none; b=EUwHYGo3FMIIXqJcCu6I6eCLlAWlOrWpuQcm4OaD0FjKZg1j0ZFlWkIPNNjPS4vIBoLjXylKs/yF/w//l5EbxS4hGg+qdxQecsb7RVeVRRPN0jYnMOeq/yjOrzPOjNamB3txthoLSnJHw3D8Kb/yuTScR0iCvkF/nNEEkBACrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865578; c=relaxed/simple;
	bh=UirKyiXLzyCsUKT9cm3HTYz1t7MKHUMep1FY5qYjkx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLQ8ioGhs5rK5anF6CPGJDZoZWoegmfJKCWVIrL+gLNh+yTimmbtlNPtXrSxLyH1/sN3YoRNYmLSw6gtfzeaaJKByUYhy5IZyW6Uff3Po5tt/SYV3LtCcEN1885BRpiNv0cFmRiBXYSuhexGoTgLtgRAizEqWe2tJcgx0SMYetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GFTpKaI7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GFTpKaI7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3D2A24E410ED;
	Tue,  4 Aug 2026 17:46:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D2566029E;
	Tue,  4 Aug 2026 17:46:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B18F11C33450;
	Tue,  4 Aug 2026 19:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785865567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TLGetkOMjTqN/SGQEQrmZkSD5SWQr9KxLQAjM0WYKgM=;
	b=GFTpKaI7tg7e42fci69QaNs5/83z7mbgNRkIjLjG2Ib1IgUoeHLXEmAh9rKm1QKEc7sp5X
	YPwXTDKo04ZAw3inZ8zvHNavYUOe52Jx3tjA2bWYKOrh8nhJmqD18bAXHH2Obax4Q47jMl
	+eeoqI2P3usXsIW+iesG41MI2dnhxooNO0ZPPPEFDCjY7x6oVxYwHhR/E98tSDHRhbyc15
	S27jOH9ELvtN3JQsPqTNXBFxt4N6OJoL2Raakb0SE+J+k9bNJn18eyFDGeImkg3+U++of5
	GWCMFgraKn16QRDT1Abr9Dx8wUo0XCK7sr5zA0tALALwHz47lUDAy8BlcAFJHQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 04 Aug 2026 19:45:36 +0200
Subject: [PATCH bpf-next v6 5/9] bpf, x86: enable KASAN for JITed programs
 on x86
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-kasan-v6-5-549ef845f491@bootlin.com>
References: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
In-Reply-To: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Mark x86 as supporting KASAN checks in JITed programs so that the
corresponding JIT compiler inserts checks on the translated
instructions.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..705a9ab85f3a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -233,6 +233,7 @@ config X86
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
+	select HAVE_EBPF_JIT_KASAN		if X86_64
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA			if X86_32
 	select HAVE_EXIT_THREAD

-- 
2.55.0

