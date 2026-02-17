Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89352E8B6B
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319218; cv=none; b=UGlFo7/WPdZQKx+K9+kVHGyqRHu83K52Gxl6h4om6jTneZ+svaGi8N/qCOtBJ9xaHhwk7s/PJeluE6FPcwT6ALVM1rLbCyw53pFXU69xdmYhdn8/h1dyng6hvT90bZbjumtkoJgcyW9LBl+o9WqIDGj+ovIn2QJYiRfyrn/qEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319218; c=relaxed/simple;
	bh=8Z/5xQJogn4PCXVi6Ge5CBud+58/C/qSRRK2JaNVZpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4ocwrMOfDTqaRqwu0PKk0d+kimTq0vVs5MrqhYLb0Vbw0bY24y+pn+RfqevWHe3WACVVP8+DKGimDIiiXnn7JUHzAwHyrmMEb1rwAmA2ViutxOxU7hZfz8NvKyibeXUsWunrQxV1pLozUnicKtIzShKUh3k78ytKgin2I0jDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOSrtDzn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOSrtDzn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso55471105e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 01:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771319215; x=1771924015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1I5+1IBudiYzksoOwHs3AfoJeyidY22mYlMEJeVcBAw=;
        b=OOSrtDzn051oTyW4qKkBY8Fj0k7ugZj4SYkys8kokk2upuMnWuMbU4GVoPMy1/QNJj
         KH+5m/tdey6zzDstG6651Q7hl+nIges9iHxUTElHLZfGDO7l5Ykq7ckCrVFqnk7xzHm9
         /niPaq8r81/eXbxSm8kJmTkQUP8iFKdnX2ONi8hY8Q3dccGYzAnwX1pFmyvYC715HGEC
         NbGbvFkxOgRXBiRqkj8f8yvzCvNQ67fxDGiVNN7iuxVVo230tprK47ZTEqOOFzSsQ9Jq
         GPLncWz6na0flak5fz5PA4H6ZU3+yBGekeSbkRl+IpON5i5w6VN4Swi87NKkn4F0M83J
         j5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771319215; x=1771924015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1I5+1IBudiYzksoOwHs3AfoJeyidY22mYlMEJeVcBAw=;
        b=sE75vP1EDFz/Ej6AV7bW2T/nBDJCLJ4U/yoQdhOQwEVwThaQj4ZUkxPhXoXAcPyrSo
         /Lm2/bUlKeUT9NYBGQt+NQjkhVVwec1RHusVG+i/qldBCXoo6s6wEE8sph4Rax3xFSdj
         SJOXIqZcLVqibHR5BgmmWPNVaSSkdzH2wkwmu0iPwUkwsxq3UAUkLUi/fim8oTOmUA2K
         2K5w3c7kyi0n7mfRH0KbXIttPcbvQqUn/1CJWkEFh/A0D1up2X4uZphmmJoGwZzjKLJE
         1Q/XN5vpqU+P0Mr10L2pt9LQnJueXmQ5yKe71wCTk/wryW/Te8QgTTa326CoA9bSFbdS
         Rzng==
X-Gm-Message-State: AOJu0YyvmSar4rsjrv+lhki+yZfCbwqDPZo0xwLqSRCtF4lagHfDsPTz
	wlWqWO182QCxHTuuBJ8OeHFLXG/MHKGMeW7Dex7XVJ2CpQ5WfSLX7/2GMniutg==
