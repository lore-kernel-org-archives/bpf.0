Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2BA348865
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595920; cv=none; b=SGfTvT6wK7OZz5BxBqfLCCod/QmA13MN/o1Kyb5RUZv/qmIv6XeY9ms0SCFa37qdx3zUjTfGUSW4iBs6DvjSffIGS0RMfWZV+SJsJcpNjzP3sT/152KEjDB3828xgaivSkPdQWoVb0Py/Ez/KGyvIXwCSlkY59PHW9UUklsk2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595920; c=relaxed/simple;
	bh=8Z/5xQJogn4PCXVi6Ge5CBud+58/C/qSRRK2JaNVZpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGRwmfQRDRgGjoOb1Ln4mOwtUbGrXKqO9boy5D3hcXl30OGGWDc2sGkkG/UNBmvwafGSY7O2Ze9FdZIGl1FjtkyO4xHefvdDJGLCnVqvCrLbc2w9fRnk+aAYEaF2m3PHL3lQZQHC2ADR9UeIayP6M/mOmwgM5S5baw3ZuFQx3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjhBhdDq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjhBhdDq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43638a33157so1973644f8f.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771595917; x=1772200717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1I5+1IBudiYzksoOwHs3AfoJeyidY22mYlMEJeVcBAw=;
        b=HjhBhdDqdts3yaY0x3ZsUyJwf+f0FzYnO31frihITlUm0GnN2MiebHOgRfnLf3M8qd
         03obJrSZiQCcmP1OPsSn+L475ZUm81c1VN0gBYKjlE739IITRkYCOe2Hhc+mpA8l9xK7
         IexMI8x1ujcyGvw9PrPdeFC3SuEPer9w32sZ+nooWaUAOEuGV3lthjiPozjZkb/1e3Sj
         AmVS5BkuJ93emiRFsZ7dhnDIysTyQf5apeN0Q9pqQ6+LwS2X/9LMfVRlFpr5sl/Y0fx4
         GZb7uh4EhFmRROH5LVYdgbrj9eYFJGnmm07hrx4ZiyC3yfPkYEf/6JjuspHDzw0dcnA8
         Zyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771595917; x=1772200717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1I5+1IBudiYzksoOwHs3AfoJeyidY22mYlMEJeVcBAw=;
        b=QcflxBYwIua8f2uvxJ3WwAJCqYpm44gQabKvMcISk+bpExrPj+vgB4roJCqFB2Pnn+
         chXAaYHioKXKzsz/n1SmD4NU0CvR1zZTic/FFrx0OIgYeGY+E4MoGad5v2pUNLjCjRnb
         8qwyAc+0eNHp6rXOjUFP+HXhVTl8K53ZgCbhyZXltyaFiUQM0dZsMxWozRGGLo6EcJcM
         yrBN1/HlFfaH0LdWCIe5/wMF2zaGENayynfL1Ci5ZxM7qE8p8tq0eBvpq3jj/MIXt2x8
         GlHm1p6jwQ88hAubgYDFOAzAOhMRZ7JZA84Qyysr3O5UAZyOwXc9YbzDrpYVo5IZzRw3
         6mSg==
X-Gm-Message-State: AOJu0YyDyITFZnPebfK71mNO/mhWlfkVeEpRQkYR19NDAtfZpzeBe4iT
	KfV0SKEVsF5gk6pixyMGUqQw6ro7+o32pa18XdxrJ1iJjziUhZZUDin7x6bCMg==
X-Gm-Gg: AZuq6aKJjWhZZ9B4f92uk5I0oNT+W9NXV/8Q6NQ1CZL8Ry/O/UcroqYCLnu4exIsxXU
	BsVFdacpUtTam4b5Vy+lC5SfCiSH/ne/WnF4LS47Bh6cnXsjs3+0JlrGEnjAjXSfzrD3JnbqRUJ
	R0TB99TFuxVVTe42IxMwsOpMCYMinfbQjhcI0nzT/HJgt5MvmNlhAAbnZqAGPU3TYgK6Z9/5jp6
	bXs0gDj0nkmRG313HZmIQCu7D4OrF2GMQWSwFMP9NR3iRkebX3xv0yOoNkrcghYGZJzqubP2mjF
	uzkU1UbljSV/b6yhvCHPThJN/vYbmjb9GgNRxa5wechhap1fPkzpEWWN7/0siPhxKlUQnguvVDg
	09L0jcD/Eojuu7auH7jk9lh/Ey8/poS4jsatwT4AyKuTeVk5EMyGY8FSsyCOGoRdOnnUN+VOYhI
	OBgXkgGhMM1iFkag9CY5/LS4jyWRR9YlQrGasRCT18Oqt2mvynzDb4KGHoRcgdE5cPzyejTY/8v
	nKEP/Ti03Fs7FnNHHXua8+Xyo2nr3lNs9uO/W4pxWHn8w938V1y/ww0AjZiH1XQbLDJEuCq9sE=
X-Received: by 2002:a05:6000:290c:b0:435:e451:39d4 with SMTP id ffacd0b85a97d-43958e52533mr16346653f8f.44.1771595917153;
        Fri, 20 Feb 2026 05:58:37 -0800 (PST)
Received: from Tunnel (2a01cb09b01c9b546fd5ffb86f392ee0.ipv6.abo.wanadoo.fr. [2a01:cb09:b01c:9b54:6fd5:ffb8:6f39:2ee0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm59479233f8f.27.2026.02.20.05.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 05:58:35 -0800 (PST)
Date: Fri, 20 Feb 2026 14:58:32 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf 4/4] selftests/bpf: Avoid simplification of crafted
 bounds test
Message-ID: <6863a99d6e168e41b61eb29ff2519e82509ab5b3.1771594636.git.paul.chaignon@gmail.com>
References: <cover.1771594636.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771594636.git.paul.chaignon@gmail.com>

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

