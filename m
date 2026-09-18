Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8A31328E
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722864; cv=none; b=F7AkRYv97uSTvm48ZbOAO7RnATEbxYY4MfzOpEqb6XVg88KOB74xHJ36gFuoXp0OJWiD6j0jByRRAqJdsH6u/n+DdLjs7Lq/haxrr6hxFo2uqZY67bURVwmJtG0MzB8H1+3TlSPH+120HWR9Tx9zrWock+Ml2L4l4tR/bvR4Fy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722864; c=relaxed/simple;
	bh=SfKpB6hUtfeLMQ4pzuFq7L7CWOsyj3Ko5MJ4c1BBJiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsTwpXcjWVvYkHTcTlC7Agx1bnq0o13x/75HVvPCDNrSxxMU48M5P2Xi3CfJTtnZYOonAe4T8IvzarKeghOtYzkOtIny91AIGtJHDPI8vbFcJKuIB5d6uVn8NyoMh+FQtwlVnxypso5ihECc89pX6Cdnc3hFXrNOhXXhUWys1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQRbrWk1; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQRbrWk1"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so330388f8f.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722861; x=1790327661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfKpB6hUtfeLMQ4pzuFq7L7CWOsyj3Ko5MJ4c1BBJiY=;
        b=lQRbrWk1HQNYPPZ+lqpF4Wz1VTXAsfIqb6Y2YxSOjWBogaDFKULZQgp+KSABYe22oB
         itdF/x1Vn5yNn/TAQoREKNqbEGG4clHsUAUshdb3FIDimMzHaEKDUhzJFGZRRQ7HgRom
         RFZjTU/gATGGJdxfWwiuMrPxCwAFFmF2cRz2ySc0f9sdT923BChNE/dSWQoX6cbkT91B
         nBGppaiEOFksiC8BEiWOBTrUnoNieT5A6Vh2qkmRgzQthzqL6MNS5Ur0TESQe8rR2XkD
         +02v25UdqFnXPwOTZwg+ckuj/5iFlHRLnGjkuHlgDhsRXV09rVi5Qjuzs3nxCfjUmtK7
         RSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722861; x=1790327661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SfKpB6hUtfeLMQ4pzuFq7L7CWOsyj3Ko5MJ4c1BBJiY=;
        b=evfVEdaTz7+kgKubrTmG9wD2Pk1NWSmLURp42NFzJoN2CMI7jUTRJddowyq+MgXTmq
         2d25WEQokBTWYgA286fyZwdyuqV23tcqR4cr67hIMMvrGfUiIPfWeJCHV4qyWMubFd0J
         SE/wrcIJUUNZZBqD/T6ocJh/Kjk6OhmsUy7bRhlhMhT+yJqMV+2npOUTKtt/GVUwP6Bg
         Qxe/mY62Cgm39kUw0Rc8kAM0X6F4fAbosULoQ0WfhTkJesFn3geGC0uHBKfZvG7HFVHD
         TkJgeXpP8FLSZZU32olMIVvLgaRETHVdNEpV9+PungiXJrY8SodH220TvfTdrQTvYxpM
         RfEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwfI4z72TToI8+Rsr9PjrBpoalxWa64h/j/d5uDd2QNc9Sl+AieluDWH7qshxgbDo4FRI=@vger.kernel.org
X-Gm-Message-State: AFuF++nmx7mwn0gQiyqG2jnqVBVptE0hspQPBTaLXcGKEqQM//HegCQA
	5086G0QHIwRBHqg8gwfOMuyB15CvS6dYhCdXSpCwVjK+/fn/W7U4b/+I
X-Gm-Gg: AYBFou0+i+uwuaXRzdapOJ7NVofnE6kL2gXyEvgp+y8mT/3fKdN9xRuV6ZJISY+FXFF
	jQUZpeoRP0DvxsGpIGMULy6moD8S67rQ7kSybF3OofiTqPo3z8mYMwGutUgohWYDEzQFgKyXQlQ
	HkEbX6iTeI2QSZKsXCMclQ/cud06L+nyVwS04WHIzDBMFH2BpO5FyOOxfdOIGWZhP2TP2v8qXjR
	iocfA1e0xdB7snLsm5jOyOqXxkmiC02MMTxEEG6Wnq4yNS1f4l8uBsKJNLyffrHkLU4QLNGRL0+
	0RhZvVJdvVIi0RIZFpBYNh5DgAKX+30oNphXp6HLl1rv8szbpqJM3CZZUwae87wGaUDyzFK3Ttj
	Eh0qFYS+uhBvrKusCCYmRBlC6p04iZENa+kmvXJ3dC+U7+tfs8PuNCq7bApBbUfRpoWqHTevh+O
	XGrFpCHyqGoEaVIWcSaXFh/d4JmtwKUCk44vrS1QHm4Ug5AHZU+vZgVFrIV2i1+xPVDwSzCCJU/
	UP9oDNEceixSgjiCk184Abo0A==
X-Received: by 2002:a05:6000:990:b0:485:ad55:208d with SMTP id ffacd0b85a97d-4871e263f69mr5184001f8f.18.1789722860820;
        Fri, 18 Sep 2026 02:14:20 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872008fe3csm2583357f8f.37.2026.09.18.02.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:14:20 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: andrii.nakryiko@gmail.com,
	david@kernel.org,
	ljs@kernel.org
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next v7 1/5] mm: Add copy_remote_mm_str()
Date: Fri, 18 Sep 2026 12:13:59 +0300
Message-ID: <20260918091359.297923-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAEf4BzaH=PJh7QUhh7szGL+gCieYLOSbhriFWaZG92xFWDeGig@mail.gmail.com>
References: <CAEf4BzaH=PJh7QUhh7szGL+gCieYLOSbhriFWaZG92xFWDeGig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> AI has a point, declarations in mm.h are not guarded by #ifdef
> CONFIG_BPF_SYSCALL, no? These look generic, I'd remove BPF_SYSCALL
> guard

Yes, this sounds reasonable. I have removed the #ifdefs in v8 [1].

CC David, who proposed removing the #ifdefs from the header file in [2],
and Lorenzo, who has already acked the patch.

[1] https://lore.kernel.org/bpf/20260918091058.297740-1-tasos.papagiannnis@gmail.com/
[2] https://lore.kernel.org/bpf/daeab5a8-44b8-4933-80c5-e4145b01a0a1@kernel.org/
