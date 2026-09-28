Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917E3B47F5
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621620; cv=none; b=cS8H5XO0HLKCHOW7T6gJDnbHVrNSJwSl2/wJKmktP9CuF7P/uSQa74NaDwt5ZujV2cjTqtYmedWNl2m9cWjfNmylcKovDk4r6gqOZTTeOdW5pOoAI4mAB7QwVfntMc9CrPBNYYni1y1L0isr261TwjRAFIMPQI2723ZZHs6gWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621620; c=relaxed/simple;
	bh=ItP8/EQfMPLQbB5sCZXY/i9T9ON1MLQQXPr+p4pLGuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUT6hB8TJ8vfuaESoYnOS0+llfZY2M7iiSN67L5oInfbRjoQja6kOuHT4dlBug0yrc6bruk7XI7mjMb7GdjpP8N/y+ly6Gy2iMaq7IrgoH7DkQPQ7ThkT6kImc6Ux8ZIfEiMp5vAJkuI2nrBJib9Mq+KeGQ6fV0/dH1sd/rhJGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrA7WIF5; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrA7WIF5"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-486e0f56cddso1452353fac.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621616; x=1791226416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I1vKWHWpjmWuNdK6I/OO88u8YPA/Vr4VV2y38YTmwhY=;
        b=nrA7WIF5BBjFZ7T8NwN031K7zE6oLlKXWush36TD4z+8o8yrtfAeX9Aik+JLb9szzA
         Hd/Vn3P077H9vWwQaffnEezsGmDK6D1fCcUJGhfCdT5Kup2P6WIVug5UNFSRVfVGA/XI
         4bGsow5p20ETOLwCowHb06S41XvrkDoqZVn4dpK6s4USCzw5Cdz19aO+H2soOszK0pxg
         554kSfpY259LtkrBqV9u4dd5fff5hhAVrwEhiaZ5gahsOZ8zBMUwsGb5E4fm7qJ78reb
         N+NBKzjx3Yo4U8/LBfszZaViCEt4YSvXEyhAA1k4dMGyKAw++uTcza5qXSz7VLaYiZNn
         Nvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621616; x=1791226416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1vKWHWpjmWuNdK6I/OO88u8YPA/Vr4VV2y38YTmwhY=;
        b=hWEjUAB1/UC8laGunokkVKSFHlebsHU15shGhlrahDxrz51Xji7avOoxnvpMgHriQa
         T8T5qMkwvnXsgQgxu2Nn00kTn738i3vpyrZ9QoaKLtk1BQMkj8IRk7uEHMDsDwSuuyMB
         1BiFih9SWPeybmBSY6z3v7nT0EwYNSKRm+WGs5FccsC2PcP7wYnoVfL0kfrfhK7AA1bf
         OmhA7EZXPiHFWdNdPt6daOfusCy3FmHJy7rjGz+GQAiE7I++d5aR42j0mHv3tGbuQos0
         Kjs7DMLL9WoFPzdghbyY14DAQUlWrT4FgBBHA2sev9T0yE0OCPtHsZeUDzHZxa/l/6r3
         ijJA==
X-Gm-Message-State: AFuF++lmY0/VBKpp486G5pZXMSfkeuZQVTWTeoTwMUMAB05nI+VCs9vv
	UKuMOCUB/0SDfPYN0jPw6cODTe8XVon8eFZ5stzPuxV1Jzli6DniMXzHweffMA==
