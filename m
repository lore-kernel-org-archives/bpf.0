Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67EC3CF1F1
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791612806; cv=none; b=Hjq+8gyAhTrwEOxVK0QiX4CIXWGrXdMy+byeUlAHrGMkcn+ccp4kQXEj7Y0mT2HLlnewpWHWykuMCcu3AXb3nlgqwwVw4D8tHmjQQNNWAYeS2y018bd5tSD3F8XoI9u5n1xFUKjNCoMIVyOiB3twBgh+D3kTfD6aohcH2X8YXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791612806; c=relaxed/simple;
	bh=tMJkYvulMtZoHXCIMDBtyux3VJSGnuKAgnQddvB449o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RhLSLPZtS5ZJg66J8vO+4cnycBcqtiSzDcC2tMKneWzDxTeVA0MqUgC4mrdLLlnMtY4JUY9ECZraV1EL3Pjur5F4IO3eg2TGVslBfugyPKNHxQlAS+/JXSYkMAEnYs/x2fVyEUna0aNjyQiijTO8ZrLmuL6SZlFhUtHFiCDSKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXUph91v; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXUph91v"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-157fe9d771bso195603c88.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 23:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791612804; x=1792217604; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RIrcEstVTogFp9RImwQFeI9nI9jL2oL8CAZZwCd1xaU=;
        b=HXUph91vJyZA8qAfpuaeEb+oK5VIlhmR8r3dsjwg1CuY/4N1RKkceEAJGDCHsdL3A6
         Q+xo0UvD9V1GlAuS+Pr4frMUu2I5tqMh61gtBEaJbWyI6qL644E7ALhGSg0GKBXA6+PQ
         +pSEOcRlQpvKgS0uWuMuVaKLRlIt24HxLTDPfshB5vuIRYXamAuKUmUdjui5oBMit+v8
         xxSoRxzZLS2eHCc4J8kEQIP7d9yQo1+/HaC8E36o7It5OE5QXvbVSqnbXFdNs9VAjH2E
         oXnjXrdX236qIQ5Yg3y4+D2UL2WYURaGP+9y43U830EhMcSX/mhc7IEyoPyqT5q/R1O5
         VuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791612804; x=1792217604;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RIrcEstVTogFp9RImwQFeI9nI9jL2oL8CAZZwCd1xaU=;
        b=akqN/C3A4ync6Ti6f22n/P8Rsh61oOUIabnEB36OweVaWP14XiUVcZdaFHZAxQ7hMl
         vlQKjRp45ZJFQQ8lV3Ta3A3w0x4ehbj1/DG4hcgS9ZicEcN7et5ZLyRlBnaI6kWO/1sb
         CEPa4Xv8afi6UPb4E7sUFgv05mB0hD6OclDYkAhPTexw4hSPW/cwnMzuRPG/ZNebWEWP
         RNdV+GIF8nOkFO89x76Xvy71fbCGJ4/wsECxY3FZxSIuem7vG8rRs9z565GutZ1k/A3Z
         D6+E3xVv9QyBXx9iu4/rIoHT/GQBhDLV+0uWuPrVwJTj4iG2j2aThy8VAQOpqrwkdG7n
         Kmcw==
X-Gm-Message-State: AFq9FYKw5S0UFpDCrXAqpVPDoTdbCo3tydY2LZk/BNXecOwAfp3akCj0
	YQD0NWLk8ufYdV2XCcDyWzT6CGIN241mTg9nzvf20eRz8GOo3SeJ4ZOV
