Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268044;
	b=b59ZrNqXJM5uRFvB1T4ygog1Vazi1NG6T1qlZtAtzYjpanOPuyblZKeOsxW6gjsdZB7I
	 eDa9ePJvNcB4bPn37qk4s2yzewN+BzbgSsjLTsmYVHsxdUJS1nalR45Skpj3m8pE/bmKO
	 EaDllPXDYxuks7bodzWLYpKtju6DkikUlQzCMD5/ypiq8pmIQ3CVz1cKcTV4whrHs0lmy
	 TOnqXVpA8hG/dtpgO49Q4t0GhoBxbP93MYvi04+bYDx1V/HxlBfdxpZ51xBp96q8ISuml
	 tdID3e88hf0AS7TOPFIP4xNfDoaIOS6L/1Z1KxaW9pEZ2/27CRrBX892EdHNCmeLkmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NvDQgFPrYIv0RGOIRNSHY0lOqUOFb7lap39i5lWlHGI=;
	b=O84KuFkxf0rxEl69QyKCyTT9vt0K5mAScgL74Zilp3H6Y6iT6BYCBiWA2G5Rmkmn2lNa
	 bKa0HwUNpWrE5Q+ELd9/vFbH4gxoIeAu2+wO8k+KNB2jX7OSjdDF18KcYQfUQmcaP+364
	 /hwbZBV9vsX+CXCFYBH+og812leLOcmJURgHV3ihjAIsDyAsa9WRU2rMkNYU0F83cg4St
	 TsU29tNkMvLTo/oRoRc1kOSc8SEO5ctlc0LcGmJOY1ZE8Q2lhijtts+Cat3tc7VeDJT2n
	 qXP3rC4gU5nb2haSQJj11TLLAp2RBaD1gVkU7TBX/cIDFd6CDocbg5RBB3c0am2SLfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNFACqP8;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67F60A261A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 10:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A67F60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNFACqP8
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b042c0728so589275f8f.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 03:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268043; x=1793872843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NvDQgFPrYIv0RGOIRNSHY0lOqUOFb7lap39i5lWlHGI=;
        b=nNFACqP8iH14vZfcni9/+w+f+fwBLOpoZaFcjOLzlKZ0Lc6v6A6ssBwaRpFxnSnbvQ
         ZoRa+MAPqZ3FZcjxzkUja8ZDRtyVYD6tZfr9AEvR6zZ5m7Q+bogw8lq8ZGmBgj0tMJ9x
         HxT9Dpah7EuFtNNvHKjLwEpLoBfLLGJtYMlplYy8lb/zPpHCly4atpF+jH6kdzenzDQ9
         1cF/fW9U92z/5V7r9zFTj5FDnzWS2CWzjd0gICjAnU/wIIp0jERODOj91pWvNcLOO05d
         qJuKYlTLkxtu5pY5uRRljRDcnDx4Zb9SlS5SaDWMvc5rI1XeK0QIUcR6wLbhfNvz99n3
         glPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268043; x=1793872843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NvDQgFPrYIv0RGOIRNSHY0lOqUOFb7lap39i5lWlHGI=;
        b=FlB5kIt0WbMzSTweroqO4qdsfEQk06uyQix1XjdPzQMuC39sgodlqw7AoPdalAAyDh
         DimyBQUKnbQDB7Q5TECQSeXSqYfqEz5XA3cDWK90cCJBXGU1jb3QQiqjzo/vtzOOcpxJ
         RUkLn1zCNubb/XnfImW9LZ64tY9lrovyRyGB8H3auQ55TpWOB8KTwoN3gIOxz2XoItal
         l0ESXF9GdB9OICoq8IRW4EHx66WVuvCEAwhiDsvVM8aYq8DA1cF9FIFfZMiobWsvks+K
         XXbqfNvLlXbBwBibxMLjxm2zZj+CBCe4CVJkFrBl5/+U8GspSyCVH9kSVhnipaPjY1GR
         vY2Q==
