Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8A381B10
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333815; cv=none; b=XHv3it/01eWdQoPJ+RJbP4Pb7ln2/Pk8QE1EJ7nRGBlkQoXrVlHwKgtAfDt1pMSSXMncMW9B2/Fff4ggT6A6/YbT0RZ6iepfNUsAGhdEIMTJOSsEs4Y09FjVm+y4Ebh//pOVBfyUR48sFBpCFsM+06OHuFeVsku+YB0acOueUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333815; c=relaxed/simple;
	bh=7SDC/MTTU8hRFq3X/I2Gt6RG8V7YNckjVfDN0wPB6zQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tPBnrEJeQlZnbRLa1vkTu6i7sbCC1sinKmaCq+yl98aHzDhVHPtguEsxEPW+xkuXl820Y3hTgIp9RbWVP5m71nAZNb4KEhHfPrkPkojcpXNab2+6yY12B1JiyagFB2xkob9pGWF4EofwL+dooY059ho7WpzS+zUbo+FWyYh0OTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIMkmUOG; arc=none smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIMkmUOG"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c166aef4f02so67788166b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787333808; x=1787938608; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O2PTPfQYtKztKWOfpp7tANhwQtfUstakuw3wFNvmzQ0=;
        b=MIMkmUOG79hUAMs4RZtLfcYCZoCMDBHowwBJtu6K7SBTfQJ7oibQfpDAR9+jRCsbxA
         EKRLexxKhGUTL8Tg0+YXI9nmnQ3sa9nqR/opUWFS5heqfAqfbK0G/t1pCWSL7jfomHik
         htB9lMWt8oHwy7sMzGhlqLkQZsSkhY5aVG6MPF9zLR1QWF6qm8cT7fGw+4gm96mcUxRP
         P7JE8oZVN0ey76dfw9YDNwVBCbnk8RTM66cH/sHsif74tyQHZko37ue07zwLo2mnTNMv
         VKyK8PISp7U7H4zJilCxz72mI1ygUiRlCQswo80c9L2q5ASrxpLRVEqr2g+U0MelLNE7
         VM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787333808; x=1787938608;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2PTPfQYtKztKWOfpp7tANhwQtfUstakuw3wFNvmzQ0=;
        b=ii7wUoFaAR5ewV7SqHqr4XCnBi+5L5KqPaYffthQJF0U2ybLGsCeHXFlmQlgux3kMY
         gyOZO/O7KFsCMCNGNyMs2pdp/Y6idHd/W9arkgs2xsu0St4aLvql29gLYdmCQ4jqInk8
         00JMP7dgKOxp/s0c2MDyDphMhzSW/LOzUT9sQhPtwDJgNlzJL/z92pnGJW/kMG0xOF8r
         QHeMPhdE0GmvOi8EYqrs3l88SQ5jE/IS4MBff2omskWBB/h1OmfrZ3uAh2F8vYdhc3Cc
         7C+MK5RwI4suEl14t7hkOP3gchVsMDM772fuY9NgbFhKnapMTwpPPOUD5miTdfqnb/+m
         Zb3w==
X-Gm-Message-State: AFuF++mtwdAsR/yJLrA+lFkmZiIyjWBNKxq6waTDYejYiK/AC5D+3iWf
	alNAsYC0g5puv7vX43AcLtIRCP77J2c3QsUAf63cVd0yhRF8Ar0JZBcV
