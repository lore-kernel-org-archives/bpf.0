Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328192;
	b=lagm+YkeEk6L0atBGDOSSTfOgwu8ZrzDM3Ccg5+hjm+mRWkbXlK4FeYRVEgFLYkFvveS
	 /vsZfD1R1g9o5eFARfLriqu71T0YV3nzDM1xMF0VlMnLlIK7ShjrA+2YbYQt/G4d3eAT5
	 S37Wpfd4ofpucDK/zjHJG//gqmfq4TPSaPb+yXPZz25ffcNqRZTIgkx2eNOKxPMTkF89R
	 9SPZk8bpJo7jXXbimcf4dUPGK6/PDm+CiJQgTpElrJVjT6IPcHLMlj9VY6jSOx37bG+vd
	 JYHDKUFMp0s+pTNkJQjEBrBOsGJ5rGDa5SvMO6vERZCXPaAEx5gYN4hmv54BtLanFQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qV+5I3xoJxRujdrwMOK1g18t57cqNvStai8Z7cSzRSw=;
	b=jk0O57C3e3HOXZHYeexLj6+OKlr+GiLGh5OKLNUSrdw1svNieOMVYWLgMOjIMxra2rpF
	 zzsktV76Lq18RGfbPnt8Ah+QWXbaQIQXAc3R/9sEa/zoJa2MN1Q34Nx8qjmVo26ScEUWB
	 XHX5uQZCE/7rX/G4XQTGgvqvYZYhgr5SvtecGhj/8EwCF04paSF2X1ASzqNDGJ0mH09sU
	 /9zXKx2AIZNooK+eNEbHadfx15nfoXEXrJj7n+O+Hk0rLrtYXg8p97yX7dFDt2oZt/KrW
	 kBSHqSDC5K0jrk8b7cMlQc8V3mcLUtHQxjPVSuCFA4m9CN3bLJNfgDdcmLy9zTrkbMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dOhF3tW9;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6D60A6F75
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E6D60A6F75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dOhF3tW9
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a208d93758so23701705e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328190; x=1794932990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qV+5I3xoJxRujdrwMOK1g18t57cqNvStai8Z7cSzRSw=;
        b=dOhF3tW9XRoWZIe/fuWGapLwyhNMUf7h7bPQLUWj0hsH2E0zZDxkXn4jwGhsjH66je
         xoUNJxv5j2e9R7jEDbwRBJmVqJOaCpV4JJSrcA7p8u0X/s1UX2q0GSTQjQJCC7cuuJoP
         vjZjhRZxOd9Bve1nOiLHYjsS4D3FHncc6qGMVfWuzgJv+Bi9RxDkTHmmeSGFXRvBv4OI
         y5Yba4iHAbJ1NLwt7yDVRDKIUXCBjhgSjSFXrSSI/PBjr0EonNuBvxPQsNE8fo0PJTz/
         ibrTVHm1aQl22g/UI320d/RZt6EzJET/kfNz03c/popygqIJGinRwM6F+ED0Q0zs77X8
         QeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328190; x=1794932990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qV+5I3xoJxRujdrwMOK1g18t57cqNvStai8Z7cSzRSw=;
        b=uYz721+5a+mMwjoJLMFEqZFaurL5v5k6OwU3IxpS4FZHS8elog004UXT75DTSkEd71
         DSV1nyA3DoSq1xyK8sJu/7B1yIgZ7uuOvTjd5FnehyYo5HaQmjA5zZF3ni/W2sj8ihYV
         nXwUbgcJwc/k0xk6ud9sRc4ZOrTufgjVtzLVuGuOuVzRnXzTKXvtvLWUATlHkg1aTcOA
         GCODXWrsh4PITfufe67esF9YuZ8gc4tP5jJLYX1SCoHsXV87avXqc4khWF1ctg8OmDvX
         Zy1jLukLV7H9WcGvSq+2nRZRqKpuaAZwr0EX0FBNwjxq0lLppz+1hzoDK55054K2LRiN
         TWVw==
X-Forwarded-Encrypted: i=1; AL+hErEWIHq0WQfs6jHQyragJLIc9sS9CKdsBaEJ0THtQVJlTRPmMp+OwQM1SIS7vSJDiL5xzjA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HLOCFVWeTWAHR1IJUwcTV9bm+G5jsOham2A9h4GuMPDHViYZx
	EbRpZwz+ac2/2h19nRH38eiwd+5QmpVJnJUIisg9rxK3wsJasJcXDtxk
X-Gm-Gg: AYBFou2zEbv1rL63GpCqW1U0oFlI8gO52Lj1N9qxjEh3uBbubkg5ULLwJfhsLxY+cs5
	ULuqtBICqNqt/nx599p0Nw0lbaFQwv6b98VaU/NBPQP/7Np14Kx9bLGkgmuI7SUzXFtdJcpSfoa
	lZc8fhl4Yw3pE6j5O2DQiYBkiRzeyml61zKrRbMqZuA8lRrGVIuRq2SqXYzN03fbENJi1d+o6a2
	kZRsDKJi5lGArcD80wyB154qMb3AU1Mp/7aZNoFuLzpLZ8e2cscB7cfydMiqFK6KlEig22A2w1I
	g4JTPcGLGxGmR3RJdCXd5C9kvKEMXZ8tFYN1zlBR/GM3Nwhcs9h2EtI3qW54Fte2hHA2l2MmDF8
	4Na7igDTU6iLHx+bbCnyR7uwQZkQMsT8VClI3TNX8yTJI3XYD8JtLAsvwzNVutXTRp2W5FCRe0T
	smQpA+vB0lgnuJr6IfWZlNMxA7yxEcHJiGZhtR9UoRJmQS4oDh5pJ96hM683U+janyzP0WTFrbR
	4pGsvOnEd2EKNOSbRKbkpL9kKLR3frKoW8Z/Hct8FLF7PkTyJ28OjZD9nBpaDALJlimuWNo9edG
	uzvMsPALASMqma9lbCfMe1fMPSAujufJaQGChCZOOqkoQSpIvUpujn6cFJWTAMiWBs3v
X-Received: by 2002:a05:600c:468f:b0:4a3:12fb:1ee7 with SMTP id 5b1f17b1804b1-4ba0234cd58mr56150515e9.25.1794328189995;
        Tue, 10 Nov 2026 08:29:49 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:49 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 17/18] selftests/bpf: Enable bpf_scan_ir in the config
Date: Tue, 10 Nov 2026 16:40:37 +0000
Message-ID: <20261110164046.454431-18-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110164046.454431-1-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
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

