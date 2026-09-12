Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83D48124E
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789239597; cv=none; b=kZXMHIFDYVMb2ict3WOLhMFiTR0/uCfXu1yB5fe7SV5T1QJPAfedLcee/8PBWaGBGc0Nht7JxoN0Zavsu7/PEs7H2mda5bnaJtXJAy2s64pzoAkQ496AuGiil2Zm/8Db7MbUJEmjQM38LW0WFGBiW5lGaUd93QfSk1rx05w6RFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789239597; c=relaxed/simple;
	bh=W5pYYkFbHu8gvCgwzbJArz6TGx07mjzoqi/91WuzJU4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XnJSYAKZfzoPZS6rhGqKglKYwqh0lvT64X65u7C3MHcTKPo49TRqv03xMc3v5lD/grVChyKXdoC/huDc64wHIOn14G31hgwjrDKqnnMzndOX8YNbCu6Ues3xZq+GcyjLPil/lG1ylQyQcUunQ5vUscR7pCkndc9hZHNbmiGz3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT11OAU3; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT11OAU3"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b12942ed04so1833050eaf.1
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789239595; x=1789844395; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m0hkFL/zZs+ga9gIE1b00ZBTTiY2auR/sNm0zFmpqW8=;
        b=gT11OAU3g0F4I6b0hBH48880CH9HvugutKIxYDKPRy7TdUII16F6pBPHpAyU447iw0
         J9r8+tnNb0xJlD0rf20WKlVjORVZUYPl6cC1vfnJQPAscqYiMjMtpoHPgTn6Ca7bBJ9r
         0qsGd8ewvpAClNXRIb+FIwK4w6NAXv8gMv/sKSrDS00mJ8mmnB/52JM1NAreq8tx+Zvd
         x2smqwqG+Aa9K9zV4zvzLBP0HIPySaA8V+MVkek5rlBCHeUu1GsewJbDaXli5AIkZNqp
         NXyQksM/9xAQmLBMuyDsJFZiOMcCS4O/OeM4E/sCZ5K1Ya1yUy3lJYYhxUmD7mn95ikq
         lwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789239595; x=1789844395;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0hkFL/zZs+ga9gIE1b00ZBTTiY2auR/sNm0zFmpqW8=;
        b=TdQJj8uKzxDpG9DLbCUAyJyMHjHNFjpKRb/aPM4xUN+ksV/IVYmDOXgb+Dtpu4kptG
         GxQL0n2yo0e8CcDKFTDYbMoxGJYbJfTOURC9d2NSQs+ux9vzCcM3A+/WN4T1tWewrz19
         ENmPcoWPXBTftWTTPWBc/NQg3h+oVnTlv6CD7NXOwpRDsL5xFqtUhd4aKJyT6jrPhW0i
         QFWzN9HPLPUR2Hz/xVLHeBDfmz42mn0kmBgpcv4k3FTBX4/jj6sOdV+fQ2SI/avMfREV
         mExs4p95qH8bXn0FiULD5YMJVQRXY5sO51ixF36P67BkSdsVYTZ/rUVG7JdQsId1sJHG
         rEMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjWMftfrVmgKkA0Q+nqmhGrFnq8igbaq+5fIBCpfA+SeLw7ng+OGyslljzKWZghXt7tN8=@vger.kernel.org
X-Gm-Message-State: AFuF++luWdG6IKhHsbkdBBnOeO7I2FieufJG9SY8DCvqWRykDIj3NFcH
	qXaHIot+jSZnbmrIEM2zj5Aby8MVOgXjGhfNMqV90sCeH5T5K1kiUi/9
X-Gm-Gg: AYBFou1vF/n/T3P3vomU7bHAhmb86UCCQKk1GnxcbprHBDFy222Nsgn4yJvMWuFMtJ5
	rvnrfATLSorima9ZwFhAhjDN4U2c74KcBg/0KeSJdb430EsLbStPwXP9InI0Gfl5Sb0DyETKyZa
	Eg18Z5GIgH/N0o05EecyJwP3KvG7XP7e65w0ET6oeaHBR9rAijlkKnM8stQghjgZ4yvYHNObncu
	NhzJkao7ypgDItRklzJMS1Q4HHkMWWiAf2iYQDzjKrNefbV5dl3oOlL1pW/WX0+V7YXNjwIQPWV
	kmP1qAHB88It7RNwaiF8tb0o+T1ncRDrHZZ9K1bgeavflg7/anVqn1re5Kty/LIBI3+RHX8IcBI
	B68zCWlvJzxXxIQD3HIpAR9Tnpx7WNKIR1QHg9zPHslTp0Mj8YW7e4u3XH+4ST5nuLeL0hIav8b
	xkn9D01rCJ9geBQQXr5pIWjT4YKTuhNy2Rg2DSPDc8HmYlpPMKZmfSmilm3Sk00+hlkEoXx3HTU
	4zHCyy/sXrrf/zwRTLD1XBAmG9UVboR2Mn19j/UwuM6dmtEUS/ZNffZl/bn+oXEjg==
X-Received: by 2002:a05:6820:3393:20b0:6b7:83c5:fde9 with SMTP id 006d021491bc7-6c0bb1f316emr5155273eaf.42.1789239594641;
        Sat, 12 Sep 2026 11:59:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c342ec1ff5sm1030996eaf.14.2026.09.12.11.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 11:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 11:59:51 -0700
Message-Id: <DLDKI0ZXYI7H.1XQZZE2RCU7IF@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <john.fastabend@gmail.com>, <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality
 across zero-extending movs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
X-Mailer: aerc
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-4-vineet.gupta@linux.dev>
In-Reply-To: <20260910164635.459558-4-vineet.gupta@linux.dev>

On Thu Sep 10, 2026 at 9:46 AM PDT, Vineet Gupta wrote:
> Linked-scalar equality is full-64-bit only. A 32-bit mov from a source
> with unknown high bits therefore has to drop the relationship, and a late=
r
> narrowing of the source never reaches the destination:
>
>   r6 =3D ...              /* full 64-bit unknown */
>   w7 =3D w6               /* 32-bit zero-extending mov */
>   if w6 !=3D 0 goto ...   /* not taken: r6's low 32 bits are 0 */
>   if w7 =3D=3D 0 goto ...   /* not deduced today */
>
> Record a low-32-only link instead: dst shares src's low 32 bits and its
> high half is zero. On a later narrowing, sync_linked_regs() rebuilds such
> a register from the base rather than copying it, by re-applying the same
> zext_32_to_64() the mov used. The reverse direction is skipped: a ->subre=
g
> base knows nothing about a full register's high half.

at the first glance SUBREG_ZEXT is exactly the same as ADD_CONST32 delta =
=3D=3D 0.
no?
Both are unidirectional:
w6->id =3D=3D 1
w7->id =3D=3D 1, add_const =3D=3D 32, delta =3D=3D 0

will zero extend w7.

This new SUBREG_ZEXT will do the same.
What am I missing?

