Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795706203;
	b=SS8UpJ1l9UHNV4HgbFQDQccbwTNgSut+umB833xA+cnH72KCyuuHtpny+rTti2b+l8pL
	 CTY6AbW1MEOB4kH3PD3M2/4Rr1HJN/IYIFSOPHlSB7S8LkHs7WOkXIfPYzRBJ2kv1SOC/
	 VTZ7zuvz20cAKb0zWENfH1adZlA6I2XeMhBjlUXurfikkcf3OpH6NRMpV8FRpZVefNbZr
	 L2j0jF3I0F1/hSmC51cqL8Md3iSXjqYBFVvLLhVUi+BZ81UykpCNJiRgRPhfYQmBZYpOd
	 cqOXI2g+75ucMjqtxiYyoLAH95tq6eOcw49I00khEDk3wodXb0kgQBGfFFv6I4zyYuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706203;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+MbepoD9sJgCfmxmOe9PqintQmVlD0+63+PIkWpg3RE=;
	b=pX71eQF22Moj9JAEdCCnWvzGJNJfsNDcY2VFyw7S1HKs2WwbCaUFRK7dm4Id/TYT5wdI
	 FpKKXaopOYX6I5qRfCYOp55XixEKmVKDkbLmM5fMkg6hGjzOU3xbvcY2th9n2L/YSb4P0
	 nIP2xHyRuwgJWHlOe7ZXStLD1aUcTSHsAo4AhvEk+Kvtpqoh6X6AQ93lY0QwOtI6VfH9n
	 biyHuomAwGauaoupasw14NdAPILH9r0FaxfY/Pro3EYPWjFScfMuEiTHxpVGXCN6zF1Mz
	 bKvCoXMiIlHOLUuMBelWDjcxmTLV5JeMrbEwyBJ3CYr0JS1URUE8qPf4y/66zU3d7rA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=r4qW0e5J;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b="cDgn/4q0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB5606A339
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77DB5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=r4qW0e5J;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=cDgn/4q0
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQCjUpk3249102
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=+MbepoD9sJgCfmxmOe9PqintQmVlD0+63+PIkWpg3RE=; b=r4qW
	0e5JHa6D01kMhTIQib0P8uM39lECape/9S8o2RSFWy2A+NEyoyRjMUS4IkpSK+GL
	jkPT1617eH/XFmakjKA33peN5gPtu2naPqT001OEXHPZQYOLxFFtCkNW2rHO2gJK
	fUIGWtlj20xYHPJM2reEFHbIFwai2z608zJL6LcT36rmZPZHoKtimW+PEjNXRQAT
	ZnKeKKQdik64qcjbpj96yN1PydnsG/qLWZdgB2TJ33JlBu2cswZz92no//irsl7p
	kwcy2z/NoC5ufCAU34Dg/K/ejnE/DVrfVRfXGaJgbcBCkKdj7+vNymKo0UYukkCx
	wWFd2v9QpZdLLoKzBQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4j6hytrv6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:16:36 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b501e92b97so66670167b3.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 07:16:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795706195; cv=none;
        d=google.com; s=arc-20260327;
        b=LTWZKBDp2KUfiSEG87cA3wm38ENTCUcTaUZtETQyxzRlGXHyGJWhtjDevshVz9PbH6
         jgik1HJBxFlR/Jj7N9FHuLC6W/pm19KTgJpkSGwYpD1hxldqxiPaDONmhNVbQomapzD5
         7U/kG8hoaLTNwYfN6lE4rfcVDkHIqDz4Kfdl3I9WKas7t7NbZz3JVWXBP8XQVyEDTlrJ
         SMBL+076uuibdGMwP7SlBIeq6z0EYdzO/B/CTxFgPc/x4kig1wyxgqkMG65xGrvIVAq8
         63/0zH22MRsIMEjiR4AiGAAUFOTAHuNNLpofVAEosEptavvVr5pdl3y1nJf+PxSR9oHc
         cHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+MbepoD9sJgCfmxmOe9PqintQmVlD0+63+PIkWpg3RE=;
        fh=fwl7BQ7a58Ho/1W28CQvyEp7G9KiSa8f9Z0RarsxDcE=;
        b=G7kKImCxusC2W6RdEl13y9a5tw5oILSgngKO7KXKJg5UCCrptkBRNEylJMH4Vy1tMR
         Zr8o4omLl0T7XUFRsqFh7v9rcEMWoLxYTj6Qe6w7RTfyknRQ1+OfGRj5WRiZ4yqzu0N1
         H6Vo4vsBM+MyTeQua888OxJdtFXw2xpEIuQmM1gjwIH/xSt85Hj+q2+JEHkHdbzJYZJU
         qrq+EhFofPQmNd4sUKSdqK0NwfH/W+otHMYVlrCNFt03/3BkXtKcw7JaaRvfYO2WbBqU
         gyexBotTYCFPx8PLxaUTPpqj9g8U61cfMttthZLn/4Hr8X1KUGPKcfgZ1quvl6dehfSx
         iawA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1795706195; x=1796310995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+MbepoD9sJgCfmxmOe9PqintQmVlD0+63+PIkWpg3RE=;
        b=cDgn/4q0xHZotPM7gSOd0v/BeIeTbFk6NiQmjvdtxxpRjSYxsUIPgXXsE/tU59G2Uh
         eIZ5D4tpQ1pHKfE/eaO0Ks34Mz50IqUpdHFqTiSprRpYd2Q+B7/KAC+WLO/7GQfiJBou
         dBklQf5OiaNA45LBO3uYl3Tk5+QvdD8LyxREdOVtjc6tGDkvo5+VVUNwt3STO/5uNrvc
         5zbvt7WxFpJya6rNSCvdIrUrk/t2Ne2SocKQUwJLmNZBeyC9FuXAzaRnUU++ipEwZ2tN
         +/C/YJisf5ODRGpQaXajt4TlEKptPdg3dXqCLlK3NrROQwu6h7Pnre/Z3GZW02FFRi0x
         v38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706195; x=1796310995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MbepoD9sJgCfmxmOe9PqintQmVlD0+63+PIkWpg3RE=;
        b=nx6SUn3cYTdy8Q1NeJbyB6CnFlhmxPJA+TIrflB1S8VlgdVDJcF+5tzw0pasdSYKqu
         TyP10mnbGGS4uTXuyrLoqht3lVorcwuZCwqrsqx5syVaoAKzYypaCsGjYQk/e5lrBvNh
         emisTZIQkTmJ0fzZdBEIO/7sHZKqn6idevEKKW+wFkjyhLN9qJkbxKJq7hWecdx7+cf6
         CIw/nQgxWMmI6wTR6YTzaNfLxhrV9ga8UlrASK6wFuocTiZ8c0NI+5ZVGbtHVX8vgZIi
         4iHYBfBuQgN/MIBd9pSRCvjpEU5wwaLlR3BBmXhS3IR7kvKa3FmSPE16AqskW1oO0LfL
         mXfA==
