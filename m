Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106770;
	b=nKC4igBGUmyVFaHCTYW2+FbmIUxr7f52dPMMR54AoTDrebHUJhbpD0IZ2w11+TGWgFyj
	 in9xyY2OTVIZ8dguk+kNINxcYMhQ/BLB10emsVh4ba7LkoM7K3yzA6bVtkrhavRfLoSmc
	 82t4T9dsTCWKbF5u9FF5K1Kj9/WEuTHzoo7BjzTVjPv6aQEvcRWdccNMwSumvguQvlP1g
	 AgNAhhtqyzdBK7pXMb42ionk8aovKcQ0f1MNWrgkL7XU4NYAZpr+YGK2RultvPqA5kPei
	 8gY0ybiZI7YEt6v80956M0e8ZVn7yy2RKrWh/Xle+YRyQx4m1/DKTY3ZyyGjFJ9EuFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=g2M9j/VQAVKbvhG6Nn8Y+BAYTfGyHSNRXTF1HZRA0x0=;
	b=S3o2NXWSw6HV9Igzb7Paodd3iiKwM4eL3GTvOcy/K2HUqUFntgmdLhizFERJhSTvAvd1
	 THftgYdnpf06XzfAlAV3FGbCA97GpLg0yrXlt5QgqgZk94Y+xuYTveMrVweQKSqEun1pR
	 maCFsykRan+QnRAm3UHG2cQbOvNNpN6DzbbF0W8F/Uw34e3xig98BT1JQ19wwgnDqpWIG
	 kZQ0yHJm2lAyrElr8h5Cjp/Qrp78ZJ/MEIl2Jv/TtMS1gEcF5l/V9FVRLP3bGMLpKCRoq
	 T0tU3jGAk8JnZJ5oY6f28V5+xe431Uu7DhIpwyVT7M618ZocI5wXcVxXg2XU2V461xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaBHuDmd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F04B606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F04B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaBHuDmd
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91c847584b8so12482386d6.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 08:46:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795106769; cv=none;
        d=google.com; s=arc-20260327;
        b=ZD+AO2LAicA6Neyk7Mb3vcYSemsRB8Jk34n++iQZ2LBRyAcdW9yXRQ72FqG0Lv8x0o
         xRNDdQQ0bOmUj6iovVouMC0Al8xSEmFaqnaXGxtDc1PnIbPEvV7EN+YkxRJ6juN58n+O
         hzEiZHQol0tBE1lGLx9eYqG4KHWx2yLj9564Zv3JQFkZVCDAgS3tVlVVGs8yIiQ/FZ8U
         oo/9J2CWjt+yyLLzqKwLigxv6FzwLfwbDU7CR1Pe/5WXfmKKHbIDRRntLaU6SQVtlHt0
         qBn0FPfy9J/sampVGXVMaD4E4NRx3fQ5CTbtIUiqfHkyv+1vw5MU6ymEH/WVa6dtsKLl
         TPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=g2M9j/VQAVKbvhG6Nn8Y+BAYTfGyHSNRXTF1HZRA0x0=;
        fh=XMCbGw9rgcQ3w6LyqDABhswCAcowgPCXUGmkOlO9wGk=;
        b=Fzl5QMb2CXU8Wcba403XDE+3h+2YpWoiU5NW2xYZ0b9EDecdM72300oe2exXtZsdfl
         EIooE2PxTXFLsVftztO1u/1bxXOgchcfQgrD23qzYogIe18TXqWdS4eh6/Re0cvBeKH/
         WZXV6XFeV1PpV48q7PfpiEkg+RnjdoR7VxjehBfPrpB5+nt9UFQr7+6aUiwLyfGyBO2J
         kO6/4oZM5ZlfASCLMa6sjcQ3RU9Wym7U1/YMp/sP83VRNl5EHKsFy+ZlZH2WjKZpikl8
         MlUzWGWTQ48nFv1PM63IZ+tOS9YupMSWnCheAmDwQccL+QE6PdwFeQDjxoCmuE106jY9
         czyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795106769; x=1795711569; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g2M9j/VQAVKbvhG6Nn8Y+BAYTfGyHSNRXTF1HZRA0x0=;
        b=VaBHuDmdUUoqfJOAQoTQR7FMy8cWXNQy4bPOMeuHmEtAkQgtoskPx9t2bS/f/Tn/xP
         KO6wZUKkWOIyieKEHBN0nNhZkEJL7qCpavnzBBtSPGMSxWHPU08rj0AIvcX4FntmCILN
         R6ls9KGCcOirlwaG5x9kduwfrWawyGx3wA0Eo0hWsgK2ayy8XwQ9dqFa0BALo5rkShnv
         hN4o3KyRHyFpn4KoNEEplIPC+n1LcmQPN4FNeTCutEEPpQBrx+qAR2hJlISMCpniS2P7
         u5mHWk6sBvqrNYgfZTTGtxAq0Cq607z3vofO1Nnb1OhFtS1LLzniyQks9KlmxZeaWN5X
         ik1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795106769; x=1795711569;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g2M9j/VQAVKbvhG6Nn8Y+BAYTfGyHSNRXTF1HZRA0x0=;
        b=hBGyADrESLgY3C4uegXAikYR4kyZF8ty/Iq7K/TWGwvkPVlEinkAXOFpT/L3y49eIm
         4GCBQsAdbjquIzVKwVJRc/ybAoqDRQG51mwPxcx5fvS0Kf6ok4lzVZPsr5aRN3CL4JqL
         XW2n2ShTLEUNpDN8FEtX+pr9RmoNHrOnNIlqeHJj4DcWW9pculFWPi3xdo4OwurNwz1K
         i82P1jgDUr+ojdAj2vjygWqD7FW29d9fKN7q5MULKPlhNZvcvnLNvBdSOz7NXwO/tbpn
         ACePM7mBmbdh/HAW9zpeDGPk79fs3GwmMhfLEbhaPadnq7ZCuNQU5pptNJxvUk1Eecfb
         IAuA==
