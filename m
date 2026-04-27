Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E130FC33;
	Mon, 27 Apr 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290215; cv=none; b=GcLAxkxERLRMd6HYzPXpcLM1Wb/wG+SYIXAupHjMyRw/tL4FP4VmUnrUcUzyvQNTy2vJ3aOJ71NoDPzDCuIE4BwlaHslNvEXQvtoyghwMyUJb34nPJynDTtmLL8wNuZd3YCOaowV5ItbdR6+NVK9tR1gi+Q/EJOaKjMFOkFkw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290215; c=relaxed/simple;
	bh=EDbnBx17zS3xFZo6r0KM+PlWBWkB+tisTjXCa9SljeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ey1LA+Wzuf+F+dYtMoVC+eTLbSlvNqNPa6DDzSvq2R7z/Ovl4hGLeq7jIWW64PQHFdHMDXT4lwrpuh5BjJcq6ieJz48LuszsRMrXr+NEXiVhU7q3N+T5GdjLXCSTgJ/WNtqih72Mz0FoxXjBppGoXYDTLnG2Eu934MJ2jzCL91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt5VYUaV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt5VYUaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6E3C2BCB4;
	Mon, 27 Apr 2026 11:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777290215;
	bh=EDbnBx17zS3xFZo6r0KM+PlWBWkB+tisTjXCa9SljeA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bt5VYUaVeiMKMvtp4PJnzxTzkhqzQtitzwOIBd7dGufTGpQdLZr+l9UI1u+wF94vZ
	 przTAXUDjSXZPITU2w5TMfx3urPPrN2uaiYEtWIF9DjELA4Uo/uf8PsTFUWgRtk5LX
	 X0Tq72uYHSKXbMiDinApxr7tyK/bgleYGU00D4DUxXtibOPcIFwE2jplS5S2nZDGIK
	 XRVMUEoijnNXp9mPoWTjnEMg255JfJaljHDsj3uyF1ELYKZ7odNNG4Aagw/7Haj+R6
	 zJJwmbPgkWWz/pFJma/i3UPApAxVDSoqoNCCo1sapUQt7ORtmpSkrNmzr8PZw5ngTz
	 XgCcm4nFpIUgw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 27 Apr 2026 13:43:14 +0200
Subject: [PATCH 1/3] sh: use folio_mapped() instead of page_mapped() in
 sh4_flush_cache_page()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-page_mapped-v1-1-e89c3592c74c@kernel.org>
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
In-Reply-To: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-mm@kvack.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

We already have the folio in our hands, so let's just use
folio_mapped().

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/sh/mm/cache-sh4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 83fb34b39ca7..8bc9ce541c14 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -248,7 +248,7 @@ static void sh4_flush_cache_page(void *args)
 		 */
 		map_coherent = (current_cpu_data.dcache.n_aliases &&
 			test_bit(PG_dcache_clean, folio_flags(folio, 0)) &&
-			page_mapped(page));
+			folio_mapped(folio));
 		if (map_coherent)
 			vaddr = kmap_coherent(page, address);
 		else

-- 
2.43.0

