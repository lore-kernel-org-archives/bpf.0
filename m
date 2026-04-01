Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967847AF66
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060154; cv=none; b=WXyWBjlkE2gM/4rdS8oyCm6Qo433R2s66RulR0IxmPySmkaxpDUvOiFPcbS39bFBll2Mono1/eRx7Yd01vN8lj7C+0eNrJLH/uwBg5hIsKubvq6RCBHF5OgVGrwM9RnsVI6ytoh+p8H+VTFSJNHyKWYRo5lGDGTVAMPfe7USeeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060154; c=relaxed/simple;
	bh=5Cadb80gWkZ0gleJDaQiHCYtLQOCdz43lmTsJFbr0dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0ROumxwTqEAyWgcrxfN0UWBp9J+X/Cc8HKJZ/jmfEBIz4QdB6UtK6FNkiUsJsexRzJcOq8rLp+t2TV16jIe97OQEsdGSF9AKGBZP58ZemfwqYbfjaVfVBZezNnoI6FfMZkV0z6+2mOP2rhWf1AfcQzMcF8D/aiOXCS4V3OZm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bk1Rc3p0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bk1Rc3p0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fb439299so66494875e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775060149; x=1775664949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlnZjdecNF/JqDBN7Kmrnk0aaNOEXID4WQmoE0dJxmY=;
        b=bk1Rc3p0boiPJitSppLvMCP0TfX1Zgesrun+CYd6APmhqL/MjNil+ZdRlFW15s/CmA
         SdLVzix7C2l7gs6n+fdChSj+2czZ23lXja+HiRpZoA3WkJ0B8QdlNI+dpKhaKXgfOfVC
         yHPN2SANR6fiihrONxYy7bMwWWum1NUSTwHJUogZEzUDR7QBK+YfWjq2oX14E6IUgJFp
         r9FBQHGDr2sDO7uoct1pGGR6Pyqi+wYOyxe1ibvmhDCy1hy3dtNPMdi9Uh2vM942dJkv
         U0t6Di9bVGdUCmBfcEtFgSkFO/0QROnFUaMFDvCfDU3d97pQbn/N68uW9dRw2F5vM1He
         aBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060149; x=1775664949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QlnZjdecNF/JqDBN7Kmrnk0aaNOEXID4WQmoE0dJxmY=;
        b=havVGqj1i6A/0S0jWzLaqi9E2EA5OSZxgCkjzICwnT3pkf9QO4g/6loRZb+0Lxu+po
         bR+lW9MDAwMq5/UnIPM3JYtRAmSoKQeDZSIrSc2Pw2NJvNYvLY4RgR5LqiadiGNkqpts
         ud+0jNCV0rHbQY7fmtRSPemBS1H847X/iKzzQokxQElrGFEqQRC5I3MIvwh+KaJr05xw
         FAOnbOw5HXK0R2rmg+69fkpDH2E8XB4vLDD0F07uL4uJsYZ1yykBpRSnc9SDPxgJpfLZ
         HAKVrxOGcHN+s0qxtituJ0HjLxtEscF/RvnpusHwwhC62VCFbpdbuGrVFfxyJJj1VbAA
         DwEQ==
X-Gm-Message-State: AOJu0Yw9QJH6eQAcb9fn6CevWEi8pqYnongyJ6OIbyxoAtYeFImQ8I5Z
	2KLfLyw7CtOxfnUiFGXNX3tUZybM4axsWlw+G/WtMuNeRUr8BkHz1a6dVbC4cQMFr84=
X-Gm-Gg: ATEYQzxWM/lTI3GG08166Zpz4mzBY4ih6OTGduym7oiU3mC+qjOQZxuuA6bWGehBf6Y
	KsCYrYp2iBNKEZAe5Xx23alOtIvnneAOfQMY5fXne4YOjo+PynQiQWo0eCNQCWPwVkKMhG+O6+o
	yOIYOF/AltEx7EmHtJI7NS66soNwEIxGekphrgaqqgzq1t/GWO/NZOYZh1wBtcSFVfwS4LAo+DA
	3yye92zIrVV2Q8n+w6s03dwHHQRqUnEsTcvJ0Ad5GlAP8c3s9Ew1m4ZiSQzD1YM7PRNZUEo5HfM
	bkEw10oL3fIaUKchKnK4pz4Yn49J9OTL1L8j2jTHX9qgYnnbZnhrvelPjwX54/b906yxhDvMUWV
	qQf8vl/Ho8UBRLufOiOFg0Q6X4201TumAMnyBLoV82T9SjzSkzpPJsjwJ3BPxBaIPBkWbBoYGVy
	6WUZXYVVpi
X-Received: by 2002:a05:600c:c87:b0:487:13d:4e77 with SMTP id 5b1f17b1804b1-488835b790cmr66574175e9.27.1775060149503;
        Wed, 01 Apr 2026 09:15:49 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6058304af93sm201322137.7.2026.04.01.09.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:15:48 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 01 Apr 2026 13:15:11 -0300
Subject: [PATCH 04/10] selftests/bpf: Make skeleton headers order-only
 prerequisites of .test.d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-selftests-bpf_misconfig-v1-4-3ae42c0af76f@suse.com>
References: <20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com>
In-Reply-To: <20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775060128; l=1534;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=5Cadb80gWkZ0gleJDaQiHCYtLQOCdz43lmTsJFbr0dk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI2ZhEFe22dW9QeVxHpYwL2xI2ZQbvN9TAnbyhqspFCgOTyLZN++3o4pyl9jWddsdpZIIcnvA8o
 DNDqK7SvYCw8=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

The .test.d dependency files are generated by the C pre-processor and list
actual #include dependencies. Skeleton headers are not #included directly;
they are merely needed before compilation starts so that the compiler can
find them.

Making them order-only prerequisites of .test.d means that a missing or
newly-generated skeleton does not invalidate the .test.d timestamp,
avoiding unnecessary recompilation and, more importantly, avoiding build
errors when a skeleton was intentionally skipped due to a BPF compilation
failure.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 781238152c4f..72f576a8236a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -697,11 +697,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
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

