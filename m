Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3683346A9
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012577; cv=pass; b=PVGmz4rsXDuwOdPYDGCbz53SCC4Aiic3bWQz+whO6zI1ffcSNWiRJ0blYCQvGHxOMdGfYJd0sT3b7zSKr0HVcGsdPMcWcaY+MkvLDw0f6ttiXKgF66f48kAysUqCsIsdIGT7yCpMY2m979OtDyPVvBUP9ovu6CTkhnFDMFYRxKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012577; c=relaxed/simple;
	bh=zZKKP+4IZYFDaCDFilC88QfoYGNpM2dFv0WidsWIKI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6bYMPfv1wIC/TewESCE/7WgxHDnvJgoFa1x7BJ5kpbJKn+vci063NAC3XSiPfAxRsLi1IYUngnMZoqPa2OdT3L3esRPH3qlydHEZ/TQvsNz7+1Ha540baAY1xL9fLcrzt3h3FK0+iWbZ2vwn+ksORkr+ekDz/OnDZBvs4I0Kso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0F/5Jeg; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0F/5Jeg"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014b5d8551so474241cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 08:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012575; cv=none;
        d=google.com; s=arc-20240605;
        b=V77UG910O8GnqX/S5vgxRd0ATMpQ99Mxbsi1dVFBzUOCmmHP1vI85woLpJrkwHzs9r
         yvtT8NU77P0V8eQiTYSyrELHclSa9kmWHXSjekDiInJK0UdGFtpPn0pUul4UBF9UXLOZ
         e2cqXoRNG1HVh6EMjQqVVM85bX7bvLC7XSxNwezlnTt43/2adi0/f/haqyz74VAl5Xjr
         TxxkWshkmQa2egDe8wGeF9sJAdN9ZHGfT5df/yArKO4JcgPtcJXjK5p8TDyxzcZzed3e
         ya+MqdfGHlXnBSv03Xlc1e780z2Ep2Oe2z1jw1dAFj9ofKRDK33YLjJDCzwa0qLzqhZP
         MJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zZKKP+4IZYFDaCDFilC88QfoYGNpM2dFv0WidsWIKI4=;
        fh=UEjcwTJvvYLzFUQGd57E1QqoVR84DZWWAa+oZUpTCl8=;
        b=cnntvUq+qFelrZjjOFLWQkbo2ibq3caqtyVSG/pRtz2W2IiIDKBP3MM+cIZq3lMQTs
         8YD0aucys1ALH4vGbV7bCa/kFbAyCFpflx6qAjkLpgEKB3lX/+qwc88UpCkql5mut2oA
         EuM484klbn8wwFNAijzlvjDInPvSzJVtuQeyMB6K68HzutHgxQzWhSTjXBH43aaTuv7W
         1bAGrt1fQnDvbw2CrzNMC4UEq3ZbrF+S9bhEiRL5kmCdlcqUHGSi2M3Nx8Z4k7Xd3dvx
         bT9eS4NAnsh9k826N4xbezpE38YYk+alaZVC7a9PWbswHxiJ3HCC3wzAPPcMOmULigu0
         +k9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769012575; x=1769617375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZKKP+4IZYFDaCDFilC88QfoYGNpM2dFv0WidsWIKI4=;
        b=M0F/5JeganpmcGhHZk5sMLSX7IGlFTlOhpVUhvUsM2a8ps0zGVLDdOKtHj38vLe6O/
         Ajd8UNHedzKMlo3o+OIgO3pxeqNwalCoTwomK6+w+kMokULxwcjXSzAAME5M1JUYeSL+
         O19wkNJLVW9mbhWKqgbSr9M6ov1C+q35jGBJQVgW+FjqF14Chj/mNBr+HbPQ+oMK6xwI
         Qrx4lAKAf3ooFu2e90A5Pi7uInWDIWr0+XW1EQhRRmNLIL29H9VXIl6VEdwM3zwTdSvQ
         xDOe7aWRfdaueOoq/XFzcUracW2VgN0m1Ro5ylLoEKU+6GusdHYH5d0Mv5snhjXKh8D5
         1LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012575; x=1769617375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZKKP+4IZYFDaCDFilC88QfoYGNpM2dFv0WidsWIKI4=;
        b=u1hUXLIK6GGZel9s6sO+BXfYuWw1y5zRNAjuppw5PcvnllcYTmfqkWC70dE/10xVXQ
         lGeHVvGEHaQuELHAXYA3Qxfbhpy/tWpZ3wfzQ/3Orm1v5jTt86zl2ic0vCRWg2Mj4Us8
         i/VwOXS46l6q9s7maxFVJlLx5uC0c+LiY1rrI1tQzCOvjpvXym4dlmD5jgRiHv8h+JGX
         7GUdZkdStTL5RgC/nCz2RusSgH+HCttplG1spsiVF8MXucyuDSPNYaCugQvGh1MXxUSo
         7bvnL1/ugsmQ/gDaHZGTO3PkPc+9FfuuNy+pvHr7hsn5rlJSzW2Gz65GRwLm+Ig5HSNW
         Q6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS7zc/3se9DKYDcbUZDumkPykWrXkfDeUEINH9ndKBol3CrnJhAavA6rt7h3I9CpoF6EM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzedys64CpcGBcL9ymBDojlnbPtXdclkC97X5w3sTalLb5mQrwL
	OhrBIN9uP4ptaUJsE4S7OGpZ253lqzCnFLwixxeNvTTa/cDKUp+h2lyOnc0cuVUFQtr4Wg9EGQ1
	fhIk+/PwwasSwEHpsmvYG9d42uO+9oa+s72+Uu4lb
