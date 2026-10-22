Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627620;
	b=TuVLsQXkBU+ngohlMuTOT4uWK9bIIYghAstQYHB6NPsp5F00vc0z9/5DrXpuwahrpQJW
	 M42ssMPRWGzseaPgDOt+jO5L2ICmBjvgEOyX1+0Gshn8b9LxBU/4TFcfvgP5FX3MBIJNk
	 OzXzvcOIM056KJNj72turMzwZlcPnE57Mud0cvH5qoWjj4RdnLzC1NPzIfk6bbv2FZtRn
	 Q2NrjN7oPvt58auwefckxRCh5q+uAkxMiE5PVtPEs2wxh7MvaPfyXtqZShEMAytLY0AA2
	 x37p7BU/fwL/bN6g9CSF9CGcfb4FgXFZjHwnF4lzCmnRu44bLsS/zN35CrgCLsWb4eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ddWScz4ZqblPj8xCGa3Ayzvz6G64FyAJrNu9xBqBzy8=;
	b=RlBx7QOW1xSa9FCTWzCGYh++MGG/fdj93fDCP4Ef18SARqxgW94lGrJT7gZyoGrk9pL3
	 uDxWFrgUGbC0qxXwSpw/lpzF9BDkBEBSpIKhjohcRHRhbVplPQiZyCyg1MN/af5mAT+nr
	 yj1VVX9sqdNLfDpHTHlCQxMjFGVHSyqmO9ZQBzw4GlLWroZfTOQdxD2YVAkviryggx3v6
	 /D7FobVF2ImmioLC+pdTce4IDxlLHqzmMy2vLzo7h62IEiJYmXyTnxIG1RwSnM5m5/dSR
	 xHYlj97nK6n++rOxDpOA7GVTwFJDcQCZIg5n2mz3zn0Ctc/rXkJOfGmkDfbF8yJWzCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AuJhnq1M;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E928606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 00:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E928606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AuJhnq1M
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-353804b591eso2394301eec.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792627619; x=1793232419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddWScz4ZqblPj8xCGa3Ayzvz6G64FyAJrNu9xBqBzy8=;
        b=AuJhnq1Mz+sOEJDxz7ML/2YHntV7XLZYyFDbi/AfSmcixrhgSxHW1ypangA8ZyWLof
         6pBC1yb5fsBBkH0+5k1uq30QycVpYzFy3sisLYmkyByLhGbv+vIZOsXmku7SFzpNlbDG
         hVlb4R6f7sUsD2xvSjA6RFKL9djmd8yZRebAXS025tQZxwhr6/DjblzHAGphHBZLstv4
         goTyaizqyg1lrWLTcHRrWO7GVpy0MdHz8TqfGpqgrzDWjDKM+uoejgxguzvx/6/uLJUt
         OBGziiHDnbzcBBboDHJEnHxU23Qp9Q1ydNST23Y8GxZ308jpPabUmsFXCDxbCV7K1Fi1
         7X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627619; x=1793232419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddWScz4ZqblPj8xCGa3Ayzvz6G64FyAJrNu9xBqBzy8=;
        b=UklQ07znqYFaSm6UrjHqYj9RPZXa0Ew3Wn4SIR8PfVfsAtCL8wf7A7yZP0K4Wj4mkI
         yT6V2rUNZkeiBD6T64/T4mXiFlzRA6bXeuzvAmWIFKmmukuIizyo8ZhJCFFPNXCNbthM
         EcfM3tC92ZRrC6+xBULOPRY75gi+4AIqmB9N4+lDL0Gx0xiBMHWsahuRqK8l1k4e2nWW
         KSP7U4WsAq/F4Kj992ds0FjF6Kn1atXjFa5/YD1WwKnF1FZPXlsCPOXOglvLZrNYojdZ
         rjuxp/jMun+GTaWBmV0sgJ9dTyPqwp12yVcZKGJWGEHwwo6nzyZBVNkjZ6U9W3m73Gjw
         uyxg==
X-Gm-Message-State: AFq9FYJsGwxFcDF7v8jIwUWG+yWS8qrYk8uyfen+Qf9mRdbsWrBw5xsP
	dp1AD4QHgLFM+bzl2vJD7i1VNeLonlPvnz0zmAlJHAbbiqSa+K9Rojaw0FEnl8SeLw==