X-Gm-Gg: AZuq6aINvDBRhcupQtWdE2h80tK0yVt4Al1UzssoasAzQpxE2B129dLuDztKmCFYisk
	BQ6A+nLESLuizBD3H9r4vGgeV8prKHZtAkuRn/JGjVWM86x4ZZRwfo9OItulyRD9x7HU6D/nss0
	kOR9uWkIgVK7hMFeD20QVWYMcY/yHXi5RIChWpvntIBSuYx7hL0QGdxgzzyjtG/veQGb7Gl3qXm
	+JEEobtqUjJ/6zyas2HqwXEYpSDm0kEGEb5BjsfUNZHeP3rorIJnlOW3FJD47Hkqrt//t/Un4UN
	Z/ZgxGoV3qpR8qphcjI3YYSFk5ojoTrysec6j6NPcOyJ5H4PUlrJm0i1ZEla7inZsOChkbP6BPG
	132iQDzVdEkIb4JShq67qS1nzCaz2yUTE9hiHnubHaVQsd3iC9k45JTgvQfpj6H5fBm3Ea6v+hE
	rZOF5MpqsgML6c8gGLXuul6OdY+uIC6EZlLWKw/s99ca4GdH9MoBCLMmmTLYBs9HoFAG+rj9Iid
	qZtF0pQHTHG6Mm2aDX5quoYlnRsCMOiqv9LpquvrxzitBFvfNK6EEE7e81TXBENjTMixDTkekmV
	+2kKIBBgfMw=
X-Received: by 2002:a05:600c:4753:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-48378d9cc6dmr215510575e9.11.1771319215070;
        Tue, 17 Feb 2026 01:06:55 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e003025d1eb71f3ff18.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:3025:d1eb:71f3:ff18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm486759105e9.14.2026.02.17.01.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 01:06:53 -0800 (PST)
Date: Tue, 17 Feb 2026 10:06:52 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf 4/4] selftests/bpf: Avoid simplification of crafted
 bounds test
Message-ID: <95c0981edba1595c029373c98f83deb35fbc5c73.1771316309.git.paul.chaignon@gmail.com>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771316309.git.paul.chaignon@gmail.com>

The reg_bounds_crafted tests validate the verifier's range analysis
logic. They focus on the actual ranges and thus ignore the tnum. As a
consequence, they carry the assumption that the tested cases can be
reproduced in userspace without using the tnum information.

Unfortunately, the previous change the refinement logic breaks that
assumption for one test case:

  (u64)2147483648 (u32)<op> [4294967294; 0x100000000]

The tested bytecode is shown below. Without our previous improvement, on
the false branch of the condition, R7 is only known to have u64 range
[0xfffffffe; 0x100000000]. With our improvement, and using the tnum
information, we can deduce that R7 equals 0x100000000.

  19: (bc) w0 = w6                ; R6=0x80000000
  20: (bc) w0 = w7                ; R7=scalar(smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  21: (be) if w6 <= w7 goto pc+3  ; R6=0x80000000 R7=0x100000000

R7's tnum is (0; 0x1ffffffff). On the false branch, regs_refine_cond_op
refines R7's u32 range to [0; 0x7fffffff]. Then, __reg32_deduce_bounds
refines the s32 range to 0 using u32 and finally also sets u32=0.
From this, __reg_bound_offset improves the tnum to (0; 0x100000000).
Finally, our previous patch uses this new tnum to deduce that it only
intersect with u64=[0xfffffffe; 0x100000000] in a single value:
0x100000000.

Because the verifier uses the tnum to reach this constant value, the
selftest is unable to reproduce it by only simulating ranges. The
solution implemented in this patch is to change the test case such that
there is more than one overlap value between u64 and the tnum. The max.
u64 value is thus changed from 0x100000000 to 0x300000000.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index d93a0c7b1786..0322f817d07b 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -2091,7 +2091,7 @@ static struct subtest_case crafted_cases[] = {
 	{U64, S64, {0, 0xffffffffULL}, {0x7fffffff, 0x7fffffff}},
 
 	{U64, U32, {0, 0x100000000}, {0, 0}},
-	{U64, U32, {0xfffffffe, 0x100000000}, {0x80000000, 0x80000000}},
+	{U64, U32, {0xfffffffe, 0x300000000}, {0x80000000, 0x80000000}},
 
 	{U64, S32, {0, 0xffffffff00000000ULL}, {0, 0}},
 	/* these are tricky cases where lower 32 bits allow to tighten 64
-- 
2.43.0

