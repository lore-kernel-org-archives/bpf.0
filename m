Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E0286D4D
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361032; cv=none; b=Ecc5BSw8UqmTCx5WZANSnESHX9IxiWtQIVpHWli47VOiM9M6e5YbSZWAsbwwukH0SvrCRMYQnd01ioe0XQX3wrugIO9A9XQUZleBvS32fFEdmlfC28UhazaKe3YgGiSwDyJWiJXY+TbEdd/zW48aWe208R4OCBC6k2HRu9JJnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361032; c=relaxed/simple;
	bh=CFnrP4U7vbfHdgOzISYqtFf3t27P7DPTFQVzMlEthdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSMFKIVQPY+T8S9fgrgsfrdDFcO8THItP/lgsQGJcALejlgXrsPaHp4tzHZjL8CgX3JjYh7Yj03mAWkAYmDmdKb19TLHdNHsgLvThgWBxKqHFeHWYOvWxdpZI4BiU6xtqIs4N9QvQG+qjLhDEjodk8nIibpqA0YQ3xMKZsf+47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=kEewfVb5; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="kEewfVb5"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb49f63238so234199485a.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771361030; x=1771965830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5Gh0DFTdeg3O1Ky/w05YCMijEQPtlmd0I8TYxjHahk=;
        b=kEewfVb51XvenaA7ODJkpyMGDVvmUfbtuBtPAojMNMC6CLKrMUFZOzXosY4p4F40HY
         TeSpF4LyCy7v9opCnMoDZkJtI0OsjLCVkUoEawJhV4KXytXTTApS47kI9b14UAzD9++v
         9qits5ff83ExDFmjtEgmUvzhLKMd2ebtEaT289m/f7eq1bjk85yoPATg/yfMlR6x/nPH
         04O7MhPMOccG8SOiRF7KHxNItTUS/MTyueC3/s/Q8gNtcYhlfpdRQhTVGe6qYs/Uxf/x
         HoOE1ypXZHr9nTxV9qqnclLmzv9wFbTvUhCQc41/YEROygdkpEMOAheIpdpxgdaP4BnO
         JD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771361030; x=1771965830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5Gh0DFTdeg3O1Ky/w05YCMijEQPtlmd0I8TYxjHahk=;
        b=BQiL9u/kyt5XNF8tOzNkAJH4PZfX7XE1Q4Lv+K/TP/NI68jLFgnMg9ql79yauVYIPT
         inmY0BeKmngaVSlxLl/QzDbL/hg/aVum4LCrm1CjCVzz4RYBBa8KNFSMtO9xB5T9jY+P
         R3A3U7Yea+VDe0Q1P5SoJfnRtr8PMxmqqq7mwh6ylaeYux8mbzp1sRrHt4Ji3UXRYEdv
         4arIJE18mVmJiyeR9XWJJNVzitZzsvqTr/dodUyEj4VbLBHuW8LZP+ed3gKC/v4liZOT
         HZVZqEcxVqrparsiWpKFhTQGJxkX9EXWRUSAIBl8e4JYXCOxaLjV2Pr98PBGxHrZZdzI
         iTsw==
X-Gm-Message-State: AOJu0Yx3jTTeHz+dwRdq9reQcSTb5nEgBasuh4uncnHsThw8yTagol46
	XacdFsp7G2behlIXjeLsqMS0Pv7hDrA3/cDRpRchlevQ2qZhqVxzXnHYERgiZAFX7JWNtcsObzn
	3eRYYPyQ=
X-Gm-Gg: AZuq6aJ9hdWFB0yxw+Su1boiKhAN4SmqIRUYdY1K63Wigsuz+FxdgK+1j/hue+lz2SF
	pn4hBD4fvK1w/Sy8mim+Ew9tsJ/VU1zIS1FYDtWMt8+yyrw0NP1HYFhZSZ5tZ0PlUL9Wg5Kx+6l
	dcRJnhO9wu9Z7tJmcoMT7FUfQ5Q0mNC5gqaUWLjSzTx+r3FE6gK9DWtpfJGoHtbSAUk6vYBn90r
	jtVGAcHwNFFLhLdxXKwT3+whv1UpX9Jj3zaIcv905+aEhvQfGyRT4DFI0MqlA1RxykkHaSErJm3
	nSGRC1s6YlowVi+t0s57OcwZwPPHSU30xnW0R5IFPkWL0YdU5CligBwB+fvBM7k36jeFd8/88AF
	ZS+zaWuYZNeJZTA9CrHEpruwZa2HNmHpYxRaJ7I4MFA71oCDDdP/wzOGevw16mNmQZ8HSA9/tEE
	aXH1M3PQWPlVixcTnChd7NV2Ff2hUrgY9q
X-Received: by 2002:a05:620a:25cc:b0:8c6:a809:862a with SMTP id af79cd13be357-8cb4245be6fmr1584298385a.45.1771361029559;
        Tue, 17 Feb 2026 12:43:49 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0e12eesm1645349985a.15.2026.02.17.12.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:43:49 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 0/2] libbpf: Fix perm errors for LDIMM_64_FULL_RANGE_OFF
Date: Tue, 17 Feb 2026 15:43:43 -0500
Message-ID: <20260217204345.548648-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
adds a feature flag for testing whether the running kernel supports LDIMM64
instructions with large direct offsets. Fix two edge cases that can
cause unexpected -EPERM errors in two ways:

1) The probe program used for the feature has type TRACEPOINT, but it's
possible the caller does not have permission to load it, even if it is
able to do so for generic BPF programs. Use the SOCKET_FILTER type
instead that requires fewer permissions. This does not affect the check
itself, which will always fail verification anyway.

2) The probe is triggered during bpf_object__collect_relos(), itself
called in bpf_object_open(), to compute the arena relocation offsets of
arena variables. However, the caller may not have permissions to load
BPF programs. This is the case in some systems with the bpftool calls made
by the BPF selftests during compilation, e.g., for skeleton generation.
Move all uses of the feature check to bpf_object_prepare() time instead.

Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v2 -> v3: https://lore.kernel.org/bpf/20260214021014.15670-1-emil@etsalapatis.com/

- Only zero out the first byte of the log buffer (Andrii)
- Minimize invocations of the feature gate (Andrii)

v1 -> v2: https://lore.kernel.org/bpf/20260213181752.505318-1-emil@etsalapatis.com/ 

- Adjust the hash of the original commit post-tree rebase
- Ensure close() is not called on invalid prog_fd in feature probe (Coverity)

Emil Tsalapatis (2):
  libbpf: Do not use PROG_TYPE_TRACEPOINT program for feature gating
  libbpf: Delay feature gate check until object prepare time

 tools/lib/bpf/features.c | 10 ++++++++--
 tools/lib/bpf/libbpf.c   | 26 +++++++++++++++++++-------
 2 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.49.0

