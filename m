Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508206;
	b=drAEok507eTHifIP1wEQNtQ6KCDspCGW67uMMiq+qy/VxAnW5DaYnfYX3ZD8bMm94ukf
	 NWqFbxr9LPCefkz8XnnC0bn6CxlJpONowDzrV1qesP3LmCLkziYxjo8eL6VMYV8MZFyC2
	 +DwyBEsZy8WeFpAEUisoij9C8dMrPeT200f8mHjdj335toGw5r0Z7xNz0UixXpLZxtduQ
	 M4nPKOgWfBGr/sxG/s1dUJ+VM0Omyc1NA1d6eRO5Lksy/6ofX8B/9EHY0pIcRYq5mHIUS
	 nYZjnJ4eh9hdx86elVm0RM4XX8vJ8IYIX5JKxwJZUz13WVZ9J3Z7pt1JKtKe0aUUCIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YN+FMjzaVgS5VcjGkA9nBfPF/nXduR6wQHDfkefr1bA=;
	b=C2mIZvr9V6Yp+OE+UCSnyIxtssQXMw0NPyM2u4EYs8996oW2nEevGIv4516HJE+ggTQ4
	 kEDMQgihF8aPwZo2c9tRAxcIsGDzsMzTdEjswppnqFQg0bXJDm3aJ3eMuyAzWyXZuukvc
	 Xbx1AZ9E41e+8LWZKC2B6Vx3AUmjMoE/iALSXC7PM4tOfOYrZenA/v7pfBxM4eaBwQhEY
	 sV8jopIABrhpFJEzqz99RSLxVeSslAmOiSmWh6kS+4Okgl59PTnyiReyYVGoReBFfJ4KI
	 DlGv3Wiu3wMfAE4RE9e7D08N3tiCP0UlCBdqeS+/co6x554zHcv3KHmchk0KESBONzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dA+jOzTV;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7723606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7723606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dA+jOzTV
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67999045530so3009332d50.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508205; x=1793113005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YN+FMjzaVgS5VcjGkA9nBfPF/nXduR6wQHDfkefr1bA=;
        b=dA+jOzTVW8RvabfgZIOyvf9ZBTikgtyxsm7c9TTOfWlHzwBl0ZLo12BIpmc54oXZq4
         RPQH1MA3QLmLereZdeIYbsA8Z4zfgIfASdeXnHVDFBQFVnds7TLwnuTuURCXiMV2Cre2
         P8tH3XFHJEMD0DhD+qFwGrLkBVg0EENjetYvHrtBn/8/qHjaRD4F/0g5/O69cyJXQoAB
         7ZuWHWjxS2vtMqMX/i3v2rAk49pcfS0um4Uzu+WYCy30AxWs91vtaL7ZLIUpfNuOjSgr
         K4dRMvDvSq5CdJ/deWaArq8vwNVZncTlyh5wNwXaBrtJVp682FvvXVMBXSFU8/kILLii
         lfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508205; x=1793113005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YN+FMjzaVgS5VcjGkA9nBfPF/nXduR6wQHDfkefr1bA=;
        b=hfwW1jCaxPVLcY6n4cymDd64sr0NGRkJrDzApdAtZ7ShP7EMNChaEUjAMzsD2F1dVd
         eU8VTYiAZwjcRTVrH2lm3n2Q09nnzuglhvhFKL89i5XYH4IKORM2yg1GN9iwfaEOBqAH
         1xpE6AC2SukIWaO4VQYBuP7QQBRRXbyvIwPShdjB+V4BL0IeQUng8HTamZul3C7X+geU
         /3nI8JHB9Vs07A5RJpTNyLR14hiEz3Xk/Xr1urPIPhOusDGn1WJSWpuHMMuQV0OB0Rj8
         MfQt5hBQ3N8YUQpFi8N29W/93fmUlhK8mLmP8dldvgOjbGg4bQvDTiZIC4fSudjUCV/t
         7FoA==
X-Forwarded-Encrypted: i=1; AKwUvBxFVISYVUSGCN8osUFjwQ3TvkNnC5CBD5lHY7WJ0o4IGqPjxw3tuAdUvvgWl/YWb9v/O/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3xkmqU8PZdw6aI0ItJzUQzJu0BJ8wqpS7MVYNDOl9CvR0Ilse
	GdXzUexJWisH5vxyF8kJo3ZGravrZicQ9rYKZ7Fd8qr+ohkDWPD1aMGU
X-Gm-Gg: AYBFou0brtOCf0OZHpSIBETcFA5uRPVwtWJlBGmluIDYTk10CVWGFyxF+FOPgdOdiQD
	9UjRoqmhAKkY/8srdA8SrNrPSlv/hHWThWv6XQKai3RcfeHyz4SC+1/JhfsKe+VbLfUb4b0du35
	0rf5b2bE0/an7x27xSsRmM/ZgB+8l2LoqzT2hSgH/qiAqLP+Rw23TJWAu2MDKC4ZdaN4LoWdoPe
	a8iZUx1QZe5gbFAN3JTZgT328rSR8ZLl10VXaelqLy83VxKKRpSWZNtMVXAfEL/6yTnO1m3KiMu
	vVpcjL024jAmzZcgaXwi5He78ngoIkDx9FiNPHwtsNomovKmWKb0PBrGB5asmt1pZRgqA/5zWsF
	b32zffpFn01M1A/AVchpB1VAuQM3uTOiZsyr7frjrE2qVOvP3Di7vIX9z3A61KMjjwXfimS8Cbv
	MLiuz8wjNytGUTZ/yPNBn64Jd9aKnuQlmPrMBlLlc55QML1pUwhc4fIiOuibNOFZGPCltYFgWK
