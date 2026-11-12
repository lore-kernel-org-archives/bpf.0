Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501981;
	b=plxla47YVaEHoUGD60FMVpRfGwov7gFGDeIxzmVkilDS10tx5PO3R1MCaAku6sV/1ikQ
	 Y1Xu7CaWGm7wliZrs6+mLgdPzeQ6N60zeU377P6AeKpOWrDoyPIHPM0nCUgoDSFviYdCt
	 atbkfTUFwl5qz3ueut/zi0s6tWh40jFhY749Ufe+StCub+o8uQlZfgaaTbv2Ed/nFINtn
	 +lUhMPA57xKuPV2m187U5E066CSBQu1gma6USFBTajZ15Gkp6KfDL2GtdwpFQRo3Muile
	 ZIA2yiQRCSrwDQFNkgW4Fh4u50kpyxxXwPAPsvRNbzRrmSe/55MAGsPE+XygKurmuzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e+fa4dlOSY8wpg+UjX2P2/CLIEQS7LnbqFRFKW2XN9g=;
	b=zd62U5hnagOTVRETp597lqZkJ+W9t0A2BejfRieHwMfXlfR30x1sUgKpG/W0I/RiD8O/
	 SK9jsRxlzE4Ab8nhV/YnPFQO7ZzNLx3YCjKW9jPOLK54foQP55xlTDiUXtWvSP+fd8vsH
	 pjdivZGIwEZUtv//9Lv1SaFZLB7ez5MpgVCStUgmU68O0CwQllzwDfdcTtcbvy0tmwDAr
	 WwNUA7XL/81IIhIWo2t9h2MqaFyOXzaQjcEJv3fkBCQuv0ERxqQI3QAFs8/9PBAI+bvfC
	 p2bkGofnuKYnkVfNWSjPiWgvU1le1+dSc60U8vrtw/4OoIy7TD2j2V+e6QwT5deC1vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KTVVrB/U";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27030606A335
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27030606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KTVVrB/U
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so733355a91.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501980; x=1795106780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e+fa4dlOSY8wpg+UjX2P2/CLIEQS7LnbqFRFKW2XN9g=;
        b=KTVVrB/UXs/Ge2uSWM0VSRvEcTWyBjMvVEz33gVRCCUjNBC+dLK59GL54EkDGS5Idc
         ZvJ8sSzfoL/nBqUA8D9tExv8PA/oo5EyuSOdRYtb7wuBCajC6W11dUjPzty8A4Offy1+
         9emOUyG+tmxyksZot2k/Gk6GipDq7H1IZxabGxNrBQ/41Zv2dq6zxP6Z9rrX6UuxGwTE
         U8NSI+i5CQJRb3dAJ9MeMUhydXv5Y2OMWTaRg+AvQClZgK11KpQmwV8SV0HxKWmsdipD
         j8Ab8R5Ip+sh2WPd1cwCJzMZxq5C5Gd1+mLKPvkxbLpv48AmUD6wD33PjzcmDKYzO3JE
         Cb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501980; x=1795106780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e+fa4dlOSY8wpg+UjX2P2/CLIEQS7LnbqFRFKW2XN9g=;
        b=k3AUbYzo9JgKoIQVcIEOLC+xeBqR+lQ9BNtNsiCCQ85wm0mMBiAyjIU+oc2ruMsC/P
         Q9SATvoXqcIVErfl8JH5M09DvGSlci7L7aoTKBsqtpYTqEzWpwTkow0frzgEYVygY/ie
         m9dzpR4/x6pEnYLI0lvHJIVyqT6gyZPCMUFP2lKWI87JWv62kUwcOfvGPab7VflcGw3m
         qWN01mBN8bC5Xj5Ebv4TBkHj4Blt5RIEVwCF9VMc6CXkRkaN4nHIkDxpKtznssXUUsH/
         rUwV5aKy4Aj2Md+4ITp/9DM120W6qdxfzFsxA77GUT2IQqVkptwtPa1VaGUbhuB1hxd+
         XLbw==
X-Gm-Message-State: APuU4Z8ipAr7V9biHaOnKhjd6AEycEmcBehx2P0ebVZxQVDweDHkGiXy
	SXQKR4qI00Ny0EbiCUrwvRH+UPpujWX/qNjrl2pOskqPLXMvXJ/os5D1V9P9Rw==