X-Gm-Message-State: APuU4Z8JU4kJAe2VntsHvljq7RiblS1ZTwkMrUBFzN7aECjjZ/AgiK82
	rQBdd2fvuc+usVSLYpPWXc10nQA86i8ne4wq4y5MjjkCC6ovXiX/m9fnwLA4kG1jmzoFnAe95lO
	hBkDdEifWYkuNAi4NKNKKbs8j2PX3tXc0AYFA9khXpIEfHRnBxcwP5+O88EWHdRtWHM/G7N3/Qg
	Wk14Igc5Ljj8+9qWaSOKkJj+e09cBK
X-Gm-Gg: AZFdTZcBDWWexdvFNDX0UfQyWSgWPtjxDa+48z59h8h765EumdYvbwHMOVwROQc4i0j
	SClOIRhGkgTD1gx+iO2vd7g9kJMv8uY/rchYhBDpxmpW2dFIAFG+QVG3Z054nm6zLLuZewpPb6p
	Asw7vdGZnphvM3WyqXvmMSHsIMINfp2MDryjEsKAPJCqXj8J8qcn7t+jaG2Q==
X-Received: by 2002:a05:690c:650b:b0:8b3:2d65:2c83 with SMTP id 00721157ae682-8b520435671mr77352937b3.17.1795706195355;
        Thu, 26 Nov 2026 07:16:35 -0800 (PST)
