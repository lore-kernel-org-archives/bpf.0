Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DF372067
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700907; cv=none; b=lcDZqkH9EQ4hxjcIEfddnLnq/+jbNQ7sBZUTNgJEzGJXMX8qJh/6pcWJW5+sIOEah4ioE2+wqznFh/2qlxrLsHcuYu2ITU6LI8CBzB9afkM8iV3lahWKFWSdptOUaUmJLMndoMFuzLFqiI973jorB/ibg4gbDSBsxtqy6MmkRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700907; c=relaxed/simple;
	bh=ga/GaeF7RQuXBAbWhIuVXHI6+3MN5+3NaqWQNfW6IEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbo/1JQjp2awzBDWYOXdO9UoNuYNcF2yLW+BQ3AZNhZPYYLn7AYJifY6Odv8DU1i43sF/mSNtE4FY22+LKk81IgOc2gS30QFXqsOfq6pekh9avCbMcby4HfijPYEyyQJdAHFQ2bm8+LKa/gLm+aJivZVnnz3L5RQHeWtup3Jy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3iQevEV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3iQevEV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-449de065cb3so6584895f8f.2
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700904; x=1779305704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOc+Skhm2gYZJKUxRuM/yUCFNYfH507QF3U6ghPOViQ=;
        b=Z3iQevEV3gGCSAJmVTddA67cB8p3h9in/wUoSRRxxUo4bzzdCdYyF7YbFWFWDtt/8E
         vAXAycl3DZH5vUp4rEcp2NtXLlaBSfEelooGipKqRCKH3Jsj1Oj4NuNY/3xsMZZofFB8
         YTbn5VnpM39xp/RDIAr4RUGijhQXY6yDZu6UsYYepmUpEU5LnK2ZpW7iCOH5Z70hGd9n
         hSAP0SEvWoHpJn03n4tE3Bb9hOkdhG56YiTf8gJnc0CDlvfbwUxnyQ5tf49LxyCTC1TB
         jWqFc/MrEmIu0n9mirsEkDoUR6FxubfTG8dGl5IMigINXTkVW+n0lW1gct0KFOD+SOFE
         ythA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700904; x=1779305704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOc+Skhm2gYZJKUxRuM/yUCFNYfH507QF3U6ghPOViQ=;
        b=CyuANfkkb5w09f79wOHCTMd7ukXNl3xw5Eqff5V/O0u+cNGJWAw6wzVTHrnNvzekmz
         SOQQN+KT6tr4E5n1uBsvHfZXBKqd1AOGsbEjJbZ2/lbcQj9DfqMXvzO1aGxVoijOj4zu
         vQHWf4rhRBk0+vKCmG4fQEZAadxboIN/XX87PhL7acrhIX1wJpBfCPtM9Rm9zMWScFvJ
         Zi4oY+rybQB1ewzUvSKw04jrwwD2tS8r9JGYjvqmlBRHtrENfjFu4NnRQ0ksXIbwR1js
         I0eK1kYmdjxKUvu4PuSHIhbZttSyW0XOBUbdAcOmfn2wfpZVq2D+BsibTJBJ2gqzVMx0
         5/WA==
X-Gm-Message-State: AOJu0YwSl0lROVevK32DZE1PefEssjahRwu4CoLbOTF8/nAGx948PgO9
	69SyDK9KzoevkmjhO0WojVN+BDd12Vi31o14PtzSrA7gMPxx9yUEhpUJnjZ5Mw==
X-Gm-Gg: Acq92OHOq4T9aR8EvlKOPD0fUXPaWST4cMGp5mX6Ei66Rci+q4E2WY90vOu11z6vPuP
	YbK0Z51Lavp6K9xJBf9wCdjW++wLyVzZfbs+XfRgZsT2dAoaqz94lJ7cM+ZLDmAvr4Mc7atdGAY
	sFb8jzn4rA8hdBkPR4Wj+cHJ7x8nxsIdYqxaX62j3EiR9AHoO80gcT4Th5kK9EgQPDJmFMCtdnS
	Ce4J1ScyJ09ccw2NU7FqXno6NJc99Q9/Nepy3w/yA7jfg3K4afNhXZKPAUjT0TyGDDNnKLxTNzE
	Fe5aZvXzQctAwNFDig5G8WPFkC3i0KCUWIz3gaLPWFG5eOoyJYAKUT3NgPGBn5FGI7VocxiBAfX
	5WonDvxm9xkTivKxgO7UJ+d1grGQ9YZ1I5kpWKIrFPJznWFO+vyGIP/bwVXDCz9Jhh0uyQ/vcLb
	RWFndMl05NT68M6OZ9SvPhMgz63ouV36gBCmc81NI/cSR8E7tRglqUm/9DxRqPxUBMNgIeIduNH
	gDK2ojA6cFu+k6fnBOCQ/WK2kT+ZV0upeVYX1xdhi/sWH6n0vQUMikEP4HApzMHffzOTNmSzNev
	uhcZMK52bQweY/a9yJveFSjAorNH0jGOftEl0YDq6qQ=
X-Received: by 2002:a5d:4cc1:0:b0:45d:77f4:1ac2 with SMTP id ffacd0b85a97d-45d77f41c2bmr1619023f8f.0.1778700903992;
        Wed, 13 May 2026 12:35:03 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm1104017f8f.20.2026.05.13.12.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:35:03 -0700 (PDT)
Date: Wed, 13 May 2026 21:35:01 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Test reported max stack depth
Message-ID: <075d22efd4338385a92f13b7817025cc3f04ec60.1778700777.git.paul.chaignon@gmail.com>
References: <cover.1778700777.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778700777.git.paul.chaignon@gmail.com>

This patch tests the maximum stack depth reporting in verifier logs,
with a couple special cases covered: fastcall, private stacks (main
subprog & callee), and rounding up to 16 bytes. For that last one, we
need to skip the test when JIT compilation is disabled as the rounding
is then to 32 bytes.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bpf_fastcall.c   |  3 +--
 .../selftests/bpf/progs/verifier_private_stack.c  | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 0d9e167555b5..8d7ff38e4c06 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -799,8 +799,7 @@ __naked int bpf_loop_interaction2(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4)
-__msg("stack depth 512+0")
+__log_level(4) __msg("stack depth 512+0 max 512")
 /* just to print xlated version when debugging */
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 646e8ef82051..2c00dd8579d1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -86,6 +86,7 @@ __naked static void cumulative_stack_depth_subprog(void)
 SEC("kprobe")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
+__log_level(4) __msg("stack depth 512+32 max 512")
 __arch_x86_64
 /* private stack fp for the main prog */
 __jited("	movabsq	$0x{{.*}}, %r9")
@@ -324,6 +325,8 @@ int private_stack_async_callback_1(void)
 SEC("fentry/bpf_fentry_test9")
 __description("Private stack, async callback, potential nesting")
 __success __retval(0)
+__load_if_JITed()
+__log_level(4) __msg("stack depth 8+0+256+0 max 272")
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
 __arch_arm64
@@ -344,6 +347,18 @@ int private_stack_async_callback_2(void)
 	return 0;
 }
 
+SEC("fentry/bpf_fentry_test9")
+__description("private stack, max stack depth is private stack")
+__success
+__log_level(4) __msg("stack depth 8+256+0 max 256")
+int private_stack_max_depth(void)
+{
+	int x = 0;
+
+	subprog1(&x);
+	return 0;
+}
+
 #else
 
 SEC("kprobe")
-- 
2.43.0

