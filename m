Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B480BF8
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830039; cv=none; b=vDtuGekb+XnZO/1AlQ+tkM6R/R+nwjJLhkB4531nuemBqnpv93FgxpGzYAJ34rUfURgEXSR9RXCasHbYfl4EVUBXIEHrz8vIXBfU+xYWv365LDSnS0YVB4wXMnn4gpiyfCfYuaLMqrT+C7aQtJoROsDKOUmkANcFGsY72UqyhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830039; c=relaxed/simple;
	bh=k8Eo5FPdblqYucHgqojDjWLSno2Jgx1u5TwQpy+l2Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWZZCMeBxbGBbjL8pMM0KtW/bAAnKc1bd4w2Xb9whCAqfephiZZPb1IXw4wzW/MbB8WBZToNe//EMpIjXmY0pOveV+w4xi70adeeSpfBTkHfyD7b41g1NAMB9mOayZmi5uZo3R/ysOGckBvWiV5ybXrOr5seAPo9oMLQoKv/n4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFnT1vKy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFnT1vKy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710830036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vc3xMzUk8gywc/kCGXwO98d0jqY0WWJGV4cGc3rbc7g=;
	b=PFnT1vKyNwEXf2iKx4fYarjyfzHerp7ZO8PTlS8UpwJRoAAhu2CKaFVJ4u4O1iykM/o28r
	/x2hg6ltPTJH9qefxuBXh7OoURqFMq+4LANcW7d0x5Hy2jUCEF8at2dpCrO2PvTm6GlZNS
	piO6fVTbnGLWQb4r+a2BzQQ3+RKTagA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-2u0CM-IdN_6v5npsIWOjCg-1; Tue,
 19 Mar 2024 02:33:50 -0400
X-MC-Unique: 2u0CM-IdN_6v5npsIWOjCg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 935643C02B87;
	Tue, 19 Mar 2024 06:33:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id C86C7492BDA;
	Tue, 19 Mar 2024 06:33:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Mar 2024 07:32:27 +0100 (CET)
Date: Tue, 19 Mar 2024 07:32:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 1/3] uprobe: Add uretprobe syscall to speed
 up return probe
Message-ID: <20240319063219.GB20287@redhat.com>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240318093139.293497-2-jolsa@kernel.org>
 <CAEf4BzaKDz-2Tavkb+Uu3zugZHcfVLqO-09F=bEJkWFre747eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaKDz-2Tavkb+Uu3zugZHcfVLqO-09F=bEJkWFre747eg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 03/18, Andrii Nakryiko wrote:
>
> > +       "syscall\n"
>
> oh, btw, do we need to save flags register as well or it's handled
> somehow? I think according to manual syscall instruction does
> something to rflags register. So do we need pushfq before syscall?

The comment above entry_SYSCALL_64() says

	64-bit SYSCALL saves rip to rcx, clears rflags.RF, then saves rflags to r11

then entry_SYSCALL_64 does

	pushq   %r11                                    /* pt_regs->flags */

which should be restored on return to userspace. So I think that
only X86_EFLAGS_RF can be lost, we probably do not care.

Oleg.

