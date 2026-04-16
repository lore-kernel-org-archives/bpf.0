Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBC3BAD90
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345152; cv=none; b=sMV3PtoZqNW6Pa6mV/HlzAo5S9gQ0oRw7ZBAyRkoEkNfk2Mvgt0p7KuI+pPUSRckHaQGavXcR6dbN37qKevDUX40tIXCsRf489UBvutcYNg/mfU3kBJmrlJJW7anqT5qk1QY/irQBRs5bWHBqoYS5FH/QZIuItT+9Z0l//X1Ro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345152; c=relaxed/simple;
	bh=pfxbq24fIUvRTm0dHdrJz9bKVk6+8TOJwCg9WtamenY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxDoOoFC/NKsCOFx8xdtjPTXgJNw6DW/6rSVB5LwIUkVtBYRBBd5cCwrKzwc5KEhFXuixrQddmN4r6snaft8vNI195cuB9oeb+LS1192XwDrUI+Y5oQB7dLOlWLIdgofhYFSk7GWRliCwhwz0roYIFDQ0tFBTKPf0UnW/uKtydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwGvx15O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwGvx15O"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso80602165e9.3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345148; x=1776949948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLVEXsp93VdYlkCcC2fl6I0++SNNEDM8hG9YVaspNcc=;
        b=NwGvx15OxJR532AImc0CUbz3ueRnORzf40Q0diY0qJsL/eAygRSF4sTpwhfLC2RNyb
         +Y6Wexid0dtVkj5G/K1goAKR9kg5J4DgtXhSgYL8kFffIj4xcsYU3Ib+gBVbUdaYxntI
         cg8fsq4F/6wSIYhgfooHRQZ6byhB8q0O5ce/wXD18OH8VoZaWIBNTKURWwHNKsQKpJIS
         riJ02asL6SZuk6Nbj5e8QxtpilTjrsj9ZVqFkl1EpYCi62oO/zhTdukr4GiPos76P44T
         NIX0e9qG/B1xs6lAeZsHYL8Hic2noTBwqeKrHc3dhHZBzlAD0hqx59+IMn1T2NKdv8ym
         wztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345148; x=1776949948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLVEXsp93VdYlkCcC2fl6I0++SNNEDM8hG9YVaspNcc=;
        b=Sg3xZaOWfcVwJ6sSB7FyASK4aLuF0zjezzvxUHGT6soUbHoWFfX6tYa5/I8iUygZha
         LkfLhiLKpdncABAALCoet6VJMbKP57ioDIrcgSSLViv+bCnr1ZnmyRUTuHiTWsjOhVA4
         OyTspWmGpfpCJTRxmZC33uz59BhVpQ9f40Scws3/pNPQpBZeHZzRbjFjGjNzs4aWFbM0
         WuFzONZRYN0dPOwCWzYmtsfhbVvYMcZpoLeoLDgfMiGATxvSnN5scmoe7napQBjPwAZx
         hcGHdqSnY6f7hgF35jt0wmjuDJNfK9KJ2gRKTVAcB2g0ElmNmrqfAxsQKfVjXT87bBQJ
         wg5w==
X-Gm-Message-State: AOJu0YytiauoxryWreYLOPgr0iDKDaBJY9K2/eHt0sDgZ2Eko+CLymCX
	pyg0aYHltQHmJQ5ysTR0rvVsXCHB0q3Ly8IPOK0koBMKNNtM5W+hbXhz1UewQ7Ud
