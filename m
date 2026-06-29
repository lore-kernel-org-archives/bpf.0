Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37241355049
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754284; cv=pass; b=gsKRXa0aK4gCAZMnrI3SrEpXmJY4IgG0v2RY6Nv2U+yMVHiBFqKy/fRJXC0DrHRJVaAr+0p47zDUsMPk0LmGlZAkSAQxldKpDeEMWJ2K/dbbjsIn0m/o/w1fr+PXrcOlabaXe7YDNvN3yXlQKXFJTCVkvc5IObQoMBbeDN58/w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754284; c=relaxed/simple;
	bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrrTr98Yvajdh5d9QmomnehH111SRbBUpGTZ2+Adad2vGnQblg16AlYr50K5knV/P4ZwGVHwAXThqIaxg2O0tAOKK/GqjMRKjeBsYjA3pH3g2Lnc6uwwXxxJoZp8G2Yd9MWOkTE8i49uoc7Yb0jirf6KkQVdzQ249oVCuuuF6UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOB0tbQz; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOB0tbQz"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69857dc1d5eso2962014a12.3
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782754281; cv=none;
        d=google.com; s=arc-20260327;
        b=BGiLdiM1eNzUmV+VLF5GaNWXQ2Mw8/wrxdqWA2aMpAoj0J+WGOptyeQAvccH7k9sFz
         CXlNxFuFuCEBoujaA7qgeO2oGQ6eCpdiwbWB5mifxqu+Q/pm5nj+nhHA8lfH+kjnIRe1
         7YEl50++GZczFcwq0WG+tBQNfP51MDza5uqSIIjnssd6976iihxX3y2t9/RbARTm02P5
         1rZnv6DYJ9p1qrufWXmxMvyEownIxmy+hu/uUIET/4xUTyPvh5u7I1ob84c3IbRkCLZb
         bemQNHsGGCUPTH0oThrpq6Ww0ieUN3W7Fp7HN1gXElKRC97TBQJ06QVjSmBh6/REuy/P
         A4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        fh=QAQO5TGs2GNYkeupizvwLcgOwopY11+SrZ225YGzIAs=;
        b=rfq8uqLqL1iO5lKWAonutSP+Wsgow2ykMEqqnrwTihygadRCIexumirF6YbJ5xPdM5
         01emKzda9NT5rGtqa9eg4ONvYbRaz6OOtJVbZzLNGOfU4/EWTw17Iab+NNSoLfnYNsPg
         +jxvo2YWaNP9/yMtYCISDxwI0/sUmtmsUmRZ0I37/VYsXZq5bLzagSmaSR46UkAZ85kN
         cAJfZDS6MfjDuVmBiSb6IUV82eilYRmUIUIUs/IPdVxk3RQrON1LfII0zTM/r2CiU/FR
         jQcpKnkx+QVqvIShfF34oVSQaTlKjHaSi4/cfVIcxmbgBlGio2e5iDWaJTfUvIheOXZ+
         IECw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754281; x=1783359081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=VOB0tbQzXHx225/eBRLGEzWz6vX02N24U92aDSCNpfdq7DZv9iI6NGkOHF5VJSXBf0
         iZEHeZ0V5mC0F3hIMX5sla7sCwE6QUNe99CfMZz+3kF02NmreX29GtPeIhhn9/tvERdq
         6rIHJEfwGNs7g3Qtc2MU325nY7nvEWm2h/9qTqpSpa6S67zweReqCilX7ZHuwu06Afw2
         Tp0haJ2b/3LKr4BGQqiyRCz5NDX62Jd6SCIPaTHgyHwtVcs9J/8SW3WLPHp/mOLeDDnB
         HbauBnc7gNry89jY+RZ4nsQ9ECd+RxPZvUBef39i/RgCTiFo8PTy4LyUjrjbVd51dDKN
         dcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754281; x=1783359081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=sTrgwta+/g3SPBqGgHt/V4H442I8A4h9HseaQLSZeNyoKIGXNY9VLN7SkmQdLAZqOC
         1KtqrWjrGjAf0T/ulsIF3bzaTtEik2IvpMnrlacykOvPEod35puOg8kFKd8M2py3DzVn
         hIRguNvo4lzJH3LhuRHL3mwzVQaGRpoGLTD8/4tS5YYy34F2FytLbdMLOrpsl58KOpny
         i+dEyyESz4hN1WzcG2to18eqjd4xr5DBLaOXzvN02h8KJVu/+j7GzyaRvPNHzLkW1jBO
         JWwre2GR65KeO45eVNXW5GYcm4bEdZmSsijuQwJzux8mCmB86C59bZNHly0kKFoKLmPO
         IGFg==
X-Forwarded-Encrypted: i=1; AHgh+Rru4ckUj3PYsmIczsUtgozyhQHmKinah2fdJGoP09paZbgr6KP6IaZOBZAwQZDzsD41T8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wRaayWSGrU5ObkDghiYxb+Lto/vKVZ8unS9E4VKyw7kN9Pid
	Shx2wyLAajsARivzflXKSrh2nD7mMJ8+GND9kLrquGayXLNRtRrwmWJJRtXZlffVRIfQJLqCmTR
	aUJ1Vh7fCzaksshEEKv9sKCA2Vsi5C+M=
X-Gm-Gg: AfdE7cnABIwW6GYFjMUhkkJqihDctC1jR1GdHPLKuRquJV4hBp1tegChSt4CObyYGIn
	skBSDqzSEnrP0QDWC01SGbhdA5S3DKp4qIgDfPrLoelKuR/RnT3Pt1j+car3sgCSBkBn2Wlivnr
	NsGDi5qI/R9KIQiLYs1hcyR5F6erFA11cUy7UGSjnczAYF2F5rHixkqwc95K9rqsmIl0T2j9VJ3
	TJV91gUtiNop2YkFBucXlgOHkI00j5lwrjQTNmQgX73/WhrdAd6sOrp5q7ZB+/E9eXLPVBrKKRk
	gQPMevsBfFo8N3agOT7C/wG+tRG/IGM=
X-Received: by 2002:a05:6402:390a:b0:68f:cc95:8c10 with SMTP id
 4fb4d7f45d1cf-69879e4b974mr46982a12.27.1782754280332; Mon, 29 Jun 2026
 10:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
In-Reply-To: <20260629070653.580879-1-caixinchen1@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jun 2026 19:31:09 +0200
X-Gm-Features: AVVi8CfvDZzdzYVHdraWAewZEFEyCZ6yZ4zu-tcKsdp7diMSLlszm49WqjY_Vvs
Message-ID: <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:38=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> ackport the patch series
> "Fix incorrect overlayfs mmap() and mprotect() LSM access controls" [1]
> to 5.10 lts

Chai,

First of all, I don't think that stable maintainers are picking backports
to 5.10 that were not backported to 6.1 and 5.15.

Second, backporting backing_file as a dependency to LTS kernels is a pretty
intrusive change, so your description above is very much lacking.

Please do not backport backing_file to any of the LTS kernels without provi=
ding
detailed explanation to try and convince the vfs maintainers that you
verified this
bacport is safe for the LTS kernel, because honestly, this looks a bit
risky for me.

Thanks,
Amir.
