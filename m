Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30DD3290BB
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596220; cv=pass; b=jliAPhjAwMdpJyrFe0BsrPE8sWnPMnvF4DaJ7A4Tepx+eWz7a/ogEseThPzvdfOi7330GxqNNllwZrkR0HPOOeww89n9LtD/FxigZkso3SBDtviXRY1ySOg1PU83cm/OpPOD3IYJw9gBewp3r0ki2Duw/xB2xFAIpReX4WCOb50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596220; c=relaxed/simple;
	bh=UC1HOOPlstS9mzxWy7fLV16WOvX2ORKqeZVhf04C1lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsBzCL2z3fOf+GH8HAedhiIeJ3nPCuEcy3+9C26lTvP+ZiF1RQNoaZVFd/JrxKvPz3MNRTtZndM6y88Rpka9j7a/z4noK287q2bEGflyOn71s/2dP4h6ZPXSZg5ME4ws0jc3wKjB4v+PpwU7Mx9XZBX89AylZTs2HVsXnX5/m0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAhsQscX; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAhsQscX"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a86e4b950cso4091418e87.0
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 07:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596217; cv=none;
        d=google.com; s=arc-20240605;
        b=lO6oU94BxSfSJJFFplzJCBahhua/MFapngqBRbDlu7JSY150tfGUa4/FyNhCXZNGtB
         ITF1eumHQW5WwA3S1azMfbe+hA3iuqazTZ0UlAY/k54c5USqppvrYbduhrL6ewhK/nKw
         WGBkr5chP2xGB1gvVMq7MkhFFBfqnVJiSbg+n39csgJxxlXyLYNOP0QMxFt6YYdSPvRb
         0mNBS/4BsnFwvXtqLQmq9INwb7jTqxMeGVGUvuKfpUTmGIGv74wPuv1eisJ4LBY779iO
         PKZGarBrePH9OssRqa/Wem26o8bPiZoCbiiNwnVseDOlHFzkX+cq9A9YCGidgaKkR5JU
         wX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UC1HOOPlstS9mzxWy7fLV16WOvX2ORKqeZVhf04C1lA=;
        fh=DLx6gUyerHmW3K2mt4AzdSwJp7ijry7uq74tzRv7l8E=;
        b=k1mNdu7nFckE+XT8iMXBtFst8CtQDtOZS77/jVjj0kiatGiKJHGmiw5RFCHQ6d5y4n
         11EdRL82dXg41H9vGE2qO5KTXuQYVhwzT/yPZGzLoEWHXfHtOou465KjwoOECc2kONJZ
         qzWTOtFc84CKGwe5IxdG1Sm1ExnirTHSpObuIBYyy5ygnfmH4RyQdHMtSH/Cve6yQodV
         wDtG6be+OyLA39UZdHbhSvLiE0xqOVtML3AgOJMe5qbo//+JDHRK+3Upu645opXWVLJx
         brOJk5JShgjIAcGMCN0hSDTdNmIgpUrBGRmiaIrwJ0uh3QxBaEZT+gWvBa8GE4obqHFK
         gKzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596217; x=1779201017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC1HOOPlstS9mzxWy7fLV16WOvX2ORKqeZVhf04C1lA=;
        b=lAhsQscXVW8HYzzh8RN/12vVlMvG7gTs8XAi3mcdIz6+MhqEpZWzcnewwncX4eKJ8u
         ImJJ4fwMsLioXxzws+WiXpzatoaVFn6BUEidAEbdz3o+8FLMF8hfwvTK0NzQirTTVRBs
         E0EJwFePYgRiG7MZ9TfPWb//2PtJ9quhhEFmugdlzXn/ph9yrDwNwRHOlAegZ9TSKLbB
         I2La1eGp656SbDrG1JyUtU8ss9DjKfmVCJuD2Z1xRQgvI4leJYFHlwtUwjzbu+mX6Ejf
         L2oo/9iwdPc4MmsfUHFgEB9YddeqLiZVaFpaLtjCV7b3nAyP3xYH3CE9aXcZ6szL6Vzx
         MafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596217; x=1779201017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UC1HOOPlstS9mzxWy7fLV16WOvX2ORKqeZVhf04C1lA=;
        b=Ib8SFO7pgaKg5jNE0MDQEYWaqNslVUeJ7KQp6Ylx7ijDIqAGnse2raprRz6IGaId8t
         OZq/W2ulpHDD45DbO7hbb7QW34iojDXMeOxwbCgVl2zBVDKANt1zLCUi5oQNxO+MycyB
         5Ri5DKd2Yz5mxOloYn0yzL87LgSsOas6afRuamQ05SJAGro5YrPPHVamLuH6bqYEOdXc
         e8CIpR28yR55t94S8XsswEoRsvqLkWBn/QITdgv9nnBVski2Acyt0zDy8yDoCo+Ro4wq
         AKY4LOtYXIBEmhDtZEjjvKFi1b0UC/PxXz4O1VPPrlV43euUHLSDB4f1/oEzVCWjYJLp
         bEKw==
