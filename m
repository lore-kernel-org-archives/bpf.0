Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790493;
	b=AosbnhWc8ERh6TEMc4sxFXAEPofw+BXlJr3gRjxNbAZnry19KfsAS/jYKPcEKrQ0W6yB
	 LQP+PX3s3EOG2bLXSxBQNug7dwjmj3yuokgx9RIbVXsAq0eZrJgNpKgoTvYyzxCt8n3o2
	 d8uHqBpwuC4ZWuRt0xNvsz4ZRDuT/A9vNdO/zOnf0sF6UUdlrHLLRxoD5PXNdRo/wu0ot
	 dnQqObxu6SUHmshrdYw7jmbGzFryiTcvu3MGOygWILoKTyJ2xXlPOIpfZjSdprbQPr+ll
	 /jI69YU8oSxX7GfJgOmHSgFUzxnREIqY3s0YzMLVMjb7TSxycYLvosaxVRfJUscQroA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YWkmcMqQkTB35w63buqSgPlqsp97Ui8qgCIAmmX7HIs=;
	b=UOBrhHnrOVTDkd7ZILLMdVHlBsQC1vY4DFkmsGYxWXSerEc0N1OyLo4biETXwm2KGXyA
	 65ZFkhMQvSu6jdKbPJSwwRlqw1gL0fFIeio7XJFv9y9sD4jEaERCbCZPgYs66gXs0zHn4
	 Iz0iXbwlxxMnnfCDkCRpixS5wvJSTpkmsINyTMPQm0aAGIQwZoHQx4WQzfnx9bGKjMfmM
	 QuHujQB2vth3rNV8ykhTZP0eW7iYWH096dgg94YSNUBXS8w2FD63tfuIwCEJrsOE6egLq
	 gCWaJ1drZhH9sYle41lFEVB7WFkm4oSVQ2fDCGG6DwCBE9urer8/Or9xOI9v0+g0ICA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iaRv798M;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB81606A321
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FB81606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iaRv798M
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0f59a5fdaso11716957b3.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790492; x=1793395292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YWkmcMqQkTB35w63buqSgPlqsp97Ui8qgCIAmmX7HIs=;
        b=iaRv798MmZ6A2UrXvNyBuhGIhDqorA48piwUAw40g3NRP6GNOY9fbvCTzNTjFpqssL
         j/5/CbBdWp6G2jAzMxwz1vBaqy3LESNzgbh1LVdknIr/Pp0r/odOIdtq2HSThQnyB7J8
         uD81j1hHpI4MjQYHyjOzMZTLAyJSvYUuA89fdhdFdsrroxolSkE8vri9YnUzFAWWUsZl
         vE366wg/8twzB7chl9yZxQ50fFqgs+jwtwXg/6/RQ/1GBJPXdmHMNd0rFLJVnrYusAXR
         Knmyxx/C+8h55nHYkOYVJpTmMIBAUgrHZlR8Hp+gNTkHCOH5yMlgZBuM7krhTQT7ZVhF
         6DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790492; x=1793395292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YWkmcMqQkTB35w63buqSgPlqsp97Ui8qgCIAmmX7HIs=;
        b=p5lIWF6+kmnhtI7jY8mnJRrEdj/5jt5LgTTMAIQmyAmF6bMx7p04EMpWt/ulwBafEz
         5pw5WoxNJYsVPANK/MdIeP1Kyn9rlDBE2FoU2uIBmo2d7lGRpxYrKcwBWKvvsdCnMXvo
         Ej560fdiRK1iVZQq3VS+3ZU1oUE4m8zpQmBUMUhxkRcKwjeXCWCHzYl3OFtPKr+wNy4c
         hLVmcxaJo8PYKdIYxNsZY064rvJ1OB8HbCODnDyLd1/jReY5eX7klHndbMN5yunXjtP2
         fmq11EaUPFGpNXgr7FJG2Kk0FItTuHXIJYKeAd6vno5s5hhVaZQqVliRypskPybT47Kw
         qGpw==
X-Forwarded-Encrypted: i=1; AKwUvByP6E8eWkJ4SJyYXNZ7zNKPK5MpENAwEt35Y7CFpQOcII6WgGgqTtQwKNLneEFBchkGUEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIJRdL8dhUJ5KUJtA0oy4Ecf2tJAg1Z23GjsMGzLlLUyxDMa+A
	Vpb0KhBQL9AwRUuMbTU88Fa9FidFrULlMIQ7992YE9c9yXjWO+FEKnlr
X-Gm-Gg: AYBFou1Yj3vxaQDuzF4kWiVv38HJ36B+AqNKBYMtvy5bX/bnmCFjZqAaVRxnj2SlSpt
	8UTLr8jKxSMQAI+aVzFbvIau4UvnshG5wsYrpDTAGni4dbx5W71WYEnpWyf6dhsOHFIrwI/RYRC
	I44Oq9X/Y4l3wosJsxBP6zAVzTuej0Wdu1v6pegI6o3ddgcI0Djv98bA5oSrop0Q0JSTjbWmFvb
	umadiZIBzxI0ol1yJckKoc5BlXP0rjqr9Ui44aJU2edoX5OPCYgUcIXciuUsTFjOJBqy+mbaBn2
	rpt+X/dn1G7vBEJNaBu3+9ujSZr/vCnsr9kuySzv7eLuG95m1+YTJx/cb6yRejt5V6viR9DBB2b
	t0FePobEyv8La8aUa8PWEt9PwpNB6gaWX6aW9GSs3fCTEx+zst06H/nbHhjhorSBxpR1jGu8Bhr
	KhUqnXrO0bfCZ8ml8MDkzgOysFdtu4+g1W5cn/beppsfL/AeW5b6s1J/ti/VDxZT+QlIUw57q1w
	jOH4pJz08+61f4IMC0qtcevJX2CboyHtQwGmYTz7dOTw2uHbbDs7jr57A==
