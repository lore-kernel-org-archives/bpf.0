Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358531;
	b=Q0vmQR2ILngbEOKwG5lOGshoiMfmOtDlsEZZAMPmIlcC6XkOtyFUGEtMQTahyhlX/PHI
	 mdGiTEk0Af+sZHqhdzQ37ikmeDG/FqUuzPUEpeji2jwFqvWErwWsCRx2bSxEz1SgesEKZ
	 konmN7uNd4DPm5hlyra32qVH5g1nHKKOtLr/shVK0EfNvz4dlqiUZrMpOoI3Wb4TnXTOO
	 HcYkeV0f+WLKI7WDTXnOsMV01/Amqeu3s99SX75+m2CvF9B5O8IvLmVB6T/XXBWIcDmhd
	 MgBdzPBrqd7kGOmwD5VVHfyOYq3hq5+XNYlbap95atvc0nKozko3tzBht281hPfhO9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=gdeCa3x7O2p6X4CzDfNArZvHnuzUnaCRCf8ceCdxpuM=;
	b=0HfkjlvHC/DAqxStlF4QpgAAfjlbpmTtdzOTPcCGBz+FnGGJG/qGoAsqLkxrxCMLbcBP
	 5AKATQIKFU1yZ6mVjQQZCpXXv+YNLtST0DN6T+6aqrOPEZGFDXhoNfq/O0kWvJm8kwLCH
	 q1KBiGORTgKM6MlAdQxO5rny+i7uzIRkOPp0V7/OSHrzmmutKJHl7OG4d5Z4V1FvtLyY0
	 AczbgPRKmPg55WCwNOUk6wu2CtDz8qANeo8/dvJW44o4Lr4ff9vGnxCJ0+aoquCJ9F6c4
	 SLPefJJcsfgpPJyfoE7McBa++rXixK9zmuDaVwExC6znVaL5X4x+xjViU6m3V1AqvRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DC8XtGi5;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F2606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 421F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DC8XtGi5
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4be28b82so584665f8f.2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793358530; x=1793963330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gdeCa3x7O2p6X4CzDfNArZvHnuzUnaCRCf8ceCdxpuM=;
        b=DC8XtGi5mewivxD1HqoCFxDC0obecJLrPTTTnloYz3HyAZP2za/Pb7oTQGPgiNz5nU
         d0ZEAFltMXEnZNVAkP5OercmshnvlL8E29F8sqYTr432/hoq/rjQluttSeuyihlP12I4
         0wsntBRhY9cvDARrw8oXo/dKVHRgMBtnuX1HFBY0PE4HIe0IFGeajheBsh9bV9hklgKT
         S1N5U6x1quXT7BaLeEFAuIoaJiQJvLYq1GXJhqLZplKy0sRUmhliK4GQ0lPVvSSobaqB
         Lj9NxgT1vCrsCctnm0ZT5vmZk/JJBCs1bmqYCHXKRUceNhs6RpHJJ/1DK6jUKkPW+NK1
         /5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358530; x=1793963330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gdeCa3x7O2p6X4CzDfNArZvHnuzUnaCRCf8ceCdxpuM=;
        b=XDor4QVVAL78oWuraqeJPCanE8bRcMzzakZ/YyTNDDlBB643BH8QWxxFZskgpJHJiu
         zMi7VoObIKvAao1PkRb0r2y6gtQiTJ76LiEdm3/IF7QUqEvjOZIAqOA8z3bMQ3d+9FRf
         Y06Cb24DOMJOWoDD7muqrGxHH0NbOa/T1z1+mLv4p5JZlWrRX2xYw3XSgvcdlZ4EQZNa
         jpURAmNsvIUcXoTJPzv1VJNgP+WrS3841KOeK4fUGiBr8YbYO/V20vQBzsULzjxurT0a
         vYZ0/JQv3yPF3MzMyj0eZh9PmhXzmRGuytxLecOnQ5fKzmSy2rHh0jNQdF7YuPEHkitR
         Oyjg==
X-Forwarded-Encrypted: i=1; AKwUvBzLOQ7Oj2Mbg6F1ZbS856yywl5j7oCTI1RdGfD2twE2RpjadxI+8FIKVySBdK+7xwV5tAU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqJ05T5G12v1VjP8RQkZiY+gPHxqMuVODCMdlpVUbQsFg3lXWd
	ZlWVIqV7FckhEVvjXr6JcUa9LHAbZ6qL10G5KEh/Z67isdqaAIDk6mxx
