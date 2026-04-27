Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D973C4574;
	Mon, 27 Apr 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296099; cv=none; b=JF6UDPiiT/b+6n0s1sP+3mWzh5JXEQ6dnqx0uRcbsT2WoXKHkTaOUWdbIu8A00kH7B1RWbRhjnxBVuJY+gODctsPwlTdhBoAm667PBQHXCJe7iFPbtRfi2TO0VdbudVXsd7BcoG1BdM1WjMtafrGOIJoICioSQXydhQAV91QkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296099; c=relaxed/simple;
	bh=avnmxeCZBiKgCC8aIsqG0WKzjB7wlRqMwF6cWUdd2Tc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RUdtz/2U4T8GJq4xhBKuo0x5iRHL2vCtbMqfZipPPhQsjIyRcXBxUx4f4i9d8+8SwzCnaTuwximriV1qXpofz7LAxcXHe+cnzQ/gVbGOzv2eRJG419puD3ccG7dBirLqy1bwC7Qfbh68B52jav5vLdJdmnRJWaUjVWuqIX7qvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jta2gwrx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jta2gwrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FD3C19425;
	Mon, 27 Apr 2026 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777296099;
	bh=avnmxeCZBiKgCC8aIsqG0WKzjB7wlRqMwF6cWUdd2Tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jta2gwrxlY2QHojSmCJf9P4jLAr70WOBILfb+lh+rXNGa1UpXXkr/VRPikeBQysMO
	 Qyf7w0lBec3pCEdMAYYTbC+r7EU253H8Gdz6eRUbgs/c+8a8UX7bEVATx5E8EtzFSB
	 lnSnmboxhJ65EPM4QNGcDg4UoEMKG2TB3SV/eN8M=
Date: Mon, 27 Apr 2026 06:21:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel
 <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Jann Horn
 <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett"
 <liam@infradead.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 3/3] mm: remove page_mapped()
Message-Id: <20260427062137.48739e6fa6e550f1f0e8ff48@linux-foundation.org>
In-Reply-To: <20260427-page_mapped-v1-3-e89c3592c74c@kernel.org>
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
	<20260427-page_mapped-v1-3-e89c3592c74c@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 13:43:16 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Let's replace the last user of page_mapped() by folio_mapped() so we
> can get rid of page_mapped().
> 
> Replace the remaining occurrences of page_mapped() in rmap documentation
> by folio_mapped().

This broke Breno's "mm/memory-failure: add panic option for
unrecoverable pages"
(https://lore.kernel.org/20260424-ecc_panic-v5-2-a35f4b50425c@debian.org),
which added a new page_mapped() call.  I made the below adjustment to
Breno's patch:

--- a/mm/memory-failure.c~mm-memory-failure-add-panic-option-for-unrecoverable-pages-fix
+++ a/mm/memory-failure.c
@@ -1353,7 +1353,7 @@ static bool panic_on_unrecoverable_mf(un
 		cpu_relax();
 		return page_count(p) == 0 &&
 		       !PageLRU(p) &&
-		       !page_mapped(p) &&
+		       !folio_mapped(page_folio(p)) &&
 		       !page_folio(p)->mapping &&
 		       !is_free_buddy_page(p);
 	default:
_

