Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FE472F8C
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656163; cv=none; b=MpCc2QWwPnyEL/2Lz5t4wO9ekp+El5X/WrG0pUX5JD4TR3rKLEyeBHnpCBYFLF4gw+iLLN1PTuHUfLgd5z2AC2qOXwlucQLDEptY42s27nAT1IK6Mhqf2e5alvAW+K5ziylypJCHgqLFA0nd+jWKNWGBv0QBkJbjvd7Zm3MTDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656163; c=relaxed/simple;
	bh=eb3zVnqV4XewPPmXaB28frMy/6+XyrdU4we6OQVyOv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQu4OcUbAlzDngcMsKkJ4C+27Yyj6LUDGls9eVKg5XYXaDMSS4fb1UPdkeDeAJ66ikqTWhBAna91EmUk65ljDePF3xUJhBL6aCcgsKT7nN6/UeKvh8dUuj4IKOmRPIAooArySCkyuAEIIMFDfd9r6NI5wgcAXOHH/NC1I1x/Lr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwj8Pi70; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwj8Pi70"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84830c774a0so6421034b3a.1
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784656161; x=1785260961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SonAXgnsXLM1rWJIkj45hWiwQYjN9ORT3olGRRVyvg=;
        b=Wwj8Pi70TL6eWax9el97iMts9Yz9l4HYOyGkshiCYGwpgUs2g+Ngisa8YLAoMvrerr
         umyShtGGsygxbl6DEFQk8KF0Hm0PT1XGGtt/oew3aaOXKX4X5mH7NUsgjnfjGc7au3mp
         zI5bI2VKHVw/TpzPqLQ7gs1s2/MuWk3UwRHrV9itKqYP/c4fRrJX+ROzkEco7a4twMuj
         6ECaXjG0mNVUeOZzKPlELIahr4CT6m/bc7+VvIi3jrS5gNb1NHZzHE+Ma6KAPRTZXRiT
         pW/5idMm8ZyLJtoisnBhfV7pZNsdsBNxAV+xOLEucpz2MFRrEpzOY3eRPXYjNlfuRqq3
         fDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656161; x=1785260961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SonAXgnsXLM1rWJIkj45hWiwQYjN9ORT3olGRRVyvg=;
        b=SJXB/Imqvute7HmaBttNf9oSO+BG62K59gllYCyAZP8koXIdEyOjFbOJSNuDJFIQm9
         PzEjczXcD0OJqM2IQF9PrNj1gw9K5dm6WqISDgdgvM0SBhaHnxuyXHcXsdEpYW1nrpKI
         uq5jAb4A2yHKr495eXnz/5z58D5Bi/sD1AlExHXMfaoTh40fvptWUUQP9O4wcIhIEOSk
         jp64s0T4H00x19jz/fzabJPAVx87Q7c3PhWUNyx6c3rgKblQLeT8Qe7tnLvLcXoRkT9a
         VuKe8gV1ubTX4iCqX1cG8L1l57HNCoRO8sH5dcdGzEpuJ22aWTG6EYnA3jBnT4Ci+u3h
         YWtA==
X-Gm-Message-State: AOJu0Yy/7y4tvaAuocTF6r0cVkuOov636XFQ7Fj+0XJlRAcwoLKr+h4c
	JZtzZUxbVlSD6a6FM0HDHecm3Bfjeq0ok9HfRibkoSoKbwf7KMClk3kpVNdehPD8
