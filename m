Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0C472F9C
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678213; cv=pass; b=kVfZMyp6jI5FsAewkuwJF9g/Ea47AmyBM7u8NI3VJpI2TbNt2vtFgoaXczk0Uhf1QxE7gx9X8TKwQIuolOokZdjugUMDE/cdLojfTv3enXulXl502dJk0h5Efybrvb4kbG6K+SByJi6eIcPDn4wRGPmOP9p9mGg7r/e5qvVT9l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678213; c=relaxed/simple;
	bh=/3DnzFUGSaO/deY28VejyOwo6kGg+FKTgVWwKcW1rhI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Qs0zY3oHyGM+ugtg9D6PMf/LUjdNgGDgtfUQSKVAcw74T0+1trcjDcCIEneuB+QBZoLZiB42wgxmZmnWgwgPTrlTBYJUK48lTeJr+Hl1CK6/gIFisMmlKp+ujhAc56FVi+XX5f3JwgOdbA4l23DBCTuvBZv6j1KJ9MReS/BCvyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8DHIxoj; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8DHIxoj"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c10e86e52so1360771cf.1
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 16:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784678211; cv=none;
        d=google.com; s=arc-20260327;
        b=oqe1wbXqEEMK9XKUvZQXVq/tasDHIIjJd6P88BLLIDl2avT+G5LMQCeI1x2K7pQPqN
         N2EryKpNcvjvqX2YuYS0h8Euhc5KRTfjy7EvHuyYIjzTiKI8wcrYd/OTV3UD3IaFkFgQ
         azVv/NWtPWYhRcGnYN4zz696j8VZbKucLhE11029NFGs3EBZ3iUFwy/vSdk7MwguwBiJ
         wsZ4UrthAkZT6iWHQu2S45T9IQbPapEupHq6J+ydbf6iHcSAqc2ABi7x2DvRlp5zgTbJ
         MOMjFbnTxsndQEilK2IpE/6Nm8eDkksGPitoUdEYk6mmNfrDv3cwyBzOTqTFI+SS/BoS
         aP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=2HDZnLZEgTng2BU/7p81Zndbee1PtPvUlTtKfIbfOGo=;
        fh=FppHYmJCV9t7qZc3Dd+/gP0jnzwLRMYeugQT35dVFxE=;
        b=XqBQOFlBkPgnHfLjX/C5YuL1TL4ff+Kj27CgfNtvDZ/zqdRTHbEAb8w2cV6glp18T2
         TVJAdWiF9ZUScKng/Ui7f/gr1kyPiuk2p13PDnAy/VakItiQrkSuiYMCLv4aHWpegNsV
         EnPxug/2cP0d1CkAZWedhbRiElB1FWFNUJm6FEPi3Sj9bQ5fwUTaEWlAc6hktO9rLSKN
         LQH3JSEu42NfRawvqpU9l80j309TI97xMc8q8SgdBBjNNtM5NDcQp0olpAy7KahqFZV2
         4xI6nTBSUIWUFpsenhieh6h7xSo/dkBD1Xcr5JVsxgpgKzvTvsMMx5Is3TR2w93k9xdu
         c89A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784678211; x=1785283011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HDZnLZEgTng2BU/7p81Zndbee1PtPvUlTtKfIbfOGo=;
        b=p8DHIxojSGqUeDZdxUHjZzEiAmX4EahYPUmGOgtAyxc0KUgFK6/tYK4GCnpnCC/dkn
         CjsB3sPcWeU/l3CI91xJK3cF/YI87dCGImfRus3IaG6oRV+OMn75fwUODhHT4kNXDRYT
         1JH5LUFUmangSssTmRuVfgfNYF073W8A3UgLeFrVlIV3/haw9U8rUdMAWsh8bvEV5xQA
         +z8plFzOD+ewWPQEbRFzMQwpPnfOX4Y1kGCFfNdDTWQcRtZIM5awtJefI6WFTNkSunbg
         zjsdMA3d0iP4JyHq7nyf6o5RC619jiMWDBwo8M1PxRnCoiOdl3+J7tpIcMHnShsdVIb1
         cqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784678211; x=1785283011;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2HDZnLZEgTng2BU/7p81Zndbee1PtPvUlTtKfIbfOGo=;
        b=BMLuHDWbqQMyf2+kDGec5tSvoiSQIzZDJqihpJjGlqHgT80rt3O7xXr+zT80QYPAGr
         rmkO8N/6GKHAP6+KOu4LjwqstjABVI6/950nc+iODkjRkFMAbO3ZAwT6w+u6V12LoGS5
         fuNXuGND9NKoyHSNcYVg46nS3YYEmz2ByLZcukCkRxiF0XLcWDnh1OXaN42jO0sA5IaG
         qewCH4hI+cbTjow6VOkjF6wTgqRv1Qk4GGe/NCuZqWGf3irUL6lO8FRwVOsN5rzSGdwT
         S19BVbDXUXoGVdPRekoccqBWMDRK0J1ndpXsrVDwTpmvyVKBv13ifclR5YV4JgkKzZFS
         BkaA==
