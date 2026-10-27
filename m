Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118562;
	b=jQuerD6qzxLReLOjylOLvaUhnTPp/75JKQYDev5ahUqMyJypXDC+T1kLXKZf0jE3kY2g
	 +hKUNIZ6xFFLIv2QPXYWfBchS4njYbdnlgImGkkY0+EkZA7amk6rlfNUdFNI8wUm9F0d8
	 QVFMFgIB1/2JA9s6an0ka54lvi2ubrhAF7OVotRjkbk5i+8b5DHh3/iBgcuRcjft3yZyO
	 Kiv01EOHwhgO7pxsmh4Fx6AT7KhEnY4COTWJKHC7gvgp6u72yXtlgJs5WBwW7m/952Wmz
	 VkKZVKj7RaD5Myr+0+olTPLrhhDGkh4M1CKF6JWYR/lRQPn0p5/eHuPj8EgOhgJopEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=grncty3rtaTDIbrt6Kso7iKOLNCfGE1zwh1qvuhFSJU=;
	b=P9bhjDAmjngH9GrG8PQHt1HcGUvJZfeSiXelwNEfzFqw2Byjd7VHKvULWHRE+mI6QGSZ
	 uVl9vqkckvxHox3Q7Pt3+4YmP4Ic9QM98ibaHEWCsQ5efo0TBNk1GEvg/TVW/KQu4i2rd
	 Oz6EIOXy7nz8DUkkevitDWyfyazmtNMzaO4uMZ8VTol2BxSdMmUp3b2joIYlt8Wil33nH
	 oBBKQKP+r0nLdUKS03gbCjX0gGdt4IXxMPJDTdUrcK8mLO9CRJxH91HPw9BelBhvXmJD7
	 5+MOJOEe7pA6dL4ZAcsm89lJ4EUrMyb1Kh5/XrKAugm9KbXz8JuJp+R/rziqy/hj5+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=y2sd4u81;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD1606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABFD1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=y2sd4u81
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso70925a12.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118561; x=1793723361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grncty3rtaTDIbrt6Kso7iKOLNCfGE1zwh1qvuhFSJU=;
        b=y2sd4u811FArGHkSeCtq0m2DYYXuBQEDOQsRDmKUCeMlUPDPq+VT8dpjousm67z9jl
         J97lWmCfBwa5Gy+BdZt1hYvx4m1d5J2n9fheAuy4hd169eQ7jLsV/L/jclQTHOB/pBjK
         B3iZnhMRfalhAs/Zw1HLgQCpoLFzvINwlCfIOyxpZysbGz1Zje9KLJ8FAOmamFNecKUo
         yMaRNQGtS/gi6euB1vatRINQppu/RutP00tofxUlCUX5Y8xtcDtjLX57WYop0WkdesPk
         PHPYJpQgfSmi/O0WXFBLqdzygAttG+TXashtLCSH6qtwwI6kduIYYUS4VJFQxwhsDdY6
         8avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118561; x=1793723361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=grncty3rtaTDIbrt6Kso7iKOLNCfGE1zwh1qvuhFSJU=;
        b=qd0U3EjExtdXq1aZ3APVdUUKbw+au/9Cp9zAHsJMu9HwpApvPkSoIWCDlVraJ+4rkl
         9NM8gplvHErJvZRsGkp0IwnKneJyDc6PBgWFCWADcm046JoZGGwY2Kwk0K62tX3dxKqv
         WmaZ/VrXPdFK5HeJRQV+cJMhb3auITT7DI0RuC9r7m5/CrnQvL6UfTYVDGID3WKOGJbE
         RkaHOr1uvGYECuKEEGB4KPp8lDcLrM8sSuOnZjJB8xYA+czJ50ac9EoXH2Rd5jF4BbCF
         HCUGzBV4l6GyPqmBrorikE0SJ1pDCQipS23jDIXIE/hTwI6+9OjubrMH0+DHCz+4qviE
         LWqg==
X-Gm-Message-State: AFq9FYJeQG3d5F0Me/58IsTBH1t+kcTwBx9AGi9QFDRvRYVLftfgrhua
	YSRgp2O9JBkPFkEHnykYD4Qh+K1x7A0LKBGiX1TDWZzJE3m6VhDvOZV4wJgdFBzx9kVoSQsfl6J
	u2w91
X-Gm-Gg: AYBFou1+VJYBKNaE75yobrtVsW1RApnuaXrYyRCdstVe6eJ0xbaIPrULNR28qwlUKTn
	trcf2mCPkFw86NThAGtBSru/LCAoBOeA06RJ0pQcFicnY7IWI1zQQ+23r0m34wR1J8zt8BIsVg6
	n5dQ9wkNnOH/CR4vkfhaXkwzWoYm7R4mmLKAqFFLxYzSKBnlQ8jLjuwFGzXgYDcPuVVmCGoAbqz
	4obpgwpQbvCtprg72hsytkQ6RG+WvB1TZlQ1xCTZL6PuYToyc77yh643omHFoxEs/vvL6Vmw2mL
	xxxDkneQFYzMo5LebMBWNc1GQX5kAg/2mGUvAb0OkhKm6lVFUinDXNl7+qAojTjmD09xQm2jvNv
	6EFlScLnoOzr2PBtCEzuzW0/9h6YOTzm/Y6hJmGYXkMoRJgY0XE/W6VB16NNU0E97bNp9kDBxQf
	TeB7uC77A1EPtC+9+l0d0eDHNYh3LrxVDS0quyNsc+ZPuHZ409n3pAH7wum1L+a48AnKIg+coAv
	4o3F3P946ioInWp3KUH4Rt72u/8uzChM6+CRWhPjaXvsYld4YhkZlxmUjUa8kgzl9z2d2w4bUIv
	ziDggbSYYlluMSLPfA==
X-Received: by 2002:a17:90b:1a86:b0:3ac:b7b9:6484 with SMTP id 98e67ed59e1d1-3adeae8622dmr8174455a91.45.1793118560982;
        Tue, 27 Oct 2026 09:29:20 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm7288854a91.4.2026.10.27.09.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:29:20 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 1/4] libarena: remove in-code licenses
Date: Tue, 27 Oct 2026 16:29:13 +0000
Message-ID: <20261027162916.10996-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162916.10996-1-emil@etsalapatis.com>
References: <20261027162916.10996-1-emil@etsalapatis.com>
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

The libarena code currently specifies a license section in multiple
locations. These sections are a) inaccurate, since the license is
actually Dual BSD/GPL, not pure GPL, and b) superfluous, since the
files already have the license on them and libarena is distributed
as a source. Remove the license strings: The code that includes the
the libarena sources should be the one with the license section.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c   | 2 --
 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c  | 2 --
 tools/testing/selftests/bpf/libarena/src/common.bpf.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
index de656b69d13a..8a0f06110606 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -532,5 +532,3 @@ __weak __noasan int asan_init(struct asan_init_args *args)
 #pragma clang attribute pop
 
 #endif /* BPF_ARENA_ASAN */
-
-__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 2490ab1396de..552ce87875e3 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -899,5 +899,3 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 
 	return ret;
 }
-
-__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index d1af60b81838..d859bd538c52 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -85,5 +85,3 @@ __weak void arena_free(void __arena *ptr)
 {
 	buddy_free(&buddy, ptr);
 }
-
-char _license[] SEC("license") = "GPL";
-- 
2.52.0

