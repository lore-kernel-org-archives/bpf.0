Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429390;
	b=cvwyaRnqBsoBebVuQyAfZ16aaUOilewfg3e2m47Ox1M9OL8pdZ7CIhRpn+SMykAS0l2G
	 0oSV+7YngCr2n+gkdDn1+LxhEhf1bVS9UajLsTASdivo2E5GgLBA1OLRF8nQNHagBsicS
	 rdtEq5A5skzKKx6jdkNn/0lCc1xkCSmf0m4RyTpR/rVfs/1rxE4Md+S8XTASn/3RsBjKX
	 ++PoMZbCIs6p8dD2bBJ2FRoOjFD6v30j+6KPcACoD281+Jm5T4cW/X5uDfXxq/WslIcFc
	 y/4Uyhl5FrMygLBbuqTryTy11wXnbGxjpIt70OdRA3trXMFhv/Kypbl2MK8KvXy5zhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NNGE6UrmGIoih3+sbT7xMKwGPGzkwVpsddz65pffQVE=;
	b=gJFf4zl88V9GmiLgtbeJnMHRF/F5vPurc/67g9hElupsv8IiLFZObHLPNJhnxmED1ZZv
	 qFb28eridINSZw0Rn9mXuarXmc+kKORoa7faMWpWEO4zMGjKQzTEWdRkdHrTw4IKEdjGE
	 LozWYR7O6BNzhaqwkXjcJwYh+gP7sgOqQWohk/WCa+DfF1bvn+bC6JCbhbgx3roU8li2P
	 DxH8bXsqFfYVAcTptlctGKOtj0Z3vB7QWWXwmf/FvnOIhj28p6/u7uI3+fEq60DV3hUCx
	 w6rzSrlQkLbyTcA0N7N2ecawL5vgwsbNAKQH5G44dl9Ls03ABHfst4ka42kZ3njXJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=ZVLF+vIn;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E9606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 20:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3E9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=ZVLF+vIn
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso23049485e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794429388; x=1795034188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NNGE6UrmGIoih3+sbT7xMKwGPGzkwVpsddz65pffQVE=;
        b=ZVLF+vIn3YWx2xaDmvc4ASv3P9waWwcCVU3SNR2EwPknjDiIZ0Jza+Xvgr3YBC0Cgj
         3LfwimsG8o+30npPVueJUpJopy8NgZo9x06PHOpgTfwTH4+V1m6DlG7eC4Y14rvC/KCz
         yu/+eMbK2BILgpIfzjyOeaR+LmTzbuoX2BAcvkNW/Hc1WMSnC9a1MseEp5BPHHifG5oG
         pvvUWM2EGZCA13ilunkCs65OLsASUAPYKwV/ysKdDj1YS2PAvKMzx7bvoSwPLPXyVgLF
         88IXM+BMVRhCvw1foZSljOGbFi8dglkxfieGRuuxJ+3Eu8jwkKLjIm64HEKbZdbM+OHS
         1aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429388; x=1795034188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NNGE6UrmGIoih3+sbT7xMKwGPGzkwVpsddz65pffQVE=;
        b=yvwnd2ubU7M0nNcG6Fa9HIPXPfoacUf+5gFR88quOjYB1TaSUoWrcL++ePP77uSMTv
         iL83c+azkxyFtpOxRv0QcR8g78P2uHmuyHQTOlzXtKwtvX9Cj8koourGSY+0BVNYgy1y
         RPw21tS4obPEh5qwL+Nc4MGGJyRD9FbNO4gzbg2rY0EuNg0OpaGaMDSNn8MeJz7pPTri
         gFdmbLvOOknn6fDNlzARsd6uc0Ean+X+6U0hDutZ2URe+iSwYHZgmcGop7rmOyfIdw+H
         V6Hs66evZcSJXoQJmGF5J+8y/UDlDXTxHjgyNegMjYmVeWXtv2oijdroPspUJiTdNvJs
         vuDQ==
X-Gm-Message-State: APuU4Z82swbwpBOz4JZdpXtxXcmEaWxpA8L+JPtMfRB+NbwqzdSxhThW
	hmEy70joHGDopAaopp/bBENWEWKVvsgoTEmfJgkHRBRhaRteEONhLx1wpBoNchNRbCYxxczR7ME
	1StppnFbwpA==
