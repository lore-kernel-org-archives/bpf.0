Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC923D2FE1
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025136; cv=none; b=qeE+cJYkpxfWdtV1CAuznP2/HvnnZfAUl+jID5i/MfDy4T9hoEGEuNEgO0oHamizP1iwdQLBO2NHDYOPqyDff3OGnl5qWIxiX4+iXeEiBH2uLVaXuPpIJeLkqaNB2C1wlLMTypIbrTix4BmI4iK4TRhKaJDvjpBskLu2vNowdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025136; c=relaxed/simple;
	bh=aSqIvd7nYo8xQyFqLvzSfJ3fKmMNAy1qn/EpnwHd0o4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DtHTmIXx+7M9wUHjOJq0aPsz/BKdCaolZnIDvAfK8NBaqTk9EgweRE62Md9Px259dfqMAXhDbgY/Dux4RvMXwaCgVsIxN+A0/W+2ibEz47ah8BN73zDx8lvBOvxj3MYHdEtVHRaFOD5rRfx8G70M2TPjZUxEN4DZ7/gQFS/9cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJGanKr0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJGanKr0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso9713735e9.0
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025133; x=1774629933; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MfuKThKzXt3fkNZWzgUdvWd7zC9SPin4+1CCyQ6ZZg=;
        b=PJGanKr0GZwJfWeQv5oS4amzCkXwFa++wJ+z37KfJ9ctsTLDYMXAwWS12HSeo5skEe
         vYRVA69RIWXHC0Z5BbULddv40G3I3fXAU87xCc5adFFOhBWbteNlSGvQrNQITGBSeDy2
         zhN/hBjoFHubB5Uv2hqXFWE2KATXXfWNZz8PTLyn2MsQtnfORV0z018+qg69TDT8Amuy
         U5ZaOJ/zReFuWKvLGSbTfKF0UANcNK2lL1ZLIRKZNMPKV7fEMFm7L6DKqOIm4SSc7RVi
         Ky/Ghem9DOlvUfQ90BPacd73mcaWytdltChiF2G0wpUjxRZ8Fmu9udsiHw0RQrbC7unS
         W49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025133; x=1774629933;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MfuKThKzXt3fkNZWzgUdvWd7zC9SPin4+1CCyQ6ZZg=;
        b=DWTsjD2R0EoKiyVAgXh7PVzq1p1GItDnpqY2ZcQ0U9Gv+oLNuDpTZEVdcmdAsqu3hj
         QefNFYYrww/GAll3Cv5vLf89N2R1zcLQEHaGd79EXxmXqW/s5bjCq7KihopTdV/n2QRV
         eI9InGTAVAbBeSVcC+p3nU8rF4HsuFtxxa/vya4kNASyjHK7j9wCWLBeP+Zhg0PRKE19
         sTPt+nVhgP6zlFgPzQRc/qAZRkqvnahw1YnG8BNQPCb1DJ3CFHrMHLYbeXxsh2dNfaO2
         /4GbrpFsS/1olHCYn9cSo3v3J1OTi/z7J88UQkqX6XgMGbEUnw3yDNGxxqgLLuXX9Nb2
         wc7A==
X-Gm-Message-State: AOJu0YwyoDtMPvyLoUUhzbyTDRwqdL/j347dyyJaoGGcP9zZlJpl6Qb3
	oqdqogEEHz4T8sNKUa9hIPb/OZDjlZ2blEdVCZCA9qdjO6GXbaeppa3n4ENtMT8X
X-Gm-Gg: ATEYQzzrAXXc1ioSAiseeCBfiXayfveteNvy4fAWbUmfa/DyERBH3QGZZQvh5Le8Lpk
	26YOD84kxwmnqm6/M7+i34J4qjL2aFhH6AIMjU2KT/txXMjv/hQRhLTVad8bj7WY4ocszT3s6lO
	kz8h+5zqvNneuPQBarfLTa/JaopfZYV4yetdWkvKmuKIo7VFYf0aHZDSWMZiK8SvYPwqfaZ5WlB
	7z2Su6w7BSpdEHFjtw/e+0Xqm8znDIdmxy9SClD87gFtoOI4Zv0CWRnnurO5iYid+qoI4yNLqxZ
	SuhRt7DxhP+HYIkSMRAYeHUGijQ9VvSv/JK9m82IIgoXW5P6HM0Aa+ibTAGAofHCOUl5+P+M/QI
	8GNdLrk8hu8L6jLFZWILYkY+0D3yaWGFu1MgsrEMm2dKXNV7QoIApfEmLx43mV1ui9dkZGjd077
	BdPnYqzQsQfbVs4v6U+T/Doncn9btMFCfqqfQHfzGzm2tt4Txi9KcTye1DKf2nizTYjtILV9Zpf
	Tkq0dwZ2mSVOS3bgVVnB5lKYjdAn0RFbgcFBQpQ5KMY5sHOS64X369sAzQhbx2U2ldIgH4TrgGD
X-Received: by 2002:a05:600c:8710:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-486fee01a9cmr55252855e9.13.1774025133110;
        Fri, 20 Mar 2026 09:45:33 -0700 (PDT)
Received: from Tunnel (2a01cb09b013a2c6b23e8799d065d8e3.ipv6.abo.wanadoo.fr. [2a01:cb09:b013:a2c6:b23e:8799:d065:d8e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c7fsm8283790f8f.23.2026.03.20.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:45:32 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:45:29 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf-next 0/6] Fix invariant violations and improve branch
 detection
Message-ID: <cover.1774025082.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset fixes invariant violations on register bounds. These
invariant violations cause a warning and happen when reg_bounds_sync is
trying to refine register bounds while walking an impossible branch.

This patchset takes this situation as an opportunity to improve
verification performance. That is, the verifier will use the invariant
violations as a signal that a branch cannot be taken and process it as
dead code.

This patchset implements this approach and covers it in selftests with
a new invariant violation case. Some of the logic in reg_bounds_sync
likely acts as a duplicate with logic from is_scalar_branch_taken. This
patchset does not attempt to remove superfluous logic from
is_scalar_branch_taken and leaves it to a future patchset (ex. once
syzbot has confirmed that all invariant violations are fixed).

In the future, there is also a potential opportunity to simplify
existing logic by merging reg_bounds_sync and range_bounds_violation
(have reg_bounds_sync error out on invariant violation). That is
however not needed to fix invariant violation, which we focus on in
this patchset.

Changes in v2:
  - Moved tmp registers to env in preparatory commit (Eduard).
  - Updated reg_bounds_sync to bail out in case of ill-formed
    registers, thus avoiding one set of invariant violation checks in
    simulate_both_branches_taken (Eduard).
  - Drop the Fixes tag to avoid misleading backporters (Shung-Hsi).
  - Improve wording of commit descriptions (Shung-Hsi, Hari).
  - Fix error in code comments (AI bot).
  - Rebased.

Harishankar Vishwanathan (3):
  bpf: Refactor reg_bounds_sanity_check
  bpf: Exit early if reg_bounds_sync gets invalid inputs
  bpf: Simulate branches to prune based on range violations

Paul Chaignon (3):
  bpf: Use bpf_verifier_env buffers for reg_set_min_max
  selftests/bpf: Cover invariant violation cases from syzbot
  selftests/bpf: Remove invariant violation flags

 include/linux/bpf_verifier.h                  |   4 +-
 kernel/bpf/verifier.c                         | 185 ++++++++++--------
 .../selftests/bpf/progs/verifier_bounds.c     |  46 +++--
 3 files changed, 136 insertions(+), 99 deletions(-)

-- 
2.43.0

