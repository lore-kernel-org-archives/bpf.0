Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998326;
	b=EQ4LhTZGzxbcnQSUNVV6cMq8fIKXhULdcDIDJG93icXcgrcdIboKH1HXCeCynhjTTDgc
	 VZ09MJZ4eLoXZiRbasrE/W2+hCXsUvXwtGE3OA8TvPWYlADELIPmrWic423ZiPSzJeVA2
	 jm0Za0wUNA9BVRZHSRipTmJOQIYnaYnvmYSLQPNdbhHZF+Sy+vqssJwaVMGunVO8jR6wF
	 Xs03gkJrIiEJtioVRV7brvI8C3kzzRuSpkPTYZwPAlFFq/sH0QTUpggMpIBoo944oV7TY
	 cdvVCcmwXNqvWJVvigEJDlpkHP4zHZ7DW686mMHwPk2U0bOgXoC/zwSoIVucK+pUflA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KaefMEvrOf3+jRRd3Xy+fUqgL7q625BAckIaBev8onI=;
	b=UBu72QHhnkSjIMGh7n7ly19lTjQKarxzzJi4n0L8xs/ExSdpyYPB8LPh5yxXHrNK1+i4
	 z/rWRkaxauu5tjgKbvm21qxhwQf1ESEqkArXz0u/eSCPTVaJH42JY8k0hoUz1BBo72Hz0
	 pXdC08ao1ouSl7O4k91T0e435NbNkJiaQEIGpVzMnxZr84OS0BQ6Nl3J3zNldaEJ/gS4W
	 162MD/3AWmP01Nwyj0m/XNcGp6JRqhE8MN9hZCDY3KOWHATHjHQPVPDXYjMW8XyUIRQ4i
	 wk9yNKtAFYwOgM+LHdWTw4vbS3xne4AizIzNlhesb4R02h4qYpgZv21itP3uwrFuNug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tGu9teUN;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE969606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE969606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tGu9teUN
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so211095e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998324; x=1794603124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaefMEvrOf3+jRRd3Xy+fUqgL7q625BAckIaBev8onI=;
        b=tGu9teUNJ1zxIAGoTnqctdfzxw6DyuT06z5Y2L93HHwOhxX7C55Cwz78HdIsnFJQ05
         cJjMmdFA1gXpFwWhrOJRgDWDm6v1eOZPvaQIVwSFITwdhICAGIR/wbxVesnO3fGVMC+Y
         hD8AFftaDqVdyb6bOuJfotSi0FLS+FRdxt1N5EjijC5kQQfp3GMlNWf4SlkpJs89WTRh
         +ipjLNZmY2/69YbEbk4rjo+WahVBvmCo18NzEckgRKemCU3o2vIyS2lcFiIF5HeiUsvZ
         eQ+ItrXl84I1tafbF875utkB8RQXwgL4kDkAQBiZYeovXSKHtaRtVQjWT5fHJL7MeEm+
         /vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998324; x=1794603124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaefMEvrOf3+jRRd3Xy+fUqgL7q625BAckIaBev8onI=;
        b=daXirnR6lO8kxE86E0//pjCzOlJh46rkG7zkvw8p7nmkU489yWdKCTEyM2WmZ3bRJy
         oz87Wb+X+RgIh+McFVbCZGORsptfS8uSDxEUuGtJUwFtRNpF15zEEvfBLfb6xQzAszyB
         3K/rtoHkRiiAoFOz6Cop3isuzJ5IvdtnuASZXrSf1mjzANbEOAETQRIZzocjyA8pEFjr
         vyUMkt3mGP8TId/ueHfn/u1vlMpnQBdDYGiidRkJ7rpC0L5sBvjohznaQM724lIp2giu
         k68t5tjoI1tbGgkB6atocp636gNXWre7o6s7dvg6DukoGUcrmpUtcZK19sJpD/OWrSff
         CQog==
X-Forwarded-Encrypted: i=1; AKwUvBwMtZwJ9W0jf7kjrNh952n1NjVgzMrjgYxvODAE3rnw7QxQuAiWHgQc8SUmpxw0lbkMWlo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JRm+eQcpAfjji+BpTLwWurrUkLlhwh1YYw3jGpeuRKg60WHoe
	fmDv9xFpk/aZFrLCWUHpLuyfRmBCOJtG73oTWyJkdZIvcYf+z0L+KTEY
X-Gm-Gg: AYBFou0YxsJYaoSsA7T1E3z/T1ycJ0ebDvJHDQeGR7b8M8rsQfQ/Uq29MTlHSz3mIF4
	Gx29bM0N4l7LO8W7qj5bo5C35wE5XRsBYKe5DQwwWzVJxfyWvAMzBdBW7TeWNAsT1/+TXweCDlr
	4+okWxCR6pAP27IgeQN7eU1Lu5ciU72XIF8XgUbn5oHRKnVAvlv7V85GB5dbUN/AmhMK3ItrTVG
	tQebDnsZw8C50y9AMCA3hb5Nz8oJZxLMz4nOO95Gt9t2EO5FHqaVvs0Q1Wndgnx8bsw+J1Ep45x
	RXJx1QTJenk7pEJNVpmez03Vgbk9LXU/WJWqWUSg9vFhPvFXc8Zjtch+/AGV1Q1RkGqOOfHfo5e
	ZYy6WZQgYNPjwWqz3O7r/cEBd1k/tMuFj7cZToYz5KFHCe0jCsMTDzpOy/PGrwEnFJzgRgmsLHP
	2vZv/boCAiqxrdejfE3riOAUiGccWv96MV5mHmlMANX7jSqbod3s9elFFDNzJqtw6CuAFzv5O/q
	VvcafZJyTTLchErtEZL6SX2mFywqN2szT5Ao8BRFRI/2TSQ67Cw4XGw5zBPuCm9PpcBITMO+8/k
	LEj0uGyHsOOSMFMX+SdnajYAuPTyAYqeWsn4AcaQuT0YZnc=
X-Received: by 2002:a05:600c:871a:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4b8190eca6bmr2665875e9.2.1793998324172;
        Fri, 06 Nov 2026 12:52:04 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:03 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 04/18] selftests/bpf: Declare bpf_fentry_test1 in tracing tests
Date: Fri,  6 Nov 2026 21:02:53 +0000
Message-ID: <20261106210314.1767267-4-a.s.protopopov@gmail.com>
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

