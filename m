Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9E38237C
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622076; cv=pass; b=RiDGTeKQq5Z9JZSFO2nflpiAU5TYTXAeBm/S+Pk1jdvgP6wq2B6K8rYeuf0+Mcl9jRKo2C9WTo+wIJ2h04F/GNroj0AXnmC5PkNDDRi0U5JnOsdXa3fSNUsRxiCURsdrM/dAtLbiGXFMldRYur3q0/QlWOhTao37POwyLLmDjD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622076; c=relaxed/simple;
	bh=OL0tJWQA9nR9g1pJiMuT+stdzGeBCi82MdUJmT1n4mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCXhflE4/PLeYWiH6Zfr21VR2J7iAEcUy23G1PZg40j2r98Uyt/x05tNQIOjBiROnfsvp5LvMfrSQE/yxoMrdGNgCkeg2P/yR3GAh7BIE8J4SY8s//5eWBEjehDYJe1HOlO+ZCRylEoa81W3dkCCj46gx1Mpe1QWxeOMKn+G0ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGpINWEl; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGpINWEl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so63919805e9.0
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778622073; cv=none;
        d=google.com; s=arc-20240605;
        b=NBJANkgsgOGD4Kxk7J2+J2e33ikdq2sIDCyk8nvgShXBK9vTYGb0OGKNtkW6xYU7o6
         irvcc4OI/l2+nmDxuMB7snL6dmSnFv2Y8/6sVrqZXQs/7yy8XZM7dj7Bqv1fTrAcLs58
         rBlP6S4ORkWo4eW95D4RgDYEhmCGhvLi0zO6Yzq88/R8TyFK2/4wiaGOV9Shwvm49GyH
         O90XERAs4ziLI9UnV0dM1FQ/4mJMITbh+yV+unhjxULFaMFylE3rQszHGxRQ3u2nZbWE
         xT/13dYiMez7NUTyEz1GQqBiq4PLoMhCXtchTovVYzmnlgPMy7l/TlpHJekzl5HTdOOn
         Pe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnJRcPv3anhQleJX1h9scyF+CUFzYP9DYRqjifTE3MA=;
        fh=YKdUUT3q1GWwy+eGKCBfK/46DgnOgUlgQIsADNa66I0=;
        b=XXfex3FaRVko7ruZ6NV3DPfeMUiKSMAaTkn2O9co0/d46pd/yE2gf+s2CS1bgoAc7/
         J4LYtpA9RA+k0yv6SeC227ya1PrgpcSIN6x3cziIz+fcHj4Vg9vxbpMkky+OltUivER+
         MmUZV2VeafQAksh7lhZ5Unua1eyr3DpT848BMVZXM6lNrTZ++o6a7YPLbpOH2tB+j03A
         DO/+nKnFgWwK1nWhAEQN6R4hfUA9b2tFZhyqocIxtlAZSSOhG3U19UT7jtR/4f3dghnd
         Xi+XOkPIbSTQmb6+YNCNagpvYTwHJZxTiURnvIOIiMCPfDvhyTHYkudghKmmndRGkHUv
         ZbFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778622073; x=1779226873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnJRcPv3anhQleJX1h9scyF+CUFzYP9DYRqjifTE3MA=;
        b=FGpINWElPtKoFLRY2FckDIMBrDyzWZPMw4BUTcgnZmJjyRGIC7BfHXkuyzw7gro0oe
         /lplmxMBaYJ77kfMvX2NPtlfjnnXejSn80Om23usnMYCsooicAJgv5U/+gaA9Y56ZgbU
         qyiGKaW/sM3LFFfTOBYIwakisBzNllKXzoB135Hka5q7meJ/OOkhhtq0rQI1zlxa4ol7
         2w23N1tUpr/5G9XTlUbFAKg6e3Mfif+jvyPYFarq+7jI7AuO/vSaodwcAwy3qF31VDJY
         OgooGZM7Bff6MIX0HDCd4EcOFEgWBcyTxp27SgZx/4SR/4yanaQTwcjub3H6YMPBJjT1
         /g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622073; x=1779226873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnJRcPv3anhQleJX1h9scyF+CUFzYP9DYRqjifTE3MA=;
        b=E2d14mVzJhHZX0mluQKP8c1xUAXniDApgHAm5vLCmgB6bjMYtGS0XSet9PwPFxmUub
         hsaSKwLlpS9UGtLDMtMcMYyByKveiPA1gDj6kRXr2PHS2ZxPc9chMLiuCDyzGV1I8GLF
         Wg3NpvYLxQ8/dIaw3fWUsaglFXPibMDSQYyeYD6kRAzEqmEEO4ri5Nc2bPCN/KuO5fi6
         DbvkQkwAkSihLGBVUEPwMLETiR7GBdLXklY0evnIjuwCdSzGFxzUKWDuxJhL7rtxgcSe
         RFj9dwY/8wZKHPt9KqB25RPhRjrh/Xrqj/fYjLqeA3W2Wa9OpTTPb8Ki9UiT1UPBQ5O1
         wxZA==
