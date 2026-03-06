Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48E34BA4E
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 04:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772769637; cv=pass; b=AkYFCWns1z+kWkJwmO69KaqxVe+13yZl1vTMzki2QjCFIHJEgPLdnkyDE9Pq6i1Ld4oJfUXUDUjq4w/GUI93otH47op4t4+sqePH17Hiur42g09cIZvZa6XQBWWbYOhNEbCPyVGIU8Liiw5a54q+lKsYnfH83gMBTd9smDCi38E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772769637; c=relaxed/simple;
	bh=EJcQlOLoIRPZmT4lH2Gt/68yCltEAhXaT9/rQyRasrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uywktfktlZogVvtamZ/7F4jcXFdROSD2uux2Xf7f7v2pcar8vCGLztliqG3ch23TplvPVhvpNFbjHhBYT0SojP3jXhhAmcCcFnC/I9xJdaUStwv0VSdX15qVYqGKPsJhDOnjM8RvmxNn4xWhMA86aLxsKJ734WfcYY5QUho+C8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPvSoPSu; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPvSoPSu"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439cb5af25bso2187754f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 20:00:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772769634; cv=none;
        d=google.com; s=arc-20240605;
        b=JvOVPbVsOf4wJw89ZnRimhzMvNHZsw8H9ukPfKS7ZIDDZ04qGrHXv9iBhI05co+F4h
         dGA2y9ZEIQrIrdibk4XrihRkUeBc0n1SJU0vWBNrDZy8NcIAaDAG+1HeAKT3QaVF8yna
         fmTYWwIXtXIBuClvN+z1MI2ppuadIOZmXVyB8uXzLKZnCLgmDZZmNTiViTseCRlbn07Q
         jl4CpNwmzIAavnkzjdjdUDzIwSIj4Z2bnjHe+ei63GMo0Uebs18BvkHEsLRwKfMdNt/5
         dFwakA/iFO5TxvYUU2vWqcly9nCt+Nqx9LTLqFHjxqs40nSinDtCyy6ZOLqgndfuqHCf
         FRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EJcQlOLoIRPZmT4lH2Gt/68yCltEAhXaT9/rQyRasrw=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=j6D/FD13FmQKGTsomBLHJ8kaj+KoAm2HRZ5MzfBnWl6bIX1Ztxhh0g6ndSpgsHLOWN
         S9NHNbkn4128IIrOmIeLoYacF16eGngSx5hF4+i7TEznISNZito3qX7D1VtAs4vH4MnJ
         WDrciJmlZ+LLGMy1w54OdyYVoWzMZdgZvEd0rKhOHnzGWNNZN7j6IkUAmCE5reAMsmQC
         oDGgYvmBghEIh/DkvuyF0Mx/H/Mqkdyev7tJJCvADL+DH5+fo5sYS9yDi8vF4ICN6HOD
         +45OAPkXOatpwKOqVCGU7BtnQ6eHVueQiD3StKdV/cl38hthQ+AhuiW4/RzDLl2nySfI
         4NZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772769634; x=1773374434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EJcQlOLoIRPZmT4lH2Gt/68yCltEAhXaT9/rQyRasrw=;
        b=jPvSoPSufcnLYajFFEIJvbu7B7Ace62c5DbhGcSG7UAX/+AwFyU67uxPXx/YYq/J2H
         uzyKeurOH8fViCVsdIM1FB2OGgRA8adAuOnezpyqCkylMl/FlLRxD2Kf/DT1k2JoEYv1
         iWYYcwQcjleViapCNg7J+n77wUNzPC4XglxyHAQauWrMK1AA+UlAa6LeFpEO3sbbq3hw
         WBoI8gUYR4VNXEq7jq9F8mgCvsD9PrFqEAcJOQ0OjybJFuUk+XN+C6V/r+lUEd4HsQ45
         4pM7Goq3ToDEfIa2VrHw4ejoZxOewoELGqQPBQ/r1g+eSgCrRS7btNpzsxd06bY+ubSY
         F5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772769634; x=1773374434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJcQlOLoIRPZmT4lH2Gt/68yCltEAhXaT9/rQyRasrw=;
        b=rPtTTyKAk9k/zjkuY2GvRrvMLUKZGGn8obEAs54CjyZcMN4Xz0sIDw3+2cTSqgkI2K
         rNRXjcynXpxv2b0baz2uTgR+9/NZyvIAfNoPtAfk9A8KFXzxi0mR2OCTYnGsqqy04TU1
         v3P3mHCb4XJPclkCuq5qEfn1fqrpQTNIefZn62LA0U+3+5+TOnj2ltLgDrNHHy7rRjfz
         LxNu5P6GShZ1GtJStiLQaePQJPaV9zjcybj64EiD3hUKnT+UYmcSRIosk+OotRhmz+Fs
         sOJLFcacPlqurn5gmc5Te9axbBy58pzNI5NDXLAdqBhBMye0oZcPp1w8UHsoHQAwns6Y
         WcFw==
X-Gm-Message-State: AOJu0YwTo5Aw7k5d3O5qE+kNv0yGq4JJRNBhalMZQFkNZxyWlNQWRZFr
	CyXrNgIVh6RPZHA2W9gwCyX8RGBCFaTJwXkdhKdC42cnO+fNCyev5v09D/JxbG9aJWb5nTXyaU3
	aui0Jiu+YoEZcOgEVTrnGQ1HhxEL2EzE=
X-Gm-Gg: ATEYQzzwvqKvYaMME52BS30BkhcVhNGKNMLLMm4oT2oQpvX/Bn8R85HJ70iv3X5F+Kj
	OoGYIhH3rB/AjZ0TreDMKpRkYnqynkpi8GXEA0qEeqyF2s22uccdfiHhB+tdnrDDQAanqnX82xe
	0D4qNgxluUYMmPGPAR9WRCtsFVRVsAOKtqYMcCZpy6AJ81cr9PeoTI48Pr3If3ha78YOuL8JxT+
	Q7PfIHOfTfp+CNjhuRr54rxBwCESu6ehuqkXbbivc8YBzSWxN0QtUzB1exCSJrdAt4v5UqrO4Ug
	ZIe4dPmjCQtJ4Y/Gid8sRuw+blyL7iBxGEUA7sUN1se6mSNeVmtjMgXXimM=
X-Received: by 2002:a05:6000:288a:b0:439:abcd:b2fb with SMTP id
 ffacd0b85a97d-439da67c00emr917292f8f.32.1772769633852; Thu, 05 Mar 2026
 20:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com> <20260225-sleepable_tracepoints-v2-1-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-1-0330dafd650f@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 04:59:56 +0100
X-Gm-Features: AaiRm513yQ5DFu-zPg4_7Jq2abdc4JYZlTkr28uXuF8auBpIYCPoXw5Xqr_75Xc
Message-ID: <CAP01T74G-KdwEbY+v9yTKLC4DWAtPyooAHimmX9K9jX31MJAZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Reject sleepable raw_tp programs on
 non-faultable tracepoints
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 at 17:24, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add an attach-time check in bpf_raw_tp_link_attach() to ensure that
> sleepable BPF programs can only attach to faultable tracepoints.
> Faultable tracepoints (e.g., sys_enter, sys_exit) are guaranteed to
> run in a context where sleeping is safe, using rcu_tasks_trace for
> protection. Non-faultable tracepoints may run in NMI or other
> non-sleepable contexts.
>
> This complements the verifier-side change that allows BPF_TRACE_RAW_TP
> programs to be loaded as sleepable.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
