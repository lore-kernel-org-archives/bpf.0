Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59EE2E424F
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357677; cv=pass; b=SbvG7SKdnhTmmShEpld28WmRGmvG928rYUiIEYRDp0HcVjghpXYj5SyQ8O1viLzCczm1UeT3V6WG8qiUlHbF9mfd1GF55OBxZqmMvrHeZKw7sWgVEMt2/j6nsYvU+9dVesT5lvz9tZ5jbbth412tNUulN/s/1BZ44Wfi5E5ldAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357677; c=relaxed/simple;
	bh=ZCkymTlMbYjM2Jgv7zubGpd6CV3qwcTJotFjegi+2Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krrmuey86VQjXUBXopWeEE+oDzsAAqipEmJj3KNZrUrAOS4flPLF9NdFp+H3+IukrFALjKWc3MrqHpa4XUcDRjZjzx9yHFDDRuH+/Y99Qf9xqgA3BhTsgCrLGX6ltM348uyi8lxhYvuPu61HJACPp/rXXGzBsZFchV8GK5rxM4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqqPV4pt; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqqPV4pt"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6501725d888so6609586d50.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 09:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776357676; cv=none;
        d=google.com; s=arc-20240605;
        b=gynKWWEI1hHuQUA0S5nPCBHyHmz1LGD45d1iM4Ww513PG63QNBpbmbym2xJ97iOHjc
         1LqNb9QuoMciKLVABcG4WVyoO9DuTCubpWPlgiNECOsg12FN9yyhjbA3fG11roOwOojj
         BiDkd85gBdNnhlr3ufIrV4NXonUSyKViZZlqTgOYIVQ98rRE+XM0yWrMKqenYFCqCdnr
         L4cmAscD46cvnMnxr4G8kKcyrX6XT/97ApLhqaKXY5KY/bRl9SsNJgvUW2hUwrhaU2Ch
         vkhXw+mpX4aA1/rsOoHrtwdtly+27Gf6sajBR7h9eQmC/bPBJF0XsdSriJvEifLU5Dfm
         ww7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZCkymTlMbYjM2Jgv7zubGpd6CV3qwcTJotFjegi+2Fo=;
        fh=k46G+QkEBkhTYCOgPcgjZ7z/24hNT1V/8re8Do7esjQ=;
        b=SbHjDJCs/fcPO4pEe0tMCLk+fPHEHji1vj74uHemVI1SaXvsrsTdsgl31LDGN79Aho
         jOoDAWWfoofz2WT+CVK7EZXi7scENLGbDcl0XlqchiE3VeBTxgPha81po8aeEo1nd8kf
         dJfjPppV/JvcG8+1pyg68gU7cX1ksROfuAyztqJM8/DsD62YR+YlRgo+0wdkRcRJQQIt
         Ln23FdKZbcfss/iTtum5dVfls52p64czvNPqgofyqxNBTaDom36SYXBmfdrX5b2i51lI
         bgNJ+E1gbxsOKhGMhiPous3nFFNX/UqxObd3NrESmmQeZOoZlWZMcZLOaMVmHRouyYVN
         tcYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357676; x=1776962476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCkymTlMbYjM2Jgv7zubGpd6CV3qwcTJotFjegi+2Fo=;
        b=rqqPV4ptfA2smyAnVMlU1BXQYkBbJtdaUAzdg90i9nFjb2ILGyAbYpqFlhifn9jdto
         Ah//wieTINiPdJXcjOSloUqRwsUNZwiHOJcyjN/Cv+PXCcu1tQg7xhc/nFRz4NPY/KCd
         xw9M6cyt0AtBgBtEufRzgsSQveqCmFkPv3jf51Oissfeu2XSKgD1dcYeCRxJQt3Nix3j
         9p3aZcUsSABUygQ5lUrRmgUEc7nYSGXlDpyWSe6SmaEO58MKNe2UGdrnA9YoXkciopgj
         tuIPuO4G4B3vH0Sbeq6weKSqhAhnlomLtcntvorebx028IYTQgvBcS3qBgBaejnSlXIO
         PTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357676; x=1776962476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCkymTlMbYjM2Jgv7zubGpd6CV3qwcTJotFjegi+2Fo=;
        b=Y7c70qRb4kJYhrmxd3nhd+NUoxgW9O1gLHroB5GSg1JW0AxwRsLSwhufKr6nJ4CUnR
         DphQrmHJrjDhuIg4ylqldPaXb5ypLGD0KWy1HfCR6e8/o5AytJOJBqYw6EYNZj+pdik6
         FDIiknA928o0H4khLp/IrIe9DUCDsXhmik1H5xWad9Ejr1MwOLH1X4X88/r216IWFZus
         dgIjrcAbo2nRch/SAMj9EsIlBE6bbN51UCStzSEsQClJwwpcsk4tLsd0iXlZK9U6EiWm
         1w1CTk+70cjJ+/dBIDOXELUdrXU2U7fdGKQdh4RDIVY3lR5bKnTpB485fUE5VQc1jMrA
         5PxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jpmJVFq9T7iZo7BXmyqWfZpyc8vz1jDFqiPI0LQRuxqmQQHbVLL1gYBm/FDYAMRgbfQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBynpfSbMKehv/l181BfuZsopxkatf6WMX+gFBHv+Vc2CsRUSt
	kxfrm4lKry8LcRgcJB5p1SpkVHvTFzN2jh6yvsXc0fvx0cyrGrPb7XYz57/MQNvWSbfAnspJJtM
	XKvN/BALTIltHjZMaLpPdYl1II6lozQg=
