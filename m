Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993B31691C
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783527; cv=none; b=Oi0PMigrSnxTG77Pll+U01cU+tHfc31f9EO5eJ0gwbDy1V7VPLQ6LUCyhfrMu+Hd6zyA6/Iv4Ro0yBOI2iBbdH1UUbSQQ3OBGOfG3PP9cxQyOhEEgvQipIh2eG+5dalR/28OcHE+pDXRi0QXv4yFoScZ1U8Nv7ynezZklGdIRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783527; c=relaxed/simple;
	bh=6fkvZ1NFE4H64WA2vDPjJAWZschxUSC2Df+MOA8TzVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecoScwETR28OkqX2XGGMABy3L6uBi4qd+A+Rx5BLLUXYcHMMqG66EmJuj7niqnrn0IOqdnSTEES4Y+aJrkbo5lxR1BSV9yNstQ27SaFRHJQ76SzqER8SeBWFeDiSX/UB07Wa00oYWRLz/Au8axY2M/eaU+0yJi4fN4MUNzaGbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOJMlIIp; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOJMlIIp"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so862472eec.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783525; x=1776388325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgRdlb5kd8tbRib+nPOPFDYEtcnvdpIQv8Ho1uBWLLg=;
        b=VOJMlIIpNQ1rlLuEwR2+iaDJ3aubXrMGjW+Khk3yEXcHrkqrBCyvJN8uI2cWEKuPoq
         VncsotxZQnBnRzlP/XCmnaKQ24Z1EvPvG5KPb7Fhmnv/F19mBwdpLGI9fTaFLcQ/E8Av
         9TcsQqW47XMwDPxUOPUpVGiAbwMlJpLBgwaPAwXw4Uuc3Qb13AWLgbvr6bS6NTgBNeGh
         gRutb590RT5tmJuPXKx76vzA3V4A70oTmoWf9ETOt/y3V92KG01N1mOvDnXjjp2pa7od
         tXqHKFaa4VIGJP9uOu3WPa9mx3JhyGKiyrYYu24CciDxuhhukILwwI18MAB/IzT7u/wE
         rCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783525; x=1776388325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DgRdlb5kd8tbRib+nPOPFDYEtcnvdpIQv8Ho1uBWLLg=;
        b=nOwFPHju4gcZUn+NQ61dw9jLTxjmgUvcTCDNSc4XLaOwgNeJDuiW3Yr1y1CSlsAd/2
         xZ+MR/GF+/zEipNH5JRoe2w70PAAcKxk2BaGMTMHuAheT4ZSA8ieRnv1xv17pFu1OWpD
         yzCr+GYessF9qwCoFA9Pd+A8PJMe3X+HbKNL0tzTr0B/7gZQjmPj1hemubUQawHdEe0X
         viI9Yk7yRY6ODrfkTzctqTqjXXIoeKmPbFbILCD8wLgEZvjWVyjwZUny27jGji7FQG2K
         4Y84hE9QDH8a8ZD8Vj0Fy1zeN5zdj9cIQeU6nH88I6HuLOivJg38n5Za5iQbJjB4i2tY
         Dczg==
X-Gm-Message-State: AOJu0Yz+hdOGDRGDQ2TUSdlfqLaXHDUBwbtfuUc+fwxLKLW/fM4dF0iP
	kb1BDjA4czMOauMU3+fRBitN/hAkOuSl6BpvXtyTuq65F0+CRPb9s8zmSjTnTrIv
X-Gm-Gg: AeBDiesCFGDzHAC6CYQFBovxs2VVIa5a07dcuEBg4cCL1UIm3JY5YRZG9iIWeqMALDP
	lYGrYFRZ1LWwWgha9YfpaCG8IsaN587ogJ0Uec1ktXKQ/IsUdQXjpqe6bRHopQQYI+fot+mGmh+
	lLy+BwSWyafQVubNivzb5D0yHr8bq4ezibIhxaDAI0M9MuKGqi+QQJT0xaAokaoFSeEe/iTbbU6
	Ediqd61DE0eIq8POLGGtHZgMZn/83GHRjkJg1NIHKagFe97ENshCB/R4xWRbrug7k4S34HU1zYt
	vTtJD4UcNgULZ/yqQAycMy4OTlw0u6Y6Zw2GbClrU1s0FKGLwhjC9AZ2WESBpZnASXxuDbafGQZ
	gDjXVTwrQfNWc/iUy6T/WGm2+qXxoWTAF99kYdQ8F6ovsoPnaZ4tt0uAkUAw+zpslhk+8mvxL1Z
	taKEuCKBN5FXG5tTtye1qZ8UeuJKqYIJ3ubZcagS+/f38eSTy2Z27SGegY5//c1xjTJuX2fxTIz
	/61CHk=
X-Received: by 2002:a05:7301:d16:b0:2c1:7fd3:4504 with SMTP id 5a478bee46e88-2d5870ad527mr688753eec.3.1775783524877;
        Thu, 09 Apr 2026 18:12:04 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:12:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 11/13] selftests/bpf: adjust verifier_log buffers
Date: Thu,  9 Apr 2026 18:11:30 -0700
Message-ID: <20260409-patch-set-v2-11-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-patch-set-v2-0-651804512349@gmail.com>
References: <20260409-patch-set-v2-0-651804512349@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The new liveness analysis in liveness.c adds verbose output at
BPF_LOG_LEVEL2, making the verifier log for good_prog exceed the 1024-byte
reference buffer. When the reference is truncated in fixed mode, the
rolling mode captures the actual tail of the full log, which doesn't match
the truncated reference.

The fix is to increase the buffer sizes in the test.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier_log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
index aaa2854974c0..c01c0114af1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -25,10 +25,10 @@ static bool check_prog_load(int prog_fd, bool expect_err, const char *tag)
 
 static struct {
 	/* strategically placed before others to avoid accidental modification by kernel */
-	char filler[1024];
-	char buf[1024];
+	char filler[16384];
+	char buf[16384];
 	/* strategically placed after buf[] to catch more accidental corruptions */
-	char reference[1024];
+	char reference[16384];
 } logs;
 static const struct bpf_insn *insns;
 static size_t insn_cnt;

-- 
2.53.0
