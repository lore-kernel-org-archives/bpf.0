Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D5D32D7DE
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595714; cv=none; b=dmPV4PxAUdS21OKKOPWymqlA1aHuYwDz5C2cd1Vr4HuDtD3SDmSe3ifW6OXyIdvMTnuxh+swwLgUzY4CoP4aADphxoVtvLzegVEhoS3lPkH95wnfSntD4LxeGYsEQ3djlPJN1j792SBMLNyOSjO0an06oTheIDkzPZzAEv0pyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595714; c=relaxed/simple;
	bh=ySoL9J4FxFNGa9WN7CbfvAv3+oDHaySh/qFb4stR06w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=podRFd52oSyPWr673B9aSqU2B4ZgJV8fiesV/llD5MCswgdns9UAz87H4yv7eZpNt6otBZf7/U9TvnPoYXTTK/otDffVyOrgA+lvKqydo8+xS34gt8mO9nCSCSTTDsFgE8vXn+GqI78I6cZ0tcuW3emjJTx4maNowzowIuUvS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJniYZjU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJniYZjU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso23521395e9.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 05:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771595711; x=1772200511; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7nuQ3N9jZ0+deq9hdiz+W1Q2iHZJGb6jT4a2xGVzbA=;
        b=IJniYZjUQZv4sKpW5T2v94xOpRVOSX/ki1+4iJ5nGjY2VZo6W7kfF1UwzDDKZT5wcw
         2AkBNDkYdUiGk5c9yJ9J7RGH17uFwyys8tjAxxcjDzYItBAxP9ajCfmZZQFprRR5njoP
         4DvYwuoGnRCfPdvAlVwgwHYyC1I4pYLaBCIA3emur98o0OLyRXNpIjZ4ib8NAWmMIyJZ
         JAlMkfIVCvdzG8kDWm+IjcxW1ayZiKBnOEvIScvRBfUod7FLwDysvnAjJrAMsMx0j1qQ
         UXDICpHa/u57kL5Q3WGXBKbCk/FlINhF6hN6+ooqMpJ2erqmJNPCmckn+5SePTJOzjt0
         D9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771595711; x=1772200511;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7nuQ3N9jZ0+deq9hdiz+W1Q2iHZJGb6jT4a2xGVzbA=;
        b=YtVMLO4qzmmFv1Q0GIQu2GrKgobnUMVEHwX+cuOE1VVcmQgFqp7+RKva7ZJXw+zdaI
         s+Y83rokLs7Pf/8RYekm11Gz0NFuIPm6TUQLepagZJAAz97jAivN5MD2Rvj7VRnaJMvj
         9I4rBQ6Lb9nRzw+BQwdzk4pjwH9c98nXlrEZls9eS9UEngQqIuAQtv4zTNRFeCj2loIM
         G4EPPMyCBpK4cXPWh+zTlJmVUJz6iT24KaEtzOlVCTkV/taa/wygbtNrdxbcydI7aN5P
         1Vxtp1H1EMZPGPJ+uaITK/gJVB35Rq4naEPD5vt9C41en04FysHPy0Ty7KOtqbwH8DxV
         sbqQ==
X-Gm-Message-State: AOJu0Yy8sgzeeMQ7gSK9ZztnctFI7zAfJ6VNsNHLhZLzu0f6Aktixcnq
	wN5lBRsoBMm3g4vw/HskL9csTJ6+9jusTkTYoLSTHn1rzGr0MiSG8sD6u5O5ZA==
