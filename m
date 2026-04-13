Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4F3E3D8A
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110412; cv=pass; b=iImt/nXJvLusgqpmI/nMVO0+hymxLtWjRHoLavgqtVeNtcikDc3d15mmRDAtlbFwQLFCzFCijpNPuAMZ1w6RcVQ48kxMRZLfN7/pniPBRlh6wtfQ8DT8ZKIThQdhRRgxtnl44RbeJVm6Jps2PpfsepnIrdUH4Pt/6o25IIvrA1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110412; c=relaxed/simple;
	bh=Ng62zX4lIHS48snDGMa4tHVjsgtODRYiq1km93uOWF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUJKMorC2ZJ+lDYWJjOGabM0c9jBty64hQV2uEtXKGG+a6RaF+zIrOjSOwYmauAWXNTMcaxCm8xwOpf7+cqqkkgzJezgZad7y6QZghNHhJZFa58+JM6qqWpG8OREvRZYcCOuUPvs4xMy49GEpXx8ZLRiysUgTV4/9PkSJ7pLokc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzg0YJmP; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzg0YJmP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso51920305e9.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 13:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776110409; cv=none;
        d=google.com; s=arc-20240605;
        b=BYCwK1jW85o+x4KqZMwUH08Z4CGWQ8U2Gp06cj1suPApyvhm3OdYJtMuUxt5TCeSJP
         qKAH4lOoh9yDy1EnaNTyrs4NCg5fs4mhnTVAoPTxv1Eayjw1GHR5oBp7C8K82M7Ck0Ue
         +ZlcdMHEbXoRPMKvgHM/NjcY0kI1DhVIbeTSv88yEN85/op6u1xbhuW1nljLUV7p1MsX
         EQHx75SmRO7Xh99130E/YXdhZnDs8V0GQqFlxcsrF5+Oy/dVzLV7IZc2A5PV4vhvd9bp
         vppeNvTVe95rrQbl405difrYZ/oDNJW8WdFZNiY9pRGT+MHtl//GoYkltyn82Ev/7vFz
         JjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8mJqYJhykxzKOyCBtJIeZcnXu0t6Y92iwpQe1iliRZs=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=iahRJEmXFsMB7wD6ZA5CKv2mTixtnn8TuYQA6Zk81HAqwn1BUEOOJ474GNmGvQRzWF
         rbYFIcnk8KUr4RJbLUwu0aI6CaTtNy0Ky97aptgMtGyTco66fIZHfFqg92ZVVq54Xvvq
         BrIxbc1hyE+0ev3OCth26lYxTSUoT0VJDhq5rceoKfOMPpQrxM5fPKPW/c1SU0RVahM/
         NJ/LXzO2qBvdCqziFyfasyVTyA7lCz4EMa/LkEiI4urcb1+jr8kkFv+bY08hBsj7ZdKS
         Uk0T5lvHZz2GXFuXAbmgPYoEwm7d3nizQsIObmNWgTwcd/SO39U6XMCd8MbcEW33u32/
         JGgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110409; x=1776715209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mJqYJhykxzKOyCBtJIeZcnXu0t6Y92iwpQe1iliRZs=;
        b=Wzg0YJmPXWgS2J4sjC4cxuA2icEsvpmjBcAHxKMQ6hofXG0pSzgOAci8ePLiHrnmkS
         3+2+spxuupEOiZxB/prZoRGAJqm63D/Pn5LCWxRD/Gv7w43MtZM/RSiFVTTV4cnVS+X1
         gsX29Gu1GRTmcIodWt7tYIhkDjoHSzdWz9bzfEnYcrd61CR3CvBRUJfVW2iuKxbYXzTE
         pF5BDGSyqLg3dFVU2EKgnxPj1/AR0+7SLDdDXjKLjx14woLHHfMMbSJl0MH00l6ofdF8
         usU1r6w90h+SGWpwrz8wR23NoeKC+hoMLhNrnurdPS9eh/ic3yy60XHAYX4OcCXALVad
         q8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110409; x=1776715209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8mJqYJhykxzKOyCBtJIeZcnXu0t6Y92iwpQe1iliRZs=;
        b=ikYYmyFhsDNxGgCw1EoWsCa0jg0g3G0WZtQSWtTzNIrE8lWXxe1cmysY88YF2weceb
         f7ruc1FPTz+AyC5iYF6E3Y8xPQtVgY/QUDOaOWI+2FGbKcrcIMN9vMzgddYThy4d+Jvw
         wPE1WX/SpSsq9cb8YnfrPdt/b1zIx2fz24m2dxMYyktDR7+XRSPpPraqYG77q7J9NIvC
         XS9TEgppD7xmH0V16Dl8iHwMPAu3G9EGGnCa7BS+Kgn6Zb69vpBkJyCV03OAaP5tkKYK
         LFEbs0Me2p/mUOOIN2P/x8kSDHtt5ARbO/zNSHfuWIM+7TYPMJ3VQs+5ikMK2kKf/OwG
         lg9A==
