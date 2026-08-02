Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6370366048
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785711136; cv=none; b=qdBcCgy1E8LKrxPSDxfys0gNE4znM4V+5zitZI/E5dEtAo579gKMqvUJcojeDmRs6meesOm8ANS9ia00MczYma5FpBiLkVBB5Me714TIwMijk2PNE8oY0pgU7Y4dFLIlnPbmxvOQnIj4D4p4U4RAVtaAGScXGxdHTA39tpBYV3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785711136; c=relaxed/simple;
	bh=YaD6RUxbooAFyVNAUjaitE6hvIlZXLimx5nLk7lP1Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIrbrkQgY1rkmTwjeJvyNMU1mxSdzx0vJgJGmyYc9PujP0+XK0VPvc8Db1FIpWzZNOX3sTLQo41OxvdKcaBq8mAZhN76hxrI+ZBxhqLqDUAYlCzku28/EFnjYCNE9bVjJTQZSQqoaDnFreSV1qk5r4W3tnJWackobMTa8DtqGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sff2mydm; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sff2mydm"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495473da596so611755e9.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785711133; x=1786315933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gv9RWj0Z9j7Vt7yBHkmCGBMZ3OGPiuLSZW3DpjJjkHQ=;
        b=Sff2mydmcg0pGsfNjPII7+gFwebV2yxl7kMlcBsyn5EkwZZFcsjdrB/SSt7IDPyWnm
         M8uvbyBLrhB7otrF52OYBPLGBTvSrXoa+tgVJyu2/kEqstntUUioIkzh6gQyOENUrTk6
         y7EhZGQVmYg27dcgDe9D3VWmCi3fPsCvCwb2NOqlRHo+HGuzEmtjJ8wcwKuPHIw+lG9m
         EyKvWr9NOmvEBB3lgGs1xwCV5yWLeldn5ooUxvNWPHMAg5BJCIdvSIzAimgN56b6Z4SP
         iFKRE6mLnQOXYvaEmOsdJJQc+h/ksMEiGcWVgG2AbEV5evVGP3enHpbuU2lh70CfcSSR
         0/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785711133; x=1786315933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gv9RWj0Z9j7Vt7yBHkmCGBMZ3OGPiuLSZW3DpjJjkHQ=;
        b=GgLWwtWRNR3/+4H/Jypznjz24lDNGb6xGLZbn5VdPv7nSJQ1g+EfQwJBuge8uKHlwS
         0Enqq5Xe2lbl8q/+lMckrv4eO31+thVMcdW5rPhtBo3soyicm6SSUEZNYRb4IzkWJtVb
         gV6EM+a9WbBqdwN+KUZM7jZ1+ANb0N7nGOIM7qneCvL5KryGZJy367rdqlna3w7rVYt8
         pcvp8y08s9gJ8hZawyLX0dHLKdYCCnkLT8t7QFJzv1Blni7PfURSrDrMe8U0s8QzErlz
         U4Q/3PJSf9U7TBZjhLCWhgZGsVoAUwthdgkkRnSbsoTp6roGWd7MFNtG1mJJOweO9nsM
         EyLw==
X-Gm-Message-State: AOJu0YxqBPZyKzOTLmU//vET6QJp5ZW1cUa1HtiZuhp0p8hPMn90TCLL
	e7rme2bBCU/2LyFemFBYtMCwsTZnidpVJXXkpzAbHyn4D/ttdFYxuy0lmKE9Ao6H
X-Gm-Gg: AR+sD10+moBnQcL6zc1nhhgWhVDGKUxtNtFpC980TtdEeMtzBo1MIpFYrnG2IehCyjL
	IH3ZkcR+9E65LKL/tIWLpZJH3A24NSBhA6zAEG2q5d1AvG8r1iJtrBvOMVyqTO2rlTOksKuALaB
	BCpStg/pOVY40s0zwBN1V83O5kXd9nurqvxSMm11gA4kG330OpgpAo6ejCM00wQrfIoOpHGXMOl
	f4/XFiOGB+KnB+KNCS8qPxvqxuOPmKUHa6ayWNJVHS/dLl5ADvE4m7L3mmYBvNygiR0Tw7ZDL08
	uZtyAm5Tf510+fDi+eCSc7aACn+nsHaKFySbTSTbfvzhV7cdsR9XDayRK4ob2iF6Of/jGhRWrqy
	WTgl0ADz/jwgICF3fQKRR1bRc2rMqe5Da4Kf27VgC0VUL9QnwSXn/lRTu8PEvAk6tewmxLFRvP5
	slo99EjLleP/pWo4k21z9tCQ9FFE/cUzHhmnOtN4l1O7yilXlQcKy8FqOt8AzksXteheEO3PiYw
	1tVyAgXWKcqi8OCwhfWnM+UPy4aW+2cs+0OslA4szoW1d3AC35bXSR+v6gCj/joJcb82BYf4Hr8
	c0GVP/zjB0hKom0iSl5oY3nz7no=
X-Received: by 2002:a05:600c:46c3:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-4980eb8d081mr127113035e9.1.1785711132996;
        Sun, 02 Aug 2026 15:52:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808191be8sm260447085e9.2.2026.08.02.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:52:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test stack depth stats without BTF subprog names
Date: Mon,  3 Aug 2026 00:52:07 +0200
Message-ID: <20260802225209.2511758-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802225209.2511758-1-memxor@gmail.com>
References: <20260802225209.2511758-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=memxor@gmail.com; h=from:subject; bh=YaD6RUxbooAFyVNAUjaitE6hvIlZXLimx5nLk7lP1Nk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISv/FMML69MJM7x/9yziP6YqeZShds0rzb2K/F+rfCP0p 53bEbelo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPptWVk2PvjsGTg8dSo6qtb NK73xe244yLX7SGez74vQ+Bqn7HjJkaGo51vtL1lOGcfuNPz7sIL9zVyNacVdu9QXOHLsEB4r1Q mIwA=
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

