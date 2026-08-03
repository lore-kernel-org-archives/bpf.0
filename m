Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B62F90C9
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739698; cv=pass; b=DngyQkNakrFkETz1/vacMnuSvXvzfPdT4/HPtUmlMqtJPF5BblOEluX5+ZrYVgHSzwWegZkcwplrZh1Jrwdio1EZcCVOyFkNKbdxE2w5j5bR9gjIVqOiQekS1AHkHt26ZVMA4ymPHj0UGhaBXJ7AhPelsDe5Nc/Qrul41TlCkko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739698; c=relaxed/simple;
	bh=JG13RJuCKh+1mI2pptEk/KoX7+1mcaPItkKVPBIEElM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chkum/aHF15lv9aIVa2DuFFkE2ZR5o+RbxkukeHXmNg7IFCtZxoLMmqYN70FDA9a+gnQAbo2mqOQdS193s3/bRqYQH6OU3T6VCaQc0Q2tINV1Bq7xAOupskXn29q7iaJ+aJH0bP8XzCf+bjBGjile9zNSvJll2+mOH/Pbq8I1tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwcSTbLb; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwcSTbLb"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so2730117e87.3
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 23:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785739695; cv=none;
        d=google.com; s=arc-20260327;
        b=pVgBhI9yem43AfLsRIGVEYcr+75yDGW4eG/0PaQMyW4OLBxRwY7DLsEz005/nrCEAa
         T+sLsO1PGvZ9aUOo+eT70i+fZOFVs0ECTpkuolFS65fJAIT2zHL8f5IlK0+jzIeWR3om
         fGH3c+PLLDeg6o5asP0BhQFPikB/W3DUuSkGMwD+zcYWt8/73XC6BVeVIZzlTvszdnJB
         LeQtGRBwyTBmFIHuW2xAnDyV3nCiSA/6QbgF1MSIIwig/0pILMlp9qZbwWnyswjgCNwH
         ZZCZncv06T6YUVFZBI8fuqee4WXEInxTLKn/MIIavfbH+wqY4VV/wt4UnOrlZoP5Y0eM
         P4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JG13RJuCKh+1mI2pptEk/KoX7+1mcaPItkKVPBIEElM=;
        fh=8GAb1Mb+qxtIOVEZVrf3J2AoChRw6EceRUAOI6TxVic=;
        b=WGPayEgC3gcTRRTuRP9AQyzWZ9jLPrkuKg7lCCLZtm+K5l0qx6mvIolrADq9R2G6Aw
         MnFSAnAPg8SVhZ76+rVPdsm4KLKkOF/AJ/Zubc8+lQsuPtNcpa3Jsj797RHD70y5vMmt
         7QnVA4gyDgCMJxcQYXEiZXN61XHgSBUWNAx+9e+/xhg6X8UMQNZqeOFYoQhhNbr/2KQQ
         wMZTyQFEfeeq9S4PnE9559NNiIPfdJFIPBpBsmhbv6dd9UBNgIFBARHS+TfNcOJPCLNl
         xxvY1LgBwd8BlcNENOWjohakJ/fHN6ZFCw6NZI8Y9PS29WrjadACGpN+8FC//7fyS0Gq
         Lp/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785739695; x=1786344495; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JG13RJuCKh+1mI2pptEk/KoX7+1mcaPItkKVPBIEElM=;
        b=EwcSTbLb6Q5ZXbPn8+Z40xyBJyGv7ZfaMQpHUm+DpQ6EduzxAsIgecAkO7f//+I2Gv
         LAS8EP3C/jyPlGjt3g4uYmGDjQstPO36C2VHQozLc+dgma8+c+Ps6fDjurlAY4bFXm/L
         wQS+TvdzpHI149qzIAahG7RPQTK1Is7uZreggCRZzwThap6nn8DRdzam/XG5dfMlXoBF
         XXEekrBFFwiPJ5Il9+QeXEhqh84/WLr52rWM/4Md32xduInaIu4V0YN9Ymo8Xa4GYQzC
         pgZZEcdf9XypZ8NbrxHzmLxqjnAm3culcN0OxMtCGsLzpGqcB5jlBwK09SJN/YqgUCYm
         6rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785739695; x=1786344495;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JG13RJuCKh+1mI2pptEk/KoX7+1mcaPItkKVPBIEElM=;
        b=HpUCjerWkI0HlBLlzQ7ZOvdKKWTd6HzODWULkGQfKZ3uzCErQ3KSzsN4Mnv6r5EnDV
         lhOZbGXDA1RXHAiPdOQnLrrN2WvaicSA85n41XELOf7xDM7hL2tyTiKawrfbugpcU25S
         0YRwLbiVjgyo57IJ2Vr/ILNOXjgP6ZMpY8bWGnf9ZWoLwqF7JEsNkF5rEqIVjctw9XCW
         zqJAVp9PgN84C1fewmb2RveXw+W1j/H7IqlMCrEx0SIjCo1gw/DhPETbh2z7RgYphvfS
         5fRvKj8QYtRrWAIVzOgxBjv5iuvHvJNu2MDwN6xVYQ+DnkLsihsNwbPt05SeJDPn1j5Q
         /ZOQ==
