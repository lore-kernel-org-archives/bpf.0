Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038C23E350
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688116; cv=pass; b=VCz9Gcj+PvTveY0kzs90+/ucC6h8FvEI/Sek9TxL2er5+RN4iMoFfaHjoYbA+g7j5mBVlRNRcIZzWgqBJmsac0PEifXjCovALkobobQxJzShvOsItgPJ8e1vCAogMGOvE10u4h8Pz20/60lx2LSg2yQoCjYyfHMDewIxHj+TT4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688116; c=relaxed/simple;
	bh=oiZQacHR/S7EwHoTc/kL7wGs0zwfmaBF4z2GD67obiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1TAea6eYf2x947rxJYaEIGbJUgZmIwisa4fn564Nz8WcWPT3E2OOAZJ+nmH+wysCMUFx7TPL4tfdIyyJP7BZzu4evoiiMrMO5eCtdxIbVyH0nNkF4inYGsfxkbkz8JXSqNdndhHU1NyKaQwkiKZFrnVBe/1pU/HXSOAvUqrVNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4q8DcDq; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4q8DcDq"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-894674a4c4aso57881236d6.3
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 17:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770688114; cv=none;
        d=google.com; s=arc-20240605;
        b=L5SE/7/Hx3BVS3a5Ldhwvq2T+YQWFgoRjmuUqcCqCHKTxOTV8SqRy3LxY49tHKbxuP
         taEwv5Phel1d31qbHnp7d74WSu4R5lKFyCuJf/FZ4wlxNQg7kdMIh3rvT0EvNayFoX34
         aFJI0dIKIZRzTH+3sQLfBkr2/NVmP+XuNYDWSDN/oLlkfSotyAcr0G5qN076IRfJx8AF
         djsscEladjMlTw0HB0DVxAwyaCHLoXIj4V0CDMOURJ63+0GXY/CJwlg+SGMH/riN2Mt4
         nmiyPCRZ3Bth/vLOPsvNN7tGqVa1ntV1IPBziN7vQiDFtcHHLQUDfG1KTd6aAkb7JtDt
         fR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nfM95cRUHR5M3Md8H2tOdqR6MV1wasnXxpRfrafM1/Y=;
        fh=SYK4naPXr8ppPb0vSRIzC5Y+GAlRmYXQw6XB5Fr1cz4=;
        b=IHVe/bXfmlZTM7ZyLIBolQ86zjR8eeHI+Q6DyqqWMn2ZvyiYOOQoJ/r9OQeIp8dyat
         WmmtTt3SLbVCc8EGgSU65p20JxHQgOcGnJK+AWfbL7p8Lba0oWqby5biIu3iksF3CBu5
         ed1C+nqySviPRFkwNahcOw3Hi779O/SnEc0A6Hxz3ItHMdKx2+LpQF0mX25h7ksCes3G
         afoc2zCQkeD5tdnYL3CNra+CD3jsTbwBwfLjKb4DWtazdk0tPXooWErw2jGjn2Mh99wn
         Q4pPclVfHRYxu+1hsmbfEZHxF3dsi9m9pr4bxZ0/sR2hAM+3RI0HehwsKcaOCGGYFz2m
         bw2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770688114; x=1771292914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfM95cRUHR5M3Md8H2tOdqR6MV1wasnXxpRfrafM1/Y=;
        b=L4q8DcDqNgXJf6HdRnPber3hRcDWvGGv8o5Wa8z+WOEnWOFvtK3l+p9Xx7zFcd1wwX
         dBZ+A349IYQibCYJ7dveTFEGO/BXbkORCCxvM+lP8T+CVtqCGyzJzw57xoBWME6+E4kV
         UrXAGtS/lwb9Ed1Y6XT1XCS494VAoThu2EODNjncucas9t1r9lTbfYLzHh6z3ujitFN9
         WzSTbcUvgsnVUuuTn8OKJk88+ZMYhram3aWk2YT/vHen8iOQAlMzBAVzuPar390QT6Pp
         pOICdBXmNSrOZG+9GaRs/GSZ1BfCiuNDIda7hIgSY34qWPYnth/KBh3IHkNhYDVh6POO
         cjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770688114; x=1771292914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfM95cRUHR5M3Md8H2tOdqR6MV1wasnXxpRfrafM1/Y=;
        b=rPtT+WhTi7GhCHPQ/dpauW5hH97wnJmxd5hLLS8WUS9OYWJoayfck0FzKUr9sN/EgA
         x2w+UH5USkapYw4Ypj+lVDS3xycvg67qUTC/edU1PRglofcZzZcvlOZzWFjgNdoToYtK
         N6PI7BiBXi7wVbKKV8BGczaeJCiQcMCr1Hsl6L3P8bEmoVKdB0+GlRnB24yO24U1GF0A
         6X60eTT+v0Fz0D+896uGGcfIcNGZJbH8Sqvelz0mZiWHCnMjMXvun8KppWMbqv14DGAj
         oiORxB3VktP883b3BDuPSn8ShUNIBj3LQQdrvLpJL3UjGyIfzscpPhOVh7IwcJ60vu83
         +Z5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXN3ytfa8NFXzws3/oaGH9pX/ZoQFaJyFIzp+TZeFM45V0PpxV5iZKwvXOpnrTUU6fPTlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwV3ZKFBX2jiFSgQuqqX/s5i+WS77OWOCiXocGj/L+mo2hGuCy
	BGeG1d6sBCZKDK8F9VocOhzKG0CvwJlIMHiGioNp5X1AHcuIHflMXYrIw241bZ2mDjUqT1iAhVJ
	q0yo78bOO122RVH4pjp2iXPp2BKypZU0=