X-Gm-Gg: AZuq6aJkbOaKY5bAm91jz/aGW8GsI9cd46leAlg0WzZsEME+5yDHOZ+P67fCyzDnJos
	5z+NcG0gaK968vLqDq3V/jZ/O8VEwqgTgcua6MzFxAvt0Pq6ApDHw52bYG2HgSu7pnFQ2ajfOAD
	d6sEPmyAeenVVtlFJHekPmICF9yptQ1mLnXVEq5jX7YBLiXXjnq9F/EksTaLpLbY488a8e5RDJ5
	I0iWL1d1ozu+h7j/NehIYxpCe9SyEbA4Gtg2BBKzmpJzJK8Am//Ezx/IbBGZ1bCovB1sVdOtU/L
	X+/b59fAdVYz4bnstQz4KaxdWuZrhYuiqGvmieSal+CvC+42Wx9yUhSsPvXnZsO+jzyf/F9gucM
	1ex4exMTnzbZgHioKq2xfOuzQpNleMGqC6R2d3WXZl42sncnhrEbZH1lXhYWZegFqHfhi5RSIGr
	tsBMvn49sDkac8QZ6v7GHOpzvDlqInStn/zzg3k4nR9k2CPu59Hc1hFYElw50WbYhbhwieNERfE
	PApY6rvHkKIrSRJB7k/uqY89AolohHbbrYSpfAL7th5j6HKhjKiA5EqWkx8PCzRKozJOV8etMg=
X-Received: by 2002:a05:600c:820f:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-48379b9f3a3mr362128675e9.14.1771595711209;
        Fri, 20 Feb 2026 05:55:11 -0800 (PST)
Received: from Tunnel (2a01cb09b01c9b546fd5ffb86f392ee0.ipv6.abo.wanadoo.fr. [2a01:cb09:b01c:9b54:6fd5:ffb8:6f39:2ee0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31d3ebbsm69678475e9.13.2026.02.20.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 05:55:10 -0800 (PST)
Date: Fri, 20 Feb 2026 14:55:04 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf 0/4] Fix invariant violation for single-value tnums
Message-ID: <cover.1771594636.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We're hitting an invariant violation in Cilium that sometimes leads to
BPF programs being rejected and Cilium failing to start [1]. As far as
I know this is the first case of invariant violation found in a real
program (i.e., not by a fuzzer). The following extract from verifier
logs shows what's happening:

  from 201 to 236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
  236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
  ; if (magic == MARK_MAGIC_HOST || magic == MARK_MAGIC_OVERLAY || magic == MARK_MAGIC_ENCRYPT) @ bpf_host.c:1337
  236: (16) if w9 == 0xe00 goto pc+45   ; R9=scalar(smin=umin=smin32=umin32=3585,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100))
  237: (16) if w9 == 0xf00 goto pc+1
  verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xe01, 0xe00] s64=[0xe01, 0xe00] u32=[0xe01, 0xe00] s32=[0xe01, 0xe00] var_off=(0xe00, 0x0)

More details are given in the second patch, but in short, the verifier
should be able to detect that the false branch of instruction 237 is
never true. After instruction 236, the u64 range and the tnum overlap
in a single value, 0xf00.

The long-term solution to invariant violation is likely to rely on the
refinement + invariant violation check to detect dead branches, as
started by Eduard. To fix the current issue, we need something with
less refactoring that we can backport to affected kernels.

The solution implemented in the second patch is to improve the bounds
refinement to avoid this case. It relies on a new tnum helper,
tnum_step, first sent as an RFC in [2]. The last two patches extend and
update the selftests.

Link: https://github.com/cilium/cilium/issues/44216 [1]
Link: https://lore.kernel.org/bpf/20251107192328.2190680-2-harishankar.vishwanathan@gmail.com/ [2]

Changes in v2:
  - Add guard suggested by Hari in tnum_step, to avoid undefined
    behavior spotted by AI code review.
  - Add explanation diagrams in code as suggested by Eduard.
  - Rework conditions for readability as suggested by Eduard.
  - Updated reference to SMT formula.
  - Rebased.

Harishankar Vishwanathan (1):
  bpf: Introduce tnum_step to step through tnum's members

Paul Chaignon (3):
  bpf: Improve bounds when tnum has a single possible value
  selftests/bpf: Test refinement of single-value tnum
  selftests/bpf: Avoid simplification of crafted bounds test

 include/linux/tnum.h                          |  3 +
 kernel/bpf/tnum.c                             | 56 ++++++++++++
 kernel/bpf/verifier.c                         | 30 ++++++
 .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 91 +++++++++++++++++++
 5 files changed, 181 insertions(+), 1 deletion(-)

-- 
2.43.0

