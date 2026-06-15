Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A4246782
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498104; cv=pass; b=oG7Jkhaa+7NWw1iNfHO2Pvvug5OIiy4wE3J/y8H30jVaERNHO7gy9mX2rBGO9qXhHQ8gTvjFiAgqhh9fJXxcWghhmfdw/tcRQhwa4fCe9x+5GsaNBHYkmrMDThg+aF4DxuJvW6LncHgcc8Btlldn7WZ+rKQW0gqjSzfDpBG1pFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498104; c=relaxed/simple;
	bh=CD2VJysUakj2ypsLvJ5QLrQ5K025FJvQAqxXMhehMJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsK2jFVHW+2hfQpYgCfxeja4N8KTp4nTXn2o4KuByNOPwyE9+cy1VPVRt5Kb0g1a6D9CCvj3+KB+TDIW/tzLTPCI85odHvfgHCV5ODUXCQjBGlOrLoxXWgTMuwtM4canoxuM1msJqvKWjS+rBmzgEVSgwx8fwGnyijVGnxc52F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbwpYvUF; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbwpYvUF"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso1678723a91.0
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 21:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781498103; cv=none;
        d=google.com; s=arc-20240605;
        b=Zlv0OC8nTBHvlrB9mTr5cVthsv6o0lmgrUIgr4HcwBIyyUW3HoWLfb01z7fosGxFgj
         MsKyAhTUYhzCzoJy1f9hne6R75VveiELwkoplQP2sUkemyAQgbU5f0TWL2mrGeU/Kwhe
         N3aXTZ/5YhUC2W44s0Rio0lii4BrBUw+M+5ukuwtdUeLBIykPoezC8t3gW99+xpLzLwI
         f4vlbT9nCsyoGH7rcXlJrVARoVMZFL4mSfw6eW/HqVwsqA70NlHni//Aj+rgENPq2htZ
         bLuPEjmDkji/JTxeQ401tLhLn3uM85eWAgDTZTn9IvlJmByo+zlGInYSAQG3FlC2aAC0
         Y1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b7zFS/YeKuVvrxAF/osgXOwwZhUuDxsU9pyU4h0a+84=;
        fh=eI2y9FPYBdJzabJvShcY+z1/w1wQcOa3HJgQO1nVxH8=;
        b=PKvrql2VpcSKKNDDno4JJ8Ar32fQ1CkEupdrR37yzi1rkk6q+ASpsHBAdqlx+ru8rt
         a0tZ6/+1/hQ4tDZb3m8rGyp1bhPMb2OuKBCRzdVosa8yA6YIe+InSQ2tKaHm2aq/JUh3
         8MYF/t8TMNCS0+JrtyFFZU1pg2Fq8N2lDqpAcb+879AEZNO8riYR9L/cn6ChuN78wirA
         /n3InbtGUEfEzbDTgKy2O1HhxU0lL7/Q0fTFeHNC6Za3r9n2CZMAzgt0cpTiBYhpsCT/
         N9rk24iU1nie3dTlYyd6BAmwjqQZTvF3E3Rb/7gyXCkRTRUCNpYj7PoA1kxxiGdQ4RhB
         G1ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781498103; x=1782102903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7zFS/YeKuVvrxAF/osgXOwwZhUuDxsU9pyU4h0a+84=;
        b=VbwpYvUFjTmS2nRtGoYVdwzyrfnyLxdcYoT7RvJYLH8iwZ+XXjOKnLn2NlItww8Djp
         qRyB10dhmOS1PSHsAcTdlZ95kUg2BZNrcT/rvPVlXWNT3TEKa91iPwV43PhIxPhX7qWt
         +UmcxwOs6Z2vp1QdV1UbDXGshsZsVAQgXDAaY9XRS4Wa5ipmfHlCIqP8yGtY/8aPVBpS
         stjRvFdhhg3YAEgHmVQHHvo4/x2ZGTb1QutJ0quO0VCunaAMLRb+76wC22nvbAlmrepP
         J2CyifXFo2yv85KfsK89jxOpr9c1DjEaFLnzpmAYfSH7NPKw4WHTU0BgJxMWE+4EPOAO
         3KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781498103; x=1782102903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b7zFS/YeKuVvrxAF/osgXOwwZhUuDxsU9pyU4h0a+84=;
        b=UJ/FEbaKph322eo37RZH0vxBVkYP2acilNlaKv+LFoPd/+P3YNnuHlsDFXq2DkB38g
         n/YC1dFGZFX6rIOPA3kLMFsggBMoXLpqDYVRFooNtrp+xWyITjW5hjfxb3aowVFwjn70
         7GKyt0iairn6ZpSG+LwMoCyYkETQSSA+htnhQpXkUc9neRH3V0+lRRKgffjH7JZ3+mrF
         iMVv8FnbiMDY18KmJNVTOjdRxu91nfnkBX6gGzS1qWZ6nSpugpNs67tckLfLmQe5KgJM
         1xtZwdAHUhQyGYPkULFmZTh4Een2cWPnKvmW7LtDjl8W1sgYUW+e/CLOg8MYKMjo2F1D
         yykA==
