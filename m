Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77C38CFF8
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286791; cv=none; b=H44wHjwAac9lfBK6hyBIpnVPfhrF+CmFze1B0fXBdJIZdUKXYHBIcjMwPQ/XF93fFk3SEXgK4C56gX0nQdZ54hy0IUsuSFWOXyMcGgHyK9irPr5v+NM9c4ymPwdXy2SnlzHS3gSRD77bwctOoQzD4Nw/cyN5YgpJoRZy9a+F+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286791; c=relaxed/simple;
	bh=Dr4PihMoMr3qRKNSDl7IrxVJ9HeBlG623zgxVHaeaQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7xlPJ7d87+8IYRa40ZWwZryACj0rn2fjx2LsphQPBJeauXpkUmI8UEvENSKQ2Hq8+6K/1YTHZNnWIPwcZMwua6ZgudPS59BHzYd7YTaszoJazy5DcGmj167vtXRh4rnSthgMk/Ju6hlA9pQm5MEioJUchqiHb4YvDeS2y0Eu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MYqJi0HC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MYqJi0HC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso67787875e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776286788; x=1776891588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFBLQbbwJlUBHhR630uwL3PndoUaJYspuC1LBCHiL9A=;
        b=MYqJi0HCydTQp86v/hFbx6c5FmsOJJKWo27vVhVSkKtWEzpDCXOqYG/9Zn9uti0+8F
         ICvTJou7Xet9lMXHD+4UUI5IqK6Nl0DPJm/1qznQHovAq7XY5jLPiZvgnxvBCkz3TPmn
         I97rHQlT4x+3yIPU5io4hX/zfTHUJeu8BlglLRdOWCkeZasTziDzYL22i6+BZpJZIEAJ
         7m/5W6fajU2MC+/yccoKeykozhF3L8FZVtREjLyB/Ve7Z0CbBOUSclZsoPrdMcKapQjb
         P1zDKeb7qIoRN2+P5Pn/TW9OGc/b52odStlSSUAioGPGu3O7Br4mzBxMlN/s6zkAYpVN
         tsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286788; x=1776891588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFBLQbbwJlUBHhR630uwL3PndoUaJYspuC1LBCHiL9A=;
        b=EaCQLU5N+9HAUtwjK5csYbIh+enCr8bx2MvOJ+Npsxfno/V2gsAJe6FdLXS/be8wzT
         dLHC7bCVT115cr9wg183+MbUCz36kFFG8JQiTUPkHGYaRC0ZvcS0mEC7/0HwZlMZfYmj
         cI56dzOJ4x3u2w9msZkLqPds9NVBOnIowB5xerdpdm2mt6OOk+FcvSLZnvyo7OdUVGsX
         BhTOydPV2v7J4hDwT+/5i6QB1LhaE77hXe/Bjv6BQEP4E0PVS06QOT9zRSFb+Sy8tUEe
         uoiK55c5LHGOX46YFAIJW/QrgbUD9GlaRBRLg86iqyw7D9drudg0Le9wNfpzNthK35LH
         M6ww==
X-Gm-Message-State: AOJu0YxhEZ4rij0uMUU9qNxR+g3DrwDTCt3Yjl4YTYsIuG1FaV5q/wDo
	n4qdJuU8+E69uFtJx6+0GXMa7xU/gDRIprAVfkYJIoMCVugBKfLBHHERW1N20Kp+8TQ=
X-Gm-Gg: AeBDiesFjoG4Z9Boh+yBnXOS1MCUxwPgIARL66K5UiA44MYbPTBER7oT9II60v6DTZc
	73JyScuKDVc8PWm08AQWjCD8Y3nM3msahv1rJfu0oN/esSzE8Kv8lUMrsZl0DZ9kakRSxE2hEPX
	Wzp8jVU1O4hP6mANgr5+Hl47nVkyr7FrwEDqpjphc8a3FDJ6qaqKfNbSP88MWJ6f+FXUI99uaFo
	BxMWTaNsZnY0R/cZrR68g7R1e5yzb80cx981xsaIzwOP0jRYL1Uzh1PwRvTbBHi2HujjujmUPgJ
	62YdAdLJQ2ybkHyIImZPoViyDZViqVA3Ed9KcUd3o7qzK+VsC3sEQVQIiElEBNiaLApVsBEXBSl
	XOLc2/Zzj/rOdAQcn1cSYi9A+2prqD1j90WMnwxxppmMRViniJKLwH4kf/2XcIINRxMPsXtFcZN
	AJJsvUj05Qxjk=
X-Received: by 2002:a05:600c:630d:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-488d687cfd0mr320769305e9.27.1776286788430;
        Wed, 15 Apr 2026 13:59:48 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6a8496sm3468696c88.10.2026.04.15.13.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:59:47 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 15 Apr 2026 17:59:23 -0300
Subject: [PATCH bpf-next v5 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-selftests-bpf_misconfig-v5-5-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
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
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1776286765; l=1610;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=Dr4PihMoMr3qRKNSDl7IrxVJ9HeBlG623zgxVHaeaQ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMGWWbzfWEk41CsDSxTzXZll/JOC2pUkK6ZFcauKpPfsNAx1Y5sHy8bgQ7+Tme92jV66sKfhQJU
 1pmDrrEwGUgE=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

The .test.d dependency files are generated by the C preprocessor and list
the headers each test file actually #includes. Skeleton headers appear in
those generated lists, so the .test.o -> .skel.h dependency is already
tracked by the .d file content.

Making skeletons order-only prerequisites of .test.d means that a missing
or skipped skeleton does not prevent .test.d generation, and regenerating a
skeleton does not force .test.d to be recreated. This avoids unnecessary
recompilation and, more importantly, avoids build errors when a skeleton
was intentionally skipped due to a BPF compilation failure.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 040617c01bbb..3c9d61023414 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -713,11 +713,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\
 			    $(TRUNNER_EXTRA_HDRS)			\
+			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
 			    $(TRUNNER_BPF_SKELS)			\
 			    $(TRUNNER_BPF_LSKELS)			\
 			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
-			    $(TRUNNER_BPF_SKELS_LINKED)			\
-			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
+			    $(TRUNNER_BPF_SKELS_LINKED)
 
 ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))

-- 
2.53.0

