Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8947F6B
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945577; cv=none; b=ik6TCzWvEJ5JkcDctw30Bi9skqQanSmci8A0Fn1gdhrQSoXF6WSZxKqSNMX9ehQgJSnXPdg2nbabCXGA2uTy3/ZnSQrYjgfmF/l+gTmEGAJa92Cw66qIFt+EgXV9MjyqvduRyvpBJVujNwBVTUwS7NogS+3tiXa+0Seg/Rjfyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945577; c=relaxed/simple;
	bh=O60Eh00woIeI6k01dYnAfkZHWqfhmXd+slRKWM1NV84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiA3eJAeY0L6gfK1o4UR9eZoFlqZUvxNSuQZJZuYZmGAju+5il9KSCVNfovoDwM4UAVcjVdLQItmIlnT4Gu57ju1+g/X3tYmwrCuPtIC2euHMPfIhNVSckQZ4s1dEISzyBODxTtauzfjhdPSXOwGIX9oAc0jmUTex8cwUc2ZaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gh1KgRXJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh1KgRXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710945574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMot51e+Up7n6LE4ZyNgw/UudoBbFvljXsz1zEBC9QE=;
	b=Gh1KgRXJmocqaA4xuLj6zM3mQBultUnkgjD3YWwP27tovXBeB5HYj2UkL8dTDpZabi0mJd
	QgmVM+5+ArP23RYP0s7LfBXsEfqTL9gwiNOlCM32YdMqnazHCR5GPS5ES4ZBM0R5pQdwyC
	JnK6RPQGgLbgYxwlW10nKFMZacjmhkc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-Ne3fV7T7N8ypVapr6b5alA-1; Wed, 20 Mar 2024 10:39:29 -0400
X-MC-Unique: Ne3fV7T7N8ypVapr6b5alA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6582E803EC2;
	Wed, 20 Mar 2024 14:39:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.173])
	by smtp.corp.redhat.com (Postfix) with SMTP id E3A553C23;
	Wed, 20 Mar 2024 14:39:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 20 Mar 2024 15:38:05 +0100 (CET)
Date: Wed, 20 Mar 2024 15:37:40 +0100
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
Message-ID: <20240320143739.GA32579@redhat.com>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfrC0NZWxmWBuUIe@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 03/20, Jiri Olsa wrote:
>
> are you ok if I squash the patches together

Yes, thanks, I am fine.

But lets discuss this change a bit more. So, with this poc we have the
(intentionally) oversimplified

	SYSCALL_DEFINE0(uretprobe)
	{
		struct pt_regs *regs = task_pt_regs(current);
		unsigned long __user *ax_and_ret = (unsigned long __user *)regs->sp + 2;
		unsigned long ip, err;

		ip = regs->ip;
		regs->orig_ax = -1;
		err = get_user(regs->ax, ax_and_ret);
		WARN_ON_ONCE(err);

		uprobe_handle_trampoline(regs);

		err = put_user(regs->ip, ax_and_ret);
		WARN_ON_ONCE(err);
		regs->ip = ip;

		return regs->ax;
	}

I have no idea what uprobe consumers / bpf programs can do, so let me ask:

	- uprobe_consumer's will see the "wrong" values of regs->cx/r11/sp
	  Is it OK? If not - easy to fix.

	- can uprobe_consumer change regs->cx/r11 ? If yes - easy to fix.

	- can uprobe_consumer change regs->sp ? If yes - easy to fix too,
	  but needs a separate check/code.

Oleg.

