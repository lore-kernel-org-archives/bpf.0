Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6A9443
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097265; cv=none; b=RfxPVPAAlCmwrNVwNHSD9vTSKO0ITT8UKzuuoO/N582DXuv2TZMSsqwpgV2Zkoljp5+01JrkyYVMfoDu968I26jjEvvIhf7xM3V2S/7lzzCVpfLPkY6QltD3gstrYUFkQH6IosYmnktWna/Kb6gpAuYm6EVBIZIejsIDj68yUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097265; c=relaxed/simple;
	bh=P3qYzfKYOt8FwHTcacEegLDISUOV+YCtr1M8iST3rKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVRHejkns02S0hMk04UEVttlYv6kI53nJLQLkH8EJYclBbgJTlRXLeJTUYHoHPkeCkf4rYGQCQHbdxi8dASKC98UXko3QKI78MG17V6jvep8ksjh3tdPiN7PmLrWABxQPJIr59JcxLBTy/ZDS7ekV6ZQDdTjIUtcS464OR5Yink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=VFqaYTTX; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="VFqaYTTX"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be26842fd5so3867292eec.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 16:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1773097263; x=1773702063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cli1xz6XUpbdpM0TirOuAWc3GKMiVxzxW5XLM+qAjyo=;
        b=VFqaYTTXNBOL0VngrTxHNG2WfvxgKsX9C3SXoVeLqXhLOU5z7owa7/nPeEW/VBQ7m7
         tfNRlqJ7C2XEn1M5wqN2HYaG7eA/RY2BZNJNpZuxgJz4pkUQIqP/XufFS9wJS0boHg7+
         dYldM9z8CPdgGtyWEaCv1xUV1qSyYKWT5i6hLo+YZV7bGo74nOHjQTMd6AMeDXgnXZRL
         W7h9jwEKJFnpr9lCoco1PHRDec/azpu+8iev9ZtLe6HV3bykHBc8Fw2KWEeK0Ws5EGZv
         g60aEXEfkhd72BoH6QsTDBZh7SF5GmM1I3Sustb/QIyFP4aAeZGtAtLjeq2W42jssYdj
         W2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097263; x=1773702063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cli1xz6XUpbdpM0TirOuAWc3GKMiVxzxW5XLM+qAjyo=;
        b=BLgE1R0TqusaTYByjO8oDTtMPBqnIb4zhhU7AjxWwbA5W+/jhJVcRxoyslBJki/qe8
         U9Dn7IbKwE6f657ja1L9BCHzrA4Vg7bKdtzz6T/2L/STYY3nm1knmzN9C1yXAk0K8Ch0
         tuZWvh46uiLgR02URL5cGzwo4QpiAHwmIz6h3ckpIwE1EcIJM+vIDUyC7oVC5gAG8GPd
         ZAviLkeAOticRZKLMipScVM8EcEjKLJ6ovi0eeulnRlRM0h2Y01lvzjV2jF6r/4tBoI0
         1a4BGOui33g+c6LzF/NXskIR4hqFds5od1jVB00lSBjyroECMXmO8x8vodtFICOEkDzm
         vxow==
X-Forwarded-Encrypted: i=1; AJvYcCXam3F1VRoJDdkxE9dfkrg6OliQ96XTlIOO9tS9rAoQjp7K7j818D8DU3SA6qovjzFxbUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3dF9wYaXS8Ss4n4FB6oKMev/+o5qHy9lwdvdL/liWq/PcsTG
	uct2KF8yGOxDVtSHkBs3jdRbxM02/BD1BxEkNL4CTYXRfl9Nt0c5iN0IP3kWp2PE1lm2fhAl7Zz
	dzbYHWUA=
X-Gm-Gg: ATEYQzzTZ4Vf348+hsg21xckjhWuTidJyJ8XMGoBfmlPLmjRAnp3wtrVk76hV1dYNzo
	QxKfDE26uKwKOcOPMCunpMjV+N2dYXJewtEAfK71e0k0dkIoY5H1RI8Cicylqi2Al+7R3jUWyhc
	7Zd/hJ4piBnvnkPEfMOgZ/yEy78/zPE/dDN5cAVvPzGhmqy4e3gkIXqqt17TdaLgqbKii9ElElQ
	JyuPTcJtQtLzPVZ3bYW6zR94+DmutCv99F//Q4Z1/p8uMHfweccWUg55M8/7OdF5FcuSoH/o5PL
	oX3GHR26apPetCyarMApQ5A3SPTVZSy2W8TjmnjE9XIBe54dewQUmEbezUq8MWzZSKZumcWso3i
	PoyvySNGX65O4yZTfGLxIApsa7xqY1G0stGNFKmGGui+0TnxS2HwIAL1tk5oco9SHoPZDpE6PYK
	1K4uSFTC9/TJIRPvksb+xxaStfyA==
X-Received: by 2002:a05:693c:2c11:b0:2ba:a080:61c9 with SMTP id 5a478bee46e88-2be7a25f2d7mr463747eec.10.1773097263340;
        Mon, 09 Mar 2026 16:01:03 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:8af5:5a8f:8ef7:426b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f807a30sm10584123eec.6.2026.03.09.16.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:01:02 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:01:00 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: Need update to libbpf/bpftool for bpf_stream_vprintk() removal
 (kernel sha 0cecd492f516)
Message-ID: <aa9RLM_OwFmI8X8l@mozart.vkv.me>
References: <aa8KBN1kQnng3yma@mozart.vkv.me>
 <e1918475-8028-45a6-a669-dc9031f73c2f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1918475-8028-45a6-a669-dc9031f73c2f@kernel.org>

On Monday 03/09 at 20:34 +0000, Quentin Monnet wrote:
> 2026-03-09 10:57 UTC-0700 ~ Calvin Owens <calvin@wbinvd.org>
> > Hi Andrii,
> > 
> > Your libbpf github sync at [1] happened just before [2] was merged...
> > would you mind syncing that bpf_helpers.h change into libbpf/bpftool?
> > 
> >     In file included from skeleton/profiler.bpf.c:4:
> >     libbpf/include/bpf/bpf_helpers.h:318:12: error: conflicting types for 'bpf_stream_vprintk'
> >          318 | extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
> >              |            ^
> >     ./vmlinux.h:128001:12: note: previous declaration is here
> >       128001 | extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz) __weak __ksym;
> 
> 
> Hi, where did you observe that, please? I don't see it when compiling
> bpftool from the main branch of the GitHub repo.

Hi Quentin,

Thanks for looking, apologies for not adding you to the initial mail.

It's bpftool-7.6.0 with libbpf-1.6.2 that is failing to build in my
case (with 7.0-rc kernels), exactly what is described here:

    https://github.com/libbpf/libbpf/issues/947

I think it was just "bad luck" that it missed Andrii's sync, it was
committed in the kernel 18 hours after his sync. But maybe I'm assuming
too much from the timing...

Calvin

> > I'm happy to send patches if I can help, but I'm guessing this is one of
> > those things that is easier to just do yourself with commit access...
> > 
> > Cheers,
> > Calvin
> > 
> > [2] https://github.com/libbpf/libbpf/commit/6ddc03d4fe0535ac0fb6c8525db31ac88a018ddd
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0cecd492f516
> 
> 
> I take care of bpftool, my ideal workflow is to sync after libbpf has
> been updated. Andrii, if you have a moment to do a libbpf sync, I'm
> happy to follow up with bpftool.
> 
> Quentin
