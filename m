Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B01C3BFC;
	Mon, 18 May 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121859; cv=none; b=F0fzkyDhjTbk5ofL1aSA3gdfrLcmqcg8iLwo2iJDXXUXrAPOCxjmdP28A6lkHf0cL9+FNpJvzlTQXiEWgdEb4OW4nNZZDPSt8lem9Plav0zJklaiIOq/RBaLbPjdATJC0PnME4QtHXPzksLj9UHdIW1VtY/Gbvr8QANVMH14hU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121859; c=relaxed/simple;
	bh=+PTmja8+AgNpMmpGslzHwo+0HOnMtHat4+Ks2iA1G9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+4NhnW7eDH3ZVKTXPfT9irRK+dRmpIHQ5qJ7mdjgCUrB24UWCZiOzDcdvxjDouLyBZYn+cmZWOACxBzygbrEQICW3XzPuC9MabIfMZf+VIzi3LdBO+0n98vzGk92d3PqxBWfINGStpLOWYfNWzIV7VTg8wAfn39KZhg5X/ikIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivtf+DL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivtf+DL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8126EC2BCB7;
	Mon, 18 May 2026 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121859;
	bh=+PTmja8+AgNpMmpGslzHwo+0HOnMtHat4+Ks2iA1G9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ivtf+DL7HEjti6wWPWoKRQCBLB81JfXkGedkxlUvoKpotGvAIoz+N8u5VpXUZTHu0
	 95KrA7cVCDGsRbdsiCB/qbJYh9gQru2MvBihledJZ1XrmH0bZjClhEk2LmCtL17i3J
	 NtIMyhfTys5+mebfUs2Pt5U/MEHrQ+bIbbKGoD6POOf2I7cgKYSt6SZ2NH72j8nKNJ
	 tmIGTBC0j7IXOku9O+g9bfq/Vh69ZGwgrsNIBZXxrUGSgCSpz2IYNJCSayFpgYmums
	 WNyhlUzB8BNArZQrcPVcuxp78whYkp3Pf1WB2MEHoHzyO0lsJOnWY4mS7s5ygCFspO
	 3UrYlOYkiNdnw==
Date: Mon, 18 May 2026 12:31:12 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev, Indu Bhagat
 <ibhagatgnu@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Dylan Hatch
 <dylanbhatch@google.com>
Subject: Re: [PATCH v14 13/19] unwind_user: Enable archs that pass RA in a
 register
Message-ID: <20260518123112.20da820b@gandalf.local.home>
In-Reply-To: <bd711f74-a1f3-4410-975b-64e9009aaf30@linux.ibm.com>
References: <20260505121718.3572346-14-jremus@linux.ibm.com>
	<20260505183531.C9EE8C2BCC7@smtp.kernel.org>
	<8761b037-d8f8-4142-9091-cc51d0d19df8@linux.ibm.com>
	<bd711f74-a1f3-4410-975b-64e9009aaf30@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 18:16:52 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> >>> +#ifndef unwind_user_get_ra_reg
> >>> +static inline int unwind_user_get_ra_reg(unsigned long *val)
> >>> +{
> >>> +	WARN_ON_ONCE(1);  
> > 
> > Replace with the following to resolve below issue:
> > 
> > 	dbg_once("unwind_user_get_ra_reg() not implemented\n");  
> 
> Omit or replace by the following?
> 
> 	pr_debug_once("%s (%d): unwind_user_get_ra_reg() not implemented\n",
> 		      current->comm, current->pid);
> 
> This did not work with dbg_once() defined in kernel/unwind/user.c as
> follows, as linux/unwind_deferred.h includes linux/unwind_user.h and
> therefore gets included into other modules that do not define dbg_once()
> (e.g. via linux/irq-entry-common.h including linux/unwind_deferred.h).
> 
> Steven, Should I omit the dbg_once() or could I replace by the above
> unguarded pr_debug_once()?

Question, should the above ever get hit? That is, should all architectures
that support sframes have unwind_user_get_ra_reg() defined?

How can this be triggered? Does it require an architecture to implement
only partial sframe to trigger?

If the trigger is due to an architecture not supporting sframe correctly,
then a WARN_ON() is appropriate.

But if this is not implemented by the architecture for normal reasons, why
bother printing anything?

-- Steve