X-Gm-Message-State: AOJu0YyLALJZS1laMkeCzq3vo6DjlLF1LCpBoszOApQeiaC+hr57bkJh
	ygNhjnyr/gfcEna7BSpgrnokCDPj0YqIy/1+eib5EgsIuMaPRngzbEbWtv1vWvFacnBiTLZvYHi
	rqcWOZ1z6/b1ylaJZ6IVZiFxNAXYkXw4=
X-Gm-Gg: AR+sD13v5yjpSCnIWdxYV/z6hm8e+3CxCrcgojL8kcEszTH5NYWFGfuuU1MMIdWdWOc
	Z+lNKu7vyvKxh0Lc3QDc8HGKvt3KUtemyfSuai5Bt5sPTU81xothcywwu98ziZZhp2YSgPrvba8
	61A9enaOBfm8XzxIx2v4URzgrAVzWLbtd/tErQ5cY3/ISKfsGAaOWUTNlLoeUcweQGf2aJar1Vc
	0HrwLTxr/U2QWOD0BoyGolMFW/7VnPEViKJEPnEQm+BXjsHZbsIWm0V+2f3agb1fg55BABH2wm0
	gIUfCKYNECxQQN8f2XvH1L3AMLss/oRe1dsagpzfoMpzVjY=
X-Received: by 2002:a19:6b0b:0:b0:5ae:a9eb:c5c6 with SMTP id
 2adb3069b0e04-5b2e4f9c5femr1063985e87.64.1785739694418; Sun, 02 Aug 2026
 23:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com> <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
 <CAJP4iuuYfqFChH1P2=3Q6WxHbMTNnAkCagR2k+Lr4W155gCj3A@mail.gmail.com> <DKF31NEIMOOB.2CPM6KGVXD73K@gmail.com>
In-Reply-To: <DKF31NEIMOOB.2CPM6KGVXD73K@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Sun, 2 Aug 2026 23:48:02 -0700
X-Gm-Features: AUfX_mzhewA91CRAwsJWmr3SGvMQZWYhX-aXO0fDnppsltfn5I1_j3Bsj62QemE
Message-ID: <CAJP4iuuz0T694PnyZmcq9f9PaQLX2kV+Sd+veQN+uydsvZ=BFA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in refcount_acquire
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, 
	davem@davemloft.net, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"

> I would just disallow it. I don't even know how things would be correct if a
> untrusted owning or non-owning ref is passed around. I think the case in patch 2
> is demonstrating that it's a bogus type state for being passed around into the
> kernel.
>
> The only meaningful correct use seems to be reading from such a pointer, for
> which PTR_UNTRUSTED downgrade instead of invalidating it completely should be
> good enough.

Just to confirm, semantically should this case be rejected by the verifier?

bpf_rcu_read_lock();
res = mapval->node;
bpf_rcu_read_unlock();
return res->key;

At the final read, res is MEM_ALLOC | NON_OWN_REF | PTR_UNTRUSTED.
Should this be accepted for scalar reads, or should this pointer state
be rejected since it could possibly cause read-after-free.
