Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3CC3CFF4C
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383145; cv=none; b=BQDO7Wb0DR1NoO5Nq6XsyAXC6hczlQqzhbpRPjr35VUmYJ7qT9qudUI2YUONBrrQ+1iLw2hWtr/KyM35baCxZyJOnD7lvWvov3LWIXMeGhYnbircMChrBixBMZeVOtr5VwRSvvhZjHgrUg9gc2gbCVwslUHgMZfbheBK44jJiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383145; c=relaxed/simple;
	bh=CEwfyCdqUGGfFA+A63YSbW3pRHTpE+IKRu5riZlfnUI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J9v1W/fET0FMKDBevW9IOpOevm1y3HGdMjhnqax2GT60SiUPQZBIjUylYyQytcHVxCbqn0q1imtKU0vKaO0teJ7gVyCYsLZ+5JBiU+mTgMW0wuTGAXscXHKog9YRr7958Y2130xcuGK6YW9rkJemmV/TOcqIFaNN1qMTI+TRC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0L4lojw; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0L4lojw"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-845b733e82cso249808b3a.2
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782383143; x=1782987943; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xlk68ictw6UP43mCZB0KTRrYEcjVeBYNFkKP7FNv03I=;
        b=J0L4lojw6EnwWa/bogiOiC5ORae0HrISuQ5AKU+u0E3hK0wHh7XhqQenUCAJNx79Zl
         FObRJuPE1TcIRBjVLIrKeMkGCEGVyPsxkvgxYDUM7WOlStlkpbbXe4tgBSug3aMpvqTO
         yeoPGr3OZnK7G00xQGW6tBn4DUbYHmoUhbVqAu13q3pb5vO1AbKnB6W5YhtUXmhxG1t7
         FYaku0XTmPlAanVnsQ1VyBB7X9vGEDoL5Z2kFL30jS0SFwoWgKhfIe/XuIq4TPdmeDxu
         by8dfv8dZSxqWChh8yd9yLEe3SJr7JnScaPiOk9pQZkUSfsEhszwqwrhZbD143imwJms
         vfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782383143; x=1782987943;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xlk68ictw6UP43mCZB0KTRrYEcjVeBYNFkKP7FNv03I=;
        b=JeixFNI6Pt8oPyReu++0fCLOAt32GDMBgJezOZV6I37BaDbAsE0LE4bqDK1/aJyLvc
         15SlgM/ExOV97V52IL8RH/EW+Csx3q9hfw5r+vvcTgePTRgAqbGVLziWerJc0KNfDD1H
         3bl6NA2ew3WsLhDRMCS1HYy18BKuVrEzINnuNq8Pjz3nhk3VF37jYCdaSJCYP2OeSllm
         nPGcyUN2EdeGI5bABIEqz7RqB1gvHxS/06qvPBq4XWCtHi7SBXzjfh0tJ0PAMtLJQguH
         xq3cUfP6+NP19IdbjO2CshX6NygfxCPbwAMxTg+5Bzy/2kczU4Y2ipUQBMKU4I/h8Hlo
         bYFA==
X-Gm-Message-State: AOJu0YzSGIyL6K4OxDrVYBN+t8WY34ZCsMsF4UkTy8BCFGkrWtvrdb3X
	0CwIEbytUeY0UMqCu9v40hq1vfODTUfeMZX2kq6vmLrko0t4qDiNBv9S
X-Gm-Gg: AfdE7clutSTfdAlqBtd5CUjyy/M9YczMDBfekVGpdV/4+0tLyRYYAynAUMA8InW6dk9
	2fSKrCRF13AysIYHyrN1x1JSuYO9VjesG5T7D0G681r5X1dDCbGvlYyalBXbZ3ywVvni4dHjUsA
	asX+DTlNHfZfe1D1jAFpgmcodxgvchj9vX93QTzHbRGIjpvExJvm9Ahio0d1JccAuBjR2zpgO1M
	nl7SoFmDTqANGrMh68ROcLO3Qs1uep9LTCU6SGkKhkEfal8m676L50gARb/2HKhPeUavRG908B3
	QLWNFZ+MHfkE91hT2mq6z94PSuakrNvi1XlqFICNx6QFI+1gut1+NxQpbN8f/hbYRtqlQDaX/5H
	haI/mhjiyzBpUVfmjmi0t1/ehHy93D2Rd1c2EtIjkiP61BSzxeW4l5LmugJSzLLKn/AmnUmXV0h
	mxgnfTm0dgPyE=
X-Received: by 2002:a05:6a00:8084:b0:842:4982:82a with SMTP id d2e1a72fcca58-845b3b09130mr2267142b3a.45.1782383143342;
        Thu, 25 Jun 2026 03:25:43 -0700 (PDT)
