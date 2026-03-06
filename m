Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC333C51D
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772836421; cv=pass; b=N6E2ciUXZhQ3azpzfLvTmVWfsROK7W+MqK+stwCCXAApyTW2pM/C5OlUKOqPqnN50rQ068A/OCBdkUx+uBPoCYlfmEJQNZ7PlV2MKqvbvGoWLQSJbydd/2UCwyH3zSKFhhk4pCj32pR8zISkgvRvKe0W6c9GVe2rOfqVieapuRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772836421; c=relaxed/simple;
	bh=FCBkVguJcOqQAx6Su70c76LeXigZKzJdfrjlFGLihtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juADypBDomvOBtlU2uia4x4gi2D8TgB1/fmDyMcSmVhxzfGf4bHGUY+uhdMzGhtZ1qmBcume8HGuzte792jIw7J9TSU05WLgFDKWEEYZzb30eIdELUh+teJ+VuZe64k3IdxZNBTpOwDExnqArQlDtHbZAT+VpA8JQGBcszWoBMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i93ivEYE; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i93ivEYE"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439ce3605ecso1777916f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 14:33:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772836419; cv=none;
        d=google.com; s=arc-20240605;
        b=Zis6agyhgQZhy6olZYcGyqRqT5gWVyrLsihus9DvG7YN5Mlt5zLJZpQTHYZw5eZnY0
         CXI9eVV4jNORxrN3utPXg4UDv54I0M2n507IKODP2e6gCF0cxXJn9LUAseD/WFgNuKYK
         VB8MXlOKUXE+2zn6+k64U13K726NUQZIpZikRSwbxv9woCaJwISgtj34bNPHtXeOKm57
         XLVeVRNknYg5031ladJi5s0viWiUN7vN4PsGQtl0gNRPHVzdy2eer1fDdDXho0shbxuM
         ykhE3NEffsXas4dYLijhN35ZlFihxSOyTXFVPTKFrmPwD/OvyHoXMPd3G4Ef0UkiXVsZ
         UWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUW3uQ0GOOk5NLEcFEyI1LZbgO/qREK4Yx9n2fFhxPY=;
        fh=G8IZO6zJJTI87XIyZBn1+bnKMV88tsPfXQr3OEr6l3c=;
        b=FheS1m3z+NO176h4k+vJF6X87Obxua5e9+3Q3H6kQaJ8pv9yp9yADtRMxYEIfFZGVI
         dfD2hCKQZfvUB0mfHMf74y6w09Jnl4hEeYIFYAccwqMZzSxFeiz0r1TlxDNMASagLvyH
         8erb/Nk5BFRDVLOkhBzerpbYGP6rkoSBglge0b3aUS/6+Oy8N2RiQmVRcT/2hfsSCG3c
         vA0O3zIghw+Y00xNJPnOF+gshCEj4H9diJ3mqX+6/af35tHQUJnERbVSz+X3wyF5uF74
         qLzHJg4ydQd7+Dr2LfB5U14mPeQ7bHatQaVarYzLYqIQ8gvZNkS77UzQ0pMW6CadZRzz
         LXVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772836419; x=1773441219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUW3uQ0GOOk5NLEcFEyI1LZbgO/qREK4Yx9n2fFhxPY=;
        b=i93ivEYEws5CpHTFzxp9ujxdDvhGN2qdY32JFJ0qMofSv+0HmS/HZsIBgaJVZY+hmQ
         utrj+aahPzLdm6E/qMGRwuo3qArlqOpWIMHv0YZHI3GXqqZp2IxPZvxu41DXR4b8yVgV
         H4okgYoX+csV5DNKkZTRr4Xk3eBbE2bfQmtNtVLEV4NVeOSqVr/J3T/hRhvBm/huGhPQ
         o1fXDriFu3B9sKLZr4La+cAqGcDwhEEIIfcqg1UIL5GrgVNbcbD1xLtmO80UIAoj3GG4
         fz/MEXe3YhGR8G0i31KYYrO504Fc0LmG8OG4Ovp8Th1CMTWuWQZ4Ox8N5uMyqQ60jEcA
         f27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772836419; x=1773441219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUW3uQ0GOOk5NLEcFEyI1LZbgO/qREK4Yx9n2fFhxPY=;
        b=HSgmdmTPlZ75gUP4HzI/+cqOgTotRgoBWCY2V+f6mGOmcfm1HPbMMoIY2S5wTcBurk
         GlTmITy7we1nq6i+5zfZNUh4aFUHTNxJ9DBQmy9wvLnSqBithcfOmDOPznNBkQYmL6Yl
         1DUsXSXg8cX88TXzVXNrgr4r9+IMRk539azCY7fivMU/xDM98Nuk7UMtEVeOr1FYwZ1X
         +7jDz4C0+qhzGb1URt6YlYyaik+5j4lvSU0JRYGZG7ScVbUZ5njh6BI832Wqdi0oreD6
         qzD4aduuxDaSFUteZqFWTp79vI91VBW9K6j7Qau36cLZSp/ceOKPKyEaeVFDa6RujY9k
         P6+A==
