Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C03CAE68
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228369; cv=none; b=Ox+a8BHvnHNEtcI9faOhv3LDWpByMqzQU5kO3pGig7TMyjMqutuRObYae/EhJzmCSeqHzmJQRhlLtwLj9uS3kGc4ZFejXJERsASETOCreyXGsL0S758oK7OtFtFV8WVkqmrmtWDZdMaFZhHmfo7iKq7TdraZK0oHTdjboKAfI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228369; c=relaxed/simple;
	bh=r0hAi+8/1aDh2iFsHnAbZTWuQDE4t7kIxRdOWHyRr+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBHBoaQ2/0OSW2v0Xhd23u5sP1s1KCppZA52FOjTKhWgyp/BpW63i/1d7rt2xTUqYV24hpNawHgSZRiDKATAVU34H2BJOeA3ml+Q6a2XLyimaInztLaiWzswXQ1vbBLJUmIBU+wKImUH4VMSQ9nc7NL4yazlwNkArJRuhfvBPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dZ6sHxUx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dZ6sHxUx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-482f454be5bso33160555e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775228366; x=1775833166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYgqj1zgQSxXbMWVjaEA9XAG2XEf6AIEbv/nbSFPah4=;
        b=dZ6sHxUxwXrbQYXHbCPJoG7Uei640udMjSCid5tmn82H857CKaARz/ipL/+iQ/vcYf
         0SmioO8fGc5T+ewRnprsjVSwpyPwvBFfmK0gQ7YO8yFHoxiA2AQrtCmfWSrV/DsZuCei
         DKDxWOXj2wvwgEkyEZmrprEQbOwKydCpP3Z42iLQw2T+DJd2G+saR0lhU6xBb3+2Ih6l
         VeBGffmxWdtJpUMB7sx6u+cg7JcFKEucd69EpyCJ5VZiImj+VRqouEfIDdqa1ZsRO8xH
         Ve/qD+3aigIghJIak5EFLihrXhvWiIhahDg3uyDxBw0PNwoZeEj5T/j/86P0jJvjwfjE
         NWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228366; x=1775833166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OYgqj1zgQSxXbMWVjaEA9XAG2XEf6AIEbv/nbSFPah4=;
        b=R4tMwlZrKeZMDd/H3Y8y3yE90uMkKph+9vpNbCFjFgxF6U5Bo4bv4WQSLAVE8PffqU
         w3a7cQPbe3MJ9JOnkTFdFIl2gHEg8s3Kmrr/48qvl0Eg3tB2oOJ8CzAiX4TiAQeArats
         Fohp22/fFH6Yn1fy+HuXzjMrXWNtvl9N8IBsFvzSas8n1y27nRm1z68bM2vT0MAyfQMb
         egkIDG8xmqfkTAgBq1kOJrPNUBgg9dU0GORqpSIf1C5W2iNCqRlHph/TPyZs8TP2CRMD
         EctNIvyGn7NGScjpFVCyDf0LXeHLiFBpmCqUrZvyOQ/U+HGlosf0YECEbQWyhuS+bRYP
         jExQ==
X-Gm-Message-State: AOJu0Yx9bAxUWHn82uR8lMAIw4/dEG+RJDIuDoyRlx46vzyZwVnbiRpL
	MEq7FCvj9ei6HTh38czrINzNEFAigdg1UKN4dWuY8ZhPSsOrPfgeY9vbIWtjvtB7vgI=
X-Gm-Gg: ATEYQzyUfvrGo0knOj/HZoaKbVEdClLCODjSRfDfVsdmcZkOx2r3j5TYNIxLumR01uG
	jtY/3qMPUboBUNt42O65XYBdVOFaOuSumNCLa/FIoEgKapODZrs7L7yeA5YpcfuQgB8HjWHHF5q
	xD+h/VkYIgNpx33qRWy0xb3w4xPTvXFIx+HxpljATS5nTARYpetTvSduNcQDbXXsmpxZT4SjmQP
	Fuhb5C5p5RvVI7R/hhbB+NEtFeTdJBjn9DcUivpp3HTJDf8P/NGFwgm8CeGVxLlSCV+lZf/zp6z
	RVjXawCYMB1yEzV5/LvIJ9RMMcAvzxgm9NAq7XktCM/pbpXCKH6XzRw8DYur0P68HeEecB0ahnV
	ovGrAVLoPfluUZHfNyuQ824imbsDlh3ERV5DGM0J0n44A6kKZAaJO0QavDtCypCSzlqm57T81T6
	wuAPm7ZCDM
X-Received: by 2002:a05:600c:63d7:b0:483:6fe3:bb49 with SMTP id 5b1f17b1804b1-4888df61f12mr83736555e9.0.1775228366187;
        Fri, 03 Apr 2026 07:59:26 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e1cc7dsm7452360137.2.2026.04.03.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:59:25 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Fri, 03 Apr 2026 11:58:58 -0300
Subject: [PATCH v2 05/10] selftests/bpf: Tolerate test file compilation
 failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-selftests-bpf_misconfig-v2-5-f06700380a9d@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775228344; l=1733;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=r0hAi+8/1aDh2iFsHnAbZTWuQDE4t7kIxRdOWHyRr+Y=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHSmdYX2XXWlMXfc0aJJn6g9w1iqwLslrc2d73uxWf06LSA98AtmDYLZCdLQf748TjJDLfJfvWk
 GRJtZN4CeawI=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Individual test files may fail to compile when headers or kernel features
required by that test are absent. Currently this aborts the entire build.

Make the per-test compilation non-fatal: remove the output object on
failure and print a SKIP-TEST marker to stderr. Guard the BTFIDS
post-processing step so it is skipped when the object file is absent.
The linker step will later ignore absent objects, allowing the remaining
tests to build and run.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 72f576a8236a..6a3835a58f87 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -688,11 +688,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_TESTS_DIR)/%.c				\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
+	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F) || \
+		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
+		if [ -f $$@ ]; then						\
 		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
 		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
-		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
+		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
+		fi)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\

-- 
2.53.0

