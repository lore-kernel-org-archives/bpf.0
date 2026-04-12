Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97078271464
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775999324; cv=pass; b=lYIipmCuOJz8AxgnderEZna1JCo8IJwk8A7jiHBNbdHQkFeG/AlSAA78ZMX0px1TLyvmIhFZFTbrBmCcAB4VawFvdwWuGm+WpZKK62fPJ1obR418JWsH88X+4e3f+sRE0QVwcypKgNkcWDCkAjkBsKYz3IBqVKsAx4+7rqA4i78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775999324; c=relaxed/simple;
	bh=MhNSVDq+Mp4atqhKE+k2G9tvL4hBYd8ILox5fx+oqq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNpk/6iuc03vXpdXaC0bV6s5ELGN+FijecyzWUfsXjnk5EiqxZa35VP+Y93ghrhxMklNrIcWs3C4/aMDBz735Rq6C/XNb0LBLzjNo7BGIfxpvlYZPlCSz+NfLcqXJdOHIATG0n2LTEutWhU14892i4g36eT1KTBgRioG9qbMYR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuLJlfN2; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuLJlfN2"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7a17bc5745eso33165497b3.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 06:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775999323; cv=none;
        d=google.com; s=arc-20240605;
        b=eUQbtC7caygfrKA6J5xHW5N/XJrfbVPwMTb4RlzFTMVC9LWnCARLmC0ULSbs9Ttulb
         CutXqZeV2Ch54PLZApSevpwKtDwFeOWAjQ/nuhRl0jW2sJBQlpjCIjW03sOTFvqUkK1r
         722V8f+LIoz+h1RRLAos3PpiSyzBjranm3fJ6wE9BrDH7ex8T8WS2SZE1MyomCkiCX3o
         GFaXzprtrW8dgZV8NOXlOEmX3/iOIbOwbXyCFanTBSaH9mA+oDNm8FqFjbTds4qTvfk0
         w+5U0Xq2H5MF0SZ3g9kw/jv3rygusl3VjpyEwsNyLyKqW1jlXoZuzK+aOubK8AamTdGC
         VcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MhNSVDq+Mp4atqhKE+k2G9tvL4hBYd8ILox5fx+oqq8=;
        fh=zkpf4b2ndjNtM09+fSDmeTkdWHaF+E+LAkYWkk1TmjA=;
        b=k4oaEjWWooskFAGbe1FwuCa8cjb0XZbnNmf2ZE2R2/o/yCYxm1OF2YBFw+cReFMYea
         HIiMalH4m1KgGhlRNtW6KYklcL973QVjVXRl8YZBGuUUrVtIV+fBiALlotw/zCpop9as
         k6/KhwhycAhhufzOXrgOipvV2552jJX0N5g3nWSSS5kexd1gN/C3WW4X1E+9v4OLmOQo
         qnSlBlYW0R61Dlx3wq9OdxqoFTlU3WXssiuXGi70IBmjf1K16T5XO8yOpwsVkkH+OlRJ
         aoA5mQgm5Y8fk7rLhqJvzI50p8Di0IL32NuiqJtlGdly5rhi1h0M4ZHXdFeoXEiMMXuX
         L7+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775999323; x=1776604123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhNSVDq+Mp4atqhKE+k2G9tvL4hBYd8ILox5fx+oqq8=;
        b=kuLJlfN2DofUdwT+syoUrQnMLqlZ2KfG0EBZ1q/hifobtYSVUf8KPZ+5/xpeS65+2C
         qyw3K6M4M9KjNrd5JZuGUGe3phaSxvCaCJzvrr7jmZbajOrDNQH310++fEFEenwmy6lB
         Vh9FDFQ/c85PE/z5N72aABXIV1fup6Qaqybice0OBLoS5r2LtVbLd3fkDHyX6a8LMhnj
         +E1+2MLUzdYmAh9HtLus2vxfQUL2HsxFmxvykoosuzJ2IM39eZU44BzhIQk6SSMpi76B
         TTNjs444BUPjEe9kbqlQ6JzCBO87y3LZ0lg9CPvAyTrfY/q4ZCccUdaHwMOX/JPzZIQO
         Yl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775999323; x=1776604123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MhNSVDq+Mp4atqhKE+k2G9tvL4hBYd8ILox5fx+oqq8=;
        b=n/uiRK+1mtxBRD83WsCT4CwGnNdjKJ4ZoIf1LUCzJIE7jFYsyA0ZLMt4G3HQZz0JMx
         GiGbert7591yhlDFq6qMM09PdQI/ofE4RCS0/+Zbb7mIjEG2a+FwT5L7XBNOTwmhwSxP
         H0izhrD7TPZIq9lqhHcJzWf2fcA6E4CkJNbDMnF/ayJ+FUEKku5j878SgREHGlUcF9+m
         lNEY3L/GAzg7VFJ08Ggw58vRY05SNLKfN2Mn3T5E7E7Jrs+h6L2PDs3SZQJ4CiQgat3q
         iIdUITXVz5QZDwTJvlVrjswa0OLANbw9Vv8w4EfKS5nxBmu60lN6cR/pTi4axSifkwYs
         xErg==