X-Gm-Gg: AR+sD12HY2lHlZo1zNkh2X8LBlZ7PQmLBFIflRkJnC9ryGkC+K2knHvuUwKJBrqUn9Y
	RGs+m0PsF0demGjTOuplW+mZHpWAkecX1rI/M8Z+Ls4EQsHgR1HvULpbeWY9Ds2wWRQpvtrw7Ih
	WjhTGQa8jGppLsvqhDTOxkvsgAuD75Dvc8ptadczHyLv6M5r3A39/I2Gyusghl65cJCLfJDwbSc
	tbiIdDPw0N8sW5MvSRLREOJ7qh+gRRNn5SNoiy3MDmn06hLF2VpYBX9iPlsBLtkTPWzRspBEdZK
	axEXq7aUasJHD3eqovLmWPNVBOlL/9NcMeXkkDu7UoWcsAyT4dVvJxTvMdQ2jvrtTnEPo6IG0nE
	cnjdpRwrEMbXZUcqaA8xTrSQsrUmyL97djQitgq8s+q9XlibRUfSYQ3zQrmIfc3wgXwB1GnqnUp
	qs0fE4bp4zi93+CsbRqo8/UY7PRikYvQoJ9jU=
X-Received: by 2002:a05:6a00:1bcb:b0:848:34ad:3d3b with SMTP id d2e1a72fcca58-84c292276camr18467191b3a.14.1784656161204;
        Tue, 21 Jul 2026 10:49:21 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172984b0sm85737b3a.27.2026.07.21.10.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:49:20 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Subject: [RFC PATCH bpf-next 0/3] selftests/bpf: restructure the Makefile as a layered build
Date: Tue, 21 Jul 2026 10:49:06 -0700
Message-ID: <20260721174909.8044-1-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF selftests Makefile has grown to ~1,100 lines, with much of the
complexity concentrated in the DEFINE_TEST_RUNNER double-expansion
machinery: the per-runner rules are written in $$-escaped make and
eval'd once per flavor, so the rules that actually run never appear in
the source, are invisible to make's own debugging facilities, and are
easy to break for one flavor while testing another.

This series restructures the build in three steps, each independently
buildable and each producing byte-identical artifacts:

  1) the four near-identical skeleton generation recipes move into a
     parameterized helper script (gen_bpf_skel.sh);
  2) shared (non-rule) definitions move into Makefile.buildvars;
  3) each test runner instance (test_progs, test_progs-<flavor>,
     test_maps) becomes its own plain-make sub-make (Makefile.runner),
     replacing the eval/escaping layer.

After the series the top Makefile owns everything that exists once
(toolchain setup, the libbpf/bpftool/resolve_btfids sub-builds,
vmlinux.h, shared helper objects, standalone binaries, and the lib.mk
run/install contract), while every runner instance is an ordinary
single-flavor makefile with no escaping. Total line count is roughly a
wash; the point is the structure, not the size.

Sent as RFC to gather feedback on the overall direction.

Validation (each patch, x86_64, identical toolchains, clean builds):
2,948/2,948 BPF objects, 5,352/5,352 skeleton headers and 1,413/1,413
userspace objects byte-identical to the current Makefile's output. For
the end state additionally: 20/22 binaries byte-identical, and the two
exceptions (bench, test_maps) differ only in object link order, proven
by relinking the current Makefile's objects in the new order and
comparing bytes; emit_tests output and the installed tree identical;
BPF CI green on a manual pre-submission run across x86_64 gcc/llvm,
aarch64 and s390x (including GCC-BPF, ASAN and veristat jobs); and all
76 benchmarks produce
identical outcomes on old- and new-built bench binaries.

Mykola Lysenko (3):
  selftests/bpf: extract BPF skeleton generation into a helper script
  selftests/bpf: move shared build definitions into Makefile.buildvars
  selftests/bpf: build each test runner instance in its own sub-make

 tools/testing/selftests/bpf/Makefile          | 942 +++++-------------
 .../testing/selftests/bpf/Makefile.buildvars  | 204 ++++
 tools/testing/selftests/bpf/Makefile.runner   | 313 ++++++
 tools/testing/selftests/bpf/gen_bpf_skel.sh   |  97 ++
 4 files changed, 874 insertions(+), 682 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh


base-commit: 0bcca2a42cc50b7d64a95c08dffc6b93661a7ea2
-- 
2.43.0