X-Gm-Gg: AR+sD12sak8X8q73VtItQtR6QIOAi68ANf5gM5EcPTi6xiM6B9PrSAqwRxTjKs4Ukh7
	fMoPFxg1ks6gIxjjzPGpH/T790n8N7Z01T5XQY88cosR8W/t3KbYpfrRYF7ayj9jLL7okXiuRAX
	1pPN1g8zdYF1P7EnN3LeIJsO+N2b7iYKuvJDcRZAMsKVXrW1aTjCxwCDWsOU61D/UgjzFDkL4oH
	XH1jep+I1a3c6mj1goyLV+LeBeHAv+C61LDHve0JZIPeBR1vOmLN046viod2Ee0XSKknFYGJ63N
	3nGLpbpBFhDsCqpqdC3/ejGyU/XyfxB0SL1LxjJ+MSOIOBkCQ6pbjPZ+lvKBYd27Bjo9ImIPAZw
	f2EW2L/vliDjysWszNLV+hrd5Yn490eEdalTrqdJjl0ZI8MlEotslvjpsOIUbcuo7cBa2JhCPNJ
	EneDa35oFqGu54kLwRZyyyO+XTTnY/OIq9GiRBi7zl2sPykfkejatPHyz/+mZ7CQqQQyf9isVNC
	1aaXeanJI7cCc6bUYrGaTc9wkJ6YzWNu+njC91uONyOX39dFBtUWJkTUCfg3H1Jb6uPNsTKCj5H
	50S2JBA7CngVqSSG9bspKH0LGkU=
X-Received: by 2002:a17:907:97c1:b0:c1c:64d4:5ba3 with SMTP id a640c23a62f3a-c246a651d39mr815803466b.20.1787333807866;
        Fri, 21 Aug 2026 10:36:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459197cd4sm580558666b.30.2026.08.21.10.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 10:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 19:36:46 +0200
Message-Id: <DKUSYFLEQ39S.2QP1DOZV5PZOP@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <netdev@vger.kernel.org>, <andrii@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in
 bpf_sock_from_file
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, "Syeda Mahnur Asif"
 <s.mahnur.a@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260820152532.621639-1-s.mahnur.a@gmail.com>
 <CAEf4BzZd7BDdJrNb+N3uktbwMJRHjUFzG1xfzmTDibEmAKX8gA@mail.gmail.com>
In-Reply-To: <CAEf4BzZd7BDdJrNb+N3uktbwMJRHjUFzG1xfzmTDibEmAKX8gA@mail.gmail.com>

On Fri Aug 21, 2026 at 7:30 PM CEST, Andrii Nakryiko wrote:
> On Thu, Aug 20, 2026 at 8:25=E2=80=AFAM Syeda Mahnur Asif <s.mahnur.a@gma=
il.com> wrote:
>>
>> bpf_sock_from_file should not dereference a NULL file pointer.
>> KASAN detects a null-ptr-deref when eBPF tracing
>> fentry/fexit programs are attached to points such as
>> __mmap_region and file_map_prot_check kernel functions. This can
>> result in a NULL file pointer flowing from context to the helper.
>>
>> A minimal check before dereferencing can fix this.
>>
>> Fixes: b60da4955f53 ("bpf: Only provide bpf_sock_from_file with CONFIG_N=
ET")
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Signed-off-by: Syeda Mahnur Asif <s.mahnur.a@gmail.com>
>> ---
>> v2:
>> - Added Reviewed-by from Emil Tsalapatis
>> - Fixed name in Signed-off-by
>>
>>  net/core/filter.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 16845987b244..7c3caae4bafc 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -12182,7 +12182,10 @@ const struct bpf_func_proto bpf_skc_to_mptcp_so=
ck_proto =3D {
>>
>>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>>  {
>> -       return (unsigned long)sock_from_file(file);
>> +       if (file)
>> +               return (unsigned long)sock_from_file(file);
>
> given this is a legacy ARG_PTR_TO_BTF_ID, it can be not just NULL, but
> also a) small value bogus "pointer" resulting from NULL + offset
> calculation and/or b) just random garbage casted to struct file
> pointer with bpf_core_cast() (maybe this hole we've closed with
> explicitly untrusted, not sure).
>
> Either way, this is not a sufficient fix at least.
>
> But I wonder if the proper fix is actually to mark this (and other
> similar) argument as explicitly requiring trusted PTR_TO_BTF_ID?
>
> Thoughts?
>

+1, should bite the bullet and accelerate deprecation of legacy PTR_TO_BTF_=
ID.
We can mark specific arguments / fields in structs as trusted where there i=
s a
legitimate use case and the kernel guarantees their lifetime appropriately.

>> +
>> +       return (unsigned long)NULL;
>>  }
>>
>>  BTF_ID_LIST(bpf_sock_from_file_btf_ids)
>> --
>> 2.53.0
>>

