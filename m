Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2498322B69
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273492; cv=none; b=c9JSrrBeB/jODgmNwHtACvEPbkU2A/pR9Bh2U7jJq4UMLNQWT+stAI9BnIQiaXeWgpdMT02sENaVimtEKqS5HBjBvGlK1pfBxnTZPcLIrdblEl//he9C9M0ZVS2hvIiJ7QsVz3O3TdO8KkxZyyR/bXnH3f7/mXQrnUhMXJ5pBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273492; c=relaxed/simple;
	bh=0yd3vl9ueFi69vzy5bKtA8iHjYXoRZY6bH5RzkXrKnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QYcxOytD17II95oqVMfTVwudS+nP7mhroMrI2u14nbG6weJkS5Z+A3V6XpvGZzlZwBf+uLLkDCg3hHXOA/hdBdyowZCo1bq3/I8r2cSLwXyOG7g8zBQzT10po1foqe21bdTlW6OA4GZj2agCT7rDCK40+1rU5XRZVPDPLcgpcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXKKlYTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXKKlYTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209D8C4CEF7;
	Thu,  5 Feb 2026 06:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770273492;
	bh=0yd3vl9ueFi69vzy5bKtA8iHjYXoRZY6bH5RzkXrKnI=;
	h=From:To:Cc:Subject:Date:From;
	b=AXKKlYToam59wC03EQsDxhv8HsTSRbdy6J7PwSXiZmS9u0MUgfIkjhhIq+psc2hge
	 D605mqhR68tie413OUCXnBlGHwDcfbw+LFqcsCo7VCVgvdRp+vzFD6ZgaqiWWtc2J7
	 8L7iT3kEFLUhBj2+S8PG9xe/6+kbPHBcnssr1PqQIQkOng5mEiwa9njaQARwFeCP0r
	 N3n80k149gjDeu5jtS5zOwpCE1qETwvJ5bsKd5KAdXFyw3QkfxOkocGtyAJhNKXAuA
	 1hshK04UwZRhprNzX997Ym0R9RLwa/CJb0FdCZHslh442v/n580FdpJtZfCzgV0zB5
	 rFPbcAI85DrMg==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	clm@meta.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf v3] bpf: Limit signature size to KMALLOC_MAX_CACHE_SIZE
Date: Thu,  5 Feb 2026 07:38:07 +0100
Message-ID: <20260205063807.690823-1-kpsingh@kernel.org>
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
index 4ff82144f885..15e87f507991 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2820,6 +2820,12 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 	void *sig;
 	int err = 0;
 
+	/* Don't attempt to use kmalloc_large or vmalloc for signatures.
+	 * Practical signature for BPF program should be below this limit.
+	 */
+	if (attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
+		return -EINVAL;
+
 	if (system_keyring_id_check(attr->keyring_id) == 0)
 		key = bpf_lookup_system_key(attr->keyring_id);
 	else
-- 
2.43.0