X-Forwarded-Encrypted: i=1; AFNElJ/OtnOVcq27c/9I+Mone+1GBfUxR+ZJM/3vOsra9qdeuiV3/Idha1qsXrYvCbjfApzjj04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVmCMS9Zy4eqJdWoO5aTSPfkcdrBw5JMJALwRnvituacc2Zpl
	XGckTOPIN16kpEEM60m0RZ/d0chKje592YnhP80yEJTQ63oYjBr4VP1FnWvWqB9gV9gewH8tDHc
	8h/zHweq1IqO3i+tVqXmqWpDtRXcYPCo=
X-Gm-Gg: Acq92OHclu3FZNwn5owuzVm0vkJu9s5Xo9yttMIG8n3RWlWfKa7mpox4XJUsPQKz8+s
	Jo3VujrGQUC1F4i/sTH/77+sbRZ27XKOqC7z+R8oVHpKFKx7WG/qSZ2BY8BLdRBcH2N+GWsFqVA
	wWqxLiDLYU9HzZM6WHqcH/s3CCZDLqaQDTzg1fJ90dHr7K2rVY+YgsyYQ+KozNxDEupeLub11bZ
	xZTCkf4/V8pz7iT/wQ6hBgtSV7XOjsdWIYPdAfHkZSYUHIAJGXfHk3gbqoouMPbRNHay75dj08U
	5r3W8TOYb+LfGrJnG8n5E/uUkx9ULENaktcTPlc=
X-Received: by 2002:a05:6512:3409:b0:5a8:99bd:12cc with SMTP id
 2adb3069b0e04-5a8e31ee2f9mr1426213e87.28.1778596216912; Tue, 12 May 2026
 07:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com> <20260511071634.463aea60@kernel.org>
In-Reply-To: <20260511071634.463aea60@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 12 May 2026 22:29:38 +0800
X-Gm-Features: AVHnY4IsZt3e09x8B5jihx9KDxzH4Eu-DIuM85L3vRHC_QGU6iCLOtNxoLVJC04
Message-ID: <CAL+tcoBezmEsBBNUxdz1p0FBsWd4qgmJX6xYZMgHxegHAoZKjA@mail.gmail.com>
Subject: Re: [PATCH net 0/4] xsk: fix meta and publish of cq issues
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 10 May 2026 09:23:06 +0800 Jason Xing wrote:
> > The series is the product of previous review from sashiko[1].
>
> This series breaks the BPF selftests, it seems:
>
> Error: #277 ns_xsk_drv
> Error: #277/21 ns_xsk_drv/ALIGNED_INV_DESC_MULTI_BUFF
> Error: #277/22 ns_xsk_drv/TOO_MANY_FRAGS
> Error: #278 ns_xsk_skb
> Error: #278/21 ns_xsk_skb/ALIGNED_INV_DESC_MULTI_BUFF
> Error: #278/22 ns_xsk_skb/TOO_MANY_FRAGS

Thanks. I should've updated the selftest as well.

Thanks,
Jason
