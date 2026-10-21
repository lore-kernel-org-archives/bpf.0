Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792559885;
	b=MYqgnfGM8r6xDpmLGx34xcuJxS48S4ivQzAJM8P55JZcBcwthlM53Fr7wCt4Amd2MYQG
	 ELEn1h2wvlKfo+ESQdwUw/zojJlS1PmVGgC4DLAvk9l2f8mrfnvDx7ONlRkzCT0W9Rnx9
	 nz/3UcDnDJu77MmZynHxIj/6Lh7QzNiU8Mih/g7kAuNABmJpdm/68thiPrIg0efUI74SY
	 IlIGQ9DjdbWRH7XjxkQAdFa351+NxoPpTjrU3OO/vqPBE0Y3+neF+4GrAEbsLGAFmvfR7
	 /xX+OQnIzl/ADZAeCNIAW5apvdtOwyEiCAzG/feYCQ1SImH49/2NV6MR9agB+EG+Oig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RFCVJpypNSaOPfJtLe4XfbwdbHr2FRgzaO6clY/xeFk=;
	b=ATPkOFly2xjByNnWgdCyq8VZUYRhJR1+CpORMD8sKstTIDg2IlZ2Cg2z5mAfQcMwiBHJ
	 oGHmtAtaLhgMcVcWuJ/RX77nqqIQ7D1yFrBJ941wMHTEUNuTF3vjcdpdt0Y34r04+GF5e
	 vfaPIxpg9lpaDzyfXk73K1/WDmlJjUplN1deSY8WA1jZAsibNrlH4yfVElXDpFcr5l8QZ
	 zkwasyQfMfpcC6akLCThcm/9wDtxUJMRsAYeahWGtADqG3P45UqTu2HMVqDp8SPYR5xhw
	 zkDIIXzAtDmwdjN6JdPZz0EJnqcVFXywD7nHse3G2JnZb+1d2gklF25ytFEX1KcDULQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KjjK+owp;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138A606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 05:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3138A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KjjK+owp
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba328513b9so272780e87.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792559883; x=1793164683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFCVJpypNSaOPfJtLe4XfbwdbHr2FRgzaO6clY/xeFk=;
        b=KjjK+owp9xtb+2UXsPt0zOCfaE6qLx8l1W2y6dX2MEe1HQ3t2k9liW1Y76/+eSj1sg
         F956mgna2Jwk69Wa13yllo4AurgFYNR+30t4ysTBA83wC0zZANvAnD6X0BcWMBuRaoF2
         aPtAqZSG6Ep1LGuI+OYkN6vXs8oiYkF5WjZt8JnT4KK2+aw8z4Z+f03DViV+ypKQTRPc
         J1dJed/9BVrniCOL4SpP0Ax3grhhvP1hBDaPY9hWtB0ocQ4zClqpEFpINipwZ3WoaZPR
         pnnyDuYrsT/fFBSp3rWTXN7x34AtsXLY/YeIwEGG1Sl2m7lOS6RRxrTanFTixYgik5JO
         uASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792559883; x=1793164683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RFCVJpypNSaOPfJtLe4XfbwdbHr2FRgzaO6clY/xeFk=;
        b=1v9mUn06CnnFiiRG2aSqlRz8GYfDeXq8ClFupFk8HbX5BnxaSpkZbP9SfBBgwajCei
         aF5ehNfWBOjrAH8MVLnTW64V3oZVqW6MeZZC1Nt1dQclzMSll30L6Uwa9HRXRYE8F+6Q
         8GxNTJEISdO4/iQ7hZcCnykwb4jjfkr/epFki8Gd6TS2ZL3/CZ17WYwouVqeXtpZX5jd
         Rg4C7SF8fH6cyQ7xhd9HcgEkGPer1HHrhTh0uGnFE2X266Cdfaz88/cnG9ZBmGs6IPWX
         c0zl1hWRULD98fTlza8AAhBAc8cR2JkTRmQluWzEJ1muyW4e1YAjAq9xSSfAeI8e77eC
         YImQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUwoYNliiPR9UYMXfvSLWVgR1N77tfYR58oJdi6idJnD9bmKExFkusu8Lptflx2/BFyqg=@vger.kernel.org
