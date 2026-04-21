Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1573A453D
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810235; cv=none; b=kRnDWUsApTX6UUSPNc/OxnKSYSMV97CEFMt+wBITbJ0DzIk4UQp9zTi5UPXAeIYa++K6OExUVQw1Nd42EeqwY7f+SH3pgAY8FCPUek/FoauZ/p7GthTp8S7eoNXsOAl+LhpCFfPlkPXp7Hvc4Fzky9zjbe4Li43gJvHGu8OU3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810235; c=relaxed/simple;
	bh=sgxlv1Gy4m4rsCqWOlyOFq+BVwQIC9aK9+QByuoBKgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxQ//d3c3AMWfjZc3Brx+ThchKyDuDe34PXZVES5T8sld9kh09CeVrN54Mqgxscgfe58OQCVSBjbv/fwuLgj63qL2WMgczacIRoRhBzK9sata3ctfihSuhqWxzbzrQSknplvNoxoJgHwsKNajylwzhRdpBfJlCE6o5pr5JqBxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGMYyIp0; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGMYyIp0"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-479d4df9035so1453736b6e.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776810232; x=1777415032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lKoAeQw3fgOsyloCGOYdd/7n6rBcnHophybPgqTIkU8=;
        b=tGMYyIp0O11x1j55iLJCIGvJU28dQap3Y7yqipAhblBl5grCmQA7TlUk5QncCtQNZy
         DSO6DFNeVHan1jHgz7nHcbIsfFlpmU5/PeriByy+rEjFXbvKNPYizvt/PDzapPgwU53y
         zEPD02hL0w9p7I5U31IG6y5GH0X2qmzAWWuwIFwOtTsnay1UvTL0a/DWSPbSviodt9Hf
         Da8oZjkOkAYbgVl7Wcu/cosqNYrHGqAq8QwIEqU+dsZCOJY34TFAFMlIwzD9OL8mNleC
         YkT/fSpWjuNJKD59Ou62u9id9JuvjsAtcAxzmCncbommTZjGLIdBq1Ing/XFyBEa+XHu
         b4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810232; x=1777415032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKoAeQw3fgOsyloCGOYdd/7n6rBcnHophybPgqTIkU8=;
        b=VwPcfPts/FeJPmu5mJAOixS8+ErGySCKEY5RdJLT3b839vJjoSGVwqhL12dnUjacau
         Lv/1Ckj533JwD+UbH5tnBqt+KVzLfBUDVCXAWmG9KgwwdibcQVm9PiiZr/vsPMvDb5ai
         yxpVUc4H7+IPNuOCoWDgjC5OA8SA2lgtFIwYV0eIzD7PR7vwFheal9nYPjsNIZ+Tk+4y
         TexYxi0RiR3qNrlkGBjIFnzyxfN/K8y7+CSqMTdmXVnZZOGeJW6WAYGs3eU75i2JmlmA
         17C/nQ0PFMDXtaDnycRgGAmYuC9g54nsWN/e/gMBArN7cJYO6tgHUy42t3+zil87XVq3
         TV9w==
X-Forwarded-Encrypted: i=1; AFNElJ/pwogZKJnAIUT4XhgtRtu9n0TcQKf3MbIXZhCUtBILyFhQ48aELK7s2eL1h4Un7UzSLU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJi48vBzr3KCQSxWB8sM5W4kpKgzG4VxqzecknJH6J4sN3yTxY
	OPyk+fthir0m7TDw3drjboBpLvcdUxtIe3rxNsV92zGP5Q0XkC+hnTG6
X-Gm-Gg: AeBDieuy6JYP/S8AVSptHlTaJ+SyhV2aZV2OH+SmyBv0wU7AcwG5IokwTJ9+iQFK8yG
	mvxwqiOQR+6QT/azDr04XL9GuRaA6JYzrn7llclwy2QiLU12ROefCK+shGt81Ii+laBEZadkudR
	Yck0utjs4cSgG3ffs/9Z3E4wzcDLkreE72KFhFx3ACuvEOGRHTsO9aGY/VPVN4J2bqgP/LxReIZ
	+8IkoZwzrYqDZpi8JPia/fmW9FCfD7ohtYMJKMgaYVyS1maWf4KwgXugHu6O9ZHDFiG6faWopG5
	J0IdON1nR3+eqrWLFkaoiIyXsAkt0LXd11ckS1hxvzenuvrNx3YYoQq/WO7iXPJm0tE+gNtvTmb
	BS/+oVl2PJUZeFrn/veM2KCZa6K992t1nwqwFOc8WE/z0CJTlMBLVK1OerlutCymT8dQelJq7zA
	fnkmATLr4nFmz4iXjM6/zEqCaO48s=
X-Received: by 2002:a05:6808:1a19:b0:475:be2f:c56b with SMTP id 5614622812f47-4799bc82da9mr9234418b6e.3.1776810232611;
        Tue, 21 Apr 2026 15:23:52 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b0591sm12293852a34.19.2026.04.21.15.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:23:52 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:23:51 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
Message-ID: <aef4XHnqR2cs5U1O@devvm17672.vll0.facebook.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
 <20260420082805.14844-9-kerneljasonxing@gmail.com>
 <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
 <CAL+tcoCxQ8cU+wr7eJsMH+FPMcp+vQ4J4BdSdsVqyTRqN8q9LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCxQ8cU+wr7eJsMH+FPMcp+vQ4J4BdSdsVqyTRqN8q9LQ@mail.gmail.com>

On 04/21, Jason Xing wrote:
> On Tue, Apr 21, 2026 at 3:49 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 04/20, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > > uintptr_t cast:
> > >
> > >     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > >
> > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > > the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> > > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> > > lost entirely. The completion queue then returns a truncated address to
> > > userspace, making buffer recycling impossible.
> > >
> > > Fix this by handling the 32-bit case directly in
> > > xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_addrs
> > > struct (the same path already used for multi-descriptor SKBs) to store
> > > the full u64 address.
> >
> > Is it easier to make XSK `depends on 64BIT` to avoid dealing with that? Does
> 
> Of course, it would be super easy. Actually the initial version looks
> like this. One line of coder is simply enough.
> 
> > anybody seriously run af_xdp on 32 bit systems?
> 
> But my worry as you guess is if there exists a 32 bit system? I doubt
> it. That's why I put some effort into adding the compatibility code to
> cover the case. Good news is that it doesn't add any side effects of
> the 64 bit system since they are protected under IS_ENABLED condition.

If someone complains, we can follow up? af_xdp is all u64 everywhere,
including uapi, I doubt someone is using it on 32 bit systems. We don't
test this part on 32 bit systems on nipa either..
