Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1390CE56A
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046507; cv=none; b=JvwCiEpWut1ZPfOPr/YcX18tqCfj65YPPU0ctjJMR9UBW3A1r2Qca+7eoEpqtCTVDXUi4dHdt0riuRIe60R5hOHthPAn9qxaKBtYr2Ls8hRRv+7I0833FsmVQ0Uc11T3AzSVfVI1xZfWnmXBsQb56wwPSSxyjcVGoPVNHX/8FpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046507; c=relaxed/simple;
	bh=9p9AyyLaqGjiI90pDaLvtQfGJBkbgpeFW2dOwWevsEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6E+qrDv3jBRVwCdzBZzK8TbBtzLAfrkthF37XIjm7hyu+IcZNwAmUjucDYrjGSiAEPLovHncvcQtpFjg1hqlsSzSMGzeiAA7sUycQRGckhaBctJXfmg5FuaZ+bqJ+4kNBVacGi9wq6icTmpLuebc1mDeoKhMQGURoo0Hu0MRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqJm6nD6; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqJm6nD6"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d744d9acbeso2817994a34.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775046504; x=1775651304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Fqo71wXKpKfOtwG0bcdWhsYxUkyyh9fxzdlYgknZUU=;
        b=NqJm6nD69r0UcfOUDrGUJGIP4nSv6HdL41eqrKvTMQmTkZLx3owhC5OyXfsz7dmjOg
         KMLH/TBaw9NLXDJkf6EhAIMSz+k8bTkQsOdnVMac2LRJEfCG9oFOBXw/VirOaylGr2Xu
         /JpiBU+mbpfLY5FKc6cupQyeuRYMkOs5GBDgzFU0bsKv9gpDxyByQVjUxKMrfukkySjd
         aJ+t0X+cblpnSkRJt17qcQ6+nQm9DtRLtOISBZokI+mvJlyUidPV/Kd7UTevtlRSKxFw
         QrAP6XKx4rA2uFQxi+J/GACZQJySAmeSAZp3bRc77jsYWuKgGgdW770P8CHDRTBWPlvE
         mY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046504; x=1775651304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Fqo71wXKpKfOtwG0bcdWhsYxUkyyh9fxzdlYgknZUU=;
        b=Df5HiwdpREM2kYpCU9NFAmCmeajn/iDkIcQSrCqAGVd/vTeZMoGAVKtHlU5boLCGZf
         XIPeqK0yey1wXc/UYEZEaPyGPTtR8zH+QAlCt+ZDx05J2VhSz5W4ibN/OTsEMmOkd7io
         veTMqc+QSrvX2WwTzS0GsuOCkm1pjIqEZWpXoAsgPYzNBmStM2SeWdDUBOPCqVXI/jYX
         DMfQ/tTdTbvjpJQIy0JCA0412xNx34ytRqS50kUiCy9z4VLAqwTahUKjc8N0u0spu5xi
         78lzh4K8c+GcpByKW/0j+OdADAZv8OWQFgTmLPpurp7hK3gYwhhCWwJW/bVH+qmv61MX
         JUgA==
X-Gm-Message-State: AOJu0YwLvAIfy/MiFyjZpjPrW1notmyavwkqTaE2Mhuk/rgsT+SRxOPL
	vaG/laatFwID2rBKiXfzoY379bJ56rVmbb6rgS37L6YoZMkRiNE0c9u2RvKbFrgYpSA=
X-Gm-Gg: ATEYQzyMGxoB1F0PLDeDX3jUas599yxtLUh/xcgpEU7iDIM2AXrITRjVBU2hmJ1LLwJ
	YeOkeRNMU+CxZ4bkkZZNZzJZpJG68/U0mgeN+41DoleMYNFi29+K7PmneP3nxk14uhceg2IF19+
	xcC3mAPrX/oEiXoZb5hQvWP4hJW5niAH2BQiVjZpD3eZRlif1lgHT5AwdfeGdoysuAHDPdeTGh3
	7XcyMr2TTxYim5c268ec1zB01LTKq3JjVIiyfZoKiBAGGXRgy+TNDnqoUT4GHPMFxmk08XD2kq+
	eQIRf1BzuEUfL0B3fSSGLRbTsXGqwxZZQLGKkjDk8mT+9yNIB/KF8+ouaf00CTgtHl/nYzv+bUH
	k7J4cZbCd5FmlhOBvr1St9LhhBYw/bMYS1HQBA7W5gHR+nxFgnBe0kl5RaQr4tBRLZYKFRq72NM
	yt+oU2A2ioP7XT3reUoYot1c7LNkD50Iw3eZUjUGcD8AMGznSlr8snpsI=
X-Received: by 2002:a05:6820:3087:b0:67e:3265:1659 with SMTP id 006d021491bc7-67fabd0ee58mr1574667eaf.62.1775046504466;
        Wed, 01 Apr 2026 05:28:24 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04d6bf89sm8243310fac.16.2026.04.01.05.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:28:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/7] bpf: Enable unaligned accesses for syscall ctx
Date: Wed,  1 Apr 2026 14:28:11 +0200
Message-ID: <20260401122818.2240807-3-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401122818.2240807-1-memxor@gmail.com>
References: <20260401122818.2240807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; h=from:subject; bh=9p9AyyLaqGjiI90pDaLvtQfGJBkbgpeFW2dOwWevsEg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMs371/XMVx+jdNN4qKvKzNnmVk4HRocUt75Z1Z8UFuHgct W5d2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKBTxj+5yk3GL9mvHyuMvJq3sSmpZ e7Fru1ijDKfPys/ln8yt4fhowME5/NmX7ihe80sXfuPA1XTLsvFbqv1Ljv7uD/9eWW7166PAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Don't reject usage of fixed unaligned offsets for syscall ctx. Tests
will be added in later commits. Unaligned offsets already work for
variable offsets.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/syscall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51ade3cde8bb..f06fe9a9b1d3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6348,8 +6348,7 @@ static bool syscall_prog_is_valid_access(int off, int size,
 {
 	if (off < 0 || off >= U16_MAX)
 		return false;
-	if (off % size != 0)
-		return false;
+	/* No alignment requirements for syscall ctx accesses. */
 	return true;
 }
 
-- 
2.52.0