X-Gm-Message-State: AFq9FYITZe5nEQ4pnLDcuksosT9vDmiewUmEJI6zwdKM1elv9FhfmEfc
	gmrA1QC+FrOHM8OmtgBn0v4Jz90/5GtgqAIrAXncSHjluZrPtuR3QxAG
X-Gm-Gg: AYBFou2MPxwnCYWOf2pbQ06XpYJt8nA52bQONGt0QeKun5nt9hyJtm9myNrzrpDemG8
	tAgBoSFCPIRa8HsNKBDQHs40cp+CeOrpNWjX771Vu2phd/ADozgWTZBKLa1ljn0rU9GQAtj/tXG
	FaHhw9JeUojlHXnCsOjesgS/p2P54qwm3BUVhDHQwPDrHC/VxA2JtWlgagvSlx64h62U6ztBbHd
	6hGEmwWNL8gAytN2mPEcDaR+pRl4CY3rPWupL05EtysE9NAtuBaFaVSLGsnDRKjnpud1lcQrB+F
	wLMHxDkLbzv7meMqynkpqV1cd3+dG8z9gt+HQR6tSa0A4kCSdy+I8sqU8n9CXnNL6hEDB7iVa3m
	raHmWvfG7ROOB+1iMRfxbclX4C/UCCF0YrEa8bgK6hYrU+MjkHtzq2Xz8p/2CVde0DJeHsGQYpv
	4Vv0nmoPeZzUtmVoZX+hQLkDlqd45fyi7XB9kgmGHNv/4Nin7yHr//8v6BsSbmDgoOSUlvTRlFh
	kct84Kiqfoj5CmqieAyXcSLsiSqkmX3kQeULKBNeQB9GFoOAsHy0LXMhGRwZokqliIj+BahnDYD
	SW86cDOKbPweZkkK5xgXb82AhU+UuQ5p
X-Received: by 2002:a05:6512:3a8e:b0:5be:64bc:f7c0 with SMTP id 2adb3069b0e04-5bfa1c22119mr283430e87.18.1792559883013;
        Tue, 20 Oct 2026 22:18:03 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa11f60e4sm298289e87.25.2026.10.20.22.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:18:02 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Cast helper IDs to the helper type in bpf_helper_defs.h
Date: Wed, 21 Oct 2026 08:17:48 +0300
Message-ID: <20261021051748.12278-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <DMA3L9A79PD7.DRTZ2IXQUVA7@gmail.com>
References: <20261020101229.111074-1-skokovmaksimevg@gmail.com> <DMA3L9A79PD7.DRTZ2IXQUVA7@gmail.com>
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

On Wed, Oct 21, 2026 at 12:42 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> What C++ programs you have in mind?

Programs from projects whose userspace is already C++ and that want to
share types with the BPF side, plus typed maps and RAII for locks,
kptrs and ring buffer reservations. Not full C++: no exceptions, RTTI
or virtual calls. I'm building that as a small header-only library on
top of libbpf: https://github.com/cpp-bpf/cpp-bpf

> We have to see full roadmap to decide whether we should even bother
> making these steps.

Fair. The compiler has to come first, and I've started there:

- BTF and CO-RE for C++ records, which crash clang since LLVM 22.1 for
  any record with methods or bases, and references as pointers in BTF
  are in review: llvm/llvm-project#233715. Reviews welcome.
- Next: preserve_access_index, btf_decl_tag, btf_type_tag and
  bpf_fastcall, which are C-only in clang today.

On the kernel side:

- BPF-side headers: Kumar's cpp-bpf-mini series.
- vmlinux.h: a C++ mode in btf_dump. Generating one for 6.12 and
  bpf-next, keyword suffixes weren't enough: tags clashing with
  typedefs, anonymous members of a named struct type (-fms-extensions),
  members hiding a typedef of the same name, enum forward declarations,
  and empty structs, which have size 1 in C++ and silently shift the
  members after them (e.g. lock_class_key without lockdep).
- Tests: C++ selftests, and a check that C and C++ see the same layout
  for every type in vmlinux.h.

Kumar, I can send the vmlinux.h cases above as patches on top of your
btf_dump change, and I'd be glad to split the compiler items too if
you want to take some of them. How do you plan to order this?
