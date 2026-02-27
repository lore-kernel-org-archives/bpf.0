Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8E843E9F6
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207183; cv=none; b=eJEIuQ6oJyfNAGLU6zJw9V6BZjvqneQBopmFeRnTG2dSIxx9/WbeNwHJX5jivHoYMhCiVd5le03VJbAjC9QQJqTdNKHMW5pFPn9cEl9NLZP8eAm1oiwnnSXNtOUW9OrOhnSLI+2FfUUXFi9+PD4sJ0qaCGUJ6+V6ENde/rfjM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207183; c=relaxed/simple;
	bh=1LYPB+tawWemrkFREErpEpiCBL3a3mHOkJjWsP78YFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NR+tHytq6m3hZq4z5BL8Ib6/Qtto4gka39xhi96tZ2h4Q26MuFOzeIEZHsWa1sQyF2DsnIpAHW/K2eFctGurHX3w6CMKLCxtXTd2eMq8JKqVrnFOm3IfkRn9v+0yS9qbd4/5KRalK1F+WpRAckAbB8aXjlIoSSbczIUN6+mA/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=vCOfDE24; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="vCOfDE24"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6f21c2d81so212683685a.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772207180; x=1772811980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CXWShtygruyoPSdmjDvjqAKepN8unToMh7eTLoaRe1o=;
        b=vCOfDE24DePGN+BBxDDcazhMSYJq+1/xvhZt8NVBK+7dpdF+RhKIih1ClUb2bIDUPB
         SjPqyrEaA3CYfKnCwoCoGEah1ub6eEQI0JFG/HXiaYfsZ+G+s2qUPU3aABM5Dmh56Hml
         h6U4olgmcUCjA0SUkQiNMTgyPWZA71QuB/bbThXbHXWRbuGqdmxWETQD1995yPzbgxnv
         fuTL0zztyT/Z9LzpfEyDe0VAoe7JiCGpEQnljE0bH8fWbbgipscwuV3x72mAUkSZRSSp
         v6kkayumVsKAIEAWckZbA+vzY42yRihe9LzwNiYDsj/ZlWi7A2b/nNRFYNlEs3Z1Q6RT
         SCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207180; x=1772811980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXWShtygruyoPSdmjDvjqAKepN8unToMh7eTLoaRe1o=;
        b=eVgOdRZFckcQtJ720XQ/9mtM58r1VgSz9Wnhvz0ncp6R161yN/5lSbJnAFNfUTH4le
         nWrf2MLk5/vaEVY4j7dsckL0e37M+x7Qi4NHNiasx3/ZfKGKKx5IKMimqFB7GgLiJiX5
         fqTlcDsi3G/9DW4/bm7DUxg8U61yMcetIPOVpyhAGNZBKWhFS/12H6m+utcIONKYA3Ch
         8JVKdn9Wu0cfSsY3wXstgiBlKDcepYWux/jtcOUyIF7p7vB/1v2/dd9Jt3zOwPKoFJzl
         HQJJjbag5dXBvsjcem+A8RPvX4hZnrgqHlfc5zkCtvmjT0gadx2ZkN7MXEUDmRXG/IAw
         4dEA==
X-Gm-Message-State: AOJu0YyfXdpz1bSAYJx1QFFXK4cxkHxTMDGPKuWPd9BO1IziP15znump
	nx4Dm4lCUEQ/UNTmAhyFc8LQGpLpTQt2vUzDoOh2TnkhPunvTX14jDXZoeXNB3ZcVyMPjGALA5k
	rhF/1qkE=
X-Gm-Gg: ATEYQzypDFz8a9Cky3ga1ivnWrccgX4LAv1iG052cjfE0Az8XDs7EzkZK8HaXjhldJz
	70tiu9hJipGW8uXUiyGD45xEe9IdH4kusatRWuPP4DHzZ67yZcQ6J48qHUOdIfgpe5n4dhxTaOp
	sxu4H4+GwT6CpLOqhXSrtIHyCjJ5tPbhVxyR/fym5xUPjZLNsMGgvZWXuO+ChSbP4wMtJonxLFh
	GWx/6qULlWYG61KSgCrrjyeDdYqkmXvt3S48mfYOarbDcWuauH9pGHfe1jJBo45OKw/HaA8F9y6
	wn4kp6Y/jokTV1N6p6YRpUFKNJvSKtCNEPM2wqBjXx15X8RscgZPSXAHj/nII1VGxWH/C3AiKbz
	Rm6xdoyGMPElZLZwhcTDsfyTttd8TJqiG2Exf0ZozyEFd+ZVA8xPwcZ1DVN/AFXqvNGa/ncB53P
	CRRar1bEFS/SfH22p08lSiog==
