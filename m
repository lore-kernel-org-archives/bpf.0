Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243287;
	b=e0U65Lgy96qu8DPEWhVTNkomt624Xn3UhL6W46TyRqKdjXMkRHZZyffBdmfJMUKGXMoD
	 ieaXvZJHdh8XlUw2s7wqGCOPqnnkNzq6SGFAZmuc/Cchw1bvIed/cen72+t8mrUybfcW2
	 SRksbP5gg+bn7WdGFBG962WhLrCzvLSD40jMbQcW93oAP4y4sBgPPaANIzW/EEvHrTqwy
	 5AiWdHyS6Mj1J4zuhE2x2DsIHAQ/MMOa9YyFTdmGGLjuxxK7GyRiqcLyBCSunGwaHtNh7
	 wwUv5j4LlrK0VlKbr6nxMWHGprVknTgN5ipjEJ9KWWYbTApqaTTqk1DPDpL1oAjRSIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KaefMEvrOf3+jRRd3Xy+fUqgL7q625BAckIaBev8onI=;
	b=R1+BwJJsLZIi2H6aFET6AR5PxXQc87XrUu1gZccElRRRsbkdeizxITciGIfx/H2Wmrip
	 dnEyKqupFult+JIRLKpr0y6sqBuIqFaZ+hxqNWDXJKsLt8lrfMax3KQc1qQDR6JCetW/v
	 X7bNxFk4IsTFKzhpRx7MMN21dLPC/hWutCHsAb4BOiIHsQjS0R6xaKtO6SMkdJM1X9J0e
	 PXEXWbE/e0WwSqwnYf9Oo+CEPHXZyXZIzEBC4VsUXl7YvWWrAZUDabQdXKQOko61I51oQ
	 +fHpC3l9OzL6+5D+WBCME6t4Y+SKMn7yfRlPokDW55bGf1zLuosM/mJvVe/EjgZeQ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yOQ4uacf;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468D60A3829
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7468D60A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yOQ4uacf
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49318428d98so606854f8f.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243285; x=1794848085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaefMEvrOf3+jRRd3Xy+fUqgL7q625BAckIaBev8onI=;
        b=yOQ4uacf6U+zNsE7OVTUSnfG9gzLnIxkDbDQBZpK3uSYAsgKJHWffzTSJLOU2RXkMC
         LoP8Qzgy0N5bcXuYBlDXA4OWld5Z464RaKALkuOoQIiJfD812S6+M64aTo7q3SN6MBOY
         u2niOo+ex9gH+mwg/Suy6M1mR4keaWC5FxqWkCrqwX59yvoEqDpW9wmC3PCcZe3/yYh+
         3Ow74JpGg65mI9/01J1wyj401SpbF2fZ8p4EQGYqlgi4xZC6RcXTlTia8sjjS0ZCUpuF
         hXqmWElZ/eMNfsXRSzM3/C7+idcPceIzVyOq2oUFM/6lIeOhrBLjyngC1j00nkfentuu
         TB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243285; x=1794848085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaefMEvrOf3+jRRd3Xy+fUqgL7q625BAckIaBev8onI=;
        b=bYe3sKUYO/4lDdbCpOK8Zz0mSWgNLkKA9PbyApWcBW4FYneS5+0P51n7j9ynFjO7d6
         z6Hn54ac9RrSEXUFXZipe+d9at+9efc0R989U/QTYekV/MsV8ny1D0cbraFn1GW5yHwy
         XCSHF1bXAm+gDp2GiJ4e2BV6wk4yPES/aOLla9niTr02Ye28BbqlfNQA2c68Y3bB8dID
         tV0x2fa6Vs0yed+P483kInQm0RDv5eqy7iViIb/0ascnBRI6OFaypUCFsf4oacheIpuv
         Pvi80kfZE6PWP+jbzRULQOlIt+NVSTeRZSfzc2xYn4OVwDOAlw3SdX51xAK1iEGSR/ef
         ucYg==
