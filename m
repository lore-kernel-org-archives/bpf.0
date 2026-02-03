Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44322D2493
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139835; cv=pass; b=eL2hYx8gfpbAGnxrHDnuF7DrwUFNVzlGyKtPNzvg8/7jDjAbigpTMP4e34gi17ilB8aL1u+ZyA8Jw04Vej+GAsa/7D062wWC9U3tTGRuEoct14eqNMP6vNLYMjJ7mszSVxQEqk287R2rpF+oN1wa1i2ez1n9IzuT+g9LNK9dXXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139835; c=relaxed/simple;
	bh=LxlUaTqFKS7In2YCjf68ejlYEd1ZJJ/0QkdlQrU0/PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4gNOjZE0xVmZiQgupvkENSAOG90YkPF1OWQAruo3mzJXPMOpLpiIAWTTJ/Fhz7Zl7FKOqk1eWx+Y0o81iDzzI47OuHDOk27EY9Qh8mF1sB+a4RqebZO7d+SGA5erwdQizmdkcDhwv7TiH4/LKAKIqvJc5H+rTPMcD1PKMSEA+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBfElG+q; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBfElG+q"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so43402425e9.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 09:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770139832; cv=none;
        d=google.com; s=arc-20240605;
        b=SwSt4NW1p/X/0jtt87BSqraVPf5W7SauhrUeCdh6gPrpa+VWH77+CibHjKMhnl3ns9
         oocUW6JrshBvBr7CBCPM18QlSGBvRoZww1YqPproU0pISzs7/WBiVmJnO/0pLdnqslS5
         xfLr5kjQnoFRJECt2kOgp8CIXaowksu0NuvygZUnl9BivsCsNudgyyfB7wVImuRcKJ4v
         XmXFJDDmipozUIxo6S3nWvbdh6E7Wq592jFBPaxxjEjJeDhtNCwmVejImpzteY8o9Ixa
         ZSkFHqPGVTwCxbsjQETDI9yPZdoCgvKJLlEmBRPLRkVt++Q2Yndqwoa144R8hbAyXhw2
         rUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SObx+IC9bKM7MPIHlevctFXM7OsaKOOQMhOCaSUnGjo=;
        fh=EIouSbRpkoe+/FeK7T776hkz6qXfWLvtHRbyL4ms7kg=;
        b=au9AImT6pPE7HZx0xVHgTSUQ682c4IcYrrtjV8h8IAoxB96Ty8OO2ElSWoz97ITCj5
         IByDVDc705bA4pK1LACYb9qNxP/B16tAJRCMQ5YPP6FEbnBQihnS4GUQv4Gh/y2uCEfs
         T/M+pKJvYdLHD2axozLi8TDiOK6hDEAU7q4l/pz8+GL+k7gkFSgmAZlYc6/LEgVVbSoE
         0YjtGXw4/vhOvDSwSNxdF5USsmATA2tlfCVbfsPUHvKjG7P7sTHaWIfva2NMPD/JYO7t
         7FSVjJkGipwBoDT0K9VwFXyFKeygvq9w5S9eMimdcj6MQrvZTmFi3qcl0EVHYOQUYNeK
         HEvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770139832; x=1770744632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SObx+IC9bKM7MPIHlevctFXM7OsaKOOQMhOCaSUnGjo=;
        b=SBfElG+q0QxJ9pC74TV6gMuGJMJhV6QgahLHvL6A9mWI0cLQDVnc8JQFCs1rdqvAKg
         lOfrTMm0e2661CwOeit4ii5Ong5Oj5Jhcfg4EgvcdQdb1KL/SkZ2qoFgy7eejEONIl0v
         h02cPJ0ddhFJ9pOvKtBSoB1nL+KDj/T9yKtuD4waoXZ0n7jj84BsrLCD9fO8o5b4W17r
         ZVWNN+UyRV8Bcmox8yJtNZ3c0pELgLKk10EjLU6BDgK8U4YP6uAJnzA8+QvGVPv6hCvo
         5tGaWWbzQmESA9YOSJ2JLTTpPtr6EY3RO4uqDtqWo3+L3qHYcaD/AFXPWMNbHf6MSsQA
         ZzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139832; x=1770744632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SObx+IC9bKM7MPIHlevctFXM7OsaKOOQMhOCaSUnGjo=;
        b=pYKIfxgUr4W7Mnbjtu/5yCFAK14+UtPleroka5UZWj3kaBcRfb6qj/nuUneFYfQuPI
         TOdrVMJ5qJBO/juQ3R0J56q3Yfbg8CeSDL/I7qz5S27BxlDL8xGi0sb7vKJjT+ncva1d
         +3fAUR9LJGI0urYveEJuisuar9nCPpfyawIOsvQ7JOCU9nItic6Etd6aacW/qcPq/huW
         vpEX9V7VPBTs7Dj0ZvShirOGylwcgLPRIf1AYfgH72SXeLsvN3yjutaT4RnEoSkpBnnY
         AGvdi+c6tDtc1HV14QuYIOQ5Dq3QraS4cOtO5SgAD9/F7W+JHd8dCjiq5UIGe8JpSlDR
         Iy/g==
