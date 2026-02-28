Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE234D389
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304491; cv=none; b=jTc/4/h1ISduEMiSxnOHyR32H7BPQsDOUdY88CfqUgoZYCOujzJNHKlQSCJmiPpcT2k1siM7dISm9c3Gpq6Z0Fj7sN8vGo2tf/ndejtClgrgwr1ixx+AKMhwsLCcMvVLxdgGvjWKA5gUql8qY1H4tEFYJgZUiCjBTBFBmIapJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304491; c=relaxed/simple;
	bh=s2g6ibLpkWq/89XU/7atfUVS7Ghj0YTy22RAB3U4dx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PN3x8ijE5D5reb7YLV6Z7GgW+20op5u6ujZRDV8DfoJJsQlLz3oVc16J/3UL4+9DMx6V40BnhLnKYL1weX2Z9M1P3k84XDDlgHCVDAKyQSQ4MUqFjLTn92pj9xP8Sz4V/iElyUmz3gQ34UF1k6JTB9yHjNzM4rf74Wdfh70SoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=o521q1qP; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="o521q1qP"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8954c9daaeaso38563266d6.1
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 10:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772304488; x=1772909288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OMVoFKtb6rEqSt+BaHEeC7/vGupf3OMpDmDnYoGn90=;
        b=o521q1qPasCwcIvEulIgIFHsZJ5s4i9c+OkH5SSRf4Hm/hl+7ugZDAK0tCx01kC39Q
         uvwJ75YR45XHzi6H14W81MyOuLEn95lLGX+lAzNb1dB8glJF7/sczRLhVHyHZq468Gft
         dOY24k5Z/F4/e4omzfU4kTHXemgvoWNIGP9eubdMkX4An0tT/QRG6Jj+0y3ZZ6vQly/L
         Afe2sguHoEdrcTyl1ScoIlLS+8dSekEbB0567RPyhJCLjc9Vj0o2ChWkwhUG/Fy1uCVE
         xyR7CVBLw6B9BmkMoNv3VWy7A0zMiQ0ULOK8ojCiVhcHVQGkxpuIlU5fsWGQUwZzYcSe
         wYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772304488; x=1772909288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OMVoFKtb6rEqSt+BaHEeC7/vGupf3OMpDmDnYoGn90=;
        b=D/jJqhZEHLFUAgI9hy5u3GpwsrwkXdTBvKozY9ChnZQ3e05v5K+xeNWz6Z6blBv0Zr
         zZlP1Mu4LFpv5kqlwxEeai0mjbUPmu1vTea6gSHnlCUa9oeKts+MbfAJla5FV+mJ5pKY
         dx+P3wYGtgBRLfTTHC/aI+EPAMfXctcZpk3UwlBc8goi+3R9pFEu9v1uCB9jfjLWjfxE
         FRqm/bU0H89FW4y+zKL2C3vpcs+uYLL25EAqTh4kzCtnQJDHxZuZkOfQSfQzS8xp5pw9
         WxIjzhXmUxJY3cMoZtGUzrYsDZKnJKVRI7GjXzOPWipSWnKEwkmfgHTTiaUp6YcatvJ3
         tcRw==
X-Gm-Message-State: AOJu0YxPDk7b/6XY298cP2TtZTkQ1XtVrJD8SYLmIH38GUTTU8Pvwkb/
	xam+Hq6XmKspIAf4nQyLXz+Li9gSYVjx8laH18Wqd8Fx7jIpzFB88haCRnPYXaH2LxluGzJ2yHq
	oF6XFsqw=
X-Gm-Gg: ATEYQzxSlFz28WXAb7rj0973k+4WBuFAqklYUxNKBN4eFP+z6vTBx+0sAUYuMvXSf6V
	uea7wrh+RauuIL5K4GVbsjHVeetlsx51akeAZXg7paMQYGBCt6r7YrIBJXpJsbCPdl+//wDst7b
	JOsKEAHs3AhGD9D5Jpc8wGKGJGJw8Q7qPUbeELJhYVw3BkAaWUMmCnkHJJ5wHWUQy9YcZ2Rt+cu
	dwr8aq7z+MfBWgZ8XbqQ6PoXwNF0+6EHEmE061+IRqu/G/WVzD78AWNa2yYEk9mW9TEmoFfBTkV
	EsoZ3fb6+7hU0R2I4wrBLIDFOoQrpgWsA80esLjWNKdSPFQsomWJhoQMVdXwWPaIFInyJpiZFnS
	jl7t4arS4Di2HXS57n8KgG095iTedTddROFLjROuYdET3q3SOhlFXDZmwVZMVnrsgiYXBWX01QX
	FyvtuOftx+5RhT0BWyFj0KmA==
X-Received: by 2002:a05:622a:1811:b0:4ed:66bd:95ea with SMTP id d75a77b69052e-507528d5aacmr95870221cf.29.1772304488037;
        Sat, 28 Feb 2026 10:48:08 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab3d88sm76160561cf.21.2026.02.28.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:48:07 -0800 (PST)
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
Subject: [PATCH bpf-next v6 0/5] bpf: Allow void return type for global subprogs
Date: Sat, 28 Feb 2026 13:47:54 -0500
Message-ID: <20260228184759.108145-1-emil@etsalapatis.com>
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

v5 -> v6
(https://lore.kernel.org/bpf/20260227154616.6846-1-emil@etsalapatis.com/)

Patch 1:

- Removed unused variables (kernel test robot)
- Add break; on empty default to suppress warning (kernel test robot)
- Added explanation on why change in switch statement for
  BPF_PROG_TYPE_TRACING in check_return_code is a no-op

Patches 2/3:

- Added From: tags to Eduard's patches and changed my Reviewed-by to 
  Signed-off-by to properly denote patch route (submitting-patches.rst)
- Renamed check_subprogram_return_code for into check_global_subprog_return_code
  (Eduard)

Patch 4:

- Remove unnecessary subprog_is_global() check in check_return_code (Eduard)
- Fix indentation on patch 4 (AI)

Patch 5:

- Fix unused data in selftests (Eduard)

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
  bpf: extract check_global_subprog_return_code() for clarity

Emil Tsalapatis (3):
  bpf: Factor out program return value calculation
  bpf: Allow void global functions in the verifier
  selftests: bpf: Add tests for void global subprogs

 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/btf.c                              |   7 +-
 kernel/bpf/verifier.c                         | 349 ++++++++++++------
 .../selftests/bpf/prog_tests/exceptions.c     |   1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  24 ++
 .../testing/selftests/bpf/progs/exceptions.c  |  14 +
 .../selftests/bpf/progs/exceptions_fail.c     |  35 +-
 .../bpf/progs/freplace_int_with_void.c        |  11 +
 .../selftests/bpf/progs/freplace_void.c       |  10 +
 .../selftests/bpf/progs/test_global_func7.c   |   2 +-
 .../bpf/progs/verifier_global_subprogs.c      |  19 +
 11 files changed, 344 insertions(+), 129 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_int_with_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_void.c

-- 
2.49.0

