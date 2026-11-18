Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012019;
	b=NyIqw4aOSlsgMiy4mynfynzepkpCKZn0lHQPa+jVr6240cVVX8SJXAkDEL6Q0brBvxN9
	 wCQc/5I97Yg4XcQF77QaN0NAYNOrEQb4bM+IGKF1jRoXRIxcewlZF31NKMBO2zlWoat0b
	 YcH+X/udWegIdQu3oL9cjoBJ8NKB1rmJ+heuqw+Yn2wwRLIddpLfugab0ilNEwR6sP3mQ
	 zc/Bq9KvwjY1Ybt4+gEUVpk12vDTdCB0yVCyDLv2907/448sCzdXZ28zr9D3Vg/gT5HUq
	 lhno1p/6JhUQFlQWS6aVH5oWhyu9Qtjf4P/dUoduk7Vj0rhH9MsVkXl66ENxILmtOlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y7AldnFPFwd28q9Fb7JfwOQSIJZmwrcTj9ZEfGyxga8=;
	b=S9nGVrxr0ZXPjeIvSe80fJbS6h+GSbmY03a8zBOg8pGguFg6zdGvayOrfwQApLEusuXI
	 9kiWDmm7KmDnFXlCYyrAusJq6GfDmqaL1HsmzPPtx81u2M4TkzJsKC63ezayG7kPKjfN8
	 bkNvjq2bL3Mu2VLcfhhhS1lT5aqM+bpqi8uVVvgLMh5I89TP/I+rRV4a92smd4bNPY4Nr
	 xx1awS/yCjAQ+U788XusAIsXf69lErNpavHOc06IK9z2s1hWPfbVN2EqpxXJHOgy2LYlJ
	 NxF+MOND3e52LCMP1fEB6qhOKB7I8DFY2pJZNX7mMBHda3aM4yDKuVJGbesYWweJHwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0STMB6LJ;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81B60A2602
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B81B60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0STMB6LJ
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4a451915d8aso539385b6e.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 06:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012018; x=1795616818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7AldnFPFwd28q9Fb7JfwOQSIJZmwrcTj9ZEfGyxga8=;
        b=0STMB6LJinF6MkDTzbvwqB+W3FJpKiki0kxpinxHUSf/5iAM9Bfa3syLvlxqyRqQhy
         BVUwooiEm+P90TZ3GB2qoAj6owdVwi9GT3zgzP/H5lT3q6KI32GGcpZufXjMiMrxNLmM
         4lr7xaZBf1QpYjxcylmO0zzW5ZQOBUoKfMLLzD9ik8HH5CeStlgL/BQ917X/1+4T/j5u
         s1MCIMYksILaHpAeWbp+SAG7lIGyZZC/O7bestAyuqgrIqItQehRl8N2K90I9vG02WzI
         bQXZyh8v8mOIWRWUVZ+yR6uiCe5SHpvqkPiL7agvO9gnCAnD0K44XSQCRjy+i5joLkQD
         rwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012018; x=1795616818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y7AldnFPFwd28q9Fb7JfwOQSIJZmwrcTj9ZEfGyxga8=;
        b=QlzEYPy1PcvneGmq9/zuT/HJ9SK8+HVVJGdqP3r6DELNQOmab1iC4RXOiH5Ou/UjeO
         S8HOeLekt0zjOCHbS0zL/186uZLc7tPViE3rQyiw3444LrkbFaUPB4zqsNMzFpQ6fs96
         h7bHrQRE/Bt36IdEk2Rw4sTjAntFepVhtBJ6t0R8CZ76WdPvsrqcAR5ANPcXJX0zp5GP
         pRSrOWvAwdG8ttISC5E+xURRQbwmdXPW5DKe84y2aMwTjMlEARu4raW0BJFa29zM4oJo
         L3ZnyRFDBUFd8sr8PNRKdyswpspOIOTwvN3/ToqqdfMXDWjmRCd8PLYWteY3odibsQqm
         PL7w==
X-Forwarded-Encrypted: i=1; AL+hErHqboVSpcPt2hKWfpRv0fET9qiSVnnZIop8pKIXaGsgVN0cYyCzVdg6Mh7gudai0WzxgJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zkcLJhNLWSsSZS13lhBCsf5MuN5gQ/I+uDR9aMHWAeWWtdv3M
	fPWx5dF5fR9lm2GKFmm72ZR7fYS+O/UuqtblEiGcHLo7SkEapRcCtpIG