X-Gm-Gg: AYBFou3NZ18trjHcbTulRPd2AFIeGjZ9ooODmxs5N/fugC8E3BNSCB5ShpWq1hWNZHz
	PbWaBHr9yNf8EJaUQIDj6nYCUxBnuYPHMB4hDGjBzi4zbLXxmFyw4ap/dYZoGLNryAMXEhB3OhS
	d+7WyYvPSpYD5+0WxQJ62T3PEImLuIEHGxxZDNAbxUpX/GfB1YnQ/wJTXw1PIvIdZmLnHusqtct
	vzym4rPcH3BYKah/FX1Ltxg3B2/JUidn9Xotr2+ZGhDsudpVqggElHxQScBQDgIPrKEl1jrowP+
	5TTRboZErHEA6uRgC3Y/htLNC8wh5nSjYf8Xw3uUvL9pfzTpB8cYpae7EX0mGPD5dAm9fID5mLM
	E3VDvd53C4fMQQ3PyC5TPsxX//yDGz69s0zN78FxQrtGOzKERdg3H9jGppkDOjAekIVxo/yqsoA
	U2s4/9BmSaWJ02002OBzuj/YhDCM/9WWGLrPx3vYcSm8aBOxcG079OzKZhhiWRVbZi1BxsAN7q7
	kh0+9mCVLvjGd+nbLqfNpJaDNwqOLnJ+U2iEAO2fO2OmRZfv1SrltVGUbU3TqWDyjIUfxefszWT
	HSvrxqywiDNkkiWwG260L+4=
X-Received: by 2002:a5d:5d06:0:b0:487:88b:4681 with SMTP id ffacd0b85a97d-48e6e303c2dmr4961705f8f.10.1793358529616;
        Fri, 30 Oct 2026 04:08:49 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba5dc2sm2545582f8f.54.2026.10.30.04.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:08:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Oct 2026 12:08:47 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: Add user memory kfuncs
Message-ID: <auR6v7rEVTlEALJ-@krava>
References: <20261029212551.56964-1-jolsa@kernel.org>
 <20261029212551.56964-3-jolsa@kernel.org>
 <CAEf4BzaAbWxWfjn4u8vieaWzhjE+Af+KV8sLFH9kfgGT5PtAGw@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaAbWxWfjn4u8vieaWzhjE+Af+KV8sLFH9kfgGT5PtAGw@mail.gmail.com>

On Thu, Oct 29, 2026 at 03:00:50PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 29, 2026 at 2:26 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add sleepable kfuncs to copy data into a task's address space and to map
> > or unmap private anonymous memory in the current process.
> >
> > Require a usable user mm for mmap and munmap. Register the kfuncs for
> > KPROBE programs and gate them on CAP_SYS_ADMIN BPF token capability and
> > the BPF_WRITE_USER lockdown check.
> >
> > Use FOLL_FORCE | FOLL_WRITE for task memory copies and return -EFAULT
> > when a copy is incomplete.
> >
> > Rename the syscall info-copy helper to bpf_copy_to_user_buf to avoid
> > the name collision.
> >
> > Assisted-by: Codex:GPT-6
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/helpers.c | 102 +++++++++++++++++++++++++++++++++++++++++++
> >  kernel/bpf/syscall.c |  10 ++---
> >  2 files changed, 107 insertions(+), 5 deletions(-)
> >
> 
> [...]
> 
> > +/**
> > + * bpf_user_mmap() - Map private anonymous memory into the current process
> > + * @len:  Length of the mapping
> > + * @prot: PROT_* flags of mmap(2), including PROT_EXEC
> > + *
> > + * This maps memory by calling vm_mmap() directly. It does not invoke the
> > + * mmap(2) syscall, so seccomp filters do not mediate this mapping.
> > + *
> > + * Return: The address of the mapping on success, -EPERM if the caller has no
> > + * user mm, or an unsigned-long encoded negative error code, as returned by
> > + * vm_mmap().
> > + */
> > +__bpf_kfunc unsigned long bpf_user_mmap(unsigned long len, unsigned long prot)
> 
> bpf_user_anon_mmap(), so we can conceivably have a more generic
> bpf_user_mmap(struct file*, ...) in the future?

yes, will change

thanks,
jirka
