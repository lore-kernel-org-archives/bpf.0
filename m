Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394594;
	b=fr2yS0vWT3EkBh/pZ4yQfavMFM3otS/wBJE1gXeR9Nj9lG3PTUpzIPHNJGVJX419LUU7
	 gfYcl/zEWt7ZM2qHxiqcPSARabXu9K2ABFGcQVyC439uME7epGJnlizfS+NHymwIA2AjB
	 GZbMmg+gmHGkTcWWw4rCtsXNc9YsRp5+8p4sH5EmI78gEvaigeCvtvU45vetXtmCPaNPR
	 iyp2uRvT0OsmMGkH9UI7mxFWp04EanSqu8rh4CJA08qh1JXnaNihfZPhD0e5SKZBRtCgc
	 RjGPJnjPqBTPQHofkK2pz6/1Zoxx+y8Ng/r3zacqX+EjA6w+qHQ0j/zQvDQ3Qzp3oCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9iIIxIsO8jxNJuOKLqm7GNBXIm4ucdEpp+ElYIaGgWw=;
	b=zQrWQighCGE2jRIcwoznwG/erBAkbqND2tZ/++bYbQQxSwEWk6f16Buvqf1j40cjg1VR
	 8enI4Rhx32NN0s8jSRr9c9/msCXe64V/NKt6pBF4j04xC2d5TdahXxOZvYlCpsTKadIM/
	 gUXEk/Oow9Tpsz5i4HNN20iwFDFH4cdivQ9s3Q5oHs2yg3qMXaLWHmfwQLaOmmJ+4gFQC
	 Km9itBsy4HGVdjHC/Cjlsjdu039Gv+j8o8TmsxCHRUm7cWCQkPpCf2NrUuvYY3AcYv7r3
	 Vh+9iNCwUIclr3eRAkyP6tHJZaUfbMlPPmom9hQUrlHcc44sqH8u99o+V4nAQrQ7ZBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVjm90WT;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3977606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 21:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3977606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVjm90WT
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06e79e152so661896b3a.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793394593; x=1793999393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9iIIxIsO8jxNJuOKLqm7GNBXIm4ucdEpp+ElYIaGgWw=;
        b=XVjm90WT9HrWGBJvaaNMfogbYs0Bm9SU723r4oXwwwYtbGbc/LN+oyYIpyILnE/WBp
         t3cmjVetg9dpGTwra5r5XAB1FLtR0VOjvka73wahsz8BqxkQz43BbrGpataaxeTZaoGS
         lqyUOcNbkhoRaL5G1jhiBAn0u4Y/kuVYoWdAdDjrtzdlsGCBboQA7aV0ft2BqexRRNXi
         Wuy+HhUprppk2BDw8FX0rGqjHTFxWwaOt8qTQDRRUXDGntOZsHbVT1llsD7OV+t8qVrK
         oUK5jxHDChRhTncFHSoRf+mjfR/6V6qiky5pvC2r+pUajJEEbu4XSwqQk/AjxN1x1R68
         x1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394593; x=1793999393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9iIIxIsO8jxNJuOKLqm7GNBXIm4ucdEpp+ElYIaGgWw=;
        b=PJgn1uPkwWyO9kUV2x4JxyJ7A/W/8GOINayV4fwzJ3tVHZcZIuZvuIYSBfThUB8yhM
         16OTzTuT9PfqyKw2ypg+cvMTuzc8v5ukNycVyjRZtQ5msmwP8Gi3/nEYIJSlklZOpeg9
         BBZiunKVEushVrQo70Zw1zEvitYUWJun7Sc29D2QhewWzdDeJBiDjTsFYR37GmZC6X2p
         6L+elOOIbkNuV3rywgGDgUOUjx/MXMPGtfHemuFFSAGjdVTkYh6cAauzIM6ljnwfPXk3
         kGRldzt2sJNeD/rhfFa7ujCHSm5TgwxK37sNn3TUEmVjKAOEtteLh/vXMAQ0iY+FXWE3
         ONSA==
X-Gm-Message-State: AFq9FYKi/x5PLIwiaNBSLjbWo+plFLaz/2meiQkJSPO5XPEnUlFv7DX7
	XQItmWFKX1M7QIB/pBSkHTEpc/w0HKxUvbEMudd79em3l6qpJY8sh3fF7f+ChA==
