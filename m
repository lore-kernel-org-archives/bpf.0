Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB836607A;
	Fri, 20 Feb 2026 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609760; cv=none; b=c0TbGUzjQpOOgdvxUwPA8Pa78QXEiZJwh+20NPipq2lbP3F9w5z67Qicyzr0pCnRkbDqNsA78AMPuBuVn+RjQTXbhkLGda+13u4gSKKuQJO43XxsgFPqlQf0rWXIVpq+h8m275r/IxNLgGyZ+ahzhk182EPeExSvAlhtLA69KTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609760; c=relaxed/simple;
	bh=7EydhsHfS7wgUvoktsyj68nBNa00yo5omgx4VRFnjcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q92e7P8qqMREQTlmzr0MVbU3VmBVN5ddAMIgi6Ls2KfDT5iNYVCTWLDqfCxVoZENnBMfBBghZVZyxZ35aduQ0xEQwuHHuxAr+ok5SMZcSCiEfntJQqAfii6mla7DQFKLVWu2G9ez1HEe78Wwo8DMEf7kPOC26laOC0rQocOpUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpma7apW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpma7apW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E39FC19421;
	Fri, 20 Feb 2026 17:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771609760;
	bh=7EydhsHfS7wgUvoktsyj68nBNa00yo5omgx4VRFnjcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mpma7apWG8ZiStVYc7BIiibABKknMKKXmFDSr8LikRR+1XgTkvBagz8bz3GfycC1E
	 U6GAJFRIXAi39jSjzxjRI3uUrc7HlJ+GNWZdE6MZnI3K/vXCsYzxKSgWIKAkq3y2e1
	 1/Vobk481OX/FzIwoJcpCD14iMPeCUarp3l++mZ2pB/M7kSlKvTk+bjt3HMjmuaVzj
	 zBAlMfyEqgA8X5R8yEiJAMeiU45UoihkGNUTylssLcgbK6YekzefL2icyKfDL5i9d8
	 9sFsOBwsjnhHuIKXmpmscAwPmg2qv7KNUktm4sFqTmxe08JlC7q7IK/cfewrK/8dsz
	 BGbzRWly7WX9w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Feb 2026 18:48:48 +0100
Subject: [PATCH 1/2] bpf: classify block device hooks appropriately
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-work-bpf-bdev-v1-1-c53e852c4702@kernel.org>
References: <20260220-work-bpf-bdev-v1-0-c53e852c4702@kernel.org>
In-Reply-To: <20260220-work-bpf-bdev-v1-0-c53e852c4702@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, linux-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7EydhsHfS7wgUvoktsyj68nBNa00yo5omgx4VRFnjcA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOmDd7xfN3KY9nyiqY3v6QJHvzYw6Xo8DT520zHhVv9
 mUQvtR6q6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiN74w/K9pmJOiUOYvOtGS
 8aZk+O1Uv5sWwtevbDi/xuHMH7tf29MY/hls2/5LzFz1v/SLTbUx8/+u+3N8r4Hy8laBabnTlRv
 unWUGAA==
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
index 1da5585082fa..0887fcda4a9a 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -419,6 +419,8 @@ BTF_ID(func, bpf_lsm_userns_create)
 BTF_ID(func, bpf_lsm_namespace_alloc)
 BTF_ID(func, bpf_lsm_namespace_install)
 BTF_ID(func, bpf_lsm_cgroup_attach)
+BTF_ID(func, bpf_lsm_bdev_alloc)
+BTF_ID(func, bpf_lsm_bdev_setintegrity)
 BTF_SET_END(sleepable_lsm_hooks)
 
 BTF_SET_START(untrusted_lsm_hooks)
@@ -432,6 +434,8 @@ BTF_ID(func, bpf_lsm_sk_free_security)
 #endif /* CONFIG_SECURITY_NETWORK */
 BTF_ID(func, bpf_lsm_task_free)
 BTF_ID(func, bpf_lsm_namespace_free)
+BTF_ID(func, bpf_lsm_bdev_alloc)
+BTF_ID(func, bpf_lsm_bdev_free)
 BTF_SET_END(untrusted_lsm_hooks)
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)

-- 
2.47.3

