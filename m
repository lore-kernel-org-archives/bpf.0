Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4619E819
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627118; cv=pass; b=N8Kw4bOD2rrzmFYKkpksb01Ap/E3zOJ9g7IGFydTVLvfzIcpU/PeH1dBVn4bmC4CEStbGAEVBtKzyY5xtNMcJIXStQepDstRxLWCRB3mIsQaFcdqevrKvRg6oqRVf/GuvF/mDe2t4UsUzyDEl8enYDhDc4+WcI1qNmA8OtpDG1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627118; c=relaxed/simple;
	bh=O5mLHtMbAapNPXq46N093tL3wnr+hNWmDAcn2GGibIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5PAfCSYtZgkwS58BGCYy+YQY/HGB8OtyvF6KPurqnvavdp3p3J1e5e/wJWc5l07Oz1KZW3k0d7cM/fF8CqKkfmY5Jv42VVaeI81f6aCvdoCVrfrVegxWH7uYzIDnFgpFQEqZksJOSTIgFxqJb9fO91Ia3m5EX9jxs8REefgHEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioG5qRnG; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioG5qRnG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so17310555e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 08:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774627116; cv=none;
        d=google.com; s=arc-20240605;
        b=KZstjizc5AYvQ7cvBWMrqlPC4aMHaCMIlAfUPS/u+PDEkL7sCb97hAlmUw2f+7Msji
         qf/94jAltXrmi9ClPhSh9UNY0kaRPqy1/3rv9gYFEXd/l1PskFCIVS/tdt4VHvk8+Poe
         jRQesU+OcdCXP3G6YMcsjTRWPFgcdcODEBNYQo7knDHHijwrAG6QRPLQGU/gYOiey/ZM
         P8SSdhbyIV3hj3ty0+TBWANk57mrtW+4tPfN1oU8oPJS9ZkZxI3Qo6cyMmOQU4zUa1uP
         anCqaenTyeoo6A/cBKiPiVCPVQhW1mkWlRzdiajUddVQa5S8KFL/4sbO8krKlVBc7Fhf
         +SBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O5mLHtMbAapNPXq46N093tL3wnr+hNWmDAcn2GGibIA=;
        fh=anmv5tDMEsbwl/SiM9sbKXbYDTfWawOGvQTOhE7Npdo=;
        b=BdVQEYw+kgEryfAyTuj2AZjj0stR8cVRiBB1SMTetSMauhcsynI2a2Ap7TRBui9xus
         uIF1ZIGpHT/8alH6UxTW4HBkdTbHHPnM0vzpG5yAjgZy8m1OziIQsDtBbVoLjQpd2Eao
         92Q67/5GK6r+Yup05YDhyVlq2hO2x9e4kl3vV7D61atT+tY1xrF2K8WHsqc+p2KPZM8n
         THp+LD0eSAhgxJHyE0NBYp4q4WJqrwkTk96xD/xAOx3X+lzJFisGTEm1+Y4wJinrsejI
         3yYONATcEvc2SNxkesNSZeoLpVG1osGyBqlqwUQkn+cM8ttJnjWxWXZMgC8UbH3WAkmu
         fsQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774627116; x=1775231916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5mLHtMbAapNPXq46N093tL3wnr+hNWmDAcn2GGibIA=;
        b=ioG5qRnG00feXy0sLCP+PXxmoSFDnSBmgYG6IhFr290/EpqpEF5RYxshD8Nf3mEsus
         VTSDpuzuzOUdtUJHHolbXQYlmmIMCpuxpe6hZ/PG+17l/Sw3UCfuPI/n0heQFqJ5Aon7
         NXUXvmfLMssgCR9hc3Mm/CGgtHgKln9FYIVF/67D/OoGBTkGjtH6wTVBtOxvRBAR6g+n
         7RuZqZ6qJwtQEefeo8UdxztCOUrA9pBEI8fC2VwgDjEIyyDDs/mmMz2k1jpU1IrbA4U3
         MuNIcyqILhKYltyWkqqgeDrXWUdXJaQJzPbNyNHSmyUHIlLprPzH6FQ4wSAT35UDVV+v
         RvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627116; x=1775231916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5mLHtMbAapNPXq46N093tL3wnr+hNWmDAcn2GGibIA=;
        b=iDfMSCKnDCPsr9ciZcQ/hxWdcoAxgRXjsaXoFECMzApEXYxkq6GNGTl+Fv2Yda0FRX
         ZV6xIgfZvRxlfYiKiBq1lPiwnJd5ro54M4cp4uzGhSQpWHo5CKsEVJcbhMzAQ7wcupp1
         RGSoP1taVhuhlceXTCXfSg7wQEfX2Ejuh+Wq15FGC70WREPLAOvzr3QNsa+eCdD+mXYL
         q9LhyBT4laCs23J8KQ4jrHo7hkeTNqPTIWlV2JjlQWhKJO46dv1r8IJVbkEQnzSGrWUi
         x4En36dwHjBGPdUTN4au2IqPtbMnXXfUAtV+wu/cbVBYbCXDAtTUCImNC3ytI8iTh0VX
         r6qA==
