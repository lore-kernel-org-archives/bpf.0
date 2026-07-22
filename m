Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7E3B1EFC
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753782; cv=pass; b=fdM3G5y2roUEHh/Rb4wtu+3SXCBsk7tT+3kKJgOF/QfBUUZRU9gz601IP1Nbjc7axKu+QdoxOHjubgLpFkzi3woeddRIRls+7aDPj12aFO5UvlhpavVMPzJ0y9xCSHwE2UlludP6FCWXHYdaJl/qVxASWxEH8/4ddittdNiMg8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753782; c=relaxed/simple;
	bh=0MTbgq1KWJc+1GNluOa1ST11CPqFKW1ipwKVFiUVMh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyQl2FRSjMu4JoZA9JcX51ThrTHohFVfTVI9YCbxTJNnW6OAFJo2g/Hfq2fm4eipSot9tW5iRH0vF6P0Mms9JMMXS59uabC7+a3ZnNejbuxoQyS5f8TcMf0jPJ2ma5nnFGl+i94ytaJLwsqTPLT+JPtKoG5dKCxlTMFQTGz9CXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUDE5mQ2; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUDE5mQ2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so13295e9.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784753779; cv=none;
        d=google.com; s=arc-20260327;
        b=ZnT4xxTW/6KEWr1uRM/TE56/tI1llKUNAlguvlMODDYNf3a7d09r6iEeFhyY8RGavz
         F1LKgXIP5PnF6+KanUl58bBvuBl6ICAXoaYREOtiZ0lctk+JSsLCXVo9zSBi/CdTKNPI
         z4Q9ZvtVxLedWyuG49UAyNxNgqmzayu7Iv6JtY31qUrPhAVXeMHxxJ51MfcBg+fi02iB
         LL+EV9Opg3dX7oSmSwfrK8uOk58m0yQbbEYXTixLu/eGk18I03Y082mkVa18PPbSUEVg
         wv8eJLmy3vgL8a6WlTuDgx9fDVRInLnm4rwIAjhVpcdpwr9E8Jhwf8Ygvs1UrqDn4ody
         96dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0MTbgq1KWJc+1GNluOa1ST11CPqFKW1ipwKVFiUVMh0=;
        fh=S2n2PPIDX4KomTSHVkCVsq2RB+Z3zS/LeMYP/S0x+sU=;
        b=Mi1hfNrwsJv67dCZyKCygg6v6+4Msp5d/XQzvuPphEEWULXS74MhgEOhgLs7XShuTd
         3/G91Cj7O8fUKTgqQz3FFT2t/75iQqmKwgFHVUiNiPTmyKyj+Vko3WuAVx6ylDMqH3zd
         OadkLkmCFl4Fb5Sgd6aECgCkq6sBKuVjg+iEbKfyKUpBvZwWbkJP964yfHX897A/+mms
         tVqdqtLzvT8IMXwBmvICNkf9aTiLPYgPE9RLwTnHOfMQp2Q3kBMiOW2sahtAlgDzRXrA
         KUD2e1ugPkZGnd5fJ5+A/flFCG0u7PQf+BaOAwGcCm1Rk8VuppbeYmWw7McATrsG9k1J
         RPew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784753779; x=1785358579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MTbgq1KWJc+1GNluOa1ST11CPqFKW1ipwKVFiUVMh0=;
        b=jUDE5mQ2pt7iMN2CLkjDAkjGNG21X0vrsGDxpguPwAfu92TDlVqdLXgeHtkCkNBToU
         AhMhG1MzMS7WZcOnNXlfqd32h3I9kAwpdUJ4xeHJzcAm4cfZ2Fg2gEx7OKBlscPmiq++
         o0Uw1Qj2jUGYLRXEWV8jKrgj0tRIlzQU2y5nPvCRRFm2qZ9LDJx3AkjL5Ib4Gpqsv45z
         r0UJXHoAzxMvtEdbsY1D9qkE/vtHtg+/gp9dndVd/S34AuujFUdAmHrLfYgK1azwd6fJ
         OWuPgLdZ1IGCswo3dTkSr82VDUoWNCTSXQitWzUstUL3EaMfpRc1tKDTuIIKQ9kiTJf/
         XYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753779; x=1785358579;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MTbgq1KWJc+1GNluOa1ST11CPqFKW1ipwKVFiUVMh0=;
        b=KKV2zgkZrYuAkAI+78y1HeA+HwMIhlxzLfqAOXXh/jN0b6Rgs8N1wzi5S7T3wcGmQR
         eg+veTgwY8W0PrFF5zGxEdU7tjZ1ZnhONzxPEENkoU393Al4swFFE9CgwGlBVhMXznpN
         jxJ4nlqHQ4i2tkTzCMiaXHzyspvTZsj86xDYy3eZvzDZx4m1f06FXZ2xVPBx/DkXg8G6
         fc+uKARSKdQJbkQiL5EJC+3WKmJgt9FHTGDuc97zhv5CpNWcP0QRWtCtOJLRA3Tkxo7Z
         xxkyzBNhc3TTxbkNVXA93jJT5G237RssG8GV4LheEtZoQQb6ohJHZP7dMzUPdcQ2nRN3
         7Giw==
