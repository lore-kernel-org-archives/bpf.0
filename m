Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86A421250
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831078; cv=none; b=Ic51tRsFIKLAzRj0V6AK2dl6SbG0DXP4kuS8pWlH31hwUt17fOyco+bAQrAxtrEsCvjAaM0surVoatbXTstDhOv/b6UJMS2A0oD5QqijurrQrSUvWF/EegK337IQOMFR1GeOjI/usCOvLHDPTS3/XfZKbRY89QBjcZfmzvO7+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831078; c=relaxed/simple;
	bh=/lU4HMhT3FLCBzktT7VqVQwIX7G5Cd+VSjYK8XMHhvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eye1mrB2XdqGN4HuNedMR1utxVz2a9Jha+rCBznfmXAho72GOALklZW42dVYv9pmgh9nbXflvHJo7uTFIYS0+IBRWy6hbkKgFFcbQM4oQtjubY4VmddEvS5HwrHKJrTkGMNXFsxBBVmkup823/K2JUVJhZLjI5xkDPBSefIthhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb1DUXun; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb1DUXun"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso8884025e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785831075; x=1786435875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5P4cgYktXXA+ISQ2i8dFfS1V2EScAem0D4JbJ4AIyNQ=;
        b=jb1DUXun7PwqDQElioF6yGXAlGQfD/1uH/CCTWXHumlyCEvWbTcoQo2i7ZLvQLNaex
         UOGtDGCkYMrzUW5i8k6BhS5d/ZSMLqGJtOgi0vrQ1bYnNqzezYfqMUXk3rerKdK4n0oZ
         vlMqsL/GcaQchy/CqSfz8yLepY8J2jjidPmEI0DvDcoxKNGetzDVaYDm5+1sg6s4/jox
         WSH6/dxo2vDcQfo1oLaabBsThntIA9oqyXmBGG1o0R/vbfxWTZAH8as8mCMp4lcMucws
         CZDpOT4DIFQgHc0dmGmRwo9lNTGaqYdph7JelcaC4/wWZ4NPQPLGIK8PIGtXUnVHZR8k
         ND+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785831075; x=1786435875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5P4cgYktXXA+ISQ2i8dFfS1V2EScAem0D4JbJ4AIyNQ=;
        b=D4VwKDCkRxfyrxK2YpHqf2wZ2F1g2XsaKkyRxf73kyG2121PuDjOaS2eGNYONf8Iu2
         EYfKLVTXgfgtHo5M67uQBKJOIIpEUVbR6aJJM39q0Q8zgyi/gYEO8yF/NvGRgVUSIK7d
         EScgYUUs5KhsZWBoR1fuppevM6F7Ja8VfVo31zC9gAplXrGh9i13UhiVQRKIJhF9Blww
         ntw0fVUeAXpwcizhYZuOwwaf5IIS7OPIAJCj8TRNoHiQwlzq2KALWg9odNli0KRnT1cc
         HQm1go8Krn6kTN13xRLUEdf+/QV4iEErUSAsJQKxw60ABh7w8ziWWrPdUnaVHTRQKinJ
         8uKQ==
X-Gm-Message-State: AOJu0YwBvFcniN2/4g3pv3ehCO3KRVtOYyHvcZkdDhPbAlFbG+YuPcyB
	l6VO/eAMXFzo5Oytw07ncym7jlyb5bZMP4M+QmacaA0GaRpLkdDUIv/eupq+xyiI