X-Gm-Gg: AYBFou09q+MmRal8DGnFc2wpRDuc8XlJ0nPE8f8WzTIFkELVI5RR+aCkAw4sjMtI/xT
	2OKsJ4bYtoxYy5DxJn8erefFuhQy9PLHlf50LAXAQZ7GJGzV/Whu48HuRJdRMOec9vzE/Uq4YbS
	6fTODnsIwjMkf10wx5gG0+nwu7KsLqTQRtLf+XYMbw5ubciGd4AMylOZ8D6TqdbQVDBIoaicr9h
	FHFOUfpoTZXgOSe9Jxfvbwnli1kC85kjdHvaKU2k4oyDVpT2CezChoFLhdwWSHB2sJHjGeT+De8
	GQ72/wX/56WEOV+1oLdTT+YuMTsv0elb1OGl4K+yjB3C/C+8ptTb1ScLl80XZD+O7Hc2ne6OunV
	ldCiMyH7sRcZKW2uXTjdTt0hr1L76JCRsy3KMSjPfsr6Do3uHdT4tRYtYOgBAjchPr/taDjhwgR
	FoKMSCShbHw/Et21LkeoYetsuT5kQt/M6oPB6IRmk6BDkXtk4n8P6PkMD5L8l6QeXeyUh+5JhVp
	0LRQ+TbLAfuSMoDJzi2qB+AJLBZjxUWxOYWXLAdvlxDou1HDzDo/0ZiJIwB6PZy+iA6UfcBtjB5
	6S4N96jpGIxyUZ+1tjQaal+1wui09LTKMjVVZbtbPi7cXdt3W8ZiQmbBMyh8n1A3A4wSdvAVjHL
	/UnjafWvbvtYRQeO9rSgAqFh8khY0SC+7/W+pNK8dQ/Ak1JPCFQ+cslTubRk+lEAgJzS+MwABZ6
	o=
X-Received: by 2002:a17:90b:4ac3:b0:3ac:7b9e:a545 with SMTP id 98e67ed59e1d1-3b197c8ab1amr2431014a91.3.1794501980306;
        Thu, 12 Nov 2026 08:46:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4bf02sm37964605ad.25.2026.11.12.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:46:19 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 01/10] selftests/bpf: Don't depend on the width of a BTF id in verifier_live_stack
Date: Thu, 12 Nov 2026 16:46:01 +0000
Message-ID: <20261112164610.1917256-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
References: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

kfunc_iter_stack_liveness matches a line of the verifier log:

	 6: (85) call bpf_iter_num_new#95448          ; def: fp0-24 ..
	" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 .."

The pattern has "{{.*}}" for the id and then ten spaces. The verifier
pads the insn to a fixed column. An id of six digits leaves nine spaces,
and the test fails.

resolve_btfids sorts BTF by name. The next patches add about 12000 decl
tags to vmlinux. Their names start with "bpf_fmodret_retval:", so all of
them come before "bpf_iter_num_new":

	                      id of bpf_iter_num_new
	before this series      95448
	after this series      107433

Let "{{.*}}" match the spaces too, as other tests in this file do.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_live_stack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index d6a6420d219d..741260a1e834 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -979,9 +979,9 @@ void __kfunc_btf_root(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg(" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 may_def: fp0-24{{$}}")
-__msg(" 9: (85) call bpf_iter_num_next{{.*}}         ; use: fp0-24 may_def: fp0-24{{$}}")
-__msg("14: (85) call bpf_iter_num_destroy{{.*}}      ; use: fp0-24 may_def: fp0-24{{$}}")
+__msg(" 6: (85) call bpf_iter_num_new{{.*}}; def: fp0-24 may_def: fp0-24{{$}}")
+__msg(" 9: (85) call bpf_iter_num_next{{.*}}; use: fp0-24 may_def: fp0-24{{$}}")
+__msg("14: (85) call bpf_iter_num_destroy{{.*}}; use: fp0-24 may_def: fp0-24{{$}}")
 __naked void kfunc_iter_stack_liveness(void)
 {
 	asm volatile (
-- 
2.55.0

