Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212816;
	b=3bCoEoyGUBxiINmgSA2BW/cXp5b2xiGqTEZx9U93X9dduJ1FjHZD47fsMoZ0F138CmR0
	 onFgsRWIfznX4eikh+SrG0dN+dhbYuwg1kKaY12PZrEakDA20EglhxEiZaWTeNxqwvv2D
	 CfGtKkDHPmEWxjwapIpK9PU1/Jg0piQsVj7xxd5BD3bHzHxl3lwP1wkYdklfKzdRPmPk4
	 JPy0I5m6wAaONwWS4HyDIhMA816c5UcbNoAOTbJeffskfB8cBZ7r3yfh7M0nH/eUfPWX7
	 KRdauVkmgeAEIbkzeSgjhBcT3Bevp3nLmjqHDjSuNMxDKhKybuIGnCycihnCpqsXHcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QiKOO0YrqKharvG7Lk0X9XBUnnQ3jxJPKziFFjzJ2Mw=;
	b=uj3jLIwgzH+PozS5+usNyFwpS8V44ezHHrCFzTT/HRNwliJ8KHeX1W3tIOUP5fT3g138
	 f4Qn275Q82o7VgW/rCMwucH41HaDGKaro+8i87KB8PfdOnEt4UjTZzmaiF8y0br1TwQAr
	 N6w1Bidp6+D4G5CZiJ/IxfAAefaSKryLFbI8wg9fvdxdC1s3Y7xJrI4AS1vX3kdA+v/w3
	 ZoaTZYIu00bG9QlJjBpskvneqZiNTpcVWQzKBMm3tDvuQEZW1EsTNsk61yaVP+iFCwmQ3
	 x69LSJ6a2vUB9S265FdgCIbW9sHYNSSMIi8kgHQ2eQYpkjxR+yxyNXt61ZLwvjTDSKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tD3pDpnl;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9F606A31C
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 18:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C9F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tD3pDpnl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so12506505e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793212814; x=1793817614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QiKOO0YrqKharvG7Lk0X9XBUnnQ3jxJPKziFFjzJ2Mw=;
        b=tD3pDpnlXy0LkVNdZuYH7NK64MjzEnlKvp44lGFujmHV9TJZEVqtcNtNO7rr3Xr1ZK
         lVY1LdNvqSSMTyOY9ViS94NIYVu2ZhlDf3RffiFOkZP5C14n+w1l+CSqHiBc5sadFRQp
         zv/KuzK/vMd6L0DHutVe9desnAeYM4Sp5+Gg7MSNfOuUGnHNuddgX5xqM11JvzvIz+/1
         WAQBnCi/5xS2lvmNPh57WKwjWGJPesDMYtOCYKIEhADpEu9tYzqF6wU2tOAQpRY6kuSl
         sDHRhK0VCumOdypux/BHZl+g9VAmbM+iCAdnwX8u5uyudAbhr9HOJNxz4r+aAKesYqEw
         oy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212814; x=1793817614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QiKOO0YrqKharvG7Lk0X9XBUnnQ3jxJPKziFFjzJ2Mw=;
        b=QOHLOOy0cB0EDqu/Jq654Xwt4W5jLAgc4wJjM6JsZyO80JIVBEWG/ccZItPq/Zhvld
         uOelV/TMXDQRijwwxvDPW7lgdVUCeBlRGzHBKcgZ0Q129lItpsn0VtTE7NNR8e69d7Wm
         gulA4ScctAp8MnnNyZ312NcnEMPP+Rm6cSS1BePVEQPzRZS3Wm8yR1rD6JIKfld00ZqP
         9sIUBuGvxAETxpNymDNuvpmpcd/AMP0s1F1N/9n3yanNENjTwkXEYS4ZWFyc7gR65bLM
         errVIKpbISCA5NV903T4LyA8ZqexXHC0WIqbbwOOhwVXKRcb2u6bidkxN14Lpd5aaxzd
         9EhA==
X-Gm-Message-State: AFq9FYIVC+9ONqrppyX5CwN+yLLNb4V3m5k1v/g1pbrVQkoiWiVmkDKl
	a0CG+GLrboXwzV9SBD6l74zwB/cYOHmj7nDz/99oYW8HxqDpfBlQFHBqizjP+74Y
X-Gm-Gg: AYBFou0S5IriXaZuDAlIbsDY5MK+wqc8dBuHstgkYBZh1h2H1eFy59EiImkgV521mhV
	HheOz+Ny9epr9lnqoporEER0Ue+l96u/BJHGnYKO1rHwTU1m3oLw37zhNyWanowD5XLTyg+6qB1
	esJP2JwIfKGC8OpkMsh4zHitCyv1il8LO/NtPRySDLzcGoDSkfKXFJwiIN0GdFflQKLzExO2dvy
	fxSjJZJ1jzRNciTBLnslWpAKpiGbjXJLZLk/hs9cTB2mGq8+YS9Qn0r6aDA1/1AO7HBSx5sxt/7
	IpQLL7Ao9jnqTABneHqHw6Laq2SPLxbIRjJXdrFTiJBbOTaN509pW3qeZYxpS2JVrkLeHXU17Aj
	bHxw4Dvmv755YPUGEtK8cMsbpK4fgYPFMMhl62iywAdOIBp5LhMW+mIKj3xAxCFvajgG8eFGx22
	m+nu8bzlU6pD/8LxUh+JYYs0qjTCm00bB8AROu94n6SSkMDH7J0o3CiqbWN3ufbs7AgPXyZqS+A
	Qy2uzqfPbq2FlgI4lKss6LCgeRCY0MIcxGBk/N1kgLzFj42Yot2pKbp/kw8h88oyEPRdXaCcjWg
	icQmvHhVXtwNpOlvaIWJGiKQtrf7ryYsgwwCFhOpcCenZdcpI1tocc8mwCAgDmjQ70KoywKWHi1
	dw0/vR3Lp/lzNdimzfACL3A==
X-Received: by 2002:a05:600c:6555:b0:4a1:d45a:3ae9 with SMTP id 5b1f17b1804b1-4aa8b05fa4bmr7063735e9.15.1793212813465;
        Wed, 28 Oct 2026 11:40:13 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39a8sm30862921f8f.11.2026.10.28.11.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:40:12 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf] libbpf: Reject excessive program counts in generated loaders
Date: Wed, 28 Oct 2026 18:39:47 +0000
Message-ID: <20261028183947.9606-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

An object containing MAX_USED_PROGS+1 (33) programs successfully
produces a light skeleton that laters fails at load time with -EACCES
because saving the 33rd FD emits a store at r10 + 0:

	*(u32 *)(r10 +0) = r7
	invalid write to stack R10 off=0 size=4

This catches the unsupported count during generation instead of
producing a loader that the verifier rejects later.

Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 tools/lib/bpf/gen_loader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 251392aa8b41..80a6b5306183 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -122,6 +122,11 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	gen->log_level = log_level;
 	gen->nr_obj_maps = nr_maps;
 	gen->max_func_ptr_maps = max_func_ptr_maps;
+	if (nr_progs > MAX_USED_PROGS) {
+		pr_warn("Total programs exceeds %d\n", MAX_USED_PROGS);
+		gen->error = -E2BIG;
+		return;
+	}
 	if (nr_maps + max_func_ptr_maps > MAX_USED_MAPS) {
 		pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
 		gen->error = -E2BIG;
--
2.43.0