X-Gm-Gg: AR+sD12Gdiyn1zp6yt+EHI+Z531zL9OACaPDe/uYFT//K9aURpyUWUdiIGUxcpMdu4t
	/zy+ULtAdDAa9POYqPCSigG6vlNolYAmXFEV1Lbl2McAzzQ25U4j9WElfIK0NMlsZfFZYathe59
	Wmq+Jw0dWqlLezfeuh6mDK67B0Y1cBqy+x9lPqSjDFboNAa+qg/s3CpOhOkU7TTjVj0zoJxvJ8c
	mD5EtiYeq79LtlOQli3ZV4smvAsSHKPIcynGbHAYQ8tbGnGYO8/l/Ibzb3vx5HWjSABYKmvABen
	p5BzmFrAtZX3jyUbAePNsTmLv0AA3jvCJAei6gEDZ7+2fvur86p+WrN6PmsaMI6AROjpbzsjgXZ
	PdPkwaWu8smcOLevMKDEGh1mHHvYA8mi2eGKjqPTkeP7cS4vKBEchYI4X3K4NiBAnxJKmQFwdPu
	N1kZVmNZMg4DjpyZGKWV9P+Hxjv1xD8amSEI0pup1jx6jMkR5A1JLAqm95TDSCFFurtvZsvCjxe
	QfdFJ96kvA7+1D6CRoayibwd09WU+0DaJxvEj1go6WNUzVdwrt8SsA47zW7a6ltiE9r0QZTGfq4
	PeidAENDdfKORioppkXTdCjvaQA=
X-Received: by 2002:a05:600c:3507:b0:496:cb48:5eb8 with SMTP id 5b1f17b1804b1-4980c6747fdmr198167725e9.15.1785831075420;
        Tue, 04 Aug 2026 01:11:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562a38sm39931335f8f.21.2026.08.04.01.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:11:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 0/3] Improve stack depth verification stats output
Date: Tue,  4 Aug 2026 10:11:09 +0200
Message-ID: <20260804081114.3871564-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=memxor@gmail.com; h=from:subject; bh=/lU4HMhT3FLCBzktT7VqVQwIX7G5Cd+VSjYK8XMHhvU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatwnm9i94x7FVqSe87ulTpn2Piv4fq75TY6+RNz3906H xd5pP5+RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACay/zQjw77JtRc3MiREbsli mpwguJm34aNTlkD/XN2Hlg3ra6+mPGH472f3evEbxl+hBa0zZ69Wmnrry8kX0+w5PhlXu23Yf+T hIWYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some improvements for more clarity in the stack depth verification
statistics output. See commit logs for details.

Changelog:
----------
v4 -> v5
v4: https://lore.kernel.org/bpf/20260803072733.191502-1-memxor@gmail.com

 * Change the format to combine instruction counts and stack depths into
   per-program records. (Andrii)
 * Adjust veristat for the new format while retaining support for the legacy format.
 * Explain why the legacy stack parsing buffer is zero-initialized. (BPF CI Bot)

v3 -> v4
v3: https://lore.kernel.org/bpf/20260803031457.3115812-1-memxor@gmail.com

 * Read names from subprog_info directly to avoid an out-of-bounds access
   when func_info validation fails. (BPF CI Bot)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260802225209.2511758-1-memxor@gmail.com

 * Reuse subprog_name() to fetch subprogram names. (BPF CI Bot)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260801230400.850271-1-memxor@gmail.com

 * Use multi-line format. (Eduard)
 * Adjust veristat to work with old and new format.
 * Adjust selftest log_level without new option. (Eduard)

Kumar Kartikeya Dwivedi (3):
  bpf: Show more useful info in stack depth stats
  selftests/bpf: Adjust veristat stack depth parsing
  selftests/bpf: Test stack depth stats without BTF subprog names

 kernel/bpf/verifier.c                         | 24 ++++++++++++-------
 .../bpf/progs/verifier_basic_stack.c          |  4 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 23 +++++++++++-------
 .../bpf/progs/verifier_global_subprogs.c      |  2 +-
 .../bpf/progs/verifier_private_stack.c        | 15 +++++++++---
 .../selftests/bpf/progs/verifier_var_off.c    |  4 ++--
 tools/testing/selftests/bpf/test_verifier.c   |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  9 ++++++-
 tools/testing/selftests/bpf/veristat.c        | 17 +++++++++----
 9 files changed, 69 insertions(+), 31 deletions(-)


base-commit: 457d4ecb47aaf7a2cb46aaadd76e8c812e4f3c9e
-- 
2.53.0

