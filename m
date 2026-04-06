Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D663890F6
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491928; cv=none; b=SsV1dQLOKiOFmCmx+Wv0PwKeG9AknwHhMi41ugbksT3491SfixsBO7XcjfdWO2r0mQ3n0qF3qnAAIJD0SLScEXOh6wpwb+h6SQRXqTPbXxEG26tz7ah/uKKgMBSEwCoPVgwcoRJtEWApUr+e777BZZ6cDAmmqhk54zJQ17GnnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491928; c=relaxed/simple;
	bh=NO40hlT3q/UQLTKYN24Xfp26cxU/OmT6kvT04yakHR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sw3beS63FIk7wWJQpV1FqiYfQ9PLf+bA7tps8mBx7TLA75R8iuV7NI/MfKOa04BJOiCpRlKoPPf+bj01M8KBpVz8GWrrmKcWH2eTbuZ2cVQeTNUv2RQbaLcZ8wv9GV96f2Jud0XRDJcvFkZ/CLsvU9U3aCXlAuwHiL3xnz7KDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ETuy9xz7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ETuy9xz7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so2127085e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775491925; x=1776096725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atRPErzIDwCuTw8U4bY1TIrRJ7Ayq0ANPp/cVJlRlp8=;
        b=ETuy9xz7zHy1IbiWvvxnJo0I6zXb/SgscW/9w/xlKEHW3yvUjO2w2ua4nFjiTN2Jrd
         euA8F29GnskzGt4YzUjBCLSVcnJFPMhogzvT5WCi1eo+tFRu6JGOiw5fthAths36GryZ
         jxin1r0x8w8x+rC8ijelcI6GPG3unqFtneGQhIR5t0swaCcYqqr0sp0FYsVD1CXxTxpc
         AZVE5JoQvToQkjMyDg4Unt0heePqBj0yi14Q6QD8JnDI2OcaT/M2YwK9A3u+3PsCyOD/
         cyj8QQQjfVKyU8Ky26TEKX5D6A2jLlTuMSpGnRvkg26iAgnberWac3QE06ugy0k6ou2e
         y/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491925; x=1776096725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=atRPErzIDwCuTw8U4bY1TIrRJ7Ayq0ANPp/cVJlRlp8=;
        b=T7Vx/+CNFHerYWjR/6ui3EFHDwX2DEd8JSr5JphO1UqACP3LkqNSXMNrFXJsHEQTE5
         60fAY9vXHyxPgBBsLJUK9jZYIXCtZ9sjOtotp6oytWf9QG4tpiBq6wro7Y5D5XSnCDJS
         lIiBaDkHqBipzPhEKOI9GD0UDsWqHjaPc4Cy7ao/8OdOrVdniuhZ3A7+/I6aoUnL7yI+
         mZeOSEQtKOdQES4EKoZRz2PfyhMWgNbnCxSGFRXX0oQT9ZxE47D8DuenGupcAJoYSZg5
         ENyLFll0EPhPDNaRqFh6AGu4/e/b6ev54ZIKU4M/sPzWopZT2cIgcCtyz0tuMC7s5yuq
         OHxQ==
X-Gm-Message-State: AOJu0YwM+I0WunJIjRYx2hJvOmEDU321j6WgLiVA8+LFf0VJINy7P60c
	izcgoGC5DiCfYRMNvFh7KOzHhGnVHL65bca5VnS3/fF5FwS1EA8UScNG27rG06ARxTEOlIXj0qp
	fToPQ
X-Gm-Gg: AeBDievUVE24DpTx9B9jdfQeoSmFe4OsESlSMBdPEHOxCysYz/lOPyjn8HkD9oj3Q1/
	u6d/f6zi6CrUVw8WAl+YgGysCEDUvaarMYhzb55zwFKgYMtJw7VN35EMjDQBX2G2ZeU1AanDqtA
	K49UWhXNPVK9+nbZllQd6UjCog7NKvXGyR3VQLw/PHPYJ2mbVBMRAcN8WLSF/m9hlBr2CbPQheD
	9UTgyU29LXO58hF+9DJENt/zszfvTJqNoTb+hE0P231z3Uoy8X4Bu8wQkUJXbPkTY9zIIg++eEn
	qtgxORdPbrOVJLhnVnJOd1AxUJBlKfgewLtJs3PMtGtHgcOYo37UblvelwK/EzP1F5qS6aPO/re
	k6HV77iBw3U5w1IpuQY6dD2R8mm4zmGBj7XAIr6z+FtnGmF69Rj9Cq+wJ6eGFYQOoJWJzEcqtk4
	8+IzaxwWZuYZs+
X-Received: by 2002:a05:600c:3acb:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-4889972b76amr197342355e9.13.1775491924916;
        Mon, 06 Apr 2026 09:12:04 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e730e9sm17177979137.6.2026.04.06.09.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:12:04 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 13:11:32 -0300
Subject: [PATCH v3 10/11] selftests/bpf: Skip tests whose objects were not
 built
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v3-10-587a1114263c@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775491886; l=1740;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=NO40hlT3q/UQLTKYN24Xfp26cxU/OmT6kvT04yakHR8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBcPqnkEcBf86Dx9YUH5f7oorhjFt+yo7AGaRuOZT+r9Mmky2DTUhYKYG5fJM6/muLiwdhDW948
 UdoUfl6iz/g8=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When Kconfig options or missing headers cause a .test.o not to be
compiled, the corresponding prog_test_def entry in tests.h has NULL
for both run_test and run_serial_test. The existing infrastructure
check treats this case as a fatal coding error and calls exit().

Separate the two failure modes: having both function pointers non-NULL
is a genuine coding error and remains fatal. Having both NULL means
the test object was intentionally omitted from the build; mark it
should_run=false and continue so that the remaining tests are
unaffected.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_progs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 0929f4a7bda4..85ac25a51a8d 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -2022,12 +2022,15 @@ int main(int argc, char **argv)
 		test->should_run = should_run(&env.test_selector,
 					      test->test_num, test->test_name);
 
-		if ((test->run_test == NULL && test->run_serial_test == NULL) ||
-		    (test->run_test != NULL && test->run_serial_test != NULL)) {
+		if (test->run_test && test->run_serial_test) {
 			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",
 				test->test_num, test->test_name, test->test_name, test->test_name);
 			exit(EXIT_ERR_SETUP_INFRA);
 		}
+		if (!test->run_test && !test->run_serial_test) {
+			test->should_run = false;
+			continue;
+		}
 		if (test->should_run)
 			test->should_tmon = should_tmon(&env.tmon_selector, test->test_name);
 	}

-- 
2.53.0

