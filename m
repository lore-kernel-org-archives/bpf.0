Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9D4E1B5
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771828; cv=none; b=QOlijFUXvcSEoaQOHkS5XW1PmLg28Uk4MloEtS0w+UXSAcp7uT2ixxTQN+buCzlY4/0XbUfJoerxE2Sb5dFpjL9zeQuY9dFVRuAVauit6JQ+wmUIpjHwPeT90RLd8neAi+JUn+UHgDdHNsPKySo4FpnSRPJT/eAvTE9E5IeDc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771828; c=relaxed/simple;
	bh=7OdIQlUMF9qMTHSVkMXMGHTnpbr8bYRRI3A7WEC5WKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvmS4U/nedYGLYFJNVcDnGe9YOrq2iy/jTwbwTvBqF4uH3IYVvWHb8Rpt44+/biAh6lXKo/I/wP16CDzz5ho+wdbcRN08AuwS4QIyBJKvFOE//BMLMzwevATZ1HJ8JqkSChpCATRS1Ii8HTOzGbS0uN/hWCRf1l1H8P+LiFD49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYK3EEnX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYK3EEnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710771826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J56iKe+J8y/DvtrlrUb/iBGPy3gfmTc/L9b1YwvY3l0=;
	b=LYK3EEnXp0xuni6lhpPPcXvwMAUVeGgp5GPRhxZemJM1G0vcr7MrQxEvFKTy2plvoKaDQi
	DWdo/ofMInekdqRbq3wgFku9uBlyI0QCHAlLW+PoPu6oL3F170syvfebMH+srzH4b8ifua
	h/Yr0nLEsV4mXS5p/vnHdvHSAAcf42Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-zWaMBKYmM5-W7TvNSUni8Q-1; Mon, 18 Mar 2024 10:23:42 -0400
X-MC-Unique: zWaMBKYmM5-W7TvNSUni8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 335AB185A781;
	Mon, 18 Mar 2024 14:23:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.109])
	by smtp.corp.redhat.com (Postfix) with SMTP id CCB8CC04121;
	Mon, 18 Mar 2024 14:23:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 18 Mar 2024 15:22:19 +0100 (CET)
Date: Mon, 18 Mar 2024 15:22:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 1/3] uprobe: Add uretprobe syscall to speed
 up return probe
Message-ID: <20240318142211.GA7616@redhat.com>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240318093139.293497-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318093139.293497-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 03/18, Jiri Olsa wrote:
>
> +SYSCALL_DEFINE0(uretprobe)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	unsigned long sregs[3], err;
> +
> +	/*
> +	 * We set rax and syscall itself changes rcx and r11, so the syscall
> +	 * trampoline saves their original values on stack. We need to read
> +	 * them and set original register values and fix the rsp pointer back.
> +	 */
> +	err = copy_from_user((void *) &sregs, (void *) regs->sp, sizeof(sregs));
                                              ^^^^^^^^^^^^^^^^^

IIUC, it should be (void __user *)regs->sp to shut up the sparse checks.
The 1st "(void *)" typecast is not needed.

Correctness-wise looks good to me, FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