X-Received: by 2002:a05:690c:113:b0:8ab:422f:a89e with SMTP id 00721157ae682-8b166c5c0e5mr3475307b3.53.1792790492305;
        Fri, 23 Oct 2026 14:21:32 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:35e2:98f8:e90a:1695])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e46a93sm1915667b3.26.2026.10.23.14.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:21:31 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Xu Yunxiang <xyx2021@mail.ustc.edu.cn>,
	Amery Hung <ameryhung@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 0/5] bpf: bound trusted fields and derived returns to their parent's lifetime
Date: Fri, 23 Oct 2026 17:20:36 -0400
Message-ID: <20261023212041.884996-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Howdy folks,

Fixes to the lifetime of trusted pointers derived from other pointers:
fields walked out of an RCU-protected parent, and returns a kfunc
borrows from one of its arguments.

A field in the __safe_trusted or __safe_trusted_or_null sets becomes
PTR_TRUSTED regardless of how its parent is kept alive, even though
kfuncs.rst defines the annotations as marking a field "guaranteed to
be valid (trusted or rcu ...) as long as its parent pointer is valid".
For an RCU-protected parent that bound was never enforced: mm->exe_file
read under bpf_rcu_read_lock() is MEM_RCU, yet it hands out
file->f_inode as fully trusted, and the inode pointer survives
bpf_rcu_read_unlock(). It remains dereferenceable without PROBE_MEM
and passable to kfuncs expecting trusted arguments after the grace
period. Patch 1 stops applying the trusted lists to a parent that is
not itself trusted, and moves file->f_inode to the __safe_rcu_or_null
list, since inode is RCU-freed and a SLAB_TYPESAFE_BY_RCU file read
under RCU may have been reused with a NULL f_inode. Patch 2 adds the
tests.

A kfunc that returns a pointer it borrows from an argument, without
taking a reference of its own, has the same gap one level up: the
verifier types the return as trusted for the whole program.
bpf_real_data_inode(file) hands out an inode the file keeps alive, and
it stays usable after bpf_put_file(). Patch 3 adds a __derives_ret
argument annotation: the return inherits whatever keeps that argument
alive, its reference or its parent_id, and a return derived from an
RCU-protected argument of a KF_RCU kfunc is MEM_RCU. Patch 4 annotates
bpf_real_data_inode(), patch 5 adds the tests.

The referenced-parent case, a trusted field walked out of an acquired
object staying trusted after the reference is released, was patch 3 of
v2. It is dropped here along with the iterator patches: Xu Yunxiang's
series [1] carries the same field-load rule and binds iterator
elements to the iterator as well, so this series only keeps what it
does not cover. Patch 3 introduces reg_lifetime_id() in the same shape
as [1] so the two merge cleanly in either order.

With both series in, a trusted pointer is valid exactly as long as
whatever pins the pointer it was derived from: the program (hook
arguments), a reference (released by a kfunc), or an RCU critical
section.

Changes in v3:
- Rework patch 1 as Alexei suggested: gate the trusted lists on
  is_trusted_reg() instead of substituting MEM_RCU for PTR_TRUSTED,
  which would have handed out non-RCU-freed objects such as
  vma->vm_mm as RCU pointers; add file->f_inode to __safe_rcu_or_null.
  Not for stable.
- Add the __derives_ret annotation, the bpf_real_data_inode()
  annotation and their tests (patches 3-5), as Kumar suggested.
- Drop the referenced-parent field binding and the iterator patches in
  favor of [1].
- Rebase onto bpf-next b116ac608754.
- v2: https://lore.kernel.org/bpf/20261020145059.2146170-1-utilityemal77@gmail.com/

Changes in v2:
- Trusted fields of an RCU parent are PTR_MAYBE_NULL as well as
  MEM_RCU: the parent may be a SLAB_TYPESAFE_BY_RCU object reused
  under the reader, as Sashiko pointed out for file->f_inode
  (patches 1, 2).
- Bind trusted iterator elements to the iterator (patches 5, 6).
- Cc stable on the three fixes.
- v1: https://lore.kernel.org/bpf/20261014173039.3666415-1-utilityemal77@gmail.com/

[1] https://lore.kernel.org/bpf/20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn/

Justin

Justin Suess (5):
  bpf: Don't apply the trusted field lists to an RCU-protected parent
  selftests/bpf: Test f_inode of an RCU-protected file
  bpf: Add a __derives_ret kfunc argument annotation
  bpf: Bind the inode bpf_real_data_inode() returns to the file
  selftests/bpf: Test __derives_ret return invalidation on argument
    release

 Documentation/bpf/kfuncs.rst                  | 31 ++++++++
 fs/bpf_fs_kfuncs.c                            |  9 ++-
 include/linux/bpf_verifier.h                  |  6 ++
 kernel/bpf/btf.c                              | 35 ++++++++-
 kernel/bpf/verifier.c                         | 48 +++++++++++-
 .../testing/selftests/bpf/bpf_experimental.h  |  9 +++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_derives_ret.c          | 50 +++++++++++++
 .../selftests/bpf/progs/verifier_vfs_accept.c | 44 +++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 73 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 +-
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +-
 12 files changed, 302 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_derives_ret.c


base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
-- 
2.55.0

