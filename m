Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C1555C327
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061050; cv=none; b=bkBYaRoa6aDCC/S3H7DeSAaEfz7sg5trwG/Hz8bgRiEcKDZ5yAjag7UMABRFLhcYZCb/Vmrp1U5a56JPSZ+H0qobGtpLDUzBDjEAMVZerOEwaZeDsFuXqymGkLG6lmLb9rENQJq0zY8TYV4Qdg7AhQighxHVqWbdmbunf23XgmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061050; c=relaxed/simple;
	bh=q+s3r5oMGq09jUPNRLDIXcQFHaxoX8OtZSZfeGNG9qY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpJvBVoNKOaXUxQPAWvTg1G5PyrIkjgVDkc9ccRFiucOpW60NSnGHdA9EdN/jONPLo16brSQpPZVh787rqgQIQtTPXY9T/4BQqyM7SK0kSrSWc0HYR3RltDj6PA/1KKTR+sBGVPJKxW0Ug5+O7taBL4nVMNVPEiSJgfjLH6JTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnilizUm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnilizUm"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4be0e5469so66756a12.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789061035; x=1789665835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mfG5uAWEbxwQfL0USWeVXd7U6V6VJZZBa/+iXn7q3S4=;
        b=RnilizUmT3yhBLT8PoO3kr29QYJM93WBjkClVKeAmezvtIBtfvVzltzgRRlV4lYD/1
         hibX92GsrKQW4gKMRPjmgluFBsKxnd8f+0YsKrpDVBOEa2xJB9wM1RtXD3cGwR8QWL22
         vgy8ze7u5r6vwuN7mUJO7OH0X62dl2bcZ9reYs+6YB7jmG49AyNTHXOILHv794rMdpFe
         995z/jgFHm0ZvF60XOl8WY2LXz2JTamUA+8lFYD2/XkcngEziF8WIQ/ach7dJGSpyh05
         DfihD4uwrIieJIAVfxd594dKDtcyH+3HuGRUNIz+AmdL7DD78C/pdVr66kjXpwlEDhYQ
         BOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061035; x=1789665835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfG5uAWEbxwQfL0USWeVXd7U6V6VJZZBa/+iXn7q3S4=;
        b=JaGyI3UBe6202uyTwzgHF2WCw4cWlnCBjQ/nQIjL5hBg+b1+HN6u/ZmktpOgoerFR9
         u6VNBqaGrFvQdZjCFIzgcmg05Jr5YEHdWvjxIquNJCwRdXDYByOIvX55/gGf8w6bwBKl
         FyKSJV6ZxYL+Ia7LzEeYBZyl6eDno2LDoiMmhaR138XIQw+5A2T/XrXZ4GiTp/tcvI+O
         5yEYU6dXOtm6eP8AsUCz9Uie1/mN+p578BBNH1n+tMS2958lEzNFUir1yloa4/ViHvjo
         N2jE++wdAQfFLMWby+hc+osxl1ubjx9HA0PtZW1Htvf8niAnvEmSsrwYcAwNcn0Bo/BU
         p7MQ==
X-Gm-Message-State: AFuF++m7TcheQ5wtvBqKrA7MSLfTNgRuDu95WGWhRhouXhO5gDxVuNBM
	lBfeZibb8qAjWS3DeEhTqt/HOSE+DPWkPip26UVwrDJ6Te2KIRVdlSjKNZIbld1OZLE=
X-Gm-Gg: AYBFou3AB8SkdUb83H/d4xcW2O1NxreLSchwu3p4OzCRa4MUEhrF4nLGH0AmqOV9yCq
	2CHaJLIPck7EVLaSmYfjEv6vv/uhr53kjNCeZh9H8rdyL+cKSzzJnnz2Gkwi61JZ80dlYjwBTNY
	NsbfPDqiy1H1vV40CqHZM6ETS43eHyi8IZDNOQuJ/0BIWfVt5WI17Jvs43MsaXwb8kXkdcmtEEH
	HiV90WgfStCbP9eFNSmB/1HlNM5oVkLi+7N4RAwP1kDuxNG+lfhS8vMsa4bOu6j8ZVh3vCM5wtS
	/thURNLNcqRWU1fgPkW8BNpNX/otrxwB6uo/f39RNA5pirtI6+T9iSfVczXFgObQHe3hZ+mD8GB
	DJndG9IxLuLWY862hRAMJmgVF91dbckpf/P4eKtlIYq1JpsHediFt3cViU6b6WeWqCmqDvpBFyV
	psbW+Jd0DopnJdbtycOOAQakSir3LiCNj4yCmuwQGHiXGpNTommUgoSa70qULkvP9gPfef+qkra
	QK3MBwtoyPZAvWk9+Pxm+8bBXxIAiQTVJAofSe5aq+yQIx5PM2VxKKX8Z/P3FOIBw==
X-Received: by 2002:a17:90b:3b8d:b0:398:b426:ca4b with SMTP id 98e67ed59e1d1-39b2624f10amr62412871a91.22.1789061035009;
        Thu, 10 Sep 2026 10:23:55 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d995a42a5sm164304a91.17.2026.09.10.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:23:54 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf 0/2] libbpf: Reject private struct_ops bitfields before data access
Date: Thu, 10 Sep 2026 17:23:38 +0000
Message-ID: <20260910172340.1467764-1-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug in bpf_map__init_kern_struct_ops() that can
cause a userspace crash when loading a BPF object containing an all-zero
private bitfield in a local struct_ops mirror.

For structures with kind_flag set, member->offset also encodes the
bitfield width. bpf_map__init_kern_struct_ops() currently uses that raw
value to calculate the member data pointer before rejecting bitfields.
The absent-member compatibility path can consequently pass a pointer
far outside the struct_ops data to libbpf_is_mem_zeroed().

Patch 1 rejects local bitfields before calculating the data pointer.
Patch 2 adds a regression test for the all-zero private bitfield while
retaining the existing ordinary all-zero field compatibility control.

The issue was reproduced with a Clang generated object. Before the fix,
AddressSanitizer reported a SEGV caused by a read. After the fix, the
same object was rejected with -ENOTSUP and the expected bitfield
diagnostic. The ordinary all-zero field control continued to load
successfully.

AI assistance was used in preparing this series. I independently
reviewed the changes and reproduced the results.

Mingpei CAO (2):
  libbpf: Reject struct_ops bitfields before accessing data
  selftests/bpf: Test private struct_ops bitfield rejection

 tools/lib/bpf/libbpf.c                        |  9 ++++--
 .../bpf/prog_tests/test_struct_ops_module.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  7 +++++
 3 files changed, 45 insertions(+), 2 deletions(-)


base-commit: e4a62833adff6ef0fe7c0b90393204fe3c26b5c5
-- 
2.43.0
