Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99B25B083
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349385; cv=none; b=PSZWiJyvH8WSBCZfcR+6PdiZh/YzXzQr4ZVfnqgZAgePdyoS8mOZg+qJyRiLwp6DPba2XLRFChn6mX1/bu9sdSXgcIKkaOv/i+rYGx1ZzrCqAHwgHO9NLDD/mXWG30tHXRlPt4ZhfqlLoNCtbymk132ZiItVj+qB/RmSmLZURMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349385; c=relaxed/simple;
	bh=0IBdueegRe7PC4l+0z+SMYLcTNLg7LZyvTSdLrp9eQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OWiWHXHQPOuC4tQsCQsFJ1Yp/SLAtvUDi1x8tnm2n39YEbGEuc7H/lV49d73IN61/7N83pIrtnQoVE1XhzfEPf6GJfvhIN/waXGHjjCrJH9jk/CK5kDo4Z2+tjxAuelM4YxZtIVCcL1lrdCDvH2S5+JmhEL1cOEsiqxT9R+dX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/VX0bFT; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/VX0bFT"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bf3781ca51so16380615ad.0
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781349384; x=1781954184; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmMbZVl2thmRPktiNo1ITY6OceSlWZyVIdAvwQlobhk=;
        b=Y/VX0bFTXsLuTXm9f5fmVMxtnEqdRSPOddQXXAETmfguh4kjEzS/xfXzqEYM/kUWkB
         F9xT5I85HC/XfmBVgkPXi9vDjKZSwzTHEswzLBB3Hf96BNSIhwsujcbzAATqrah9qPMV
         XtYyzK+hDowqZFcru7YRRpZJgN1dlt1Iy3t6vetFW3ZTP3KRLqUr+nMTh9qB2wmf3hk0
         zj71x8WjrXSqk4ocJ82jAN7am5427WhU6AHzECzwVj8OH3YzCaIMqaEQ55nev4UxjT8Y
         tUV1R+k8iuE9hRiUWOM4HMPk4H3A01mT5q3tCVvcQ7cCu+1kitBijqspF4uQyjUWkbQH
         YlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781349384; x=1781954184;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmMbZVl2thmRPktiNo1ITY6OceSlWZyVIdAvwQlobhk=;
        b=Lsl/eZMXykV5deYmdJjOxS07uZIZ2SsxeeEgbH73bFZqkVkzIFN5sDE2OCCGhYx14N
         9ncaxcwLp67Ydl9K3/HwZ5ZV8IJNTvXzayCPDhudGZnGkXV4Os4Ssy3YRcUDYIfvMhw1
         uA0+Vt0M6Jqks3ozyAHXX3/lPbqucVfyH9a9XQxpCSw16OTYBUGBdPHW/7zM6BGR+IOW
         6/cOSzA2Y2GNiUNspT0dM0t10qYhWTD07rNXZ8PBIvfTQrQYAFcwrpD39XK1IYWBnnNG
         LRvt3F19YZAJPnRoIvEQOnblyci0+hozWujTPD4OAUw7Hi+fROOgErHztRmaB1ggV39U
         KZgg==
X-Gm-Message-State: AOJu0YxZPYZWyo8anKpVJmVODxq7haKuFWFVocwCWP97+Flv1yT4mYqs
	np1N1zBRjygzDVgY22/+0A6PcT0Olzo6ZVo1ogKclVqOiJ/b4+teUjeK
X-Gm-Gg: Acq92OF5V+kOkMHLung9FHpngfnVzecOAmg7sWElUPBpssrnaXkm7Sh9if7n1JmSXzP
	r5aZwKLa/E6ieoBPg42hQWSoZtftbJyURYaYhIyWFqLe5lZ15puEDpTmUHguNfLDAK+QMf93UKt
	PUE7jmjrhxRd/O5k1siB3ILVmn82Rq6PLAele7kBWrapDeKMR3OGw2zNI8p3MjTL4rT7Kiw/OZ5
	K5HXO3wv48R+0werqJqxoDj120CW6kx6/1EVJ2f5b5Rg3yjhJZs+w4XQ/HyItFI3G1+PslfsZ2i
	Cb3kak98int4wq3UEPfZC9jtz/6mWkKOr5itsyDA/7E9qv5GE07kYJln9Zc4iF3n2siUwxFmYB0
	OysS4WEkfh3biGIumu/k+5eeH9n+fWTkeC7TfETijVJMoGWZwx0QrciJ7hzdigL0EI0c2w2p3yj
	TofmVCc54+4R+FCJyDdhplPiba5bwDuxkgF4b3O/k=
X-Received: by 2002:a17:903:15cf:b0:2c2:25d8:d5a3 with SMTP id d9443c01a7336-2c664197169mr39920135ad.3.1781349383935;
        Sat, 13 Jun 2026 04:16:23 -0700 (PDT)