X-Received: by 2002:a05:690c:650b:b0:8b3:2d65:2c83 with SMTP id
 00721157ae682-8b520435671mr77352857b3.17.1795706194886; Thu, 26 Nov 2026
 07:16:34 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOu3gNgXcryEHSjSxW7u5Nx-RBj9Bfn+h_YZv5fGvD+0arGvBQ@mail.gmail.com>
 <CAEf4BzarLoswH7ZTVsxnTq4D_NE_RZu3khDEzzyjs_2bbGFboA@mail.gmail.com>
In-Reply-To: <CAEf4BzarLoswH7ZTVsxnTq4D_NE_RZu3khDEzzyjs_2bbGFboA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 26 Nov 2026 10:16:24 -0500
X-Gm-Features: Aa3M54qr72TNX6g20y_W-SW7OUVE7Rn2CjNZ5UvWWVYxLdmFWiWAWRungcc9VCA
Message-ID: <CAOu3gNj9EsHVA6xCn=9wxKsEP_0V9wKqF5JkOVtdPKJaRdYb9Q@mail.gmail.com>
Subject: Re: Reviving manual (lazy) BPF map creation discussion
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Slava Imameev <slava.imameev@crowdstrike.com>,
        Martin Kelly <martin.kelly@crowdstrike.com>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1OSBTYWx0ZWRfX8bQFGaQRtObe
 zmT69rQcx3iKjlp8JI8rl+Z5me2daBLB9XerBmzfyFjaBfYNozLvQueM2noxcbSmjwhnw2bnZma
 qRsLSIIwz3tN7bAacgjP8PTT7Ge6P9/uUAbAGimnuHrYtaPQ1Gm+
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1OSBTYWx0ZWRfX2pMO5VcmGG+B
 ntxTI8155LYVVhMEYgUXcHuVZ2LsbAZhEppkbfZuyjM+J9me1lsnu3V2K2CX+RblvbGUEf/aicO
 8MefWBPPFhLaVU1V3RiC+rEQLGuqiw4TIzRYSGGQVSIazGLqZ23tLKtCMLuWfdrztoUZ/zoU64Q
 fvnTAhLhYzdP1V/LmZrloWPX+BDQSO8trMSgBvdq6+S/C8zczrQwhZ12ROqwg5zB8H78Nb1bLMk
 /dPe8RsNUBMU0PvNDur2a0ZIRTmxYXHJtYcIfWD+unyvJrtBtu+ko4sRGatpIYOp+sWqiR+OKBL
 jbzNbO4/FCNPm1X7cUkXRKKTBC/6owzT3UL7VnqxR1LDOExQQYerlQRHSLt6ZMxTYLwesrPSnyx
 opfZVWJL3woFQhvdnuLTNohQ1vGw/0rq4Ym0fZHZIug6t3Iif5iULkNO1zkqN20mVEnXqVNBjE7
 7aG8jhWyFmBdbrr22qQ==
X-Proofpoint-GUID: 23COvpyFLJ3Zccnbwb_WfOTiAHHd-PQx
X-Proofpoint-ORIG-GUID: 23COvpyFLJ3Zccnbwb_WfOTiAHHd-PQx
X-Authority-Analysis: v=2.4 cv=ed+o7LEH c=1 sm=1 tr=0 ts=6b084d54 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8
 a=z8ECJ6rAxgbvtUrKGTYA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11978
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260059

