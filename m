Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3326ED3C;
	Mon, 27 Apr 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302949; cv=none; b=rPsSmY+B+0zyB9VcCJdMCK/mBqJERrhIUe2BtuiLQngh4sy/QXvk70ZHNSRDZoo8Eg2Y9MixAJkMYBnxX3UaZLFhTows45f3Rnk8Prnp+pKxxUDjGvV8dDHk6BF6gFaZr8t7zASeN7oA1GLRnkIsyiucOs7+3CHVm4fPVZx9aG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302949; c=relaxed/simple;
	bh=2g2Ht+R7i6Ddhhl26w383Z9dWKZP676lbBJ41SKulBc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ShL2YNSDBEvfTkIXd7zb6/m4HP9PAMK9ncm8N2K879ErCIUFQP62/QRcgg4XtlTBdE2B8NRbnlbnEIc+T1hV6xJmJh+O3u80BvtjFFs3CXeXy6/UMdlZFZaER36XaVWim7dakjb9XgT9xBpZy9ZahfJuzhm2SPrJC5GypySW8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R526EK8v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R526EK8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B37C2BCB9;
	Mon, 27 Apr 2026 15:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777302949;
	bh=2g2Ht+R7i6Ddhhl26w383Z9dWKZP676lbBJ41SKulBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R526EK8vILjVTNN7jaw1ZW3M5wmU3lWJIWC2UAqZGdzcGbCXVqzY8BPvWTyJFDcuT
	 /uHug+eKdsFXFaHsGa9xQkEz9IOx1++n6CcBN3gt5oEMVnkiugAHx0KYMnDu0xO7B1
	 oR9tpmEpHiWy3sL8rKUS+kaZbyTo6TbmLbXF8r44=
Date: Mon, 27 Apr 2026 08:15:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel
 <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Jann Horn
 <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett"
 <liam@infradead.org>, linux-sh@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, linux-mm
 <linux-mm@kvack.org>
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
Message-Id: <20260427081547.4cdbb9a5cade734f143902f0@linux-foundation.org>
In-Reply-To: <CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com>
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
	<20260427-page_mapped-v1-2-e89c3592c74c@kernel.org>
	<20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
	<CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 16:00:59 +0100 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > >
> > > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > > ---
> > >  kernel/bpf/arena.c | 2 +-
> >
> > BPF maintainers will probably want to carry this in the BPF tree.
> > That's fine - please go ahead and add it.  I'll carry a duplicate in
> > mm.git so it compiles.
> 
> We cannot carry the same patch in 2 trees.

Git is fine with that.

> Sooner or later it will create problems for linux-next
> and issues during merge window if more changes
> are done in the same area.
> The only way to share a patch between trees is to
> create a stable branch and pull it into 2 trees
> then sha will be the same,

For a single one-line patch?