X-Gm-Gg: AYBFou0DhACXUh2oYp/Rm4eJ32pGaUdZcmsOXYQoJTkFGPmSD45Z1GH6Hd8uf8yCyxP
	C/QaaPmv0q0xFjarW/X/mfjIbMfbNQQsFeQXDxKfBkfAg5hmUBg5J3Fz4ZsqDeKrPBxHQi0ei0k
	6Glo4RxJv+KHF76CQg63Gyu4MgtNJXlJsxIA+HKDBNa61vDB+R8zZmGiAS67GyvxFXqiNe0Uz49
	1BZLBfz8hD4fev2CCq52Pp5IAZ+E7xkR0DLyHl3asI+dbEmJ2o9ZP7/Z1rvSM412f225Z3VwzNv
	JIgcA6LrXSIiAYtxsQZ2e5s95vdrn6lewbgJFKpwvXC7AUvtQpI4fleyDD5dyWJ3eMSlYDvbOm4
	YsxgoQdH2U6opYtHMMWZLJlSdccco8Qc0391Z3MZjXzwd/4bYQ4gcNwXkGKadP9CR7I+pWJHi5T
	UaWDe2v0fSx/NZOMhFNmBzD4J7wV9/Iy9u80Xm2AIeDnIyN1hmCZMkWr35vL8fwPeyKEnQJHbzq
	/M6EfNny4A0qeM0egg+C3CsorAnrplTG/3tTcPPjWwJWi7mDv7+iP6cL3Cf46iuSkWkcCrWM7UC
	Jqme3jwcje1d29J3WSKBrVtnaidHTCByt0F8UjHWpexgKwroeYyPbXDHLxmXEAMiGD2BEwFoXAr
	T4WGn7pXL
X-Received: by 2002:a05:6808:f04:b0:568:3866:d1b5 with SMTP id 5614622812f47-5773fb4cbf9mr2975057b6e.46.1795012018160;
        Wed, 18 Nov 2026 06:26:58 -0800 (PST)
Received: from localhost ([216.128.135.139])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74372cb6bsm2197869fac.4.2026.11.18.06.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:26:56 -0800 (PST)
From: asatsuyu.liu@gmail.com
To: gregkh@linuxfoundation.org
Cc: asatsuyu.liu@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: [PATCH 6.18.y 0/2] bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
Date: Wed, 18 Nov 2026 14:26:52 +0000
Message-Id: <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026111850-shiftless-popcorn-a566@gregkh>
References: <2026111850-shiftless-popcorn-a566@gregkh>
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

From: Yi Liu <asatsuyu.liu@gmail.com>

Hi Greg,

Thanks for the guidance.  Here is a direct backport of upstream commit
1a5c01d2508a ("bpf: Make KF_TRUSTED_ARGS the default for all kfuncs")
to v6.18.64.

The series has two direct cherry-picks:

  1. 1a5c01d2508a  bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
  2. cf503eb2c6c3  selftests: bpf: Fix test_bpf_nf for trusted args
                   becoming default

Both apply cleanly to v6.18.64. Patch 2 is the immediate upstream selftest
fix for the behavior change: 6.18's test_bpf_nf still passed a NULL tuple
to the conntrack lookup kfunc to test a runtime error, and after patch 1
that program is rejected at verification time.

I tested the code backport in QEMU with the same reproducers:

  test                           unpatched 6.18.64       backport
  ---------------------------------------------------------------------
  copy_str_null_dst              LOAD_OK + oops          LOAD_FAIL -EACCES (arg0)
  copy_task_str_null_dst         LOAD_OK + oops          LOAD_FAIL -EACCES (arg0)
  crypto_null_err                LOAD_OK + oops          LOAD_FAIL -EACCES (arg2)
  rbtree_null_first              LOAD_OK + oops          LOAD_FAIL -EACCES (arg1)
  copy_str_safe (NULL src)       LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  copy_task_str_safe (NULL src)  LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  crypto_safe                    LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  rbtree_valid_remove            LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  rbtree_safe                    LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  copy_str_zero_null             LOAD_OK, RUN_DONE       LOAD_FAIL -EACCES

No oops with the backport.  As documented in the upstream commit, this
is a verifier behavior change: kfuncs that previously accepted NULL
without KF_TRUSTED_ARGS now reject it.

The commit message specifically mentions the netfilter kfuncs affected
by this, so I ran the targeted selftests in the BPF CI container:

  bpf_nf: 14/14 PASSED, including lookup_null_bpf_tuple/opts and
  xdp_lookup_null_bpf_tuple/opts.


Thanks,
Yi Liu


Puranjay Mohan (2):
  bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
  selftests: bpf: Fix test_bpf_nf for trusted args becoming default

 Documentation/bpf/kfuncs.rst                  | 184 +++++++++---------
 fs/bpf_fs_kfuncs.c                            |  10 +-
 kernel/bpf/verifier.c                         |  14 +-
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   5 +-
 .../testing/selftests/bpf/progs/test_bpf_nf.c |   7 -
 .../selftests/bpf/progs/test_bpf_nf_fail.c    |  57 ++++++
 6 files changed, 158 insertions(+), 119 deletions(-)

-- 
2.34.1

