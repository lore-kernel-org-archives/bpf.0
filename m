Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AF17B43F
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100587; cv=none; b=jAFxhrzChQ2imV3uYQ1fsUJFeUuTxx3g3o8yWxzXcWWN9XNWmKoXGtYBg+HUgv8aIFjgHWyXHR/U6LwZ9Q1jyKiw/JoRCnYUI6rSUfK4IQt/BUzw1yC6wZYDyvMTVWgowmpPoHAcB9zWzbW5xX0UjiJ/eq7pToz++bMHb0JSa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100587; c=relaxed/simple;
	bh=OUGBAjJQpJnK9c8ptuXrWE2oiJvKBzD87X931F4DpBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8p312pzhMkbOACR0gRFyKSBDnDSkt1MgV19RyL13y+SxE5ODWL4a4PNAOpo84W/NjblhlPeYmWDIYtrpUXnjr1/hFuzgKlT6gs0vqHFADS3ecGg2H2PQl6Em7LYYIVRp/DkDzq3OjsEkBNG9Ri5i9ZPl4ZnFNsFU4pqbiO+QE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=zy2WjGSg; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="zy2WjGSg"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1378943cd4aso4520778c88.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780100585; x=1780705385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ry5Sl19bEFQrGeuG5weobRCTGVoJtPg8jolvSPbvI90=;
        b=zy2WjGSgj8deO+++sCTP/JqdioulBhpxC1JO0LzzpEp7Krh7DaH0J+eKtjwPqLCZGq
         Qv6ON9EZAOZWEN/tYSRjjN+9/XG4SlH1ErI237rs2mo7e7U6abXy4QHAXILeFGNpp2BX
         A1sTQmW5EzqZTGgBBgHAgR/FEUOtbM2OfiIk8jSGP4kLOSBXKbTcFx6elS5zvY0qNIy0
         hyWZL+P3aFlcY4oTd9u+SF0vs3HLmqy/JTZ38Yn3/OVcJ/KJB2Qz/eM81Gc8U8T942Xo
         r+XMjBOZwXnTxoJ/BD9gQVAjfHTyjkakyYv5oQebG6FwuWwBIkNal+ICIcHzo0IgNnCQ
         ShJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100585; x=1780705385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ry5Sl19bEFQrGeuG5weobRCTGVoJtPg8jolvSPbvI90=;
        b=iOI+daYRMSb1+yfN7U5/6ao+9KB7CPDCI1Ap3VsYo5cOzYtd3NsEkcs+9QbaB2RcMK
         lCP3VHcV+Af9A8wg8HM9soRT/GTWXbmOBJd9iSHEmysMDsl9sKEXt7QsWlwVZeE/VfOS
         tGOcDxvUuKF9cSiUQnrBp2oqh7sKGwZgLkFdfoTpUq1OTReHX7g1Y0aNTVNwfXRo5BOM
         DGedt/i3zBCbRY7xeoSIFsWWpuJcvWa1/ruldzB30m3Assl26tz8gZDTXkY1MSZhqw6E
         oQbUQlUBtULDIp/S/U3HdDUWhjXil0Eml0dz7rJS4fDvCKn0iHph+WWcVMIAURWt3f1n
         yh5g==
X-Gm-Message-State: AOJu0Yxim6HHgA21khJbqTGLEGWxdm4CujGFvMmG2fG9LmZO6enXY5BG
	eGlgEDnXlWPvvz0hRcl++snKMQb44sgUv8VcVvTwr6WIx5btkYijpG/ZGkGebT908SvIyBERkvF
	yXo8PHqS0LkZ7Yww=
