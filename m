Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6999234E75E
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082346; cv=none; b=a+a41HRj2Z8IS/8YzvVyJySvR/Hw8csPJA8F8IIYEeT0EqAadZk/YYffbAtL7NRlhQIcd3GXd+qACgzTp5KWOzAq4V7UWt+26lfeR0L7LFNMCA7bta0a9xOkrqanE/IhEE4LuBD5sWs2AHJ7I0oAeBN83cMdfw3qw4+HB5eKVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082346; c=relaxed/simple;
	bh=sjCLPqARataqIVvkz3xM21eWNMUdgK/hENkSUt9uKNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9iy8CszFqyFt2i6s1fDQ11wAWcAHZj8udMuMdjpM1T76kC34Bms66LayBs0tVZ1HTiByFTagCfuaos1xTojDLSF38G0jqYPS8VvDomfXiWHuVocoEjSpLwEtAqTXABIhA2nL4JqDqFsshV1nIGwdt/dtuZ7dxLgHHPdAHMDv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoZSfjPb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoZSfjPb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so26215825e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773082344; x=1773687144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gIupF3wZ79zow2MRbYI0aPa3XBYiCLM68IYk9NH1FtA=;
        b=SoZSfjPbwaf17nATSnZURqQb8ycDMZWrrVijGfzNH5CDtnBwIl2wgNchAyquk6Ld28
         3Wz5PpksE/+BcMuPHhmal3funXqa4OQ+eEhGZ/3DI01QDqHeBX3tJpuyBQDQs+kNW8Mg
         fk0UT5IHUMZMBYopeh8wyKr2TrumixFvi/z0N7WzEepH3elnJV4ksBcwcsErIY/6wc/o
         P4zsHonEb+X60vhf7uQdWOkBX8Lf+uUWp1KbgzzS3cBU3mV+BqNoOtrumI+cfqcI43DW
         ap3BWBDhTQ0aBgnFq52BsCF89iMWhsRNS/+JkjhDulWQ+dcvVtKDvohIUEAh0EhD3JiR
         u0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773082344; x=1773687144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIupF3wZ79zow2MRbYI0aPa3XBYiCLM68IYk9NH1FtA=;
        b=KHaMEiVaYSmLa/OetetR7mhUVY58V55EQw51YwNzSujiwUjUOYrxJZoARqzok1F1Gl
         cwStlL3hk7+vRz+bbv0nOoYShucIZGFJogzSVTahCMnAdcM8LY3J1OKEjBxQso5i7Sxu
         6T2O3UKqd7eBRn54Y2PO3DjAlkq0U6+jXLZS4oYUzcVW7Gacm5bUgw9PVpSDmDKQK1fA
         jstU/mQbyOAvqAGyS5fKpkFMf4Ka73KZTzEnIpqCyUrt7aauaDAc0IORNpY5G9BXKzsC
         uItNhAGL7tVhIniWmvL6RuI07i/ja49pXMG3XBZE6NXnZ6/hJQxz3iNECEsrrMnFZwvd
         +XhQ==
X-Gm-Message-State: AOJu0YwdyuDw+hlJZamV5PQ7ClI4DiUO9eaajpEri5nQ9lDzZsgkGCZR
	CFnx779snwcS7nYn0C+45nYGYvlOR+tLK0IbeVkdcAHRXWFrlfDmogmsmCEhNFaCF2EDrw==
X-Gm-Gg: ATEYQzyXdzVcclo/ugGnSZmDIgipwjia5gaw/9zrPObPCCB/g63+qywFAFBgqZV2/le
	RnO6CQ+9mSmJ94ABi8D9u1LKsL2xQNdlnHpnjtnZZd7dP60Dew2s59WlvZzb2vvihwweBd/Lqio
	eOIUHYBG2waS6C15S2He6V0WchH1ukZQyzuLIrC48yIxcTIvyOVGmnmoSTri6oO9sy6apTIfwlR
	Afb3FIDPommFqOCIl8rX1ko7DgF1FFVTZGF/H6XxewGTrauwn0aVfAmYD7ASNsPeNSfBD+7A8qj
	0Mx+hjT7Ov48luSHP/JPr0GXYpMpb6A0pVtC40lPaX73W/t4dQyY8kHAeWa3gqQitPgFjRjtTYy
	6yFa8xtwUL/KqZwS5PXjlOQkR5O5NrB7DEWz38kSDPDBSi54Xa1COv7q3+f9aAEi3Zim0HxnBPH
	NSdnZITt2blmB/WlPId3BpYFWxRnT0rXR8IXiHyz+mD31DlpFJsPO2MytG0RYOzjil+Q==
X-Received: by 2002:a05:600d:644e:10b0:485:2af3:3f82 with SMTP id 5b1f17b1804b1-4852af3405fmr128679045e9.7.1773082343588;
        Mon, 09 Mar 2026 11:52:23 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852470c697sm92029695e9.31.2026.03.09.11.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:52:22 -0700 (PDT)
Date: Mon, 9 Mar 2026 19:52:20 +0100
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Add netpoll kfuncs for sending UDP
 packets
Message-ID: <aa8W5JfSZUo-Y8NG@gmail.com>
References: <20260309131635.302424-1-mahe.tardy@gmail.com>
 <20260309131635.302424-2-mahe.tardy@gmail.com>
 <CAADnVQLyTjCk2xSdvT67kofCJS1cDOMpHdCFfNHrWg9nQMSUSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLyTjCk2xSdvT67kofCJS1cDOMpHdCFfNHrWg9nQMSUSA@mail.gmail.com>

On Mon, Mar 09, 2026 at 09:26:00AM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 9, 2026 at 6:17 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > +
> > +       bnp = kzalloc(sizeof(*bnp), GFP_KERNEL);
> 
> AI generated it and humans reviewed it ?
> Sigh. AI does a better job at this.
> Think about this line again.

Yes I reviewed this, but Song might know more on how this was generated,
my experience with handling kernel memory is fairly limited (I'm mostly
learning) but this looked good to me.

As I'm seeing it we could have used more modern wrapper like:

	bnp = kzalloc_obj(*bnp)

But I'm not sure it would made a fundamental difference here since it
would be the exact same flag.

It's called from bpf_netpoll_create, that can be only called from
sleepable programs (like SYSCALL here). And it's similar to how the
crypto context is allocated in the bpf_crypto_ctx_create kfunc so I'm
not sure I understand what's wrong in our variant. 

Could you help me and be more explicit on what you think is wrong?

> Also, don't bother with RFC. If you want the patches to
> land don't use RFC tag.
> 
> RFC means "I don't know what I'm doing and I'm not asking
> to land it in this shape".

Okay thanks for the info, I'll remove the RFC for v2.
