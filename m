Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601798;
	b=XfFPqIRYs/KaOFCZbemKQozKU60Juyc4bnLiZFoeJvT9wlv2hXAdYfxH6EUBdEIa1PR0
	 TL9LH4bYYZtheazJVNVjimwTscrNH1G2se4lxnh+2Do3EODoVDp9PZ/Wx9FJq0ThMxAv6
	 AzkGQIVi8oNMNelXl/WqkNSnaYZGOmiiqeM4RwXH596HFNrlZ9t66ObsUm/U+vgnEDjkU
	 ERMmEuBaDi7fPTVYwnvIZHkUVvuuSkVSNbwpBep69RYQn2WyX8THfenSF5Mpvvwy01zlx
	 M1HPhty56tVTVQlY02yM9UinnHPHVGzIJigJsZttd7sQARLAqd1oqvnozqxjba0xLqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n/fp0GQXLHMkij5dYnsPmQSZdfgnjwNISi/V4P01h2k=;
	b=fGN1hatKhpmpanBSFZtUrpzdhT6T9nN+CLZZ6nVfahS1EpLxUaOzb2oQH//55KnhkKfw
	 jUiQgDlJ1Rkh41Pqpvxy5ZJhxWFV/V8SvXXO3yvqGWkoZ/qMPB5apVr9RTtDPqTGTcDuy
	 dvMFuD7b3UwxtCPulgw9pTwoYus6iuZ7sbgmA4oPSjotMmNal5xMBiGYD32OqeerDOmnQ
	 T39Ovgfvb0DRGGzmfpjCbwcLcm3tnW3FYC9Laj8fv5VK0hxw4DYSW4ljm1XnDC44CRopF
	 0db0eu4Wd8HA8bZWFg3v9rZQlF56SZ/cUPwk+BTgY/RPO/6YrPHqQ7gYH7CyzeYM5fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5ig6Yvh;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC9606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFC9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5ig6Yvh
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so4529375e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601796; x=1796206596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/fp0GQXLHMkij5dYnsPmQSZdfgnjwNISi/V4P01h2k=;
        b=o5ig6YvhV7pQuaTTlyfioipbMsbHRLkBILcF4lNeYWeKHVTD8FqHefitOkin8Pd4g2
         pvwCs1AtAg8GV28DepZmxHId0Ux626N5sNvxFOktFet90wEBUZYP9sAQOOkm+o40gxg4
         VMox/b9CdauQcbs9UqeIIylzdJRqS1tPwHY9kK7lCPmXrOOf17ldbFwCX4/waFVep15G
         dXcxzaQFhAdHLWQjCTNYL/qK1fCpClIuzq0EyXXfLxuY3x9ZCFG3+Baku2ezNqhIYOm8
         LAW2P+ny2Dx0OYiQfpAYvPGpshJs7CLZLpht1uZQBldbeqPkqa663ZwEAXE6QoRo641k
         4YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601796; x=1796206596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/fp0GQXLHMkij5dYnsPmQSZdfgnjwNISi/V4P01h2k=;
        b=K9oQZq3oiAZjFNuWwFsrwwMtaYPAEwrcH9rr/NzDYgUv1ZzMvC+f7GjuPcaI9C1iKc
         YvgaUp9I59nIewzpU/qGcXVCQtVv1BasWNR8gJkGosurtvwtfxGYGfez++1c+q5/2ORD
         JwVKQP4IcTuJyzRLgV7m89LiWKCcgO7EpSCf+5veg2GX+0tLjVQgfGzlEZvlTQRoLsMx
         YhGCK214ynpD2pOaKDxLINjzh+Hocqh9d37Wztz3lyLBl+z9iHm2+SLOzCJ0EQNl6ZOA
         svMNgFe4uhcYu0XbPrkxl70qenP96ajQXm4+SelhPHCSrTJ/9IWocKv4MiU9kpXDNBT6
         pgcg==
X-Forwarded-Encrypted: i=1; AL+hErF236Zi5/NuJxGyjhfkiVUIQ24luchzWY2174+r0cSmgh/ZBrE3ap6RkYj01j7rUUonuf0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jzJ2jMhF3gNEPE8P6bqbBsnLat07jIZEx3zezWJIzHiJT4bY+
	tHvYL33Ro+J6bEU9goZb6ysZSyKuZAtzsT72GXX22sCeZJ3V8By+eKvZ
