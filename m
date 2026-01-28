Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF142050
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558508; cv=pass; b=SQVAJVKmSfO46h/fqpq+V99ILxR4tTZeQyaA22nr28I4JYlGhyjC+9g2cVlJ2qzj+rO5QrEzbzGETN1iAvPR3deYOSEx08xrwDnXOuZsZF8oq/lmmUDilVEk8vc8rzjX2qyioYYiCk/jnv69w3t4kwULvZPSYG3LJ7xgZO9DwvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558508; c=relaxed/simple;
	bh=t9ND+D5Du4/pUmA8SLHFQRJz8FQvv0JX4f/6qtjwih0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc3BaiM/GLpM3OSaC0dYVWG/04tUKLifzTR2u5Dhe0YJspI74zb7S3iHHHxLheJ3SNNOOLNjmd7n7HdZgsfLJpnMbtHj3tYao/YiEf6AUIhbpAPAlu2/CraxI6SCg4Vjjf7iDMVoCvykfefzHSbJRO7FDpkIhVAgypesZBdURU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbRIKJrV; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbRIKJrV"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fbc544b09so4634702f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:01:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769558505; cv=none;
        d=google.com; s=arc-20240605;
        b=O/fdpG61ixCS9ulfskrQZ3LI5amYLCZ1+Y6YLg7Q0wXiTE4IVpxqEvVj1HSyM8jTlS
         i2afrzOtRMR/BxW31Hhtx4ci8LsgypUp2RQPSufZIZe4rnlg1sT25Xn4RD303ewYAVH7
         bU8GsEXW8kfU9qYjH0XwLXVVNn0/dhwDo3OgNhcnJpOEPIL4BnZxr5q3USwkf5bTbgjH
         aPa0XTX1QA4MtUTFCGu5SDTLgOs0JiaiO7Jv+nR7zFfq8t4B8eAC4GTkHLDQ3TjPCUPP
         Ef7bwdXz2oCXzEXa1JDxkkrJjpzJFO1NprsUVjxNx8ohdt2NtFWMI9zhxZbcir2UqE7Z
         D5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xPaNXmKP8WFuqQKdvr8nCixPPEix37KywobjisK4ZhQ=;
        fh=QFCKBz+bFHUY0exaAOG6K9Mhs13GMv1YfVf4ZOBvWic=;
        b=Lnt9Xi2rTyk1nWYFl2eLLY2tVzYjk9OZWNULlLqAHF1albh8Yw3YRKAFTnhnLpUs2+
         z5UKtW+MNLhO0TUVTZs56e+UylIVfN8p2uRsmrWQtTnuENnrshROPI/aWi8gp5ZHZMIH
         EOOHCge+Yg6Bo10ZKnFXzEPe6qj9M6Vc3JhKYXBOeomsM3EBtMtqNrROqQaCmTCDJego
         9Od6b0E22UBVSjdFj4qfMddv8dppvpO2SZb5Lx1MH+KoCGC6Xl5pRdzX5DFqXFlprQnu
         FvOig2JL4Xp7aY5Za/MO/s9DNpjducA1t1/Lo2uP0eLZL94dQW9Dfk/lgiptO3+Fz2ry
         uD7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769558505; x=1770163305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xPaNXmKP8WFuqQKdvr8nCixPPEix37KywobjisK4ZhQ=;
        b=AbRIKJrVA1ykxHY5ub13rbl9TAKXQPh376Bl4pWOjbcqTnnYUzVoSmIJb3RD2tqP4w
         be6FsoDnDhMzyFwfdx+7yUzjWrkRAN1BuKCuEq21SsYpSVgogU/bVLCsSaSUjfkApVcd
         VWLxKEdMUJMe0qBrukXazwiPK1GluJMBNM2EHA7BjsU9NkRXD1I/ET/vOBqDFBiffDgg
         d8vWmmgbzYloIzmluU97wh8kgLGkNEkb2kx4scsIXRh3aLD6Hd6iCJmpVMZpS1m/Hc7d
         A1itpbPRt46bCVi7iFmxytHcSN/pFC47Sr0zQR3CPiUuxxBu/X7+5B59A8tvhxshWGqs
         JGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769558505; x=1770163305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPaNXmKP8WFuqQKdvr8nCixPPEix37KywobjisK4ZhQ=;
        b=iBhXmw2Ll40gLtpSZl6CjHzfgoWTV2FcDRsB+zf/cOx6tq/iAFQKeurCZmHPDAYMHj
         NjxWGPRD+WJPN3pPkNXG/o7X1Ba3oLOtFNnd4kV8g03BNzctR7aiL8y63cXZYtIeMpge
         iZED7PTWDrO4UWVs+UqJ3d/zplcphMdVtv0fJIK9QyNnLereAv7czJiwLchUIIKd2DZe
         dQ+D0kfEuhNJvwhfnYmt+ndMMbFAQeQQxxQsCNDlu8CSL8ihA7v/qx97NGJvfTdCKVau
         lMFQkfmNPmI1sgFCDGjhRoGr5aHcyh1mU+Zhr9vo0B/mZSE+5q7sfdMBeB89ryi2r5LJ
         sOzA==
X-Gm-Message-State: AOJu0YyznZc4zPzNbW+HcABup5YLtiFoQzFiV9Tw3P+j98KDIsyITMsg
	us3rQXQtAGCtGj/XmhlW+UCGKvhzeNCgy4VSTVjDDUC5PPw+Y6my5WEYK/TX+k2tzJ2ikH9qnLf
	Dbhpp8NrGYwBi9lT7n9Lh3WOU2a9wZAg=
X-Gm-Gg: AZuq6aLIbEAxT6it4aylDWFVqR+1JwEvTp0S9qrjWbMoTegfn0/RLl0M0EQnU/RElKc
	a9X/idOqJv+JZDzpGMUcDdiEwbIKtZKnlps4wPdzvsoyvQuWGjSxihMJ/tcSrzDPfJphA1mjeaA
	Ll2d9QTxLjFJqvc5pkjsqjJGlcOyA5UWDzFoKJf3EJNGYVYx0NsRf9Pb0O0KI7igAM+xffLg2RH
	ERq12v3WRcuqDu988n8kIIxeu+o5UQZXuRlJk+T9S5FDz9YqZZMMIj/xdgOLnL4smRk2ujeoAyP
	68Cj3ifteU7fBI0W+CCPBE/KscxhDbY5CfpUbjI=
X-Received: by 2002:a5d:5d0a:0:b0:431:48f:f78f with SMTP id
 ffacd0b85a97d-435dd05bd92mr4594551f8f.1.1769558505342; Tue, 27 Jan 2026
 16:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127181610.86376-1-emil@etsalapatis.com> <20260127181610.86376-3-emil@etsalapatis.com>
In-Reply-To: <20260127181610.86376-3-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Jan 2026 01:01:09 +0100
X-Gm-Features: AZwV_Qg2KQJTE1wpiiHX9cStrJTjEMCBE4aEoKyjWu_f4BD2ng4lEJSfxzDErZM
Message-ID: <CAP01T77RSLLvkgCG=CujXhyTTa4gg_MEzu9yUYqt1icmuODM-Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] bpf: Allow BPF stream kfuncs while holding a lock
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, etsal@meta.com, 
	ihor.solodrai@linux.dev, martin.lau@kernel.org, puranjay@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 19:16, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> The BPF stream kfuncs bpf_stream_vprintk and bpf_stream_print_stack
> do not sleep and so are safe to call while holding a lock. Amend
> the verifier to allow that.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
