Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA574070F4;
	Thu, 26 Mar 2026 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541365; cv=none; b=RpaB/DRPh8CX7g8gKG4OnZIlBa+3lhZSE2hZ06mlzwGrl8LBO02bWTi08i2X8+w/7hqhDM5/ggoQe/cFCsqDawmkSrqYGk6gI5j2f8aSM5Jym6b83hylC86NTrY7+WwvXVzS1BfQxdPWj3cn6JhZFnUygSCRJUI9KsdxapZJD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541365; c=relaxed/simple;
	bh=7azGKc80wcX8nAE+5i2Ffor9je2LSncza6rzMUCOLVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekBZjph8ZDwdk/gUiRndSf/+qqm1AhAGgHOnA/GgiLjlAf4rC49lrDvIprakuRRJU2weDxMOPkTPFWYrOu2rFDepdfUSlLW022Uu6MHYP/iuaxJfzS4VzJcRJC4lnBHig6eMluZ/wfgi/eFHZAvpyGHRunkt1a+ubZev7bFYwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfHmJsUA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfHmJsUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB57C19423;
	Thu, 26 Mar 2026 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774541365;
	bh=7azGKc80wcX8nAE+5i2Ffor9je2LSncza6rzMUCOLVU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pfHmJsUA5j2pJdikaarJ6wFgKPNM7EqdwDnCRwfMAeQLOTjs2RrhugdYL59CT4rde
	 bxUI2A96cZf97sN3cN/rg0YCJ/NEaVZjWrf7N1mUbFh6KpqqwxHmhiw8NZ0zi1RRnQ
	 e56CA13rspF9CwDbVLfgfCRDt4SpxM8omn+HmOuQ2pSCxZZk+V/2fiP6mxBRYBo12N
	 ag/ju6mhTJbkgwYit8VWRbmz+EuBVtKw+i7kzvKz+y7J3b08NATGDPX4HUw83e6qLR
	 +DK4IJmgVUu1g3PJ3sJo1bFG+DNZg6K28D6I0i79XkR0LqNJ6L6fRSNjNdY3hNHzcE
	 SfiQI2JF/FL/g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Mar 2026 17:09:14 +0100
Subject: [PATCH RESEND v2 1/2] bpf: classify block device hooks
 appropriately
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-work-bpf-bdev-v2-1-5e3c58963987@kernel.org>
References: <20260326-work-bpf-bdev-v2-0-5e3c58963987@kernel.org>
In-Reply-To: <20260326-work-bpf-bdev-v2-0-5e3c58963987@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, linux-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7azGKc80wcX8nAE+5i2Ffor9je2LSncza6rzMUCOLVU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQejdJ/x3q8ymBPYGBq4/0JPlLmGmxb5v/6rZK2UiyLy
 fFsS8GXjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkkuTL8L577y1Z/IZtJql7z
 vJNq7rWsKvb2x9+sc2RdMTnrqG/sTkaGI1GipiFtp7fN8c/6+emtGTOzTkjqUeavIa4TdvWw2m5
 kAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A bunch of new hooks for managing block devices were added a while ago
but they weren't actually appropriately classified.

* bpf_lsm_bdev_alloc() is called when the inode for the block
  device is allocated. This happens from a sleepable context so mark the
  function as sleepable. When this function is called the memory for the
  block device storage embedded into the inode is zeroed. That block
  device cannot be meaningfully reference or interacted with at this
  point. So mark it as untrusted for now.

* bpf_lsm_bdev_free() is called when the inode for the block
  device is freed. A bunch of memory associated with the block device
  has already been freed and there's dangling pointers in there. So mark
  it as untrusted. It cannot be meaningfully referenced or interacted
  with anymore. It is also called from sb->s_op->free_inode:: which
  means it runs in rcu context (most of the times). So leave it as
  non-sleepable.

* bpf_lsm_bdev_setintegrity() is called when a dm-verity device
  is instantiated (glossing over details for simplicity of the commit
  message). The block device is very much alive so it remains a trusted
  hook. It's also called with device mapper's suspend lock held and so
  the hook is able to sleep so mark it sleepable.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/bpf/bpf_lsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0c4a0c8e6f70..119e3942cf5a 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -383,6 +383,8 @@ BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)
 BTF_ID(func, bpf_lsm_userns_create)
+BTF_ID(func, bpf_lsm_bdev_alloc)
+BTF_ID(func, bpf_lsm_bdev_setintegrity)
 BTF_SET_END(sleepable_lsm_hooks)
 
 BTF_SET_START(untrusted_lsm_hooks)
@@ -395,6 +397,8 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
 #endif /* CONFIG_SECURITY_NETWORK */
 BTF_ID(func, bpf_lsm_task_free)
+BTF_ID(func, bpf_lsm_bdev_alloc)
+BTF_ID(func, bpf_lsm_bdev_free)
 BTF_SET_END(untrusted_lsm_hooks)
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)

-- 
2.47.3

