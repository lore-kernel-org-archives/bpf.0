Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48AC35292E
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833577; cv=none; b=BAl9I5hIIMCAnFifUccIn5spLpyHYTHjYpvq408ZfkXKOSqGe0W78wbXhcxjXU1bX6N4XUev80l3qMGXBrMWxAUbs1U/9f/zlkKs9lzGpKxIIapq/Oxpwb7aWWIYTnULcrza9aHels8bMIwFj8Umw4n9GjPfmEd/gJ43V8kAlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833577; c=relaxed/simple;
	bh=cw6biPi8Vm6QwIoonUYw8vEf+IzYIiChxfXRjaypQaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG3HEB4OPvdXvTRRbisUlNMG9jbXHI0dwJfs9MIOJevQBV764ofHKH8qZNRFQRuJWu7cF7RNVQMftjSZ3nNxJDyQoBFC6jvdgDr53yZzJBNfSm81v40z+0BDuQ2oGh0LMcEX+Yb5AWvjgPmbYFHYIt2Sp8rex/ZGXZfX59ENmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gherINV1; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gherINV1"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-4043b27ddeaso1291222fac.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770833574; x=1771438374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYI06wr0yFvazoQfbq6WNphJN7iPFdM6tzzoT5jPOzI=;
        b=gherINV1joIRtShWuNyskZzUvoKv7BWtdQSbtDpo0ZJGy6IP0B88zwB7DDPlWQZJSV
         Ue1121sXtXeZlcMzG5iyF7/P+U5XOuVr1AYlSrSfzQKTfm630/JOGNmWDmOlReRyZZRl
         lK3aUB5pJi9EUx8X+UGH/389iiCrNeEfPBrqnVm28AWISAXqnlD3Of1JojiEpuUKN/uh
         e+q+o/R4zmlojmEzKfqrn5vhejhyTOzZsQFpABsDkBBChOJpnPofmcyn+0LbCQY5CUhs
         oWlWV1q+8vGBWJ7GEOiAaqGRTxiirBEPsebTGuPEqOV8m/d2ft9sMRv0CVTV3KHgmcVn
         D4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770833574; x=1771438374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYI06wr0yFvazoQfbq6WNphJN7iPFdM6tzzoT5jPOzI=;
        b=RAN/bYko8eWaxdAluREZu62BsMufVQbWB7nFfLiWrfEofqt494vCqok9WTIIdt3Yhw
         YKP9cOTeH435YY3n9uYYokG87XVgL0PDuZlgQg+yEK2l7GEFIOXBMxPwdZRCWgA51c2g
         Zs5q1lOflkQMRV3kW2mgnvsD6JPcemt+MYG+CTYrvm4MgFo4SpBV0iCxBki8R8lkb90+
         9zuWM7Tcz9SIlUToMcPMIsZx7HGv/P9m8TYrBGbaI9N2Hc+WuMAE5KvagJ3I9/Tui5Y4
         JtrKLuZ3/jg+MH89rFDSK22iM/r5OZzLqVzFBFX1P5ThmH/Il1/ZE8zI/BmBi51hmD0W
         yyUQ==
X-Gm-Message-State: AOJu0YzAJb73SZNlINru3KGSqngtquFwCjxo6N+kf7Nj66Uil2UlKCyV
	tOsw3Vb1vxxjDb8V1SiGChfDnetA6ZRD7m5mSxXyrlkmgUSrjcmAgESG+BInh909
X-Gm-Gg: AZuq6aI9vg++ox0s522sLRlItpVdUj3XqCmao1a/POlQiRXRsO4qYSUMMl7t5nfWa/6
	einUoCEDVJ2e3xiVWwsGjWiRwjGJpNoNCdDA1B+tbNcgKc/mNAaWGdn94/JQ8jKaOSms7f4Z1gA
	xHDRiidQH1ox7TwSrI5jrigm01aR+fWYpp7ShC+yQlg5yQqKLIlSyh2e1ErPRCOvjAfj9U99+B8
	+F5263pGTT3g6FKmrA4nDVBgMgPAlPL38fqjmia644y94x/iZU8Mvd9MNmzfzuU6sxbIGZs269H
	rCv09m+anKkUO9abtemJPx10HT7Yvm7JXrmvSE5/H67P4WKs5DqW62fJVcb8v2L74MxSS9CoSO7
	ymWw4BvxaWywhb7Nsz6Aurz66dNmOYzscZSTvLex1GREUIQp3R1TzsnI133esiPe2KbO5US0kfC
	hd7Uht0widTtXGMMuz6yyonGeCxILNc5y46FiHfATe/76k
X-Received: by 2002:a05:6871:826:b0:3ea:d0d1:bb06 with SMTP id 586e51a60fabf-40a96e59977mr9499074fac.34.1770833574313;
        Wed, 11 Feb 2026 10:12:54 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaf16c383sm1789828fac.14.2026.02.11.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:12:53 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 3/6] bpf: Enable rqspinlock in tracing progs
Date: Wed, 11 Feb 2026 10:12:43 -0800
Message-ID: <20260211181248.3040142-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211181248.3040142-1-memxor@gmail.com>
References: <20260211181248.3040142-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; h=from:subject; bh=cw6biPi8Vm6QwIoonUYw8vEf+IzYIiChxfXRjaypQaQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpjMUeuuSKf/Z+bKjTbSibeLwEVi1mv8b9Q6e+a09s 1VFuURuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYzFHgAKCRBM4MiGSL8Ryia5EA CRdj6Aaf02j8tYG1SumAzmQ68710F/kkP7xN9JgfQTRzfkeJUb8+GfErHJMoybXOo90yjD+GUa+E27 1QfaopKLd4iQwTX4rmKBKRauaNU5aI8xxrtTba/UUeezVBoNujlPc9jufdybstq33qlIJo5hF0U7sr CAG2/4ciqb2P/6Nf2TYGRHmC4wCdvnO4xHMSa+Pl/3THQ23fHxknEJ/RnoK2DtuI/kHpGwBgMcAlKv +k4B6idu56EXSWt8VW0gHEjy/2cb1oeM82NNPsQALK5gNsvToERrW1PTvffu36ukkv2dioF1fX1m8h AyI9XbsW7lwMQw4sqalJZAL5IbLYZGu5wGR/fa+zsEJl2SBbjDes7WAoWfUpVDZU4+beUiMPhbdGSo m0Fc31sXq6IIfnnBQYwsgBZSEqLSL1m+ZnP8bXgbyfpbAhgDYhmZ5r+eDBoRVlRyulfZxpyn7c0KJ+ fd+iiQp6NuZGXWouLPGCS96y2uHHm3luRtG+DQUDlBS9JHR8u1S4EVzPn55c63kMu2NC7/luvKUywN N/EVrR8ErCCBeiuVvm9GYm4U5hiqYfmQ2PPimDyw8VnQhOwdaCDI7+yimZcutTsIaexdnN6r8Mh6hI ISO9qbYDjf9gPE3ck3uhqRQqBSLVRycbo3eByfRgZTuRN3LcFZEfraTF/PiA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Allow using rqspinlock in tracing programs, since it is safe to acquire
from any context. This permits its stress testing from any context using
BPF programs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4acd8e848c88..fee92ff348a9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21542,7 +21542,8 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 
-		if (is_tracing_prog_type(prog_type)) {
+		if (is_tracing_prog_type(prog_type) &&
+		    btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
 		}
-- 
2.47.3