X-Gm-Gg: AYBFou19RGQbF6b5VSWNRWSoaqGZF5fWqanhyHfP44qyLqfXaZDWyEMMVD/FcuOxEXT
	KWOsWIWVAgz6JNoRvdqH8vV7sYuWUz1dHhma8Xqvjj5Phi0k5IYKbRBYxAfXT7JCiPya/7v0kZy
	UVqJUELv5haq1aM4TRvP9ZTgGrOwG5zgbZyxXpOX/e/ypI6AwFtui13nI/zbiQKcbH8rnI2b5hs
	bvV2mzC/xrJUtIsS5hklyQlbjOFNjbBO4NDeQnx3nIGOmJJCI8vygsDyWemwsWVdfwTzcaQPich
	uJlPWMp60NfmeK/bpWs886AWbvjYWzvK59clsz8WGh96VetagktAhvvWvAhKSqvPVhAiqXZfLtJ
	OP1f+ivWb5912XmYN+zAJrCBy3sCS37+aXTWrEqJVkLm7+PDmRnUJ/id9EzeEUNBVykD3y3BIi0
	VnoDm7EFTqtj+n7UpJAtb/0UleufbXR1YUe30/TkK+4JUA2Hb6J4J9mnbLYkWfW8DuBenmT90ve
	OEp6CHtj5w2G1gWyK3v3wMRFrCB0FOXQByccNAi6sX3ayG8Cg0xSohLi0fdWZRSDZJkl/e7VKNI
	Y0l5UAz4DJfrccna0YZDB0+4F7XvYcLPulLGaWXT2c+3IiBEqsqT5c/nudOOpnQ9l8f7avxJNP4
	755R1XvB0MouYM2M+Y5frQhhy5Uot9mAhnDdF5ahHeIriBlmOfGWbArKorVOHZb5quPJnpW3oPT
	o=
X-Received: by 2002:a05:6a00:178f:b0:89f:1b32:29b3 with SMTP id d2e1a72fcca58-8a9ba80718dmr2923955b3a.5.1793394592760;
        Fri, 30 Oct 2026 14:09:52 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada9ae39esm405893b3a.52.2026.10.30.14.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:09:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 0/2] bpf: Keep the valid bytes of a packet pointer in scalar evolution
Date: Fri, 30 Oct 2026 21:09:48 +0000
Message-ID: <20261030210950.1904640-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Sashiko found a bug in the review of [1]. It is in the tree since scalar
evolution widens packet pointers.

'range - umax' bytes from a packet pointer are in the packet. At the head
of a counted loop scalar evolution sets new bounds, and reg_bounds_sync()
makes umax smaller: 58 becomes 56 when the step is 8. The range does not
change. Then the verifier accepts 2 bytes that are not in the packet.

  prog                                    bpf tree  this fix
  --------------------------------------  --------  --------
  r6 += 8, access in the loop             loads     rejected
  r6 += -8, access in the loop            loads     rejected
  r6 += -8, the offset can be negative    loads     rejected
  access in the second iteration          loads     rejected
  r5 is r6 + 8 or r6                      loads     rejected

veristat shows the same verdicts and the same number of insns for all progs
of 36 weekly builds of Cilium (5032 progs), of sched-ext/scx (563 progs)
and of the selftests. test_progs, test_progs-no_alu32, test_progs-cpuv4,
test_progs-bpf_gcc and test_verifier have no new failure on x86-64.

v1 -> v2:
 - Use smax in place of umax. umax is U64_MAX when the offset can be
   negative. Then v1 did not change the range, or made it larger (Sashiko).
 - Change the range one time, after the last register of a union. v1
   changed it after each register. Then the subsequent register had a
   different range, and a correct prog got "verifier bug: union of
   incompatible registers" (bpf-ci, Sashiko).
 - Add widen_pkt_pointer_negative_offset. Change the prog in
   union_pkt_pointer_var_off_lowers_umax: it loads without the fix now.
 - Patch 1: correct the log. The removal of the mark can change a verdict.
 - v1 was on top of [1], which is in the bpf tree now. BPF CI and the two
   bots applied v1 without [1]. The two tests that failed in CI and the
   comments about bpf_clamp_scev_regs() have this cause.

v1: https://lore.kernel.org/bpf/20261027201436.3192716-1-alexei.starovoitov@gmail.com/
[1] https://lore.kernel.org/bpf/20261027190314.1440199-15-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: Keep the valid bytes of a packet pointer in scalar evolution
  selftests/bpf: Test the valid bytes of a packet pointer in a counted
    loop

 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/scev.c                             |   7 +
 kernel/bpf/verifier.c                         |  13 ++
 .../selftests/bpf/progs/verifier_scev.c       | 182 ++++++++++++++++++
 4 files changed, 203 insertions(+)

-- 
2.55.0

