Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165436403B
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115313; cv=pass; b=SeCgJZuJsxq9e45xLOLkz2DLykLj7sSsLaZFyQiZnIvFD7hCginLtcQaLXnejKfSzZXspsYqQeCQfLYRJU+5IWE9P/xRs/s6dmyFZUiyId9HS062lWyrW/LSm0WmYws+BZECjgui/Vq+9/nDrRfXhJGg9V7vNvwAmWu6xazejwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115313; c=relaxed/simple;
	bh=4WZbWdaZj+aiRXHDL/W0FOItC6o0fL8KJ89SbAOpabg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6/i38OcQhq2P1hGaqpGTEekpyE32MmVB7DuNiluGexLWs9Lx1PZLUdanzyBDzc+oQM8J0rwE60ddLo7KxW9tPWm3nbTUGF6LEprsIqFetWt1J9Tf1q2ORlrP/EN7fwHICWN9lowEY4bHnnT8RCrSLrgB6Ta457v+4Yy1MROgc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH7rZVGT; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH7rZVGT"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a74765703so4407807b3.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 00:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775115311; cv=none;
        d=google.com; s=arc-20240605;
        b=JR3e3mxbkjvQvVf8HeZolVc+PTRQVytNerPQv7TZ567tqCFHfEXwgrMdQ82gUEzzZF
         pG+4OjIZoXZ4TcII1vingRYobW0/eYPrSvbC7ZOefQCjojpKsvlr6MUnmpz4YFaTnb+c
         cdvQ14EGUuDdUrpWEp3y+BCiSxv0dep3I8/QpToxIWbYLkLn8fB9on18O1o72bn3vfTF
         cRMgNuO/+1XWrnVStZ7kPCzo3daiAeKs2IgpJExw1ZpLYpiFPc9qHyUbqmVBCvIsaKlW
         mLQ2rurJHUkvzJyajvOCDTec0ivaMybHq4uuzW7rsKN+728MT50tkZb3ahWUTTiDHDEQ
         peNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4WZbWdaZj+aiRXHDL/W0FOItC6o0fL8KJ89SbAOpabg=;
        fh=8s8Uq52s/YoQtzl7h+gdCe8MPSzCGA+tB8Byxk+vQzI=;
        b=Sik9JdZsBCt/+udEDf3t0VFIzc/XCpPb/Te8wHl+T8Ax5fQMdNb04WLYaGMbXoYLt0
         1n45QNZJ2bPHq5GybpJuXKx5ptedUAqPh+H6ahAauBAEL5TKojSdefSsxDGHhvRF2ig8
         mYY3khFeJSSdf83miyThsI1JMMqcOCTctQrkgl64B5vLqQRy7ekV7tAT35k5zqkYKZLT
         yz7dCgVWQuncOKvF0FvDQI0ZablU8Y3VNPJC8GqVHMFNod3JwCNjVRq5mEJ/E0FSPDl7
         +d4NeiPTmmM6QMeuktJjtruB/4FmTJuGisIVCwjiT1ixrScb+ncDTeumkfUteKJc4YYO
         c9vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775115311; x=1775720111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WZbWdaZj+aiRXHDL/W0FOItC6o0fL8KJ89SbAOpabg=;
        b=QH7rZVGTbWA4f9+JjY/cDmQztxTl89aBMg6BCTWz1Tw7VeFCCzyELTOojtaBixeXVm
         k1A+6eRSmILRttX+P6mQy1HIqNZh+SE1tmzNVFgpkqODrtonGXsBeJRh/4mlv7zN4Ov8
         VQe1D15RXu0GBUjdPTHcUdMLSfVTnpm0pF8lfEq5AhIsEyD3hKPtBVcQorIZef9FuayS
         vhPFE93Xuw49dbepnSY6/Fa9pof1d+EgSQewvJummVmBt0gmOnfaMRzel7dGkECGLM6Q
         7OlVZ/MShIGRm3e20PWls5bClF6wKYN3WaD3wpEUy2je4CVGauktPCSXjJfiON1/a3D2
         97eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775115311; x=1775720111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WZbWdaZj+aiRXHDL/W0FOItC6o0fL8KJ89SbAOpabg=;
        b=LJNBjx51w6QIPkcsFmnQQhbDG25Wj1R0WtQuP3Fh6facS7HMeHRZ+kxQ3xzZ0NP2Ta
         WLUwViIE7W+L3ECluBMzAsZy4Z7U5yN5b3iD3JnCEy4JZvBU9YH1mpmMt44Ce6HtRauM
         iU2dRSZrxXjPBHFUAaVgliX1cihHggsfxogtwk7BVXOfS+ujGl388Sm6FpA5qI6ACD0x
         x5Qqd69muwu+m1N3ocGK2fePH+lniONSNA6rqwJCVsratE/0L0wpC2dFkCNZp8jVrevE
         VSSHp8SiyuoB3HoOvkv0GOboMu9TobEEj1Y2ugtFmxotmSHOa7qR8xzdj2y+ZkoiTkZM
         e8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgbwOXShWaYvRjyrcNwzOv5OVm3Dy8ibds/5uJEFaLmfwH/CjbD3HieKbaKtEC6sXMKwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq1UHJCRxHmtW1AmlJvaYVxvmEUQlRWyOoKLmfPzyAASaSRLZn
	gRvVAxs25AYbcNvV0gMC1TRexE3JO8haR12zR5JEp4JTaEj8SXBy1XSWY9POGZdo9rYvjVVbTf8
	RNPKzTJhrDxFhX4aoulOZiO4WL+AOOrI=
