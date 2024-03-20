Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419755E72
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948629; cv=none; b=C/XNpY2gNp1iUqCorQ+s6NwATpa2lDzVBgeWxIYqobK3BG9ZpqYlOX1quP/36en4WGNjm105cjYkZmxWyCO1o7zG33EcYUO3YD3M/e3Fa1gY9YyvtwOwkilSBGXjN9wMJL4qOEUcED+kmm3htmnuI6eDoAB8I7g/GzZWgm16faU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948629; c=relaxed/simple;
	bh=UrG4EIWj25xQRb5ZlBhHc5hz7x+8yc6T5wy2p7CXyxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzhFmsu0BaV2e7CCfWnVwLvS5UCSrOmAcP0E0NjeM/VABJtI6JYCqcF0l6BVUZp9o4HxCRaUV8JXK8ced8nOsG6gpKv9K67I//5bgrrwnALEzlrQH+nmqgK42xyFcsYb/n9FpSnKqTBoqW/xslL2tLCm7Yljn8pirIqAZ/8Y7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHr1HEiL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHr1HEiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710948626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hdCF6RZV0uulVgYwMoQabbil5qrvC7Pr4E+4iUwMKUI=;
	b=eHr1HEiLvGHiHg/67FFOhtQQ+69RTiOiGjfOM67G4b8iz0+/zjYmuNdL6dpAJJn6/yhkNF
	/U0KEVySkep69wukvqPmPX3e2t4QAgM467FCBoEV6HaWFMUOURUvxrBJAf6eZsSfaU2pIF
	TIb3vzkCsxj6hEfZ+MGN/IcfyFcH3PI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-PveXJ6TCNkyKvw_XkTJOzw-1; Wed, 20 Mar 2024 11:30:22 -0400
X-MC-Unique: PveXJ6TCNkyKvw_XkTJOzw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0C80851798;
	Wed, 20 Mar 2024 15:30:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.173])
	by smtp.corp.redhat.com (Postfix) with SMTP id 9F1F1492BD0;
	Wed, 20 Mar 2024 15:30:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 20 Mar 2024 16:28:58 +0100 (CET)
Date: Wed, 20 Mar 2024 16:28:48 +0100
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
Message-ID: <20240320152848.GA7613@redhat.com>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320143739.GA32579@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 03/20, Oleg Nesterov wrote:
>
> On 03/20, Jiri Olsa wrote:
> >
> > are you ok if I squash the patches together
>
> Yes, thanks, I am fine.
>
> But lets discuss this change a bit more. So, with this poc we have the
> (intentionally) oversimplified
>
> 	SYSCALL_DEFINE0(uretprobe)
> 	{
> 		struct pt_regs *regs = task_pt_regs(current);
> 		unsigned long __user *ax_and_ret = (unsigned long __user *)regs->sp + 2;
> 		unsigned long ip, err;
>
> 		ip = regs->ip;
> 		regs->orig_ax = -1;
> 		err = get_user(regs->ax, ax_and_ret);
> 		WARN_ON_ONCE(err);
>
> 		uprobe_handle_trampoline(regs);
>
> 		err = put_user(regs->ip, ax_and_ret);
> 		WARN_ON_ONCE(err);
> 		regs->ip = ip;
>
> 		return regs->ax;
> 	}
>
> I have no idea what uprobe consumers / bpf programs can do, so let me ask:
>
> 	- uprobe_consumer's will see the "wrong" values of regs->cx/r11/sp
> 	  Is it OK? If not - easy to fix.
>
> 	- can uprobe_consumer change regs->cx/r11 ? If yes - easy to fix.
>
> 	- can uprobe_consumer change regs->sp ? If yes - easy to fix too,
> 	  but needs a separate check/code.

IOW. If answer is "yes" to all the questions above, then we probably need
something like

	SYSCALL_DEFINE0(uretprobe)
	{
		struct pt_regs *regs = task_pt_regs(current);
		unsigned long err, ip, sp, r11_cx_ax[3];

		err = copy_from_user(r11_cx_ax, (void __user*)regs->sp, sizeof(r11_cx_ax));
		WARN_ON_ONCE(err);

		// Q1: apart from ax, do we really care?
		// expose the "right" values of r11/cx/ax/sp to uprobe_consumer's
		regs->r11 = r11_cx_ax[0];
		regs->cx  = r11_cx_ax[1];
		regs->ax  = r11_cx_ax[2];
		regs->sp += sizeof(r11_cx_ax);
		regs->orig_ax = -1;

		ip = regs->ip;
		sp = regs->sp;

		uprobe_handle_trampoline(regs);

		// Q2: is it possible? do we care?
		// uprobe_consumer has changed sp, we can do nothing,
		// just return via iret.
		if (regs->sp != sp)
			return regs->ax;
		regs->sp -= sizeof(r11_cx_ax);

		// Q3: is it possible? do we care?
		// for the case uprobe_consumer has changed r11/cx
		r11_cx_ax[0] = regs->r11;
		r11_cx_ax[1] = regs->cx;

		// comment to explain this hack
		r11_cx_ax[2] = regs->ip;
		regs->ip = ip;

		err = copy_to_user((void __user*)regs->sp, r11_cx_ax, sizeof(r11_cx_ax));
		WARN_ON_ONCE(err);

		// ensure sysret, see do_syscall_64()
		regs->r11 = regs->flags;
		regs->cx  = regs->ip;

		return regs->ax;
	}

Oleg.

