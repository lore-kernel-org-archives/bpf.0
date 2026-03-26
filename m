Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5516F3A6F17
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567804; cv=none; b=BgXg3fcjVZQRoP74IzeLwmDxTz9rRdYIFzmb/pAf15W3iN0juN7pK7uQ3JeJ+izTau/Dta0gmemb3YtW7xLkkjCqlrp2o0Q+IpV88QbnMbhIQNfGjJRBIZP1IyIvWUtk8P63ucJIj9beMDplW/w4yqlUkDlS4IafkonSxOb3aTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567804; c=relaxed/simple;
	bh=ZAxzm5r1A8QCuom4v/qqXiX/6Y8VFr8Bo6ioi7kg4iE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOm8AqdQHQUNneGSTa4grr+bJArLDcT6nw73AuzHd8WXjTm0E1sLCkBp7yM1cQgmB73BDL2qXJTKEW//S5lN7x/CZgnmglvAlF5EMObj7ry6QW61hwCrEi8y/Di2qro4nx/IuyXwxDJMSidZUPuqXw83Dn2rR9oxPenGgFUqYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKAWkeSf; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKAWkeSf"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128b9b7e3edso526224c88.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774567802; x=1775172602; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZAxzm5r1A8QCuom4v/qqXiX/6Y8VFr8Bo6ioi7kg4iE=;
        b=NKAWkeSfOXiu1Fy9w3NvdsvtVUVlgbeLzgBrE+Mr6vS1PJY9X4Ynd1FnGoA4PUm27Q
         UdNXrtAq5VNn0FcQpE3Ev7jA021YtlXASuxlxAcCGwMT+eiBlY6KDg06966EwTvXzvzm
         bb5CWsRbQQkKjltUWdq6t7nhOvMfe7H0Z0lggTRCh2Grp2ys1zgJhCHi1q/+LChWPKDh
         FJWMkaisFQs2LPWV+XNErCVtP8BI8gnDpcA87eesT6Qc3JxTwLNdXh4+MpDoNQkSbeQX
         orrnhczGKR9UUAdgtYqhSJwr3N4+jEhnVqiuhokP8PzTr02KOLfN+2UZ+jtw5W58IHDl
         tQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774567802; x=1775172602;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAxzm5r1A8QCuom4v/qqXiX/6Y8VFr8Bo6ioi7kg4iE=;
        b=mm7657EXclfN+bti64saraHypyFxqda5bTXibf+ksaG/7W9SPiS0NK53283C5pWnV5
         Wuk48qC8qhpppeWcGNw8OWvyldmNRa+ADGvXJy4a6G3bKxkwl7LfvSZcjG1GAaxDUlKw
         G730789IyWFaFuCz/QiW1ART0xEq1GsP1v020f1LCj5km80VLhr7mBV/6KNL2g7tZWbG
         3LPRLfddtleXOQg8YStOecbrpTemtru2g10zb+3nBAi56g7P1Ws2YX2W3AkFXxtKLwng
         e0SP9aRRfzrRAd1KGBJI65lLnkX0BhpjSAYAfJdtLKZeI+Hd36R9F/jVkMd/tIHba9gE
         l0pQ==
X-Gm-Message-State: AOJu0YzLHgPgz1nfHDujvoDtbb468LUO39qIwh96V8HqeZptxVjXH/aq
	mn1oPFhHgCv867T9umnpUBLV15/jxwkQSvY7heL7OLbNPuX0rt8osVbC
X-Gm-Gg: ATEYQzwfKqX15qhIJGUVs4AeMLpoJQ2XPayeBx1goNlnvLff3sUzEIE7Y5B7gUkTmt8
	gZoCZcPt3LoOzqecmVbozIyiCz+nOfkJgzgHocXG5fhMnzyZmtk3Ik+C6NgtoXr6Eyas1nMX0OU
	o9Tl1Het+6Me7i0NiVDSLRuYhLOHoufCqpMtzs0HAeJb/+g+I9Fr4v7EpKK5EBDtq81x1B11dpZ
	F6UEv+8CSMRMt+suCY/7J36Z8S9XNRaHo8JeAFYdFKFCpPjuFH6MoDVEcXUqsc793X+nhjX/78Y
	L+4kK2gxlJaH8cZqYNLzehZFda6hpslqlkNggPHv3ntZHc62sUzQw/gSaN7m/k0npYkpEF4L+Ym
	PPrdgMEYtH7gqb37/fCwOkiGPDfk2iHjwnrHLZU3g31X1tyNAWYE2gTFSwuoZpsyebrKAYaTdIt
	M3fYFYsXlecsr3JZHcuy6AXxOSd+zvFJVfLfprtXsH1tbigcQSKJkEqmgKSjWUWKeRoQ4cc/dma
	hssG9zuIlDaRHvQcyQ=
X-Received: by 2002:a05:693c:2b06:b0:2c1:7673:a6ae with SMTP id 5a478bee46e88-2c185f4f56amr245235eec.34.1774567802372;
        Thu, 26 Mar 2026 16:30:02 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:4a82:c020:f551:481c? ([2620:10d:c090:500::1:634a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ee29ff9sm3419314eec.29.2026.03.26.16.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:30:01 -0700 (PDT)
Message-ID: <23a2ed0f2272f74bd7eed4720a2ee3b442ffe02f.camel@gmail.com>
Subject: Re: [PATCH 3/4] selftests/bpf: impose global ordering for test
 decl_tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	cupertino.miranda@oracle.com
Date: Thu, 26 Mar 2026 16:30:00 -0700
In-Reply-To: <CAEf4BzaETjC-_mZ_rpDkbxnXXBZLvh74mzNE3oW_Ra-VgGMRyQ@mail.gmail.com>
References: 
	<20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
	 <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
	 <CAEf4BzaQqWprVN8RcvGvAEML7rGsGE+x37+RYRHADsGRNd4JXg@mail.gmail.com>
	 <46b5a0cdcb00899de5580896596ee5d3c693f3ac.camel@gmail.com>
	 <CAEf4BzaETjC-_mZ_rpDkbxnXXBZLvh74mzNE3oW_Ra-VgGMRyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-26 at 16:00 -0700, Andrii Nakryiko wrote:

[...]

> > > > +static void *realloc_or_free(void *ptr, size_t size)
> > >=20
> > > but why?... why invent a new realloc usage pattern just to save two
> > > lines of error handling code?
> >=20
> > Yes. We have this in verifier.c:realloc_array() and I like it.
> > Can through this one away if you don't like it.
>=20
> it just that you still have explicit free()s in that function for
> clean up, so this realloc_or_free stands out as a deviation for no
> good reason. So yeah, I don't think it's worth doing... but I'm also
> not going to fight it, it just caught my "traditionalist"'s eye ;)

I'll respin, no problem.