X-Gm-Message-State: AOJu0Yxphs6bF+dNqaaUMfC6SeutR7do83xU7Etl/JS1lNfw3XLoGLs3
	W0FEJ6DuptzKOaqQbmyzdwhwKF0r1Lk1gG1vx3c+tIykcPEDZrVGewX9xBFIprCUxwPpqDmMhIT
	WHN1HHHCb9ZhAFcUcRwpwKDD7TZ5sADU=
X-Gm-Gg: AeBDiesbuB3sTIsHPS1CFU3iZlRfWqf7nktO5StmVOc7tmUVJ249GGpHdKp1s9aybhd
	ZxPEi02vIQSafnVKZO/arbyW6GmqDCnbmcY/gGle0bdisON8IrlvJA4/BuJ/MryFl3CqRfdKxgz
	yQPYv+nwiBXU14qkSTaNnNVkm16K1qbVKvmh5VrzUkfxCKzVSvW4GGOpeHA6BrheQYpshv54D1g
	DkZmMTRH7hzqa+QDh+UvcWtO4YyhjATR3csjKJjwMVNneOyv9qFgzD0FOC3yT41sqsFa0stkU5p
	arVrJnWcAKQghjDuDTM/39nnif/4PjebCECpHE+JoExwgr9ODw9Jmt8C4w2heCuhlQypE6Q1APD
	2hTOWfFtg/GkFEBhvdgbykyrAgg==
X-Received: by 2002:a05:600c:528c:b0:485:3a86:6392 with SMTP id
 5b1f17b1804b1-488d68c2bc6mr185300115e9.20.1776110408874; Mon, 13 Apr 2026
 13:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412050033.267815-1-yonghong.song@linux.dev> <CAADnVQL462NnYNquWqJL8=CFZr6vJOxVzCPCpijV2MLAx0y67A@mail.gmail.com>
 <281485db-073e-45b6-8929-dad36fea5f87@linux.dev>
In-Reply-To: <281485db-073e-45b6-8929-dad36fea5f87@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Apr 2026 12:59:57 -0700
X-Gm-Features: AQROBzA9Oi8fyNwC7gP_5f4xCrDgdegcuFpQE4eJ1k1i2-oAE5Y8xcJyWSV9DbU
Message-ID: <CAADnVQ+Xem-VErMn9f2MC52ugofFkA+XcUz4OqgvxJ9wTVz0JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for
 stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:26=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> Yes, we can do something like below:
>
>                  case BPF_ST | BPF_MEM | BPF_DW:
> -                       if (adjust_stack_arg_off && insn->off =3D=3D -out=
going_stack_arg_depth) {
> +                       if (dst_reg =3D=3D BPF_REG_STACK_ARG_BASE && insn=
->off =3D=3D -outgoing_stack_arg_depth) {

Something like that, but use BPF_REG_ARG_PTR name ?
here and in the verifier?
