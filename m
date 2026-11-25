Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601816;
	b=ABJ3yOzeLzRMzUiJR6rfEYPRiTwAr3RLw7NsjlRGJ0mMU8YjjzN6os3zA31x9bAYsS/8
	 6RYzEPsd6j+qe+P0r36v9NxfkFt2A+6qu1DYV3Jvp43xu2FmHigEznDv7yhEPn8Fvl5eF
	 2Q7XCW9YdFOJk1214BPpA8/fMDA5WCE5F0dtKV5RDvuuHbuJgaIc2ukMtqC5m9PqYImc+
	 qSArEtZIWRlTZF1XzVKS/375guvm/TxP3af++Qc/SPTPJ7PrM4JsJiEVGfxX05QPKHyOt
	 vv2Gi3grVtZQW7eTcxuLKdgUUUSlh/cBQuWY72zYCAkobEPcd0oAqIcwIKpN+dMNe8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JhBNX3uOzO5PNgRDDTMCPnoI/htIxNKkhVjejqAXAjY=;
	b=ZXCHCIFnxK3xBYeUGLRrcoP6v40+dMYrkASCM3QFus9Y1WIwhaugOuoqumnXrcFHz9PF
	 LD6uA7olgXS/yBi1lrC/WAoO18e7TWacgqQL8FuQ/CcrWK1wLBYWuR9K6ZMUH+CpO/NS5
	 Z+D8AX/uy5o18nTq1CfFkz5HSq9qVYoXWxwrro+tJd+IXSwAm0br9IoZ5ZbqVvzdsOeMU
	 6VscRAZHrL5Oojjav6SH3xpqD9LcF5lqkhPQ65rkOY85MCIDDUPp3AWVHKxIEjQUvJLOS
	 FCuGA3tjmg8FuNDUmd9todDY3+gs+EuA4ps/AXV++a4UCJ2B4LIc5zg3PUAmdeVzzrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLwU7In+;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F489606A32C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F489606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLwU7In+
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so8364363a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601814; x=1796206614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhBNX3uOzO5PNgRDDTMCPnoI/htIxNKkhVjejqAXAjY=;
        b=YLwU7In+ybSlCqtMy+R5e5EXFmn+yePs3hO+rHXz3cmB3dMaar9EkOd2nNeXpCTDfe
         Ztb3tAUOLUjhmyMmOubqNUJ9S8Q0n70tJNKJ/Q95LS7dMe6HK57vMuHe0FWhvlfzfv1H
         +4CvpVh/5Fvi76qzBhG55Xxi9dEhasCDal7yunkEYoODNIEW75xhyGZ2COp+KGCGB6o7
         Qz0U16ivrrTmUqBrimGoWgOMQYdkePn0koRU2E1pZupAWDF0KsZvwtWy8fTt2GR7TJWh
         DO9mom1EKTB99LmNrimqHkEgE1uRlSuOjLsi5t+Ig0h+K8Nwb8h1nD2c8grRs6l4cQEk
         k1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601814; x=1796206614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhBNX3uOzO5PNgRDDTMCPnoI/htIxNKkhVjejqAXAjY=;
        b=Z37xEQWMn2POzHMWpZ0g3xykREIqY6ujc76TvICGew5sUidIlH9AeOejYs21Feu0x1
         aFcvijEWGktymSSES3AgE8H0QM87LX+kUlJckENb0zaALg04ywlhv24fIB60ulBEPdU/
         c5GXt0KPC3UkPsmmjgxyhIATI5wv/WWMI4beQUcia415vwgum+G7HUsbxppgpiFh/hEc
         +jlIyGeiLsPSBHlxH8+K70VVHl986sCbejmENQrv77sgCnLJ/yCM4Yl6QnUQRpWf+27j
         ys1tAwodvlZIVAWhb9xGaWRbbpCe+Y76dZWtBJ2a9xuo/nZ2L3YCYUMr4qq66+NAnJSB
         5GnQ==
X-Forwarded-Encrypted: i=1; AL+hErFHGdEWkf2YY26DPklL4RBTFggVYpld6/XBGhPYXmMb4QMrFODcpJy9mfV8Lnj7nl4F+Lo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+X7o52Qpfa7IlUCyiuhZtmjfC+941BD7XfWfhYggFofXjMIvCm
	SAsUNJM5yLQGVdSKbYYZuDYJ8BfwtAqt9Q8CWiqujvu2xzd+EDP2EYGX
