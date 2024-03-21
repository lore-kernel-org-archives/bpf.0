Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8234D9E7
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015961; cv=none; b=YfH5M/ywPLHAEZNxtxmzINaR12Ctft5TUAJcD5XrT1zVNSVqgUhaCLTZQp1Nvpo5Xu0Q5IarZ5mGLSchJWIsUEpwki+wkBqVzTNM1fhR07NoK5DOr1OLcVVVbp09nKzCyPoxAkrq/dX2GFqjGLwUrzw4I53+LekrTSFIbxBVn1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015961; c=relaxed/simple;
	bh=mpsMnE//1YNY7ZGBRoXOKJNPwfa4JNH39TcusMgkKUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBiEuBYJBvrXI09aeyy7Y8QTgGVXNqfR7FZ0dsAOqNkDCGxFrnqDYsdUkRdRv4dkeeeXHxNC+Z9hduG9Etg4ASz5sOuWZBr71378BM1WWQqqOapUea58l8PYJm9kv7BWsJvd1Xkq7gBaCgEb5ctP+j5EG5ekFLN4g4JVg5DfWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZnlQCaHo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnlQCaHo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711015958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ef5Enx4XZGj8Pf5Nf/dpeQmHdxBoXkW5MU+Cx9OJSCs=;
	b=ZnlQCaHo8XG84g3Gc6paEK7aNX2vecIDfVfcaJzXQcFXMz3rtEehkxgAZT6aslWMrZ8FQ3
	W1KLloQoNaXLDw0jzJHMcVv1l7y5y+OU7ufGq/HOuFEj1BLIM4+MgKSYitvdxbj9R5SGkV
	R/3sh85MArqPaMaAgSY8F24irqQ+kNs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-6BDop-O7MG2-bSwaiJr2LQ-1; Thu,
 21 Mar 2024 06:12:32 -0400
X-MC-Unique: 6BDop-O7MG2-bSwaiJr2LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF7D21C3A4C2;
	Thu, 21 Mar 2024 10:12:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.184])
	by smtp.corp.redhat.com (Postfix) with SMTP id EE945200B3BD;
	Thu, 21 Mar 2024 10:12:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 21 Mar 2024 11:11:09 +0100 (CET)
Date: Thu, 21 Mar 2024 11:10:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <20240321101046.GA14646@redhat.com>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com>
 <20240320152848.GA7613@redhat.com>
 <CAEf4Bzbw4CGCptxi7tXoZEEkm_wcBzkaJgTN_tYE5K7sSUgMhw@mail.gmail.com>
 <Zfs0LSuw-JOhBn8e@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zfs0LSuw-JOhBn8e@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 03/20, Jiri Olsa wrote:
>
> On Wed, Mar 20, 2024 at 10:44:30AM -0700, Andrii Nakryiko wrote:
> > On Wed, Mar 20, 2024 at 8:30 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > > I have no idea what uprobe consumers / bpf programs can do, so let me ask:
> > > >
> > > >       - uprobe_consumer's will see the "wrong" values of regs->cx/r11/sp
> > > >         Is it OK? If not - easy to fix.
> > > >
> > > >       - can uprobe_consumer change regs->cx/r11 ? If yes - easy to fix.
> > > >
> > > >       - can uprobe_consumer change regs->sp ? If yes - easy to fix too,
> > > >         but needs a separate check/code.
> > >
> > > IOW. If answer is "yes" to all the questions above, then we probably need
> > > something like
> >
> > yes to first, so ideally we fix registers to "correct" values
> > (especially sp), but no to the last two (at least as far as BPF is
> > concerned)
>
> I think we should keep the same behaviour as it was for the trap,
> so I think we should restore all registers and allow consumer to change it

OK, agreed. Then something like the code below.

Oleg.

> > >         SYSCALL_DEFINE0(uretprobe)
> > >         {
> > >                 struct pt_regs *regs = task_pt_regs(current);
> > >                 unsigned long err, ip, sp, r11_cx_ax[3];
> > >
> > >                 err = copy_from_user(r11_cx_ax, (void __user*)regs->sp, sizeof(r11_cx_ax));
> > >                 WARN_ON_ONCE(err);
> > >
> > >                 // Q1: apart from ax, do we really care?
> > >                 // expose the "right" values of r11/cx/ax/sp to uprobe_consumer's
> > >                 regs->r11 = r11_cx_ax[0];
> > >                 regs->cx  = r11_cx_ax[1];
> > >                 regs->ax  = r11_cx_ax[2];
> > >                 regs->sp += sizeof(r11_cx_ax);
> > >                 regs->orig_ax = -1;
> > >
> > >                 ip = regs->ip;
> > >                 sp = regs->sp;
> > >
> > >                 uprobe_handle_trampoline(regs);
> > >
> > >                 // Q2: is it possible? do we care?
> > >                 // uprobe_consumer has changed sp, we can do nothing,
> > >                 // just return via iret.
> > >                 if (regs->sp != sp)
> > >                         return regs->ax;
> > >                 regs->sp -= sizeof(r11_cx_ax);
> > >
> > >                 // Q3: is it possible? do we care?
> > >                 // for the case uprobe_consumer has changed r11/cx
> > >                 r11_cx_ax[0] = regs->r11;
> > >                 r11_cx_ax[1] = regs->cx;
> > >
> > >                 // comment to explain this hack
> > >                 r11_cx_ax[2] = regs->ip;
> > >                 regs->ip = ip;
> > >
> > >                 err = copy_to_user((void __user*)regs->sp, r11_cx_ax, sizeof(r11_cx_ax));
> > >                 WARN_ON_ONCE(err);
> > >
> > >                 // ensure sysret, see do_syscall_64()
> > >                 regs->r11 = regs->flags;
> > >                 regs->cx  = regs->ip;
> > >
> > >                 return regs->ax;
> > >         }
> > >
> > > Oleg.
> > >
> 