X-Gm-Gg: AZuq6aI9QchdMqE4curG518BUihDtuv7+sdEZE1xbrkvjc3xHMqfcihRCLy+u6W9UbV
	A/FC14Tqp6vpbgxLJqkj0HRs+6wT0eKydlCrsuoNX1L2DejuEqbHDa/fPNG6VHzM7GS9mz9KuA0
	X+f+T51sL7qZjLWxU/Y956KEDcJBmXmXg1k4gBSqxqIaALZGaNzO2oGWlbTsma22/ILTU3m74th
	Em+lgooS/Y+jrORHcOe3hvSeNftjHK3svLnKdoO4+5QC5WM11/1re2qhnveje36E5xKF3yffRal
	cxSd79j+
X-Received: by 2002:a05:6214:2022:b0:896:fea0:ccfa with SMTP id
 6a1803df08f44-896fea0d4eamr74854806d6.10.1770688114558; Mon, 09 Feb 2026
 17:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209085536.16723-1-xuewen.yan@unisoc.com> <aYoxSfDjUvnIIAMd@slm.duckdns.org>
In-Reply-To: <aYoxSfDjUvnIIAMd@slm.duckdns.org>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 10 Feb 2026 09:48:23 +0800
X-Gm-Features: AZwV_QieB5nmasjZ7MAfcz8hm16jdjD9Mn--TBSkbruab4F10si3jQOMR-XGVfE
Message-ID: <CAB8ipk8H65Kn+Cg8cVuLCwgcvWP_Q4tXUS1hqr_cSweV=DZFtQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tools/sched_ext: Use u64 for kind field to fix ARM64
 atomic ops
To: Tejun Heo <tj@kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, guohua.yan@unisoc.com, ke.wang@unisoc.com, 
	di.shen@unisoc.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 3:11=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Feb 09, 2026 at 04:55:36PM +0800, Xuewen Yan wrote:
> > From: Guohua Yan <guohua.yan@unisoc.com>
> >
> > There are following compile errors in arm64:
> >
> > bpftools/CORE/scx_simple.bpf.c:144:2: error: unsupported atomic operati=
on, please use 64 bit version
> >   144 |         UEI_RECORD(uei, ei);
> >       |         ^
> >
> > Convert kind from int to u64 to resolve ARM64 atomic operation
> > limitations. ARM64 primarily supports 64-bit atomic operations.
>
> Alexei says this is llvm bpf backend error and the answer is to upgrade t=
o a
> modern llvm that defaults to -mcpu=3Dv3.

Thank you for the insight. We'll upgrade our LLVM toolchain and test
with -mcpu=3Dv3.
Appreciate your guidance on this backend issue.

Thanks=EF=BC=81
