Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636B4E50A2;
	Mon, 28 Sep 2026 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608070; cv=none; b=thUWfLQxGioGjlbwnwVf+/c+NDaTsoMQ6t4NZKUpwmXA9mqTiML5TtiXv4WW+DaFpEoqbXqXOtLHLp/gw15mpt7JDeYZEllJ/hEDINuG2XYcCG4PRQHhTwNAGUk7ZER9pJtRdLWtFiCugSehNgV9IIRG4FqsXxxI00/7vpu5YI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608070; c=relaxed/simple;
	bh=q/s2mZEHt2DGwlnz660WM5+D7f5eRSUtCP1K9EZuyQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM9BATpmvZrbAxxFmms6DBWUG52opwejlf84ze+3Etstvi5u6FKCh9uiPX0+4wz4R5lBSvTvvyEbkDfKEJqtF1D+/ixLzMes7yVEq2hnO1xlB2WTtpDbHyUIwunUhOt2vgV6EZ8UGm1bgt6ZVJ+4NScyzWaXxApGwr90PN4kI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlu3LGbo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlu3LGbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDB71F00898;
	Mon, 28 Sep 2026 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790608069;
	bh=q/s2mZEHt2DGwlnz660WM5+D7f5eRSUtCP1K9EZuyQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xlu3LGboDX64NscvV/kv5RDmDKtw5hFkym4749XW0rB76t0MhOY6zIXf3/kEjIzti
	 7/zdSJ8qF2n2Z9Gk3d8RJXa8QPgAvTKP793Aqqw5DkuuWE3cb+U5JT8yAxzkHaGAt6
	 2K2YNPm2oeJTnEg1+MbNTF8ykHGi9FrliXYk0msRzhrjh6+kYjEk0/PCkhC84RYYrs
	 PyQPUrRsiljA9gItcD165EnmnYScUzzxuLDg0a3duJUImfG+UfmwhsNICpY94vIyhh
	 S8UrqFmwdmqxizKbb/CaWz415A7DQg225fWAXMsbmir9ddCUwlS6EzTbv05G+muDKS
	 OZniCI9+0cvRw==
Date: Mon, 28 Sep 2026 16:07:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: akpm@linux-foundation.org, bpf@vger.kernel.org, liam@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/nommu: Reject wrapping ranges in access_remote_vm()
Message-ID: <arqCtS_MB2Ee3-44@gremlin>
References: <arZzn0bwWqp7xTE5@gremlin>
 <20260928150446.36873-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928150446.36873-1-tasos.papagiannnis@gmail.com>

On Mon, Sep 28, 2026 at 05:04:46PM +0200, Anastasios Papagiannis wrote:
> > BTW always feel free to nag if you're not getting review! Something things
> > get missed. (Though I'd say wait at least a couple weeks before doing
> > that!)
>
> Thanks! To be honest, it wasn't clear to me that I should take any futher action
> after I received an email that this patch was added to mm-new. But after reading
> that email again, this seems to be the case. The patch is still open for reviews.
> (Sorry, still learning how the process works..)
>
> [...]
>
> > Seems reasonable to me! So:
>
> > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Should I now send a v2 with those changes? It seems that these are already applied
> in https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=1b721712d07e831686de53efc667561985897956.

No need, Andrew['s scripts] already fixed up thanks! :)

>
> Thanks,
> Anastasios

--
Cheers, Lorenzo