X-Gm-Gg: Acq92OG1WE8xShjXSVwYjsbfVfEIm1oevZQDke4eahXDKa0dUAHOBn2bmgfIz48Xjr/
	hEUAQUUKeQgTlAL4AtblJ5zfUgSPxLxkwB4Hm77GJSltnO7n9SdFg6uSFurl5Kz38DS2PI0j+Sv
	gEL43CIA4JqCH99TX7mi5uluCMPKS34CcM5BDUQCmc8Uyu2oPMvuNSEBcjUDWblRPCu2w6UxKyH
	rHej19pqSAPLGWWJRDyK7Ol237PvSczfgNh0Gjvw5hsM259MJOgrRmJjyD/V+2feVwUlctj/vry
	0aloBDpq6mqnNyG6aaqdwS9BsE0DV69UCdSFOwnsxIDPuiOUlSLpj/CwUaQwS0LpbQl7oOptjVl
	eUywOkpX9tJ1ppGuYWplbGNfqiVYasAu4ml5Gu8BTPjTIW5OjQu0E1cI/78AAGHc2Mm/JRfXxqJ
	TlGKkw5EqtBLsTwaURl7FFxM2gbxbTqw==
X-Received: by 2002:a05:7022:69a9:b0:136:c565:e83a with SMTP id a92af1059eb24-137d426160fmr953470c88.24.1780100584622;
        Fri, 29 May 2026 17:23:04 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::9529])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b35a5f44sm2070540c88.1.2026.05.29.17.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:23:04 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 0/5] bpf: Minimize annotations for arena programs
Date: Fri, 29 May 2026 20:22:54 -0400
Message-ID: <20260530002259.4505-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs must currently include code to address two limitations
of function signatures that include arena types. First, arena arguments
must be annotated with __arg_arena in the function signature in addition
to __arena. Second, it is currently not allowed to return an arena pointer
from a subprog, even though it is safe to do so. These limitations require
extra annotations and typecasts respectively, and have proven sources of
confusion to programmers.

The patchset improves arena-related function signatures in two ways.
First, it removes the need for __arg_arena in function signatures.
Second, it allows subprogs to directly return arena pointers to their
caller.

To do this we add a new type tag to the existing __arena annotation.
The annotation is currently an alias for __attribute__((address_space(1))),
which is not discoverable from BTF alone and so cannot be used to
determine whether a pointer variable is an arena pointer during
verification. With the new type tag, we can determine whether
either the arguments and or the return value of a function belong
in an arena.

We test the new code by modifying libarena to take advantage of these
relaxed limitations.

CHANGELOG
=========

v1 -> v2 (lore.kernel.org/bpf/20260527071457.4598-1-emil@etsalapatis.com/)

- Rebased to fix conflict
- Removed the typedef foo * foo_t typedefs. Those were necessary to avoid
annotating each instance of the type with __arena. The new version of the
patch instead removes typedefs and uses __arena everywhere directly (see
patch 4/5 for more details).
- Reorganized the patchset to frontload all kernel-side changes and place
the libarena changes at the end.


Emil Tsalapatis (5):
  selftests/bpf: libarena: Add "arena" BTF type tag to __arena qualifier
  verifier: parse BTF type tags for function arguments
  bpf: Allow subprogs to return arena pointers
  selftests/bpf: Remove __arg_arena from the codebase
  selftests/bpf: libarena: Directly return arena pointers from functions

 kernel/bpf/btf.c                              | 170 +++++++++++++-----
 kernel/bpf/verifier.c                         |   6 +-
 tools/testing/selftests/bpf/bpf_arena_htab.h  |  11 +-
 .../selftests/bpf/bpf_arena_strsearch.h       |   4 +-
 .../bpf/libarena/include/bpf_arena_common.h   |   4 +-
 .../libarena/include/bpf_arena_spin_lock.h    |   6 +-
 .../bpf/libarena/include/libarena/asan.h      |   6 +-
 .../bpf/libarena/include/libarena/buddy.h     |  23 +--
 .../bpf/libarena/include/libarena/common.h    |   3 +-
 .../libarena/selftests/st_asan_buddy.bpf.c    |   4 +-
 .../bpf/libarena/selftests/st_asan_common.h   |   2 +-
 .../bpf/libarena/selftests/st_buddy.bpf.c     |   2 +-
 .../selftests/bpf/libarena/src/asan.bpf.c     |  38 ++--
 .../selftests/bpf/libarena/src/buddy.bpf.c    |  96 +++++-----
 .../selftests/bpf/libarena/src/common.bpf.c   |  10 +-
 .../selftests/bpf/progs/arena_spin_lock.c     |   1 +
 16 files changed, 225 insertions(+), 161 deletions(-)

-- 
2.54.0

