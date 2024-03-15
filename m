Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4752577C
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515009; cv=none; b=Q4hvn7eQFELgTrUQlMgTwKmHPPaqYyls4gcPCF4Hd4J4G4MLJVgFqxW7WrruifGs6qov3bJwrpvqRbn7e0744BN7K8ex3R2emaBfMO216N9q6WeO4iXoOniWOtTXwBY/G0RAkquURh+3tBXlYMmIvJU6dmAtPfrxZHTaYfU0dpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515009; c=relaxed/simple;
	bh=X2wT/BzxQKN1MciyzH4oQdmRg/MDDXfK0mOlDaA3dS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4GNUF/l3JBQUXlAlYj4GTGS7glsfpECLbub6qJg6NIsugAyNlLmN+E2HuJY1p9VB7K5Yzg4pOT64EfMORfAbgFPkGK+oMMTeHYl0xg6OdZmPU7WacMQTrOg7iiA9HlAsIw20TpvHLlh7IWC6LDQ8nflXlEIiJJuEVqmf2j3Opk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=kEzOciAj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="kEzOciAj"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a468226e135so108002066b.0
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710515006; x=1711119806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2wT/BzxQKN1MciyzH4oQdmRg/MDDXfK0mOlDaA3dS8=;
        b=kEzOciAjMA5phAV/00wPYG5sZcTzbhJyA9Yo2E82IIOMsTSH2p7d4JDKqicRbudlGY
         g4wWMPRzq/lvF25JBhalwacac20xpAEuIVEq9I3T9yhUNNs5Rsj7WvOwmzN4fuYgzOdH
         veJ4op9RJEK6qhSJvLmpNiGp50NzIQF/Ryfy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710515006; x=1711119806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2wT/BzxQKN1MciyzH4oQdmRg/MDDXfK0mOlDaA3dS8=;
        b=xPXPFWfwL7iW0wzTZgIUzBQbzTmSilyamsKtV3gSY+O92853MX7roj0+jlmi4BnTRl
         ONPzi727RiJwgwmEpJw4BPNMPLYbeEGYGozZnJrM6gL2zmdnOmXcxvzDkLBjQZs4iubt
         IQqZorst2Y4b/97Pwdk75vpJk4IK2TJfy9mdLYSOeN/zY5Du//yXy37yoxcXSMhU+E9r
         TLIFlh3Ffcv93UAU+y4v0Q1jog38dcZGfrjA/+FxrJYmqiohXBaEEeMnBct3cxArIbot
         BZY3pYPTqLJxtDZ1BgwlJlwHQEMdYsMRlb55Jeji9C/8BUNONq1GhHV49DUQOBVPduSc
         90SA==
X-Forwarded-Encrypted: i=1; AJvYcCXzlfEjqR5lj1N8Rgs98In4sTGeJdlSksx5cCnMYTCeGLeF/xewnEBDsTNUfUnv8SBqnY/fhnz4tbXl4tOrCDD6CRd6
X-Gm-Message-State: AOJu0YwU+TPUcgkdszDXeiC7LOsnvHpBpzDkLor6UQJ36M8TwZhWGYIV
	lCHRTwmBhQ35PCas2hrKc6L2Xxnbn2SsBoI0+6WAF0tNAENchBGFbzfsq/1K9ujzvupP02ZA+4B
	0YK189Sbf1l45T55BDjVoL9umVg6mYiUQv7r4mw==
X-Google-Smtp-Source: AGHT+IGWgmfkja/H4b5nneN2aa04dXN3RKuMZKfXyBOXRkigwPhRJyr2zzT1SFedI9QSjahv9+IVHf26dBfqo5+priM=
X-Received: by 2002:a17:906:b899:b0:a3f:5ad2:1ff0 with SMTP id
 hb25-20020a170906b89900b00a3f5ad21ff0mr3527043ejb.46.1710515006228; Fri, 15
 Mar 2024 08:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com> <20240315113828.258005-7-cgzones@googlemail.com>
In-Reply-To: <20240315113828.258005-7-cgzones@googlemail.com>
From: Tycho Andersen <tandersen@netflix.com>
Date: Fri, 15 Mar 2024 09:03:14 -0600
Message-ID: <CABp92JBZXcfNgh=0Np0uH-XtxioqHXL2SeTQQ=Fc7ZeGNuFQjg@mail.gmail.com>
Subject: Re: [PATCH 07/10] kernel: use new capable_any functionality
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Peng Zhang <zhangpeng.00@bytedance.com>, 
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 5:39=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>


Reviewed-by: Tycho Andersen <tandersen@netflix.com>
