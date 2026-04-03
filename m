Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30D3C871B
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228355; cv=none; b=p2pyxSIcnx/Feb2XkOI9vAKIhSdTDdCnT8zS/3R1Kqsff4u5x+cb/hHp1LlpIFLSKMWYTh18WzwxVtlI/tYYDOYHTXbXljggX3Vf+Ll+laP+gTyQvhPYLMk7DEU8cui1ACzwtpUX+SojzL/0X4QTWu6ZWEwA5sXvKGrjiW9BG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228355; c=relaxed/simple;
	bh=f6HIgkgW0zS+/mWkMw/sxAs0VSARPuwtTbc+sdvuugA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhZ2YAteXlnaXFuXQhaJ9KHTupoi8IXx6miqRlQjKneeeEB4wAD65arLC/eS41OYwEShjfluzzYOY759UpZixiEXYxwGRFe9UGNpJR/vVn3lzlvZ03w9NnBkQohX67F5x4H9ooV5HiQGl00/qXBhylzXi/nB9mNkC7/C3BIgsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G3fljUvI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G3fljUvI"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso27262095e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775228352; x=1775833152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+1wdXb+bRQTa0pyI8/7iwKfOf3F7IiDnmsocIg8xPk=;
        b=G3fljUvIMqlyHn9SaEl5HRvt0GrcSUg8mOY5/2JF4gIjp9255D03JmOQd29b4d42XT
         0EKfff82vEd53wdN4n07DAi9MZ8z7i7TccSwKD84j1HMcXksapXyvvFM8Ous1SwgVYDV
         FatSHVkhEKYuasjSuklVsOw4jUFjOmP+u3jogzAOr+DqEYVFdbJrI1dQeknLnwQpTGX2
         9huWPiR2UP3/dZ2mNl8XEqSMpMBWY4aUNguh0eTD7o2JrHdu6OFnzk0L0IblthR1Ym0k
         nS8ESWMrTi58zPru4gGOBV16pvthcRQOtiWCg2IEIf/MOxa989KCpj1j/aTqqZ7/B/d7
         3Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228352; x=1775833152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G+1wdXb+bRQTa0pyI8/7iwKfOf3F7IiDnmsocIg8xPk=;
        b=kgOmYaSDslC0Zh2YJHVwX5+rMlsofqfo1sELqHAWsDGnbCpRt+T9ZuKIQI0tamSxPP
         Xjd6RwMfk3aAsOINIoJ9lFde5jIo0MZL0fmTW6gRz0dKBDQf5AXeVe/3X2sBKTZA9rZN
         DsZr4zQvXo3o76rXJYToHTu6YRo2Sb3qotrT3eJ5WgkgncPYNH2/dSVfU129XcACMf6P
         5tOLrjsJm+KBUieCTWdedG/ozvfENPiBTh7A9rO2MxPhVcu/CjHGePX1F7FKDEP+Mt3p
         9Yrx+sr+3lkA9m63ukyP4/faiXsA09HCdm2G+HxSXrk1IpTNCqdwe1ApiZOXUc7DEcBl
         ndRw==
X-Gm-Message-State: AOJu0Yw00DSTkEz3rSy9xY7bHNlGu94wD/pTRyhrK9xL8BMWrPA/rUVC
	T8v2JVG1Vldi74rTiLs7+gW6cC+t2xS9zzvezHLDUaqIhZn0G0fmGztuBFfG/8AUfvE=
X-Gm-Gg: ATEYQzwK52Vud9IEPG+J7O9r1ySsRb4LdAsAX32+DmIbXmnj9AIuSdWvA0lUqrxG2xb
	sygH2HuyCyZR2HphBJaNyQQWfajlSw+nwK4MZuDywnmwtN/f0uSeCzQUaYl1XWy1urD/wBCyHqp
	BU7N4gBmRKT/aW4rlti7tU4i8yCnzOQ3uFHiIHr2kAcB+U7NXleSSNsHO6qeBd8ljrLlpFnA8yB
	PmnVGk1duAzgUgNwm6TPQ3u5Rya3pjOLSf0uC4oNRMargZaBGqvrAv4umW1QJUaYu+4umbJKJVO
	Q10I/pA5a4BbOtnpw+2qmR5734SmaJ1khB4YlowFlCcGMDj7A07xp/8Pefu5CBQkuTVqJBmFBxx
	QFKtaPl9A/EUvJMIrlq/1B+KYgd4Bot9ZCR4KGbqO9l/H+O9bV2BNjTD4DvVZZNhno+pRwKmhNL
	ju0p5SahjX
X-Received: by 2002:a05:600c:c167:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-488997810bcmr56269185e9.14.1775228352171;
        Fri, 03 Apr 2026 07:59:12 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e1d1edsm7553018137.1.2026.04.03.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:59:11 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Fri, 03 Apr 2026 11:58:54 -0300
Subject: [PATCH v2 01/10] selftests/bpf: Fall back to distro build
 directory for test_kmods
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-selftests-bpf_misconfig-v2-1-f06700380a9d@suse.com>
References: <20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com>
In-Reply-To: <20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775228344; l=1670;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=f6HIgkgW0zS+/mWkMw/sxAs0VSARPuwtTbc+sdvuugA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOTB/yRzeCjFiieMiNd6HsKGUrnkmjlQqa03nLaUBftbDGnMuhh46RMMM7pNW3UfiOFFyJeSPD+
 yb93iZcWxfwI=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When building against a distribution kernel there may be no in-tree build
directory. Prefer explicit O= first, then KBUILD_OUTPUT from the
environment, then an in-tree source tree if Module.symvers is present,
and finally /lib/modules/$(uname -r)/build.

Also skip test_kmods all/clean when the selected KDIR does not exist, so
selftests clean/install flows do not fail on systems without that host
module build directory.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_kmods/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 63c4d3f6a12f..a5216815d989 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -1,5 +1,6 @@
 TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
+SRCTREE_KDIR := $(abspath $(TEST_KMOD_DIR)/../../../../..)
+KDIR ?= $(if $(O),$(O),$(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT),$(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR),/lib/modules/$(shell uname -r)/build)))
 
 ifeq ($(V),1)
 Q =
@@ -14,8 +15,13 @@ $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
 CFLAGS_bpf_testmod.o = -I$(src)
 
+# Ensure KDIR exists, otherwise skip module build and clean.
 all:
+ifneq ("$(wildcard $(KDIR))", "")
 	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) modules
+endif
 
 clean:
+ifneq ("$(wildcard $(KDIR))", "")
 	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) clean
+endif

-- 
2.53.0

