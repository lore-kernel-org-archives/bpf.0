Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5C56448
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016367; cv=none; b=WeYlS4bMaa/RXEK1/IpHhFEvsmADzOX5vY5aeDCaB3Dm05cJzvDUeQkuSsJT29OCLSZNUjIwfGGWLXxVAfLwMZcfXLsosBSocNW46p4rDal+oZ258Jwh3h2MNYZs7/Aj6/m1wMmBK2RLk9ez5TV2zJzj+xdXt3dQA/zObFUoEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016367; c=relaxed/simple;
	bh=LEMsfzOizGDxw42jEQASTJj5SuqouIls0TE6GTmU++E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVOcGvlb/b9+z9UZHBzlU9N5fLrFymZPhFXe0opJu1OYkRRn1f/b99+sFI1psbG/1wLKufKSwH2U7WnAcG3gaRjcn7HcEIxUZIsKAA5519h0dFv8AqymmRmTsVLo78tN/MMjS0DT1a2tTX1SxNCet4kRKR1y3grRFyKuBaObXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbmO2P0t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbmO2P0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711016364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qsv16zqx8RiTwSUT/ytKDSEPNXTOzEecZEPVJrGnKsQ=;
	b=TbmO2P0tFoGL3z07ugD/jJSwFG3HoHlJdEWDndsik7aw3SLFiyRWVh3TcBAowYqN48VDUu
	jvzs8jYeV9Hl4sdiEeH4KEnehC9fD9XfqLn9lsjJmiqDcnohSvjMAaBs60V8ACGCgbk+H4
	ddF8e0Uk+h1CfESaxioa0c/629AaPrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-0eglqgeSMY-R-BZCiRRPgg-1; Thu, 21 Mar 2024 06:19:21 -0400
X-MC-Unique: 0eglqgeSMY-R-BZCiRRPgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF722800267;
	Thu, 21 Mar 2024 10:19:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.184])
	by smtp.corp.redhat.com (Postfix) with SMTP id 10CB71C060A6;
	Thu, 21 Mar 2024 10:19:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 21 Mar 2024 11:17:58 +0100 (CET)
Date: Thu, 21 Mar 2024 11:17:51 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <20240321101750.GB14646@redhat.com>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com>
 <20240320152848.GA7613@redhat.com>
 <ZfwFBgfdHUzQBdxS@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfwFBgfdHUzQBdxS@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 03/21, Jiri Olsa wrote:
>
> On Wed, Mar 20, 2024 at 04:28:48PM +0100, Oleg Nesterov wrote:
>
> SNIP
>
> > 	SYSCALL_DEFINE0(uretprobe)
> > 	{
> > 		struct pt_regs *regs = task_pt_regs(current);
> > 		unsigned long err, ip, sp, r11_cx_ax[3];
> >
> > 		err = copy_from_user(r11_cx_ax, (void __user*)regs->sp, sizeof(r11_cx_ax));
> > 		WARN_ON_ONCE(err);
> >
> > 		// Q1: apart from ax, do we really care?
> > 		// expose the "right" values of r11/cx/ax/sp to uprobe_consumer's
> > 		regs->r11 = r11_cx_ax[0];
> > 		regs->cx  = r11_cx_ax[1];
> > 		regs->ax  = r11_cx_ax[2];
> > 		regs->sp += sizeof(r11_cx_ax);
> > 		regs->orig_ax = -1;
> >
> > 		ip = regs->ip;
> > 		sp = regs->sp;
> >
> > 		uprobe_handle_trampoline(regs);
> >
> > 		// Q2: is it possible? do we care?
> > 		// uprobe_consumer has changed sp, we can do nothing,
> > 		// just return via iret.
> > 		if (regs->sp != sp)
> > 			return regs->ax;
> > 		regs->sp -= sizeof(r11_cx_ax);
> >
> > 		// Q3: is it possible? do we care?
> > 		// for the case uprobe_consumer has changed r11/cx
> > 		r11_cx_ax[0] = regs->r11;
> > 		r11_cx_ax[1] = regs->cx;
>
> I wonder we could add test for this as well, and check we return
> proper register values in case the consuer changed them, will check
>
> >
> > 		// comment to explain this hack
> > 		r11_cx_ax[2] = regs->ip;
> > 		regs->ip = ip;
>
> we still need restore regs->ip in case do_syscall_64 decides to do
> iret for some reason, right?

I don't understand... could you spell?

AFAICS everything should work correctly even if do_syscall_64() returns F
and entry_SYSCALL_64() returns via iret. No?

> overall lgtm, thanks

OK, great, feel free to update this code according to your preferences and
use it in V2.

Oleg.

