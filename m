Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2E4174A
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169710; cv=none; b=d8q8OLEw64zIk+/zPHEKZTfg5XDhtToGyRrKAO3vafQuCBdPFtasUdyE2l7VrRSOjZ1mAT+7b1DhdsE3xkmgY8tTieg5EUZK6IXiF07ns3tGfvCSdG1TYvBzIr79pC8lWaB8nzgEHgsTTO5zpUJg7KFUqmDuYS3J6rK6hXyFx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169710; c=relaxed/simple;
	bh=098fWzoYwSmqpWJ12+QC7qOPaM5eBGf6cTIamjA8KaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMkkIhOaBaqwjjNlLl6zjmtka7w5XMyGgcSJC5MTMzGg2+CSL4BAScIwBSu/suYMFaKqurCXmxND9c6cw+bCpOtwWZzzt6O097QGObUfD7z5PpkLvDbf7UGg0SOIPsOnWFHHUw+kczoGIUawcZk/pg17q4o89OEweFZg6jNkXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+n7Pj+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+n7Pj+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710169707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kcvm7TGmZ4F/Q+GGtGoWGuc0b/iyK4sfHKLwBgDx/8A=;
	b=S+n7Pj+8KwD3I/FvLTzmhckL2ySFGZ352XVzWEUv6beSBTPAVmqjEdBB6wpx8CqtEGZgsK
	K8s597zBCKYEnQQw79ddeQtJWH67Lk1Uy9BIid/Ns9sh9Txa4ar/YG8sjaOBCCO80IHhAb
	g7KSpfDfaCz1ry6leLA3kEmPTET/ukU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-p58QcrU6Nfia94QT33p1-g-1; Mon,
 11 Mar 2024 11:08:24 -0400
X-MC-Unique: p58QcrU6Nfia94QT33p1-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A10FD383E122;
	Mon, 11 Mar 2024 15:08:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.242])
	by smtp.corp.redhat.com (Postfix) with SMTP id 499961C060A4;
	Mon, 11 Mar 2024 15:08:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 Mar 2024 16:07:02 +0100 (CET)
Date: Mon, 11 Mar 2024 16:06:59 +0100
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
Message-ID: <20240311150658.GA28588@redhat.com>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
 <ZeRO9_IiLSy9D7jQ@krava>
 <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
 <ZebWqIgABbk8dQXT@krava>
 <Ze7kGP5aAYGseRuM@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze7kGP5aAYGseRuM@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

I forgot everything about the low-level x86_64 code, but...

On 03/11, Jiri Olsa wrote:
>
>  #ifdef CONFIG_X86_64
> +
> +asm (
> +       ".pushsection .rodata\n"
> +       ".global uretprobe_syscall_entry\n"
> +       "uretprobe_syscall_entry:\n"
> +       "push %rax\n"
> +       "mov $462, %rax\n"
> +       "syscall\n"

Hmm... I think you need to save/restore more registers clobbered by
syscall/entry_SYSCALL_64 ?

> +SYSCALL_DEFINE1(uprobe, unsigned long, cmd)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	unsigned long ax, err;
> +
> +	/*
> +	 * We get invoked from the trampoline that pushed rax
> +	 * value on stack, read and restore the value.
> +	 */
> +	err = copy_from_user((void*) &ax, (void *) regs->sp, sizeof(ax));
> +	WARN_ON_ONCE(err);
> +
> +	regs->ax = ax;

probably not strictly needed, we are going to return ax...

> +	regs->orig_ax = ax;

This doesn't look right. I think you need

	regs->orig_ax = -1;

Say, to avoid the "Did we come from a system call" checks in
arch_do_signal_or_restart() or handle_signal().

Oleg.

