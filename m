Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243316;
	b=U8qAphBjaJ1yi/q6dBk1nW47sGxwyTS0V6E2OUa1UyoPQGshwXPRK34AKNcwHLPzPWn3
	 o9FtoRN0jeYCRoNsD4Ht71PBxgDJo7x2KlD0Sfs5QIHsfbgjsGVErCNyHklYSE7bF+F72
	 HtiiI2Zw1HjImuLyL4CPfRmGmE5onu8RKiNPfniA8VF6W/oymZ6bsSnv67tY3xlMUV7E/
	 j1O3F+Z7ShbxEQDN+hiP37Uc/DZDSBUXSgtcoO0pIp2ht7VhC/l0HgU3RWdiqep9clTAT
	 /5pFVhABLA5LwhCG0oa4irC+2SnHg07yeRis7vm1y43r6ZASXo09OKHqAW+OsNJ6qnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qV+5I3xoJxRujdrwMOK1g18t57cqNvStai8Z7cSzRSw=;
	b=jRaW5wSrhPg7ejBXwWQgsBw23F73vvFDihy0VSFxjNDgsDnb7v9K71sbBg4VBi3VFM1N
	 cWptmrZG7uUY8o43L3tjXa3TlD8TIKLilexRTyJmutWFdXcip/LENDKqzxz3fKXoKDY5V
	 MZtJbhz0WJRKDxYiW2gqYB/LU1suhdetrIIrmkmSgg8yv4fJ3H70J3Zm8gbWfwhVvs9F8
	 Zv1JaoXJwpF1FtnQvZ7sLzu/yJ61li83Wo74H6RSYbi+mvYlV27VACecc/Y4ECDpK9HZP
	 FhraXnV90jc7pYP3r8lOe5gQNQFPyMZGbKy/aOF0LIGfi3+JQbxcPllqAdXX61Tu1DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qx9dUkOk;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAA60A2621
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64AAA60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qx9dUkOk
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so7414895e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243314; x=1794848114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qV+5I3xoJxRujdrwMOK1g18t57cqNvStai8Z7cSzRSw=;
        b=Qx9dUkOkbOVv3AdspaNK7rZkfivrRMnyfo0dX91ZnhdMc7yhFU5Z91Zf1w2FP2mBxo
         HpIPc2x6aDyz8iy1BPcuNuHNZJyC3JYbpDvkhI8xVX1NPNJnjpqeEtTNBq0obCPPdO4s
         Ecg9emsfzIzHYpJl7CGav469zxWR4BX/+1a12cQKKikGx7hObf39JVFMua96en+Mk1aU
         kiix3JJKsGGFQe8tjztUMdt+82w0M+nprj2g7cinQh/04QwWpCzJ0b2dNDhHAOkzDnO0
         DcO0HomHn7gCMEPvjlqq1OKJ3gvfqekHHY5rd3Y+jBf9Ab3qS0hx9eWJn59DIqFcW29r
         QFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243314; x=1794848114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qV+5I3xoJxRujdrwMOK1g18t57cqNvStai8Z7cSzRSw=;
        b=cutZbI3qHchiG/8gH/mD0+nc7Cg4h7mVWxGmdJQ2zNnNByd6tCl+3xUUQ0UwiSKKnB
         wX9oVe+d/xSyA/UPHZLRH/NCmbrwjnBsKGnq9qB0ZH2hWtrUp5LCBHB5M0xQChED1tei
         b+XavE9v9jjNqna1KCjRsHMerdjoenosq9R1M/1PGgAD0ercZh8+CRqcvSea/pgcli89
         +R6jS9q/iE0p+c4+PsYyBaPTWFkfPWTJssvf++rEPaiKqdAMcxTNwjHnJpEJs6pks6rz
         Dk+ljDLHFe2QGSGmEIXP4vfKU1O3ceevynO7LDNz0txbm5+Entkh+QnbjO0QEMPjxmpo
         Jg3g==
X-Forwarded-Encrypted: i=1; AL+hErH3HsakcCMZTIPxhMhbxSAWCohNc4kkRiOAB9IbnLpRuS5ZKqTIUGyn3cMIDXhgoeHHpcQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FF3HI6lqPKigF6N9Qv69TCSFZ724nIiH1XS1lL8vqBKQfYHMj
	vdJC319BtyvILu/YMJR4WCDAaxcHEAPH3vgokV6V6FlJ9NPxrmjXlIa+
X-Gm-Gg: AYBFou0r8n5qHNXF2ADC4O5+FAeMzcnlyj71JjSKbIBbf+3t2YmlX+Wm7aACWUUVkUr
	47RoRBkwHJl7zc8BdxOygWHPmFcdOaurrh/YVogEjcYgxJyKqfQ+HWp5j/vKqoNV/jR5RrVCEv7
	IBh6nDuzoISnUFJnOmoS2xKx+LL+iRGQokWTPug+Ae0Q8OOS53lPddrxpYrImIUj0sQDGyuJfiK
	DJUqg5m2U7GWNnGIa2/HC4Tkj2PfaRVMmiK5QAd16QW7uMQijcs3k94D+wmThXvjfBtREC8d013
	1KSYOvyFIyu4fZkmLHaeEGBLp3lYrNUOiF6BsPJWiLqGAEVcc/+fJh6GMDNvhg8TX6MIZhMYjs+
	KjoWMsvG/9iY/eewBg70INrkkKODxi1MxeA9VzI3hvU++KQbz3u8LdN7iI/wya2a0ISLKB3KKj+
	aPkerb08bf0KQqHnw/Ply3y5ys6EHTIQ8qQkkLQP72aEtSOo036FvvamApO3tiHdB1H1cBOWfMA
	tJs6XPDrg483cI1+j1koMReL3pEizzEnbamjsH/YWKUF3AIxaS00EJF5xucDLnRVY8RBDAzHD8n
	Tx5uSHTrvPheekT5c2fXoliMywS4CAOitVhiC2zTNfb1hME=
X-Received: by 2002:a05:600c:1d05:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4b963c8c780mr80148275e9.18.1794243313724;
        Mon, 09 Nov 2026 08:55:13 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:55:13 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 17/18] selftests/bpf: Enable bpf_scan_ir in the config
Date: Mon,  9 Nov 2026 17:05:37 +0000
Message-ID: <20261109170550.141443-18-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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

The bpf_scan_ir plugin is off by default. Without it bpf_test_retval has
no fixtures for the plugin and fmodret_retval skips. Enable the plugin in
the selftests config, so the CI jobs which build the kernel with clang
build and test it. Kconfig enables the plugin only on x86 and arm64 with
clang 19 or newer and a matching llvm-config, so elsewhere
bpf_test_retval is built without the fixtures and fmodret_retval skips.

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

