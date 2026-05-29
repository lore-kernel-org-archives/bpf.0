Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752E26C3BD
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042415; cv=none; b=gB7x7Ezkt95GWqgTpM8LUi+LKPXN+dcTrlISPJSOencax8MEX3MuwoNSQjzwbGk96Czel8jeDVGPakRrrsLoj/HRmg9eOLKX8ZexCQUyTIO//H6AmQSazd0ojpc4DydVDiMbVvbGc46e+wucBXRYLrZmkxqc3dzb4f5yBggJD0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042415; c=relaxed/simple;
	bh=cFiav10msugnIK0tM+gv/396XB+DNMLjKbvshW1a408=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8/8HrZaNU+pcY7xcHHwBzzriW0qM+bkgdl0R5raBUFj0yZNUERQMD0KMi9TRW1LUG132gNSUvXxE//z44Pg/SB8TQ7yLWqidHAdBh9XHqvwAwNdUZFTY/uRfyzFAZyvjeUImVfS5BYrJmjYY/FHZ/mJt4cApC51lxhNXvBgjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga9A3gFe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga9A3gFe"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b941cd869cso88973415ad.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780042413; x=1780647213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9YoscDiLKVM06+v1BI+BwflOMCL20ObstDfU28fAAs=;
        b=Ga9A3gFensdQRNMRmuJSTGb+gPkYnZ9McQUkMRCrMEGCmsNv+H4VrXMLJ+YQyslwXs
         +JI1J6m5imzk8YzSu7wkGdqeSPEly4g+zGfEQIeKBFeIrzeUVtdbz40UFB+VmwK1VSwL
         LsAAl+LIgFIMT33997cNWZ16gOt8YgVM/hb3rwrfQ8I6C81ajGxsEFeyJ76dnCS3zt/I
         U9F4HM7Jee1Ix+J6u+ZFk23xDWVwBlaq0oXhf2c7Q97H7utKL69A4MWKLSXyyxalZwXP
         EAN/RR35Vt6ZuVMRuaWDdWTrwT+y07SxNid6W0auS8zAber5aH3bv6s3KGbpocoQMtaB
         K9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780042413; x=1780647213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9YoscDiLKVM06+v1BI+BwflOMCL20ObstDfU28fAAs=;
        b=gQLo+SArlnD4vv8GiGPsmfQqw9EY7PAeg0X9q1CN3JRSkY+B2E8Ou48Xtu8GCy6khy
         7oxtcAgggje7fAyZwSZ0EVpratLP+5VPNA3k8FApzhOV/KDRs51Uj4iPrYin0Xm//Kfb
         YHJMkMpKIjFYsnKdMfClI7OGUtMRAQ8X/PvY2ikoAW6TvycNABzxHebqYDTRL6rdZ3Vr
         QUWnmcTopq8WWSyNSsT4w0NelseoXeFpbNVDd4flHpwxngjg2eP05yZS7kmxNkbrxXP+
         26uolCoudGvHuwmHZ4OmelGE4n11lG6q3vmEC0Ir3j2SWG/qg9I+0VYOdZRLxKm1pGA6
         C8CA==
X-Gm-Message-State: AOJu0YwvryuLE+6eLVCXfGdJMpMaSLZNh+oVv4LQIW6aYVzjAMs0folo
	hfDzF7UT9mghpq5/WqVDuzO1MdWCcVp5ogwntgMwoCff6DCfzhuNOo7tFFmwr99G
X-Gm-Gg: Acq92OE0lh4eiNj07HSjU4WiZEi76NfhaM6ma2fKeizoCDnEVuIapEv1P3pZhBYlRZf
	DJSVy0BcSTK7C4zwF1oM58QnLGcWOLOrWNmYIfDlbBz9A2LSNvfmH3KutjGdlO9G8AevwCqfhXr
	oeRWoA6ysRAjoX0TFM77VwDl9v1ZOWe6Y+MZ8S44BJl2B/650Qsxyqwdkjtq+BrnouDXlf4txys
	h9SPVF7lJrBwwlK/JQ20FLJv74l0OxQn5N8MdlYH+ZXwfO8hjvinn6jCjSsenmwTu78GsG8vRoo
	6x8Umw3WAFKIUDsoq7fapp6Q8eeGWvaM2IQ5MajEFUFtrmFAxSr3u39EzLx0jDeX3endNBv51wM
	oKLIWZI2SPztyeapCakS1lOSgt53YCpGqsX98omPCn7sAP2gMlMp0HRCtG7rXSQxDzVH0swnL9Q
	4YJHTh/qYnXkK17BoJ47wOhcBfHOLqmbbr8rcj+Rwro9iLWX0Ulzg=
X-Received: by 2002:a17:902:e74f:b0:2ba:3e2f:6874 with SMTP id d9443c01a7336-2bf209873bbmr24601085ad.26.1780042413445;
        Fri, 29 May 2026 01:13:33 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e6f57sm10806715ad.13.2026.05.29.01.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:13:33 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	zhuyifei@google.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 0/2] bpf: fork state when comparing sign crossing ranges with zero
Date: Fri, 29 May 2026 01:13:18 -0700
Message-ID: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260529-cnum-split-at-zero-3c03db9234d3
Content-Transfer-Encoding: 8bit

YiFei Zhu reported [1] the verifier regression after switch to cnum
based scalars representation. When the following sequence of
instructions is processed:

    1: ... rX setup with [negative, positive] bounds ...
    2: if rX == 0 goto ...
    3: if rX > C  goto ...
    4: ... code relying on rX being in range [1, C] ...

The cnum-based implementation only infers that rX range is [0, C]
at instruction (4). The pre-cnum signed/unsigned ranges based
representation could always deduct from 'rX != 0' that
umin bound is 1.

This patch introduces a workaround forking the verifier state when a
register with sign-crossing range is compared to zero.

[1] https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f106e3.camel@gmail.com/T/

---
Eduard Zingerman (2):
      bpf: fork state when comparing sign crossing ranges with zero
      selftests/bpf: test fork on zero comparison with wrapping ranges

 kernel/bpf/verifier.c                              | 71 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 68 +++++++++++++++++++++
 2 files changed, 139 insertions(+)
---
base-commit: e42e53ae23b7d41df22ccd7788192bf578f24da2
change-id: 20260529-cnum-split-at-zero-3c03db9234d3
