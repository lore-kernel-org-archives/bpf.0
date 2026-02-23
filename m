Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D57280A5C
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855852; cv=none; b=Ar7C8ENcQd+lloKDPp+TcJ6X49yAK88BZh1aFVhk+qV3zQ3V9qnkLWv6ZtOZBgoBzFHSjFGqlCiscMfODLZ9vDNmkEXgeuoJV59O5MgiJCroqdWO8bZeDbQFCRf/3crrEQFJU1iorOsH4HRve5r0j3xEaZ05lpt+kh8uFq+j/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855852; c=relaxed/simple;
	bh=sDzcjQkzAWw7X5rlfIzEibzN2rOuTI+BfzLbseUS4II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyH5vR6ik83Cxv+cgbJ7l3egSO2bfWCYAexodUB/wZESGfK7Yij54k4iDbdJ0n9LFuhHapsule4RFAqqwjhWiXzFFB+JFKS954YCagkR1w0flGGOq3IVwaRHTRTLe3ofNNHjTJYgGdufBVOC38u9tNt9cpHFRjmQarNHW1xsUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMkO3VCg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMkO3VCg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43591b55727so4300967f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855849; x=1772460649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjRrv3KM8xQowe6y2+mGh/Bq1IBsIN9ajRwFWDh4DBw=;
        b=CMkO3VCgMa4XMujbXbwYm0lhMhUPX/d9p/ypJA37gG4oQgthM3vHaT35cdcA9vdFv1
         8J4p45gjCRiU+tF/hWfHI4rVZB19HniUrlBGzzujWpETMxUFqnB2covHDJGMprrVu4Om
         U7qM7vNj1UjI1t/R2yNfq8G0eobjk4Z3nvUhHezvHF44GaZg3MahpIPOySm7FG5bexof
         REOLUMmyK2RQ1NU/SaITAfhj1fT3vBsR+LAttmVdJSH3vhHMmry+ZhZc0s2es9iuJ5gu
         nqGa6ITplJZAuaSBDadHFu8X1pKRROXnxPBJJj4x3KNgQleRFl7S7b5KSlIEYJEiJNIV
         6b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855849; x=1772460649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjRrv3KM8xQowe6y2+mGh/Bq1IBsIN9ajRwFWDh4DBw=;
        b=RZCYgkqfT3QEQQHybNXZtVBr4ICZXHdy5Vgzzzq7VXKoO6LkoiQgKSYt77OCgU2qRr
         tyn/insILtepABhIJnZ6Cjb18djFi4dckKTHGpBX4/5Th4OzF9ACHR7pVZUjQiz6MnRh
         5FTyYK59NV0JmX0In00VLb46Llt10/tCeNZ4k3FvIHo7EU/+1+QtZO9uXm+Gl9NYOkEM
         ifJaR+wRBp/FPSeGx6Q6bvTqzrQasSUefUgXcIGq/1BlYGdQhFd+sz1Fy5GP+yITgNIV
         osDjuTZxQij+wMVuNioGnOmuRXQcIbX7cYfFJ3Arj0HAORQrx4i7wc8FmPgHMU538knA
         I0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXzsfI4S6RhKFaBRKCNYlosWutgQHpejGuNv0jzdZTjpZ/QkyEP4gNIetAEe4Hhyu5gpR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWl0JrZVTxtyZe0oznYBzwtpTMHv9pou+rcTaV7E26Ui623Vt
	TRf+FK3a/4bBWMKUTTNX4+Mzu6tE64Mwq+gBlbaNeOMLX8sMb+cAPSGY
X-Gm-Gg: ATEYQzxiOUXImH4uAuOL4DqRZC0RUsRr1tvG0xlP0WwxNs18oBGqjfD/fRKSuy/ZGiZ
	1dRXq9fXR+t8WIqbva2KA4Wp1IM2F0BKiMDoOCMxHlbMHuuwjJUokbjLTDqLCdmVmxMOBUi5Fgq
	T4X9sJrpQf40+G7b5YMvu2lAKIadbmZsz9KtTIO+v/femWdHd0ifWaSFN2EKA/1CTEe7yfgvynA
	kdLVNDqIY8Sku79ZcW8poPz0ABwunxTPIfyBXZz1ccVwD8RCkPxz2pAc8VHn6w4BUC02iE9qQZ4
	rZ6lQl3hmpB3rcCfmtyVyvgkydGwROGh/3P+QXxg2dWf4E6R2c7fBiL7p6VtCyZ+Zbf3YKj1Bo4
	9tWVO12jd9yh6h0QOOvLvdijunwZNJnVUorxkC56vnXN7dWj42ET/PknIf59lcXRT5Nt4FRc7TG
	CuqAR6d/RwT+gD/A6LXSAvTXmeCnjT3Kh2rLkg8HtD4BSR5a/kpE3dfn8YjMOXb7zipKW0HPYYJ
	pEhDSYjmA==
X-Received: by 2002:a05:6000:4026:b0:436:173c:b8e3 with SMTP id ffacd0b85a97d-4396f178732mr15944711f8f.29.1771855849129;
        Mon, 23 Feb 2026 06:10:49 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19464640f8f.6.2026.02.23.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:10:47 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 06/10] io_uring/mini_liburing: add include guards
Date: Mon, 23 Feb 2026 14:10:17 +0000
Message-ID: <9ff4284f5819ac7bec25e88e8909073058626435.1771855761.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771855760.git.asml.silence@gmail.com>
References: <cover.1771855760.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add include guards, it makes it easier to write tests with multiple
headers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 tools/include/io_uring/mini_liburing.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/io_uring/mini_liburing.h b/tools/include/io_uring/mini_liburing.h
index 44be4446feda..81513b82433a 100644
--- a/tools/include/io_uring/mini_liburing.h
+++ b/tools/include/io_uring/mini_liburing.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: MIT */
 
+#ifndef IOU_TOOLS_MINI_LIBURING_H
+#define IOU_TOOLS_MINI_LIBURING_H
+
 #include <linux/io_uring.h>
 #include <sys/mman.h>
 #include <sys/syscall.h>
@@ -309,3 +312,5 @@ static inline void io_uring_cqe_seen(struct io_uring *ring)
 	*(&ring->cq)->khead += 1;
 	write_barrier();
 }
+
+#endif /* IOU_TOOLS_MINI_LIBURING_H */
-- 
2.53.0

