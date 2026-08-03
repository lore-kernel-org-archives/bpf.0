Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5B39DBE5
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742061; cv=none; b=X3bYeLRmROxZ46MiAtVYdvpNw+1rq2A3s55BfeWBR4GyCHi4/Q5WcJvXzfEHuloGDTJO4XUfc9vel8PsvmlIsBBuX9jc/mAMsiU2ix/+qundMvHtVbym7r5j2txx0kLGrVvi/UX3C8FJEChPjEDkaceQ6gNDSagcPEw7SvV6tdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742061; c=relaxed/simple;
	bh=YaD6RUxbooAFyVNAUjaitE6hvIlZXLimx5nLk7lP1Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqFP6CdiXiapXCWhN3E0KAfwpu6DfFQeLeUyc1Ek3BX+xPKy4+GFgWrcWOwu5xqeRckLVomC9M8+Jqjt0b1arXUt1EiL+oCVIk69156rZSEWvdV/Fkk6CqpjRw+SSthdV3liPDSojrpP5YLlEpQNEF3zsm5PYibiZtstwcidmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHHWFxTe; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHHWFxTe"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so2442185e9.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 00:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742058; x=1786346858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gv9RWj0Z9j7Vt7yBHkmCGBMZ3OGPiuLSZW3DpjJjkHQ=;
        b=hHHWFxTeZaVI0zqUgDJwXn3FqDbcUnc8S4lqTWPCAId7XYtKpvB+2UsUb/eimzqat7
         OKNEvM7b9oZy/LPXFrygsm4jDsW+a80guOQAfjvNluAXpdilEKnpEsQNeJcfgQDG+aCV
         w8AvpobJeAonc1j1RB6YILLZ1p0WYRUaEsxrUe35ZJwEUUyy5qnwF+gEBiNHjBQsttgw
         oqF8AWIKl74Hvgo+Nh3zKdmssVT5Gx9XWinzImr3vjmK2rR7pN4MlWtgl9vU9J6ZbaIa
         YrqImNfwr0+bprFxRp/0yYCY16df6WrMSPdcBxl/6I05R93yyNM3/7Z26RVKb2aUeuPw
         UmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742058; x=1786346858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gv9RWj0Z9j7Vt7yBHkmCGBMZ3OGPiuLSZW3DpjJjkHQ=;
        b=ZivJ99YH+45HAlXBdPlAxH2s8qrTqyL7ObdCy2SwoGTQ6zD5Qyre/j+6T1rwBDM+S0
         YADruRPs3g11gXoOFL6wgdGQVodfuNeX/eIaj6LNnihm4X6C21Eo6v9Z57KF1c1sKdI/
         pUtr4WSKrVu1IYK5CpjyiffVt3QPhlT7VkmTbhDh5nZl4P8cw0OyjdSbz5ZJZ7rjGTPr
         t83FJKADfEIqj8k7v5FKDnLapI1cIGRt0jiCxzQUWToXJH3ZadJ9atNnAJJBW1ZYc/qw
         LE+tWO6fkqsfho13JSNHEm/AFjU9uC8UZW00TBSwRNTPJpYMXiKA2IaHGuJKJniXR2DF
         GM7g==
X-Gm-Message-State: AOJu0Yx8KGEm5kxx8kByUq4nthEHFLdtWjGGsaQtNqHDl/lyZP6wqRJe
	k1fXG7/VBy1L7hx3OqIqKw5v5CULJIdnogtkvf2lx73j1+xE/PJ33a0Nqy/HVj9C
X-Gm-Gg: AR+sD135ataCLsMnAKTDPIsqtMw6GFqrBq1Rt1jRIWoW2p/FEBxgxd4uqQSnwadaXCn
	ROj/j8X4dZwXC1N/QIZMSFUKXsQ9jb0/Giv/gdG5SrGEqTuPtc+wUkLo7/tlJ0K7tfwwjPDIrih
	UMS8Y/As6KRClNDGyE+00N+ZK5KV644FJarqlDW2c6GlxlatUTWPOJGjOcOPoWfsCSN81TZF2aY
	sWB98PN42OfZXsz+KLdK/zEo/jXpQKvBi3a53p9Z5wNqWUuD8WNmbOEnQcfdDfjVvu+CiRYQ7uf
	aOuG3fo0hmOuu7CZtDTV3S5eJCphj61EAFiSUejFHghZluE1EKXjgZ2OvIobZnfND06MhX/w3vE
	invhv1ilNUsO12bTfihPF+2ILje6aikOm35GrFHh4Yrn+js2PTi7UgKstTwNBQwi4RtUSg1hs0y
	owEl6aL5rMQIVRni4KNmPfmxwk+fIMvYTDc6LhM1PTyYemGDJQJXDtZswQ3jfOv6wV4S5R3XUGK
	rhjhcGojGwipMcYm+xf/s5zAvHT9zSAdFWiKIOa2sPMQscXoGHtYMMWLkCYsOPJ3AaL2OZP83sd
	5ssboGUTOAY2P4jNFSJNHebImHI=
X-Received: by 2002:a05:600c:e48a:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-4980c66b53bmr128371945e9.4.1785742058027;
        Mon, 03 Aug 2026 00:27:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562667sm32210120f8f.24.2026.08.03.00.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:27:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Test stack depth stats without BTF subprog names
Date: Mon,  3 Aug 2026 09:27:31 +0200
Message-ID: <20260803072733.191502-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803072733.191502-1-memxor@gmail.com>
References: <20260803072733.191502-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=memxor@gmail.com; h=from:subject; bh=YaD6RUxbooAFyVNAUjaitE6hvIlZXLimx5nLk7lP1Nk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavA6foL69MJM7x/9yziP6YqeZShds0rzb2K/F+rfCP0p 53bEbelo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPR4GNkaOAo3PVaxuOJWEff 6wOt/9eHzduk7qXE//r9Wvfb9eHbDzEyXFP8fS+zzJHhg5+fzUamUO2ZxyUUmY4VvrgZ/ZJb8M5 FVgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Test the stack depth statistics emitted when BTF function info does not
provide subprogram names.

Make VERBOSE_ACCEPT request verifier statistics so the raw-insn test can
validate the <unknown> output without a test-specific log level.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c  | 2 +-
 tools/testing/selftests/bpf/verifier/calls.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index a8ae03c57bba..bffb7360434c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1560,7 +1560,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	opts.expected_attach_type = test->expected_attach_type;
 	if (expected_ret == VERBOSE_ACCEPT)
-		opts.log_level = 2;
+		opts.log_level = 2 | 4;
 	else if (verbose)
 		opts.log_level = verif_log_level | 4; /* force stats */
 	else
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 8cd626e04551..14f6f260b88b 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1091,7 +1091,11 @@
 	/* stack_main=32, stack_A=256, stack_B=64
 	 * and max(main+A, main+A+B) < 512
 	 */
-	.result = ACCEPT,
+	.result = VERBOSE_ACCEPT,
+	.errstr = "stack depth max 352\t"
+		  "stack depth subprog 0 <unknown> 32\t"
+		  "stack depth subprog 1 <unknown> 256\t"
+		  "stack depth subprog 2 <unknown> 64",
 },
 {
 	"calls: stack depth check using three frames. test2",
-- 
2.53.0

