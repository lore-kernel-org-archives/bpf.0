Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960EF3112BC;
	Mon, 23 Mar 2026 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306683; cv=none; b=ltN0xOo8wmOkekaF6lobGAYt7IkzwZDgAxsVnZkaFE47AiG+BadNqJJrAl570Npjgm3QIAi494WLltqT2T3AdfOOLTaPwU0F+5DL7m9x3T1kCeQcRBN82cu6Z1rkiJhS7LYGOw3IbuzTDI0yCkHdqisWz0vSlHhrCRjpphQthuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306683; c=relaxed/simple;
	bh=EiNat42VuczjsdffLBCVZQ9x3qS9l3P6OlVBuRMXo54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5kBgT1kB1zgBbMUgGC/L3FXtLw6ixgBZFce9umz+9j1yynM0zE7rT8BSacjQq6tldRh0hAoumKhDvaSVeKPwiGmvA9zVwsCQZroyc3ZgwIMneoiGDbkQbEH8oO07fHdieuzpTM3vPjNfrw3ud2do8Qf6FuFFB4P7sf3ZHgZ3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV9CkoFD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV9CkoFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A7AC4CEF7;
	Mon, 23 Mar 2026 22:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774306683;
	bh=EiNat42VuczjsdffLBCVZQ9x3qS9l3P6OlVBuRMXo54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WV9CkoFDBmBIU6xtzEagghBdFHHY+EtZfn9qhuFP6Xufv2DTDU2/nu4VLTGSukXLw
	 lQK7Skxq+8G/QLkY/NmSNRdmYoNLUw4OO3XcKER1sKYtutpIrH1s0EHnPPUAr9/LBL
	 t+4+jkF1QIOjUlUMkKjxT2ieEGx2f8nxRLQm/GHFlsYBFLUodmJBFwO9GCuUpe0rn0
	 rLe3WMYsTOs2bqTz1bP224rxJNrmAm7S6vHDlQWP2y5v1nSJQtz8hsDmYKQdKNQ3kg
	 b/ez1GLrwyd0j7q06Pu2Ca9DrdwW5QEj3tawZlMXArqwlwE9yxsaryb9KUyTbUuL/U
	 BBCJeNlNQFbuA==
Date: Mon, 23 Mar 2026 18:58:01 -0400
From: Sasha Levin <sashal@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
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
	Vlastimil Babka <vbabka@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Petr Pavlu <petr.pavlu@suse.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] kallsyms: show typed function parameters in
 oops/WARN dumps
Message-ID: <acHFeaE8QRV2NJzB@laps>
References: <20260323164858.1939248-1-sashal@kernel.org>
 <cdd61497-8d50-4fc5-aec8-47286e23d537@p183>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cdd61497-8d50-4fc5-aec8-47286e23d537@p183>

On Mon, Mar 23, 2026 at 09:43:59PM +0300, Alexey Dobriyan wrote:
>On Mon, Mar 23, 2026 at 12:48:55PM -0400, Sasha Levin wrote:
>>  Function parameters (paraminfo_demo_crash):
>>   uts      (struct new_utsname *) = 0xffffffffb8ca8d00
>>    .sysname = "Linux"                        .nodename = "localhost"
>>    .release = "7.0.0-rc2-00006-g3190..."     .version = "#45 SMP PRE"
>>   file     (struct file *       ) = 0xffffa0a3c250acc0
>>    .f_mode = (fmode_t)67993630               .f_op = (struct file_operations *)0xffffffffb7237620
>>    .f_flags = (unsigned int)32769            .f_cred = (struct cred *)0xffffa0a3c2e06a80
>>    .dentry = (struct dentry *)0xffffa0a3c0978cc0
>
>Should this be in crash's format?
>
>	struct dentry ffffffffffff0000

The format currently used comes from the kernel's own BTF show infrastructure.
                                                                                                                                                                           
crash's struct dentry ffffffffffff0000 syntax is specific to crash. drgn, GDB,
bpftool, and the kernel's own BTF rendering all use the (struct type *)0xaddr
notation we're already using. Adopting crash's format would make this output
inconsistent with all other BTF-based output in the kernel, and would also lose
the member name context (.dentry).

-- 
Thanks,
Sasha
