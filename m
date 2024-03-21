Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768C134431
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049338; cv=none; b=D4EcGcMtMk4VjD/HD2SWEebn2QWR8gsuLWTjECDvm3WsBkpOrSjCCiwKLu5eBEgv49YMCLotOfT9ILHB1PmcxOs/Z0YUDCDc8VfxC2NRfstQshOQyP8GFOacA8fOUQ+kP6JoDmAIp+/tHd880RKvGLqR7QQy6cY1spIYsb/20Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049338; c=relaxed/simple;
	bh=dn2C2alSgY4+3sOHc2h++Ogi/kTiIYs5MXW1xiR+TP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0MmxjKkmwGABVNrhtHPkbdLUFG461saE0EpKxudYLihrjvEu5QriMspVVuarOcQ8S0+BZmTHZIT7x5WRLfKExN1tqVo6loQzgbe6Nu/4H94Fkm3sQGbRGiqAYELGqZdagP2qu7kDhZy5/McZOPEczyA0C6VvdWPgggPPi0wKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLlCtEaD; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLlCtEaD"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78822e21a9dso78229685a.2
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711049336; x=1711654136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn2C2alSgY4+3sOHc2h++Ogi/kTiIYs5MXW1xiR+TP8=;
        b=RLlCtEaDB4yzpPG0dptXQk9aDUh8+ZIw8fhncEWPASqq1mf2YZzoRpvjddjZTYbYfX
         llWqrtUJaV2/QoU/nbZk/iFNZ6FXWY6IG273YAPb2rf6HaJrBLnZndJBDoKsmmZvldGj
         Gxacpsjj3NEUfFdmy9nxKx4eGZNZEYNuz/pe9KscekXSplBDi0XcdaPYMP84aExVSK92
         Wn3+NPFtsnzeTftS+auQ5yuOe8GWyOwwSDG0gjJ4srDAzXhzV7f8l5AkNsMxmONTAdY+
         pN06K+DeIjdA7F0VHplwVu6KuMEIFUDbDu/DBcR1BL9YsveRnf48XVt1RpxcbqB512Dr
         wTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711049336; x=1711654136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn2C2alSgY4+3sOHc2h++Ogi/kTiIYs5MXW1xiR+TP8=;
        b=NBfoa3zSkHGhD3QpYlR5f0T8e1IG2esLjpP0Ni1QocKEmhHJ+kGJOMoPvUi6s8qQ6n
         op2OQt4f0D+Ds6UOGfhuC7yThVPlF/KB2k36PNGeRqfQl3eGgc/3q9cSl367fwPUqXG5
         +uqSuel0z2J8a3x3VVPDHE2znJotWS+lGpJWwqTy9ZTLK3HQP19X0oZCpWpGAwA6QACa
         as9Bk+dOK9AfIxb/miICpRnd55uPmC7x/FrumYb2NxpFAum2fNH1d5u4EgijxPoyWER4
         1qOOI8KMsMO9lu7jt+oXlBl5Qd9me6SjzYVotBxZoZrdPobPTqr7GU4Vh1xY+KLNHd+i
         TE1A==
X-Forwarded-Encrypted: i=1; AJvYcCWbaWaVqoN3sdZBl6J8Y1FdmtMFhAJmFfHCbgKkkHv5bxK69Qp4YlQfyMNQ8CqfFJBICCcU+zvaMSMPbns6jErfZPcF
X-Gm-Message-State: AOJu0YzZU/CegCYhxyKZSen59f4AEZihv06Lp1ubVH0fcMCVEnTDe08P
	V5VzrXPLA7+YiMYEq5VGoKMyfhpvGmxEBCpDRGra5G6KMU9djmBBvtIt2214tRU=
X-Google-Smtp-Source: AGHT+IEgSOFvl8xwMs5y2gtg7usEdb72Qigix9m/gPYvvQ+LDP1prF9ulwjb7as4dGEUTtvLC2vA4Q==
X-Received: by 2002:a05:6a20:3ca0:b0:19e:ac58:7b0d with SMTP id b32-20020a056a203ca000b0019eac587b0dmr601889pzj.5.1711048982252;
        Thu, 21 Mar 2024 12:23:02 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.84.240])
        by smtp.gmail.com with ESMTPSA id c12-20020a170903234c00b001dda336de37sm192762plh.240.2024.03.21.12.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:23:01 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Quentin Monnet <quentin@isovalent.com>, Quentin Monnet <qmo@qmon.net>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2] bpftool: Mount bpffs on provided dir instead of
 parent dir
Date: Fri, 22 Mar 2024 00:52:55 +0530
Message-ID: <2745470.mvXUDI8C0e@valdaarhun>
In-Reply-To: <355ad113-ce6c-4bfb-8ae3-8b1a37bdcda0@qmon.net>
References:
 <20240308130619.28123-1-icegambit91@gmail.com>
 <10467264.nUPlyArG6x@valdaarhun>
 <355ad113-ce6c-4bfb-8ae3-8b1a37bdcda0@qmon.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Sorry for the delay in my response. I have made
the relevant changes and have sent v3.

Thanks,
Sahil


