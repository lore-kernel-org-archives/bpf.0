Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69322AE91
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176663; cv=none; b=Hb1A0fQwSdgzrFbZHZmfySttzaXDujPTiwLSwS8UfMc3tCY4z6kMNqzaUEVeKf3yMrV+HNwyvKUyklaajIJNsyGaSqMoPpH8wqLLnNuXWf+XxQDWziFoFtwhy9ZCj3jVRjSiE2ilpnkJRauoeq5QqywfKWqB0BfuUAbd/1yrfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176663; c=relaxed/simple;
	bh=HUvpJoiDG5/K9hvakIssPN4vqoR6JTY/QKH1maDBQIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjGzbgegjf0R2vMgYY90a18n4NIk+GkvR+CgAytz2BkyrDTvO6LRfZKiy1Ytsx3NTOB25xBwusSL6juGCgtO6Pe/PbajzAYpyxlNEj/bW9eVKwq7RCvyxSeFO9vlT7hqimVRIDDIUfyGR7SPUNoqOYP8+A08O48/VM5gipRS+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZOo83Ed; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZOo83Ed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710176660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EVOXCT9OZ5yBK1wj9as2c6O9AhGxdaIZd7ePnK+NV0=;
	b=EZOo83EdLGM/HE2naKOC4RQjFX+UmbHAyG1ASpM/1bVFGvi3Lgll0lfATJwzrJhEwAhEEq
	X1qN9VuLOlXw60c7c0qhN5FiYTLXi3gO/lR6HhVX0YoagcR/9fNVKvmCLpjEjLFdiG1kPI
	sdcQcBwZXW0QV5wn/GVaSDX1B4jAEpA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-nHD9ld5HOl-trUWYqMk0rQ-1; Mon, 11 Mar 2024 13:03:56 -0400
X-MC-Unique: nHD9ld5HOl-trUWYqMk0rQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E95E989C8E0;
	Mon, 11 Mar 2024 17:03:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.242])
	by smtp.corp.redhat.com (Postfix) with SMTP id D9C69112132A;
	Mon, 11 Mar 2024 17:03:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 Mar 2024 18:02:34 +0100 (CET)
Date: Mon, 11 Mar 2024 18:02:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	yunwei356@gmail.com, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <20240311170231.GB28588@redhat.com>
References: <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
 <ZeRO9_IiLSy9D7jQ@krava>
 <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
 <ZebWqIgABbk8dQXT@krava>
 <Ze7kGP5aAYGseRuM@krava>
 <20240311150658.GA28588@redhat.com>
 <Ze81Y2oal2Lg03HA@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze81Y2oal2Lg03HA@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 03/11, Jiri Olsa wrote:
>
> On Mon, Mar 11, 2024 at 04:06:59PM +0100, Oleg Nesterov wrote:
> > I forgot everything about the low-level x86_64 code, but...
> >
> > On 03/11, Jiri Olsa wrote:
> > >
> > >  #ifdef CONFIG_X86_64
> > > +
> > > +asm (
> > > +       ".pushsection .rodata\n"
> > > +       ".global uretprobe_syscall_entry\n"
> > > +       "uretprobe_syscall_entry:\n"
> > > +       "push %rax\n"
> > > +       "mov $462, %rax\n"
> > > +       "syscall\n"
> >
> > Hmm... I think you need to save/restore more registers clobbered by
> > syscall/entry_SYSCALL_64 ?
>
> hum, so the call happens on the function call return, so I thought
> we should just preserve callee saved registers which seems to be
> taken care of by the entry_SYSCALL_64 path..

Yes, but we do not know if the (ret)probed function obeys the C-calling
convention, perhaps it is low level asm code or not a C function.

> I will double check

but I won't insist if you think we do not care.

> > > +
> > > +	regs->ax = ax;
> >
> > probably not strictly needed, we are going to return ax...
>
> it needs to be there for the bpf program to read proper return
> value from regs

OK, I see, thanks.

Oleg.

