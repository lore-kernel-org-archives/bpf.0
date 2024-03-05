Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89C28E23
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607922; cv=none; b=TCFpoob7YRiJJevvId5RvOsPIbisZjRD0g1hAYMtIblIMCfo0cp/hkiPwSR3rjfeXAQfT/BckC+yOc/97HcEki/BszeDT5yq/IOHb2hCN1GoC8EZkhTmDACE08lJgw8H067+1ZAL7n2ixSVsw42cq4VbLOW8GUNNO9DSEdmMveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607922; c=relaxed/simple;
	bh=5ZVjSwAfJsPd+QkXMr9nZIk7lyTzPslSdY9PUohFIoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gdEX69+vjjEbCPN2LbIF+wUMDdVtNBc26K4To/nP6hkw51dK5htSEDW9zqHN8maed2yLl/HHlgxqeL6Ilyj5tBUD6XLUFeTMybbb4pxfBYcNgP0J2lAKWpIDUvTHSurr/6ysyc2CMx5sJFsmLIo4xo9oVDYgxP8P2n64dadCZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy5Si5xR; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy5Si5xR"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e4b34f2455so2856399a34.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 19:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709607920; x=1710212720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GO37OSQRQXlN2VGFyW6LzwjH/NpS/PSzwjkGcO70oKE=;
        b=Vy5Si5xRsbpFzCRuiXEp+ZJv2EceCxMmgm268nuwJpgFlaukFeKkwTr6/H9QMJ6mdV
         aaD1YgQ3SqgXaIRMLnc1ao0yjb0gORz0ufl1gtVKV0oqur+cSijtKBU3yCJYRGX+aBKz
         L9u74BhtHhe2fZxJDLYOYrQsNS07ryUY5ei8RBjDkRTK5vhNdujl0xiP0uRd03wK5UuF
         ne2QIC19/wkrwpDTapVu+whRm8EzmZs/sMzwq7fAjs4MePM0CFAmyEbVxE3xUjnjYMyW
         XDpaeIxiKiJppTDOUftNVUmFEwNYDOzSb7nnVKHFHR1GDTKPutuaqfFkV9jhsOw8u/PW
         sV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607920; x=1710212720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GO37OSQRQXlN2VGFyW6LzwjH/NpS/PSzwjkGcO70oKE=;
        b=u6L6NAyk2sHdhL763KdtFGZFSraNsqYsWRF+ravJWS87vTDkXBwB1RPMLMpXboEKUq
         +b9blWTcdcAy63FsbZt4F+VWlapI1cAQsD5Mvd1D5XEP2qig5TSbqNqH9ACfVlkNAY/Y
         NfbEaRzKHc6cAqFqfe5CD+twJat7EGlSiiOddDoWppM7uCWL/jQrE6F9utZoD2+MFuCp
         iyuBsudugMCP/impK+AQzW7WbWKBm20IvuN/MU2PulK1sL82AwqVzMyeh9e44jFfpgHi
         Rgy+q/vRBfp+PoVKpgiajcgcy/4jiT6t/UgnutrIdGOaU+mdvVDR+BKOd9Gdn8yRrNng
         GZwQ==
X-Gm-Message-State: AOJu0YxGB+awaFC/LNj2gZjQhhXGjFsSqFBeWy9npjMB9huEETQ73D5E
	4O+ppWYsQA313N/fRW6y71uHhnA/8m3N+SP+OFoKDAf+neiF7iqG4r3NImjv
X-Google-Smtp-Source: AGHT+IF4DC0r95WIbRC/5og05/9WKTnTnsPpk3e37OmDlc5CQCogzBPB5agJQ7Ifv5VhRu3af2p6Pw==
X-Received: by 2002:a05:6870:898f:b0:220:99bf:c26d with SMTP id f15-20020a056870898f00b0022099bfc26dmr589777oaq.9.1709607919882;
        Mon, 04 Mar 2024 19:05:19 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:9426])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7854f000000b006e5a99942c6sm6822695pfn.88.2024.03.04.19.05.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Mar 2024 19:05:19 -0800 (PST)
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
Subject: [PATCH v4 bpf-next 0/2] mm: Enforce ioremap address space and introduce sparse vm_area
Date: Mon,  4 Mar 2024 19:05:14 -0800
Message-Id: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v3 -> v4
- dropped VM_XEN patch for now. It will be in the follow up.
- fixed constant as pointed out by Mike

v2 -> v3
- added Christoph's reviewed-by to patch 1
- cap commit log lines to 75 chars
- factored out common checks in patch 3 into helper
- made vm_area_unmap_pages() return void

There are various users of kernel virtual address space:
vmalloc, vmap, ioremap, xen.

- vmalloc use case dominates the usage. Such vm areas have VM_ALLOC flag
and these areas are treated differently by KASAN.

- the areas created by vmap() function should be tagged with VM_MAP
(as majority of the users do).

- ioremap areas are tagged with VM_IOREMAP and vm area start is aligned
to size of the area unlike vmalloc/vmap.

- there is also xen usage that is marked as VM_IOREMAP, but it doesn't
call ioremap_page_range() unlike all other VM_IOREMAP users.

To clean this up a bit, enforce that ioremap_page_range() checks the range
and VM_IOREMAP flag.

In addition BPF would like to reserve regions of kernel virtual address
space and populate it lazily, similar to xen use cases.
For that reason, introduce VM_SPARSE flag and vm_area_[un]map_pages()
helpers to populate this sparse area.

In the end the /proc/vmallocinfo will show
"vmalloc"
"vmap"
"ioremap"
"sparse"
categories for different kinds of address regions.

ioremap, sparse will return zero when dumped through /proc/kcore

Alexei Starovoitov (2):
  mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
  mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().

 include/linux/vmalloc.h |  5 +++
 mm/vmalloc.c            | 72 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 2 deletions(-)

-- 
2.43.0