Received: from [192.168.0.30] ([175.204.13.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm45215975ad.36.2026.06.13.04.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 04:16:23 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Preserve scalar zero spills for
 var-offset stack reads
Date: Sat, 13 Jun 2026 20:16:17 +0900
Message-Id: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBAAf6Xs2YU8tAd/RTwk6UajkJTdNBRL/
 91Uj8Mws4EQJxK4DhswtSSp5A7mNEB4uvwgTFNnMMqMatQK/RxRqgtvbI6xxIgf4oJNoz27Sft
 g/cVa6P3MFNP6e9/gyDKtFe5/I4t/UajHGvb9C2GbnWKHAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=0IBdueegRe7PC4l+0z+SMYLcTNLg7LZyvTSdLrp9eQA=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqLTwFgyESeCXrJcxW2M/X+p/GahVxAct4u73tW
 /STTkUSOliJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCai08BQAKCRBDl0TDFa34
 a3z+D/9lrh2/cHLHftUiWwAZxhKokCg1/BUwfyNqilffdUKTW3Qk7ru2l3WiUVHnkM1pPwqBiMv
 WWkDOrQB6GG18ZrbFsZRBcT3hceUIkzlWmjx1ZvfSgRLXvl0aeOoNP4MH6ojLwfjku5NvxV6No8
 7wq1V/on2jq6Z7CLreqIRwDN/ui465gNnaXuCdq7Edh6x3a2E0AUUb/6WSnQ/SQYhj4IUFqdP8n
 GN5caryJfDLUU+pUa1pcXYaOwBykqZAJNEjH8r6EysoagjRP8NYMIcIdl+HmrsupMK4Kot0dEPF
 YVS5hkKxwPFvIwr8cBM8g0M5a5cHXpMRl53DjOhcho2jifC0ILM/ybQJ3cK66zDy7jGyPQaJ6ly
 SzXFRjBMgggnXTF6/FVxK6fUdCjdhBi8gFs/SVGKk/VBuE6D4OQoxsXPcQ6Vb/Au/Xw3r2FkN+c
 pJqpiaB7s5WpeMPWL7G7G+6DMB66SJNlPnhOMoOs8FWEtDZIjeBzd8DEjH0ShENkq9l944LRB9d
 2q+bIb2I424WuD5b0hUIRQBKlXpN6dMw5v/1Hbs4BmIw54qjBQ4rbR/JwZLk7Xia4Hl1QeoWRuv
 4nsS6zQuCgGBAHcL/CwY0DLR7FQz+6ET9s+BboMwvX45F0xwtbFzi1XmthW43pZhKkD7Ffrzbe+
 qBl6ZyfExKZnpAA==
X-Developer-Key: i=random6.xyz@gmail.com; a=openpgp;
 fpr=AB9274C96F151C01D3CDB790439744C315ADF86B

Variable-offset stack reads currently lose the known-zero fact when the
loaded byte comes from a spilled scalar constant zero rather than from a
STACK_ZERO byte. This series teaches the var-offset stack read path to
preserve that zero fact while marking the contributing spill slots
precise, and adds verifier_var_off coverage for the new behaviour and
the pruning-sensitive negative case.

I don't have a confirmed deployed-program regression, so this is targeted
at bpf-next. I did confirm the pattern is reachable from normal C codegen
with a small helper-based BPF C reproducer: clang 22.1.6 -O2/-O3 can
produce a spilled scalar-zero plus variable-offset stack byte load pattern
that the unpatched verifier rejects and the patched verifier accepts.

Changes in v2:
- Rebased onto bpf-next.
- Split verifier and selftests changes into separate patches.
- Added bpf_bt_set_frame_slot_mask() instead of open-coding a slot loop.
- Kept the new eager precision marking on the variable-offset read path.
- Added verifier log assertions for the zero result and mark_precise trail.
- Added sub-8-byte spill coverage with STACK_ZERO and STACK_MISC neighbours.
- Cleaned up inline asm formatting and local labels.

Tested with:
- make O=../../out/kernel olddefconfig
- make O=../../out/kernel -j$(nproc) kernel/bpf/verifier.o
- make O=../../out/kernel LLVM=1 -j$(nproc) bzImage
- ./test_progs -t verifier_var_off -v
  Summary: 1/30 PASSED, 0 SKIPPED, 0 FAILED
- ./test_progs -t verifier_spill_fill -t verifier_live_stack \
  -t verifier_search_pruning -v
  Summary: 3/127 PASSED, 0 SKIPPED, 0 FAILED
- veristat -o csv verifier_var_off.bpf.o

Assisted-by: opencode:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
Woojin Ji (2):
      bpf: Preserve scalar zero spills for var-offset stack reads
      selftests/bpf: Cover var-offset stack reads from zero spills

 include/linux/bpf_verifier.h                       |   5 +
 kernel/bpf/verifier.c                              |  55 ++++++--
 .../testing/selftests/bpf/progs/verifier_var_off.c | 148 +++++++++++++++++++++
 3 files changed, 198 insertions(+), 10 deletions(-)
---
base-commit: 7bfb93e3475be9de894f1cecd3a727d3e1649b03
change-id: 20260610-bpf-stack-var-off-zero-v1-34ad1bc3b533

Best regards,
--  
Woojin Ji <random6.xyz@gmail.com>

