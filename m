Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947E3B894F
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082639; cv=none; b=OOsJpnMhTG0UzzKoSLguvZ81Nc/r84VFUPELartHjflNT+J1dp1AneOEJbB8RTIthWX+Of79q+aokFnJ+ukpYvJ32jYowr6wcBsUmelmeEufoA2RhxSe7JYSt9pbjZL+V9619+miqeRnIeU6mo7ECfLNLtcemG3oqMkvT8tnNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082639; c=relaxed/simple;
	bh=sv7VBTrgZypdmYf3wpL3Mn81ceoiXcCLrWRt5VRrld0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ieyUreSPdxooxPBv7X4wkctt+vM0k3qTzSKusOMjAAKc5BnmUzOe3bO/KH4POsLhtUBC7K8eGkeW+PQf8v/Fjiff9WHjMndXpLGrmStM9LyRss8tBroN2boZ7t2grA2bfSfN87683T+IbHl9aAZHo1AClhqc2NFO0CT6xPlrVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBXMrqmR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBXMrqmR"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd8dbf4f2eso105429385a.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773082637; x=1773687437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7dkBjVBWat+H4XmEbywLgpRNHJrKQiTCmHMFlGr7R0=;
        b=BBXMrqmRRrikfdwqoI8+riAAivwippSyc7uIoDr39upapsoouSGxIYgtGEdq916+0k
         KGYn7/SxvcBBo0aTeYjshepalXg4nuNWac8ylpbhtXjLiPzSb3z0u4XS8MSWQYLu9UyY
         ujXclPiBSxPm57EVYJ++8FomkzZqRyB0JkebojKAhoNW+4XADHzmStP7g8vibafRyuju
         HJntlRtZELU6U11OmDKgWA2WnQj8JlLsFukeTlw228qYtlPDEG/csLw7SG+aZU/EsErI
         nz+ha3QELcaiWBgR+buwzTzH/qX/rL861dBzO8rHJtf+wGdWGGAf1E243Ih7M3Ap0OAi
         nP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773082637; x=1773687437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7dkBjVBWat+H4XmEbywLgpRNHJrKQiTCmHMFlGr7R0=;
        b=JesFQYsS1saYWupWj8v7NZNfDQMO+Uk64Yt0cwX4dJaIkGXPgAPEvFhmgSBDEbp658
         c8355HueJspUq8fdOJ7Znp9cifxZa7OBfUTeNU4X7y0SI9hGh4HVkcKKT1G28j6nvW5v
         XXdzY6PQx9F74H8fNbiVnP19TGQ9yItaKn41ZZmpvOJUBurstn/69rGkoAJHqqCbnZlH
         NKX/yPLQkxTsWmBFXF8NQCOcZ37JOWp0ttM05KM44HQGWZJQyMzrBBwtZqfRgrGstNEK
         v1UazGtvU+s097SsLpiM1XlC05rr19ErXnvB38kAu0jncnl2wcN4XHh47tyHqI1iBCs9
         JWKg==
X-Gm-Message-State: AOJu0YyfzBeKoArmYYJifhmEr4PyTM01qCgna2N0g0wruVszx66Hmgaa
	Ws4t24e0Ngul81L31hHDxAop40br0dRlgyH+B/wVpyZfcW3ipKBxORzgZg26fimJ
X-Gm-Gg: ATEYQzyKCoB8tYx3PkrVxr5UtKaY5riVzVKNk1VRv9tyMAyHS2hTIEUHQGXvDw1fc+t
	GN6Y4tzomfzhscT1fSiFbf3Te255ybh0YQXQv/9j++uODXvrTqpxLyalH5RTVf3xEzh+oKVoXaE
	OIIZFOKSbqKndXJXtfpzmQYTEKweKXz3Fl/aMDa1de5o8/sWfqc/a6O1TiMBU1fx7BSVt9WELzy
	/0nRImdIx7UOm+M7wP1kS1XnRg5qLgQYm1OCS0eja5JwJPVzM6aar7SbkFe9/J2oj+LbM9JphK3
	YXBnqlD4URj5zEJtkl+m83ULXus9RQ2siq2jJjmOgCvlmvr8+mtsyVIzDNGPHsnGsNwG6J7TQ/F
	aP6erC2+EVazwmcZCtwbw7044YgM3FA5Q67MVvmv878Nedc9gkLqlcCZRZYfJGRAL7CxHS/4WST
	Ig/mL18qTyWNDFvhd8cASOnc7wW1XECn9RGw==
X-Received: by 2002:a05:620a:2688:b0:8cd:8d79:6c63 with SMTP id af79cd13be357-8cd8d797032mr398433885a.68.1773082637514;
        Mon, 09 Mar 2026 11:57:17 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd90aae2c0sm117876185a.27.2026.03.09.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:57:17 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v3 0/2] bpf: Fix abs(INT_MIN) undefined behavior in interpreter sdiv/smod
Date: Mon,  9 Mar 2026 18:57:14 +0000
Message-Id: <20260309185716.717894-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF interpreter's signed 32-bit division and modulo handlers use
abs() on s32 operands, which is undefined for S32_MIN. This causes
the interpreter to compute wrong results, creating a mismatch with
the verifier's range tracking.

For example, INT_MIN / 2 returns 0x40000000 instead of the correct
0xC0000000. The verifier tracks the correct range, so a crafted BPF
program can exploit the mismatch for out-of-bounds map value access
(confirmed by KASAN).

Patch 1 introduces __safe_abs32() which handles S32_MIN correctly
and replaces all 8 abs((s32)...) call sites.

Patch 2 adds selftests covering sdiv32 and smod32 with INT_MIN
dividend to prevent regression.

Changes since v2:
  - Simplified __safe_abs32() to use -(u32)x instead of special-casing
    S32_MIN, per Mykyta Yatsenko's suggestion. Casting to u32 before
    negating avoids signed overflow entirely.

Changes since v1:
  - Moved __safe_abs32() helper above the kerneldoc comment block
    for ___bpf_prog_run() to fix build warnings reported by
    kernel test robot (W=1 doc warnings)

Jenny Guanni Qu (2):
  bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
  selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend

 kernel/bpf/core.c                             | 23 ++++---
 .../selftests/bpf/progs/verifier_sdiv.c       | 58 +++++++++++++++++++
 2 files changed, 72 insertions(+), 9 deletions(-)

-- 
2.34.1