X-Gm-Message-State: AOJu0YzLhInsy4FgHcaeegknKs+PDdofLHX2PGT/baz4LBhln4GOFbsY
	gKzNzhr4JuczXEvAnaehuUoJfYF7D5J2JhVYpqVA2hjxVnOKS3F8zvGfDTYKq0RhAYgvVWHmoI0
	wnFsQ6xMnEh4TNMuru0drzC17RxaomgKFD8l8bBQxTilQJguLQ6ms/6LAhJk=
X-Gm-Gg: AR+sD13GBQLSjWF5KG2j7+lo4GBADRzGsr9Gl0sdM7myquBLCOWMcWQ0ClYnbR59n6T
	oKlF+GR86MuSl/yWhgL9t+ONU6DmFiiIjv0pbT6CvEPI8vJiB9yTA2HxgGsT+UNMGCiZb5o/ACM
	yh95XPzBIIWBXY5plEYzFOobQIDlRSbD/ozCcV/CdJPLAJZbotuY30tZ+v8cQrPGXuay1olshyH
	sJQTmgtYJ6ZSfoz4ioxp+DsT+UXpFi1gJ4prgyrl3qfZiRUQuSzRx7yWnC1vr+vy1OUn8GZXQ58
	X1enzQOTaWjaCgV4
X-Received: by 2002:ac8:610f:0:b0:51c:7a90:a798 with SMTP id
 d75a77b69052e-527c400ad2fmr4737971cf.24.1784678210043; Tue, 21 Jul 2026
 16:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: YiFei Zhu <zhuyifei@google.com>
Date: Tue, 21 Jul 2026 16:56:39 -0700
X-Gm-Features: AUfX_mw-H9ROdS8DGZ7O8x6C4vMouBwP7F7113xXDldmrpgofe4tM3HShhGD_HA
Message-ID: <CAA-VZPmzCKF5uhP0OG4mPwEs8WaL-xyjAYW=bE8z7Z_J4-h6cw@mail.gmail.com>
Subject: LLVM regression in memcpy struct bpf_sock_ops->remote_ip6 to struct in6_addr
To: bpf <bpf@vger.kernel.org>, =?UTF-8?Q?=C3=96mer_Sinan_A=C4=9Facan?= <omeragacan@gmail.com>, 
	yonghong-song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In one of our BPF progs, there is a pattern of copying IPv6 addresses
(which are four u32s) off of struct bpf_sock_ops into a stack variable
(a larger struct that contains struct in6_addr), then updating a map
with that stack variable. After a recent LLVM upgrade, that program no
longer loads.

I wrote a reproducer:

  #include <string.h>
  #include <linux/in6.h>
  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>

  struct in6_addr addr6;

  SEC("sockops")
  int test(struct bpf_sock_ops *skops)
  {
          struct in6_addr stack_addr6;

          memcpy(&stack_addr6, skops->remote_ip6, sizeof(skops->remote_ip6)=
);
          addr6 =3D stack_addr6;
          return 0;
  }

This will fail loading at latest LLVM main with error:

  -- BEGIN PROG LOAD LOG --
  0: R1=3Dctx() R10=3Dfp0
  0: (7b) *(u64 *)(r10 -8) =3D r1         ; R1=3Dctx() R10=3Dfp0 fp-8=3Dctx=
()
  1: (79) r1 =3D *(u64 *)(r10 -8)         ; R1=3Dctx() R10=3Dfp0 fp-8=3Dctx=
()
  2: (79) r2 =3D *(u64 *)(r1 +40)
  invalid bpf_context access off=3D40 size=3D8
  processed 3 insns (limit 1000000) max_states_per_insn 0 total_states
0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --

It seems that the program is reading the address from the bpf_sock_ops
as two u64s instead of four u32s, and the verifier understandably does
not allow that due to the complexity of rewriting context accesses. I
bisected the regression to

  commit 790f0623411d5d9d5c989f14e87f2fe86f52eaf3
  Author: =C3=96mer Sinan A=C4=9Facan <omeragacan@gmail.com>
  Date:   Tue Jun 9 16:03:26 2026

      [SelectionDAG] Pass dest and src alignments separately to memcpy
and memmove lowering functions (#201119)

Looking at its PR [1], it seems that commit caused another regression
for BPF selftests and that has been fixed, but this regression is
still reproducible on main with that fix applied.

I'm not really familiar enough with LLVM internals to understand
exactly why it generates the code this way or how to fix the
regression.

YiFei Zhu

[1] https://github.com/llvm/llvm-project/pull/201119
