Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB82383C91;
	Mon, 23 Mar 2026 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307319; cv=none; b=LzRjQ6hn1sgfv+E/De5I7an1z7Tp7S0Hbk+rbOSm2UEDzdDEg/CWKHhy0J04Lzu/Flgx8DCgy6tkOpRUEMU9if3Y5mvB9n8FERunRzAEiL0P5WM29H6pZMjUXHDm4mrtlGhIUE8yd4Qx0QwPgAr26zqaLo9TbCJLmscbFtGdzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307319; c=relaxed/simple;
	bh=QZsMsvR13u7mGUfeohJ5fuf7LXsBGE670IWu7suugwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyGgOrnD4Q40b7/4ZmmjmTKULO4NHHVQgAo292r6LvYexuB2pFcW6ZUlwkNroUxkxr3nSOEq9zGnIMNs9U8VHcpxJzUMJCn6qv9XY0yK9M6aC1bj2MxdBz2xzA8GXBCj+xydTOG52Dow7FVONvzNPzEXvHlaKT4oVbnm6vu5nsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzJxpxtR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzJxpxtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44163C4CEF7;
	Mon, 23 Mar 2026 23:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307319;
	bh=QZsMsvR13u7mGUfeohJ5fuf7LXsBGE670IWu7suugwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzJxpxtRlf8LkiXpwQVnHzFlgmFsyVko/IvLG20g9ALGO2vG7D7k1kwlvURgY/o3W
	 DB61MKv5U+qbgd6zg2e/b/ZSNL8pJrxgMoWOOQJCcvRu/ulbr+F/fdBH6nIjYeyyL2
	 jqD5skdCjXcizXDcqcqzGdHApM/T8RTJXpH0t9g8kLtckxXyjRDkfMJMc6V+eRA9T6
	 TGLupWGTyCSH5OaKZYgoLTKbH/LezjqtAc8tl1su9BYhsVWgKrODPdiMIj4kC9DBRc
	 D9vhCA32a7/qtxw7DdgrmpOLPkpsqWJ//jDk9xR0M8st0MPjEasE0STMtVmpaThZkl
	 qy9OVo8MSqzXg==
Date: Mon, 23 Mar 2026 19:08:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Petr Mladek <pmladek@suse.com>, Alexei Starovoitov <ast@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
	Kees Cook <kees@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Juergen Gross <jgross@suse.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Petr Pavlu <petr.pavlu@suse.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] kallsyms: show typed function parameters in
 oops/WARN dumps
Message-ID: <acHH9opwhQ3i18Et@laps>
References: <20260323164858.1939248-1-sashal@kernel.org>
 <20260323155057.29b8e17d10421962d5ed798d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323155057.29b8e17d10421962d5ed798d@linux-foundation.org>

On Mon, Mar 23, 2026 at 03:50:57PM -0700, Andrew Morton wrote:
>On Mon, 23 Mar 2026 12:48:55 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
>> Building on the lineinfo series, this adds typed function parameter
>> display to oops and WARN dumps.  A build-time tool extracts parameter
>> names and types from DWARF, and the kernel maps pt_regs to the calling
>> convention at crash time.  When BTF is available, struct pointer
>> parameters are dereferenced and their members displayed.
>
>mm.git is full and I'm seriously looking at loadshedded.  Can we please
>leave this until next cycle, give your "kallsyms: embed source file:line
>info in kernel stack traces", v4 time to settle in?

Definitely.

If you want to ignore these, and related patches that might appear in the next
couple of weeks, I'll plan to send them to you in an organized series after
-rc1.

-- 
Thanks,
Sasha
