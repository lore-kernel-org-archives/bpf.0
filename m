Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F43033EB
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807944; cv=none; b=qUwScFnSA1eqQL9mfRdRlC6ptyoDXy53vdExMSnL5rYjpwUrsc4ybkBzQFHzm/XSAAbcsobQ9Ty0hxjWEGufqTKFiu7kv+iY2hschkY34kxWDoniAGV6VmUvrpyu67DANkoCbBtehyawpClzuk+7UHXsupXw0/KSiyvGbt+//b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807944; c=relaxed/simple;
	bh=ySnq1R/ZDNIdGAG/P1y4Pm9WQpGs2XBLLe8CXCbhTBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADn9W98hsveNmyxoBCjR+X7GRhKclWNV+Jhu2/VBgBgnbL2FjcFGtssO9cATyFiVr1RCTdWKvXjdT8pyqgIsgw2wom23+OGdqTui5gt9ZpaIBKYjHzXDGHqCtufwR2sdk07DiPHFzmxoFUkQ1Aq5zdpuM+WpclaTYYV0haWAMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD5Vk8hB; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD5Vk8hB"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66d2b3092c1so1982917d50.3
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 22:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787807942; x=1788412742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfC3jFJ+7i7b9tWDvNXtk6nuIhDZjOEEiQ4o3HnSEUY=;
        b=SD5Vk8hBEY2zBOnl/IBAt2fXeF//33Rw/4FDXbDDmKAB9S7EtQgaYocJHNR6ek3SGf
         j/nPYStQVhmpNciKnPnpL4M/e0sNY9jUUO3GXM5P76d1AQJ21i0dRrTt34nslf1yPogM
         YjsZuReTdBDBQy4iw4Eitf9w48Hz7RTMShKAvewyJN7FfOSHUMHBZyLQQnlL8LkZNjRH
         02VoKP6cWHKG+DtMFxaUSpLYr4zVJxXWnRODcNywA9kVRBgUPvZoCoI9lu9B94tLahrD
         mym9peiuuGYYKy/22VQW5KoPUu12S9aJGQ0nL1R5GTkKFpjIHwXT+YOD/dkJtFpCvoZs
         WnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787807942; x=1788412742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfC3jFJ+7i7b9tWDvNXtk6nuIhDZjOEEiQ4o3HnSEUY=;
        b=o58YX0YwaT8JIJb6QwUIBNo5pTisJ0PPINaGImniMNmPBBPhDK5TSCOTbx2E4alD+q
         eWrTWvbYiL8VP4AdmLFxEQ8o0d1DWpvbG36qlDl/5qJEiOCm1Q7QTN7aZN0R7msY5BhR
         OTU0VpHKcV6VJ78IKmrkvfn76SoRK4Sp9nGK/JNqv30gFISXu7Y8ueHwRiZoPyuuRpOe
         JV7y9Kks5pk35HnkIo+jCevusRH1CBHYvAXwhc8KrbYA+gf8mxiQDds0jnSNEyvGSAac
         QcElcQnhRQgiaF/pXkTiJB5e6FtVbwjZN3zGKMrb+/20IkEkEmPH4v0XZ2TCyDEFBlwe
         OQmA==
X-Forwarded-Encrypted: i=1; AHgh+RrM9H29CWHZpJ0nGZaveUt/YahZli+EYYowKWQRMUawr/mkjAhNsfzenu/zlyxkNaXFOJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++nx1k8OqWsDao/qm/pkzNYL27hCddbtbug9/i3JfNTyT9WvQxT9
	GKruFSqexRhk06qB8yoO6AD4MZ4r7OCGYVJe81kiL/mvdhuKEDoECjiH
X-Gm-Gg: AR+sD13N8arXtcyBUUTqZMJQtbmOZpcZQQ6cT/ZTJxXjW4gwERT1huSbj67c9gaAXhk
	HQCOZOjtLGg367RrJVl9Lm2VI1AAWJp0kXJg/epEKsUtTIlp3m3CCI1EGpdr7cbFW/z4KXPAvPu
	gWtZN9k1iU1XEjfob2VZxrwwkP1MUhgVjTPC27Kk1GRFrHTxROpEk13TZiXGIIAHowYfjyChEYG
	gcYpPvXAnkWACYk5Aq/EnzaZY4Q5IHmLECL/TMDK46dEy+RC+x2Fccn0Ncro5qAB4pvWNuwMp6Z
	n64NpCTel82fej7hAMdbPvQtb2NWF/rChg38naGkWk/cCW+AWDj+Nl4PrwsIhBhAZJaLWxjt4uL
	bSbGhXYSPZy4f4TJXSMOO2/HqTViY9lnYuJ484dgKY+BNJxEaqXRLD6wKUKBW6aVLylMHbwBY92
	XIQWaCBSyLENO8klbg5cWURIwRnIkDx/2THZWV0lC5jg00a+t0d7YOmNmi6+zsZZw/U9YW
X-Received: by 2002:a05:690c:dc9:b0:85b:7fb9:22fa with SMTP id 00721157ae682-85b7fb923admr7057897b3.10.1787807942117;
        Wed, 26 Aug 2026 22:19:02 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b5bc34f86sm4466367b3.8.2026.08.26.22.19.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 22:19:01 -0700 (PDT)
From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: ameryhung@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	wangfushuai@baidu.com,
	bestswngs@gmail.com,
	mattbobrowski@google.com,
	kees@kernel.org,
	menglong8.dong@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH bpf] bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show
Date: Thu, 27 Aug 2026 01:18:59 -0400
Message-ID: <20260827051859.45511-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterating a sk_storage map is two stages:
bpf_sk_storage_map_seq_find_next()
returns a selem, then __bpf_sk_storage_map_seq_show() uses that selem.
__bpf_sk_storage_map_seq_show() re-reads selem->local_storage via
rcu_dereference() with no NULL check. A concurrent close() can run
bpf_selem_unlink_nofail() in between and set that field to NULL, causing
a NULL dereference of sk_storage->owner.

Oops: general protection fault, probably for non-canonical 
   address 0xdffffc0000000011
  net/core/bpf_sk_storage.c:809 __bpf_sk_storage_map_seq_show()
  bpf_seq_read+0x366/0x1120
  vfs_read+0x174/0xa50
  ksys_read+0xfc/0x1d0

Return if the re-read yields NULL.

Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or local storage")
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Cc: AutonomousCodeSecurity@microsoft.com
Assisted-by: Copilot (Grok 4.6)
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
 net/core/bpf_sk_storage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1d295a8769fa..7228520aa2b6 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -806,6 +806,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 		ctx.map = info->map;
 		if (selem) {
 			sk_storage = rcu_dereference(selem->local_storage);
+			if (!sk_storage)
+				return 0;
 			ctx.sk = sk_storage->owner;
 			ctx.value = SDATA(selem)->data;
 		}
-- 
2.55.0
