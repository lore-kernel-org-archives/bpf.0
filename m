Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2133C9ED1
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228383; cv=none; b=V9VQ9UH0riB689RVTCX4N9sOImJ9BpEnJ1u5ag6jq3RlSg5EWPUXNSiIcRK+LxQG1mBTNuunXY/d89Kho7h3fkNclNRYxq56ahqxKRLxti0FHWLfrCNlbGW1DYs0JaLBOxJBSRmf+uU1VyFVDo6Xd2rpl14T+7ctfeZl5F+76aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228383; c=relaxed/simple;
	bh=2f5aVKepAPVQ6QAMkIjSa6F59NytLhs5Yj9FO1U5vIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lt98pStB6JiIiNelm/kFiVwQwujJjdEI0SgbRft5PqEddFZYGR7tVpLZTbKIot1BpZrTl2lt0KLB9vsJizXOhDgAnG80ymXOJtEBik8ldiRPa5Hy7W37zckc/q8ImXKG3isWM95Hqsde4pV9VdPq+d3+hX4ZnVzMKAVyaMgkE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M44yLjcd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M44yLjcd"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso20035075e9.2
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775228381; x=1775833181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKDIAWuRtDFHvkwbDQCWFyTrBdJA4yobh9R3wJFKPAY=;
        b=M44yLjcd4xdUMfEvK38gBToCy6MKax+3a48F6Kf7Zlai1fONTSxypNlO/fUayY4Teb
         E3i9nL6KBT9zun8weHYKM0pRnrNEUHR2BPn39fHv622qjhtrGdk7gxjnTACJVbwvS4iE
         IjxO1B40+YcBi81fUmo3RPG1xDld4/6rQQMceeBKLzLQfxmNeXkTSl84hsJsAEL+ISCE
         nj97LziWU0pevU/WWOCk2/JMMsnqhb70pJFlTCfEx4WYH0cLfDC1O1+wOIqsxLal9Oy1
         f2EPVcIuJGXQupoGVtyefbdsfdAqCXinL9oub9YDmMy/I2KiISwmaCt7mhkM4Y32kuSE
         7a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228381; x=1775833181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GKDIAWuRtDFHvkwbDQCWFyTrBdJA4yobh9R3wJFKPAY=;
        b=bmFqiU3nn464ymNaBLIGSRCrAG7VjXoFMNEwvPCiUfGl142ZgJjzEKmlXPUMuVG48A
         kdFaxO9znNyvo7YQQMxoZyk3aeRK+PbcWKHwi5GA3Qb7dyDEe6SuS/i34j/lld5v7cgx
         zP6JRj4glbvhiRs+Z1aL8R+J8T76JRwSCG5wP/ADHPjpowenR6pjTTRGBubkrzysK/Oi
         nJr5XiqIjk70Yfmh51BlOsSJ14XKyh2leoiHa9pXh3hIhjDWqiCkC9dgdULwPMGRLNFq
         vXB5m1KQO1tqOwbmEExcwg9mWbWNgy0nxnGyndFEorD/dTKRBrwZc1HhK/K+CseMEcFL
         qsdQ==
X-Gm-Message-State: AOJu0Yyd7cqXdnjj7iI/rI5BVnWARh51oRK1fTOCHfzyNubuURerFTco
	HMNlm1UrdtOIpLc9csPN+i23TZilRVewtDP/6II2xjAQYmUL8voaaklty4BS5N2DqzM=
X-Gm-Gg: ATEYQzzOT20MWmA6fHZulTUpZGfIEk5DKdWzUTBE29y4+fcv50tMW7TvhU4TZc5iHrt
	Lf7aT4MNY25dlxXQ34cQa1/Zqzg1yoZydjmoD0xTSmA2paM7iHlMM7+Shd5er3pJMZxA9bLZocm
	pT/obu/pH5iWSAfO0CkoTqJGqD3wmlydlFxdGViRvBLKt/A7kwatPNgiwllV7mfR64ZNnAnnDMg
	5lWWARDQ0ILrXhBjFPkBwzkVbg9b+iHFFYQmfo7NCKWqiFaRP5sYcvzOwD1GBQdlcKm5//8Ox1L
	mMs4eQS/M23u94h88nfVPMnlSdV/v+RgAuTL+IN+HpqGgQmB2TGaqlCivkqGFR7iag6shXe7a6+
	Dvy+VlgZeqsC6D9EvyBYSaY4hsiIZSd+H5V1/eAIKGXy0pkEDEAnZToOE2eqqe+Z3I+XDxSJkFU
	8BeUp96EOQ
X-Received: by 2002:a05:600c:6092:b0:487:288:1199 with SMTP id 5b1f17b1804b1-488997dfb41mr60010355e9.28.1775228380694;
        Fri, 03 Apr 2026 07:59:40 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9cbbasm7312493e0c.9.2026.04.03.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:59:39 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Fri, 03 Apr 2026 11:59:02 -0300
Subject: [PATCH v2 09/10] selftests/bpf: Skip tests whose objects were not
 built
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-selftests-bpf_misconfig-v2-9-f06700380a9d@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775228344; l=1739;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=2f5aVKepAPVQ6QAMkIjSa6F59NytLhs5Yj9FO1U5vIg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAv+Ss+JdaUOsPfoNWBRS+cKg3MWINgTH7ahWzB/w2k2cSu+EqYkRVlvI0zjzESS22puaq6LMRH
 B1yX8kJ5QIQ0=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When Kconfig options or missing headers cause a .test.o not to be compiled,
the corresponding prog_test_def entry in tests.h has NULL for both run_test
and run_serial_test. The existing infrastructure check treats this case as
a fatal coding error and calls exit().

Separate the two failure modes: having both function pointers non-NULL is a
genuine coding error and remains fatal. Having both NULL means the test
object was intentionally omitted from the build; mark it should_run=false
and continue so that the remaining tests are unaffected.

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