X-Gm-Gg: AYBFou0zdpP07i/ODeNmBH71BGc8xVz7wA0j6zm+SR+7NgzX+9ZF4296lN2/QZxeWD2
	4dR7Bq1C4Y30a1KNbq6CtyY1xK8DH6/sHnIf3j3OgqUyljJDNuxPguaPGukDrPd1lf5lq1uJ8eg
	OVOOTm6yg3fYYc86zDhN4OxoM5iU6Vy6Ecr4S4rIVTnDaFR6d/MJoqm7tSZ7D/P8eRc+R2jXHf1
	rDCtoZGPvqMrure7sylgoVC7cT35Hpysj7rmJJJcBvw+soGmBZhFlRz8BAoNJ/w33CtUP78rXGZ
	cx8yTp2Q+unJTBa3b62gi7MjXOMslwFvQN1sqDSPvP0cQ+dUYzzcsawyvof2WVm1x4nKSmx7OBu
	lbxXVqfzsICDH47Kq1HL0rs/CP3rddmT9XFB1zSediSfiC2fOngL65twSRE0TRl4WUa3FZlu87o
	KZVH+0QUFiXkE1/vjpBMnvnJ4vcAa011rIJnmvqBmPgXysLA3QzPYfzOS8XuMXzCtZcPT8fy0m4
	QRU3vnqNF8RvxclPKoGbXb/aIhppG1LbBBu/TJPT1nkLVVvl9vMCG8f2XV6zdqh8Q==
X-Received: by 2002:a05:7300:fd0d:b0:351:2a18:c172 with SMTP id 5a478bee46e88-3674cf383c1mr6648521eec.15.1792627618726;
        Wed, 21 Oct 2026 17:06:58 -0700 (PDT)
Received: from localhost.localdomain ([185.220.238.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e153519sm11227537eec.3.2026.10.21.17.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 17:06:58 -0700 (PDT)
From: Wang Yibo <szwyb123@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next 0/3] Add diagnostics for kfunc registration failures and jit subtest skips
Date: Thu, 22 Oct 2026 08:06:54 +0800
Message-Id: <20261022080500.100-1-szwyb123@gmail.com>
X-Mailer: git-send-email 2.25.1
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

While testing the unwind_goto series on arm64 I ran into two places
where a failure is reported without any information about what went
wrong, and each took a while to track down. These three patches add
the diagnostics that would have saved that time.

Patch 1: when a kfunc in a registered set has no proper FUNC entry in
the BTF of the registering object, register_btf_kfunc_id_set()
returns -EINVAL and nothing is printed. With bpf_testmod built by
pahole 1.30 the module fails to load with -22 and dmesg stays empty;
the only hint is a resolve_btfids warning buried in the build log.
Log the offending id, the owner of the BTF and the error code.

Patch 2: bpf_testmod_init() chains twelve registrations with
"ret = ret ?:", so when one of them fails there is no way to tell
which call it was without instrumenting the module. Print the
failing expression.

Patch 3: when test_progs is built without LLVM development libraries,
every subtest that checks jited output skips with a message that is
only visible under -v and does not say what to do about it. Point at
the fix, and add a missing newline in the verbose-only fallback
message.

One observation from building both architectures: with
CONFIG_WERROR=y (the x86_64 defconfig default) resolve_btfids runs
with --fatal_warnings, so the stale-pahole case fails the module
build outright instead of producing a module that fails at load
time. Patches 1 and 2 only help the WERROR=n path, which is what we
run in our arm64 CI.

Verified on arm64 (KVM guest) and x86_64 (TCG guest) against
bpf-next master b71326388a: with the patched kernel a
pahole-1.30-built bpf_testmod still fails to load, but dmesg now
says which kfunc and which registration failed; with pahole 1.32 it
loads cleanly, and the unwind selftests still pass 42/42.


Wang Yibo (3):
  bpf: report kfunc sets that fail BTF sanity check
  selftests/bpf: name the failing registration in bpf_testmod_init
  selftests/bpf: say how to fix the missing LLVM skip for jited checks

 kernel/bpf/btf.c                              |  6 ++-
 .../selftests/bpf/jit_disasm_helpers.c        |  2 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 41 +++++++++++--------
 tools/testing/selftests/bpf/test_loader.c     |  2 +-
 4 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.51.0
