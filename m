Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C936998A;
	Tue,  1 Sep 2026 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244222; cv=none; b=HdOIw2cnC20K4GzheO6tKJkmozoLCRUZx8j2F0BIzHM4IyP6wpkQ0F4slCtTIRJj34eYeCSrR+p+osFrJZUiuUq60CyEeoacTmb50onC7RUfSBd3Cs1a+2X4DMJPXmB//wAY+ajfYc2OD+f4lJZfhaVBfDXzXITHJu+2kY1bYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244222; c=relaxed/simple;
	bh=hu0xgAwinr7ULfquHxN63bmUDyJRqg4DWEnqMbRS0dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lByoPdfny0R2gKhYV/B/Z9nwVKhPV6TQ1GBCTRVjU8tU2LtXoSbGtAY7pGQ49WQFcrhd/2iWGtpzOlnIPkGlMUILHhcDG/wS7qNxRBYfySHeeSSX81A0G1DIw43P0Q6hB6tDuLqYIByJXDnuTQdj3Bh4xjZEqmWQ4B9tgxE81Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mYxxH3aK; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mYxxH3aK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=RNFRlM7b7wHdz0kBqUWQyYznFdv7eUB1CTyXVXzmkgA=;
	b=mYxxH3aK3ui+Pn20l0jGj6FP+BnujuascwEcJq5jrEbJ4FJI0LOpupPVFX7jcW
	RzlIRwCv2s4VU4bg8evs5xWOC+MjXdJfsMNcanx8GGoq7OUzs6BqAkbwNJ/9Ccz4
	6UVHTIxNs6ocGkdwXX1Kcl40kl+xD8mY77YCrWUq0C3bg=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3n5+mcJZqA6mBNA--.25535S2;
	Tue, 01 Sep 2026 14:28:55 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v3 0/4] bpf: Cancel special fields in resizable hashtab on recycle
Date: Tue,  1 Sep 2026 14:28:41 +0800
Message-ID: <20260901062845.1379760-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
References: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3n5+mcJZqA6mBNA--.25535S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyrGF45AFykCFW5ZF18Xwb_yoW5Kw4Upa
	95Gw13Kr18tFn3G39akF429ryrGws5WFyFkr13XryUZr15JF97Ar4fKFWxXF93KFZYvrna
	vrn2qr95Cw48ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QmGRGqWcKmxYAAA3a

From: Yuan Chen <chenyuan@kylinos.cn>

v3 addresses Mykyta's review of v2 [3]. Both comments concern patch 1:

  1. "Could you please double check if this is needed at all? I think
     bpf_map_free_internal_structs() going to reset special fields to 0,
     so immediate reuse by __bpf_async_init(), bpf_task_work_schedule()
     correctly identifies fresh fields."
     -> Correct: bpf_obj_cancel_fields() resets the timer/workqueue/
     task_work slots in place (xchg to NULL in bpf_async_cancel_and_free()
     and bpf_task_work_cancel_and_free()), so no re-initialization is
     needed on reuse. rhtab_init_map_value() is dropped entirely; the
     element alloc path now matches htab's non-prealloc path
     (alloc_htab_elem()), which also performs no explicit init.

  2. "Let's directly call bpf_obj_cancel_fields() here and below, so it
     is consistent with htab."
     -> Done: the rhtab_cancel_fields() wrapper is removed and
     rhtab_delete_elem()/rhtab_map_update_existing() call
     bpf_obj_cancel_fields() directly.

The resizable hashtab still eagerly calls bpf_obj_free_fields() on
element delete/replace, which runs kptr destructors from the caller's
execution context (unsafe in NMI). This follows the existing discussion
on RHash special-field recycling (Nuoqi Gui's series [2] and the review
[1]): patch 1 applies the cancel semantics like hash/array maps
(a3a81d247651); patch 2 fixes a program-BTF use-after-free in the
mem-alloc destructor found while testing; patches 3-4 add regression
tests (NMI update, and per-field delete/re-insert cycles).

Changes since v2 (all from Mykyta's review [3]):

  * Drop rhtab_init_map_value(): bpf_obj_cancel_fields() resets the
    timer/workqueue/task_work slots to zero on delete, fresh elements
    come zeroed from the bpf mem allocator, and kptr slots must stay
    untouched, so no re-initialization is needed (matching htab's
    non-prealloc path).
  * Call bpf_obj_cancel_fields() directly instead of a rhtab-specific
    wrapper, consistent with htab.

[1] https://lore.kernel.org/bpf/DKEVG8ZVJDDQ.2G40FTOIZKU57@gmail.com/
[2] https://lore.kernel.org/bpf/20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn/
[3] https://lore.kernel.org/bpf/0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com/

Yuan Chen (4):
  bpf: Cancel special fields in resizable hashtab on recycle
  bpf: Fix use-after-free of program BTF in mem-alloc destructor
  selftests/bpf: Test rhtab kptr recycle from NMI context
  selftests/bpf: Test rhtab special-field combinations

 kernel/bpf/hashtab.c                               |  98 +++++-
 .../selftests/bpf/prog_tests/rhtab_fields.c        | 337 ++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/rhtab_kptr.c  | 184 ++++++++++
 tools/testing/selftests/bpf/progs/rhtab_fields.c   | 378 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/rhtab_kptr.c     | 146 ++++++++
 tools/testing/selftests/bpf/rhtab_fields_common.h  |  19 ++
 tools/testing/selftests/bpf/rhtab_kptr_common.h    |   6 +
 7 files changed, 1152 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_fields.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_kptr.c
 create mode 100644 tools/testing/selftests/bpf/rhtab_fields_common.h
 create mode 100644 tools/testing/selftests/bpf/rhtab_kptr_common.h

--
2.54.0