X-Gm-Message-State: AFq9FYJpAQ3RjFSDdaTjfTqRksPcv8VaXwbEBjG4KjLRd94JpFC6+MKq
	JOiI/1p1dQ9XoxhVAGtdKR6z4QQDef/MZKYfolX2blPLRiiUCdrCC0r+qHOhRelL
X-Gm-Gg: AYBFou3JFjSpF8M6QXcb2qIA5o/pjd0m3+EF2/seC6AICDePl92E16w3WM4b44pS4n5
	k+B/lPMiniceA3I71LvUakz4R1l8AcV/ovfWCxpfONof62LNeO5jXOa7QZ6gPEZIRALgLaYpVVf
	ECYS6S9qTVsMxMXl5vnBuAmEdfmgh3NqGk6CjU94tzB31dhhLvlbKN3zDWf3PUvacgpYwRBL/B2
	Kp/2MfTsL9f/FPd9g0lEHBPGEAzH8EoNLwGNHwP36VNjUUsO/gyKRVJiVhcZFqL9Jpan3fLBZ+U
	lb1A/4j9WS86tQ0qtNlErpIvWvuHV7FHv4R5dk4ez85aF4kGf2/7k+EXI6UrG/atXVJJCkd0DYk
	OcSzRarW0XC3mSOQB42TPqvThu8HFoowPnGiWdqqMtya2HVvKBuUH2Watp09eGw8cG2R4bPq6YX
	WWYGRZzSEtbtW9LrvNTpwxERMiSkoKm1RNeYq0bUIGVSGg6IQ5IRovrMZWMPb85aMfaRDq0pKoR
	nW3SCbzWlpiDFDDsHDlx4c7n7bZk+TnZSY934wLa2bMVlbGrmnSgBs5sjpFin8BvJz0wblVEyaf
	zspd0Wv4bi7samjFjzxX0C8te+8myA6iKQ9dTLX1s/5VXr/QqhpdcPu3hUJT+kuO
X-Received: by 2002:a5d:4e46:0:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-48e5d58f60cmr9225873f8f.14.1793268042831;
        Thu, 29 Oct 2026 03:00:42 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm34025569f8f.9.2026.10.29.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:00:40 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 2/3] docs/bpf: Document bpf_path_getattr()
Date: Thu, 29 Oct 2026 11:59:51 +0200
Message-ID: <20261029095952.44833-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
References: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
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

Describe the interface, result fields, supported flags, and calling
requirements.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 Documentation/bpf/fs_kfuncs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/bpf/fs_kfuncs.rst b/Documentation/bpf/fs_kfuncs.rst
index 8762c3233a3d..9e0e391bc007 100644
--- a/Documentation/bpf/fs_kfuncs.rst
+++ b/Documentation/bpf/fs_kfuncs.rst
@@ -13,9 +13,22 @@ BPF kfuncs can be used to get these data.
 
  * ``bpf_get_fsverity_digest()``
 
+ * ``bpf_path_getattr()``
+
 To avoid recursions, these kfuncs follow the following rules:
 
 1. These kfuncs are only permitted from BPF LSM function.
 2. These kfuncs should not call into other LSM hooks, i.e. security_*(). For
    example, ``bpf_get_file_xattr()`` does not use ``vfs_getxattr()``, because
    the latter calls LSM hook ``security_inode_getxattr``.
+
+File attributes
+===============
+
+``bpf_path_getattr()`` queries filesystem attributes with statx(2) semantics,
+including overlayfs inode and device identity. Use a trusted hook argument,
+such as the path in ``lsm.s/inode_getattr`` or ``&file->f_path`` in
+``lsm.s/file_open``.
+
+.. kernel-doc:: fs/bpf_fs_kfuncs.c
+   :identifiers: bpf_file_stat bpf_path_getattr
-- 
2.56.0

