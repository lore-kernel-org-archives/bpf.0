Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CF39478A
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499779; cv=none; b=CBNiG4jBnPhcTFSBn7IS1EfehmJRh3AY4KljH3km68mZ9rh0PfC/tCPzaHrblIP6UuvCKs2MF8t2wDgPJK4adxGlin7pheEwPt7bHvRM3EO57mnPInuGWf4RKZpDk1qVaqTEgmLUHF9A2RXGOe84vAlpyMdNlweweYPGmPu3poU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499779; c=relaxed/simple;
	bh=oPNoWp44Ch8dIaWH8jcjnz5vhr49jgxtCJBbGnfyb/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LH8X9PYUbYzXWHdt0AtbyuVMaTvaH4CLUVYF+0EMwRndtbDnxcSH+sRC4myKQxuP8Hv04kOAyUmMT3lcxI3HsoFCTQM9DRBx7HEe7j2BUbxudtJSnReOo4qGN7HqsXBfFFY6AD4LbyfF1HemXOO0pYHycQrJBOychVM2OiOwDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WJkIScop; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WJkIScop"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so56084745e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775499775; x=1776104575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lG9XFANpBIri4ZwFlF+9G0jzztKra84hF5dQuOesbq8=;
        b=WJkIScopo1LPAPd2jPZsoBs6xJ+U163ffmOhmbABTfTNNAg4iCHVR/O3kANFG6aBud
         FCzwItlgu6nvaw+kgS5E82cHYJ+Ov7JYx1DRfJLw2vtjmIWApwqrQfLyx07np1jRzyEc
         YQkqvIqeyQtpMikcLcm49Xg5tNjUUm2Z9r86thfwou4zGRCv3gDGrDAHHoDyt42z99uw
         YwZ8QvlIi26fLVk6HH/l3X+anrDDZHWL4pzDOtga1qRJ/fcVWCu9nKCVr3oThfNf7WR+
         zclHU8znAwaQ453AIq8QNJxBe37lBhj9k/6/JGm1BOriZXznbp+rx1YCiIN7Ne35+AfP
         CghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499775; x=1776104575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lG9XFANpBIri4ZwFlF+9G0jzztKra84hF5dQuOesbq8=;
        b=OSB8/njGowsev1/Km4JePbbou8lBl/itgaM5O62XvnRK/OTEGvlZH95SvHimXLUdDG
         oHEJaYtraeoCu49NdUorsVZ6nV8kZ8XJE9bddMIv3r/RcPELhTwknozdMyWRQalrc57V
         FMKHWBurHbdYMOx4PSnuZ+q+OLIY5ZpI8SjtDhFhjQ/2gJPqRafezmVGrMo+WUPJAJnu
         zdT0nZZRfWvBBym7iCPxfSXlaSqYDg3i4T9jQMCJ81MGEtrppsk0MTNy2lPGZLfHaQKK
         Em5rlgEt2oi9RFCe1x7/dSlZd7q37naiWwsh9xKKNyIYmDqOV8FtBz6KWY9RGRywm2Vs
         e+Zw==
X-Gm-Message-State: AOJu0Yxz49lgoe5crT034pIiZvA6/CgDhue+sN3IAVeMxBme/Tt0s3Hn
	/PAgtXXcTEb7KVMWz733OtCTGD0pFK3Ou/A+3Iipmz80sPJhpUrP3LHrgT0Z9VvrOAE=
X-Gm-Gg: AeBDiesassfRt4B1PoLAaepVSnQMgrWXWsf4DIGFvu1AXw65t7EzeRAHfr2zXiRNgSO
	TmYzB+0bH+4spTWxLufLWrtF+MGFMhydtEWFDvEWp5Eb+2dX9dCQo9ki+FMkOh1FOB9iyvjDfoh
	bB+K4aD+XrDgI2/vbPNma7TQ7JOpZsO5Q8rHNVS5+LKlbQhNF0HfKwY/H9F2/hTjzSAhZNmz3az
	tLDK2sfL7EsLjz2maER/h4cpxgNaIo0zYDNFw4L4ePxo+8kAXRwKBagQraGm6pjohb2FrzUM4Na
	6x6SIIsyKMQJtcoWM5IG8IySFQXjRC4y3Dw4guX87MjIwYzJ8Jv/VENVuDJ2BWW+GRoqurHaWol
	H1oeJ3YWL+aEJD/pbqbIsV+Ym2oHu0ok3levMnNz01CIKCa/Fjok21aok95Pp0zFQcHuw+QnDq7
	7FcgCKCbzLdKyc
X-Received: by 2002:a05:600c:8b03:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488997d3188mr196188305e9.23.1775499774791;
        Mon, 06 Apr 2026 11:22:54 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9b75dsm17165582e0c.12.2026.04.06.11.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:22:52 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 15:22:22 -0300
Subject: [PATCH v4 10/10] selftests/bpf: Tolerate missing files during
 install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v4-10-9914f50efdf7@suse.com>
References: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775499736; l=1301;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=oPNoWp44Ch8dIaWH8jcjnz5vhr49jgxtCJBbGnfyb/o=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO32X2js1+9VB98RLm846QzI9EOnFxUKUrv90O3Dev0b04fK8r/TKh5q6VGB9RgJWYffoVNlFQP
 fnluA++pJhgw=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

With partial builds, some TEST_GEN_FILES entries can be absent at install
time. rsync treats missing source arguments as fatal and aborts kselftest
installation.

Override INSTALL_SINGLE_RULE in selftests/bpf to use --ignore-missing-args,
while keeping the existing bpf-specific INSTALL_RULE extension logic.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2b0747604d5f..e1c100f1ef36 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -953,6 +953,13 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
 
+# Some generated files might be absent when only a subset of BPF objects
+# could be built. Tell rsync to ignore missing source arguments.
+override define INSTALL_SINGLE_RULE
+	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
+	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links --ignore-missing-args $(INSTALL_LIST) $(INSTALL_PATH)/)
+endef
+
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)

-- 
2.53.0

