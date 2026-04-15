Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CE78F3A
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269258; cv=none; b=GSWsm7ex0z79AcP05Jc3/0Hgpv73SZWEBEEHnMcQUQce+jNbrTkK4QUHeShV2dudv3uGtoDMYOG/s5RayZCCBcLmwIUu4+C1ZwAPOzwiBAxCiQRKKVoGowiv4WKnmjt1mV/tp2gG3Ki0Bi6xPN4mMm3jItscBPZ4BfHdX8OgmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269258; c=relaxed/simple;
	bh=ecnv8XL1XmC67FEVworOKiot9VKxc0X8M7HprD8xhvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYDfaq3RvgBiXPh9hjJv+mL0Wr+oQKCZkR+AAAs1CmpxNzToFPl7x4bYxa/Wcvf7LGUsRcyaU7GQ35qQzQiqUHlMtmaoA95ngRac4xxzX97Knfk24HqUQXf4652tGBT/KiXQn9p7WlCk7DTpmAJ1Wes27vyeep4SKUCF6e3M6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpD0RIR1; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpD0RIR1"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-60fa13bde2dso2200421137.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776269256; x=1776874056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsZCdCBlGt9BLFbhDcrPv5btCZKSWDJNiSHEBV1eByA=;
        b=lpD0RIR1MOLsBiybdFql3opdoC9CdWkg/l6wLXeqDvgPThs6+/mutKLV1VvHNn5LGv
         BR6Wsdc0FawQuj2CtJe8OzHeNTkl4k+1zfCQZu2xAdGaEFgTku8o9iHrPNkwutcXaf6b
         2VLE2hA/Ml+7rNBJmJgjOR9ieEyLHVcY76HGuU4bgmsAUvSohtUbGOSyZnLgHnUEK/bo
         vUMuEjiDijFxsHfBYZ3+t1FdV2GinAkjZbngIfiwefk2Awytyqt6sc9bQZnkErmQ4Kjz
         AN/UmV0qXsaAV+Gc6A38gaXmhVTVHYVtkHWreA9e/RVN/1oyP3ONcRzk1EeyO8moTF4I
         6Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776269256; x=1776874056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsZCdCBlGt9BLFbhDcrPv5btCZKSWDJNiSHEBV1eByA=;
        b=QxdFAZDJzH4D94oI3RC9lDepLoSQ9CA44cfffOi5c444U5/9gg4nfG92gvY3SZlif5
         QPtlLvuN4lGiojud1IigizW9jAQWfTO2/bEE6cT6epEN7Dd6VgcxGrDqkaleKr0bBu/n
         Im6bie8ZOSG6YRK51oXvrdL2ETSGJQGqKgzgjc45uZt4Txr/0juok8rKpt2ULI5IloCW
         i1LkzB9ZQoBbHOD9PbIb/eYfmIM742cl7IMO+i4V20fTQe3Ot7CT8yv+7OXBWmJhGyvm
         NGjfMllvr+HzgEZqoaExuGB05q9enjdgXeQitRxsAjqQ+XCXMkT0G+urSD1FJzjDuMxM
         FLMQ==
X-Gm-Message-State: AOJu0YyX+9AE4YxdtSilLq3FG4/vp5x8fJtTsttNN3aPXBzb4C76KWx5
	1L59C0953jxkkh1/8i+kb8C+JypnwaM/hUacVg+0TUgjMUoRZIVCjvQ2nlrsmhoN
X-Gm-Gg: AeBDieskScYlFSADmL8cgQ/Xp6Htjm6ykPNbqS5SvNQfWoZL18Dv4enehK/QprJN0Nx
	IvtlvKFzUQh1Mzh2xwSNABol9QpsVQZTDxzza1Tqx/SciUl74lUQEeew0YeR/ysFVS1WGO+pb7q
	JPolsxN3EAOzjhJw2GxRRvrQbXK27cMxmslxVq1u1uWgeJG11XAoRoMeUM+rOsyMg0jQy4Vdh60
	deLBgaOkxki4qLLCmY0vp4WWUbpfcVEj9ti6HIQV4I1tHtKeGE41IGs2Q41TLBNI3Z8hWERzq6X
	zxO46WkjEVcGzCcr2Ezzh2eVZ41yqOEQVytq+Ubf4jyprtfnHnvGajwUCqmH69R4VhxA1D2RhZl
	yIaWhDZ/UcsCK6FgYLtm1VvM+Rhzl36KC59d6Q4mMKJE+OOY/+K6weNk7UMZp82jxq84VTy08q1
	zdpSEoch3CaJolT5cDiyGciz0/T24eZNZWqQS48buIq8EXo6l2gnQaLnY5rNOxv+XxiUnsCh2fs
	pDBeKkepnmcmMl4Z1fEUKwkQr3Xe6I=
X-Received: by 2002:a05:6102:3f05:b0:607:798e:18c1 with SMTP id ada2fe7eead31-609fe5872aamr10645257137.5.1776269256432;
        Wed, 15 Apr 2026 09:07:36 -0700 (PDT)
Received: from lima-default (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c959839sm14883736d6.14.2026.04.15.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:07:35 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next 0/2] Detect and prune dead branches using intersection checks
Date: Wed, 15 Apr 2026 12:07:26 -0400
Message-ID: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset improves the BPF verifier's dead branch detection and pruning by
introducing intersection checks for the verifier's abstract domains (u64, s64,
u32, s32, and tnum). 

Previously, the verifier could detect only ill-formed ranges (e.g., umin > umax)
to detect dead branches during simulation [1]. This patchset expands upon that
by identifying situations where the abstract values across different domains for
a given register no longer intersect. If there is no concrete integer value that
simultaneously satisfies the bounds of all tracked domains, the verifier can
safely deduce that the branch is dead code. As a proof of correctness, the C
implementation for each of the 10 domain intersection checks has been formally
verified against a logical specification using the Agni framework [2].

Patch 1 introduces reg_bounds_intersect() which implements intersection checks
for all 10 domain pairs and uses this in simulate_both_branches_taken() to
improve dead branch detection, and in reg_bounds_sync() to exit early on invalid
inputs that have no intersection. 

Patch 2 (Paul) adds an accompanying selftest that relies on an empty
intersection between tnum and u64 state, something that is detectable only by
the new logic. 

[1] commit b254c6d816e5 ("bpf: Simulate branches to prune based on range violations")
[2] https://github.com/bpfverif/agni

Harishankar Vishwanathan (1):
  bpf/verifier: Use intersection checks when simulating to detect dead
    branches

Paul Chaignon (1):
  selftests/bpf: Test for empty intersection of tnum and u64

 kernel/bpf/verifier.c                         | 224 +++++++++++++++++-
 .../selftests/bpf/progs/verifier_bounds.c     |  25 ++
 2 files changed, 244 insertions(+), 5 deletions(-)

-- 
2.51.0

