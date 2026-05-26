Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC935674E
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833300; cv=pass; b=eAoJsrmAHTEFAkGvla5jv66GSIlbsVvi8/0wZSBz/iiNG6UI31R1FZbCy2tiR0Q07LGKT99K9Z/LrM8z+i3ZqxJsa2cHY2LO7sH82wmsD5/Qp7dyf/I9qIdSXsuh+eVWOgFyWXu+NlR2IeVVU4lvS/PyWaJzzTWaRCl/QKmKTr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833300; c=relaxed/simple;
	bh=E5eVcu06k2o3PY8A09XNvdjNWnpe+Yc96+AlUiI1rCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4s5x08hEn3RFsmrC/FbUQPl93uas3SwnRTTO6qqCRDg31+GRpDSDrcAzk5gYZa9mRGDFrEtc/uK+46znR2Qm3RRA6I+6JR8/8aUvdPbREdsyLns5nw/F/uR5x/sEdaXuqJh6dCC9aJuL8dGXk1H7sghTkbxAIiLpijQohecNu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3OH9WlQ; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3OH9WlQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso25204865e9.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779833297; cv=none;
        d=google.com; s=arc-20240605;
        b=dKd13jJR8MX3VFHVhcae5It/6xRdFpVP762U0QMka5b/kg3P8A1lF8us5PniA9/WSq
         Y/+yuGQyvHYVc6wyC9nOytCCy2Q/ZkZsoCMeYmCsdNSijog+SoLpYxqfgZceYP7WjllN
         Imv+alf1zf28gK5LpoPojTCLGwl14BuDPBHKAC0WSRAal9uAtfZk5ZSSp8z5IvN5Cjns
         KIC6t02fHQCt8lxNoRDXdaD0neL1ELeXCRu8rjmGVY8De1WxE7OU7w7VM7EWGYouixl9
         oxYkOn/8Cs9gZo7zhPDQhxcHv1dJ24GSzJ9QErrFUcgvn3K7/rfWC7yRsiiRYUSsa+y8
         62bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3RWZTrTlmetuoLNV2ZDm5Lkp+qABxyw2h/aIwZbrBFY=;
        fh=+nSZV6yriRrZwYIORWUR8hKcK19Bwf4j476JIO0/+6c=;
        b=UQKa0ySTNvNFVg8reqhpZQk11IRKD41oV/xzyza+k3BYJY0wA8hpqHRE2YXlbsIP6s
         4YR+sc7CDEGIhhTsYcRQJvoTa1w0RUMuMLM+Hl9/Bf6dRetD6DodrZ7SoIVfahPABg88
         IQY8nn6KVZA6MVhfUMq+x4EAapqkRZkkrkF5mOjW8SkTvI/iLxPRuhiYPLB462Loy/Bb
         Rx+qNKxnGc2KfCzFAGYuVtgaqTavVbflqTG4kGjSlLN0ztP9AOiW8CQOB8IwqTRP/seM
         ZUggqK7vXeheDUbZ5hS33vxEvfcf/+JxnheAO7fV/92yZvd+/H7Z6o5/LJBo2fPIUhPU
         PHBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779833297; x=1780438097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RWZTrTlmetuoLNV2ZDm5Lkp+qABxyw2h/aIwZbrBFY=;
        b=j3OH9WlQ1ts8QFarLZzl677pF+Cb0EcpAd6njbMGwZCn1CKHhxh7onbuZy02ufV6y4
         lsX+w4BSZmX0EtZHHMMuZeDbR0hSbcuxMCXOO42JnRG4+S9lMaitqHOph0X8eqXyu/67
         RrahF/8WjjO1RilA/zmXhL0JAF8Nij8KB/JUh2QI4PfJ4EWei76Mk4CjgNMVNgBelP+7
         qMtBG7ZH+xex97BI4YfEZSRTrDUhO810DOq/tQ3WFeNnOY+ANI0dT3afO00pzs+Wcm6R
         kj1dTTUqV55QRo+IgFgiMbhqgrvS6eqBwA/GNQSUDeEMA0828F9BHvtQkdpFOmZfo8tt
         C+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833297; x=1780438097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3RWZTrTlmetuoLNV2ZDm5Lkp+qABxyw2h/aIwZbrBFY=;
        b=BDHrdfqSDmFBZ9GDyzXnsKL4YubTiUihJx2IOjsUvdtYkSlMGxC2Njj6dFvusGqh7Q
         ty2ClYBv3FzkUolXxUnUhArdR4SmRuE5o5or6xCXpswM+pitEzQ8GLrkN7JVOZ0T3dcC
         pDJMrQ9v5Icp3tpKra/sI7xNbyXRW3CXUFb7lu3D2y9FGg4k7RD1V3ZUi3c1+CQMjXc1
         sdbxyzQqMQKqYvPRRQ/Qb2rTDcfH9YF2PG9048I1mibu5U0+w3Norn9RlRkkggqJdAb1
         Q4WH0Dv2jgPUuge865+pvo4UCAaEY1D+C/dfsV/GC6x2UsZX+++KQPDF158hXru0IZjk
         bEQA==