Received: from [172.30.1.18] ([59.6.68.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845ba891314sm570708b3a.35.2026.06.25.03.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:25:42 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Preserve scalar zero spills for stack
 reads
Date: Thu, 25 Jun 2026 19:25:36 +0900
Message-Id: <20260625-bpf-stack-var-off-zero-v1-v3-0-a068210a761b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OwQ6CMBBEf4Xs2TWlRQ6e/A/DYSlbqAolbW1Qw
 r8L6NnjZObNzAyBveUA52wGz8kG64ZVqEMGuqOhZbTNqkEKWYoyF1iPBkMkfcdEHp0x+GbvMOW
 oCmryWqv6pBSs/OjZ2GnvvsKGDTxFqL5OeNY31nGr3rKdDdH5134jyZ34Lao/i0miQFKyICOME
 EyXtif7OGrXQ7Usywfvsx9d3gAAAA==
X-Change-ID: 20260610-bpf-stack-var-off-zero-v1-34ad1bc3b533
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=CEwfyCdqUGGfFA+A63YSbW3pRHTpE+IKRu5riZlfnUI=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqPQIk+WHXrKt0NU6RjEtMm+doAF7/DVWwm1yAH
 2kqNC+nL9qJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCaj0CJAAKCRBDl0TDFa34
 a2+1D/989ZCJ9lzl6jjkwk3mb8Pj9WqumirBWBpsOuUKjbvfW2aZwEUI1gtnVnMdAm4HcWsYw4h
 6IO6jcxNwNdaANJ24peTw/Pa5nwndysS1EP9cDh/4QP1h6xugzkq/3wlmipBnCjwx63nDCPEPqt
 D704Cr//U2th5uqSYFGZ9/lpbxbK55QUFaX9ocmOD+c87pTff3Wqh1kQ20ZsnOzxVlPdN/CWwQT
 W2G21PFV1hpCpN8BpxMNPnLpFSVDxt9F6lmGxWh/Jp9ZtqFQlI6vfr3LQLKXlyLlEMZY8Gm4ifs
 msyDOWZ2bG2VAFIQvch37iOZNpLYRf+EQ/3nG0awKOog/YmD3kRNJzvz/NBq7XwrUAw5kf1zg8Y
 cKARWP7ElApy2zT+zuWjyV1apYykmUONtRMnmxvu1HkJWmADweMPGDzKM/n+m4u2nzQFnTyuDjc
 HcE5V0t3B81lppC3Ey7jgJ34O/dvlnfXvEqmc8BcFSOTCy8lJA8Swg3Jh2iS1hEcm6c3iHk9RsJ
 H/taT1HLqy+SWGiCVhQS7fx3rQVpvzyGE6IRemEdrqCdvcrru1j3dfcE5FYmHsWEaEMS+ODVdYm
 Elirt4JSLZzaWJL4xtnht6PZ6HBYRAtLO7k+2m+GZdLY6upRbGsokM+i2mF0tLhYG7UcwONNrpb
 +kyDn+hJGi572Xg==
X-Developer-Key: i=random6.xyz@gmail.com; a=openpgp;
 fpr=AB9274C96F151C01D3CDB790439744C315ADF86B

Changes in v3:
- Apply scalar-zero spill preservation to fixed-offset mixed stack reads as well.
- Remove the var-offset-only flag from mark_reg_stack_read().
- Keep pure register-fill behavior unchanged.
- Add fixed-offset mixed zero/spill-zero selftest coverage.
- Address selftest nits: drop extra unpriv checks, align asm formatting, and remove the pruning-sensitive test.
- Link to v2: https://patch.msgid.link/20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com

Stack reads currently lose the known-zero fact when loaded bytes come from
a spilled scalar constant zero rather than from STACK_ZERO bytes in some
paths. This series teaches the stack read zero reconstruction path to
preserve that fact while marking the contributing spill slots precise.

The original reproducer used a variable-offset stack byte read emitted by
clang 22.1.6 at -O2/-O3 from a small helper-based BPF C program. Review of
v2 pointed out that fixed-offset reads can benefit as well: pure scalar
zero spill reads were already handled, but a fixed read spanning both
STACK_ZERO and scalar const-zero STACK_SPILL bytes, e.g. 0000ssss, still
fell back to an unknown scalar. v3 handles that mixed fixed-offset case
without changing the existing pure register-fill behavior.

I still do not have a confirmed deployed-program regression, so this stays
targeted at bpf-next.

Tested with:
- make O=../../out/kernel olddefconfig
- make O=../../out/kernel -j$(nproc) kernel/bpf/verifier.o
- make O=../../out/kernel LLVM=1 -j$(nproc) bzImage
- make -C tools/testing/selftests/bpf O=../../../../../out/kernel VMLINUX_BTF=../../../../../out/kernel/vmlinux TEST_KMOD_TARGETS= LLVM=1 -j$(nproc) test_progs
- QEMU guest: ./test_progs -t verifier_var_off -v
  Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED
- QEMU guest: ./test_progs -t verifier_spill_fill -t verifier_live_stack -t verifier_search_pruning -v
  Summary: 3/128 PASSED, 0 SKIPPED, 0 FAILED
- QEMU guest: ./veristat -o csv verifier_var_off.bpf.o verifier_spill_fill.bpf.o

Assisted-by: opencode:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
Woojin Ji (2):
      bpf: Preserve scalar zero spills for stack reads
      selftests/bpf: Cover stack reads from zero spills

 include/linux/bpf_verifier.h                       |   5 +
 kernel/bpf/verifier.c                              |  54 +++++++---
 .../selftests/bpf/progs/verifier_spill_fill.c      |  26 +++++
 .../testing/selftests/bpf/progs/verifier_var_off.c | 110 +++++++++++++++++++++
 4 files changed, 184 insertions(+), 11 deletions(-)
---
base-commit: 7bfb93e3475be9de894f1cecd3a727d3e1649b03
change-id: 20260610-bpf-stack-var-off-zero-v1-34ad1bc3b533

Best regards,
--  
Woojin Ji <random6.xyz@gmail.com>

