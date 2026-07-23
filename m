Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C3233134
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847503; cv=none; b=MTolTcU/wu9eWurkvwpw1m5q27B6AFj3YfzRpdkwpwToRtmT+ocEitSEtZx12ivqIntPTErWmQcTuu1h2HB5FYiZtFAw4uelAgIzO8j28h6wNuTz+QRShkuJ2AaAwPLtatjViohfdZZOFFXnifjzH/KYzkS5dpJjb28SWuQc0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847503; c=relaxed/simple;
	bh=R6ZrQwBh/Xo4TavvXHgrYHArxOzINmeSrctd9LdJHm4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUT6thji3Szax6TIi+60JXtYGD4JCqUNOE2D5RtJS7MtWKuphvl2K4r9uiBJ5LaZjfNUcFWkR1cdCrNf5c9z+s8gAhXuHCEIqAF0iyBWXfE3EUQg9l29gM1XHyyuHNmJBRIgDkUnhLMgcWWn4xV0q27tqu1+5Lqahe7+/rTABZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNlCjG1F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNlCjG1F"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caf228a910so10413595ad.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784847502; x=1785452302; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QVA7zKyo+U/9PuZiFdSna8Anl2m82PLMM+n71gR3P/M=;
        b=DNlCjG1FB9xhjQIJ70wTRg1YcvRtVgmTSg5VpE3FyxM0YivoV5/I3UHKLZQ0SCq2Ea
         jDuZwAGIaaJJklXwLcOB70TandCnk5hjjwG7SpPzUUj0OJWIGrHL7cZWXaDB042HPmwo
         kKGF/xU5l0wQCHiKKsUeM2PcEFXsi/qWn2tlTRF5dI/jZbK16C2iwOas3SjsFfiBhvlS
         3STuEPtetpE3QQXNKEG3LIOoby0Qx4xHXvgaRkjZ9/n9p7UQqPAEah7c7yuWVnIYKQzd
         Zf353mC0vctRObeCTq/Gtm7JQpyCuM95DZXCjMA/XX+FazHPaw2tUmiIkrRzExYMEMx2
         uExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784847502; x=1785452302;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QVA7zKyo+U/9PuZiFdSna8Anl2m82PLMM+n71gR3P/M=;
        b=h3AtFwFYyTfheKpdQp2huNVKW6lrxCksjn6Vs5oZBOVBSx94nVVRsuSrjs54Z6We4/
         yQj0ToZkje6vqXdS/lrkBtnYtkXtPki3j/Gd/nUh/Ih65zIDS01DBlFDVT5HnUPHuNlq
         h3rdwB76UXMbC2SGTRuXgUt2NMsrOL4j9PPQOyz9ZS5R/XN7+m+deszaA0kgNnCaW1Kd
         vz71aIjjQS6VMIGtsNO96Wx1KwHJVMlSQ7f5wHvTuQDMcPljbhqK0PX1whyCNKpTw9Fh
         IKLBvloXf4QmsOasJS8tl+XoQ6k2I144MZ9RJxFBfM4jBmDNWakLi7DRSrm0q9h4dWH3
         UOKw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/V20Gp7kpfjd+LX+kfvG6ixYgqnYPtVgf2PHheQhu95gIG3cnmprcPMYQlRaJ2fy8O0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9k2LJgK/wU881vhgzre9WnrLm4uRewlmdvjgIxokqAd2wp1O7
	alr6lrJu4laTNOE3+k+mwsIOkGjthyXZN3Bk7bDqc6Y7y5T9K4XaYBCxAwtzT8Me
X-Gm-Gg: AR+sD12DMKGm0+T5AdJDmGGUvfyPDa6Y+CgakJQL8wNwXqLbhtvfltn9ib/z8kg5OF+
	a3c17uFALMjpab26miwvTBhU5O/04S8hQaI/yYBuRwOjZcMZ1r8vN3O5aagXfWKDUVCeA6PT7la
	lC8mSM3yD6l8gyxGgGlDCBfLvnXbVeTC/dQVsqDH5QU1tcYGKjIH3/pjQree6wLnuSNe5wuv6ez
	gmqSpJW0EUW7BqEjV1y8RhVBIlDCP67W5chS9HyaMNlt95ws98lvPizC329RBisqlHM27Zrs15s
	/GIpwy3N4e+D7qZkW4DTNdQU7UZMpIoVzZGM0ROl98m0KJhq45N8bRsSes2KtbeJ4QYa/1eUgYh
	LDXJLdKBoBv3gkEJZCVVhnGjKhLHVGkmbGaFdlmlN71QiL2+O1pgOnK4N3Zi2USdxkSFkw8/P4v
	ngbJC0LYzM4SzJsACkPDq+zsxIFIhgQzKyk8IOx8u5akxZkORjxtkCl+cCeV8=
X-Received: by 2002:a17:903:2449:b0:2cc:e620:e307 with SMTP id d9443c01a7336-2cfa6bc1948mr58554435ad.20.1784847501796;
        Thu, 23 Jul 2026 15:58:21 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c221:d012:6e37:77f9? ([2620:10d:c090:500::2:8dac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e0818e4sm23188163eec.22.2026.07.23.15.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:58:21 -0700 (PDT)
Message-ID: <3274df73849ff8620dfcad063c6af17b10a36982.camel@gmail.com>
Subject: Re: [PATCH] bpf: normalize arg_track state construction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Yu <tao1.yu@intel.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com
Date: Thu, 23 Jul 2026 15:58:19 -0700
In-Reply-To: <20260723055508.1403247-1-tao1.yu@intel.com>
References: <20260723055508.1403247-1-tao1.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 13:55 +0800, Tao Yu wrote:
> KMSAN reports an uninit-value bug in __arg_track_join() when liveness
> analysis propagates arg_track states:
>=20
>   BUG: KMSAN: uninit-value in __arg_track_join
>=20
> arg_track carries its state in a union:
> - precise pointers use .off[] with off_cnt > 0;
> - offset-imprecise pointers use frame >=3D 0 with off_cnt =3D=3D 0;
> - fully-imprecise pointers use frame =3D=3D ARG_IMPRECISE with .mask.
>=20
> The bug is caused by ad-hoc state downgrades and partial state
> construction. Some paths only updated selected fields, such as switching
> to offset-imprecise by writing off_cnt =3D 0, or building temporary
> arg_track values by filling fields manually. Later joins then copied and
> merged these values and KMSAN could observe uninitialized union content
> when the state was interpreted through a different union member.
>=20
> Fix this by normalizing arg_track state construction:
> - introduce helpers for ARG_NONE, ARG_UNVISITED, offset-imprecise, and
>   fully-imprecise states;
> - use these helpers when producing downgraded states;
> - replace in-place off_cnt-only downgrades with full object assignment;
> - initialize temporary resolved states through the same constructors
>   before filling precise offsets.
>=20
> This keeps arg_track state transitions explicit and ensures every state
> seen by join/merge code is fully initialized.
>=20
> Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analys=
is")
> Reported-by: syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com
> Signed-off-by: Yu Tao <tao1.yu@intel.com>
> ---

Hi Yu,

I think the changes themselves are fine, but I second the findings by the b=
ot.
Could you please elaborate which assignments trigger KMSAN report?
I tried running with KMSAN enabled, but the boot appears to take forever.

Thanks,
Eduard

...
