Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF962798F8
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513530; cv=none; b=SeZxDSulBIzFEbR1/2y7wkwRIjIJcF1sg4WYPAvIHlApblHhgLaCsczSJDnx9QN0/I2/UFY+b3osWG2xqyDK+7YjZP4jcPSH2f2mPLayvSsuKSvBlo7BDdyfcV+W8adqz64fBs31GTkTqxcPDq4p40Qa7UIwu61f8jZPqu+htZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513530; c=relaxed/simple;
	bh=S/QF7/xcPW88oPsqR+fzOSq+0AZcH4QZuHxfczkAWdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1ZFrLV4T/uxnK8Z8yf/1l1Wwz+Y/R3h9WHrDfFUK7b6DrcTWegXdqBGbh6Sc0yC5D6wR4txocfcgm3uiyLI6MZW/JMYbnskXIy2Ap41cluC1jnMQqJO0VpJ6muKTlVOdHLYSIn+krg27pZEeDaWzPQci3h1uu2+m4oJNit2090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPfhyju2; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPfhyju2"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-c169ae1cb26so760332166b.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787513527; x=1788118327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jnKwW9pMZQp1g5u5XcXLRl5L4kmC5emnbT3tEjZfFJ8=;
        b=SPfhyju2s96mCtO8FNZ2BZJ/8BrW4dFtUyy/Qz9BvJPN1ooQCmyYvTXwv3hs4FX4Gm
         emWkOspathcsm5+ZG43axOXBuhqZToIXPDPGGkLPb1e9b8MTsIlLq30FAJ9rOX/ce8/w
         L1Usrfpp2XgxtAvI1Q1K79AwthiDwHJe+JyT4HA/w4Ej37i9qnVRsOXHwkytUArm7CHm
         /FAq0GBzsv/qd1DIAxQam82qfSMKvcFhrMlDOz1dlq/4NhqWRm1DvHhwbGSjagT4ZUAm
         g0Olgqe5FPyeqUoKaAN6rUdEbudo+94Dm/j106Fp7VTz215YgFvBOLc8ELecpa5wEWKh
         Ilbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787513527; x=1788118327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jnKwW9pMZQp1g5u5XcXLRl5L4kmC5emnbT3tEjZfFJ8=;
        b=bFFlraQeYgNMJQ4LCg19ZFiWZQ49dOH8bMLKZXPO/qIW85CgDvOZ6KGM7jy6/R1lkN
         cjfDOEunrTq5O/+hYUkqggmDHE+5VlDZYXoqrrFGyvSx/GgcfSo4v5ZNzXhP/NWAvdAx
         F3fxzyrJXXROgTkA4VSoCY6C0wVJCUrVFMBktZEUf3V2q4axPEH19DM9isyN5aWE694b
         z7E7LR9URjJTRe8dPNsbLTyFn/ouTsWBPNpMYf9dGGKm/WPFiqs8pp+kHMPMkESolPSG
         rbpzDSij8p8rh3vecvfrX46Pb37TsFkdCWdCiiXvozRMoifOePQUVkySpnDF5Tk3oHLX
         lM0A==
X-Gm-Message-State: AFuF++mMCGhYZW+T7NOEx7DRLYR3/JAJ3oyzttZsUzoDhjXE5ko5h4h4
	QncliBZBeTVoOZRWdqLetiZ520bpObHCHI7UmmQNOxqNz83JoKNCyzCDqm6q4SzB
X-Gm-Gg: AR+sD104zlbOgFp4Ktc5Wrj3vAUsbn4M+xb2XWZjYLiOH9ETmfa20NWQW9g+xIZwaDY
	EF3V20KLJmbrVr4DX/glP7oajZGcneXqzy0rTURvgbwlx6Dy/zaFDq244bBgMXjA2QPLzAxeCIa
	Lc63z17RjXUrT6K2HuhQiloVvXAywIxcbiHx7m/DOctbtYsXM6zhr0hyH9HDwctzT5R5DBjTw4u
	+/ECnGMHCSZ0YqE9jrTLhBJtjhBRuAExeAYdyk/6NVIiloVFkar4JD7YGYYWVuxwKzX3jIC02Rd
	oYUP0vInUGARBJGY5oiZb0YX2AhBwtPccYi5Tdxlnk3xzni3IqAe7CkYUygKXkPTtuMBFX6naRa
	JODa30FZtl35DeiueOwGiCLXzDu60cVSsjYPEjZG92eqfgtiNzrGyZqjJpCNClBEJYdgsqFrn1W
	90fZtlsXXnSuTagwJaCg3AVEDKj77RrRkI7y/Bru7QshhzWwOdiOud8LNulseeJzBoyxBBARc89
	hDxnL+5Q/h8PSU5GtvZh+p9L77MNkWmyDPOEBj5MKzr2cCnl6NC1v3H7ur+JH1ncO3s2/r7fct0
	KQ7f4gM+QnZpqBBCBqwx7vVijtU=
X-Received: by 2002:a17:907:a88b:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c244d45ad2amr2501227566b.2.1787513526955;
        Sun, 23 Aug 2026 12:32:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249672becesm919972466b.42.2026.08.23.12.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:32:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Cover oversized stream read buffers
Date: Sun, 23 Aug 2026 21:32:01 +0200
Message-ID: <20260823193202.2389715-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823193202.2389715-1-memxor@gmail.com>
References: <20260823193202.2389715-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=memxor@gmail.com; h=from:subject; bh=S/QF7/xcPW88oPsqR+fzOSq+0AZcH4QZuHxfczkAWdU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavba/6hIw/qD7KXSWzsCFt27dfekx8v+goIfT0u8WnOo bCdpj3zOkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRkgaG/2n3N33ts9y4099g pfTGmjNHq/i6a86tL3Ps37JA7OgUx2xGhr4q5a0my4p5nHb7Bb9PW6ahLfzjdhk/39oHUXkKQMc xAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise BPF_PROG_STREAM_READ_BY_FD with a UINT_MAX buffer length and
require EINVAL. Continue with the existing two-part read of the queued
payload to verify that rejecting the oversized request does not consume
or otherwise disturb stream data.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/stream.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index 4d8054a23cc7..74bd15c4bfba 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -46,6 +46,10 @@ void test_stream_syscall(void)
 	ret = -errno;
 	ASSERT_EQ(ret, -EFAULT, "bad stream buf");
 
+	ASSERT_LT(bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, UINT_MAX, NULL), 0, "error");
+	ret = -errno;
+	ASSERT_EQ(ret, -EINVAL, "large stream buf");
+
 	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 2, NULL);
 	ASSERT_EQ(ret, 2, "bytes");
 	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 2, NULL);
-- 
2.53.0