X-Gm-Gg: AeBDievP+HkOsSonlyOPFhv9zmMQLTE7q5nPSs77IaO7jTlC51mDwFIiu/cw5ndjPpK
	wTSvIyzeYdVlWa/V66itNmSueJdlrthWR1Xj98ewDzXyFuWoIX36aLoh4DSqe6U1S+lpjNcnJxQ
	Z5ufc4xSXaO3S/Aig7QDDcAyWD/5hQgjewKakU1BnlH/jrtqu+tsu0rfq65k1ttkLkc1V4fuTBa
	E4X6D06nznUobSud/oSS7rY2l5R6HIGWFkeTFlJsqOacstHJnYINYD+ZdGqwFBDqDL7flWavpM7
	ymOIn2zoFEzYzDTsJtoOnGnyTZPuCf7Atdw23tsVqd1dXjq5c0XWHkKt
X-Received: by 2002:a05:690e:b4e:b0:651:cf29:430b with SMTP id
 956f58d0204a3-651cf294640mr16497847d50.12.1776357675652; Thu, 16 Apr 2026
 09:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416144808.149543-1-sun.jian.kdev@gmail.com> <DHUOZVP8JZ80.28GPGA99P0ORD@gmail.com>
In-Reply-To: <DHUOZVP8JZ80.28GPGA99P0ORD@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 17 Apr 2026 00:41:08 +0800
X-Gm-Features: AQROBzClBlvOAFz1tUWZddCMy79tEJl10vNs0W2s8S8p-heBZnoA15xrRfXktjs
Message-ID: <CABFUUZEi1tkbzZxbT4FQuotVxFhoe_Gk9R1Ov7dkWf1dDqHUjw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: reject ERR_PTR map->record in map_check_btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 11:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Apr 16, 2026 at 7:48 AM PDT, Sun Jian wrote:
> > btf_parse_fields() returns an ERR_PTR() when it encounters an invalid
> > special field in map value BTF.
> >
> > For example, an invalid kptr-annotated field whose tagged pointee is no=
t
> > a full struct type can make btf_parse_fields() fail with -EINVAL.
> >
> > map_check_btf() stores the result in map->record, but currently only
> > handles the successful non-NULL case explicitly. ERR_PTR() results are
> > not rejected immediately before proceeding with the rest of map BTF
> > setup.
>
> yes. So ?
>
> > Handle IS_ERR(map->record) explicitly in map_check_btf() and return the
> > underlying error code immediately.
>
> why ?
>
> pw-bot: cr

Thanks for the feedback.

What I can show is only that an invalid map value BTF record is carried
past map_check_btf() on the old code, instead of being rejected there.

I couldn't demonstrate a stronger observable bad outcome beyond that, so I'=
ll
drop this patch.
