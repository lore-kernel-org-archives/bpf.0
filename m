Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997075;
	b=Zuq92vW+Iz9GDx2HczudUGHRrhmlQY39kSQ2G9Ztl9LW4/yKde1RX6OtRFJsPfc6WXE+
	 Y4EPb8MQXMyIK7jxd31971tNNBqgVga6i66N71KsBHu15x3hFUysVdbYdzulRd7EEAJK8
	 tDx0HLKb+FaxiXiob5TX+BG/wzITn0wPCrA+2gjM/+kzL5uU/G3PwD0nG1oq6/7t/jiWB
	 0ZIySRsMVfUbPHn6QP/SSe5T9r+B9mSnCFh8NP0nWYsg1KljNI136CHL0PenjxKmm82Dt
	 Tu0RcZRjSmwYEQBwKd0HzPvhkMsSeUWhIOfgaY/28PHE0PbNRd8SygJUiBlNnsUdxuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6CmmjYNrH/gQYOfYcMptODL/q5N0/pdgH0i5rjLY/oE=;
	b=nrJOHPPrIdoomdLvdO4Fr4EfayGETQQ//szlo2PWPaIEEP8Q1K7I0Ox5phpxgzjUeIzw
	 tvFo5aqyGO8ClL7istUxP43fK2wvI3SCgco1zcYMT/lcQB8FDeXVRGx4dNOV39GDCtmtG
	 3pz21lQFhz5Urfr6YnUy7O9wu2kmtQVGmwhOp4JyDx/Nzaj7SwrjuTTEdTqg2a4jSvKr4
	 4Ra455I7Zz8p+nc6ivZK/K8/mKZypcht7SY+3wB07Pp7ipCM7x/6WzRvOi62mK3kvc1Sh
	 wIXXORUFW1WHQoKnALfxriUcheU1i3P+ovgr5eBy4X22tyflYvGHwzKpagFijV+bxXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VihkZXcb;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39487606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 10:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39487606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VihkZXcb
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4ad5b52f0a7so536005fac.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794997074; x=1795601874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CmmjYNrH/gQYOfYcMptODL/q5N0/pdgH0i5rjLY/oE=;
        b=VihkZXcbxi7XZOqP8F5krstDnEqCdHxwcH+Iwfa4KMARwEcxEISu8v4dhe+G29HoxL
         1Uamjr7Qd7lMK+8xNg7lsNg1Qe4+2c7LAYstMUjIfzeDJHz8iWe+BJ59tXs6tD271WvZ
         pfZ55mdijjWLhWIpvDk8VFIRckBsyjEXfpK/RBb+dcbmjTQtEhP7xgVReqgZDjN4UTYD
         SW8dbkZNZ/YEWBfnui1FHF2P2QuvQIb6VVnsZ58GTZz77ssTcSMBWZU1Y371sxWvsO09
         pRzCZY0DaDOSvZRohyFELwE6yHACt0Nb7lUK2kQUgHRThpjPwizmR6D2sG7uov+xvfIM
         QG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997074; x=1795601874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CmmjYNrH/gQYOfYcMptODL/q5N0/pdgH0i5rjLY/oE=;
        b=Dpq2X/hllGXQ8aOzLqyyxkpPYjadc6Ntv6kcIQZo7Cr25zWupd1fA/iGate1yq44Pd
         cbtKew0R82lFYJuOtzyT059wuOU3Cub9fUSH8Aex9Q/e8rsLwELqbMX/x7b9V1F7+dGq
         g9ubT7hEtrXBKbGJpHof6osHD/qBl3w/r+JE2iIEfBx1cBRvaPEG5oNlszZucbLli6Py
         fAsau/L5zVjbzlCLV2YYX7W9Ku9l+qu19L0lsJZ1Id8zXdyQJ1SmwTWcYpHGBwBZVvS1
         itXBvYyQqlE+U/SKuUdKrpVkIDp5vomsQzm4Z5wAh3r3wtAXQDPw/Et4XcYcL7albnjZ
         nSWw==
X-Gm-Message-State: APuU4Z/CmsYRk8tqSPL0nyakJaX13yBIG7GR8JsHhU9Ku3Q//tF0w5HQ
	Hn4cTKInaeJK7n+0VIbM6qR1Bdl0+ZrGQ0QtqAoCi6sOZcY/AApt0AK7
X-Gm-Gg: AYBFou2lsyKyX9x8X4XgATHcLzU2HwJFPhpP/3oXe7bka8lck9xNCX/Dz68xXpqMsuq
	WGKMSqdkJAfcb1wg8enN1suuDhO+2lVaZ7qFk9Txm+nBHsf/PTCsHbBSOGfi9x8sIu/E2bzhPZb
	YA0xco/DO+QVAw/ajvPZ+CssNWl0eYG7cst4fjqCRHWUXlD/xCrjczAYejWCX7054rEh8qIIdHR
	oO6RP+dlQ90aldawYWXkOSlS2RoNhUMAOEYp+59sxsu/oMZKc3MDoNbTMuM9El2Fmx9+mmCmuSv
	/lU5X4k7cbGMFHdPgkvunKFN9Ak9QUYrfp1OKuHQ9dpQylJZpMiVMB3+VEcZz76dKTiG7AoPbX6
	H9V7L//kBSzDCIPVrtBpkFPrFAf1X0GhGYM1XGY3KlS/Y/qra8yw2wP3jlUKBYT9xObOEeNt3gF
	DMBa2ZgP4jvV/9DjAoSPKhAo/Xq+rB+ZSHbwdapWXa4C4vw5TY9OP6DpdAuL6ZiTL1UqVxfwJSm
	BLt4i1hJ9Ln8/8RehEMaZr8Y416QnUS+Li9ajxu65zztMkICR4YscEL0rSGWD1itHaFeSoUYrdp
	HcqDdGlBUzh/Sgg+6HfSo0RtaCymBWl/cBA4QvkGJeh8RkODEsn38kDTiAtiAGA=
