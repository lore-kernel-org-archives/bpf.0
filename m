Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C732B99E
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697836; cv=none; b=OKWZ9oufFCu+3KwN1jjWHGmHdzGoqBgHXO5860S8VUbzXQY4f3OwbiY+QHyjJdt1Jlr6pd4ZTDCO8Pt8MMXQqpCT4v51UyAqzneaD9RlZcL24fAL/sFMQtkK2Tl5XJpNA6JNP7dg4tp/HGNgk6edhSjB8JNEbWxhju2zd6v0hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697836; c=relaxed/simple;
	bh=lZRXOI6zlXYJz1U5XqjlBx/cQ8DwYkwjeF8Z5E4Vh7w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=t3zKRwx1SXVmE7+JSJgeWgiOsIUUcDr77eQp2pqHaBw2JGVfovyN69a+aDz9WQAHqcoNoNoL7Iw6bpVZR3LE0bPhI4nBqU4p/klJU6m2TuI8ScRQNk47yDcnOCkFCNYLP0SuFpCS2Gy0Fd5m1fTkXCN8CflwcZf7zZmO+fdvBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8RXPdUZ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8RXPdUZ"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69e46524711so1516586eaf.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780697834; x=1781302634; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZRXOI6zlXYJz1U5XqjlBx/cQ8DwYkwjeF8Z5E4Vh7w=;
        b=Y8RXPdUZo9TMss83j+1DPAJ3Dhdcm+jAebgD/qATQjED3vpDJXTuf3FZ7va8hu1FyF
         WZJpJaPI8chccPR8veDbXzzlwuniR2tlMXwkKfXGDRe2wfU5pEayOv3XPWfzRfWBnv1o
         QFdDTqlGTvCg5j1tULyhXq2YSHmgjJ5P2NYZq2hT82hNP38TJ7hTs245CVfKmIAfxTxi
         BDI0ueE/7H4EJUlDqafk2uWpgfXzClxORPB2CmKzYu0UAPekZRkQnV2KeHAh2W6izYbk
         +5uh30Ir/bABBwLfffRXoRMPwargrJ8EEekQRfvWYhuUOZz5LN7ne6tiNO7daQpT6VdP
         H2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697834; x=1781302634;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZRXOI6zlXYJz1U5XqjlBx/cQ8DwYkwjeF8Z5E4Vh7w=;
        b=LoYzo6jMI3o3yTSkaf81I8A93uOE+NLZqxKL0hmPFwrjmONMCUCpvNYBB4KMsClf/M
         rLe2+FuoL7rWaelH8437b5JPEZDoW68TPuVb2MTjitbSSppzBR9KPDfj4hjehn6byda5
         AFL1YAGZDgc6x21HQvK4+PV3MAcdZ0ULu8jApLNB2sW8qVhyqTrlspWrXJbMBnSgiqiD
         /2pd1CrdDbxLDIgmd6mzWZCtaKKSwkJLQIqJ8fD/GdlPW8Af2oCTEDNzRGKZnJmXID1N
         Lmmd28UB2ZIebwBjdxOQKS0tHjUPWmHfCFD4MuZZjjxD9qSg9qISkA6run9x5mXcb0a4
         engA==
X-Forwarded-Encrypted: i=1; AFNElJ9r2zN8qXQH3j7HX8Fn/AjDjY0K3i5qD/mf3XL12JRLc2wFFWj44SUX1sGynOFh2ODyXs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaXweECqEwlhdCVw4uIEfm7nlamOx7oQy7MX77Ce9NIZYGz/Y0
	gW7gt2pzlBl5jIbb1FkHfBrWVz8z43IXhZbs5kXOlEsmekQH3My+AboN
X-Gm-Gg: Acq92OEYZNL+eZCdgwz5InpMNkvK+WDfWXdc5GbTUxZmaVLXA2SRThsXyZ87ElhYrJX
	dxZhKS4etCrVqWGlqUeuCZnHWwHL3BGq1cVr9KyNjDBze4ms5+tQy5+EoXOkyTqXffm2HQ0squO
	J3fsaYGmYqiV9NwJm3UZDct6NJ56no7mXc3r0QH9UTmkS07rMeeou8uzSpKH9xTl22ZqUrS3RKE
	XKAssz44t4idOaNbxlRLOEtmwsXItZdPFdcue+m8lzb7ed2dtv5CAYn1un7LNXCsjjLz54V0aCB
	hPjWM8LGLrja8d4sPUqgJRZdtk7UwTJVqK9yzFXwI/awQ6KKmtx/3yqzaRdOJ5uAHSzASy6lGso
	cj+xj1uEfJO4bXNEW6LBxOCjyK6B8ybTVlJeT1QroGaqfS3/uoucwxc6b2pi/ijRbtmPJOopw/+
	TH/atCOUtzCXrFoo8mSasRSI5imNhnNNs1YcfuOQ3sDrFVEwh+2Hgr+lQRxOebyzogCWNSagTF0
	KNh57NF1CdClpH3A/ybdjRcBa6B
X-Received: by 2002:a05:6820:208c:b0:69e:31fc:d12c with SMTP id 006d021491bc7-69e68b1bdefmr2976137eaf.4.1780697833870;
        Fri, 05 Jun 2026 15:17:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7c351e3sm8110404fac.5.2026.06.05.15.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 15:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 15:17:11 -0700
Message-Id: <DJ1GP6MSYCMS.3JJI1SRBMMGBZ@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "bpf" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 0/2] bpf, verifier: fix PTR_TO_FLOW_KEYS
 constant-offset OOB
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
X-Mailer: aerc
References: <20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn>
 <CAADnVQJCXbZ27oZRYcd6=9WdaKvkMc4-PAK2ocd1hmRU=1C2rA@mail.gmail.com>
 <1f66a74b.74fd1.19e97406869.Coremail.gnq25@mails.tsinghua.edu.cn>
In-Reply-To: <1f66a74b.74fd1.19e97406869.Coremail.gnq25@mails.tsinghua.edu.cn>

On Fri Jun 5, 2026 at 3:07 AM PDT, Nuoqi Gui wrote:
> Thanks, will retarget bpf-next. One clarification for my own understandin=
g
> of the security boundary here: is the "not a security issue" classificati=
on
> driven purely by no released kernel being affected, or also by flow
> dissector attach requiring CAP_NET_ADMIN limiting reachability? Want to=
=20
> make sure I categorize similar verifier regressions correctly in the futu=
re.

please do not top post.

Any CAP_* means that it's a privileged task, hence not a security issue. Ju=
st a bug.
