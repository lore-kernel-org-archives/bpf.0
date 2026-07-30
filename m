Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B251365A00
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389839; cv=none; b=Pej6W/eROV1a7SIKHZToxP7hNh0zXfw3qECAtQmeDDW0bauH34TmZqPVZ7RySejLk4IzAlZG1HqRQKsjq5UO/hl/cjaUNyBMCYstqk/vuyFkFjjvRwT1jQCBnZVZ6e/3uzbXWs/NKD+4f1FIUlqSSrNRLL2lCiCkiP58PjkPCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389839; c=relaxed/simple;
	bh=mJM0Mfs6GdeH7sAxxU0AKcY78IJ2RZOWEB0M7KJq5ng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ci2nY/8TuQ3xoIJT5Ie6ugZA356GiRjvHgOsieZmFSXqsP1maF5cR6wuVYNJML6Fkz25HCjlA/JEBUYSN5NIkxNI0GtJUKCMf+Br22+ra8nAnvmDN6aehEb8QIrEF8G4lm1CDqiih/qiMRFWuG9b3Xr3n4bRe7GA1VDB37GO15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnjIHRPu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnjIHRPu"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8485ef63b68so1959587b3a.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 22:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785389837; x=1785994637; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mJM0Mfs6GdeH7sAxxU0AKcY78IJ2RZOWEB0M7KJq5ng=;
        b=VnjIHRPuWee42PUla/st9Z3E1IXYld+oQ5LoWtmX5qZyKtl9xATiqi9O0Hu9yvILm7
         YI+rACYdyqbGABLLvl/skVK8sMHmVXH1y/z6LuploDz4k+eHTCnIVf/RA4rGptM+rvmc
         fBrQURjD+XAnmQToqbemR5GG55WnY750aFsL+733ZL0yeMwo3X2oFIUixXomMXcLCqgC
         IRqih3sAElBPfXXVm55/s68zZEaL/giJDnU5sXOroUotG0HHYM9FZ4j3EZM+d2cOB7Px
         7nvbE0S2Q6rbj4lxXFxrDMPiHmLTI/e8gIR+92ZZ0KzzW9ieT8wZi0qD2feZCdwRNF9P
         6B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785389837; x=1785994637;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJM0Mfs6GdeH7sAxxU0AKcY78IJ2RZOWEB0M7KJq5ng=;
        b=OHCihjzopaUBAzrZdd2D3TlsjhvXk16qguowpR+XvT1PVWltIav6iK8p/ff3FXs8vC
         ENmOL+dLG6zm118OLBbCotxZmXZxIw5voHr0zkpa3h8254ipKwB2kHZk424zRIeIHfyh
         Wo6561b+UKpfSe+0uV01DEu2DY6jjY6Rfd8/x6OvdGytlOsggmK9Y1NRb8K4fRMPMgWF
         snfrom+4Dlk7vdwtmHZTj5I1lLj/d/AFTXlHZSakohvEX/oPRZdb/Fcrj0fs9zL2d2Kx
         W1tvaBgA0tXOgIzFQaaSYHaD7BpEb1IEcC2ZZsaotI8vfmUnWAtFqmVG9TxDxBYGwNmU
         Dgfg==
X-Gm-Message-State: AOJu0YyLV3bLUbEYhZFNpCoJyhrTUcUAz0oM871MaTNnlC3lFPWBPy+C
	WnC5znuJ5zpVk+0/pIV4u6SVNq3OBBz8IH7yLciSMw7WpPSVT+Em18xe
