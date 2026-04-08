Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059735F18D;
	Wed,  8 Apr 2026 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634987; cv=none; b=rzkbA69RCUcPnFP+dFCvOOWnUkL8DMzb5+knZHpOUrKAD298gXOJyQtv02WgKHVjgVlPUf9CX05vBac2pFOUcRJH2eu8+oMM69qx9wKk6ZSUOIwSxccQ4MnNuiDf2SCg07TBrdS5+fgXAyRblBcJgE7jv1NWgem5bE+TlGY2Z7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634987; c=relaxed/simple;
	bh=Dar/K01na4HTQ6TmyAp8EMU2RNwVCa/vzxkbUTWrWIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrBHJdZa+IuD/AzAwMrcsZlMfUHCxBtYHd+ruzF6xqgPRHL96B5qnduZPA7Bzu7SEchIWwGLx+dkoaFzfu7eEzKkXvhvj4lsZJb3ToJbx+s8lhP7Z2B3mqj/JtlETcLkcf0odK1ixUOSG/S80tugp/oY3wMkbTeTNQuHD6iMEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jGBdC/ID; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jGBdC/ID"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=InJ065M2V1M1TwUEYbBAuEDj4qhd02eeaGNZhQny8xs=; b=jGBdC/IDRwsqahL+I+nGmelIRS
	CaIYPToZNByUoVNpBF66csYGfxJ6zwe3wilcLFYwydbhS/ePjxpyhN5BADKTnTKUXx99TjpYGrt/N
	I0IdI+ALm2IVIRVnfP8L+/rnabzy/NYV5j1Gwz5OzLYl2exglm+XcTxKGnadgp12jjwwq3N5n4OZ0
	2rViAiVu49prfLJFPidNyrlYUuOn1nvbhDFwqohL5IArbbWtbK6TbQ9SMrDBSSEEXlHlmx0sxql8M
	ZXpEjKPb3ktxbi+OUnf8G2KiY7gMFRbso/4o/nXsexaw7znoIcm++DaZpp3gqUx/bc7wcMqnSnSqz
	Ti8o1Pgw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wANlu-00000009b87-0Wfw;
	Wed, 08 Apr 2026 07:56:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEBF3300289; Wed, 08 Apr 2026 09:56:20 +0200 (CEST)
Date: Wed, 8 Apr 2026 09:56:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	bpf <bpf@vger.kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
	Abhishek Dubey <adubey@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: bpf/selftests: test_access_variable_array breaks due to
 sched_domain::span removal
Message-ID: <20260408075620.GJ3738010@noisy.programming.kicks-ass.net>
References: <3e129be5-d61e-4bc4-b691-8d69e2f58de6@linux.ibm.com>
 <CAADnVQ+wZgucXKf5ZFNeSMcgARQVsQ7knVctf5R2GOGDRSEagA@mail.gmail.com>
 <adXe4gNBihTOyIjQ@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adXe4gNBihTOyIjQ@linux.ibm.com>

On Wed, Apr 08, 2026 at 10:21:46AM +0530, Saket Kumar Bhaskar wrote:

> We do have cpumask as [] array in sched_group:
> 
> struct sched_group {
> 	struct sched_group	*next;			/* Must be a circular list */
> 	atomic_t		ref;
> 
> 	unsigned int		group_weight;
> 	unsigned int		cores;
> 	struct sched_group_capacity *sgc;
> 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
> 	int			flags;
> 
> 	/*
> 	 * The CPUs this group covers.
> 	 *
> 	 * NOTE: this field is variable length. (Allocated dynamically
> 	 * by attaching extra space to the end of the structure,
> 	 * depending on how many CPUs the kernel has booted up with)
> 	 */
> 	unsigned long		cpumask[];
> };

For now. But given how utterly broken flex arrays are, this thing will
be gone the second we run into that same thing again.

> Wouldn't be good if it is used as:
> 
> cpumask0 = sg->cpumask[0];

I'm thinking Alexei's point is that this test should not rely on random
kernel code.