X-Gm-Gg: AZuq6aKOPXsKjhPYkNfuUFCk4zqQ85GfKStJ+0R3zUpnW1c88lfTE0EMUPuhULjfPDX
	VCOFGxMXeEDxmGB2aqW59zlLKMX737UgPGGf/aD2Cbjsql2Uq3pJEA/SQBS2amLi5GksiyKslGY
	VQM9Nv2dux6xJPa/fQAKADfXr7j3GnpJR4hKxA4yfYtLbpW1ZvQpeKQKKnelHo5GocbKiWhDqTk
	GJ1TQET2mOasyLZVvQQDGbyzYqyDomKONJ5Y4LLcac2U5ADSntai6+OARMpTArJhUFy91O+6Ceb
	zDRPIjlDiisor03cIBJcdxQ=
X-Received: by 2002:ac8:5f49:0:b0:501:197d:32af with SMTP id
 d75a77b69052e-502e0b52d5dmr15160751cf.0.1769012574328; Wed, 21 Jan 2026
 08:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz> <CAJuCfpHaSg2O0vZhfAD+61i7Vq=T3OeQ=NXirXMd-2GCKRAgjg@mail.gmail.com>
 <c17d4413-1ffa-4d3e-8d87-0e7c2b022c16@suse.cz>
In-Reply-To: <c17d4413-1ffa-4d3e-8d87-0e7c2b022c16@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 16:22:43 +0000
X-Gm-Features: AZwV_Qhsac_Z51cYOHKUSuzgrrT7X6Hd2cSKwh2Th8VEqlGKrAYEFKE43eae864
Message-ID: <CAJuCfpFUsSKf89tVe6u29SpN7sL1X_721H5iv2yGwt-Wa6E_xg@mail.gmail.com>
Subject: Re: [PATCH v3 11/21] slab: remove SLUB_CPU_PARTIAL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 2:22=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/20/26 23:25, Suren Baghdasaryan wrote:
> > On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> We have removed the partial slab usage from allocation paths. Now remo=
ve
> >> the whole config option and associated code.
> >>
> >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >
> > I did?
>
> Hmm looks like you didn't. Wonder if I screwed up, or b4 did. Sorry about=
 that.

No worries.

>
> > Well, if so, I missed some remaining mentions about cpu partial caches:
> > - slub.c has several hits on "cpu partial" in the comments.
> > - there is one hit on "put_cpu_partial" in slub.c in the comments.
>
> Should be addressed later by [PATCH v3 18/21] slab: update overview
> comments. I'll grep the result if anything is missing.
>
> > Should we also update Documentation/ABI/testing/sysfs-kernel-slab to
> > say that from now on cpu_partial control always reads 0?
>
> Uh those weird files. Does anyone care? I'd do that separately as well...

I'm fine either way. Thanks!

>
> > Once addressed, please feel free to keep my Reviewed-by.
>
> Thanks!
>