X-Forwarded-Encrypted: i=1; AL+hErFyVnmJfX30RIl/vgb0Zm6Q5jlJmSoAJ3wgSU1Thj76g31ACKWFI3HDmzHk9hgKrI6rFkg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+yEWQpxKHo/BhM0nhl5u4DXlLw0HuB2BMSUnhAo47AucOCEZx
	FhefZgrMARdI9MDFnw+J53wrA6gDoLHVs05wPoLJ0CdjiACnL4sr4WXi
X-Gm-Gg: AYBFou2Fu6fBlnYXUsR40QeylWenR6ZuSKvK54BKqxD23mf6ghiyQiyw1evOZ9bQWpC
	RRTugo9KMjmncICaWDEHbcLhPOr4ZJHIWJKAk9+pBYesFB+vGyTTDcCQ0GSGbnoSqa2SRTl6+er
	hG2D0T+59tGbPhL9VvczQlOzbyZDGWQK9VHMLGvbs4OQyULQiMEt8kc8o9g3bA2qk63WFwvRDtK
	KlohDTizJ2tgztKuW3v4Jyo/RqXbAhJhqguGRstk6k2tHlZSkMCiB8vZ0TowmvKnst+ky3WGCOJ
	7GgLFI0v+WlKrjelglNeqlnc5QUusWPpEevn2Wxo/HSyqvi90rsv+BeWNz++0n7ci9aOHEGc5ec
	W4jGpm1VTS5V+cbxDzpFSQ852ngrFG23PAZTlh/j7mtoPDjh/C6hmO7Fy1NkzWABUlTHmHO70Gq
	NxIXFCitQyFP2g8sSTzshdn1GPYda3Vb94I8pQEZaqbzRzEXI8ZJ7cYLVTcpcn7yevazzIypY3R
	ikBHS6t1ZaECBmtWFS6xwpRh4mAWsBvkkIZjRxBmD949oKxZX7SFVIbYjDKF5qy75hs3edxEOS0
	CeiSO7kCz0a3Rau53XNKwfg6ikUdwowSIIPF+fvm8pZQ49sP
X-Received: by 2002:a05:6000:29c9:b0:490:7fb3:cb41 with SMTP id ffacd0b85a97d-4982eedfb41mr41741f8f.24.1794243284690;
        Mon, 09 Nov 2026 08:54:44 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:42 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 04/18] selftests/bpf: Declare bpf_fentry_test1 in tracing tests
Date: Mon,  9 Nov 2026 17:05:24 +0000
Message-ID: <20261109170550.141443-5-a.s.protopopov@gmail.com>
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

bpftool puts bpf_fentry_test1 into vmlinux.h only because the function
is in a kfunc set, which exists to let fmod_ret programs attach to it.
A later patch moves it to an fmod_ret set, which does not make a
function a kfunc, and the declaration disappears.

The tests only compare its address. Declare it explicitly, as
get_func_ip_test.c does. The declaration matches the one in vmlinux.h,
so it builds both before and after.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/progs/fsession_test.c             | 2 ++
 tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c | 2 ++
 tools/testing/selftests/bpf/progs/tracing_multi_check.c       | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 86e8a2fe467e..4295f6a78dd1 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -4,6 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+extern int bpf_fentry_test1(int a) __ksym;
+
 char _license[] SEC("license") = "GPL";
 
 __u64 test1_entry_result = 0;
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
index bbeea0d512e3..51a7f605f9c5 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
@@ -3,6 +3,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+extern int bpf_fentry_test1(int a) __ksym;
+
 char _license[] SEC("license") = "GPL";
 
 __u64 test1_entry_result = 0;
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
index b2959ba71179..9b008ecd6565 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_check.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -8,7 +8,7 @@ char _license[] SEC("license") = "GPL";
 int pid = 0;
 bool test_cookies = false;
 
-/* bpf_fentry_test1 is exported as kfunc via vmlinux.h */
+extern int bpf_fentry_test1(int a) __ksym;
 extern const void bpf_fentry_test2 __ksym;
 extern const void bpf_fentry_test3 __ksym;
 extern const void bpf_fentry_test4 __ksym;
-- 
2.43.0

