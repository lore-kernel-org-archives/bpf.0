Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E935295C
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016752; cv=pass; b=IbVfU7hiETkVTmlh6h086+FASRFfNW6jfQR+n0TZs9Xxz3yEbHKcMix46p52UMQrdDzougjCkT/eEbpD7d1y78NcHlsb62WwV24y4OiWggqvzIIPRjQGYhf5oH1bS00UbF3Zl/iDyAhZ1KvHt1ZlmAEsjltWY+JTECTLDnYwTa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016752; c=relaxed/simple;
	bh=ILRzw3ymgSJBjX0vTHNQsa/d76Xbo5gLzSf+w3GDhIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vf+Eu0rDpxireugbP6nr62Jo9IGwv9Gbn5IF6H0WXuDi765Ysfc+WbYDYB5wW+Ln2mMYBpdNuP8GNjx1Ltp/5wtn6wRKiR5UGuWrtVtimhHCtb0UAkFtqzB0LAqJC5/jBpxsXDmVM1fO/2Dsqp+tETBGB1nWklUy8Dv4QClFLuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLSUj6ky; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLSUj6ky"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso93369f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780016749; cv=none;
        d=google.com; s=arc-20240605;
        b=QeuJsQ3YP0/Zf5cCfYNx879Buzb84JMKglvxsUlaIKjg5GyJAb0TTC1ZXGvkEhYxex
         y8mcTFCxX1VWaDhdvEA3Lr+/tse0t5SY7xr1VdGNqWW2ApxC7gyc5GZE46z5GOJR6hiW
         PuERx6N+0f2+4FvENbJhNKKMqBKquuNTNmYvKoH4DBVXaErghzYA0wEzQ5Z4ZFmVXwbp
         bpsj8bK+XFgeZ1I+NWuvdZmnA+6xYXlBEAbrhBTYd2IAy4tOUGYiza9P5dNw54kWL3mL
         kdni3OFxRlqNJ6WAyEZ5QXApzA9LgkHmtiJG3XHc1LWMgy5vMYX8UOHzoivEME48T0WX
         fEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ILRzw3ymgSJBjX0vTHNQsa/d76Xbo5gLzSf+w3GDhIU=;
        fh=G5/vNH6V/KcvXEO3UvVBCw3LqedrAoxSqs7bYK9QuIM=;
        b=H+Li+Av+l60UM4lJtkbkXsBO8PZ0D3+beFo5yKsmt9vGMmxYguj0Lxf9204t2IC49n
         a+vMUfOvopa0UOBmFx3VDy5HUGAifcz/MX0aBkZUZnyeTNvZDbpNlU9K77LLCF+fAp6N
         vgpd49W9oAPVrw+AyLoW7SSnNkKqY9OF+rkd4kZ4bkm0limfq4cN33Q/zTJxovWjNq/k
         q8fLQpV7XQ49r0tIV8sPhill11sPE7GVUhnE07IMIXNhMiQTOcMTz8+ZnVTyG70OObJ0
         Z6AOrMtwkJhCTqYP4hb6e4xIOGQh5YEsmuSU5Rbk/optXQpvDgGiSGYd7FIuRwGwmQCq
         frHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780016749; x=1780621549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILRzw3ymgSJBjX0vTHNQsa/d76Xbo5gLzSf+w3GDhIU=;
        b=dLSUj6kyw5l1aAZhP0Drs1miCIN0fHaGtYKaWT30KTYeEqCtgBFFJ4R7DO3acK7ikD
         bh7/PzRBrtMUjRAGUOT+mBu9NAnZ9IsPIOJhFEP9sy3p1iewyluQy2dxQv6nHQ8bk9bS
         y9syWgxw5OY1JARtJdR9yEhIIhN6E7DxgeQJoheX69xAmUHUwyd3yUX7ridragSNdDGL
         iuBFwzAF8FJV+8gfC7IMbRt8LQKz7tEOLOxJzcsyXYhd/8G538xsJktmzU5V8LTTj2aP
         wi3gDjy4w1ejbconOpIH3AaBEAspOnKfY1v797GnhyTca4hx6St15DG0NPnh9Ep5mqRe
         EqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780016749; x=1780621549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILRzw3ymgSJBjX0vTHNQsa/d76Xbo5gLzSf+w3GDhIU=;
        b=UbM7g4qx080gLGcZupski+a82KNQhdMbVZDJooT5Pac3FpulGwVCBHs+tYbQP+9AMS
         jeMGArs4eLXYdKDK4nurZNBevw0OhjQnlCyK35qGRcoh3o+smANLzApyYTZNSQisTzIU
         XWGVZjyE1IxuwCp/FiT/HI409ml0Zhld1zW0dns2tvWO2XklmMy2tPZO4olYhHIf/ECS
         LdsZQhoXECEni8cj0FPjE23ZLJza9eOZHJTxfV2e58kNZzWNHDy/9lPGqexHmHEI2GuM
         UOIhKuerg1Ga0hCx1SoqaDR0I+82gpSd0kxYDmadlrcjLodXDFRYjJE4UAlkyAn03eBm
         68RA==