X-Gm-Gg: AYBFou2cCVKrvIhQ3x6OmAv9TWDj2nt1mTUCHQM2R/g2BpaoeAr5YI4IWOCIS0BWheh
	AiEsgxphG09iwlVlURhsaE/X0SXucxMiVhn0FM60QCf3iM/5nk4+NltbemT/aiwZ3x0OyY6LUSj
	tQDZz1QneUFFdV49cDmK84Cp0/xv42gTUv3mKETKFIjKL3v7VXZMEnMRPBUDxEcRNVU3CrtMneP
	3FL1j9NfRXKU4vDxa0Zyxmfq/3cSpXvulMEnFDwKkIgjrmUhXfTc9v6yHu5vamrGzGzRJRbxXls
	ePj8mqXf8oDjUzpB4TIuMJKCIZCRgJoS8VIKDH4kJnJylPKdbNByawqfqF8kVuMY0OU67bunMdu
	C2qo1VaLP+Tb+Ikf8yyKM+IfkrNKjniWEPqDfRLXdrhjSSMbSBfuO+XpItf3fZLRBX+W8Z0qlCn
	P08MUlF8kNoH/J8c+W0XtdtHu9ns6YcYj5qUtYKwAekxGVrmqJR+1p4fMzd20EQQYcag==
X-Received: by 2002:a05:701b:230f:b0:14c:8461:b3ef with SMTP id a92af1059eb24-16a5f112ae7mr5922654c88.24.1791612803634;
        Fri, 09 Oct 2026 23:13:23 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a5866477sm10558036c88.22.2026.10.09.23.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:13:23 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: Fix a struct_ops use-after-free
 behind a flaky assoc_in_timer test
Date: Sat, 10 Oct 2026 14:13:17 +0800
Message-Id: <20261010-selftests-bpf-struct-ops-assoc-timer-v2-0-d7a43896dbf1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH3XyWoC/5WNQQqDMBBFryKz7pQkYku66j2KixhHHVAjmVQs4
 t2beoMuH4//3w5CkUngUewQaWXhMGcwlwL84OaekNvMYJS5aaUsCo1dIkmCzdKhpPj2CcMi6ES
 Cx8QTRayoUcZW5EulIF8tkTrezswLfruZtgR1NgNLCvFz9ld9+v9Sq0aN1tm7s03Z6rZ59pPj8
 erDBPVxHF8H33M94gAAAA==
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

st_ops_assoc_in_timer_no_uref drops every reference to a struct_ops map
and expects a timer callback of its prog, 500ms later, to find no
struct_ops associated anymore. It fails now and then while test_progs
runs other tests in parallel, and v1 [1] made the test wait until the
association goes away.

As the BPF CI bot pointed out on v1, the association goes away late
since commit 5db69b0fbdc8 ("bpf: Make struct_ops tasks_rcu grace period
optional"), which moved the RCU grace period of a struct_ops map in
front of clearing the association, so nothing waits for a prog that
reads the association in between. With that window widened, a timer
callback returns into a freed trampoline and the kernel hits an int3
Oops.

Patch 1 frees the map only after a grace period that follows clearing
the association, and patch 2 adds a test that catches a map freed under
a running .test_1. Patch 3 is v1 of the test fix, which can keep calling
through the association until it is cleared now that this is safe.

[1] https://lore.kernel.org/r/20261009-selftests-bpf-struct-ops-assoc-timer-v1-1-9a97a9b3d1db@gmail.com

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Add patch 1, fixing the use-after-free behind the flaky test (CI bot)
- Add patch 2, a test for the use-after-free
- Point Fixes of patch 3 at 5db69b0fbdc8 (CI bot)
- Move the restarting of the timer into patch 2, which needs it too,
  so patch 3 only turns it on for st_ops_assoc_in_timer_no_uref
- Rebase onto current bpf-next

v1: https://lore.kernel.org/r/20261009-selftests-bpf-struct-ops-assoc-timer-v1-1-9a97a9b3d1db@gmail.com

---
Qiliang Yuan (3):
      bpf: Defer freeing a struct_ops map until its progs are done
      selftests/bpf: Test freeing a struct_ops map under a running prog
      selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_timer

 kernel/bpf/bpf_struct_ops.c                        | 30 +++++++++++++++++++++-
 .../bpf/prog_tests/test_struct_ops_assoc.c         | 29 ++++++++++++++++++---
 .../bpf/progs/struct_ops_assoc_in_timer.c          | 16 ++++++++++++
 3 files changed, 70 insertions(+), 5 deletions(-)
---
base-commit: 15b578b1715d9a318c804350d98af87c203672bc
change-id: 20261009-selftests-bpf-struct-ops-assoc-timer-5eb0295ec300

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