On Tue, Nov 24, 2026 at 5:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 24, 2026 at 7:38=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > Hello.
> >
> > Now that manual loading of BPF programs has been merged [2], we would
> > like to revive the discussion about doing the same for BPF maps, and to
> > ask whether this could also be a topic for LSF/MM/BPF 2027
> > [3].
> >
> > Where we left off
> > -----------------
> >
> > In January 2025 we posted an RFC [1] that let libbpf load and attach
> > selected programs after the bpf_object is loaded. The discussion also
> > touched on applying the same approach to BPF maps, and a number of
> > objections were raised on both the program and the map side.
> >
> > The program side was reworked over the following year to address those
> > objections, into a per-program load strategy (DISABLED/AUTO/MANUAL), a
> > SEC("!...") declarative form, and a veristat conversion, and was merged
> > [2]. The map side is what we would like to discuss further.
> >
> > The problem
> > -----------
> >
> > Today bpf_object__prepare() creates every map of the object. A
> > MANUAL/DISABLED program that is not yet or never loaded on a given syst=
em
> > therefore still has its maps allocated in the kernel. For a large
> > modular object this is a lot of wasted kernel memory, and in a
> > memory-constrained environment it can even needlessly prevent the
> > object from loading.
> >
> > Real-world use
> > --------------
> >
> > We have been working on this internally since the 2025 discussion, and
> > have been running it in production in our internal libbpf fork. Our
> > endpoint protection agent ships one large BPF object whose programs
> > depend on optional features, so the set of programs to load is decided
> > at run time. Manual program loading already reduced the number of
> > loaded programs and hence the total load time.
> >
> > Creating maps lazily, only when a program that uses them is loaded, is
> > what allowed us to run the agent on customer systems with very tight
> > memory limits, such as containers, where kernel memory spent on unused
> > maps was a real cost. For one customer configuration, we see a 12%
> > reduction in kernel memory used by our agent on that system. We think
> > the same use case would apply to other memory-constrained environments,
> > such as embedded systems.
> >
> > What we are working on now
> > --------------------------
> >
> > We are reworking the fork implementation to address some of the points
> > raised during that original discussion:
> >
> >   - libbpf never unloads or re-creates a map. Once created, a map lives
> >     until bpf_object__close(), and the kernel's refcounting does the
> >     rest.
> >
> >   - It follows the staged preparation suggested in that discussion:
> >     parse the ELF and relocate, then create maps, then load programs.
> >     For a MANUAL map, map creation becomes a deferred step coupled to
> >     the manual program loading that references it. After the ELF is
> >     parsed and relocated, nothing is created in the kernel for it, and
> >     the map is created only when a program that uses it is loaded. For
> >     AUTO and DISABLED maps the behavior stays unchanged from the
> >     current one.
> >
> >   - The choice is per map, a three-state setting (DISABLED, AUTO,
> >     MANUAL) mirroring the per-program load strategy, with the default
> >     unchanged: maps are created at load, as today.
> >
> > We would like to post the libbpf series for more detailed discussion an=
d
> > to get feedback on the actual code.
>
> makes sense, but please do analyze thoroughly all the different edge
> cases that could be broken because of this

Will do. It will take a bit of time to get everything ready, as we are
still working on some cleanups and still need to rebase our code off
the latest libbpf. I hope to have it ready before the end-of-year
holidays, though it may end up being  after.

Thanks,
Andrey

>
> >
> > LSF/MM/BPF
> > ----------
> >
> > We would also like to know whether this could be a good topic for the
> > BPF track at LSF/MM/BPF 2027. Invitation requests are due January 27,
> > 2027 [3]. If it is a good candidate, we will send the formal
> > [LSF/MM/BPF TOPIC] proposal to lsf-pc, with the topics we would like to
> > discuss being:
> >
> >   - A recap of manual program loading and its application in real use
> >     cases.
> >   - Our work on lazy map creation, and receiving feedback on it.
> >   - Whether memory savings of this kind matter to other libbpf users.
> >
> > Thanks!
> >
> > [1] https://urldefense.com/v3/__https://lore.kernel.org/bpf/20250122215=
206.59859-1-slava.imameev@crowdstrike.com/__;!!BmdzS3_lV9HdKG8!zP5NWoN9AgEv=
AYgVuLUsTJQu4I11hibUgfiDWuVQTc_324BNDdXOotwb9Mk8prwESCO253amn-iJ36MkWOZIDWI=
J5xWA55LpXyqgTg$
> > [2] https://urldefense.com/v3/__https://lore.kernel.org/bpf/20261029223=
348.3730738-1-andrey.grodzovsky@crowdstrike.com/__;!!BmdzS3_lV9HdKG8!zP5NWo=
N9AgEvAYgVuLUsTJQu4I11hibUgfiDWuVQTc_324BNDdXOotwb9Mk8prwESCO253amn-iJ36MkW=
OZIDWIJ5xWA55K_pFA4DA$
> > [3] https://urldefense.com/v3/__https://lore.kernel.org/bpf/20261119-ls=
fmm-2027-cfp-b7edcf7eee48@brauner/__;!!BmdzS3_lV9HdKG8!zP5NWoN9AgEvAYgVuLUs=
TJQu4I11hibUgfiDWuVQTc_324BNDdXOotwb9Mk8prwESCO253amn-iJ36MkWOZIDWIJ5xWA55J=
ZR1tC7g$
