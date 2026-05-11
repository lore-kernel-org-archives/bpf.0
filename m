Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8893C2774
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520308; cv=none; b=BmgsA3GpgyZC49v29AbiHeuOH0FkrcdtfeO1MiqmtZljjwVyZazZfUylW7nlSdSn5eC5YFwCpAcYLbKyEBJSpJ1N3ByyID/2oOV8u4/FUDvjteWTGaU4GMe72ssCMPMIx/sYgKqXWqob2xesQchkrswxLPkmZbMXywO3Z2hqgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520308; c=relaxed/simple;
	bh=XwHumhvUbjsZZx6dX0d5ZstdJFk3Ok5F202wOZk2XuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7RsI4VNfAXLeTKIOn2UELfAnuB794xD2kii5At/8bLBnugr3MzOG/3gnwUzZoevY6sBIiaJHfDYcYIK+8kWX8uxgihf324TrXKbmwWkThTGU7h1WZq80pHofcONFx7DriYuhgwv465HGgvo4/o9KlbS2usqQmjnHIapP/cG4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nhu2x9AJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nhu2x9AJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778520306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0dxp9iONw+JdupNMyZ/eC2L/6iu9c7qz5ByFon435Y=;
	b=Nhu2x9AJSXi2Z4XgjBs5UEh0OAeiwdWsdXfarR5uU0yjN2+EXgzKoi50DMW1V7OJWDDBd5
	JCFt7QSI8JO2AWm29yXwE7GiqnmdnCVh+XN0ey4K5xtRqLJ0+2DyBxQxtmKrc5VI9tC24H
	kWCrN7alHrqRxdIXqpKxLzcNCCCXYhc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-3c79aWZ6Ms2jZID9URB2aw-1; Mon,
 11 May 2026 13:25:00 -0400
X-MC-Unique: 3c79aWZ6Ms2jZID9URB2aw-1
X-Mimecast-MFC-AGG-ID: 3c79aWZ6Ms2jZID9URB2aw_1778520299
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EDD1195605F;
	Mon, 11 May 2026 17:24:59 +0000 (UTC)
Received: from fedora (unknown [10.44.48.223])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 86F321800465;
	Mon, 11 May 2026 17:24:55 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 May 2026 19:24:58 +0200 (CEST)
Date: Mon, 11 May 2026 19:24:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, jolsa@kernel.org,
	peterz@infradead.org, mingo@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5
 optimization
Message-ID: <agIQ5WC66PwDxsvs@redhat.com>
References: <20260509003146.976844-1-andrii@kernel.org>
 <agHreV1m7MRKUtbh@redhat.com>
 <CAEf4BzZSSsUKGje1mOTOxrRxGfw4sVfyVmKrono1rOdDq1iFHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZSSsUKGje1mOTOxrRxGfw4sVfyVmKrono1rOdDq1iFHQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 05/11, Andrii Nakryiko wrote:
>
> On Mon, May 11, 2026 at 7:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 05/08, Andrii Nakryiko wrote:
> > >
> > > +static bool resolve_uprobe_addr(unsigned long ip, unsigned long *probe_addr)
> > >  {
> > > -     struct vm_area_struct *vma = vma_lookup(current->mm, ip);
> > > +     struct uprobes_state *state = &current->mm->uprobes_state;
> >
> > it seems that there is a problem, with or without this change...
> >
> > Lets forget about this patch for the moment, I am still trying to understand it.
> >
> > What if register_for_each_vma() calls install_breakpoint(vma) and
> > vma->mm != current->mm ?
> >
> > In this case install_breakpoint() path will call __is_optimized() and then
> > __in_uprobe_trampoline() which does vma_lookup(current->mm). This looks
> > obviously wrong ?
> >
> > And unless I am totally confused, this patch "inherits" the problem...
> >
> > No?
> >
>
> Yes, sashiko called this out as well. I'm going to pass mm explicitly
> into is_optimized and all the way to resolve_uprobe_addr(), easy fix.

Aah... found it: https://sashiko.dev/#/patchset/20260509003146.976844-1-andrii%40kernel.org

And note that sashiko is more clever than me; I didn't realize that _unregister()
has more problems with current->mm :/

> But we should have a stand-alone easily backportable fix for this even
> without my changes, yes. I can add it as pre-patch or send separately.

Agreed. This deserves another/simple fix. If nothing else, for documentation.

Oleg.