X-Forwarded-Encrypted: i=1; AJvYcCU95HleybxGOaRgGGST6Y4eVbm0dTDXYGXoI9Jwt9nBfhdwjUM8avl9E/loWDKc3InvlHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2beSSLJZ88oZelSQwsq8EqU+llyeAQx9XbVd/n5OuYX39iiBP
	WYa1Hq6DBOayoMtdY8aFIR+0Ng7koBOt33Mi4ZhAn5OpSmgZd1dlwLXxdXhW06FhyDyXCHZLK7o
	dT3A7EYfECOCZT4oAF7P7F1Mp4KQEfqA=
X-Gm-Gg: ATEYQzzHtcuNTr9eGiBc4C+fcff22X2P+EFiI66LfIn25Oe4L+nQXjxtbzwQe9uitXM
	Tt+s0b2CBsQrgMbpLbIIOt85R7v/x5mlbO0MYN9UKTdPOhPdMHp5KGg1oO/eGf6jygAdtaSQnvi
	ZSI5yFPbe2SpgYu0HGcGrmzLl4IUrfKSbwV7TbS2si56rZ6J1F8LsCjkeyrlfi7ueP1qOmn8YHD
	1ZA4H0lg2q8SV5Ew6ZPGHrHE+tMJ8qzr08hOi3c2G4b0BRRLTUn2H+B+AAjYonGad6Xb+LcS3hF
	Oxw/1hBFH9z16GpBR6F7rlKhY4hiwxquniNdlQA1r4q/diFdWGuHv4/zNDZKiSrlHccTrOv5YVl
	UQCjnpbwE1CXQXg1zOWnx5bJFbzA36u9TB+jk
X-Received: by 2002:a05:600c:a30f:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-48727c81e54mr47470115e9.0.1774627115384; Fri, 27 Mar 2026
 08:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327141616.1961457-1-hayatake396@gmail.com>
 <20260327141616.1961457-2-hayatake396@gmail.com> <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
 <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com>
 <CAADnVQLR6Y94wKo1G_4w0-xTPdR8ws38oGu3xfHOXxNKcqjyWA@mail.gmail.com> <CADFiAcJtjVHYVQeYJ_znVsjiJkEBmLfOafp5srY0HQMGwVtiQQ@mail.gmail.com>
In-Reply-To: <CADFiAcJtjVHYVQeYJ_znVsjiJkEBmLfOafp5srY0HQMGwVtiQQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 08:58:24 -0700
X-Gm-Features: AQROBzAjRXAr6TiuVF_W0O8sqrsQKyaf91amrRDMqiC6S1PW0VHT3nlzwLoMNg4
Message-ID: <CAADnVQ+0EwaJXgS1WSDf12+Ds2Uxbh9KMpDcyq+gyZjcQ_6+dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 8:45=E2=80=AFAM Takeru Hayasaka <hayatake396@gmail.=
com> wrote:
>
> Understood. I was a bit surprised to read that this area ended up taking
> months of follow-up work....
>
> One thing I am still trying to understand is what the preferred
> debuggability/observability direction would be for existing
> tailcall-heavy BPF/XDP deployments.
>
> Tail calls are already used in practice as a program decomposition
> mechanism, especially in XDP pipelines, and that leaves tail-called leaf
> programs harder to observe today.
>
> If fentry on tail-called programs is not something you'd want upstream,
> is there another direction you would recommend for improving
> observability/debuggability of such existing deployments?

You don't need fentry to debug.
perf works just fine on all bpf progs whether tailcall or not.

Also pls don't top post.