X-Gm-Message-State: APuU4Z9GizQ5XMvXhpdv1xd3A+NMHaB1c7oa2BjRXH4blj23hjZq23ju
	MNJ11R26uf+s1SA68g97JGO6pTUu9x6r6Ndy90r7MI+KaarOsxOdXwsrMizrbN3aiAUIdhzIXwz
	OqZQqMghM6HT8H3sCH5iYfZd5w/Re5kyDbXqu7As+xqTh
X-Gm-Gg: AZFdTZdAWzQD5I5PYp3yDscsYwswHYoSNKs2Ynu09VAgaEi2Tteqa6Wa5vJ37Ujm6LC
	yWH7Y2PkhjsN2DU0n4nxPK5pi014hJrk2K7x98Awe24w6BPGScVsl4/E31Sj9Vcid6rfUfguEUa
	Lo+6q3wIkApvAy57XSYzdaNtaI4IgM6uV+3xjeBmNUQ1n31yswZ2vUYUWizfhmxQQTzoDfVN8qn
	J0gNojcNR4l3+0yXkWPPWyZjNbReIIbJX8PDVwXNHw+k+7tDGb9KckDrGxrQ1JW2uG6BYkfbSUj
	/yUX6onavwnYM8Woq1upQwfFXrWOwQJ4X7ugx2tvEYvqKK8UCRnt+N1ZmBc6mMuSSxHmZY9mN/f
	TaYtbBTrZygmxE/Sj9NrB8sEZRnpvmYxWty0z7jKT/b9ch1i47mnVlYvSOcPRUlEtSZOU0Zsbm7
	ONCFKnLBIj1v52bijG/Cg=
X-Received: by 2002:ad4:5d6f:0:b0:91b:9582:d91e with SMTP id
 6a1803df08f44-92134aa0592mr2182256d6.9.1795106769270; Thu, 19 Nov 2026
 08:46:09 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 11:45:56 -0500
X-Gm-Features: Aa3M54rJ4NzvBHM56xW7TojSAPs0qqh8iAh_CvhoCd_Zj5g0_53qw97QbIYyhi0
Message-ID: <CAMcAce-4MeO8rpx2rvDu77r-OpbFd9k0geOs8wZBoaMbYVkpDw@mail.gmail.com>
Subject: [PATCH 6.12.y] bpf: Add tracepoints with null-able arguments (CVE-2024-56702)
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, memxor@gmail.com, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit c83e2d970bae ("bpf: Add tracepoints with null-able
arguments") ]

In v6.12.118, raw_tp_null_args[] in kernel/bpf/btf.c lacks nullable argument
masks for nfsd, nfs4, and bcachefs tracepoints introduced by upstream commit
c83e2d970bae (CVE-2024-56702).

Because the verifier treats raw tracepoint arguments as trusted non-NULL
pointers by default, explicit NULL checks written in BPF programs can be
optimized away, triggering kernel null pointer dereferences when tracepoints
receive NULL arguments.

Add the missing raw_tp_null_args[] entries from upstream commit c83e2d970bae
to kernel/bpf/btf.c on linux-6.12.y:
  - nfsd_file_acquire (0x1001)
  - nfsd_file_insert_err (0x1)
  - nfsd_file_cons_err (0x1)
  - nfs4_setup_sequence (0x1)
  - btree_path_free (0x100)

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e2fa364..55018cb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6498,6 +6498,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "sched_swap_numa", 0x100 },
  /* afs */
  { "afs_make_fs_call", 0x10 },
+ /* bcachefs */
+ { "btree_path_free", 0x100 },
  /* cachefiles */
  { "cachefiles_lookup", 0x1 | 0x200 },
  /* netfs */
@@ -6551,6 +6553,13 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "mm_page_alloc_zone_locked", 0x1 },
  /* netfs */
  { "netfs_failure", 0x10 },
+ /* nfsd */
+ { "nfsd_file_acquire", 0x1001 },
+ { "nfsd_file_insert_err", 0x1 },
+ { "nfsd_file_cons_err", 0x1 },
+ /* nfs4 */
+ { "nfs4_setup_sequence", 0x1 },
  /* power */
  { "device_pm_callback_start", 0x10 },
  /* qdisc */
-- 
2.56.1