X-Forwarded-Encrypted: i=1; AHgh+Rqk1FOdKVQGhh+10LU2RERVxmX7P9TI8QG0N0R1jwsoOi/UkNZsjyZXodZmegkhzftj8fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDygZnWmnws89oYuqvlOLFnUMnngKqqv9iRmGGTYPcHPpzTTp
	L0DS/gKc339Ws1rtnca26wy2o19dxYQDPr30vEfDUEZLR8rZwxoRhpG/ig9GYfMlL2j09kS5xGe
	q8vhwRTJVz8fbz/ptWVqfnpAF+fY9aX3iZRAAOV9D
X-Gm-Gg: AR+sD13NSkThEBQtNeb32iwAbUEhL6gD3aQ/NTbPRHIDCzf5IMG0AXtgDlLwKAyDTln
	sNFczFaKMSA8hzBUWOwuD2KAvMZqsiI1JDbGKdlkAnQKkCdYWqvOhYUkfDw5g3rwWQwe5AIWGOh
	cEoipIWk4EfkENmPiUXBV5+QinH1e2wnyWR6MG/A6M3e+JF5cI/JW28nB1x759sKDuHz2DTPa0v
	uekcq9ugpaUsOHeSIxdCjAGjXkhLZAwxKl00Y5UPhZYsjL+TSLYUkC13FGufyKGSwFPOnWP8FnH
	qU3JJQtRjENY8ckeQ+vmHOKAwkhqKEWk81NsiY16EqoZ6Q==
X-Received: by 2002:a05:600c:5691:b0:48a:5618:b4d4 with SMTP id
 5b1f17b1804b1-49573dc9ae6mr112305e9.1.1784753778589; Wed, 22 Jul 2026
 13:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701192210.2997769-1-tjmercier@google.com>
 <akbPrI67h5btdI44@devvm29614.prn0.facebook.com> <CABdmKX0-tubji_pBiaZbePrxVLA9qkw5ez61wyzjDz8-pko9SQ@mail.gmail.com>
 <20260720161052.394687f2@kernel.org>
In-Reply-To: <20260720161052.394687f2@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 22 Jul 2026 13:56:06 -0700
X-Gm-Features: AUfX_myw4NptciZFfZOOPBu4oBVvGbQZBM1IcnixNVaCyjE3vDvwDLKrGe7BnIM
Message-ID: <CABdmKX3EkDdauF4mPaU2B=5Sfas1q4W9NbPi-1nC1-4N-yhb2g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: Open /dev/udmabuf O_RDONLY
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, kraxel@redhat.com, vivek.kasireddy@intel.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 4:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Jul 2026 09:29:40 -0700 T.J. Mercier wrote:
> > > Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Thanks Bobby.
> >
> > Shuah, would you mind picking this up?
>
>
> Please split the networking part off, networking selftests must go via
> networking trees.

Ack, done here:
https://lore.kernel.org/all/20260722205442.1894665-1-tjmercier@google.com/
