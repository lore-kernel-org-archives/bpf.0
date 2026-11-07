Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070993;
	b=yNp7Ksr4gXKmpxU0DWH/fvrawAIrHAjqKfFooVISgX1UJkoi/ymmDLsDgrx4x15F8LIe
	 OUS74RBLjYWDR8RyR/iXRPqaUN+3PFbX5GmFP6TUL4/Zb06p33s3I0oUKGTt0FAeHynnZ
	 Zdfyb5Be4F4XrKzS8iLRnxrDH2+uPVgXGzBhfB030rBJ0GgFY3imrHAs8eP2rYnAiPzJn
	 Qy+MFtwuKDB1tK864roneh8JFGrpblMFPwOUp1UfJxyiJjKCK1297q7cKNpQwbNkf0DdB
	 dCOncMVSIlxTrkHtzJM1DEc9NOhKUwpJtsTXFzKHJK07WPdw9eaEUV2J8iKr1RxpbCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dzKyDlfb0fuA5dN3woK0R+lL7Bjc52G5Sdnl2ONBuZA=;
	b=k34E05+dYs1+l7YzpDKf+5jjO3+RnVLHLayFlhffu31wbDvE3AVc6onF4AKnupeIgnzg
	 G8M0qecEumSIiz5+DMeZtWnJTLZpBdKk7DKC7KNLE1Gl/MEdWrK68g2W+Cf1tTLsSwmLu
	 afN7IpGS24asYWAmRIgAHIki29St9rtc3YOICyUmRSaYFE62LGxZ9V8BoIYfYodexxOt1
	 TFXwA4o7OwHw6AgPPJemAp27G96JEfaJH/ouRC0nR2CqCgro5EgvXRrW2i4Dcae2KHDH1
	 fNbKaNhWDxunGeBef9xUbMT31LfRTV0fW/LmzIvHv63re51vsL8dIZNjdwyo4LWA+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVI+JA7Z;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313C606A32E
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3313C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVI+JA7Z
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso1152417a91.1
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794070992; x=1794675792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dzKyDlfb0fuA5dN3woK0R+lL7Bjc52G5Sdnl2ONBuZA=;
        b=FVI+JA7Zd3zMABqmEo/4xnz4qkaJlEyJJdvJs22HXBiQgkyOpPs/GvapcvKB1c4rwU
         2nEoVmvX5t8Bqge/R8m3NVNSzjhw33Fh6wlEFFatDye9NOx0cMX+edBCvRc4nhzKZHYb
         OrAZmbSc7b5ZJ6mdeowJlqZI7VKjqUBz5J5mDm+JZW9WRRu9JwS3+wiZS1NSLRqTpQWT
         87giBBERwL9sU/PwMsv+SdjSEqaTFlI2p8sPsLgMEYvPQJawuLJYDqOYOAL/H9d03Rqw
         SoJzoTU6o9/Me/oVhKmJvfuVSquhJF03BaiK8V8qEf2Gi5lSwnw7jWaw9vh7b+AWStjP
         TTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794070992; x=1794675792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzKyDlfb0fuA5dN3woK0R+lL7Bjc52G5Sdnl2ONBuZA=;
        b=K/vzUczu4dJqQUTV7cmqJ35tWhEwaN2NjubeRA+HypY9UIsboLCMAqdgsodbEbat1q
         m+/WZgriFuTByBu5nAlqG1xRjQ78HHq+x3h3vhQKcGHMmfI91HRFWjSMguTNT+4BqQzJ
         VABFMI+STGcIyCDawxsQikv0lPuq5es6IHgpWoKeEIzRXSoOWF80BG3vL9IjX21cOPUy
         t1j0Z9GPVO50k9tQZYMcYsNhb3A2n+IQVVwEehYcdBPmkJwmlzQrzhxj6qpRPlgaoCtQ
         zO/18fs99xUdF/cZ6NreYPbDsLCa0CmQOw6H28Op4WrG/2G4YqVUjV+l0G4OJgTaA581
         47Sw==
X-Gm-Message-State: APuU4Z89Bqm4n3npYSP6XQxhhZCTwfYhOR80bFeOqNEL88RmlHpSrvtq
	XzGhm+VS3sLerHIIKo34kV/TWU/X4mkfyF4EYpIIR763lhxi99IC9FmN2+bw6Q==
