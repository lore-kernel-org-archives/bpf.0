Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FF3AD524
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293304; cv=none; b=l1S0jlpj71CcO/PmlWK+MC5FIwXezn8pU0SteE6R7sgS7ZkMs5wkWS5h5P/2YplWHkW+Pe+JaA2fll1SP8Als83f9Kbtlf4gzfKH7tDjnVVLHjTraZEhyVozmsqiDMSqvbbgh7pIuR6xcVIHnqSvTQttNIRsxsxcaKKDWczJtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293304; c=relaxed/simple;
	bh=9c+jD2z2sETY12oFY277uAmbAaajDUjpcHK99y+prCM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPU14ZV/NllB0OR4tdy4O/KRdH9cVmkugwxz23+wm5w0PG6xvnQ4t4wrWdoNQuscoOdiKXT6T+KQRYGeCDgUT/RgUsMPKrL05hXSgSEVu6z/uk2F0687V+z4sAP7R7ZXt0mgKQkoVP5z+NVr45XKO9mwEfQznEABLwobWjkLwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+ioyn+t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+ioyn+t"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4924f8db066so4608225e9.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782293286; x=1782898086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFKkTvWOSQrcXuCFTLZ8S0fbWlO1anbu3cbJE6d9vEQ=;
        b=k+ioyn+tAHpKei88ufuesbR+DFyXU8J69zS9oSco1n6/IQLOHzQb89F4iSkaWXeBHL
         ldcny0p1IbAFHVE65L7q6eUmeeyMdjjz3cqz+qyw8tf98SZ9J305zYY2NwAwQO/iakJG
         YoCQa4KM3fXW6bGZ7VNhE34smVe+VCVm2DxjeKgTzf7dPcnaU8nrnZX544uz6dMm8HB+
         V0JtwE9AgcwG7qQ1kOpMLamXhRO9NQJEDx4pAJIajE9KhWuf/iBV2uJTE22h+TnP2jrW
         IAxQ2a6nGmSBs8fKrBsta9pMrMhqTyDj7LMN4C8BTIK/Mafg92l6dE42MU9TEDNSSKDb
         bTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293286; x=1782898086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFKkTvWOSQrcXuCFTLZ8S0fbWlO1anbu3cbJE6d9vEQ=;
        b=Esjw8D0FAKXI3+4JlbeH0P1uEAaT6yoGvWf6+67NM+OuDwCJ8yWvP5mczzWSN9wQrF
         JGvK3YHiRcX8kIXeoYMYVxWRtYlMkLrh+NtlkHk+HpmEjZhphofewcODBdWhz3nqGsmW
         PYCVFfJ1SsMHUzX6DcKmlkCq5sjM8nU8B92HcNQ81LRSvfE9RtZkgs7RuFnUALfIgTz4
         TWnVMsa2l7AUuQdDgxdW9mc0TIVnMiMuPqdShdYdOuiyXvBG80TZNLpvSGRCx7onu3Po
         eikDf+Hy6mrfRBboeSjf42XFVeyyNQIZ+X6N6T4YmBr1EZEjcx+O6xyOPP0i6bUySn2a
         0YhA==
X-Forwarded-Encrypted: i=1; AFNElJ/xZz0M+lc61X4MiEux/pQUVx2e4WxnZ+HDBmOaylt4V05z4cSYygenIt4ajpbp9EFKFbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkQVR0z19uwPs/PeprpN8Ryeh3WUZZSjP+DZzSa4j9VvFYqI/
	ti8HNwnnBHUKeAp6H27a3jUiXvd42ojFEQpGNiHBRY6lzPR+pC2Nmyf1
X-Gm-Gg: AfdE7clu0SdAyhKiD5LfnrNoR3E1rnj04lOGtygyt7vdSrJWiUDakY30HI2dyPCCq8E
	fO9Ko3iDYjcbGryrFYQf87mVrz/74wbm6VC1zwZoE/w8j4eaphQCFMzzNmjvLinxuf2ute/JD5o
	XICSbePFwnysBX4vZssyJamXBm/7dsKNBRR9SliLDPq6ncMzSDXaLmddIXK3+U8lL+mBcPrLfY/
	Z5/Asbu4j5FDC4Q9CyYCCtOIbh3Nh77NUl6v8uFPMulOWHAwEz0wClD7HMrfjgnu+py88lnWx+d
	5tJ3h/9oqWX/rr9ZrFEyCybsBUums0sh8+9MNh915Qzb3q1M4NOCJjHB2OpZeyc35xSQyfx5Uz4
	2m99699fkSDagv+XlsPDlHnEHoFZHN4GTr6EAH/ZW18Y62o38BtmFFoophP2UGndYBGw/z4Zjxv
	st
X-Received: by 2002:a05:600c:81c5:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-4925b34ee58mr88244475e9.6.1782293286012;
        Wed, 24 Jun 2026 02:28:06 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff821aasm466328435e9.12.2026.06.24.02.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:28:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Jun 2026 11:28:04 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH dwarves v7 0/5] pahole: Encode true signatures in kernel
 BTF
Message-ID: <ajujJM9N0_QpB_3d@krava>
References: <20260623040704.2732530-1-yonghong.song@linux.dev>
 <ajp70MRjHvCJNeyv@krava>
 <d270a215-264f-4c5c-9d7f-0b1568815e31@oracle.com>
 <b1b73cef-f25a-443d-8557-4cfe92938b46@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b73cef-f25a-443d-8557-4cfe92938b46@oracle.com>

On Tue, Jun 23, 2026 at 05:02:30PM +0100, Alan Maguire wrote:

SNIP

> >>
> >> hi,
> >> I tried to get the numbers from my setup and noticed that some new
> >> functions were included in BTF compared to the current version
> >> (functions diff attached below)
> >>
> >> like for "arp_process" function the current pahole gives me:
> >>
> >>   arp_process : skipping BTF encoding of function due to unexpected register usage for parameter
> >>
> >> but it's included in BTF generated with the new pahole.
> >>
> >> in addition to your explanation above also one of the commit says:
> >>
> >>      - a parameter with no location, a constant value, or (for non-clang) no
> >>        register found is marked optimized out
> >>
> >> please check below, it seems like 2nd argument of arp_process has no location,
> >> so iiuc it should not be included in BTF, right?
> >>
> >> thanks,
> >> jirka
> >>
> >>
> > 
> > thanks for catching this; it looks like we return a bit early before detecting
> > missing locations in the non-true-signature code. If you get a chance, would you 
> > mind trying the attached patch to see if it fixes the problem?
> > 
> > If the fix works and Yonghong is happy with it we can add it as a followup
> > and land the true signature series to save another round.
> 
> actually sorry that patch leaked true signature partial names for gcc; updated
> patch attached.

hum, I can't apply either of them, but I see that change on top of:
  alan-maguire/dwarves-true-sig-v7

but on that branch I can still see arp_process function in the btf

please let me know if I should try some other branch

thanks,
jirka