X-Gm-Gg: AeBDietwU2C2DV6tMKf72+GwC551DRHocW39TPJVsH5xyU34py6qi8BUUUpPe/vGwAb
	80Lf51K7KCb8F+lnYYZIEzRGiPJCNs5CGJirllJLaRxg6yqHzl4EZ+yT+dCOKEfv2juIY6AHeD9
	yNtAoPmpdhIX/VXd6sBnZ1JueokTxIHEy6zid+r7UuQ1AKzM+GsEc+UFuYFVO4LqVow8001RYbn
	iJTDZ6OwINe2L+saV/IHxfU/BPlbnad475Z/Gpc63OCRggG91UGFrN3rE5dvyy/Ix7Mw43JIyRl
	q9h70c5cQmnM/d8Ua73RTrOZ0qnjWXRCEk0gPn8Svr/xNpeDjqDuE44WrP4=
X-Received: by 2002:a05:690c:d88:b0:79a:bde3:7085 with SMTP id
 00721157ae682-7a2100bf842mr76036047b3.14.1775115311413; Thu, 02 Apr 2026
 00:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
 <ac2ccb5NBAB3Zq1D@devbig1721.ftw5.facebook.com> <CABFUUZEdh2-bpYG+inQeUwxs9UC7D-xm5tR4RtAsPHrG58WBSg@mail.gmail.com>
 <ac33zzsqHlFc4GgE@devbig1721.ftw5.facebook.com>
In-Reply-To: <ac33zzsqHlFc4GgE@devbig1721.ftw5.facebook.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 2 Apr 2026 15:35:00 +0800
X-Gm-Features: AQROBzAGyqvst9G7qZ8r8l7tiSSlbGVenVi6I-ak5gjRimBy2L_G50SUsSx8bGU
Message-ID: <CABFUUZEv6_nwAAqicfG7SgO_9nY2Q-V2ZPxMsMLq7Sp=VNkfqQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:13=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Thu, Apr 02, 2026 at 10:54:41AM +0800, sun jian wrote:
> > Ack, I'll respin a v2.
> >
> > BTW, v1 was mainly meant as a minimal proof of the fix, so I
> > kept the existing structure intact.
>
> This is already v2.
>
> The minimal proof of the fix is a selftest for a tricky case
> like this, instead of spamming the list, and now also the
> AI-review tokens, with an unlandable patch.
>
> It is a few line change, and I don't see how duplicating the
> existing switch case makes the RFC review easier.

You=E2=80=98re right, I just noticed that I mixed up the version number.
I'll respin a v3 and include the selftest.

Sun Jian
