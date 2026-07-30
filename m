Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C03B993B
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455141; cv=none; b=tNVB9fy1R/XXNf68EppcSY0rqwzCP4pySxIuSBQp2c7NTfbf2IFhhteTFe7vu8SH7UudiFAOywo0xYhafUY6q5F/oIDgZAPwsOoMHrgUEgiJqXN2sfdqXqVgoTKc/YpHsaksIJtRAoIPdYWE+aPWnVP3ZaN9Bbjq5SHINUpod1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455141; c=relaxed/simple;
	bh=/oM7JBSTblLnG57a7tBXav9q+HOtRWW7AYV63dxcLZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uyl3YyKMyE3cNllc7YdIzMrL/I/xDD1AsWjsJu4K+J32Bh8LDcqgFzRMTLH+LrHs+9aGFTv9rVkgm4yXop75gzey4SWMMsoxXdfab4CwAL6B6LgXDa1CfWJXorJyTQpyN6P7qtnDY0mc1KRmSOporY3YOPY3KlfYurTdW5mSfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRndpjto; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRndpjto"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ee88fce572so4461366d6.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 16:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785455138; x=1786059938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XnBhDRV9Lhz1WLumD8y8Q4NM2/ker0aTMu47IxfcVsk=;
        b=ZRndpjtoMMSnxrQZsuBN/kJWeNwlhKMPF0g+nbcyeCP4Z6VUN2vFZK+Cqdy3nED1Ko
         4t8QImCZntTOBd2f/0X0K714fATQKD/a6d7VICi81f0wE4SkXAQCp2UZ+EffiDf62KNP
         c8bPViKeRSSLDbD7P83lD2V7lLeb1tpEI/KyIYkN9E4gQH6As8+5r6dquHwp3uB7/m7I
         9TCJlAFIbKmg4U+8lIntRCTQRymPC5dM02NHFFZ07ObNaTwz6DPuMUbf1hNSJrJyallx
         efhuLWHtcgN0RmoKBaYA6E8bmp8x0exDywm5tzPeVVCI7u+igUz1/7Hp9rKEz7V7Zpfk
         mVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455138; x=1786059938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XnBhDRV9Lhz1WLumD8y8Q4NM2/ker0aTMu47IxfcVsk=;
        b=Iy6lLiHtnYEtHf0T6WnQ/5sZ6eY5C+WBwDcuyI38cFyv3wSWBvg/nJrFzDSdn8Wa5o
         2VHCC11XY4lmxQHqxIE5jUjTez2e0D6TDK+6pdeyZT5D2lDI79XY4Iu2mmuTWecXuMkn
         vTuxVPd4yrgkH3ZP1WaL7ylsJou+fSai9ktUpD68y0V/TejKI1DJpXT993TUztenO85h
         iIWWkBKwY/qpNjp5lbfV1H7CwvoqQDS9JWeBmZefwgeNCUlZocG37QrS74JfKGgrk60o
         hwqhzbshP3Ade9YlaGkg7BZGKcCnIly3V9KZyDyVpkufQAe9DjF9TsaiQqglYpr428ih
         sWKA==
X-Gm-Message-State: AOJu0Yy4QzFgDM3FK9LGRw+nkJKkYG5+j7kO6uJKCQSOO7UlBph3J+R8
	rFiKsiENSCeZt8WhsTRMq5zVUu4k6eXIo/GwdK88WasUpS8in224JPaL
X-Gm-Gg: AR+sD11lBUXpoNo/sGQvS5T4x4Msnmp4rvkpalXtT9PzApaFHNPQhnooehzWK6E1fEZ
	wzwImyHL6SUXSuomfO6JpblEjbIcDpszkG8mcZshX70mmm1JEWHRkhuBBy7M5/6GM/sNpfVPrxt
	Q9/Iw5zM461fdvR9dRDQX8jwUSBer0jOKRl8Wr1J1O4th3AzAalUMuFAwMBI5g08S+mJsa6ucI+
	OGMAIk4hNGD2RFAVjwt8b1/oDASwA73khH8/w6TOJyVzV+hRfx8B6paKyKU+En4+Y9BW4iN1de7
	L/qSxDvdfIfbsHYox9VaXDzRG4Z9P9JMVyAh0xaNxKOC38By+w93DQ3DyuBm+9ofDBj5AImAtuF
	8bPECuHd8DfNJW3M1m3nfMXI7JgKBz9NnxaTLCBLQZ+wBwv+pVyhuSKsZqHZKxKUdSZ7F8C7t5k
	CoDtuYiIpMg1RmIAu2YD+LudS/tB/Vj5jW81s3Rid3zp+6duxbA1fvI9ojUSzjFqcpD83ymj89e
	8R+IMpGb59Nf89WtiomcL24zhGPxhUQsM4GheMXYokFsjndETvX2s+78xrdNK0=
