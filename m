Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC553F1676;
	Wed,  6 May 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081772; cv=none; b=WNX7UxRSeoB5M2NZv3dsTrIlUfMSQvZMnfjf4n4qbxJ6JKuzuVMDa2ZVp6NbSnm45iFJ0SAbNIZgbXJOsMNBPAnt/OAzyOqcuO77VE78Zxd+x3/YdOpKej7rRTwckfOBEJHYxnZS/keEh4xBdSrUkxHxE7Z8QOhH0nbEjUHd/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081772; c=relaxed/simple;
	bh=YmH0VhuXg/cm69Ew1erWeLBAm2BbEeEYbjV9RLbDtY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWLy/nLcFSgwIeT3iJoOC4ydYhmM+ewTSv5IGlzX9Z1dvSAXOoJW5NRTqnqKv7p+AqyxFeMGuezF+BWgt6Cbsiqis4A/4IlPiqxg+HparY7vwF6Y4JglP0djV1//ReqVpP12RUEeQfCvs8pRa0On/1YWSnaUoUqXGU4tgU+f2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgGLuL/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgGLuL/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C575C2BCB0;
	Wed,  6 May 2026 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081771;
	bh=YmH0VhuXg/cm69Ew1erWeLBAm2BbEeEYbjV9RLbDtY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YgGLuL/rdElTLLmUrsoJpCGY6fCCK9Li+RQ5uwQAFrI4x35ENBSqbvjAXLlQcG65P
	 m2+x7WZNq/+WdZBGz5PzYYRSO7HDz90VqPds9OlL5qBTDYo+epCEhhIl9HHRvm4ksH
	 IEzRNWtcIfVteKMZdOYNRq7AeSjLRMDzxIphRlK3avhfrwDxl5mEZpDWnZVk3LtU/+
	 rchBxv/g5UEB/lNO61zeas2Ww8f484SzyV6a2E92rgG3It+p9xfnjVrQxCNUi/YKq8
	 VtGJphhuLf47W7KqXzBtFEiwAi2kIaVRcy8sMDcP5w6ZKB/8cnwtRkG/9UMzW8lBO1
	 4LLHRpc0SlJ5g==
Date: Wed, 6 May 2026 11:36:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Indu Bhagat
 <ibhagatgnu@gmail.com>, bpf@vger.kernel.org, sashiko@lists.linux.dev, "Jose
 E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v14 06/19] unwind_user/sframe: Detect .sframe sections
 in executables
Message-ID: <20260506113605.5df32968@fedora>
In-Reply-To: <29d28c6e-2909-444e-b22a-7429464056dd@linux.ibm.com>
References: <20260505121718.3572346-7-jremus@linux.ibm.com>
	<20260505125336.72A36C2BCB4@smtp.kernel.org>
	<29d28c6e-2909-444e-b22a-7429464056dd@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 16:56:01 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> >> --- a/fs/binfmt_elf.c
> >> +++ b/fs/binfmt_elf.c  
> > [ ... ]  
> >> @@ -637,6 +638,21 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
> >>  	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
> >>  }
> >>  
> >> +static void elf_add_sframe(struct elf_phdr *text, struct elf_phdr *sframe,
> >> +			   unsigned long base_addr)
> >> +{
> >> +	unsigned long sframe_start, sframe_end, text_start, text_end;
> >> +
> >> +	sframe_start = base_addr + sframe->p_vaddr;
> >> +	sframe_end   = sframe_start + sframe->p_memsz;
> >> +
> >> +	text_start   = base_addr + text->p_vaddr;
> >> +	text_end     = text_start + text->p_memsz;  
> > 
> > Should text_end be calculated as text_start + text->p_memsz - 1?
> > 
> > Since the maple tree API strictly expects inclusive ranges [first, last] for 
> > insertions, passing the exclusive text_end would cause the inserted range 
> > to cover one byte beyond the actual segment.  
> 
> Shall we keep the text_end and sframe_end is pointing past the
> respective section end semantic and just adjust the value passed on the
> call to mtree_insert_range()?

Let's keep the end exclusive, and add the "- 1" to text_end before
passing it to the mtree_insert_range(). I did that to get it working for
me.

> 
> > 
> > If an ELF binary has adjacent executable PT_LOAD segments, could the first 
> > segment's inclusive end overlap with the next segment's start and fail 
> > subsequent insertions?
> >   
> >> +
> >> +	/* Ignore return value, sframe section isn't critical */
> >> +	sframe_add_section(sframe_start, sframe_end, text_start, text_end);
> >> +}
> >> +  
> > [ ... ]  
> >> @@ -712,6 +729,19 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
> >>  				error = -ENOMEM;
> >>  				goto out;
> >>  			}
> >> +			break;
> >> +		}
> >> +		case PT_GNU_SFRAME:
> >> +			sframe_phdr = eppnt;
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	if (sframe_phdr) {
> >> +		eppnt = interp_elf_phdata;
> >> +		for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
> >> +			if (eppnt->p_flags & PF_X)  
> 
> 			if (eppnt->p_flags & PF_X && eppnt->p_type == PT_LOAD)
> 
> >> +				elf_add_sframe(eppnt, sframe_phdr, load_addr);  
> > 
> > Does this need to verify the segment is loadable (eppnt->p_type == PT_LOAD)?
> > 
> > If non-loadable segments like PT_GNU_STACK have the PF_X flag set, they
> > typically have p_vaddr and p_memsz as 0. Processing these segments would
> > compute bogus text boundaries and bypass VMA validation. If a legitimate
> > PT_LOAD segment overlaps with these bogus ranges, could its insertion fail
> > silently and break stack unwinding for the executable?  
> 
> Do you agree?

Indu or Jose?

-- Steve

> 
> >   
> >>  		}
> >>  	}
> >>    
> > [ ... ]  
> >> @@ -1242,6 +1276,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >>  			elf_brk = k;
> >>  	}
> >>  
> >> +	if (sframe_phdr) {
> >> +		for (i = 0, elf_ppnt = elf_phdata;
> >> +		     i < elf_ex->e_phnum; i++, elf_ppnt++) {
> >> +			if ((elf_ppnt->p_flags & PF_X))  
> 
> 			if (elf_ppnt->p_flags & PF_X && elf_ppnt->p_type == PT_LOAD)
> 
> >> +				elf_add_sframe(elf_ppnt, sframe_phdr, load_bias);  
> > 
> > Similarly, should this also check if the segment is a PT_LOAD segment before 
> > adding it to the sframe sections?  
> 
> Likewise.
> 
> Regards,
> Jens