X-Received: by 2002:a05:620a:45a4:b0:8b2:dfb3:dc2a with SMTP id af79cd13be357-8cbc8f50ff7mr401585785a.75.1772207179519;
        Fri, 27 Feb 2026 07:46:19 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm544180385a.4.2026.02.27.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:46:19 -0800 (PST)
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
Subject: [PATCH bpf-next v5 0/5] bpf: Allow void return type for global subprogs
Date: Fri, 27 Feb 2026 10:46:11 -0500
Message-ID: <20260227154616.6846-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global subprogs are currently not allowed to return void. Adjust
verifier logic to allow global functions with a void return type.
Exception callbacks are excluded from this change, and still require
a scalar return type. 

Adding additional logic for void globals significantly complicates
check_return_code(), mainly because of how the new feature interacts
with bpf_throw(). To avoid complicating the code, refactor the return
value range validation logic into two separate functions, one for
program exits through BPF_EXIT and one for program exits through
bpf_throw(). The changes are non-functional.

Also adjust existing selftests that were ensuring that global subprogs
with void return types fail to verify. These tests should now load
successfully.

Patches 1-3 refactor check_return_code into two separate functions, one
for BPF_EXIT and one for bpf_throw(). No functional changes.

Patches 4-5 enable void globals in the verifier and add additional
selftests.

v4 -> v5
(https://lore.kernel.org/bpf/20260225033356.518313-1-emil@etsalapatis.com/)
- Split value validation logic from throw/nonthrow to main prog/subprog (Eduard)
- Turn return_retval_range() to bool and incorporate return_32bit in retval (Eduard)
- Adjust if-else chain in return_retval_range for cgroup programs into switch
  statement to bring it in line with the other program types

v3 -> v4
(https://lore.kernel.org/bpf/20260223215046.1706110-1-emil@etsalapatis.com/)
- Factor out bpf_throw() return value validation logic into its own
  function (Eduard)
- Validate the range of bpf_throw() return values from void globals (Eduard)
- Move new selftest to verifier_global_subprogs.c (Eduard)
- Remove unnecessary verifier_bug_if() statements (Eduard)
- Add new test to ensure void globals can call bpf_throw

v2 -> v3
(https://lore.kernel.org/bpf/20260210183257.217285-1-emil@etsalapatis.com/)
- Allow freplace for global programs that return void and add selftests (Kumar)

v1 -> v2
(https://lore.kernel.org/bpf/20260127231414.359283-1-emil@etsalapatis.com/)

- Only mark R0 as valid for non-void global functions (AI)
- Rename subprog_is_void to subprog_returns_void (Kumar)
- Add test that R0 is invalid after calling a void global (Alexei)
- Add check to ensure exception callbacks do not return void
and associated selftest

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Eduard Zingerman (2):
  bpf: Extract program_returns_void() for clarity
  bpf: extract check_subprogram_return_code() for clarity

Emil Tsalapatis (3):
  bpf: Factor out program return value calculation
  bpf: Allow void global functions in the verifier
  selftests: bpf: Add tests for void global subprogs

 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/btf.c                              |   7 +-
 kernel/bpf/verifier.c                         | 348 ++++++++++++------
 .../selftests/bpf/prog_tests/exceptions.c     |   1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  24 ++
 .../testing/selftests/bpf/progs/exceptions.c  |  14 +
 .../selftests/bpf/progs/exceptions_fail.c     |  35 +-
 .../bpf/progs/freplace_int_with_void.c        |  14 +
 .../selftests/bpf/progs/freplace_void.c       |  12 +
 .../selftests/bpf/progs/test_global_func7.c   |   2 +-
 .../bpf/progs/verifier_global_subprogs.c      |  19 +
 11 files changed, 349 insertions(+), 128 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_int_with_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_void.c

-- 
2.49.0