X-Forwarded-Encrypted: i=1; AFNElJ/0cVStEm2WhAfLHro+KJyAfRiOE0+wMxVWkROx0bYG3zerQClKRSS1DUTFgXDYwcLjL6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVxjP9R6BapJr4BWzmJzjnADeeBnX67DHZKSenD3u8ZUUQ4PQ
	2ZxkaHrrU0ZqeihdyOBp/Alq5rBZdQ+szRm2Xjg7dyz1+tH30wleQkuXUhvvif8qI+RN8nUtcQO
	5FvW2EwBB+SB1Hl3zOsqSg0rZVERZMqQ=
X-Gm-Gg: Acq92OGnZlQ8H++/9cbaRu270i65HHH/nrXkhDcVAydFytI3bTXpn0lEO7ugp2haf4a
	eijndVa7CSlAW3WiMurXTMhAzK3na+Kr+G6QL6e/2bUmNUgt2GueDeo2Fpd6wX2+Ubl6YINRcwC
	CQ/ueyqBTYSevPPx3+VHtZZtgflOTXZ0E6e43JCmFbuWTcVFu5bObVbQvvt1dysjVOHmaBoN9ox
	VTuasp1uQ6r6TQIKCApkYxrIJVzI98/85RgZPqOE908xmBjxocVJkzirQEC92JZzMGHPulAZWUh
	1I1ZFlzOYSR7D4UnyazA1t0kXkg18rc7jw1C9XQiopoOG4Qt4dvbJrPaoE3CQsjLUc70EspCghg
	JlkLDHVtnjcjnkEIBN4zEfrdW8sCERI4P//Yj
X-Received: by 2002:a5d:44c2:0:b0:45a:e3dd:586b with SMTP id
 ffacd0b85a97d-45ef142b340mr882702f8f.18.1780016748489; Thu, 28 May 2026
 18:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA-VZPk5=sQMCkngpXBo34v6=Ut5YmxNiTKSLfS6-GiSvUZUEQ@mail.gmail.com>
 <5bd0c7b135559943f3abccda6390705da5e493d5.camel@gmail.com> <9d1dc36948ea9cfdf48f643f9b34ccaf51411847.camel@gmail.com>
In-Reply-To: <9d1dc36948ea9cfdf48f643f9b34ccaf51411847.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 May 2026 18:05:37 -0700
X-Gm-Features: AVHnY4KCKL-CgFeW8HmVyzlyJR98KMdlWnkSAfMeRZuwb8i4CC5I80qtXdP1ZIc
Message-ID: <CAADnVQKfjaro6PMyd=2qaU9UeecLmTbzfj-f5ULUpfobhsbUgQ@mail.gmail.com>
Subject: Re: bpf-next verifier regression on unsigned bound checking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 4:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> [2] https://github.com/eddyz87/bpf/tree/cnum-split-at-zero
>
> Approach [2] fixes the issue at hand and has almost no impact on
> verification performance when tested on a set of
> selftest/scx/meta/cilium programs.

pls quantify "almost not impact" and send that patch.
Looks small enough.
