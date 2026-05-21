Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B41379C20;
	Thu, 21 May 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380414; cv=none; b=Nnyo+7J+d0FLdA87XnKN8/pQ7v2UwMDcOWtUJZvP+lYvgJJw+ZYEgMMts7lbjpootEzmjUP7DyLElNFRI14MMLAINiN7BHrRVa8tn17Z6Y7Jmo6uLtvRyvDZctkYWASQy4mDKHfZIiF7SZtIbh+9OhC1N489tNSYgqYpjj+A6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380414; c=relaxed/simple;
	bh=CZGNxW4c5rvD2a9Ms341KGzTyHeSf+CH9ZvJXzcqWJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zq3XjPvAl5i1OQxuYu5lvg2E/WMvCKip2akZOf+o6PuZ539ONxlRLNs+pfXHQxbzFwCOlB1DJCVOIfvSowUALaIBLaXI6Kh6v9vzi+b6UVCHfpW0b1jrT2gQMQfPRea0+rEUP+1uKwVyWcGDDuWua0lXyk5I4af/jei285Ij12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB1qvmg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB1qvmg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38701F000E9;
	Thu, 21 May 2026 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779380413;
	bh=JSaieM4EdAi9F9FDJSXysY+oN61h6IMYagfLi8JvNpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VB1qvmg8GhLpR4YDJMuDzZ1ESIAzYu0wje3R7Wl7jmgVg3JTKNaykOIn7vmvEubo+
	 GJ1NkZ29OXvIVMPYVfqb4CgWVjGHTlHGad7ud96bQfFQJWb5GKKbOcgmXy13TPlL4t
	 0WSrRd9uuRZXr2Z9RjIVPBZD7pLqHlVyHQO6K4RcVE6wWtytIsw2SKJq7t9tMM/MzN
	 hipdWlyJPEaFt1a1tqeokd8JQ6+9PiwK4YWkupQSpg3k31H626kwWoWHlzKkmrIGBq
	 +dhPUJaMqYsair+G0H6hk6EX/9FsxZzV6sC7ueq4Y4GImKtRKlVnMLOTG84z1x7hCT
	 Vzn3RtroXaGiA==
Date: Thu, 21 May 2026 12:20:33 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
 bpf@vger.kernel.org, Indu Bhagat <ibhagatgnu@gmail.com>, Dylan Hatch
 <dylanbhatch@google.com>
Subject: Re: [PATCH v15 11/20] unwind_user/sframe: Show file name in debug
 output
Message-ID: <20260521122033.4648359e@gandalf.local.home>
In-Reply-To: <17ef3fa5-d378-43da-9407-62fd1bba5d96@linux.ibm.com>
References: <20260520154004.3845823-12-jremus@linux.ibm.com>
	<20260520161405.AE1C31F00893@smtp.kernel.org>
	<17ef3fa5-d378-43da-9407-62fd1bba5d96@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 12:55:50 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> >> +static inline void dbg_init(struct sframe_section *sec)
> >> +{
> >> +	struct mm_struct *mm = current->mm;
> >> +	struct vm_area_struct *vma;
> >> +
> >> +	guard(mmap_read_lock)(mm);
> >> +	vma = vma_lookup(mm, sec->sframe_start);
> >> +	if (!vma)
> >> +		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL_ACCOUNT);  
> 
> Should vma_is_anonymous() be explicitly tested?  Currently an anonymous
> VMA is assumed as last resort (in the final else clause).

Yeah, perhaps it should be first.

> 
> 	else if (vma_is_anonymous(vma))
> 		sec->filename = kstrdup("(anonymous)", GFP_KERNEL_ACCOUNT);
> 
> >> +	else if (vma->vm_file)
> >> +		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL_ACCOUNT);  
> > 
> > [Severity: Low]
> > Does this code accurately classify file-backed VMAs?
> > 
> > Anonymous mappings, such as private mappings of /dev/zero, can also have
> > vm_file populated. Relying only on vm_file might misclassify these mappings
> > for the debug output.
> > 
> > Would it be more reliable to use !vma_is_anonymous(vma) to check if the
> > VMA is file-backed before accessing vm_file?

As stated above, we should probably test it first. Maybe even vma->vm_mm too?

	if (!vma->vm_mm)
		sec->filename = kstrdup("(vdso)", GFP_KERNEL_ACCOUNT);
	else if (vma_is_anonymous(vma))
		sec->filename = kstrdup("(anonymous)", GFP_KERNEL_ACCOUNT);
	else if (vm->vm_file)
		[..]


> >   
> >> +	else if (vma->vm_ops && vma->vm_ops->name)  
> 
> Shashiko AI review of v14 brought up that vma->vm_ops->name(vma) may
> return NULL.  Should this be explicitly handled as follows?
> 
> 	else if (vma->vm_ops && vma->vm_ops->name && vma->vm_ops->name(vma))

Maybe we could even shortcut it with:

	const char *name;
	[..]
 	else if (vma->vm_ops && vma->vm_ops->name && (name = vma->vm_ops->name(vma)))
		sec->filename = kstrdup(name, GFP_KERNEL_ACCOUNT);  


> 
> >> +		sec->filename = kstrdup(vma->vm_ops->name(vma), GFP_KERNEL_ACCOUNT);  
> > [ ... ]  
> 
> If explicitly testing for vma_is_anonymous() above, then the last resort
> would be something unknown?
> 
> 	else
> 		sec->filename = kstrdup("(unknown vma???)", GFP_KERNEL);

Sure.

-- Steve
