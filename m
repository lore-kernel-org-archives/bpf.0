Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44FC75811
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023393; cv=none; b=Jp8EimetApSgFKip9cTTnsczgNQI8P4viKDdEBsFA/4+4T0TzAEVqoUdgsnONT+6oBBbfluXe9iskGx1cKA/Vju1e8ukTrgdo490b235sdI0Sw09vwSt3/pABzjgPDR+ct0yYkdnqmZMfVCsVQWPk2GPR0dsg59+W8CjVEm5uPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023393; c=relaxed/simple;
	bh=lT0xJml1VoF48BDQxCylMJhTX/RBEHDg4Z5YNFg/iVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl5E91tLrANl0r6iKmIjED50ZM8kmrM+H0d/kdK7ZRk+GUmo44SJmzSvekpFzMrwVw3bfEdDK+PMtw7vDRe1tIDFkmu+2Ec6qse2/3lc2S36EdO1MRDXOuPSOQlg8ahd77xTm0AEuRPivNPyR3NgoOe0VVb3W/jwOFRj9tIlUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwrJlkR+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwrJlkR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711023390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9S/aMk7NU6B2Vj8ZtkKYvDdqqZpneuKamYnm692AlN0=;
	b=KwrJlkR+qo1rtNYKq5YXdRKhhbxp76Qn2/mM6cqEIvy/Kn0FNbHv71CjbO5FDImaR4HAW+
	U+6Lsmbi7fL6iOqWr3KGzZ4Px/q3eQef4u77LSN31HeNeiXrCXfPUAyxIaTdynoXcIgvhy
	O8fcWeIJdxm+Da/ulbTZ39nwBROkwsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-64SlG5VOPzuHyqkz26YdMQ-1; Thu, 21 Mar 2024 08:16:27 -0400
X-MC-Unique: 64SlG5VOPzuHyqkz26YdMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B380F185A783;
	Thu, 21 Mar 2024 12:16:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.147])
	by smtp.corp.redhat.com (Postfix) with SMTP id CFE88492BC9;
	Thu, 21 Mar 2024 12:16:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 21 Mar 2024 13:15:04 +0100 (CET)
Date: Thu, 21 Mar 2024 13:14:56 +0100
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
Message-ID: <20240321121456.GC14646@redhat.com>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com>
 <20240320152848.GA7613@redhat.com>
 <ZfwFBgfdHUzQBdxS@krava>
 <20240321101750.GB14646@redhat.com>
 <ZfwRbf0FMHVizZAC@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfwRbf0FMHVizZAC@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 03/21, Jiri Olsa wrote:
>
> On Thu, Mar 21, 2024 at 11:17:51AM +0100, Oleg Nesterov wrote:
> > On 03/21, Jiri Olsa wrote:
> > >
> > > On Wed, Mar 20, 2024 at 04:28:48PM +0100, Oleg Nesterov wrote:
> > >
> > > SNIP
> > >
> > > > 	SYSCALL_DEFINE0(uretprobe)
> > > > 	{
> > > > 		struct pt_regs *regs = task_pt_regs(current);
> > > > 		unsigned long err, ip, sp, r11_cx_ax[3];
> > > >
> > > > 		err = copy_from_user(r11_cx_ax, (void __user*)regs->sp, sizeof(r11_cx_ax));
> > > > 		WARN_ON_ONCE(err);
> > > >
> > > > 		// Q1: apart from ax, do we really care?
> > > > 		// expose the "right" values of r11/cx/ax/sp to uprobe_consumer's
> > > > 		regs->r11 = r11_cx_ax[0];
> > > > 		regs->cx  = r11_cx_ax[1];
> > > > 		regs->ax  = r11_cx_ax[2];
> > > > 		regs->sp += sizeof(r11_cx_ax);
> > > > 		regs->orig_ax = -1;
> > > >
> > > > 		ip = regs->ip;
> > > > 		sp = regs->sp;
> > > >
> > > > 		uprobe_handle_trampoline(regs);
> > > >
> > > > 		// Q2: is it possible? do we care?
> > > > 		// uprobe_consumer has changed sp, we can do nothing,
> > > > 		// just return via iret.
> > > > 		if (regs->sp != sp)
> > > > 			return regs->ax;
> > > > 		regs->sp -= sizeof(r11_cx_ax);
> > > >
> > > > 		// Q3: is it possible? do we care?
> > > > 		// for the case uprobe_consumer has changed r11/cx
> > > > 		r11_cx_ax[0] = regs->r11;
> > > > 		r11_cx_ax[1] = regs->cx;
> > >
> > > I wonder we could add test for this as well, and check we return
> > > proper register values in case the consuer changed them, will check
> > >
> > > >
> > > > 		// comment to explain this hack
> > > > 		r11_cx_ax[2] = regs->ip;
> > > > 		regs->ip = ip;
> > >
> > > we still need restore regs->ip in case do_syscall_64 decides to do
> > > iret for some reason, right?
> >
> > I don't understand... could you spell?
>
> I was wondering why to restore regs->ip for sysret path, but do_syscall_64
> can decide to do iret return (for which we need proper regs->ip) even if we
> prepare cx/r11 registers for sysexit

Still don't understand... Yes, we prepare cx/r11 to avoid iret if possible.
But (apart from performance) we do not care if do_syscall_64() picks iret.
Either way

			regs->ip = ip;

above ensures that usermode returns to uretprobe_syscall_entry right after
the syscall insn. Then popq %r11/cx will restore r11/cx even if they were
changed by uprobe_consumer's. And then "retq" will return to the address
"returned" by handle_trampoline(regs) because we do

			// comment to explain this hack
			r11_cx_ax[2] = regs->ip;

after handle_trampoline(). This all doesn't depend on iret-or-sysret.

OK, I am sure you understand this, so I guess I misunderstood your concerns.

Oleg.

