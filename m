Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6742E8FE
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949188; cv=none; b=S7H4VQArv1M8pyZyeSba8kesMw52hZKFUjUD3YCbARShVRx2NXQ73U6EFBt2VxfhWlNVeEzinOgY0ZpfFAHCYWsLhh0fT8ewWFpER0Rx1XTX1qdjq+PyVDdS+q36raMJN/akmcsm7l8Np205H9WlQtrV9EJHLKr69fGHbNTQPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949188; c=relaxed/simple;
	bh=PRXrMhHHmPDmSfezdWtwj6oy53snFDFPa7g4fqzcLx0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=th7TuNBs7+GGcu3l81+kjaMnMwzEil1EC47ALKTg4pREwW4W6x0WRL4cilye80XukcDuwjsd2XiWrD9nL7/90UmTWc2Xhl2yfCfx2yjsQHm+N36PqEkEgjumh5c7AqR8hlj1Ey1fjtSGpxU++ifdiW8i/hnWioNhpDS5NVxQCgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR2Kk1YX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR2Kk1YX"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso3184179b3a.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783949186; x=1784553986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZo/QGvD29siNmPQnaA3AO4F48nI154SXJ006XgsWpM=;
        b=SR2Kk1YXNBm1tGnrfvyMJj89tVKe1cFJa4mAAPFj/dHT2BGIrnYKG4BD0nyDyDXvGu
         mfs3claoYKjHTfdHWW7sfFIU3h6eYftAG//2Ps4g3upiX6gxkyr05+hLH5hnJP5PtmuV
         /sBN03wPlEkB6hbe2JFNJMpitYtFO1Ylr0pI7VIxJFWb4vn261ZQjD5+U8nbVAqgDIiL
         BskYlcgep0NA3CtjHh61mF+KHyNVwhevLnbRK3y8cTqNeg3PTk0nN4dISzbMibsxfbDS
         9Yu9iNQ2GiP5JmmhKLyLcCqvV348jxiF9lgfKEy6b1EZkXszr7H7NjktYBmJISchC6iG
         32/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783949186; x=1784553986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PZo/QGvD29siNmPQnaA3AO4F48nI154SXJ006XgsWpM=;
        b=HdCTiQJwbE3xfQSymcC4/pX+pAdu0X7C/6s/0suSEPuAy9RvRK5hsXjOVfY3ouCB1z
         7ohOSTehOZyFKYZ/RCciU6z0zDqGibdAdE88IgR0zx5t4E0tQBXr6/m/qZCEsU/moyt8
         Z0tfqP+Gq3/w1c12zdvlltOVFReUob9gZS38PubAs+zif+Bg7lz/wmP+FC9kjoI1RVGm
         ycBXts04a/hhn0JVJzr/ndw0kHNWnL9Txnm2JF9TVDmNC1df5iUl8Tv25dmZsoMZ1/km
         AirixeeifA/Kw/7iGI/Jw3ssa1OOP114jygRbUZOFvO3YySe8D1aXuUkXTPT5BhZ+/gU
         fbLQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyEfGZ4mrds2OxfMZELU+pHX5z5Y6ZF5puvlCzQ7UTVICKJjUy1QBFyQB+E3eNXtwgH/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWA9kjOyMLjhlz6iAKVM5zIVVKy299AriEvyDluz62/j4T94uQ
	fUkIkTGxXHX7hgBPqyX44c2deaJIgjD3zLfpRsQAN1VON3qBCSsoeH0k
X-Gm-Gg: AfdE7cn33FmoidRh5T73RAq3rCyGVwJ8wFrq8JupNgTEYPf4OIXhHWrT5OoiplLAs6N
	TgrCO9U9pnAL68LtIIwSBUSbttx43esVtZkI1xj/TjxB9fZUfRyrw6eIboLU47oNAV+ibfUkN1s
	6CggQa7FKJfCRMWoGQza2WatBzT4/AVCs5mPPo0Hfgk4uNyzkql9N14i7dAJK8KvbcxzoDOyxUm
	FiBlXjK7Sl08YkUPe6oP2GKy7d4f+P/jz65vRhLNuYpcpU1/UcBzAaSSdTyu5HiRT3BehFOHgQY
	t5Qbajs5iifbhA6NxVUlA1R18CVDDB6yjLAZpynf14n5itP0v7tTtOL/e2jal1EOHfF3GgVHN7M
	JKjNx95pgHuz5zhkMI9UKN6vljtQW2LqD/VwjADzBpsBjpFTozYlx7Di2Ch3WTUQWwoH1ilOM5V
	2RWVCGox7iog==
X-Received: by 2002:a05:6a00:9094:b0:845:d274:bf8a with SMTP id d2e1a72fcca58-8488977e8eamr8992840b3a.51.1783949185747;
        Mon, 13 Jul 2026 06:26:25 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4d000sm14194934b3a.34.2026.07.13.06.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:26:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] HID: bpf: Fix signedness bug in hid_bpf_hw_request
Date: Mon, 13 Jul 2026 21:26:08 +0800
Message-ID: <20260713132608.1265541-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_bpf_hw_request() clamps the return value of hid_hw_raw_request() to
the size of the caller-supplied buffer before copying data back to the
BPF buffer.

However, ret is signed while size is unsigned. If hid_hw_raw_request()
returns a negative error code, the comparison promotes ret to size_t.
This makes the negative value look like a very large positive value, so
the error is clamped to size. The following memcpy() then treats the
failed request as a successful transfer and copies stale data back to
the caller.

Handle negative return values before comparing ret with size and jump to
the common cleanup path on error. This preserves negative error codes
while still preventing oversized successful returns from overflowing
the caller-supplied buffer.

Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Handle negative return values before comparing the return length
    with the unsigned buffer size, as suggested by Emil Tsalapatis.
  - Use the common cleanup path for negative return values.

 drivers/hid/bpf/hid_bpf_dispatch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d0130658091b..520b8f56a514 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -445,12 +445,14 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      reqtype,
 					      (u64)(long)ctx,
 					      true); /* prevent infinite recursions */
-
+	if (ret < 0)
+		goto done;
 	if (ret > size)
 		ret = size;
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
 
+done:
 	kfree(dma_data);
 	return ret;
 }
-- 
2.43.0

