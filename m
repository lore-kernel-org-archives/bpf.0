Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADED3FE28
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064806; cv=none; b=f8IdracfmrPKvoX1fGs2odl2gJyRlHQjtaLKcMyyOAsYEGAAyoxCQ2JRkc4v9LnQRxlF2VqNQcXoDqdXLZzMFHze1Mo64QPpGJldlES0Ib5CatoToQ2DF71uvP301TLW6XzTVfifxvFSU2ItUtZjyCmHrmZchqGmJJHuOCAlujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064806; c=relaxed/simple;
	bh=eW5JOWI1VZO+qX8dFEOymY2eK1G1+PCq+jFML18npSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5Yn8DoYJQzkiOSrkoO387zv5U6/LzcMf/lvj1zyOqFCY4jbobKICsbbGBhfxFqSXqPlqep9NJ7lFG8eaJgsz+QN3iqMK+ha9SeQ7uAHu4h3YhC1I2J4YT1bd9oh3kNtI7eRxIpyGVgmlD1wYxW3uEejFtxvLmShOhHHD7VD6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHOzrhPl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHOzrhPl"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-414775b1cacso5935375e9.3
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711064803; x=1711669603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW5JOWI1VZO+qX8dFEOymY2eK1G1+PCq+jFML18npSE=;
        b=iHOzrhPl1c4wmEWOkA6h/NCS4s6g6To5IKTPB1/ahZh3e7NXS7bFnZNBzfz98o7bh+
         3kUQayTqomMkRkyz1RR8ftoj69dv74wIB4mEQ+G3vtdUkZVYsrIA4yuOYt7/V/zEvVcb
         //YJPLSlLCTdDQ03I+UamO51+RUW20JebawGyU/9kgLF5G0ljPvy6W9OsDbXuPSTPipX
         JtdGd8hWy6aS1c3EgQhZWWOad/4JxofBWf8pbzrORx+/WhOTnsIyJOkbopw1wgObzGr3
         cBez00rKoPAziXsMAvEiGiNBSpg394V7GvUEda028/rUHsTXFLkgHHTsiXMFZJWhIvQa
         CPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711064803; x=1711669603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW5JOWI1VZO+qX8dFEOymY2eK1G1+PCq+jFML18npSE=;
        b=n6GQ4OBMkdem4csSq5a+Avg53AtJqGFChn9/+t0IXAu7S29jYpK53MJoSwhjG/SLSo
         /cPMQ7zCbdxHwqQSOOPeFlc05x7aMFduxuiGJ3O5IWYZEyrL4zeJIO+/q+HiLBV4CS4W
         7S+ogrLVq6q+4YFVIfbNThxXrGlAf34i7VB3WNoyOmlSw50UcQAYONRV/55Nlqo71Dcy
         ggVds+f/w/IGoBBDp8V4XcsMk37kHdZN/dYpdtryzyj0AXAVEq8d1Zz/HvSdZC+dudxU
         r5M9IZpWnt/a3APQRWcWgZ21GQQ1UWEBD1HsP4G+A9ypokUO+utnLvUfH5a7rFDkuzUy
         iKVg==
X-Gm-Message-State: AOJu0YzdekSeBkCSz6kLoNhXfEfm0/U6kSLvkCWzejiAlGDfZoldgf47
	iDPGalij/Ulk0O6dw9CuJx74Sx6tP3Ll4mNi35eDNszjbuMZyvf3CXrXWi/BvE/KeAh+5g/bRcO
	bC6VDjPZBawQVZvL6ckfjNdouygc=
X-Google-Smtp-Source: AGHT+IFJfUvf/T+saXgS6UAjhe+KM/hpvcawIBDT0/B8UaeyR8v7Eo06ussRvQuvj/ScgWJ9lKPzebO5voVjV63xbGc=
X-Received: by 2002:a5d:6da1:0:b0:33e:1e95:cac2 with SMTP id
 u1-20020a5d6da1000000b0033e1e95cac2mr582532wrs.11.1711064802669; Thu, 21 Mar
 2024 16:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org>
In-Reply-To: <20240321180501.734779-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Mar 2024 16:46:30 -0700
Message-ID: <CAADnVQJqnLnv4AUvCaefP13CDcJOXM=kJpSOv33t-u-OTzb0UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Inline two LBR-related helpers
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 11:05=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
>
> There are still ways to reduce number of "wasted" records further, this i=
s
> a problem that requires many small and rather independent steps.

I feel this is a wrong path to follow.
I think it would be better to introduce a flag for kprobe/fentry
to do perf_snapshot_branch_stack() as early as possible
and then bpf prog can copy these 16 or 32 8-byte entries at
its leasure.
Hacking all over the kernel and requiring bpf prog to call
bpf_get_branch_snapshot() in the first few instructions
looks like self inflicted pain.