X-Gm-Message-State: AOJu0YwLvr8y/G7QljcvThA8bck11nZsF3S7ANAvWmaKRU5EZeWDZE3a
	z9ti7Qzy+YINBV+ikMYNDcxezrzH2KVFwrirOcdxq4pa4xorG9x51+zdTsRW4xgzHlNij5ijIdT
	WuGsMNQ5KP0Q8pqoZ82OJMIncyGHU3VE=
X-Gm-Gg: AZuq6aIAoEumfzWSnXAcg9/2osFgAn6OaXl7nTe+IMNIgVq50K2kqYUThn5jseX27ap
	IRsZZ91HzExgnQGprefj0u39IV/GHKqhQXJVAZFEC0fdeJ996rofxzCLweHQXrdEf3gs8un/PsQ
	GI94GAxyoqlW8cJ6DKvowHr02sJHAL8Y8HwcGMvgo8IMkWW/SjEc78dDK0i08j/SXKjQ+tnG9NO
	f6pwYBBfnSP4xYgbeIg2NM9qnKAQXwL9HWbQpaLAKil9SeEAviDFm9i4kjHV1Tnh8qaypRkB7Ws
	7gGHC4Zmd+RGbAxrW1wxit/rjT+vJh21tn+UBV77mb5UCIpaJMsG08wk8rX8iOkwYV3K7Q==
X-Received: by 2002:a05:600c:3145:b0:480:25ae:9993 with SMTP id
 5b1f17b1804b1-4830e987e9emr5421435e9.20.1770139831988; Tue, 03 Feb 2026
 09:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202193311.446717-1-emil@etsalapatis.com> <20260202193311.446717-2-emil@etsalapatis.com>
In-Reply-To: <20260202193311.446717-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 09:30:21 -0800
X-Gm-Features: AZwV_Qg4fVosmKAu2SvQJLhT-63tJP-NnAM3cXNi_d5a4So1oOIh5eIpBc-rfR4
Message-ID: <CAADnVQJLE_vpO48Mzh5btkPuvFYH3EFsvBzH6+m1EuGs1p-48g@mail.gmail.com>
Subject: Re: [PATCH 1/4] bpf: Add bpf_stream_print_stack stack dumping kfunc
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <etsal@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:33=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> Add a new kfunc called bpf_stream_print_stack to be used by programs
> that need to print out their current BPF stack. The kfunc is essentially
> a wrapper around the existing bpf_stream_dump_stack functionality used
> to generate stack traces for error events like may_goto violations and
> BPF-side arena page faults.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Pls respin, since it fails check:

Commit 69310da6192e ("bpf: Add bpf_stream_print_stack stack dumping kfunc")
    author Signed-off-by missing
    author email:    etsal@meta.com
    committer email: ast@kernel.org
    Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
    Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Author: must be the same as SOB:

pw-bot: cr