X-Forwarded-Encrypted: i=1; AFNElJ8kkadrlRYq6oLCdfApQuR3FI+kkmh1PylZkrRF2V41l0pcMF5zTMTuwNAw6PYK227d//c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCHI7aamd+STSxjRA/Xu1VwiMQ+SHvjnnKe8laSnrO4O4afrN
	wmUrkgkLx3dNNkGtBVta+pdYO6byyF4AfeGL39chdEWK9zImYUG+gtEtyntqGiZgQH0Ckft6Bxu
	zQBjP9irGWaogD5+BZQJKrm9h3sZpIYc=
X-Gm-Gg: Acq92OFiCJXGcT8xNua4FVxB1AWuINbq+uc2U0/STwpRs6kygOU8eVMqi7Sna7m7Wzf
	YQlySCPiLu3JMb73vDK5FQa4Y4iZ+Oa0xcehDIR7heqB6jWJ5QFg9cXe6LVz8wXSK4Uiv490UIR
	Zpru5BHJ9wIOiPt+TPlaWML4hqlnvaJtslV8P49ImCyfkkF4CNbT58sWZUOP49eriBy5zIsVwRt
	gVwxuRn4jBav3F7ZUNovD65XteBZLcSwfPNCUN6ouNdgJxDu3S9cyLVQGUbLkFngI4iettiRXM9
	S/m02hVk6tnHg+SREFYTUyPSfV5nVffulGQZSH9g2VTkvvI0oHQtqP7hR5fdH7otg8f5tXvRDrN
	FLJU1MvLSsoNsZvZRBBWBbLEtmg==
X-Received: by 2002:a05:600c:8b12:b0:48e:978f:c45a with SMTP id
 5b1f17b1804b1-48fc9a3ba11mr7323355e9.19.1778622072979; Tue, 12 May 2026
 14:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510030136.27876-1-chensong_2000@126.com> <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
In-Reply-To: <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 May 2026 14:41:02 -0700
X-Gm-Features: AVHnY4Ll8E-0Y0MARZjSnurDHCpF3Z0mdURWN0DP9-EQbxc1KT5-WLkoRfNUfok
Message-ID: <CAADnVQLNLd7kV+pBV1i7YvPoQGMVzJusS71iPs6oc_K0Qpd9fA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Song Chen <chensong_2000@126.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>, 
	KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 8:19=E2=80=AFPM Kaitao Cheng <kaitao.cheng@linux.de=
v> wrote:
>
> It seems that there are two problems to solve here:
>
> 1. Allowing kernel modules to override vmlinux kfuncs with the same
>    name.
>
>    This should be relatively straightforward to implement by matching
>    names in kernel modules first, and then falling back to vmlinux.
>
> 2. Handling the case where different kernel modules have kfuncs with
>    the same name.
>
>    Could we use a new libbpf API to establish the mapping manually?
>    for example:
>        bpf_object__set_ksym_btf(obj, "kfunc_name", "module_name")
>
>    Or define a new attribute, for example:
>        extern void kfunc_name(void) __ksym __module("module_name");
>
>    We probably need to hear suggestions from other developers on this.

I'm not excited about 2.
Two different modules are not allowed to have two different functions
with the same name.
The kernel has only one global namespace.
Hence I don't think we should be introducing such namespacing concept
into kfuncs.

But 1, I feel, is useful for experiments and mitigations,
but it probably should be done transparently to libbpf.

register_btf_kfunc_id_set() should be changed to return an error
when a module attempts to register a kfunc with a name that already
exists in the kernel.
We also introduce override_btf_kfunc_set() that would register
a replacement kfunc.
override_btf_kfunc_set() would check that all overriding kfuncs
have the exact same kfunc already in vmlinux BTF: proto and name should mat=
ch.
Then the kernel will just remember that the address of that kfunc
is in the module.
libbpf doesn't need to be aware of this substitution.
It will find kfunc in the vmlinux BTF, but the verifier will supply
implementation from the module to bpf prog.
2nd module should be able to override_btf_kfunc_set() from vmlinux
and from 1st module that replaced some kfuncs.
All that only for bpf progs that are loaded after override.
Already loaded progs don't need to be live patched.
Thoughts?
