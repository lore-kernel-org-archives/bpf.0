Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511F22331
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097413; cv=none; b=KoLWRq6dSN9idUFjhTzrDlSNfSheStmwQS+J2MYvEHYB/0PPW/2K3s2Lj1BhxDPz3m8L0T1fLLerrvUs9HJiGIl4pcQVM4q79j28jjg90p2UDiXmVAeEv3REBH54sDifCejYfpU1LZYYtf4655/HjK4Xnne6yt9gGIKKEmBZ7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097413; c=relaxed/simple;
	bh=6cSyU2KmaIwyEHF7qurAFpDAmYeckuqAf6rjHAtbAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDD30YrYKsXb2T9FDMCggImXQUUciG2WzplaRqLdFFpLxzowAuAs+cDiOpre/jdybAwGSFtz3ieLQ6cwhzDRVIbK2wJ3JFOINWN65EqmlZhxLqT2hv2to7SJAdOsYd1FBA02iVKJKSTEJvzRyHJ3INvF4dPO0E8lMzK8kAnBN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fb2fpIhD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb2fpIhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711097410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjyRpgToNYd1SsHunwlrm2xWFnHKrYI4Rbg8WhNxCIc=;
	b=fb2fpIhDM6jQ4tWEOxbcIdQEi3E+WC+D6lA/wADLsyUJz4qnVTh4RUaNdra6vjT0GLtaGY
	5FpxDHQRNQAzKZQ7JYx41CMeSoRrCYmN3Pgr1ih9DHhBvlzGsEV8CJYclhKeGy2Il9AkCH
	7b/oClFZYbxaG+jMN9+aJOgEWdT6n7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620--0In6_UTOXu87l0Z-AMMlQ-1; Fri, 22 Mar 2024 04:50:04 -0400
X-MC-Unique: -0In6_UTOXu87l0Z-AMMlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F17E800262;
	Fri, 22 Mar 2024 08:50:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.60])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7EACA8173;
	Fri, 22 Mar 2024 08:50:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Mar 2024 09:48:40 +0100 (CET)
Date: Fri, 22 Mar 2024 09:48:33 +0100
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
Message-ID: <20240322084832.GA30928@redhat.com>
References: <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com>
 <20240320152848.GA7613@redhat.com>
 <ZfwFBgfdHUzQBdxS@krava>
 <20240321101750.GB14646@redhat.com>
 <ZfwRbf0FMHVizZAC@krava>
 <20240321121456.GC14646@redhat.com>
 <ZfyYriG3ttxbkpix@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfyYriG3ttxbkpix@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 03/21, Jiri Olsa wrote:
>
> On Thu, Mar 21, 2024 at 01:14:56PM +0100, Oleg Nesterov wrote:
> > Either way
> >
> > 			regs->ip = ip;
> >
> > above ensures that usermode returns to uretprobe_syscall_entry right after
> > the syscall insn.
>
> hm, I think above ensures that do_syscall_64 will skip the 'regs->cx != regs->ip'
> check.. and after the sysret returns to rcx register value and ignores regs->ip
                                                                 ^^^^^^^^^^^^^^^^

Yes, that is why do_syscall_64() returns F if regs->cx != regs->ip.

IOW. To oversimplify, the logic is

	// %rcx == ret ip
	entry_SYSCALL_64:

		pt_regs->ip = %rcx;
		pt_regs->cx = %rcx;

		do-syscall;

		%rcx = pt_regs->cx; // POP_REGS

		if (%rcx == pt_regs->ip) {
			// OK, we can use sysret which returns to rcx
			sysret;
		} else {
			// debugger/whatever changed rcx or ip, can't use sysret.
			// return to pt_regs->ip, see the "Return frame for iretq"
			// comment in struct pt_regs.
			iret;
		}

So return-to-usermode always returns to regs->ip and restores all the registers
from pt_regs, just it can be faster if we can use sysret.

> but in any case we need to set it

Yes, yes, sure.

Oleg.