X-Gm-Gg: AYBFou1YkQrdtAt6m+DoyveXjIpiFmkMcoCdUJTRHBaLgFCNhbBLMJiNs/n7oF975iq
	CYloYgntTv3vpRvVrdrlYi2kjObz6sEE/nC/8PiMAqMlU4YciHUGkvrd7TjPn2uGKCEIrptwugP
	6JZeKhkDbKKpDWA17EKCfiLuf6y7QjIs0p1hA3gapPrkJ7gorDsUnFye8oZcDOgGxrLl4rqFPHu
	ECAdUl6ZxScd7+o9G4re3TEIsX5ltPNAJnm4LobvTKfpz0cb+Tpf1pq+TOm3NLRleJbXRt5/d9Z
	d85NECJ97t+gsNJ5v6hR/zDZxw6a1G1/Tv5alYbngHVhxQDYhz6+Pm8TvWKHRISs44ARN8t5MH1
	ZavVOEed93jmj1UClNWtgSaw/17jaTZCTdBGgRuQ1aQRb9dxgDMT5ic6KhnblTcKKrqYN+daxF8
	FQY7+rqgIcD1qybEpyjcPx+FcVYS6sTNnIfCN2eDBDgtB6j1BYDd6JUjf00oO5CgzP/2McbTu4c
	GWIPhXeohm0lKvRyDbN3TybKaDrceVFk60NHKcOGRvqp4iGiQFEijSOh3NaKhNeDyzL5FImKDlW
	1nrATvqcWMb6jRGCyoDjcqT9V7AQ68t8u4tB3ZlXsw5iaSptRIJcdClwtU8vLAnzNMWJMOE000g
	W2RZSSLGaiTDSOa/Wuiu8TX0XgePrnGakQbx8xatwXcrKIcLAyD3B0KklOo9PqllljTEdEiUc5K
	jT1fUOGmsjfk6yRE92mzA=
X-Received: by 2002:a17:90b:2748:b0:3a8:10e2:ad08 with SMTP id 98e67ed59e1d1-3b0db6eca36mr6358763a91.48.1794070992325;
        Sat, 07 Nov 2026 09:03:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101bc4586sm2382498a91.2.2026.11.07.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:03:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/9] bpf: Fixes for the verifier that joins states
Date: Sat,  7 Nov 2026 17:02:57 +0000
Message-ID: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

Fixes for commit 2d0b457611c0 ("Merge branch
'bpf-a-verifier-that-joins-states'"), from review and from BPF CI.

1-2  A number that wraps in front of the jump that counts a loop gets
     a wrong residue behind the jump. The verifier then checks numbers
     that the register never has.
3-4  Two of the new tests fail in BPF CI: one with GCC BPF, one on s390x.
5-7  The same kind, no job shows it today: a message with GCC, a target of
     fentry that is not in BTF, five tests with an arena that run at the
     same time under KASAN.
8-9  Valid progs that throw one of several error codes are rejected.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (9):
  bpf: Leave a number alone that wraps in front of the jump that counts
  selftests/bpf: Test a number that wraps in front of the jump that
    counts
  selftests/bpf: Skip the stack walker of verifier_loop_latch with GCC
  selftests/bpf: Skip plain_c_test_wakeup_source without the kfuncs
  selftests/bpf: Expect GCC's first error in test_alloc_double_release
  selftests/bpf: Skip plain_c_arena_race without zap_vma_range() in BTF
  selftests/bpf: Run the plain C tests with an arena serially
  bpf: A join must leave the cookie of bpf_throw() alone
  selftests/bpf: Test a flag that goes with the cookie of bpf_throw()

 kernel/bpf/flow.c                             |  4 +-
 kernel/bpf/scev.c                             |  8 ++-
 kernel/bpf/verifier.c                         |  3 +
 .../selftests/bpf/prog_tests/plain_c.c        | 34 ++++++++---
 .../selftests/bpf/progs/cpumask_failure.c     |  5 ++
 .../bpf/progs/verifier_jumps_ahead.c          | 57 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_loop_latch.c | 26 +++++++++
 7 files changed, 126 insertions(+), 11 deletions(-)

