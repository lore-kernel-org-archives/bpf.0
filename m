Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387CD34D397
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470775; cv=none; b=VFS3yLtSDclEpB8FgNsJ3KcLAp4arhMYeGzABqHJ7zYQhHx85MRpStg8eb6C9KpRwRiGSpDNFHXr7Ipp9hOQ3ura05BLqicx4SSXZ0Slo9df9b0M55+uKalhtXAAFHkRMJRUcJxPEltn3HcT9SPVWB/fbnR5wIAtVdtJj303Y8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470775; c=relaxed/simple;
	bh=/zMY1ilEQKAegDHK2lfET1yQ59lfnPIUwyq0TyZ485o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ugJhk4HidmKYWxYHTqjnz5PEGAs0fsfvIjqUC44kqaELKisX2Qxd9uJS6O4B99POYrtJVtRXrAUwNJd9z4D3SW82h4nl41I1SxwzO+QGERzXVT7DKLXe2kH19zIg7Q75+yCHhoOy+wzBKmTpUx6UQ2c5+FitUhrHaF+Xy5yT7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu94efCp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu94efCp"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3900e39d935so209477a91.0
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470773; x=1787075573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGuew9w6TlhuLJBSOvs53motQwcTEIF4youbPvz38WQ=;
        b=cu94efCpwjcmJr3kzYlrn3Jb0TDSq3FJhalUUJHt268jSFIumSAEn8YMpKFrje7Jsc
         J6ibOvEII7x5bv41JjOISOx3cLnKLY2E6fzZ+C5sPZacKZxqjGH4I8fs5pajZxVUfPmP
         6IqAhEsmo/VrEs3yq1dPuDw6syITrGVkQGCzf2TzDmnshnUuYCtERZgAuxNDzmyzHcfJ
         9iyszA/IW4KZwOV+aZPIKjU955XmCJb29ZROdJCYCePtQyB6UGKyyrnvWlswWrY+OQYj
         noFrSgxyaq0UooPm/Gns1zTVMPqWtADo/UYGqP+5vqK0iJIwPFDJtYuoRIE0oknkHvDW
         KesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470773; x=1787075573;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eGuew9w6TlhuLJBSOvs53motQwcTEIF4youbPvz38WQ=;
        b=e2TbMJhsV17B/wj1DBH4UexRc80u0/yWCQDwKuZ3+m7now5oev0QqY6HapmbRAuj7G
         Eaii5Jth8VEi8QF/tMBTkIU7x+HV07oKJMrEhMDdySEI1A6OCrgsRxQCSVgxkuSMvaLe
         uz13TQSk9Fnphli+oeFJk3xxqebgNCIQKhelf4M7ApKB+bDhdsv1991KjcBYNfavG5UD
         bpNtFhbz9dICsrU0CwWqC7FiQJTr0+COqZ5k+rVKidod8Mfa/HxPOfJMCbpJgIsSsPzL
         2jpa+mxfPZtPeO/IakKT7YHeJL8qRCmZemvBq/cPcaCGf2LoAnXDtuZxlbwB/Gk9hqZ/
         P6eA==
X-Gm-Message-State: AOJu0YyYDeoemEODSqdlPYQWyWV450AY/VM6fU1mmTIMIz16GuW7dRUZ
	vdB12CBqrI8BnvbwI0g4G27JHolEOs9cyBM5znVk88FxjpDja/hnKIdbfd56YBOJ
X-Gm-Gg: AR+sD11v+UJ1BzYQyHWhsTlr2fKn4YLWihYtB73Esp4teRCFbWtjTfo2lE8sz4aCIoB
	NULpkxQCe/hf69+bG2gqTDVQkcK2EwVXnsTIRWLiNPxSQ0s5v9/5DKbC1fJV3yoLyM/4V/EopJ2
	/gHlNSpWpK6QLUbreZvFn4hMl9DnTiaSx4dSQqfOfJl7WENYnqDMWasiYcjx/9dKGN57REisWA3
	DCbqY07CipzQa9us0+Wt+u3mTOs2X143PwnQYBUXQU7iCZLN3X0EOc1ouCpD9q72Qsanu/v3SUE
	B1gIMefOuRtuVWFGBvneWDhAZkZ4LRQtmCFcZAv6lS44iVjST2VSshjt0AqCVolSpfZ1sgpFVWB
	ep1WC/TLzbA6zPXuxAsTHYot1B96cQ47uwuANyes5NquJ4DlvOa+ZuQFsHSwRBwR780VQ0/aRci
	z3+cv0JuAtgCCmv2xcHk98ndPgUOeI/U3lcSB4Pmz+5kW1pTNhADEyP5knOzLgoNzqM7YTDiaE3
	VL6k8Kpp2/nQN2hVgOiE+NjJ8JX6MBA5hs3UpzN3SVdLQ==
X-Received: by 2002:a17:90b:2751:b0:392:e5b1:d833 with SMTP id 98e67ed59e1d1-392ec557b4bmr6554125a91.13.1786470773474;
        Tue, 11 Aug 2026 10:52:53 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d726f1sm2405112eec.26.2026.08.11.10.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:52:52 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/2] selftests/bpf: fix for veristat file/prog filters processing
Date: Tue, 11 Aug 2026 10:52:40 -0700
Message-ID: <20260811-veristat-filter-fix-v1-0-b5b43c431550@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260811-veristat-filter-fix-920cff2a288a
Content-Transfer-Encoding: 8bit

At the moment veristat filtering behaves unexpectedly for the
following filter expression:

  -f !file/prog

The expression rejects all programs with name 'prog', and all programs
in a file with name 'file'. Fix the expression to exclude only a
program 'prog' from a file 'file', also add a set of tests to exercise
filtering logic.

---
Eduard Zingerman (2):
      selftests/bpf: fix for veristat file/prog filters processing
      selftests/bpf: exercise veristat filtering logic in a selftest

 .../selftests/bpf/prog_tests/test_veristat.c       | 98 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/veristat_bar.c   |  3 +
 tools/testing/selftests/bpf/progs/veristat_foo.c   | 31 +++++++
 tools/testing/selftests/bpf/veristat.c             | 76 +++++++++++------
 4 files changed, 181 insertions(+), 27 deletions(-)
---
base-commit: d114bb98936770c501c958bf2bc5fb6b7c0bad7b
change-id: 20260811-veristat-filter-fix-920cff2a288a