X-Gm-Message-State: AOJu0Ywhm0gIy9RxxRhvAXMIQcwTTmNaskHKGh2eNoE3pU8fgUgjH/m3
	oawfiyTXlEHDvPwos/HXPrrEA0N2dBYpHH4t7ZExbBbneO2CjMoKcxugxDkXK/ocrfdwS5jt+ue
	CelcDUXJ70vzHWNEucR7RNjV/D8Cy5iM=
X-Gm-Gg: ATEYQzwIf2AaV8VnYkO32dL0S8M+fU1WgyI2bg0Qo8ySxKNo/SRW9ZXw9BBC6p8knwN
	Q+RoZDq5CtwGiZUH6SYMY3iuFvFer6im86N8ifeXfL87x9qmkT0qdTkvhibIpIhOi1FN/c3Y697
	P8UpIDgmlfY4nQ+/EEVPDuTx0Eo871mMPn7mefllaD7nsYMK4gP+nhznDe+BQAdx+rdYG9XrNoA
	TtouShVGAi0wwLtY84rxQ0zFPri7l4k/up3hb1EfeAQ7lYAo6NB42G7z4SjyavW9qJHlRpPEUTR
	MfwqNln585dyjDM8rHf0xQRQNGQem29lnM4CpFse5+eHSm9gEHq5alCkZ21NfZzOSN0tOYuJ9hV
	JvsGPEhI3dk/wsXFpOMEvGzkk+g==
X-Received: by 2002:a05:6000:2003:b0:439:ad2d:99f8 with SMTP id
 ffacd0b85a97d-439da885bebmr6744576f8f.30.1772836418704; Fri, 06 Mar 2026
 14:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306221330.630971-1-yeoreum.yun@arm.com> <20260306221330.630971-3-yeoreum.yun@arm.com>
In-Reply-To: <20260306221330.630971-3-yeoreum.yun@arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Mar 2026 14:33:27 -0800
X-Gm-Features: AaiRm523IJSrvR6Oh5s_-TbReIdaszdnRGNng5EUigJX51I46zC9wDY2sRJtdOs
Message-ID: <CAADnVQJW2vK9YEsdnDMbij9Ed-wfra3Wbg4mp95C=xiDw6Bteg@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: introduce bpf_jit_insn_aux_data
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, richardcochran@gmail.com, 
	Anton Protopopov <a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 2:13=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> wr=
ote:
>
> This patch prepares for fixing the BTI exception related to gotox.
>
> bpf_jit_insn_aux_data contains per-instruction auxiliary data for the JIT=
,
> extracted from env->insn_aux_data.
>
> For example, it is used to determine whether an instruction is
> a destination of a gotox, allowing the JIT to emit
> the appropriate BTI instruction at that location in arm64.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  include/linux/bpf.h    |  6 +++++
>  include/linux/filter.h |  4 +++
>  kernel/bpf/core.c      | 59 +++++++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/verifier.c  | 30 ++++++++++++++++++++-
>  4 files changed, 97 insertions(+), 2 deletions(-)

before posting patches please scan the mailing list to see whether
a particular issue was discussed.

pw-bot: cr
