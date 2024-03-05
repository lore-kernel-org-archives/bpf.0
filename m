Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BE28E23
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607926; cv=none; b=bt0gCZ+dYAiRyyiLQQoZqasB5VHy5WiwujhpXv4vBfjDaChwEA6GGwaiKpSWs97fdIqKgZ6sZM5RyKIzxI3YIOrxWx9GhIVR4zsIpXnDo8bxhdF9hkY1vqOhl8qITzwGVyqvSWO/nyeZS3RkpDTuKF53dQ7L/73HXW6MoPi+iJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607926; c=relaxed/simple;
	bh=lgfINaiLdOBQ4e4ik4QRTuWaoLgUUvuFaltC5V5ewrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2PZLouM3HJZHoug9uGiJBbX/s/HM+JrsLFdFD0kg92PDc1fBPs9XM/2L/pqnln/iPgkIRqBt8IdXcnq93OYvDQn1HcCiifTkK7GTja4UQlmxLqe/wqjtuCrf+uLcVSl1DaVuvDxlBUy+NSlq0UF5aQKWu/lvC6HK+uoooHpY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT5APoc9; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT5APoc9"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c19e18470aso3417827b6e.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 19:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709607924; x=1710212724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvs1TetY/ywxZOqb7cu6/qS8FYbgNwju0ZDKmLnC7pk=;
        b=NT5APoc96Dviubg/QNLXZi9InEUbwVkFqfi7kwpXoGAEHO7GIJnkJCS8yq0hrNoRMW
         Z5dPMjU36IWXZYvnsBct5fJiAogDEVNAsdY+sZxMmTZ/NYF6HhuszGsyA4b4LiBNLA6Y
         DctfF6056mOmtIX8XV17OXr5aFHWPBb8MQnJTDAsFAe6Fb7B2GtYc4bEf6cBy4bPsf/4
         ZiGtgaRDlFUK2pAHccUc5c0aLLgpEqfV7KPxf6mHyN523g4bAd4teqppLoyoXlFT9YOQ
         kKJbwOKU6bMRqC4D2XYwbF/B6k95JwLUTCNplr2z6lS12nsaqHJAayisf5gXl0XZC37A
         l+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607924; x=1710212724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lvs1TetY/ywxZOqb7cu6/qS8FYbgNwju0ZDKmLnC7pk=;
        b=S3uRr7+Wc7cNBg4YCkuh+RpUg94bUoc7KFJxNtJ/nC/py+NZnJQwkHKOB9HYPRHv3G
         1eSCW8nHIK38Jekb7cneWrDcnd9yF/szSb6CPyXeIQ4ZNajSoNDKu0OBqVaQn0TBa8v9
         eBuyLmtKufiiT2qqjbRx23J3EC2i8J8wCjvminvlPaSOtg0AsJELXXcqAtuj2qR7aeGf
         pZkwVp/CSS6OQRHo0dDC022WwKNfXByZZGxRyJPft1b4G+xpRmU8QD2n8ilVtOt8SFuA
         Bm1vK0mW0Hk6vrsezVhhm2p+75fB6ouJ6z2VcbsNPD0UScup4D/WlUDGOqg3zZBG+XVV
         rYbQ==
X-Gm-Message-State: AOJu0YxP8Xb6uG9cJBXzDA61WwoO9fS0MicOWC83+Zzvy8qr+j11JmE3
	6E3buM9Tdb5HRVl3fMbE3Pltm3pCj7kri7nQF0mMTQaD3wv8AdHVMeMXcoio
X-Google-Smtp-Source: AGHT+IFYfdb0wzVKskM65cSKwSSitCWQ5HIwpxCM5POpmVMYG5/Wx6Ndr8UyOlbODBpKZ1uFvI0VUw==
X-Received: by 2002:a05:6808:4c3:b0:3c2:c13:978c with SMTP id a3-20020a05680804c300b003c20c13978cmr597466oie.5.1709607923728;
        Mon, 04 Mar 2024 19:05:23 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:9426])
        by smtp.gmail.com with ESMTPSA id i37-20020a635865000000b005dc5289c4edsm7941060pgm.64.2024.03.04.19.05.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Mar 2024 19:05:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	rppt@kernel.org,
	boris.ostrovsky@oracle.com,
	sstabellini@kernel.org,
	jgross@suse.com,
	linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 1/2] mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
Date: Mon,  4 Mar 2024 19:05:15 -0800
Message-Id: <20240305030516.41519-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

There are various users of get_vm_area() + ioremap_page_range() APIs.
Enforce that get_vm_area() was requested as VM_IOREMAP type and range
passed to ioremap_page_range() matches created vm_area to avoid
accidentally ioremap-ing into wrong address range.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/vmalloc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..f42f98a127d5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -307,8 +307,21 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 int ioremap_page_range(unsigned long addr, unsigned long end,
 		phys_addr_t phys_addr, pgprot_t prot)
 {
+	struct vm_struct *area;
 	int err;
 
+	area = find_vm_area((void *)addr);
+	if (!area || !(area->flags & VM_IOREMAP)) {
+		WARN_ONCE(1, "vm_area at addr %lx is not marked as VM_IOREMAP\n", addr);
+		return -EINVAL;
+	}
+	if (addr != (unsigned long)area->addr ||
+	    (void *)end != area->addr + get_vm_area_size(area)) {
+		WARN_ONCE(1, "ioremap request [%lx,%lx) doesn't match vm_area [%lx, %lx)\n",
+			  addr, end, (long)area->addr,
+			  (long)area->addr + get_vm_area_size(area));
+		return -ERANGE;
+	}
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
 				 ioremap_max_page_shift);
 	flush_cache_vmap(addr, end);
-- 
2.43.0

