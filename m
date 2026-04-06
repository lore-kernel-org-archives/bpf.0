Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D1388E51
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491908; cv=none; b=QRQWdcmihBsd0R4KWti92p7utsvgEm6c8zP6bXAIm1x1lTFKi1oFZVoiOMA5ijMnlHrc7lajAUIfxOKNWtk6SSmmCB/yvXAih7Tj+WsjNgBLCFC1G0wJdw43IKPqyWKQXgxFer5sUZvd+qXxgwfN0s1w5tJrvX+v71fxFiX4vXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491908; c=relaxed/simple;
	bh=Y6Op61VgoKq3gdZe0FSy+wbwKQznkmsB5z8u+Zqjivw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rv4Gaqa9zdt4sP/05AAM/LPnds2i7c9ZgcxpzhQuj6rx4TVO8OtIH9cfJ18m3mZit/XdMJJJLIq+gz2ftQFkxcilREYPDaZKUSqDONFRBhFmJemLYWulLi7veA0YF6iRVWqfnbitBrPLnZCrfqPPvNjemq0E7fkn428XwT1bboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GZw4BCeN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GZw4BCeN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a041eae5so16984245e9.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775491905; x=1776096705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KyEH8CHmtk3sJaHZBn4POklyiKWwjDfRP+VG1KRjOM=;
        b=GZw4BCeNkLvalBiw8qN4wmH3jsvpjQsaYMwkKutUBZ6Xwsud0QcCKy/F7JjUaXAFmV
         tegareuCLI/V7M7kA65rYjzhb8pdJJx0GyXC03CQV7VuAXi6syd/WWrZfiyYaClTurKc
         5G0VViB5v+uPnMLxvs7y4nRMQIF5ZFVfvLr2v6wU4e2JN7oQbBAPuzhFZ5BCF01TYEkM
         rpFZOtUGupE72evjJRjaSAept2wnJZwjaSQkkJHFapQ3y2DOvq6qBgEUFa1d006KdUUQ
         V27Nb6zGU1idP9X65yxQFGVV+R84OXKCtrIjcePDYxjEO2Dm+cNvHX3pyDHztAFuWcso
         lx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491905; x=1776096705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5KyEH8CHmtk3sJaHZBn4POklyiKWwjDfRP+VG1KRjOM=;
        b=ZOTd3r5lUI2rxUYbrNGuZMzY9hPl83N5dzmd1LWjJh1CCNtno8CrlYkm8VerhbThHI
         U9rvBVfrFvJp7KBy7Ji9Uuyilv0zceyLVN7QS8GqnS5txCX9CfXqqSFvYS7hgbBa/6M9
         X9MDBOuJWGPfhrcWEBdiQN7yRe7fEBb7fufwLBLvTFt3gvqWmHPzBrjk8yiZkyb6B6Ga
         BxvUCnKoWovbXpHr/XH7nwrn85RTX1NU1jIG6F1oD22Vqsm/BLB8Bhq6xqg8VZz4RVPQ
         DpPbxW2iNN8X93HnrGfpnMawQOulO4LRnEY87TnbCm8ocBe+QNp0yu2KXHkJI8VVBaiy
         PbHQ==
X-Gm-Message-State: AOJu0Yy/wpB5tNP5VmIiOE9SKSOUN6uiP2hNv+G0LnlGgzFznfXBbYVI
	VYvu5yeMSE06PCCBZ+eYmmE06Oc1YvGSINmPtywZiQQt7FDOrhHggy52LMBPLSX7A2h/rZwqiyF
	8x/Bt
X-Gm-Gg: AeBDiesUO5OzJkax4li5Q9rA1XzxT8U4GV9kRDIaHKqrbSKUpfUPmUoJ0sW0Jw2v2RL
	Sz6SBEIKlOEordTvd/F3RePKUnpe+gocaHxaafSRfPs4Xms3JTaWA0V4Dz+r6q+Nf4ThIiMjapD
	rIkS2uSuyknr0nBG6l2Nn8/K/l4hwnIWWtZ04w51A81cJKqRN0TAYwLGEVYaTqqj8WKyWtf6dN1
	5O7E6VIwYetpfwqMpCFtl5aUvI/kon9tuXN2f02f4Pi1BncrxjVvyKrcC+mKCxk4W8bGmF2CXR+
	uGE8y0oDK+xamyWhSbox1O4nZXfSWWfWJrsG/QPsegwFUnE43JylkbJIuv7Dp2wUZhymKvc+Z31
	0gVj7d3JUy1eGgiH/6aQNFwFSUVSd8ARue4NaatxS4etm+/ZuQjSam0WJl1vyS5R/MCv5MWdhc/
	NmykBnj0EDULYr
X-Received: by 2002:a05:600c:3f0a:b0:485:b6dd:5066 with SMTP id 5b1f17b1804b1-488996f9414mr206065935e9.7.1775491904962;
        Mon, 06 Apr 2026 09:11:44 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb897b8dsm13308897241.7.2026.04.06.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:11:44 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 13:11:26 -0300
Subject: [PATCH v3 04/11] selftests/bpf: Avoid rebuilds when running
 emit_tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v3-4-587a1114263c@suse.com>
References: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775491886; l=1031;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=Y6Op61VgoKq3gdZe0FSy+wbwKQznkmsB5z8u+Zqjivw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP6R45JmKPhy2oLtA7VAxCguDZoe1ylR5jGGacD358ZJbObSXP5EhX7BBRy9WyK1ozCENn2p37g
 7IfQIVY8odgo=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

emit_tests is used while installing selftests to generate the kselftest
list. Pulling in .d files for this goal can trigger BPF rebuild rules and
mix build output into list generation.

Skip dependency file inclusion for emit_tests, like clean goals, so list
generation stays side-effect free.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1065852e2b01..3e4c726870a1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -699,7 +699,7 @@ $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_BPF_SKELS_LINKED)			\
 			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 
-ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
+ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))
 endif
 

-- 
2.53.0