X-Forwarded-Encrypted: i=1; AFNElJ+tP9bn7ldOOrhz+72Tb5jwhgC8ddWFHx3utqcvx36U/3v7u+gqVB7p06R1DV+I6Jqg0eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XehcxuCBUSDMREqDsAdCjq70my4Sof/e4NK9WPdyOw8fQG5L
	wLSAiNz4yNPerPFqJ05AJupPan6945sxfVOMsJRrKBwMR/SSoaIYn8paWL+TcWLeSfcwCY5IHOp
	gW1O2z0LAnlWZ71WOKak2YI0uLNNU5+A=
X-Gm-Gg: Acq92OGXZQk95u50CuaXIyUGHCRisAwR7OBWazAgkjsb0bZOa4qpaDOY4DrWvfesRsi
	ldz19X3hmIEdKiD8FzfkSX7d5IuJRvTUkUiiFJ2zaz0X+jjLsY+qlNkPFh7SbZ6CCX/bR/fPWew
	iwhxYdevXhlkbP7ekiRNXbPJayzzZcRKfNe/388Ljy3/bnTlbRSapPg2QgkSnklDBTjPRk9YJbP
	bwl+c8l6vz9d08iwBP4KfXRvQOjSxi7dwbKU57+PMx3JhIqQc6WwOCzY1IifiX1xzSJzPvbfbMi
	DujWMYnhA35b09whzc3BjhOSuR70phYJHjEyz/at2i57PtD+BiWIBOY03tPcsS6KGlvkhL0Omqg
	Nf4h78FbrAkEGklt340J5vTsUtFpqZJGWxhGG
X-Received: by 2002:a05:600c:4510:b0:48f:d5a0:284e with SMTP id
 5b1f17b1804b1-490428e03b8mr327634565e9.28.1779833297389; Tue, 26 May 2026
 15:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahWOVFZZScPjm2Ow@sirena.org.uk>
In-Reply-To: <ahWOVFZZScPjm2Ow@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 May 2026 15:08:06 -0700
X-Gm-Features: AVHnY4L80QQm6oMmZo64_ik7eu9jKD9D8sG_L1XILYcew8M4vDIlUwIvnSeQ_D0
Message-ID: <CAADnVQ+yjm0SJ0UQMeuS82MLDeo1bvZKSMMDh-K8D9-PNu=p8w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Mark Brown <broonie@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 5:13=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> /tmp/next/build/kernel/bpf/core.c:3379:13: error: redefinition of
> 'bpf_arena_handle_page_fault'
>  3379 | __weak bool bpf_arena_handle_page_fault(unsigned long addr, bool =
is_write,
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /tmp/next/build/include/linux/bpf.h:9,
>                  from /tmp/next/build/include/linux/filter.h:9,
>                  from /tmp/next/build/kernel/bpf/core.c:21:
> /tmp/next/build/include/linux/bpf_defs.h:12:20: note: previous definition
> of 'bpf_arena_handle_page_fault' with type 'bool(long unsigned int,
> bool, long unsigned int)' {aka '_Bool(long unsigned int, _Bool, long
> unsigned int)'}
>    12 | static inline bool bpf_arena_handle_page_fault(unsigned long addr=
, bool is_write,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   dc11a4dba2464 (bpf: Recover arena kernel faults with scratch page)

Tejun,

thoughts on the best way to fix it ?
Pls send it to bpf-next. I think it's fine for it to be in one tree only.
