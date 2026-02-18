Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543935966
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771383098; cv=pass; b=aYICbMAiuRDfFdWZeYlSXn71tatB/JDnVS/sja941hfdg4Q/NzlJu4wPCGW5VN3dJn6CytmNWOpix1VGCzsEbsSc6qrVxxsRicgXSImI5YgoeiMB0/I5S5+9R2ZUoy+c1Iuu3bSGD2EdwkFt7SDl1BODY7nepcsJTKJr/nUOZdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771383098; c=relaxed/simple;
	bh=HzjOPHjT/bajR6N2Wlf71xvVTvN8ShXaMB+exkQZr7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3eprMcN9pYo6wC7OK1qCRKToX1c+YIkgfWJnS76nec8ZR81uwKkB5Vrcrt/hEexOuqro2z/xJ5qqQzYUmQmH9PEsXVAgKmBS6DPzl+xhvJ1cLIQmpGMGUpAo9vR6mBRqjCaQNJKjZ9vkTBe2NJzqJnePkDHgVE+Zstka0uk060=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/WhgaUp; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/WhgaUp"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-436234ef0f0so3445625f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 18:51:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771383095; cv=none;
        d=google.com; s=arc-20240605;
        b=XY4DklI8sK3P/8Nth37TcM6q79TOx1sVHHeU7ej7cmCWma6psj15fUpKVQYdzo1+WD
         hjFHhwiKzt+1KR1ddbjjuhdicvhPQvBtrB7gTiMcLnv8mHG0M1ZY42VcO+eIMf2ovTkn
         os2GDjxxTPRerrDXjCwKFueLiwYbjoCUOkU4FBuGgxAAD7oxlsJDJcaZtGubdQJtHrhJ
         li3xIf/KBNH0PzkN1LDg74+bqoqBrGxQkVqcTyafbuY5bo3+4ZHd9p/o/EGMDzyN0lBn
         KAfCf+XgcZ4AVxnzgZRlKTpJM4oh12+1VJm1sH+vKraqaYLlR/zHwXF0EBVx3D+FMQ9R
         DwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HzjOPHjT/bajR6N2Wlf71xvVTvN8ShXaMB+exkQZr7k=;
        fh=NUFGhmTTSX5ZwRIn7aT/Ndr+alzpksiKQzFEk7Vno5c=;
        b=Zl9HINixLJ8n37asVW82wyFez8K9Z/aisDr0msSIJRF6KPU6khnQkqhNQ5DnDN+2fr
         8sP27Tm5dZvFrpSuk5op3LeGYAJndG116QtbDHpZdZVf0HAzvUZH6SbF+mD5J8Yk/OY4
         TlgCh/hZfhCutZIMxwED/HO+Xd2kqVhs2ZRJJqKPJ9uLW0t9oTXKbAS28J1g5bjmb2V0
         ot+PvCOGRJOuTEL0HaeD1NlzoVxF/2XTEC9SL/ip33NfOwwWZDzlHfr63AuDt6a9F+iu
         1W1Ni2ecj+HoG1noB0X6nq7Cw31ouf47Y3zmnoZC7LcPvZRXtldmItCtEguWp3tM6+n2
         +ftw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771383095; x=1771987895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzjOPHjT/bajR6N2Wlf71xvVTvN8ShXaMB+exkQZr7k=;
        b=C/WhgaUp9ylFPj0Y+FSFIUQeu7ZZKczyahVjczwZ8Hw7HjpjgUYP3fwIrwZNEim3nx
         qh9G3gf/u3obnKoiZl/qnoP8AY/g8sZLAGNQQf7NUesRVtznMTqH949m+mPGpcmAvtxV
         2+5OShRY8QRsNWFtTLlEawdNlH6xOqNYxRoV2FARL2g2tkHvFEpHJ5pkMQvv/+qhozqP
         GxF8hwjcr9gJ8RjrKm67LnrJj4O4/JheTM7hL02nqFqP0Mmrj7m8sSc9EIW53DXAYSNc
         PIzzB2WUlybRKEEK/TXXdZzKuHdBLYqorbi6EfJq3D4SjzRUv2lIkVfL5LiDCRuO60Zf
         88Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771383095; x=1771987895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HzjOPHjT/bajR6N2Wlf71xvVTvN8ShXaMB+exkQZr7k=;
        b=F4MKEBH/SBRabw117kRtu44V2KmDaoMI8pZJyGoGhQwfE/XXrQS98HB3qn/Z1V+0Fp
         R9bL4ztRGPfMP93kOpPGrAoPTsbe6d5/unyOUKQtBrU9zSgmJ6UWFtXp/55VckGzZi12
         7axUmk1Rp8QVjgtXOhRT07uN8QX9WkNNxZv5nQEC1XPrDM1vUxZhpxRrOwHI+wiPuiLG
         SF1rIBPMHyptwdfxXMFOZiU6JUUv2MFReSW8TWWowzkrZBxAtP1dB+0OFqV6GH0x8lSL
         eWKU8hdhif+3gODiFyMJcl0LqK8083uAu5e7Ue+FLy/6hdoekmK7LAwoktJJGRrAXgQk
         Gu/w==
