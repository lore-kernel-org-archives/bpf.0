Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AE3B27D3
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 05:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785561202; cv=none; b=ivt1hR1PBFj8QOlWhfFlXkpi0UbJPo63cxmQVtPW7FlgfnzoMZ/WYZkdTl5gJSNOWGyqOVSmOFvbuWFRlgik1RVAVzbZM2lfwiBRf0fg1mfr6Htlr752xx88aqIl9mVu/5eSrk3GpmbhyNVrqja6d8p1hrhaVANomtOIZ0o+6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785561202; c=relaxed/simple;
	bh=axuNdE1mwbFWEpJB6Ct9uJBJt9kptYoIs2A9D8C/nKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YX/AcA19H5PlcUjfvG+Q2ElMHSxl+cyN4LO7G7UEPZKhBmeXQu6RvLDaRAH2dKEoKljVavJ7AGISlOaYgaMTbScBQwzJOWMmp6wQJq/TGhEO+cNZR9wt7uN4zLG1lmUzC7Fwtb8y94IdyCMORWXII6CUYjaCnm/S5NL6AVTf4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UhQhbsy+; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhQhbsy+"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb835525b13so1970281a12.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785561200; x=1786166000; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYqwZAvPaq1z+L+b1vgHCEIGBd9UB7fT/g85RdNXiY0=;
        b=UhQhbsy+GmJIyGe0fZBTuxo0fq79HcWzVNUemSHrJT2hL6m8a7ZwGmh0d5i7+PcC7j
         A88rgaCMr68/Ugdq3dJ4eMPdtYhL7egXg7hQau07J8RflMYXrPAtEazaJsxyDEED+rtj
         Ve32norAb13y6V/mt+x/mSpdn8MoVfwWUOGifh4FZKZ93Alo7U/8oebJ6TFEUgXrUc0x
         HE3W7yNFkFql/LmO5E1p1cQiSQ18lAaTa+TcI4YCFHqVoQc/ZADrJtXSmc13cILKAk48
         qHKBwZtpRbV1z1/ez5AeGOYoyjtiFtl0OR4uGZrlxdwSS9Afn6TOvIBQZc+ffeByX4SC
         i5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785561200; x=1786166000;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYqwZAvPaq1z+L+b1vgHCEIGBd9UB7fT/g85RdNXiY0=;
        b=NZx9yxWz3eWR5VlE0RTE4zhuttYKL8wWFkH0rcKEucAB3aRafZyg4tvB9Kl4FM6W0v
         X+HT6GmXvOKQeoXeBx6/UupRdqkPoHrb3jZHnf/CIzUVHmanq+Sad9E5BIoz2+gbyW7/
         k+Qt6reI9lAqvRvrgmbaQxoDjM506d+USZ7TFxiaRJ1jaq1wFaeOe3WOfEK0Z0QKr7/w
         gfL6PZC1/LEZ8Vdeod6+vzEqHWHrgyP/kGWse+d+yuvEYA94+7K9v65VzpbLjP4KiCaA
         8fDI+3KmDAyrNf4Opnk9ihNZbL9l8tOxk/KsRkbVHMlJeQupUo2Xunl60vjOBBmMTYuW
         S2dw==
X-Gm-Message-State: AOJu0Yy8TC0ssqcPaoWFYsZv37Qrd1Kzm/RQV8yhHwW6QLVOvIwzadPA
	lIj3x2k8ntVT1ojeMM9pt2g7WuUStgGAFDgOfcubiKBI6v0N3KoSW9alKC23nsOyYOFufdToviq
	tky5Q6kk3cmPDOuc/Bc42ucPBg7cQIg9IjdyMONjwbGqEOXQDOWoHN708c9K47RLHS2Zyf/BCKm
	FTOwtFyAmRqZky+Fdf7dlo8gAR3mc5JbCndhn2i7dIPQEJLq2xxwUI3LWN0/8=
X-Received: from pgnh22.prod.google.com ([2002:a63:3856:0:b0:c9a:53ea:434a])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e081:b0:3b4:75c0:3ec0 with SMTP id adf61e73a8af0-3c92a75521amr2048634637.30.1785561199861;
 Fri, 31 Jul 2026 22:13:19 -0700 (PDT)
Date: Sat,  1 Aug 2026 05:13:00 +0000
In-Reply-To: <20260801051307.478469-1-shivajikant@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260801051307.478469-1-shivajikant@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260801051307.478469-2-shivajikant@google.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add IP_TRANSPARENT and
 IPV6_TRANSPARENT to setget_sockopt
From: Shivaji Kant <shivajikant@google.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kuniyu@google.com, anubhavsinggh@google.com, 
	Shivaji Kant <shivajikant@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Hoyeon Lee <hoyeon.lee@suse.com>, Guillaume Maudoux <layus.on@gmail.com>, 
	Leon Hwang <leon.hwang@linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add test coverage for IP_TRANSPARENT and IPV6_TRANSPARENT socket options
in the setget_sockopt BPF selftest to verify bpf_setsockopt() and
bpf_getsockopt() helpers.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Tested-by: Anubhav Singh <anubhavsinggh@google.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 2 ++
 tools/testing/selftests/bpf/progs/setget_sockopt.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index c4b438854565..593b38f90417 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -31,10 +31,12 @@
 #define __SO_ACCEPTCON		(1 << 16)
 
 #define IP_TOS			1
+#define IP_TRANSPARENT		19
 
 #define SOL_IPV6		41
 #define IPV6_TCLASS		67
 #define IPV6_AUTOFLOWLABEL	70
+#define IPV6_TRANSPARENT	75
 
 #define TC_ACT_UNSPEC		(-1)
 #define TC_ACT_OK		0
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 636a7cd8e2fa..d96e99b67aeb 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -69,12 +69,14 @@ static const struct sockopt_test sol_tcp_tests[] = {
 
 static const struct sockopt_test sol_ip_tests[] = {
 	{ .opt = IP_TOS, .new = 0xe1, .expected = 0xe1, .tcp_expected = 0xe0, },
+	{ .opt = IP_TRANSPARENT, .flip = 1, },
 	{ .opt = 0, },
 };
 
 static const struct sockopt_test sol_ipv6_tests[] = {
 	{ .opt = IPV6_TCLASS, .new = 0xe1, .expected = 0xe1, .tcp_expected = 0xe0, },
 	{ .opt = IPV6_AUTOFLOWLABEL, .flip = 1, },
+	{ .opt = IPV6_TRANSPARENT, .flip = 1, },
 	{ .opt = 0, },
 };
 
-- 
2.55.0.508.g3f0d502094-goog