X-Gm-Gg: AYBFou2rz675ld8Nhb0+eOgmMun4xOpiwCk7n8JDNJnfz+DKiHpYl1UwOCOFuJe+R9k
	Bvb4OEBvbFGY0nYO+2kvxapjg19lpGNMkIk7PiXrsYSg7lWYUrP8yhYvNvvYosMU9NvmdULCRG+
	DqE4RCuZH36Zm+RTO1OvHL57sitYzOlFzrEGdkJgBBiA6GTazqgt4BlHK1kKcKfCpP6hpolosHQ
	fDZJvDdZHn6ytcK+TK6epZAibaZc8y0DRMBHd6R18rsSjo5OSNFLyAMI/E4p5Gz9tDzAqihr8yi
	PnFpo2GrwLPBRLu88Ia5YOPKKh6M1wVqazKJA9fpzDeUrsMfH6UFtjOh7S0MZVGHHUU/9gFULLs
	7/3zMRV9o0oaHQwb9qycE2Gd3lrO57F1+DtVxBZCps29SqLh9V6dBI+vlPtDLtPi1pwnHYH86zU
	Rd1EzCNFVlnHTo/4J6T0dOTYVOa5Y697n9avfq3R2ZOdZ4dkOaW1BjnkiTY/4KW14edhRpNAmL9
	Wum1iILRXMP7qmwRQBZDeBkbMdk1+47AJeHF7OiML2k36R38r1GReD6ANCDuZ9w4yiKmkQeJTfc
	oUUyOmiNREMHWANd52GNwK5ZzqKQ/c40MzUVNFc=
X-Received: by 2002:a05:600c:81c5:b0:4a1:dade:f049 with SMTP id 5b1f17b1804b1-4ba09376130mr58077175e9.15.1794429388649;
        Wed, 11 Nov 2026 12:36:28 -0800 (PST)
Received: from winnie.home.arpa ([62.4.45.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e258e8dsm21071525e9.4.2026.11.11.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:36:27 -0800 (PST)
From: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
To: bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Sergei Nizovtsev <snizovtsev@cloudlinux.com>,
	stable@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Serge Hallyn <serge@hallyn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, lsm: Mark backing_file_alloc/free LSM hooks as untrusted
Date: Wed, 11 Nov 2026 21:35:52 +0100
Message-ID: <20261111203614.1221188-1-snizovtsev@cloudlinux.com>
X-Mailer: git-send-email 2.56.1
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

The backing_file_alloc and backing_file_free LSM hooks get the backing
file as "struct file *backing_file", but its f_path is not populated
while they run:

 - security_backing_file_alloc() is called from init_backing_file() in
   alloc_empty_backing_file(), before vfs_open() sets f_path, so
   backing_file->f_path.dentry is NULL;
 - security_backing_file_free() can run for a backing file whose open
   failed and whose f_path was already cleared.

Neither hook is listed in untrusted_lsm_hooks, so bpf_lsm_is_trusted()
lets BPF LSM programs use the argument as a trusted pointer.  A program
attached to lsm/backing_file_alloc can pass &backing_file->f_path to the
trusted-args kfunc bpf_path_d_path(), and d_path() dereferences the NULL
dentry on the first open of a file on overlayfs:

  extern int bpf_path_d_path(const struct path *path, char *buf,
                             size_t sz) __ksym;
  char buf[256];

  SEC("lsm/backing_file_alloc")
  int BPF_PROG(poc, struct file *backing_file,
               const struct file *user_file)
  {
          bpf_path_d_path(&backing_file->f_path, buf, sizeof(buf));
          return 0;
  }

  # bpftool prog load poc.bpf.o /sys/fs/bpf/poc autoattach
  # cat <any file on an overlayfs mount>

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
  RIP: 0010:d_path+0xb4/0x810
  Call Trace:
   bpf_path_d_path+0x26/0x70
   bpf_prog_f8f2e241d4ff7217_poc+0x33/0x37
   bpf_trampoline_6442521065+0x61/0xf9
   security_backing_file_alloc+0x78/0xe0
   alloc_empty_backing_file+0xf0/0x170
   backing_file_open+0xfd/0x290
   ovl_open_realfile+0x1ed/0x270
   ovl_open+0x1a9/0x2f0
   do_dentry_open+0x404/0x1280
   vfs_open_consume+0xba/0x4b0
   path_openat+0xc4f/0x1f60

Add both hooks to untrusted_lsm_hooks, next to file_alloc_security and
file_free_security, which are listed there for the same reason.  The
program above is then rejected at load time with "R1 must be referenced
or trusted".

Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
---
Tested on bpf.git master (475a0cfd02f1) under virtme-ng with KASAN: the
reproducer oopses without the patch and fails to load with it. Only the
backing_file_alloc case was reproduced; backing_file_free is from code
reading.

 kernel/bpf/bpf_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index f58dce888ff4a..f39a3766f2245 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -411,6 +411,8 @@ BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_file_free_security)
+BTF_ID(func, bpf_lsm_backing_file_alloc)
+BTF_ID(func, bpf_lsm_backing_file_free)
 #ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
-- 
2.56.0