X-Received: by 2002:a05:6870:26e:b0:4a2:809d:8fcd with SMTP id 586e51a60fabf-4b75e828bdfmr1538265fac.35.1794997073633;
        Wed, 18 Nov 2026 02:17:53 -0800 (PST)
Received: from localhost ([216.128.135.139])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74372cb6bsm1772612fac.4.2026.11.18.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:17:51 -0800 (PST)
From: asatsuyu.liu@gmail.com
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	vadim.fedorenko@linux.dev,
	Yi Liu <asatsuyu.liu@gmail.com>
Subject: [RFC PATCH 6.18.y 0/1] bpf: reject NULL arguments to four kfuncs
Date: Wed, 18 Nov 2026 10:17:47 +0000
Message-Id: <20261118101748.2335815-1-asatsuyu.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

6.18.64 still accepts NULL and PTR_MAYBE_NULL arguments for four kfuncs
whose implementations dereference them.  Mainline fixed this class in
v7.0 with

  1a5c01d2508a ("bpf: Make KF_TRUSTED_ARGS the default for all kfuncs")

but that commit is a broad verifier behavior change, it was not
tagged for stable, and it is not in 6.18.y or 6.19.y.  6.18.64 is the
current 6.18.y tip; 6.19.14 is the current 6.19.y tip.

The four deterministic reproducers on 6.18.64 are:

  1. bpf_copy_from_user_str(dst=NULL, dst__sz=8, src=NULL,
                            BPF_F_PAD_ZEROS)
     -> memset(NULL, 0, 8) in bpf_copy_from_user_str
        RIP: memset_orig+0x72, call trace bpf_copy_from_user_str+0x69

  2. bpf_copy_from_user_task_str(dst=NULL, dst__sz=16, src=NULL,
                                 tsk=current, BPF_F_PAD_ZEROS)
     -> copy_remote_vm_str() writes to dst
        RIP: copy_remote_vm_str+0x45,
        call trace bpf_copy_from_user_task_str+0x2f

  3. bpf_crypto_ctx_create(params, params__sz=0, err=NULL)
     -> *err = -EINVAL
        RIP: bpf_crypto_ctx_create+0x1f8
        faulting insn: c7 45 00 ea ff ff ff  (movl $-22, 0(%rbp))

  4. bpf_rbtree_remove(root, node=bpf_rbtree_first(root))
     with an empty tree; first() returns NULL and remove() reads
     node_internal->owner
        RIP: bpf_rbtree_remove+0xb, address 0x18
        faulting insn: 48 8b 46 18  (mov 0x18(%rsi), %rax, RSI=0)

All four are LOAD_OK on 6.18.64; the four safe controls (non-NULL
dst/err, valid add+remove) load and run.

The 6.18.64 kernel is built from commit fd7cfd39c885 and the QEMU
tests use oops=panic panic=1.

This is a local DoS from a context that can load the relevant
program type.  It requires CAP_BPF/CAP_SYS_ADMIN (the tc/rbtree
reproducer also needs CAP_NET_ADMIN), so it is not a privilege
escalation and I have not demonstrated an unprivileged path.  With
panic_on_oops it turns into a kernel panic.

The following patch adds KF_TRUSTED_ARGS to the four kfuncs and
teaches the pre-v7.0 NULL guard to skip __ign arguments.  The latter is
needed because bpf_copy_from_user_str/task_str intentionally allow
unsafe_ptr__ign == NULL with BPF_F_PAD_ZEROS; without the skip, the
legitimate safe controls fail to load.  The diffstat is:

  kernel/bpf/crypto.c   | 2 +-
  kernel/bpf/helpers.c  | 6 +++---
  kernel/bpf/verifier.c | 1 +

Tested on a patched 6.18.64 kernel:

  test                           unpatched 6.18.64       patched
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

One behavior change: dst == NULL with dst__sz == 0 is now rejected.
I confirmed that mainline 7.4.0-rc3+ rejects this too; its
copy_str_safe/copy_task_str_safe/rbtree_valid_remove controls still load
and run.  If 6.18.y must preserve that case, the
copy helpers can instead get an implementation-side

  if (!dst)
      return -EINVAL;

after the existing dst__sz == 0 early return.  That preserves the
zero-length semantics but leaves the verifier accepting NULL; it only
prevents the oops at runtime.

Fixes tags for a split submission:

  Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
  Fixes: f0f8a5b58f78 ("bpf: Add bpf_copy_from_user_task_str() kfunc")
  Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
  Fixes: bd1279ae8a69 ("bpf: Add bpf_rbtree_{add,remove,first} kfuncs")

Thanks,
Yi Liu


Yi Liu (1):
  bpf: Reject NULL arguments to four kfuncs

 kernel/bpf/crypto.c   | 2 +-
 kernel/bpf/helpers.c  | 6 +++---
 kernel/bpf/verifier.c | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.34.1

