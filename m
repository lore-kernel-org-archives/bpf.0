Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9633343B
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273416; cv=none; b=t6R5ZmDGe3CKgSFpLu1d8LmpoRw0pwkg2v9Ryb9nW79grQ125P4ZVvCd6+3Hk2Qx7DTVGpQdhd3c6CuTbtkKJHsXv6LgVSk4eKARu6SgpI8OGv23FUN58c6Nrv6zSluW1dLw0mfDYzT6ISA8tVapbm+H/6Wbgv0H3mvXwKgfTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273416; c=relaxed/simple;
	bh=yp2xz4J7V6UrDoYY7UchbWzPubV/Tw3cGEqxmsGaUJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPEmzbf665k/I9FsUV6bPTD6ld9aFV4jNZjbd2UvWhyv1pJ8JcfKeCpx+ewOArM+0a3yS2bGdcYYypkGeL8r5nmVmLt8f+n26+CXA6d+eJi317czcaRRxxf2UxLySZafihiv6nyIVtugQPdbiikLZwwWH0NyGwS9guYz5eUd8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRKbVmHs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRKbVmHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5913C4CEF7;
	Thu,  5 Feb 2026 06:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770273415;
	bh=yp2xz4J7V6UrDoYY7UchbWzPubV/Tw3cGEqxmsGaUJk=;
	h=From:To:Cc:Subject:Date:From;
	b=fRKbVmHskqcmHzEKrDkj1QXq28TzeF9M9OrDA3RXhQ0NWEG3DBRJDvoPtVFRRAOWo
	 539r/mGA/B7qh/kc+ivC6rCsUs1PcUCP31toFLa5A3KQnAETIGZFFKM4lnV3b0a5Aw
	 PP+gaIUSfOdl0ZGx5qwVurWVueTrsPFDf8mnaYS0JnZybrveoZeZuf6Pf362Pun+1A
	 A4rad5ynmvK7W+L7jc///zTKOxdG51Jat/GSro8gysihn94eClkEYr+l6AeGyb3QaJ
	 SHMpCVymkxOb83u7uxrPgPizmiVpkgrAlPSQtePoVU3Yz4L2XBZ9vvzjBvaZQTw9DZ
	 8odV5/IUzyjxA==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	clm@meta.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf v2] bpf: Limit signature size to KMALLOC_MAX_CACHE_SIZE
Date: Thu,  5 Feb 2026 07:36:51 +0100
Message-ID: <20260205063652.690588-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Practical BPF signatures are significantly smaller than
KMALLOC_MAX_CACHE_SIZE

Allowing larger sizes opens the door for abuse by passing excessive
size values and forcing the kernel into expensive allocation paths (via
kmalloc_large or vmalloc).

Fixes: 349271568303 ("bpf: Implement signature verification for BPF programs")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4ff82144f885..447b101d2195 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2820,6 +2820,12 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 	void *sig;
 	int err = 0;
 
+	/* Don't attempt to use kmalloc_large or vmalloc for signatures.
+	 * Practical signature for BPF program should be below this limit.
+	 */
+	if (attr->signature_size != KMALLOC_MAX_CACHE_SIZE)
+		return -EINVAL;
+
 	if (system_keyring_id_check(attr->keyring_id) == 0)
 		key = bpf_lookup_system_key(attr->keyring_id);
 	else
-- 
2.43.0