X-Forwarded-Encrypted: i=1; AFNElJ/0yaPoAnoSbfFK72Z+WUkunCQT6BtO2UjiBjktirsiZk27e97vXHuZOZA8fiVEpHuasUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpKRS2G3x6E6xfDXWhgV/pnh1suzIpBi+UjftE55Ruw+9NeHn9
	r+MQPJRZoBomqQJl35Lx6ecCNTwlaf8Pd5Zs8Aifbvs5g5KcWj7M2GMJsHZp47iGr3vXEWMCgn7
	tnprtXNoxyRWPG2OU4pnwPs2B8DS5z/s=
X-Gm-Gg: AeBDietcnQbgcwplrzWE8b4NVe0MnFwtzOxaXRfTfRcVXlGYVKnjx7m8mHiM9oc/icZ
	p2+QwhCSr/nA0hzcY36PyMB01RsWTWQm5CHZQjiA28szL8MC7JrkX6/zxrjgDUMXn9xbxfv6LxZ
	IIsnSIhO+0z72QJ1CgbBmXfmjdXx/98qmldBwWZGgSUMVEYHeNHdl4SH8LUskhkNJ+hyByC8xI2
	K8RkVNPaEWAeaLcPnvd5+U9V1sIrLbcMLmkx6z6YKuW9x+U9fU3Ov9a88d8OT8xTSgPQIA8CCNC
	bbJysI1/QTaXMiH5L0JRwacUr3/HQ+SQbS30JrvQ
X-Received: by 2002:a05:690c:e645:20b0:7a6:1df5:c99e with SMTP id
 00721157ae682-7af71578411mr84093067b3.30.1775999322635; Sun, 12 Apr 2026
 06:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-3-laoar.shao@gmail.com>
 <alpine.LSU.2.21.2604091145340.31526@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2604091145340.31526@pobox.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 21:08:05 +0800
X-Gm-Features: AQROBzAclerg8yyA2S4z9obC58pWuFg4E2KRrI1OP_QkCniXP5TtVECzkOzNGHw
Message-ID: <CALOAHbB5yyj4wJBOZnspVUPfoyumrxHcq2e27hzY881G+Jc_tw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 5:47=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wrot=
e:
>
> Hi,
>
> On Thu, 2 Apr 2026, Yafang Shao wrote:
>
> > Introduce the ability for kprobes to override the return values of
> > functions that have been livepatched. This functionality is guarded by =
the
> > CONFIG_KPROBE_OVERRIDE_KLP_FUNC configuration option.
>
> this is imprecise if I read the code correctly. You want to override live
> patch functions, not the original ones which are live patched.

Correct. The BPF program will override the livepatched functions
rather than the original ones.

>
> I also think that if nothing else, it needs to be more specific then just
> checking mod->klp. It should check if a function itself in klp module is
> overridable to keep it as limited as possible.

That is exactly what I am currently implementing in
trace_kprobe_klp_func_overridable().

> Even with that, the
> concerns expressed by the others still apply.

--=20
Regards
Yafang
