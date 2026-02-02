Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A67296BBC
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068901; cv=none; b=gBLf7HqaVSR8f7wpsbWYirZgPNFu4R76Qtxe3GLtm1+JyaRZXsTGoEVaPM+55mtcOtcilHjJVyLTvhxzsXEsm4yLufjCL0HHRo4sPBOAsiiJuN1cnzTEeJiTQ5Xv3hmiO6SRtEePXNgwCxZZwCX8xo3TUPB2mkrhI1e7UDA3FSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068901; c=relaxed/simple;
	bh=+AlW4KUibtTEL7aTM7Y9a8q6iUSg1IHY5nxcd67yjd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDzUdLJ3VazRE0rDl3jQbOWUaLNGBZaVPYlr047iLcHo9xrPZOYsdAovIXShowABteavMirVtAdKhZu/9+6Af8p6FAH1ManrBPkRfOL83byYoS1j3LIVf+MOXvzdEUiIMlOFPg8DF3bauOnD8pTVdy4MHMrEFd+vtUsG59/XcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfnkupnR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfnkupnR"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso106791a91.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068899; x=1770673699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG68PqzRGVsT32Sf0QIjL6C9Zittl7Tzt3slozf/1sw=;
        b=CfnkupnRtnTZ4O+RhR4f0P33BV7x1WXRU9Uc9/daSSIRaH30M5SMoWQ3MGeDvMrZ/U
         hCws1KAfLOBT2LzN366qXcDE26n+iJhFTtkuN0nkUIRhq4/a8V8ViZz54J7+u7ACLaQ0
         VMT5emnFmsAkF3d9pQrSxwj5YRF66uJvhHlwPnMVBzXDhA/5L6ollB0xW/hG52KEsjSW
         9fnEWje8AOW5UsUWaXknKv6Cbai++daR9qmGVVGe/LVnxOv5mUROMPHqyk0UrYdOHDKT
         NrBNTZA3GAc5z/zLrDlUTaUPWDBXsrgZdjDX6uTr4EGRBfUGHn74AYJBPQ4/zhvdbiXl
         gECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068899; x=1770673699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nG68PqzRGVsT32Sf0QIjL6C9Zittl7Tzt3slozf/1sw=;
        b=mqRRZ57dMAn1XwkQSiRsyMZ00LsaZbqQrtIQPQv7J0ymOF/HP9IvpRg9ytR4Z/Vssp
         GnDbNWIDq7v2h8fBakNOOvKIPyeFI5Ods1sdbHjQlYVpRDzHyMvEzvj9YrANc37F7AFV
         W7v/YW8SJhp3JdMQbDOniZGuACNE5ai6azm3r5VCshKtJQ/NzRfB9TL+/XXOF3xpC2IY
         1+zg2QVEj/mcnjAnvlqfmk+/yoNX5tLvQ6V4Tz18jdYjacIxmWwHosVuwZmA/f3pgf+v
         Bvj4hApo/ZgyCxX3nQA+3lYX7ztVjulaLQ7yLni/ldRHlluck1p/LTEx8MDRv/LAtYAz
         /K9Q==
X-Gm-Message-State: AOJu0Yx22Z+k+ub0aYghkK/swLAczOaQyd+Xe684a5gDZhVHpSBX/kbe
	Lzkg64m4knIZkvEWu7MrIrYWqeFqtxmTpz/vt/wLz2q57Yxow5ljMi9vWZTokA==
X-Gm-Gg: AZuq6aIfg46XSvg/aV9k2uGa9Xe+VU2NPplLKorD/azdtKdov+XqupDYdwufyMlwc9Y
	NBkV8yo610BmVIiZNmiNBISLl1wDv53GdUrGXxD2V/pATmpw7WjgSgiC/TbLqZ/zrMieGN2AUvY
	X7van47TN7xiwHNbTk0P8289ke2eyuZZgHIL5hMywX41mJ81P/l8uDX1DIQ+evV68JlsUCRqIpv
	1GwMdE1UV/Jg4UFkk/bhJx/GzzM8HjZD3ZrOOvHIrC5/HE3Sd/3hv7b/afRci8DSwqP7boDk4rh
	6ABf56enWVyFcPXS09gB8PPq9Z/rLzomNNgxqMEplmj2k1xGOXCEoxDBDCU0XbLiAfDvNw26FQo
	3K57VBZiwOUGEGYsnuAgEcvg6ZbgpVejfvONvVLXhHSHJCkr6M1njABhNN6KIb9XpiyzLwvrbGu
	Pe
X-Received: by 2002:a17:90b:3c8c:b0:34f:6312:f225 with SMTP id 98e67ed59e1d1-35477838424mr595504a91.14.1770068899271;
        Mon, 02 Feb 2026 13:48:19 -0800 (PST)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d72cccbsm4716889a91.13.2026.02.02.13.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:48:18 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 2/4] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Mon,  2 Feb 2026 13:48:15 -0800
Message-ID: <20260202214817.2853236-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202214817.2853236-1-ameryhung@gmail.com>
References: <20260202214817.2853236-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier currently does not allow creating dynptr from dynptr data
or slice. Add a selftest to test this explicitly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 8f2ae9640886..b44372cac40b 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -705,6 +705,48 @@ int dynptr_from_mem_invalid_api(void *ctx)
 	return 0;
 }
 
+/* Cannot create dynptr from dynptr data */
+SEC("?raw_tp")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_data(void *ctx)
+{
+	struct bpf_dynptr ptr, ptr2;
+	__u8 *data;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	data = bpf_dynptr_data(&ptr, 0, sizeof(__u32));
+	if (!data)
+		return 0;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(data, sizeof(__u32), 0, &ptr2);
+
+	return 0;
+}
+
+/* Cannot create dynptr from dynptr slice */
+SEC("?tc")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_slice(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr, ptr2;
+	struct ethhdr *hdr;
+	char buffer[sizeof(*hdr)] = {};
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice_rdwr(&ptr, 0, buffer, sizeof(buffer));
+	if (!hdr)
+		return SK_DROP;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(hdr, sizeof(*hdr), 0, &ptr2);
+
+	return SK_PASS;
+}
+
 SEC("?tc")
 __failure __msg("cannot overwrite referenced dynptr") __log_level(2)
 int dynptr_pruning_overwrite(struct __sk_buff *ctx)
-- 
2.47.3