X-Gm-Gg: AeBDietB3t0zq2emCRBIIaV+RnoId6BdCkQB2dTGjfV6VC9Hp4/DOIKMpOAHOLvrEkf
	GUDoqRAsoKIzqFCIkBb7IwIWR7y68gYqhAlqANgr3NS0EHH3L95csqI5fGmt/plrpeBosy8z/Sg
	boTWKU1k4dFbzd1BblPKf+dnSCsM8PQ2Vd0BnNgcCv2etk70K1+BJn0rFPf2Z/hM7aIoezE9WL5
	Ll6JdxY+0hcIdf1g0zwT3WjaLr25IuYw86UTj+QLB1+wR6RjaTOmxMtbyQMpxW4omLMBIoEZ8cx
	TCsv5rEXCQyV7maBknJPsgQ24nFiYZiy3zpZSKqn/inuGARKu4GKmo/fn0pmIziVOz1dEyrCwg4
	54wNpDnyrPmlTrzYjN7d7UPzLKGr2OLlDmsVZgReJD98P2saU0+7Elwy3Z3YPnbVC1OiDw+vCun
	KQSCS5nrdVMgbe8y53YkEN1q0ETQw94G7VTr9iDPxsTTJtEkMjd5Po+BZTWcb85vd9I0uIsMgPp
	k4BQvsn8meBgcUCUr9ZtsWBd8q9f1c5LE8oSvpH2eI1TzM2wqxJktNGzghrkS+aHkfUmd+11LrS
	R6SDg3+KSS5ses1QJYbevqxPG9oE2zSiGcFpNOb/ErpIj1foA7Nt
X-Received: by 2002:a05:600d:d:b0:488:ba5f:984f with SMTP id 5b1f17b1804b1-488d67b8dadmr288237565e9.6.1776345148375;
        Thu, 16 Apr 2026 06:12:28 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f58165e1sm50870405e9.2.2026.04.16.06.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:12:27 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:12:26 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Helen Koike <koike@igalia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH RFC bpf-next 2/7] selftests/bpf: Test for empty intersection
 of tnum and u64
Message-ID: <cf4061f2e91d271f1f44160a0b87a87ec6df5428.1776344897.git.paul.chaignon@gmail.com>
References: <cover.1776344897.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776344897.git.paul.chaignon@gmail.com>

Thanks to the previous patch, if the tnum and u64 don't intersect on a
branch, we can deduce the branch is dead code. This patch adds a
verifier selftest for that case, with an invalid r10 write on the dead
branch.

Without the previous patch, this selftest fails as follows:

  0: call bpf_get_prandom_u32#7  ; R0=scalar()
  1: r6 = r0                     ; R0=scalar(id=1) R6=scalar(id=1)
  2: r1 = 0xe00000002            ; R1=0xe00000002
  4: r2 = 0xf00000000            ; R2=0xf00000000
  6: if r6 s< r1 goto pc+2       ; R1=0xe00000002 R6=scalar(id=1,smin=umin=0xe00000002,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))
  7: if r6 s> r2 goto pc+1       ; R2=0xf00000000 R6=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,var_off=(0xe00000000; 0x1ffffffff))
  8: if w6 == 0x1 goto pc+1      ; R6=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,var_off=(0xe00000000; 0x1ffffffff))
  9: exit

  from 8 to 10: R0=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,smin32=umin32=1,smax32=umax32=1,var_off=(0xe00000001; 0x100000000)) R1=0xe00000002 R2=0xf00000000 R6=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,smin32=umin32=1,smax32=umax32=1,var_off=(0xe00000001; 0x100000000)) R10=fp0
  10: R0=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,smin32=umin32=1,smax32=umax32=1,var_off=(0xe00000001; 0x100000000)) R1=0xe00000002 R2=0xf00000000 R6=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,smin32=umin32=1,smax32=umax32=1,var_off=(0xe00000001; 0x100000000)) R10=fp0
  10: (b7) r10 = 0
  frame pointer is read only

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index c1ae013dee29..151c7a479a6b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2184,4 +2184,29 @@ __naked void tnums_equal_impossible_constant(void *ctx)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("dead branch: tnum and u64 don't intersect on true branch")
+__success
+__naked void empty_tnum_u64_intersection(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	r6 = r0;									\
+	r1 = 0xe00000002 ll;								\
+	r2 = 0xf00000000 ll;								\
+	if r6 s< r1 goto +2;								\
+	/* On fallthrough, r6's u64=[0xe00000002;0xf00000000] */			\
+	/*                      tnum=(0xe00000000; 0x1ffffffff) */			\
+	if r6 s> r2 goto +1;								\
+	/* On fallthrough, r6's tnum=(0xe00000001; 0x100000000) */			\
+	/* It doesn't intersect with the u64 so the condition is always false */	\
+	if w6 == 1 goto +1;								\
+	exit;										\
+	r10 = 0;									\
+	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