X-Received: by 2002:a05:690e:134b:b0:679:8af3:af24 with SMTP id 956f58d0204a3-679ca78e9cdmr3161509d50.52.1792508204824;
        Tue, 20 Oct 2026 07:56:44 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c98a1esm5239944d50.1.2026.10.20.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:56:43 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v2 0/6] bpf: bound trusted fields to their parent's lifetime
Date: Tue, 20 Oct 2026 10:50:53 -0400
Message-ID: <20261020145059.2146170-1-utilityemal77@gmail.com>
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
fields walked out of a parent, and elements produced by an iterator.

A field in the __safe_trusted or __safe_trusted_or_null sets becomes
PTR_TRUSTED regardless of how its parent is kept alive: nothing ties
the resulting pointer to its parent's lifetime, even though kfuncs.rst
defines the annotations as marking a field "guaranteed to be valid
(trusted or rcu ...) as long as its parent pointer is valid". The
documented bound was never enforced. There are two separate cases,
RCU-protected parents and referenced parents.

First, an RCU-protected parent, e.g. mm->exe_file read under
bpf_rcu_read_lock(), is MEM_RCU. It can hand out file->f_inode as
fully trusted, and the inode pointer survives bpf_rcu_read_unlock().
It remains dereferenceable without PROBE_MEM and passable to kfuncs
expecting trusted arguments after the grace period.

Second, a referenced parent has the same lifetime problem with release
kfuncs. A trusted field walked out of an acquired object stays usable
even after the reference to its parent is dropped. An in-tree example:
the file acquired from bpf_get_task_exe_file() is released at
bpf_put_file(), but an f_inode taken out of it stays trusted after the
object may be freed.

Fix both by making the walked field inherit its parent's bound.
Patch 1 substitutes MEM_RCU for PTR_TRUSTED when the parent is
MEM_RCU, so the field is invalidated with the critical section like
every other RCU pointer. Patch 3 sets the walked field's parent_id to
the parent's reference. Programs that relied on either escape will no
longer load, but the behavior they relied on was essentially a
use-after-free being papered over with deferred free mechanisms and
refcounts held outside BPF.

Third, the same gap exists for open-coded iterators. The element
returned by bpf_iter_<type>_next() is kept alive by the iterator, yet
the verifier marks it plain PTR_TRUSTED with nothing tying it to the
iterator's reference. bpf_iter_task_vma_next() returns a snapshot
from the iterator's own allocation, with the vma's vm_file reference
held only until the next step or destroy, and the kmem_cache and
dmabuf iterators hand out objects whose reference the iterator drops
the same way. A saved element, or a trusted field walked out of it,
stays usable after bpf_iter_<type>_destroy() freed it. Patch 5
binds trusted elements to the iterator's reference, as already done
for the PTR_TO_MEM elements of bpf_iter_num_next(). Elements of
RCU-protected iterators (task, css, scx_dsq) keep MEM_RCU and stay
bounded by the critical section; they point at RCU-managed objects, and
in-tree programs legitimately return them past the iterator's
destruction (__COMPAT_scx_bpf_dsq_peek()).

With the three bounds in place, a trusted field is valid exactly as
long as whatever pins its parent: the program (hook arguments), a
reference (released by a kfunc or an iterator destroy), or an RCU
critical section.

Patches 2, 4 and 6 add reject and accept selftests for each.

Changes in v2:
- Trusted fields of an RCU parent are PTR_MAYBE_NULL as well as
  MEM_RCU: the parent may be a SLAB_TYPESAFE_BY_RCU object reused
  under the reader, as Sashiko pointed out for file->f_inode
  (patches 1, 2).
- Bind trusted iterator elements to the iterator (patches 5, 6).
- Cc stable on the three fixes.
- v1: https://lore.kernel.org/bpf/20261014173039.3666415-1-utilityemal77@gmail.com/

Justin

Justin Suess (6):
  bpf: Carry MEM_RCU for trusted fields with MEM_RCU parents
  selftests/bpf: Test MEM_RCU carry-over for trusted fields
  bpf: Bind trusted fields to their parent's reference
  selftests/bpf: Test trusted-field invalidation on parent release
  bpf: Bind iterator elements to their iterator
  selftests/bpf: Test iterator element invalidation on destroy

 Documentation/bpf/bpf_iterators.rst           |  6 +-
 kernel/bpf/verifier.c                         | 24 ++++++-
 .../selftests/bpf/progs/iters_task_failure.c  | 68 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_accept.c | 41 +++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 70 +++++++++++++++++++
 5 files changed, 206 insertions(+), 3 deletions(-)


base-commit: 763187dbbf83764a57d5811168ef9de7b9a60e2d
-- 
2.55.0