X-Received: by 2002:a05:6214:1d06:b0:8fd:6dc5:94c with SMTP id 6a1803df08f44-9083482c8c6mr47873286d6.65.1785455138153;
        Thu, 30 Jul 2026 16:45:38 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323e8bc0sm28991836d6.26.2026.07.30.16.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:45:37 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v6 bpf-next 0/4] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Thu, 30 Jul 2026 19:45:29 -0400
Message-ID: <20260730234533.1912709-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
extended attributes. For these LSMs, atomic labeling during inode
creation is critical: if the inode becomes accessible before its xattr
is set, it is briefly unlabeled, which can disrupt LSMs making policy
decisions based on file labels.

Existing LSMs solve this by setting xattrs directly in the
inode_init_security hook, which runs before the inode becomes
accessible. BPF LSM programs currently lack this capability because
the hook uses an output parameter (xattr_count) that BPF programs
cannot write to, and existing kfuncs like bpf_set_dentry_xattr
require a dentry that isn't available until after the inode is
accessible.

This series introduces the bpf_init_inode_xattr() kfunc, which takes
the combined inode_init_security xattr context argument and claims a
slot in it via the new security_lsmxattr_add() LSM helper.

v6:
  - split struct lsm_xattrs / security_lsmxattr_add() into 2 patches
    (Paul)
  - drop the CONFIG_BPF_LSM bracketing in security_lsmxattr_add() (Paul)
  - have security_lsmxattr_add() take only extra name components (Paul)
  - return 0 from security_lsmxattr_add() when the filesystem does not
    provide an initxattrs callback (Paul)
  - selftests: label files in /dev/shm and skip when the hook does not
    run or the filesystem does not support xattrs at inode creation,
    fixing BPF CI failures on the 9p rootfs

v5:
  - make the kfunc non-sleepable to avoid an ext4 deadlock (sashiko)
  - move xattr creation logic to security_lsmxattr_add() (Paul)
  - use distinct xattr names in init_inode_xattr_slot_limit

v4:
  - introduce struct lsm_xattrs in separate patch (Alexei, Paul)
  - rename struct xattr_ctx to struct lsm_xattrs (Paul)
  - make lsm_xattrs.xattr_count unsigned int (Paul)
  - drop new_xattrs/xattr_count locals in
    security_inode_init_security() (Paul)
  - fold __bpf_init_inode_xattr() into bpf_init_inode_xattr() (Paul)
  - drop bpf_fs_kfuncs_filter() attach-point check; rely on verifier
    type enforcement (Alexei)
  - drop attach-time cap; enforce slot budget in the kfunc (Alexei)
  - allocate the combined xattr with GFP_NOFS (sashiko-bot)
  - replace init_inode_xattr_attach_cap selftest with runtime
    init_inode_xattr_slot_limit

v3:
  - rename struct lsm_xattr_ctx to struct xattr_ctx (Paul)
  - increase BPF_LSM_INODE_INIT_XATTRS to 4 (Song)
  - enforce per-hook attachment cap at attach time to prevent
    runtime rejection (Paul)
  - add init_inode_xattr_attach_cap selftest

v2:
  - pass the xattr state as a combined context object and drop the
    verifier fixup path (Kumar)
  - restrict bpf_init_inode_xattr labels to bpf.* namespace (Matt)
  - cap bpf_init_inode_xattr() at BPF_LSM_INODE_INIT_XATTRS slots per
    invocation (AI)

v5: https://lore.kernel.org/bpf/20260708000956.46138-1-dwindsor@gmail.com/

David Windsor (4):
  security: introduce struct lsm_xattrs
  security: add security_lsmxattr_add()
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            |  41 +++++
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 +-
 include/linux/security.h                      |  15 ++
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           | 120 ++++++++++++--
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 156 ++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  33 ++++
 14 files changed, 395 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: 2659f94ed3be147942acbea96405efc562afb34c
-- 
2.53.0

