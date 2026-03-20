Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8C3A3835
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774050185; cv=pass; b=f5cr9mgLj3Ukc2MXK7cndWPEFHPGKUFii5L9+ncx+s2bBYxE6TAtg23nSOkkra+W2tp+RdLSJUdGS5twUT+SZSbdZXZESRPa+TnRKDCvYmXcT8HOMEgbOseuqzEb29ULYDhjNojbHxSQM5NwaGWJY/UKY6lJuFyNhOwg8JT2u+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774050185; c=relaxed/simple;
	bh=S3ofHJBlAaVE83JxdQ+UdUO9dYFhKx2LE699YjvxXaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOv3rWFiGw4jsewvLaiIwSQnAgnFWnOBKuz51EzeUOsFuFiOIwAIeEzQMmh1c2kpglS5NUDRZ9vnAVVogDqeAVk27sxscvgRZ1wDGGIgjqplaZ00D4i0iIni59arboIbLjhxH6p2UUt7jH8u9TIpYfjfDDd+FdcWKr8D3PutFA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GATOyRsi; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GATOyRsi"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso3223114d50.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774050184; cv=none;
        d=google.com; s=arc-20240605;
        b=Y1QMLbRKrSSzhtXxanNQUtityMRtRSc+f8Cb+L46lt7Vd+Ew/thJSRy7mDyl/EGk1B
         Gf+j1+X6cDEtzuDi3XLsYRJF0Wfjnv8Q+RFdpBnSfOHRI+FDiszwU6BKmQBWRb+MlbfC
         zhYeL/RzAjz+YBbR10DYl43Vm5EaPjBdrngX3ybPyQqpmUBKGsbCPCbCm1Yz0vuCg4yG
         4c2eAMuFM0zZA9eNrOQEzrcbQAS6AmzbZHh3K1qHZKR7EiMOGGIu9lTyA404zxCbR8Rc
         oj08laowgBI5waQCZXM/PVTGQ5+NDfbEQn0ydFM2K0K5xv6MfROQIN2chXoYjydj6H0F
         3h8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S3ofHJBlAaVE83JxdQ+UdUO9dYFhKx2LE699YjvxXaY=;
        fh=iQb+6giAkeLuwwpui57fs50mJfltaw3P4PBFx0rNpiw=;
        b=glloz5zjgpojaCha1LlyWuxyMCjV+X0RBs1nl09/IbxvM0KWDSE4IYDdEnUOi2I38S
         F76dibmKYIwH+Y3jIrpftVt3RJ5WUAOWBNtNG2lhGBvPly6A+csB2QURFYOkTqPURVcO
         j2q/JHzVN0g7UhPkXB3JD6K8h7oPo7ua5qO77TV9JpxRNGmG8vfrV/h8S+/Sh28oJro6
         RXFb/oyyrg1QwhxgfF1hXonU29PQtiWVurmYjj8mnFOjY1/oLjH7CvhBfJ3AkeMShrEY
         c0a0bfCNvOiOTxz1B+oTKELkIjcpcq3ZNqJdBd9QhfUMJcS+4HnIXUmwmsIIGRBO4Y0V
         VK5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774050184; x=1774654984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3ofHJBlAaVE83JxdQ+UdUO9dYFhKx2LE699YjvxXaY=;
        b=GATOyRsiXHmh4nk2CKDUmqRO9lBJWfSp1TatM8Z8IOkXrfm6LjF7t8BTEv/AU6CFKu
         mfP1MKCaF5ZHb61MKeEAsX0bmbji9S/YOGxM4pOqoMA3uL2IxQJ0u7b2clQwrxBdL2u5
         3p1J5d2QsHZZm51awLKh3UxfaMZ1TWZRyZfyVVzY3KufmIANYQUQmHDPGLg44nuwUFVM
         4T0QMt6Tkpk4OL1DIQY8bK+AhYmqQx7ASi5OpGIjC081I9UQ4Xid1TVYguQNyLo1OmyE
         b0MZQFtwfwZS7z9TKSDenJZafIVmCDojltu6GKLmfx8AOJrqFR2fDtr/YDwdjRbHXvKz
         oFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774050184; x=1774654984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S3ofHJBlAaVE83JxdQ+UdUO9dYFhKx2LE699YjvxXaY=;
        b=bhdcv30aq2rz563YjKFH0zsEiL2mkq16/gdk7tu8Ks+nSzuCGOfvEGFJFuq3MmHtSg
         ywNGdpjRjuxjy6QxwDedwBEAnJ7YtwPYtOFFNLrD+9b6Izgdr+3/6w4AkRtjzt9+M86f
         IAUY8gfZRQ2JQ0G6lpmb/FL75wz2Zqc79zkgYn4cgTifJEhbav8z8wNCmpAlsfrFTHmt
         Q0Uz3yORUFRnYjDVjQfpKpCFk41TV5GaEV6B4No2TU+I8ZeYHy5gScRle2e5NZ9Fb0AU
         CKwieCeAw8zoUDkKnrhg51sroffbbodC9HwzIdgRjzgDQzpV1/fGqBTt81Ul0ywBVkii
         +oaA==
