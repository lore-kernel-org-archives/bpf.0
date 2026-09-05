Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FC70836
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566774; cv=none; b=RsJm+2RKsifS2fVmiyUbtjYBN9j9SjFodFppH5b9z4aEwQ1w7XQGEk9jg52BaJe6bInMEwrvMBR2JyscJOS6pl/DNBsVcPj0TKLkIyMfWpzb+bxep+gjLmjrT4+JMSxMDuGABT4CQfCQKqapgilSLDMk8fSaBYVMODKBAHsTNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566774; c=relaxed/simple;
	bh=L4VtiDAFeBMLz62i/IGbofQ1YKJ7TRAsEkVAxX6dtr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EmSQac5xrYn9iDpzt2FKY908FieZK4EkqTOQYTpsCl/qsnrpDOS9RHoczC7PgVFRZVFJGa0g9EVNf21zekCiFRiamLl7jS7qVhy21JG0loOzEfS4wjqHoCHZ83nFpR3kstn0yDr54uiXWLe5pOZvLxOaP4uVqQJ8IxZKalmt7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCYUuJlR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCYUuJlR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so17196495ad.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566773; x=1789171573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EriVP3OG/RGSUzqKFg29+kHQzQPXOpc09jsIDUSQfU0=;
        b=iCYUuJlRzICPQaQ6Wtuo92IaTvwObF7xUoHgeu+2ZDXMvpsxzYtJghdKXduIn1tI5k
         HfjNaLfQmkJj0X5kZVsYHgSn5mX8I3bKiAKruN5HeBDz0sM3A18dST47AW5azBPsjl+3
         lP7ee6BJ7IbbEpRSIpFRkVLhA7eY8QZdn/ltlyX+VKBKObnIBEj/tqITkQVAkgkCbJqf
         BKMs+AddOKZ39neJlCK6wZspe0/mYnju0XZHhMdMiBg3fc28ttaPaExEIvN77oflN7Jz
         nxZ+CNb8Og7LRsHI9rFuh8zCHBfxcW8036I5JtV14MoVMeLMU0Bz17tSVMx1fX9882SA
         jP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566773; x=1789171573;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EriVP3OG/RGSUzqKFg29+kHQzQPXOpc09jsIDUSQfU0=;
        b=cjxJTFY1HW8LM8tHIO1AX3ALieq7rbsXoB+WbhOG0IpLJwkXv1fXUhErXFkDVW0GKs
         nUw2us5TeFQT/eo4UpNSXb0W1ePp2VObraEj8gEAjE31EBmINTfFE58In0MWd/OpcGvc
         vSlNn6BsPIbm7C54Ib9XbnThUif+8AGV9VHyEvIkzJIZqjKbCnbD71I1OoejICAHNsC+
         b4u5WOUbLn4hvRVGOkqrVubEyu8UrLRfYYAGpWZiEHyTB+IofS9pWLOiH7uBywfmXaF0
         O2OYpn29J1+BtamZmrNbBsRsRVL44BnzAqTu/46E3Y7y6ZAEwVIQrh0otbEyDtGvG60R
         jEbA==
X-Gm-Message-State: AFuF++lszCJ8jxsA9+peGngeSRvADOtGX2vQ/uwRYt2hR4xZW7QX7x6/
	3fqpTDTxxGvDjYniQ8YGQSZV2BjpvqDxVvyUtQwTa+kXf46Kdsh0RaUagO/+9u0vVuI=
X-Gm-Gg: AYBFou121wc0KbAHGwff/A2u2nkCcGaDdPooXDPs+SB61dNmfkOT+8DgainJr+54A9o
	MdVJR3aeFjKXYm4D9/2SuSVrQf1Yjy4snQgCQhEIOm9bi1n8U3wz0VDcIW+eEULZlG+l1xMgYb3
	LEsvGE2qRj2Zns2KQWBDBjNoAUxJKUbusAOPX9Kvniqki+9rptNenpyBEa5VXevTLSm92J7uzn8
	JJ27dFRPfvSQRNgc4RGzhJcbWATQjKuvOPdwwoDjoMdRnIJJpY8fW591pU+hOeoEzSyaqmndzjq
	HZeDi7Gg340LfIJ0YGylFgoM2pUE6ReY63c81EIiw9HQZbu94YpXrZVeS+rzAMYXF/DahAErjh+
	sDy9ISKy614MTkF2j0gMvwsNSxz4BCRIf3DlyhbTYnuI3S5QvOoJ+bfnkb2G+OZ4USiwE9WDhkI
	6dhoIgp9jg4soI7nDWSlA0DYEwVxsdIIW0wsuUy8MpbhSh743bWRXe7RwRkEjA0RQiMwpoy07E8
	OuCG+Vfla/pPzNHPiHoLzgaczkulJuYzskuUC8Alu9I/w==
X-Received: by 2002:a17:903:1670:b0:2d9:438e:b70d with SMTP id d9443c01a7336-2db1232c88emr143226675ad.1.1788566772708;
        Fri, 04 Sep 2026 17:06:12 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:12 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 00/10] bpf: add missing precision propagation after bpf_register_is_null calls
Date: Fri,  4 Sep 2026 17:05:51 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260904-register-is-null-precise-fixes-15c7f8cd7a73
Content-Transfer-Encoding: 8bit

Fix [1] uncovered a host of locations where the call to
bpf_register_is_null() is not followed by a call to
bpf_mark_chain_precision().

check_map_kptr_access() is omitted as it is handled [2]
by another series.

[1] https://lore.kernel.org/bpf/20260904083325.2083493-7-eddyz87@gmail.com/
[2] https://lore.kernel.org/bpf/20260904104203.345917-6-memxor@gmail.com/

---
Eduard Zingerman (10):
      bpf: mark a NULL call argument precise
      selftests/bpf: precision of a NULL helper argument
      bpf: mark a NULL memory argument of a call precise
      selftests/bpf: precision of a NULL global subprogram memory argument
      bpf: mark a NULL kfunc argument precise
      selftests/bpf: precision of a NULL kfunc argument
      bpf: mark a NULL BTF_ID argument of a global subprogram precise
      selftests/bpf: precision of a NULL global subprogram BTF_ID argument
      bpf: propagate mark_chain_precision() errors out of loop_flag_is_zero()
      bpf: use mark_arg_precision() in check_mem_size_reg()

 kernel/bpf/verifier.c                              |  78 +++++++++++-----
 .../selftests/bpf/progs/verifier_cgroup_storage.c  |  29 ++++++
 .../selftests/bpf/progs/verifier_global_ptr_args.c |  24 +++++
 .../selftests/bpf/progs/verifier_precision.c       | 100 +++++++++++++++++++++
 .../bpf/progs/verifier_subprog_precision.c         |  12 +--
 5 files changed, 214 insertions(+), 29 deletions(-)
---
base-commit: 41e6f03658adfa9df68642750b53a046f1abdea9
change-id: 20260904-register-is-null-precise-fixes-15c7f8cd7a73