X-Gm-Gg: AR+sD11kQ5Sxmm24n0R8eGLAZMDAQRWcHDFyqANxuBodvBHRa2icnKB7FhUBhnKGKMY
	YNjUtufOKyw7wf0ktAO/7rkDh7bB+WQ3AJrcr7YCKtomijVQlRm9ITBOFmWoVRUXFrYmVTrFcJR
	dKrU2jC7DPD744RVX2xyuGbyanzyQk0oXrzKZAd6VONVaxzMR1A5b6nsrGxWncKbpENw3QZcDiC
	OAySkT63dFIvZ0CKXliQF4SV+ubO07OMX0nyBZWN+jp33TD82WyQbqs+cS3JN2Qk1wxLEGuevoE
	Kvt0tOkqvHWXNqosxuWcmBdgvszV71SJXCAlhxhlSXh3wxreJb2xEm+HvNYhNp5THs4STMKzK7z
	nGR0o/BYTZcR9zczk77Z/6m88wZ2cp5JnMDEXRVPqJt01n/GYpok4dSwEp03Yb4ZaCs7AFziHbO
	0yPZcNuD7KnavTl5xW845cY22F5zxEehSZBxLOWOL0uiIz/olewlXsHf3aRGi/91GDLr23BP0hO
	UUT7d+ujozxH/u019WZyHAIuzAmJxryLgzjegA=
X-Received: by 2002:a05:6a00:1486:b0:845:e3e4:9702 with SMTP id d2e1a72fcca58-84ebc3dc353mr1276463b3a.47.1785389837325;
        Wed, 29 Jul 2026 22:37:17 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe238ffsm2441201b3a.12.2026.07.29.22.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 22:37:17 -0700 (PDT)
Message-ID: <873321927b849ee473245cca610a99527c8808dd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/18] bpf: Check helper and kfunc mem+size
 arguments identically
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Date: Wed, 29 Jul 2026 22:37:14 -0700
In-Reply-To: <CAMB2axO=y6mauaS+xLVVYWUNByiK0+AECJmL-UpUQQFL5Rn8EA@mail.gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-6-ameryhung@gmail.com>
	 <27739a12b7f7d5cd6e7fceeb389cff0072aefef2.camel@gmail.com>
	 <CAMB2axPcdjVA6Pwp0TpGpMtJGiOB5khJ4HA13iJ9XT1qpyfNtw@mail.gmail.com>
	 <933cbc8d75fddf0dd94a7ae8614a55e9dfc231e5.camel@gmail.com>
	 <CAMB2axO=y6mauaS+xLVVYWUNByiK0+AECJmL-UpUQQFL5Rn8EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 22:33 -0700, Amery Hung wrote:
> [...]
>=20
> > > >=20
> > > > Note that the check_helper_mem_access() already calls base_type(mem=
_reg),
> > > > so the '&=3D ~PTR_MAYBE_NULL' part is irrelevant, what matters are =
the
> > > > following mutations:
> > > > - PTR_TO_MAP_VALUE -> CONST_PTR_TO_MAP (plus it's uid, type, ptr)
> > > > - BPF_MAP_TYPE_XSKMAP -> PTR_TO_XDP_SOCK
> > > > - BPF_MAP_TYPE_SOCKMAP -> PTR_TO_SOCKET
> > > > - BPF_MAP_TYPE_SOCKHASH -> PTR_TO_SOCKET
> > > >=20
> > > > A better design compared to current temporary fixup for a helper/kf=
unc
> > > > call would be to deal with types CONST_PTR_TO_MAP | PTR_MAYBE_NULL,
> > > > PTR_TO_XDP_SOCK | PTR_MAYBE_NULL etc, instantiated at map lookup.
> > > > Wdyt?
> > >=20
> > > I agree that this is a better approach. This can be another follow-up
> > > considering that this is an independent refactor and the size of the
> > > current set.
> >=20
> > Hi Amery,
> >=20
> > The change appears small enough to include in the current patch-set.
> > Here is the patch:
> >=20
> > =C2=A0 https://github.com/kernel-patches/bpf/commit/e59423209d66e71baa7=
c66e5cda3b2018fcf273a
> >=20
> > Wdyt?
>=20
> It makes total sense to separate refinement from
> mark_ptr_not_null_reg(). It is better than the stopgap I have. Do you
> mind if I carry this as a part of this set?

Sure, thank you for looking into it.