X-Gm-Gg: AZFdTZcVcTB/vw1u5Au4+G1gnAaam+beGAVkaGEGbUtsKvrQJkGitH546fuvlpqfCtN
	INhicPmWzdgjEUtpuhV+FDTb+WglSNdRW1EZiyybEejxP9kwU41LHRBorsYB4GRrIauehyK24y2
	yng+Bbwn9a41rXow6qBGhLlN8F9BiPO222plRGBVSORsjWFMer6E0oS2vdx5WB7Ew2S9fi4Kaaw
	df/N8oBUem1jfxaAsxFxZe3gm8kqmdfVmK2tI/HUtDJeHEfJex0FDMyH+tfqR4YP6vUp+di0M/f
	Fk5nNj7qJPr6/RNrc/Ag+f66XGfp5u8jmuHPyElLPzJCi8MTsXSn7+L+P+TLfjRjfWcbQ/xDHYU
	Cwia+giF+wLWTrSGg7CyU4iLNLc2Rov8+lhefSj0EXakQAcOKaQh0BTtL/jUUByjeFnAwgCcmKN
	/5OhIOPyUdkUYbIWIL3Rf8+zniEof3dJnXzgaev3HTsBvs7XWz/bycoAW//m7qwaw84Lh4RErBn
	ifCtsa2ZoX339+Y348gU2YKRJlwJrtioCj+2agNQF9FqwXsXvnQL58GL5MbvRc8ftcUoVnd0L9a
	rZ1kzekNS0GCSzNtpj5GHtV2SMECoMvkdFFJkZtJECzkz/s=
X-Received: by 2002:a05:600c:4e0d:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4bb88922c6amr329162445e9.15.1795601795865;
        Wed, 25 Nov 2026 02:16:35 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm34765938f8f.29.2026.11.25.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:16:35 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 0/7] Tag fmod_ret functions that return ERR_PTR()
Date: Wed, 25 Nov 2026 10:27:57 +0000
Message-ID: <20261125102810.699464-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
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

With CONFIG_BPF_FMODRET_SCAN=y the build tags the functions that
return errors, so that an fmod_ret program can attach to them.
But it looks only at the functions that return an integer.
This set tags the functions that return ERR_PTR() too.

One note is that it turned out that verifier already allowed
to attach fmod_ret programs to functions returning pointers
(see patch 2). Besides cleanups, the two main changes are:

  * From now on we disallow fmod_ret programs attaching to targets
    returning pointers to return anything but -errno or 0 (meaning,
    as in the integer case, "exec the original function").

  * We tag new targets in resolve_btfids

Patches 1-3 are fixes for the declared targets. Patch 1 requires the
JIT for every fmod_ret program on a function which returns 64 bits,
because the interpreter returns only 32 of them. Patch 2 removes a
wrong comment in btf_ctx_access(): fmod_ret programs can already
attach to functions which return pointers, they just can't read
ret. Some functions on the error injection list return a pointer,
like xe_device_create(). An fmod_ret program on such a function may
return any value and the caller dereferences it. Patch 3 allows only
NULL or an error pointer. Patch 4 tests it, together with an
extension of a global function called from such a program.
Patches 5-7 enable tagging for new functions and test them.

In an arm64 vmlinux built with clang this series tags 1380 more
functions: 15804 instead of 14424.

As for the integer functions, among the callers of the new targets
there are ones which do not check the error, and a few functions get
a tag though they never return an error pointer: they turn one into
NULL, as inet_frag_find() does with "IS_ERR_OR_NULL(prev) ? fq :
prev". I do not fix this here, as this is a shared broblem with
integer functions, a follow-up will be send later.

Anton Protopopov (7):
  bpf: Require the JIT for fmod_ret programs on 64-bit functions
  bpf: Remove a wrong comment about fmod_ret targets
  bpf: Allow only NULL or ERR_PTR() from fmod_ret on pointer functions
  selftests/bpf: Test fmod_ret on a declared function that returns a
    pointer
  bpf: Check fmod_ret return values of tagged pointer targets in 64 bits
  resolve_btfids: Tag the functions that return ERR_PTR()
  selftests/bpf: Test fmod_ret on functions that return a pointer

 kernel/bpf/btf.c                              |  3 --
 kernel/bpf/verifier.c                         | 22 ++++++++--
 tools/bpf/resolve_btfids/fmodret.c            | 11 +++--
 .../selftests/bpf/prog_tests/fmodret_retval.c |  2 +-
 .../selftests/bpf/prog_tests/modify_return.c  | 44 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/err.h       |  5 +++
 .../selftests/bpf/progs/fmodret_retval.c      | 10 +++++
 .../selftests/bpf/progs/modify_return_ext.c   | 12 +++++
 .../selftests/bpf/progs/modify_return_ptr.c   | 43 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  7 +++
 .../bpf/test_kmods/bpf_testmod_retval.c       |  2 +-
 11 files changed, 149 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return_ptr.c

-- 
2.43.0

