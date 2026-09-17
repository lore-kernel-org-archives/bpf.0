Received: from mail-pj2-f32.google.com (mail-pj2-f32.google.com [74.125.227.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C035675E
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 03:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616033; cv=none; b=OdPJFvR0rQgpsXg8PKToc1N2iuQdkZ/NPUmMxithNwD6ffcid+XTzNyXPATFQX9JTUgJWQ7WScBq8AhkNodNHK/s9uVKc5gSAUrK3485zJYlVg9NAUx4dQHIM4AS1648wb5Vu8ylFZzN/Cz7BCIJywGL07NwlkPeGPnMI9qMQY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616033; c=relaxed/simple;
	bh=xiYVn57pn0XMpas+wlR8SmSSTnMiv5JdI/rPUiCUEF8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I4/rtwvog++r7g+aUtgdNXdJDHA33UC4geZth73krXmgJeXJ0+7uudtp+mTCvKzWKlKp666C3n154PFzLqVmaBfL8nOiJlidGOtTDz28ySMMyrbnytTao6dstNFJ7x4e7QROQEa8cP6B3aJSE+t0Tml4qRV9dZWqzE/fnhLf8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQJJ9sWv; arc=none smtp.client-ip=74.125.227.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQJJ9sWv"
Received: by mail-pj2-f32.google.com with SMTP id d9443c01a7336-2d747f05ffdso2920555ad.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789616024; x=1790220824; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xiYVn57pn0XMpas+wlR8SmSSTnMiv5JdI/rPUiCUEF8=;
        b=SQJJ9sWv8kbqLvyicyIH8dA079Hpdf7sAIGAgsa3gu8az9fmonDf2Wj4CjjeHdDevw
         GG5DXGNWmjOJystNj0aFKHITBrJ4HGEIRiBZgncCCyfssABBwoE9OjohnJi2mP0LKUKr
         Egf2WxTdjAwi163gzObk0VTgGiKgJXLsa0bK4+Lh6hcZYw7+ytQCHpC038wYeFxjgBoG
         wKzMSXHLic/tTqq0X7SnDw6UlRecSPNdDGwgx0Onfiw9m5xIbuhXLyYroSSik1DguWnx
         ZmNMq1sTLuEOvpEHBv1THhC4lQBcket6CLDcZAxkol4Czdoh8q91xdXW77tVLbQSYnoD
         GVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789616024; x=1790220824;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiYVn57pn0XMpas+wlR8SmSSTnMiv5JdI/rPUiCUEF8=;
        b=S7zKEQeLz43JbO2VvBLYkec0ocitSZEVvM+hFXRF+8i0S44KNe34fTp12g7rqGvKk+
         0Fjh2x6APOnkbn+vLHJbe6VUjjm6hmMBd6qtDwqRYx6wN2jfAaTdpYcUUTQdAIL6kjzZ
         pjjJn1FcaeBXiA9Tetnn+2A2hr/i98jTWEClH6ovMoZ+Ai1GIcte6kf0zckcKQu/+4Ay
         P8jLJaPJmXxd0ut6j1frWDSlIOTSM7YB/8/wgx6vzqKZWtzROCeFWFfTPKS1VfGcu9EX
         9x6VHwBKgAK87onvACdxpat5uIfAUu97iX1Ciut6BYkMecQJZkE4J4KSU27pNG4fOSfL
         vbYA==
X-Forwarded-Encrypted: i=1; AKwUvBy5DLzA93h6BZar8zogYxK2Jkxaj02ciQsLB5zzBZVbykG31uI81HTY2wVNQXNv+sCM6z0=@vger.kernel.org
X-Gm-Message-State: AFuF++kjtyucIHWFlTkbXuo/clrZKC7wLkkJXAlOGI9Umh37ZHqez3u2
	tB0syOJSQ8SjdAromfverv8oGokLuS5Rt70PJ4kMeHXKRdy6kSPx8JbN
X-Gm-Gg: AYBFou2W1flO54jUEOFqIpUGl6PuOortRkFGdefE9VSLhFV5xFE+xtDeGmwkxMCi9Q6
	f8Me2xGxUsmfpBl6WmgVV+Z+qVN/emfOt3a7Txh2ih9qpqh89huvrAZMspdqJ/K2KpEPjEKteAE
	q+rGSPAcZq8SBBkmRJm2nXNnbrzeUQ7KYcDCOCQW3js1mJSqJtY0BuoYJFk0wZ5ILkZY2HnWJAn
	FLUDnrDyIhmpTmP8HqOsLD+sy3Bi+A0/EbbkU+6k6ksjleVxCCq7Wy1bhgT5dPTIowOdYImjkxi
	qHsHKKnrNWJzyS8SODMU4Pq2TFCzLM1x2vjECelfAbajZT5jeDAEYBDrw/adnDBKfmCrq5MUz7V
	y/nCz/OJGdbSle5aPDGk/ZrYBmFpamoQjyEkVqUJfehh2FgWJKwcVygvQSWdy72pz7tqU/zA9iH
	UMMNUWBJW1pwBt67qZ/MBPLGKttijiZvhSc5GwR/xJEpX3wbKYuEebzs2YqlwuErfgM3XPcEDhJ
	gluS2UvBL0Ob5gGUscWFCzD+Z0bk93r+KCgvcnr1tLlekbY5mxtnoz9u8sPwICpNW687pSon2lp
	rHrc
X-Received: by 2002:a17:902:d547:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2dd8dd0b15amr107107475ad.4.1789616024059;
        Wed, 16 Sep 2026 20:33:44 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89eb5826sm19687585ad.30.2026.09.16.20.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 20:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 03:33:42 +0000
Message-Id: <DLH9XN5U55Z6.32MF649M30C6P@gmail.com>
Cc: "Nam Cao" <namcao@linutronix.de>, "LKML" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Wen Yang" <wen.yang@linux.dev>, "Tobias Schaffner"
 <tobias.schaffner@siemens.com>, "Viktor Malik" <vmalik@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, "Steven Rostedt"
 <rostedt@goodmis.org>
X-Mailer: aerc 0.17.0
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
 <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home>
 <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
 <20260904123108.1fa1d815@gandalf.local.home>
 <20260904132421.111c0279@gandalf.local.home>
 <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com>
 <20260904194620.0c7a8363@gandalf.local.home>
 <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
 <20260904201741.2986efca@gandalf.local.home>
 <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
 <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>
 <DLDSQDSVXFHF.18X2UQUL5Y42D@gmail.com>
 <1f8caa71b79e70f554245bccaa29b66268452dbe.camel@redhat.com>
In-Reply-To: <1f8caa71b79e70f554245bccaa29b66268452dbe.camel@redhat.com>

On Tue Sep 15, 2026 at 7:15 AM UTC, Gabriele Monaco wrote:
>
> Essentially sharing the API simplified how the userspace component handle=
s some
> things and allowed to share reactors.

It's surely tempting to reuse userspace, but unlike kernel the user
space is much easier to change, so let's not add kernel struct-ops,
since they're not necessary to achieve the goal.

