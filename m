Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1F383C7F;
	Mon, 23 Mar 2026 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306259; cv=none; b=cTVBQbXUTBwqxpQfL8gDRMdPCQZ40MPEkk8D/L7pACOFxFWGl2TqXCvGCuUVAhSxwpoRwtKXxKwHmCzoAAttieCV9g4FCVYbJhb+R1m/tooKs6WUZZmdushmFXCHxzcxJ+M5lELa3OhyL9vmt/x7S+fWMh5vc6wy3CmqDloTs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306259; c=relaxed/simple;
	bh=iM8xi+g7eJ2LFfiOb87u1NfLeTFkw/SR9m4C+FJUB4E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cYDrVjS+RAMkdJLYWeX2oOCsz1P5fERSHxjjzA9JX4ECkHipWp4k/9iyc/F/jKt19sGnT1Ac0IIMHHPBRGnlt7gSbUN1XGfV/Le6bHy+ysaWkRTVFDOvQl7CIKUKCxwqsQQw+nfL61nK3QFhZgyJFSKWuK/6JyQQirlmOaSm9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=no2U1SRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="no2U1SRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F7FC2BCB6;
	Mon, 23 Mar 2026 22:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774306259;
	bh=iM8xi+g7eJ2LFfiOb87u1NfLeTFkw/SR9m4C+FJUB4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=no2U1SRCbCx+YwOea+jmKOmJACmet5hnyb2IKo4hHES+gDnQsL9Mqe5fn1AYbROPB
	 6xce46J5W3z7K7k+XhCtnsd3zXSpWWfNLKnhyZM7RnDsE3pHkfUZlslfXZa8qrzC3F
	 /m1O+7ZTV5VkLQzEFIRjwi1qIrhRLH1r3C2x/4lg=
Date: Mon, 23 Mar 2026 15:50:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Petr Mladek <pmladek@suse.com>, Alexei Starovoitov
 <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Gow
 <davidgow@google.com>, Kees Cook <kees@kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Helge Deller <deller@gmx.de>, Randy Dunlap
 <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Juergen
 Gross <jgross@suse.com>, James Bottomley
 <James.Bottomley@HansenPartnership.com>, Alexey Dobriyan
 <adobriyan@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Petr Pavlu
 <petr.pavlu@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] kallsyms: show typed function parameters in
 oops/WARN dumps
Message-Id: <20260323155057.29b8e17d10421962d5ed798d@linux-foundation.org>
In-Reply-To: <20260323164858.1939248-1-sashal@kernel.org>
References: <20260323164858.1939248-1-sashal@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 12:48:55 -0400 Sasha Levin <sashal@kernel.org> wrote:

> Building on the lineinfo series, this adds typed function parameter
> display to oops and WARN dumps.  A build-time tool extracts parameter
> names and types from DWARF, and the kernel maps pt_regs to the calling
> convention at crash time.  When BTF is available, struct pointer
> parameters are dereferenced and their members displayed.

mm.git is full and I'm seriously looking at loadshedded.  Can we please
leave this until next cycle, give your "kallsyms: embed source file:line
info in kernel stack traces", v4 time to settle in?
