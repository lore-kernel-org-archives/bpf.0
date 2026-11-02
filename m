Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616459;
	b=bUKvEUTGdYBcYBmzScohU4DEDj82bcuZTfAOV2wVuqj4G8f3Sr0rGsiylcfXfjHwfXIO
	 M6WH91HQHipEpmzCNL+2gF5hpzN/QMBfTWvTGJuOK/aAiOs1f93X7n34a5N5gTBgL+UXr
	 jyhjoh8HfZ5pGtNQMOZZF4R37tdwcPOfSbRCUlSqtya5vNAvuCQYT79cRItsz2Qy11WBj
	 euBjYQ4PhW88D5TTQV5WLBXpG3eIVbrXZU83aDt4mjMX8pbiXAMLVXEiFE2ig/Sc+u2/K
	 pf5UoWQhYMztEOVe060bcPHksnZ5WEenfXmv9CF2bjsWs9cVidsxWyprW0Frkn2V1ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HyDSHSgspGUCXxBL33Pyf2fxt1FGBdRsUfgAbu0U2lg=;
	b=EpkP8+rq8duOYexmrEke7yFsrm5xRW/g9ctDNbw5UPmprCTljsZ7GqQTAG0zjUbY2bI3
	 geMktGxym3uLT7PIHRQOLY585XgarYAo7UYUTw+JyRCRtleyipwS7QQu2HoWjdedbaie3
	 41fXlPABx4KXAXj32l3mFwaZYfplcmvPKFbVSLOGb0U4OYQwCrk5Vzq6ttDVIVhEEZmjH
	 159j3eqMk80e1Uy9PT722vKVXNfHkmSNuYJyZJ70tcjyS/A2inHW6e8bvfOn7UkBuD3pp
	 dnZHvI7oFkbjVYvsjkPkpLIsuFZ1qtJKjLDF+lnDUCoKPYG69R3iXTZTDBA4i5clLWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwhHSOkC;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24D606A33D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 10:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D24D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwhHSOkC
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so32273365e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616457; x=1794221257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HyDSHSgspGUCXxBL33Pyf2fxt1FGBdRsUfgAbu0U2lg=;
        b=dwhHSOkCW0EVkEHrgtbCMeCdOHGQy01fUPv5J3FY36E/daOm4zYXJc2PleAINdu8Xi
         Wdl12oOh7Ocfjrcfhv9V7UDNOWqqOcvLtO2rYrJUornb9Q5RBayX0fsvdmvvVrBU362m
         PYnxt3rRIzf5HPJo2tGlNRx0vw1VHklNdGlnkaPIjWdt90K0KoipGzXWkBr3yhVQL1XB
         XSjtERdM7KFIU182twmGoa3ORD2QAp9VipCnlapwBbsqOKbGW9Uf7qVOZtz/xf/xlkp+
         q0zJYEbqonnd5ITGqxcZfZgJIBWH/lM9ni0/Ny9gftFWtImoJgWYGAwkhg8mKQ1lVw+m
         r3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616457; x=1794221257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HyDSHSgspGUCXxBL33Pyf2fxt1FGBdRsUfgAbu0U2lg=;
        b=cdFJu3UZIisi1bOW/HQ/UR7MWrqqeu8WKcLqrwNwZBOr1OlKID9mkP9wlHFbAykFct
         ZnvRffveJ4U9y7F3Z2zxUGlJA7cdMk20hn4D5lwez5cGe8iR0MzLF85cTsetOL/jLvKI
         eZ0LHSCcSPlTTzkR2T959Nxjj2PEC4PuO4DndYa1TShe869DKH7EV4CH8oTjvLMjOQlI
         nezi20MsO+1goCP6pQA9R9svd6ZCchA8oQ7bH3xeGeb9BMbh3egF+RFCEyUM+7F+tPE2
         Hsd6w1q2qHkDhn8tdROxKSu+nZrmzKM6s+jNXCGGX2DLZdcDpnbG7ghoo7P/HDeYdWcH
         KxUg==
X-Gm-Message-State: AFq9FYLAbIMpOnJuUDXe16tl0ALRW+EHrQ1n06dxFO24WbDVDm+EZyj+
	EW0AI29cziAr6RbiNXoXqDnY+zIInwUgj7D3I/id5SnBIdrKtsqb2Bht
X-Gm-Gg: AYBFou3bpshybly8tNPoRiu2w/VwcefUpsWfrEaDaAq8X9ovtzbyn5Zoj0np3At27dh
	D9rX4p3nJmhvrWj1GQoj2UyWlF5KGZglwlPrBrGynqkVvc7GDTnDD14Vd/dJRBEeD+2etjRqr2g
	GCG1rqQbhS/21mWM3DDvkcdYumI+QXlr07TY+IBOpVv3bbrRZugjxJ+y7Z7GuBmtUWD2YY3eqzf
	AORRrXKCfYjKBDQqWNxTJM3UmkP8jHzSjG6CQDsgjhyIvOloEcamRmB9lAxvf6tyQXL0RRA0xvy
	xC1fskRcfZI3TWbu1o3dQl/BX5Dxyqa6QlFbz1K88T9ukiUGsji2n7uA0gjXV4GId07kckyS1tr
	g9Ju+OnahSZw9qqloieALOUPp5Jj0SSfabMhBR5O2Mag/U0oRLIq5Jj5iRpVIfO7MP8QINI98bD
	Q0iQTD6tIRgmSO4nx1aQz/Uwlv1MuNnQHbs5hAhrMVxQvzd3Rqed1uTp7hWdAHHy3FeJSze7mP8
	0yXviaYqea4jaotLNqDyvQOsAFhJKseX7OB73yFKhynJhkmeyJdkDs7LR38k5YO6LcmwG3NO6XO
	gd5MKGoa9H4v4rfucsDWlFuCBZznk4leQX8lGf6uqLM=
X-Received: by 2002:a05:600c:848c:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4ac17d19e0amr220305825e9.18.1793616457546;
        Mon, 02 Nov 2026 02:47:37 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c7852esm248939695e9.11.2026.11.02.02.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:47:36 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH vfs-7.5.bpf v2 2/3] docs/bpf: Document bpf_path_getattr()
Date: Mon,  2 Nov 2026 12:46:54 +0200
Message-ID: <20261102104655.70901-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
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

Describe the VFS result, output buffer, and calling requirements.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 Documentation/bpf/fs_kfuncs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/bpf/fs_kfuncs.rst b/Documentation/bpf/fs_kfuncs.rst
index 8762c3233a3d..05cc9b657a42 100644
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
+``bpf_path_getattr()`` queries filesystem attributes through
+``vfs_getattr_nosec()`` and returns ``struct kstat``. Use a trusted hook
+argument, such as the path in ``lsm.s/inode_getattr`` or
+``&file->f_path`` in ``lsm.s/file_open``.
+
+.. kernel-doc:: fs/bpf_fs_kfuncs.c
+   :identifiers: bpf_path_getattr
-- 
2.56.0