X-Gm-Message-State: AOJu0Yxt56BZo1nsDCrF/hGVFX0Q6BBszNRKIZ1PVAxG3iRGp2uqI+tq
	U7uDwg6jeoVgUVqa0w9YlkgDsyMNEmCcTqzr3u5QW4WaeQm4VGcVsVFoQQi/iEv5Yh5fBB7l6IJ
	63GrGdSlkoVa6mTdTDWEJT0NaTQxFksHjTg==
X-Gm-Gg: ATEYQzzy8L/mAG8XqJe3Rg7XOcPCsliMqb9XGCNXN/zCNoWkTqpy75SX9WTmWnlW4Bs
	uT2UI8RwegrBUe19aA0nl7s8Z8IAlgLdgjjw3Gn95zsAdQwUEsw5hNo8TgNYhVMiCrCdBUaC61j
	eUjrymTYv3LBy2o919U4D0OYBkFcO++LVkukkCfZBNuhao9Bs5KMk/LvK7vVN2bQPIPSj2W6DJV
	+TnGOt6epl6mRRAEr/u2quT+ph4JeET4+ejTzNceaGgv970P9NnlgmLAyhObSqbMCAoND+kdZIV
	RTXMMRH+Xo7n/fMZLnk6UV3Hrxs3KWw9e7fxYp6f
X-Received: by 2002:a53:ce8f:0:b0:64a:e799:1d92 with SMTP id
 956f58d0204a3-64eaa802241mr3973802d50.61.1774050183753; Fri, 20 Mar 2026
 16:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319234531.3022634-1-kuba@kernel.org>
In-Reply-To: <20260319234531.3022634-1-kuba@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 20 Mar 2026 19:42:26 -0400
X-Gm-Features: AaiRm52MOcCn6rEM_cCqYBVbOhuVUqPUGLkoIQAiWTzMxfiLP7SiXSCErXuZ-00
Message-ID: <CAF=yD-KVMYcF4_VF98qzS4qXP5y0_uXAvuVoFuexv2+qn=zznw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] net: clear the dst when performing encap / decap
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, maze@google.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 7:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Commit ba9db6f907ac ("net: clear the dst when changing skb protocol")
> added dst clearing when a BPF program changes the skb protocol
> (e.g. IPv4 to IPv6). Since that was a fix we only cleared the dst when
> the L3 protocol actually changes to keep it minimal. As suggested during
> the discussion (see Link) encap or decap operation which wraps or unwraps
> a same-protocol header may also render the existing dst incorrect - even
> if that doesn't result in a crash, just the wrong route for the now-outer=
most
> IP dst.
>
> Make dropping dst unconditional for bpf_skb_change_proto() and all
> L3 encap / decap ops.
>
> Link: https://lore.kernel.org/CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVz=
fdJF3p_w@mail.gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