X-Gm-Message-State: AOJu0Yw6O9ZaewcO+LG9qOEplwJ/U0cPVIbTTf9uphQfrnwZ7n36siaz
	TDpa+y1ZM8vP1EM+qbo1AT0zZIOYic8Lp5tcqZdUGqSa2UUI7mrzxtvbcfl07EMBixlxbTRRYG1
	VnwADfVt9FYCvDvBls0dTQ6ME7Dja1XSQ0pXd
X-Gm-Gg: Acq92OFT4vdDUTEbRSVfqwTpcL1mnuoT6GCfvkFv21LC4C/XTOgiC4K84/GzI6ByVV+
	ZNydYhIphtTYzJCRk8kwibyJNMtjKV9n4O+EFwbz+tS8qDW3Esz4vPMHmbPJ/CdDPwZ3QzjWaeT
	jQOdTyIh9Y/ljuo8ssM28h9wGU2NPcY2OXFBE6tnUMvDDZ2N8QqN/qnMbPmPBfq0flgYiO4V7BV
	3QIR9r5i6UJmtZk8Ov8d4dgqiCgL6067oLjFxPlIR8Ik+uZKjiiIsn2JQ0xqDsAg6HHCwp/q0YF
	04HUhoWt8GOrMordW2VeBw1eSCv0payXrgexfzgPj6QyMg/C6cnARXgYhXI/n1xEp2qKVWzyUaO
	KucE/Dk7fIvJXmdp6mNpdQYAO
X-Received: by 2002:a17:90b:3c4f:b0:36d:6308:12fa with SMTP id
 98e67ed59e1d1-37c2bd03a99mr7969581a91.18.1781498102770; Sun, 14 Jun 2026
 21:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d12081a0-b933-44cd-8c46-5d7b83cf0347@gmail.com> <20260609083709.168755-1-linuxoid@gmail.com>
In-Reply-To: <20260609083709.168755-1-linuxoid@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 14 Jun 2026 21:34:50 -0700
X-Gm-Features: AVVi8CdNb8ICzunuWmv247kYQHQ4MIBbnuh3_Ay-KZdUM2mIFbiIz_cU-O00ELU
Message-ID: <CAADnVQLrKQOR8qC8OeiRgne0QcVV+50ykgxw2UL3mcjKCcEfZw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: add tests for arena vma split
 and fork
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 1:37=E2=80=AFAM Ruslan Valiyev <linuxoid@gmail.com> =
wrote:
>
> Add a test that an arena map's mmap()ed region cannot be split by a
> partial munmap() (the "split" subtest, which expects -EINVAL) and is not
> inherited across fork() (the "fork" subtest, where mincore() reports the
> child's range as unmapped).
>
> Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
> ---
> v3:
> - Consolidate into one file with a shared setup helper and two
>   subtests.
> - Put the opening /* of the multi-line comment on its own line.

Sorry, not every branch in the kernel needs a selftest.
I don't think we need to spend CI cycles for every future patch
to test for this unlikely regression.

pw-bot: cr