X-Gm-Gg: AZFdTZfo6BI3NdY8aGtzj2ObqQADYI9Xy09C73BEWnAd3z2LP06JICVwnCrdcMTJiH/
	ixsX66gnnaf9Lzv3UgcujwABPOTpb/vcegz7bE5d3QKxPFzXVi+8Ts2zlhcuPdcT3H6geI4YFRJ
	t2Gv0xkdYBq2shLUAjuySm4EEPT+wg7OY1Tf6HpORVOazrHG6BfCfsxlcOdZhrHYRgm190c8FYw
	VtFJpRoOWM2K3vDI4Z8F88s32mjz6CemfZy0Wn2q+ug75v+vryz62nY81dTA8AxsDu8nbgfdVrS
	n1TU4g035uQWhmjrhk04xh18UZvKQktqBjMbnYZwCYieJC8e5ToyqEHOVvbmNa22aAn2YiKPjv8
	qDGTebbgj9oVXzFB0aimyIYRrSwy5DTJ4zmsSayr3g9jd4iNh1K3sxTASHWBC/cR4OI+pT3rlZx
	Tu8tV/y3K1obNdSv6azKt39oV06b92mcsaqLjztGJfsJMR5+ex6jEadmzOVpmpJfp2swy8LMOuZ
	bwc7/lngYHmQBujobhNydd+7QKWWKNUtwoTxl8+9cqHlb2TnTtgLTj7cJEhiKqclf3BODRvMMYq
	5cAkvE80vnDJXo5h3RSWWOMh8dkRpOGtpqA5FHDMomO8dpHzzyioi3xZAyDjm27oXeXH
X-Received: by 2002:a05:6402:5486:b0:6bb:33c1:ccee with SMTP id 4fb4d7f45d1cf-6bb33c1cfbemr567680a12.14.1795601813753;
        Wed, 25 Nov 2026 02:16:53 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm34765938f8f.29.2026.11.25.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:16:53 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 7/7] selftests/bpf: Test fmod_ret on functions that return a pointer
Date: Wed, 25 Nov 2026 10:28:04 +0000
Message-ID: <20261125102810.699464-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125102810.699464-1-a.s.protopopov@gmail.com>
References: <20261125102810.699464-1-a.s.protopopov@gmail.com>
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

bpf_testmod_retval_pointer() returns ERR_PTR(-EINVAL) or NULL. Expect
the tag "bpf_fmodret_retval:-22" for it and check that a program on
it may return ERR_PTR(-EINVAL).

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/fmodret_retval.c  |  2 +-
 tools/testing/selftests/bpf/progs/fmodret_retval.c     | 10 ++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod_retval.c      |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
index 281c6192e570..ef2a57f52dac 100644
--- a/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
+++ b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
@@ -24,7 +24,7 @@ static const struct {
 	{ "bpf_testmod_retval_no_effect",	"-28,-22,-16" },
 	{ "bpf_testmod_retval_err_ptr",		"-34,-14" },
 	{ "bpf_testmod_retval_no_branch",	"-14" },
-	{ "bpf_testmod_retval_pointer",		"" },
+	{ "bpf_testmod_retval_pointer",		"-22" },
 	{ "bpf_testmod_retval_argument",	"" },
 	{ "bpf_testmod_retval_notrace",		"" },
 	{ "bpf_testmod_retval_variadic",	"" },
diff --git a/tools/testing/selftests/bpf/progs/fmodret_retval.c b/tools/testing/selftests/bpf/progs/fmodret_retval.c
index 112f1575ce1f..699f3603dfa0 100644
--- a/tools/testing/selftests/bpf/progs/fmodret_retval.c
+++ b/tools/testing/selftests/bpf/progs/fmodret_retval.c
@@ -10,6 +10,7 @@
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
+#include "err.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -108,6 +109,15 @@ __naked void zero_extended(void)
 	::: __clobber_all);
 }
 
+/* NULL calls the function */
+SEC("fmod_ret/bpf_testmod_retval_pointer")
+__load_if_JITed()
+__success
+void *BPF_PROG(err_ptr, int value)
+{
+	return value ? ERR_PTR(-EINVAL) : NULL;
+}
+
 /* A privileged program may return a pointer, but not here */
 SEC("fmod_ret/bpf_testmod_retval_called")
 __failure __msg("R0 is not a known value (ctx)")
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
index 85722e48d34c..ec093098108b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
@@ -131,7 +131,7 @@ static __used noinline int bpf_testmod_retval_no_branch(unsigned long left)
 	return left ? -EFAULT : 0;
 }
 
-/* Not an integer, and an error which is not returned */
+/* ERR_PTR() is an error, NULL is not */
 static __used noinline void *bpf_testmod_retval_pointer(int value)
 {
 	return value ? ERR_PTR(-EINVAL) : NULL;
-- 
2.43.0

