Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74663CB
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999069; cv=none; b=OnP/fiwcsBAs8cPndSnk9dBUDABkEFUlsJQ+hfxPje9ytNMYS9uVcCNGpIHWHXnvbHPnSGEkQHHv31Bi5dGJJOGmwr+8xj3GI8D6OL7ntYS76vpO/p3lITDX9muV8XHQ2yiy58VXR1oCWx7u22HfKfG919cCU6oviqZbz6ShY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999069; c=relaxed/simple;
	bh=WKQM4qYkW2EhXUqBRdWhlmEY1wv/rHbRa3kzgERdTjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7dqWUWZJGiarK0nohpxGVvntpBTHFBfW7adtZ4ZRV4HoEqFRdokZ+uWVoG0fx8/x83PAU2N2rPr77aY0D4fNbbMm1cZEas0VBAhBSmaZhALiMob9/gGg35HjINIJfPw2BzhBVtXSfLr5NxAXk8xngbyXNZqEOEgidL0lX/aNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKOgOqam; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKOgOqam"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6756a01fa01so4392966d50.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999062; x=1792603862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=riWdiV3hCLKViFJc83JAYONbt8PQ9CoklpbQPogCqc0=;
        b=QKOgOqamo/YiG1Wr9SKvP0sZO8NXvufouHd6htdst2TyefuKyUGpdTx8ZFebXGQWSP
         1yfKMCz8UG2hHYYq/TX7XeN9uNkpbwO07toL1bUIg8GgwH/2CpvJEshSfpj+KGGw72ky
         3apnVbI3IuDSbnxzjbRgMbkT3srHITK7tJvYYQMc1xET+GHBT29G3VBV2CcFRQMLxbnJ
         o/mWvc79OY0EIqXc4K7LHN5IOplHoovElwM3t7McyzcqmVzH2IkgLV2adqrbyIDhzgKr
         FwLTcRwmNq9PwrmI3BHPE4EXmZ8VRhrEYuIkViOQJNjQDCngWFN+K4MW5j3FdfPgHOBP
         Dbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999062; x=1792603862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riWdiV3hCLKViFJc83JAYONbt8PQ9CoklpbQPogCqc0=;
        b=fzj9cpGSYzejTLJOKO4eWimkyh5nXUUjAOL3wF/ZEKxUmJttr13QHcwFVi6Zboc9Iz
         K3vSGDdq4CEjKjFlAL/PmhjIKfzvgrmdsszsuyZ0qWcjR7m2pWw4+5ajlOftomhGgE7S
         RWW/8IQgjlF6TDslYZ/qd7e0u2JZyspHOXaBvK+r5Gix+H9haHa3FQ6XOYas5uI2M0EN
         1xhLtC9T2CQP9PxtaEdy1bxvSatk4HEi+j4iT4ypEZIr5x13iQ5qThS4VltM1EZD1ujG
         cnomZSnTfJ44g2W0X9QI6ZOGz9pNApfqj5pg7LXugwM2YdcI9QAL/1QuJXMKb6D8+p+W
         dcBA==
X-Gm-Message-State: AFq9FYL/uB5McogbWBF9MGTWxGbbiXwiBZtNSYNlRKpfnL60feCF5/z1
	E5y5gspjRYlrs3456AHv6U2QFrGKdHCZxjyIDCBnGHTqD4wi4h28ys0h
X-Gm-Gg: AYBFou0+fa/ZNMrq2yp+khtYBTcaPv0WmUVOwJOokjBl/cb3Qnu07n32GixhF0LY278
	k3I5lxaPHSyx3BdZJSfz6mAjN24KU6nq2bd+E8YXU8v8A9EqPEe1AlucHNLR2RQbXgRkxGdB0Qj
	IMq9ChQD+YKvQHlpL12awSlFOOXWmh+sQomXgxBiMm+TUvuCKXqqQXCn2aHmPVndSX+wrW8kCk6
	4+OOjynHyOpvvYUeb+JodkjtCs9NtoxmiTLvUwMGohf7ohula6pnPkkatphKFaQhghG0Nbta6Ew
	YKgplPWCHqTcQOOdtLJkZDV+ltvY8I2IcNd71uTCH2d+Lh0ZFBDmNis9HcW8MswFn8QviGdFiPY
	93a+nx2+7c+h+sPi/PvSNYYNaYTMSeGKa84NynSbPy3N44xRyiFx3/B1R8FAbszsT5gKsvoKf6V
	AP8orum6HlIgGiY2LsNxBWUyjuFy/rKaY7j2nvfQhCGCUUxNnfQLPiPhqmWMe1XRKJfzMuqosu
X-Received: by 2002:a05:690e:1387:b0:679:9a1b:1f71 with SMTP id 956f58d0204a3-6799a1b3455mr305127d50.56.1791999061438;
        Wed, 14 Oct 2026 10:31:01 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8784:7d62:1705:ef5f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a66262sm1277803d50.11.2026.10.14.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:31:00 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 0/4] bpf: bound trusted fields to their parent's lifetime
Date: Wed, 14 Oct 2026 13:30:35 -0400
Message-ID: <20261014173039.3666415-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Howdy folks,

Two fixes to the lifetime of trusted fields.

A field in the __safe_trusted or __safe_trusted_or_null sets becomes
PTR_TRUSTED regardless of how its parent is kept alive: nothing ties
the resulting pointer to its parent's lifetime. There are two separate
cases, RCU-protected parents and referenced parents.

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

Patches 2 and 4 add reject and accept selftests for each.

Justin

Justin Suess (4):
  bpf: Carry MEM_RCU for trusted fields with MEM_RCU parents
  selftests/bpf: Test MEM_RCU carry-over for trusted fields
  bpf: Bind trusted fields to their parent's reference
  selftests/bpf: Test trusted-field invalidation on parent release

 kernel/bpf/verifier.c                         | 11 ++++-
 .../selftests/bpf/progs/verifier_vfs_accept.c | 40 +++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 49 +++++++++++++++++++
 3 files changed, 98 insertions(+), 2 deletions(-)


base-commit: 763187dbbf83764a57d5811168ef9de7b9a60e2d
-- 
2.55.0