X-Forwarded-Encrypted: i=1; AJvYcCXiJ82SFrKcRa44Cch0TN1opH2IyAx9vZXktq3SIcN9uOLOF0f6TlbkVG4vqeqG7kg49lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABdj9TB3bwT/MomiRF4wHDV04XHIfOsAiUqwwentyyE8qsrW4
	Ljx0XCpXflbJ0lBXFDnPvXyeL/cFnJQr2E5yWbwKDAgYZxBTEVnAiMW9M0lJEXUvzrLuznabMYV
	aPKugjHnRcuslSXb7lThEwSAGPbBjzec=
X-Gm-Gg: AZuq6aL47pEDZWBw1sXFCv5GjphM06qUTVJgzg5R0XhJppuTHB4bEA7BSrjR022+Cak
	9M8IzF24pITqSzWOgO5IuvBjO6DyheZ+cG3nV92/UijYHqrBwboZIjiC672kTl3YXD5lCefPqc7
	gfEIMGQTG307VPlIT9ssPhfZk3XvK3P/fh9yS6vTjwsAAl2sKwvABhnoInPbdjp8KoNFE5o0RyT
	fyEJ5HOLlfa7b6b9afeJajSSpba5PG4s7ByQZcvIFYVXzIXSfq3UTQ+CVZO1fJCnMo9YDenXJ/g
	lPWGMjhQ50fkGrFjAGWkts/j4y8I7ZddDkkd1GoUCJ2X1zZschkkI2gBlGzEjKYC7aCp3qH6IwY
	WUHQPtZphFiifa9HSBtHs+o3Z7Q==
X-Received: by 2002:a05:6000:25c8:b0:432:aa61:a06e with SMTP id
 ffacd0b85a97d-43958e4c78amr544211f8f.32.1771383095203; Tue, 17 Feb 2026
 18:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <42397d01c3662e85437ffdfa41f5e0c0799189fb.1771316309.git.paul.chaignon@gmail.com>
 <70e49d1210d1aa77ccf713bb39c5b6a19c0081553a2fad41a581714077663c0e@mail.kernel.org>
 <CAM=Ch05qfhEzxCoKBK6MhQza4vPdCus76gt1=vGqEOzkFJRtOA@mail.gmail.com>
In-Reply-To: <CAM=Ch05qfhEzxCoKBK6MhQza4vPdCus76gt1=vGqEOzkFJRtOA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Feb 2026 18:51:24 -0800
X-Gm-Features: AaiRm50mmyvvlxuc38871naCuuh6Khf-nDJJR_Z3ndZk3HWlUonQZFpKEhjqLdY
Message-ID: <CAADnVQ+wZhriWAcHtXvVL8FRF0E-2iPu+Cdj8KqkDKKeHA+w9A@mail.gmail.com>
Subject: Re: [PATCH bpf 1/4] bpf: Introduce tnum_step to step through tnum's members
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: bot+bpf-ci@kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 6:36=E2=80=AFPM Harishankar Vishwanathan
<harishankar.vishwanathan@gmail.com> wrote:
>
>
> As an aside, this didn't show up during SMT verification because the
> bvshl (bitvector shift left)
> operation is defined such that a shift value greater than the width
> returns exactly 0.

Something that you should keep in mind when relying so much on SMT.
Shift by 64 on x86 is a nop while on arm64 it results in zero.
