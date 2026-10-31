Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793488064;
	b=CHMsXtyvztK1iHdc25xy2C01Qqcp3BS6sL5PndYXLziIfC+LzSHNM8dBB4IU5/PryiYY
	 Yij7qfC6xK4tGk0vE+SgiBBWZ6cBgHPs2YsGo0fcAAzV41hhNnzuXiQCRrMqtNXJDpZQb
	 5qoVWjaoN32NiOpMFxASpVLoM/0jvX4D0q7tSWzkh7jnH1wJ8oV2ermHCPun9J0cy8tVX
	 KzYx9yjo7MwrUhjkIYzY5SniWjBGRVvMpV4KZe+/Bf/x7ItvE88JKruX3fLjQX75o0nyf
	 Nf3SNpRNSVKyzRNhRrJxwK0W5xhnsVxgcLlxtrn9ho9pOeZ1gzWcNKjPMHPSdIuU/Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793488064;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version;
	bh=vaY+m1c1N072ikdfuWB41IkOQIyKwOi1rHmBZWFfWsU=;
	b=V892M1pfTGOZZu1ujD1qgN4AxDBAZFcFFHWnEHgvhFy9VSrXati6jsdMyHMCma6XTlMM
	 jaxh/FbKUS+aLN7qrpniLanDuYfaFOET8Qe820C+h2+fD9L7sha6bpNAY/Zgx2vIlVrdj
	 ubvnEz2tA+TByYHAdhFb8fOdQlP9uKMB+Svg9YFTHwNfO7v+ZBEonJD9wE6+5JlRtbVwb
	 WcZRHXR9S+VfrbwLTdi7H69puhcZQsVX8Py5FLGm94fkmxoPnZVkbyfFJQG2QGVOsleut
	 Uu1qnV4klkXqMUZHxrrezN2qEibEHpFkYzhvjSMndaUVY/ooXhW2A7BUtu/kAR2FD9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=fH3BTNX9;
	arc=fail smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA3606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 23:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FBA3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=fH3BTNX9
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VMoUQi3275539
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 16:07:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=vaY+m1c1N072ikdfuWB41IkOQIyKwOi1rHmBZ
	WFfWsU=; b=fH3BTNX9/NZvnaQcoqGIxF4PJn6+MzaXOO56sNoTPXwoJwSJU4y2G
	TQP6Pk00IjEgX1/KfA9j41eGkf1fEg4mOdvXTvWszOzvIAWYA4PmhXrx4sFuyAQA
	ak8mO9xGnufmRe1c+56KrvdsIH3bxI7NwsE47s0PVqU1quilivOoqUJhfyDmssgj
	a+k5bUl+OXzpgAi17n+FevlVgyBw1ao+6UDQpXOSiP50Sn2Pu6+ku9eOPfUkvjtR
	uqN0eWuNKLf/g0lz/x0hVsrHqTGOzv/5FLFvFaaSuKgSIS/Q/Nyr3VLLKnrSdjkp
	oe9c+HP0u28g+6n2CjGPKSe3R4GYKxQuQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hn2wd552p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 16:07:41 -0700 (PDT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b0e757e70eso27931737b3.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 16:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793488061; cv=none;
        d=google.com; s=arc-20260327;
        b=keOQLtLJqV1pbEI3w7dUhpf3Mjhb/lCLsoiQbYK7Omekp51vfltx2BuVnod322gAqz
         uM3ADle/z1Cb0Utjnq+eMGAkrl59l1PfewH4wV2rmhyYUah59flLPQPhzVTbZo0JPUJc
         h1tyx4CukotsW+cUqa5nP4iznZk6ty9JTp22klzwJarjHQn1ulhhlY0Ga7son08a/DQH
         exjktbn5WYGTlqsKUBk3pHlUgZ90AKJYL62MblXBexEeozVhcoPoDga1RKFUAWJpnccZ
         ArLPdV3L7BO7P2VcW0l3wHIBFrF3ru6G7ff7jO0PWhjLs12ltMrkskTY77MUbBt2QuPd
         GkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=RJYna8J6uLKycEXkU9pKJ7+eISE4KHaKY1lq5efMy38=;
        fh=TEBidfRvke67vCAy/LUGjR87Odm8+nr8rWlqNk9Kcl4=;
        b=ohaJw5bOPT1C+EWqH18aNS8H7gULVmaOZm6VO8nK18EG6OpAV++R8hJ8z06iX28Ewp
         BIJHU6ahgV+HVrXZRrDYhRC3/J1UV55CAMZyEhxrcycWv5VaiTJ+B+LGsudOChF0tf1r
         eFs5aKK9JLmB7g8S1Iynj0up7WtVdy+bibui/DpilvB0/aT153csmQSCsOuLGQSpa7SK
         9tgL9h+WIAmFWMtVQbCBxM/SQPPKD/xvbsKE4BZuLvJ7UyrS1MacPJppeXgLrVQ+ChvQ
         Ob7FEuS81A9M52Tca8M6aurUBQOQ9SNlyOC2EyAeYIA7OClC/hcfjUZN/wrjdN8CPhs8
         CinA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793488061; x=1794092861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJYna8J6uLKycEXkU9pKJ7+eISE4KHaKY1lq5efMy38=;
        b=j01ApQBojFwSSlzDPpbFTSx50cFF9BKlIOlTxTUhZyilNpMqIQr4BlU4W9X+a2RNg7
         8XDKCwzC7uV9qa35oxHMzqz6dCpjPAQrzmwyqEzGnNYLJHg73MU8Kgqz4mwh52xzYhe3
         uYEmQeulMidrpyTYv/nVvDv7LoZXS+786clQUXN/1F9ioH2K0ed11ACQxvk0zmMdtqxi
         O0Fz5qpv5QwRkgOE5Qul13rF9I2x/vAg3CBvEhu+tbA2HkN1dqxug3KwmdcXoo3gGsoj
         17zq8JMKCAvUCI4c1Gifey0ngAn0yHyZTfIt4eGBjh70k65ts8rwCHsmypX8pp+TdMLY
         eX7g==
X-Gm-Message-State: APuU4Z9rIbCLRxmlT/A8IAE7VJXerXztnXmciiIw9R/nXTXNLT4Hondf
	AIH65peu7LvkQMnLvKiioyxoAktovUZiQJJ4xksMP7gcdbrWflvuQ+Z1NfEr/gRQ7Z1esIECxhy
	pqkbdhRuOG05HaWUJw0N5ZZBP3fYGj92mapfkw/07/PdVB1Gdc9jd0IHWGMIMJCu7leR/TatTP/
	GfdQotm/FnF+cTzto2hvvkPTY7H6g=
X-Gm-Gg: AYBFou0u/OwWfUAL50bx07sh1JHGsAzhbEmmJQiNfFcKgXQsK0CZEKck3rrrfX7sCRi
	4BPHBQlW6Wqvmju/qP6i5CnzgkXGaVZiRbePYgeJa7IrH8V6jrtVnKYvf5sfh6dlukCAbnbcDPA
	h9ZVtDyzmokgaKfJomSxsKlPBgaL9X/UyKSsC+/JyIYt6Co7iW+ZfT7bIOlfVuNy7rS85RjJAWf
	a5Vsy2vABhOLUY=
X-Received: by 2002:a05:690c:ed6:b0:8b0:f04a:3132 with SMTP id 00721157ae682-8b2b66e9536mr32074007b3.27.1793488061443;
        Sat, 31 Oct 2026 16:07:41 -0700 (PDT)
X-Received: by 2002:a05:690c:ed6:b0:8b0:f04a:3132 with SMTP id
 00721157ae682-8b2b66e9536mr32073937b3.27.1793488061000; Sat, 31 Oct 2026
 16:07:41 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJgm7qNx6NBzfxQbwF0ZoMLoULquNpsnrYSL1F3EFf2tztES7Q@mail.gmail.com>
 <2026103022-epilogue-coeditor-0029@gregkh> <CAJgm7qMWGF3zWOR=5qO8RWmufGud6fcNBQQxTsVgx=CgvRz3Qg@mail.gmail.com>
 <CAADnVQ+spWODbcC25SwVFXUv+ksPNuVkQgxtq4PwLHdDDsSZCA@mail.gmail.com>
In-Reply-To: <CAADnVQ+spWODbcC25SwVFXUv+ksPNuVkQgxtq4PwLHdDDsSZCA@mail.gmail.com>
From: James Burton <jamesburton@meta.com>
Date: Sat, 31 Oct 2026 16:07:30 -0700
X-Gm-Features: AclHuK9grKPnoiJ4uyVgN0MVwxZzKM7r6CXepVIgpmq_SssI3RWgjDCUmdqzmQA
Message-ID: <CAJgm7qMEz-O1+L2MJz+qqH6-pz_ELaQNG0QQkgMbHOoDi69R4Q@mail.gmail.com>
Subject: Re: gotox/INSN_ARRAY cross-subprog fixes: request vuln-fix
 designation and stable tags
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Eduard <eddyz87@gmail.com>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FtqQbGrq c=1 sm=1 tr=0 ts=6ae674be cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=XT4EqcJPt7X7IBSTUCgA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA5MiBTYWx0ZWRfX+v3JEJmM9WP7
 5nksyTpKUG/swaCERNwQ/FU++FZNla0YmHGJeNIiqoYaVAK+4HSBbBKliunP6PLnicPKfPoRafX
 3/Pm1vS7k+fYBSdXHpQ+QtEdwieppYw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA5MiBTYWx0ZWRfX5k5nFXnXvoIc
 XIwu4xiT94q8Q50r1OeI2k+p/MONdpnLMKYmK66kCqdlnaAYnJvt2MeGxZ908ZsJW4vOXTRtOU4
 jacMe7NpsO/tDYePBDU/mtNGwje2zJi0hYI2z4GzCroej3EH5MQeGwLCFvhc3iZMsYsbjUK6iG1
 SsX/TqlizonzP7ij/s5lvO7n5O+R0+qk+cibNAYzLXawOsOVW06gVb5+LP7yfiqLF1mBpaPMwD0
 uhOaD5VkQXJ0wlDKZTrzpPZgf34d8ZgIz4tuazxoPYXNX08UzRkNt/ohS3gEHuEBqdqInOZPRbh
 Do4iWXMMEvAn9Stbj/cA/9DWh26mQiGY0kwNLtyTWYCPw9+4VUVOkYAo54xU7Gif+38h3YRER43
 1Zc++Jd7XmmCszPBvz364sXlfSJKxWKTiYZ5ju/OawF1tuP4T3eln/RItT2ZeEDQFydcLSoMuG7
 p4Mlit4Bj7/OhJDQrog==
X-Proofpoint-GUID: 3ai-9Jw0bluFXObOf0QiUSfPbsjK00K-
X-Proofpoint-ORIG-GUID: 3ai-9Jw0bluFXObOf0QiUSfPbsjK00K-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_06,2026-10-21_02,2025-10-01_01

Daniel, Alexei,

Fair enough on searching lore first. I did, and that's actually what
prompted the question.

The same gotox/insn_array feature already has three fixes that only
needed CAP_BPF and still got CVEs and stable backports:

- CVE-2026-43321, mark live registers for indirect jumps, in 6.19.6 and 7.0
- CVE-2026-93043, interpreter fallback BUG_ON for gotox, in 7.2.6 and 7.3
- CVE-2026-45967, wrong address for insn array offsets, in 6.19.4 and 7.0

The two I reported, 19581372dd81 and c48a91c049fd, look like the same
kind of bug on that feature and sit behind the same CAP_BPF gate, but
they're mainline only, so 6.19 through 7.3 still carry them. The first
one has a deterministic reproducer that goes from CAP_BPF to root.

I'm not after special treatment, just the same handling the three
above got, which would be Cc: stable on both. If it's easier, I'm
happy to send the request to stable@ with the commit IDs myself.

Thanks again for turning these around so quickly.

James

On Fri, Oct 30, 2026 at 10:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> On Fri, Oct 30, 2026 at 6:11=E2=80=AFPM James Burton <jamesburton@meta.co=
m> wrote:
> >
> > Their view is that CAP_BPF holders are outside the threat model unless
> > a boundary is
> > documented.
>
> James,
> I'm sure your tokens can be used for a better good.
> Please search lore before your next "I need CVE for this AI slop" patch.