X-Gm-Gg: AYBFou1flNP1fyusw7vojoXIp39Bgl2fnu3VPBlmpy4h3Xda2veOYWzp6dIsUw6JZ5u
	39tvR80Ifm89XkGKOjT2uHUXiVxh40ONZtgMxoPnblTsfUZ6fzEE0GspS869wXGD8B7L7Ww7OzW
	9CVOyJabqypSZgAsH5wUWMxRw1IvkO81bxc872+LxR6FNrYpCLXnzGCYzPJ/bWLLWeni0jFSvBM
	lWLKAWcPMrnDJDPdAENXGZbYqsVqgLwbzfPVpvKbSJhWQ+9acghQgWQ2wnIKIdfI+bO9zKVabHy
	EFyYx9FWUJVI+z32uYzw41enpZ4hb2qKLohN++h7wQfCFDmHYQiGYX6w78BdJN2c1za5pqSui2B
	zGyPxAx/v3Zo91oLOr89zgKcqs8yeXT9hyBioX56RLroMU2tTidWuxAxAz/ooHVZsm+rrV7At6j
	Fh8EigYPVvc1FEw3TEri9w53v9KtaWA1v/WBCQdY4BcWuEn5/OZK6mIMtsxGT9QSY=
X-Received: by 2002:a05:6808:344b:b0:4b9:a88b:8892 with SMTP id 5614622812f47-4d72c738d39mr13392620b6e.40.1790621616076;
        Mon, 28 Sep 2026 11:53:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebb6ea02eesm2442987b6e.2.2026.09.28.11.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:35 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 00/11] Unify subprog argument checks
Date: Mon, 28 Sep 2026 11:53:23 -0700
Message-ID: <20260928185334.1004200-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Helper and kfunc calls now validate arguments through check_func_args(),
while subprog calls still duplicate much of the same validation in
btf_check_func_arg_match(). This makes common argument rules and
diagnostics easy to change for one call kind without updating the other.

This series builds a temporary helper-style argument prototype from the
subprog's cached BTF metadata, then moves each supported argument class to
the common checker. The last patch removes the duplicate loop.

The series is organized as follows:

- Patch 1 fixes kfunc BTF parameter lookups after wide arguments.
- Patches 2-3 identify subprog calls in common metadata and generate the
  temporary argument prototype.
- Patches 4-9 move scalar, untrusted, context, arena, dynptr, and BTF-ID
  arguments to the common path.
- Patch 10 moves global subprog memory arguments and their packet-change
  check to the common path.
- Patch 11 removes the legacy loop and checks all subprog arguments through
  check_func_args().

This follows the helper/kfunc argument-checking consolidation:
https://lore.kernel.org/bpf/20260911220415.1396439-1-ameryhung@gmail.com/

v2 -> v3:
  - Remove the redundant dynptr register-type check from
    process_dynptr_func() after all callers begin using check_func_arg()
    (Sashiko)
  Link: https://lore.kernel.org/bpf/20260928181414.644158-1-ameryhung@gmail.com/

v1 -> v2:
  - Extend patch 1 to fix the release and iterator BTF parameter lookups
    after wide arguments (Alexei)
  - Keep subprog call metadata local to argument checking, leaving callers
    and helper/kfunc handling unchanged (Alexei)
  Link: https://lore.kernel.org/bpf/20260925211256.1834061-1-ameryhung@gmail.com/

Amery Hung (11):
  bpf: Fix kfunc BTF parameter lookups after wide arguments
  bpf: Identify subprog calls in argument metadata
  bpf: Build argument prototypes for subprog calls
  bpf: Check subprog scalar arguments in the common path
  bpf: Check global subprog untrusted arguments in the common path
  bpf: Check subprog context arguments in the common path
  bpf: Check subprog arena arguments in the common path
  bpf: Check subprog dynptr arguments in the common path
  bpf: Check global subprog BTF-ID arguments in the common path
  bpf: Check global subprog memory arguments in the common path
  bpf: Check all subprog arguments in the common path

 include/linux/bpf_verifier.h                  |   6 +-
 kernel/bpf/verifier.c                         | 283 +++++++-----------
 .../selftests/bpf/progs/aggregate_arg_func.c  |   2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  11 +-
 .../selftests/bpf/progs/test_global_func5.c   |   2 +-
 .../bpf/progs/verifier_global_ptr_args.c      |   7 +-
 .../bpf/progs/verifier_global_subprogs.c      |   2 +-
 7 files changed, 129 insertions(+), 184 deletions(-)

-- 
2.52.0
