Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931549BD9C
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278685; cv=none; b=LHiBMhakzEOukuigqqJmV3arCqYrjHX2m9DU2una8MTLyO71h4bTXXXuhCwu31QSaTF2bU/1oqlje83kaeqveg+BBavCxzqWVnvmAOFfXwLQl89qUnhZHUBj2xEpgMnG/LeVYuf96srjPljlXi9y6TWLvVS1zWRqI+m7bqZuJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278685; c=relaxed/simple;
	bh=GmqrbybB0cRa/yhRH2tzchi63vLpUN/oWUG0mNUP7Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPmSfQsRTrd9LgBUeZU6lwJ2EeQgYmldgU3hzVyZ6Z1STKQR7xqz40c8hi18sUVDl17mZdFTWtMmS+34fGLauYRjtr2gCCdlM/9/o2RuzXh9LTQ+9uEqZBTSJBrkVMzUugkAHwx8y51p5RZKsbFpeOlgM1v/BORqqEvWf3fZPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krUYQF/Y; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krUYQF/Y"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso594549a91.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278683; x=1792883483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xXdDMN/wbffbam8Oa+0V2IiLYLK2q1GiUlmxoUr8uMs=;
        b=krUYQF/Y5nUcRKeS0kbEBxMCPRvfhc9CjOyKPFnkB7R3YsMMNwmXnFfc7YB+odnpZK
         uWdlIvvndf5IJp/eLZcieBDd0UJ4A1fgPnyDwIF0NPRahlJ+gW1gqH2kFZK3Utqa1caO
         JSFlTR5IGTNA5bCOR6ItBabx37uxhcJaqR0VMDKHkKM4GqrW1lt0rD9EB/BGY6v2umKn
         BFOwRc4QdinL5WSSdIi4qpDy3vCoQ5KDRBDdsXZZ7f/LS+QRlftnxzpqjV36pn7orvgu
         6+99wT2V5vEKO1/yRtqF4nnfe8A1sCujROUHOF0HflP5CGn6piHEHeuSxMotCw9Nj4mf
         3h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278683; x=1792883483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xXdDMN/wbffbam8Oa+0V2IiLYLK2q1GiUlmxoUr8uMs=;
        b=yDhp1S6ICTtrXPcCdnOGJ1iqVHOyqwV+n/000UN53mnbNMXoi/Ixy0PFQdu+Yunvc7
         u4yUu2oXwQKKVpqE48mwDrW+TkA1JF8+KeO4jfu/g5gxTLX4YHxI4IlUr7/Ch14hspGL
         hz+DAqlV7+kGXZzh4V1NXaX134hK8S/PXWUCOdQ9jEKlEEqz2lNkSWwmq6ftf/6RA2De
         c3mGLw2sQYlJ2A2N7XrxZfS3KzosfFPbVcHAFcrd5f6BicPpQ/N0WRqtO8Ngcm+V08Nu
         AzaOfLzu/uilf/Khd7LgY+JfbfHM3mcE/W3Yg41UKNelcFfrTp+KXSniByOaB2k/Plw+
         Ho1w==
X-Gm-Message-State: AFq9FYJPaKAkHJRJJfsIZwAso3tQrD7AAjHKCUJS88tuU9sS+YqnvWxO
	bdkB1jWpUeO2Bh4BVnqJcWMHsGFv6kw3z8GGMWtpbYUKLW5HwaacJG5FuD6UMA==
X-Gm-Gg: AYBFou2jm+aI63aFflVp/kAQtjwKbVcMMjkqfLIsYK/4IGWuVEJxVTmIPHjoitI+Xgg
	rpFuhnSPUDy1DSYrJVtWlub2xE+XtIPwcYlsvrzLhJHfcMW8HIo5QbcLG157ffsj5/BJZ/cGTg+
	tp8V4SXrX0FQYhSraTDebwRMoS5gyUzYYDQbNYKTEbwqLtuWmaNaLwXHzhW09zBtmAJyespJlp7
	4XeCppA8DDfM6ApcnEjXV+jdAkGDIo1+3OlpGt/60tYO1fimbg6aU3uIaMky8LrigSfF0mcxd1k
	y/xiednFJgriuHaLhjfWmdx5UuRr6a+pbCXRsl0NEovuvguEDzhtGp5hXuh0muIJLLQZN06l39B
	WvtHvs9OzVsY5LVxHIvWr91/vJDxkrn1MIhCd4CpkzP17qjPaHYkrukurWLN7XTLISOaMzwy6cO
	WSQqIz+HW4VpM2VRkapusGgLhrJSVz+/wBaztlmuEgSNo1frxiAyu4DtX3yw6y1hGOHATJMUbo3
	uuO6lUdb09+tu8OHmNjEe1/XXaoremy4PEIxwJWo+WgPNsAcmUfKKFR2sIuaiM+DMH3q9hWcRDN
	ukKF3spKzI5tJb6xbPwQosc7XFu1wwXNZPiSuRTB3sZrPjiKR0wFpQ==
X-Received: by 2002:a17:90b:5743:b0:3ab:7031:d962 with SMTP id 98e67ed59e1d1-3acef2b5b9fmr3167839a91.41.1792278683497;
        Sat, 17 Oct 2026 16:11:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9a40720sm4926214a91.1.2026.10.17.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:11:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 15/16] bpf: Use memmove() to store bytes in an xdp_buff
Date: Sat, 17 Oct 2026 23:09:49 +0000
Message-ID: <20261017230950.802052-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_dynptr_write() to the dynptr of an xdp_buff ends in
bpf_xdp_store_bytes(). The source can be a slice of the same xdp_buff which
overlaps the destination, and the helper itself takes such a slice as well.
memcpy() then reads bytes which it has overwritten already. On x86 with
FSRM

  p = bpf_dynptr_slice_rdwr(&ptr, 0, NULL, 64);
  bpf_dynptr_write(&ptr, 8, p, 64, 0);

repeats the first 8 bytes of the packet instead of moving 64.

A write that crosses from the linear part into a fragment is copied piece
by piece, where the first piece can overwrite what the second one has yet
to read. That is not dealt with here.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7fbee7570d0c..b7ac145b68b1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4330,7 +4330,8 @@ BPF_CALL_4(bpf_xdp_store_bytes, struct xdp_buff *, xdp, u32, offset,
 	if (!ptr)
 		bpf_xdp_copy_buf(xdp, offset, buf, len, true);
 	else
-		memcpy(ptr, buf, len);
+		/* through a dynptr the source may be an overlapping slice */
+		memmove(ptr, buf, len);
 
 	return 0;
 }
-- 
2.55.0

