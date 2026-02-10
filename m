Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF20148850
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748383; cv=none; b=K5ltPmTAgeBuzRktY1X+iy+bYrB4GC9aQjoqlcJU5jRrfkh/8rwQzphtlHLpx0mwG9l2VhhL28VJeUgOqmBtLaQroj3LtIz2yx7g+RHaM/Rcn9KLQCMv0UwxngKuVIwoAjCJcF77lwgo174hNV/vdBjBE0rV8ylfhSD97pBv5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748383; c=relaxed/simple;
	bh=ATFrnZePvUzu0sfQ1RWZ+PItW7G6U4XLUxckhsDIkqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPspUXra2kvYpkUG+Ugbq3kH0c0YdJHLmXtq5K7LCiP+TUca+DSDyWrhfKP0UAr3w4FtNCDXVQDbjwsIYgvJGSyeGMjdpCQEbBycHjYkUBkE53mJc1f2HRnHzKzIyHcNFxGql3bNOXSb4K9cZBcN2n2nuV8nw0D+VAKs/NZjecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=wBWAxTw5; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="wBWAxTw5"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89503a3bb83so9865596d6.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 10:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770748380; x=1771353180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yD1gALP+CFChmDyhIu6E5QKeuXVRMTgmn9hdC0RPuIA=;
        b=wBWAxTw5pBR8ToIlIx5jDiMBEmRurn5HAWsFoqnBHizkL3YFTuv5ZHb4kOcc4325lm
         0gSvcH1nnjxlujh0jDmw87zyhzB88UL56YWj4SUl27RfbbKOrNlL5mjzpCyMwTF9Myt2
         ZM3BE6Bx6xlrTW3uyw3DXEDOFbtoO94bOfzmPHqMAoEEKuxjoDsMSNRMdGjwxSZAK5AG
         smeepsrZFNpR09pPQXjXdgCiqE09hXgGjZRLle7hXjRXoWMbiZ5KurFV7rysxdEaMzyA
         wTLGxsEHKnd8FzPfDCL7xkcO5oVIXs4mZfaOp149Y/tWZ4iAJhJ+d4ydAZexEJootrcl
         mb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770748380; x=1771353180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD1gALP+CFChmDyhIu6E5QKeuXVRMTgmn9hdC0RPuIA=;
        b=NniQoxVGlAgfOLfEd4gWe3Bqb8OHNjciWNXZouPzg3oF60J7SbzCDOgX5wwwq54tmU
         Ks0HUN9EfJEYDsLLwU0iyzRR98I5a6OH1DiCHKlqjss7jn/HEKHaVDRxwgNN1R+o/aga
         ZOkiEtrqQP3oV2j+Kmj0BrKKaiQ7UcjJS7G/SLaA6ueYRr/oV58ZT4eZa9AKPPTcBiGc
         BkYu9IsiiAHfLsHJaO8ZPIlv90M4kKvE4hr3ek+Hf7OIQaWScllolC0iLMT9hPl7rNxd
         uOMEQcEbrRhc10OFnzjOTzNBNakSyxtiyI2bakrK8F0zzGDcHfPd0ggoK6ipIBScc1xY
         dEuw==
X-Gm-Message-State: AOJu0YxI0FVkd37lYeiqgOdSob68+g6S/unJxS/AogLEmE0OVBzG8WCd
	+iny+5zDwQuruuJuIrjJY0VvEP/JELwqAW7f/JFPRsv+2AVboGPR/Zjn/3WUQNIwPWQm+/COQt4
	7g3HJSk0=
X-Gm-Gg: AZuq6aL9qsDDvzm3Yn2zhjllx+z0lOCZaRy1+5SEtTJ0JWPtQ6THNykbysAptA89sAU
	Vs2OHB6fwnCD6hCqPHWvrhI0uM5kYWKxJPBnbKYqLwx8lWMgDlepATUlE0gOplelw8X07918t83
	tjqInz5kEqTjfbMq8peFuTzzIAGAlN/Bo6702EL6ogFJKJJH66MwC5XzH4vik/EOQNdO2S/yTAh
	3puQQZF2bmoKXwhL2kyM7GOV4lPIr5OHbd/zI6QjTe8LFhjwIib9muqLwSPMByJFBQqukmHAWAF
	m/NP2KN5nwZYjoe314gjHAQdvt2arJsYTSVdSnbS6MtToubewb00vH4SJTLLP65JxZmUfXnNaek
	/LLmHZgyuP986wQ3rlV/2rEfnniG6dw3cDCswst5lvKtKL5cus3Jrk+W987tmH2KGQXjYjChSjd
	0X6FtvdSE9FIUwbxktLMiAqg==
X-Received: by 2002:ac8:5945:0:b0:4fc:8ed0:d4a4 with SMTP id d75a77b69052e-506399fe0c2mr229293321cf.64.1770748380064;
        Tue, 10 Feb 2026 10:33:00 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5063913b829sm105348641cf.7.2026.02.10.10.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 10:32:59 -0800 (PST)
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
Subject: [PATCH v2 0/2] bpf: Allow void return type for global subprogs
Date: Tue, 10 Feb 2026 13:32:55 -0500
Message-ID: <20260210183257.217285-1-emil@etsalapatis.com>
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

Also adjust existing selftests that were ensuring that global subprogs
with void return types fail to verify. These tests should now load
successfully.

v1 -> v2
(https://lore.kernel.org/bpf/20260127231414.359283-1-emil@etsalapatis.com/)

- Only mark R0 as valid for non-void global functions (AI)
- Rename subprog_is_void to subprog_returns_void (Kumar)
- Add test that R0 is invalid after calling a void global (Alexei)
- Add check to ensure exception callbacks do not return void
and associated selftest

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: Allow void global functions in the verifier
  selftests: Add selftests for void globals

 kernel/bpf/btf.c                              |  7 +--
 kernel/bpf/verifier.c                         | 49 ++++++++++++++++---
 .../bpf/prog_tests/test_global_funcs.c        |  2 +
 .../selftests/bpf/progs/exceptions_fail.c     | 19 +++++--
 .../selftests/bpf/progs/test_global_func18.c  | 23 +++++++++
 .../selftests/bpf/progs/test_global_func7.c   |  2 +-
 6 files changed, 89 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func18.c

-- 
2.49.0

