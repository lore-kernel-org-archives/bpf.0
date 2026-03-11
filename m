Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3A3DBA0
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253718; cv=none; b=GkuyRQ+UBnx/3/JKW4ftEh+IuhYiEks2sGwLhp1nDc0SGp2hDK4k/G/SL+Xnm4aydlU7ua4LHV8oC1SddV3b9OuhinzqRxn11BAT7b7hoipqjckI9yVzpvR7zRVi1nBufIk/o+JfUo+OVCxfB66OgDnre7zvdsBzpy5qkfhFL1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253718; c=relaxed/simple;
	bh=zcJWI1jaArSAvvTR3+miy5rBKt5pnaMqWi52zuop1nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJLM/Dg+CEU66aksWm74vDunU2Tco4mR3ww9LisUSRqxnb6GzmaRsT2/Vq33bTPfSqmYL0FQ2TlJ01+QX+hIBbD+fjgWkHEarqvFkaQt1+U2gj74otGQLH0FO4BujbNwY4qkjd3mX2LdeI+YffkL2wxzJZS8VhQco/M4eyH4KwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=UZkxpohM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="UZkxpohM"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-509307e3854so10748841cf.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773253716; x=1773858516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5j0xI05WknCDLzuikXM70Ga7+ARhfqZ9+rP/w6KEg1Q=;
        b=UZkxpohMgLY7Ef0NhPTaOs9dErPW4HyloTForf1di0dhq8f1S8nqHpMuLIgzlrB57w
         15uBBV+5gTlIchmK2PWmgKd0UMCpxaVap0B4daKes16y60MYWdq0NdQs/hQrZqa50iJc
         fQ4/OnA4FIHDXa1yOEJ8w2L+mK3xirvyIEx39HprGzPTUUqMplYv4skw3tuGwkBRn8Oa
         leZ55HAWa4P9Rhz9LfEQXbL2MrB/Dg6T8P4+E1KHvs/1PyTCQLrBaLp2Qmy69gI5LrlX
         8V/rh0Zn8f5xGBqxBlE29tFlRn03vvQyc/mlQptWHm+jR2wO/kSkK+GEM4oGSvKsaoR7
         JSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253716; x=1773858516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j0xI05WknCDLzuikXM70Ga7+ARhfqZ9+rP/w6KEg1Q=;
        b=GRut7osXfIsa7iAu9r3o6YV1icG9knkXZTX3lloP5VoVSA3iqCniow8Zq4gD4qt7Q4
         ONAUFBwAywXhSVPGp+jHlEz1PmsgO0IgZdjf0UKqd0xKxuOFlMgyrgrlaaSbYhooJl97
         pQK4aa8G0afcY8uwrIdDhaI3U70PZ/yAyWRikfsDbcVFm86D512OKFKG7mduaHfQchNM
         6W6cyoagqtBqWeAxd616KQ71TC3VCtL9YIkQn02cghr/xAW5e2Iuhqzu739/3b4u3/jt
         L6diEWwBmqFwycaIvspECtBIuOrWJ/tOJ4cUejbxES4xVuvyRO3aEZxjVJmf2rMHVb5g
         1uJQ==
X-Gm-Message-State: AOJu0YyugAondvsBeVm5nkQIiOKa6VZH1ePHq9bIjROIBxMr3mvR8P0n
	swhGo2TtxxVgSx1jOh8orsrjRdLlHWBwwCafVanHZN4w8NvJE9YC6LRaVpXwmoywInK9T2F5iA7
	NOB2L
X-Gm-Gg: ATEYQzy6iTdqg0ROj1I/HrHJOKoiD/PHadbUx6ixtM25InmJHOiI6hcvH0hyDWjURXR
	I8etyWKbTgRy8boc28fT4KkYFo8mPZP5s7cyDoaChH2o/SBiOtYaI7DEybyDLZvvjquACcVUI3B
	rEYhyAIvovB2gTwRySU12Dyl3b4huHdsiofXd73lLWjWDg8vTSknr7FYz90d21ZD/W2v4dzN3bd
	FUbCsBZ6TJCW8PnkdbGNRN8/PDQDB9Xy5OHsOob/cuXERsYUp91EjZAsGNaIMsWOCoWgvQ15yVf
	YwbBwP/abFXeYSNa2f5VPpIFLevUPV3dfEyQCGvJmAzogY8Oo+JN0DbDNMhyGlc7CVG2dvtcr7/
	QUbCkNgoX1+qDfYFE8bskIHwWizIR/GET/Yw4K5asNKiVFox+DNX+CdxNu2iJxv/HJCCfBIHY4A
	GyztAdvLu8DVAE/j6wLbzmVA==
X-Received: by 2002:a05:622a:3cb:b0:506:9af9:595 with SMTP id d75a77b69052e-50947272bf3mr8364671cf.26.1773253715721;
        Wed, 11 Mar 2026 11:28:35 -0700 (PDT)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beeb7dsm21178946d6.19.2026.03.11.11.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:28:35 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 0/2] bpf: Relax 8 frame limitation for global subprogs
Date: Wed, 11 Mar 2026 14:28:29 -0400
Message-ID: <20260311182831.91219-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier currently limits the maximum runtime call stack to
8 frames. Larger BPF programs like sched-ext schedulers routinely
fail verification because they exceed this limit, even as they use
very little actual stack space for each frame.

Relax the verifier to permit call stacks > 8 frames deep when the
call stacks include global subprogs. The old 8 stack frame limit now
only applies to call stacks composed entirely of static function calls.
This works because global functions are each verified in isolation, so
the verifier does not need to cross-reference verification state across
the function call boundary, which has been the reason for limiting the
call stack size in the first place.

This patch does not change the verification time limit of 8 stack
frames. Static functions that are inlined for verification purposes
still only go 8 frames deep to avoid changing the verifier's internal
data structures used for verification. These data structures only
support holding information on up to 8 stack frames.

This patch also does not adjust the actual maximum stack size of 512.

CHANGELOG
=========

v4 -> v5 (https://lore.kernel.org/bpf/20260309204430.201219-1-emil@etsalapatis.com/)
- Move depth tracking state to verifier (Eduard) and free it after verification (Alexei)
- Fix selftest patch title and formatting errors (Yonghong)

v3 -> v4 (https://lore.kernel.org/bpf/20260303043106.406099-1-emil@etsalapatis.com/)
- Factor out temp call depth tracking info into its own struct (Eduard)
- Bring depth calculation loop in line with the other instances (Mykyta)
- Add comment on why selftest call stack is 16 bytes/frame (Eduard)
- Rename "cidx" to "caller" for clarity (Mykyta, Eduard)

v2 -> v3 (https://lore.kernel.org/bpf/20260210213606.475415-1-emil@etsalapatis.com/)
- Change logic to remove arbitrary limit on call depth (Eduard)
- Add additional selftests (Eduard)

v1 -> v2 (https://lore.kernel.org/bpf/20260202233716.835638-1-emil@etsalapatis.com)
- Adjust patch to only increase the runtime stack depth, leaving the
verification-time stack depth unchanged (Alexei)

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: Only enforce 8 frame call stack limit for all-static stacks
  selftests/bpf: Add deep call stack selftests

 include/linux/bpf_verifier.h                  |  9 ++
 kernel/bpf/verifier.c                         | 62 ++++++++----
 .../bpf/prog_tests/test_global_funcs.c        |  2 +
 .../selftests/bpf/progs/test_global_func3.c   | 18 ++--
 .../bpf/progs/test_global_func_deep_stack.c   | 95 +++++++++++++++++++
 5 files changed, 158 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c

-- 
2.49.0

