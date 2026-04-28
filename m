Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079033ADB9;
	Tue, 28 Apr 2026 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365855; cv=none; b=i7QiY1ck98WOIm9fIBO5XjbPllFa9gLtiWiAwP1U8LQNJ+4YmK/Gc3yx32V7/L6ob6qrD6Fldr1tMeZhKz6QX1KKJQtl/HILOtpMVJ9BVSXYJzviCoDQSZJOySK0ElvADZ7/b3xlxY9ZtpxGkCS0yCTHecapCvnMIuylRJQDjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365855; c=relaxed/simple;
	bh=yMSXc7aH8lsOC9DhmK3iD6MCAykaqWenDw41A4QK+rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXn8rBDyst1Lviv5veO38yQW05+4pGM75bBW+6twOwwahkEXDoAXvqCxMDdg+j+wCrmt0K1RM08z9+2GT/3IJTo/Sp9pB54a9Q02cJqum91V0nqQ469C0nCVtaQJBCW4i8eqvUL8QdBFsV8kZvdsnj2DrKDKQ7aaF3bMpH1wJUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2Uwil36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2Uwil36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3281C2BCAF;
	Tue, 28 Apr 2026 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777365854;
	bh=yMSXc7aH8lsOC9DhmK3iD6MCAykaqWenDw41A4QK+rc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L2Uwil3663RAVPzrHsG1iITO92pHRr0NbnlB8CCbCA1NWUA1xllzeBN1sNKNrcb9D
	 YJPEaayeukzAMh0iX4cR2pCid+jxETJUrV/EZ4cT73E9ODzXtXqBpwST67/1zQz2Ve
	 V+ezBwuEH4jhne7Zz6l5SidpD0jxAgY0n52iythXyWiKs98PSEsDlgyshSiTZ9izds
	 QM8yTldC9W8tSy/8P9Lm0d1r557rD+i7cv0EPHQvEdPWH4RSwVfKbDdEeDl8nOdV0Z
	 jIzKZ871PDXoBW1fSPbaQAN72yn5DnhTTVzjm9Y4hPJCrkn38ARi4/n4d9a7LY9gF7
	 qtgZpYsfDFw0w==
Message-ID: <9e2b2c8c-a03f-4c26-9039-ae64c848bc52@kernel.org>
Date: Tue, 28 Apr 2026 10:44:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>,
 "Liam R. Howlett" <liam@infradead.org>, linux-sh@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org>
 <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
 <CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 17:00, Alexei Starovoitov wrote:
> 
> We cannot carry the same patch in 2 trees.
> Sooner or later it will create problems for linux-next
> and issues during merge window if more changes
> are done in the same area.

Agreed.

> The only way to share a patch between trees is to
> create a stable branch and pull it into 2 trees
> then sha will be the same,

Yes, but...

> but mm tree has its own way of doing things,
> so this patch needs to stay in mm only and if no one
> should be touching adjacent lines :(

... this should also be fine even if that happens. Mark knows how to resolve
(and report) trivial conflicts in linux-next, and Linus AFAIK also prefers
to resolve conflicts to other workarounds.

The shared branch would IMHO only truly be necessary if bpf tree itself
needed to base something off on this change; for resolving trivial conflicts
it might be an overkill.
