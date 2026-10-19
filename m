Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC04E0B6A
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421336; cv=none; b=qz8aT6MLUeb5URnU25HEOpXZp6TB9I8qKolD2VHjVe249EbsKWMLFjzWXRnC+8tS7VMpwkPplQ6WE2i/V4SW1aeJw0aPuCAdj62UA78kpPKePimGBppM6LcQi+6gXldqLwpwabSov36TZqm8UjafUIW83K47niDCj0KcdRp8T2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421336; c=relaxed/simple;
	bh=V6zeZ+J2leCD6V/5yx/+EBckOIW9GjQAPnwnzLHMSVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gj/LjAjgBZX3y5mC6eL2QLi0xZrDy03r2z5Ftpmk4FVbqn9dBJGbjbdKuC5t+bqWm4KuRY8w1bFpkCY3axakSxJPwkVVu9h75JZPYBx7m3S9C6+AYRAMKHI3IjUputHniza6nfYgBbOVVX6gqq2/jhZrOkqo6icQEDiDq62CcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVbUO5zU; arc=none smtp.client-ip=74.125.231.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVbUO5zU"
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-8459f7bc7c0so989398a34.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421333; x=1793026133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zDgCeZUmIy4YBlicgUzVdZMfh2qBrxiQvVbibRO2PSo=;
        b=BVbUO5zUgqjRkpXN7RXJP4D/taorLfplSl/ZrehstiYhNZL6cURfIbwTnKjyyTFzua
         Efl/bqWQbEB1e9PdyVf5RGK4xJC70VGl9P5EFoPGHddzDbtp68y8FoLC1ypc1ctjPJEE
         LhU30E7I6K2CQFHOcOy4zuctauHA+PIZzi77UW++uWsW5BpDir7sHrArc8Ag78sh1LeV
         3vP1Dus0Rz/ZzudkB6G8MlLqTTvXXrFuIvM5Ta2EDaY+08h9j2UjMROvSbe/f5ZIAmQP
         Q3TkLQfQldrUfTF7AszYntdwd9duMv7uOVasa6v1pvaK9m2LeDJ5/KSR95dtths7wFx9
         9Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421333; x=1793026133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDgCeZUmIy4YBlicgUzVdZMfh2qBrxiQvVbibRO2PSo=;
        b=FeB16CZ13L8ECydxaOSMIEBg3SwRBddMLqYPK0scJx/4WTXkHRFjrRbTWawZsiFn+9
         4giUpo1e3FojY58+n7vWzl5YicsMGD+Ylb9qLiwa9L9UOs0oHNNpHo+jEkLH4aeqN0h8
         ewxmSf0kWAimSEJbdtgz+0bNEg6kZI2R4ChYHKTc0pfN3pxBJ6O8jPiFYJMk+hZPBbcA
         Q8s/zA58yqnwyxZW8FQz1eiRtqK2g5Hx5dKBDh4KdB8OsPeRuKccYjmn41n6UaGXKdC7
         V/gSlKCQiN/3HOc6vXkJ6worHOAOfMaG/dOo2YWLMcTSYVbuJIqkWt4GS79zVPYjAEyK
         Ogrw==
X-Gm-Message-State: AFq9FYI18DeaJsSVn3r4Ekng/2v8/D4oAYQt9T1wlxYtUzIPpOHbj3iW
	WokRQWQYeX5PYjk3Z03qJFsaE73rRbhLXCdyjJhyulTpQ38EEOzlLHgajw63EndP6Bo=
X-Gm-Gg: AYBFou0G+8FBtsU8XLP9wJw5kyOS/rUKY/mwWOYSlUnr+hem4IoEB0iv1qCoXLR+O2l
	Qh3mC88s2Dbl8ARrE7vyu0SewoCAL3RA0auC1EPbXIk3zuuryRULPLZowQjaYBeQkAL7SQ8w12f
	333ap5g1GHuV/7FcCBEdCrJ3t7XdmsAh95o4pw2BrSNXccw5sc5NyeK14IrG5Wf231uWgEYAvbf
	Xs0tXBISWm8cSDP0yhdN5NjVyLuue58jg7I1EhWoJRl28vHGSCrcDgXQpLL+S5BtJPh129nZOo/
	kOuitjcSAX7Hd5qY4bVioo4myQAA/ui565m18wbYyHu6uPPjg7sFwfy7KasoJNuyxceRoEBvTaF
	J48XlN6Oxkf1bgVEtpDv3cAuezHd1WPA6GEwlnH7RFk141u06ejVF4NJFr6aTE8VipzHj0VJVep
	rTnnpcv3MIgw28AWo5ycr0Qalc2nBvL9xQHDIO46C+4N0agahtrGNKPkTYdb0r4AW8S5FwFikpz
	CkXL2KEFRrvdT24JKteQ6xHHvoQD0/b+26P2XPZ5Ka+glyl24jA170dYuKgd3mREzEWNdnCApz0
	CLyI2Q==
X-Received: by 2002:a05:6808:6c93:b0:4f5:e12:b47c with SMTP id 5614622812f47-53cd331a2b0mr5704936b6e.48.1792421333452;
        Mon, 19 Oct 2026 07:48:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5397b4ac6c6sm7063186b6e.14.2026.10.19.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:48:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Refuse CO-RE relocations for a signed program
Date: Mon, 19 Oct 2026 16:48:48 +0200
Message-ID: <20261019144851.4052056-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; h=from:subject; bh=V6zeZ+J2leCD6V/5yx/+EBckOIW9GjQAPnwnzLHMSVU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeua7rYTh679W3/N9eiE/hph4RvNnZx3QrS5Ox6vOyXyX+Ws rcb+jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExE1Zvhf/YhRofdlZUHfogeXLvV+t m5W1uSnLTXPWh8d1ktas6BUEVGhq9/RcLebfCZyRzyqi/7yy2xpaE9h8OOuH/f18i25NyPQywA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The signature of a BPF program is checked over the insns as submitted,
but the loader may also hand in CO-RE relocation records, which the
kernel applies to those insns afterwards with values the loader picks
through its BTF. Whoever holds a signed program can so change its
constants once the signature has passed. Refuse relocations on a signed
load, before the signature is examined, and test it.

Found by Sashiko on the "Fix some arena paper cuts" series:
https://lore.kernel.org/bpf/sashiko-outbox-176588@kernel.org/


Kumar Kartikeya Dwivedi (2):
  bpf: Refuse CO-RE relocations for a signed program
  selftests/bpf: Test that a signed program with CO-RE relocations is
    refused

 kernel/bpf/verifier.c                         |  9 ++++
 .../selftests/bpf/prog_tests/signed_loader.c  | 46 +++++++++++++++++++
 2 files changed, 55 insertions(+)


base-commit: 25bb03f0a47b622b9025a1558bf2095ec1f55d26
-- 
2.53.0-Meta

