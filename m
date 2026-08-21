Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9F28505E
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276091; cv=pass; b=PRJS09PyLblAwP2XbT/PrXxBmyHwincHGgiWsOCTTfw8jfwunfLwsEOIdX3zGGKJrpGUoBTPrvrdov4qDPMVVivUisbVHjbBdt/o04aLR/mw3gNgS/7ZnrHoWT50vc/bDur6YG5aj7/pjT0uuLypwWeg6jIwhhHaLFghiu1msyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276091; c=relaxed/simple;
	bh=WfYTfDqlFqDiRBgWlVw/ucOoL2L7rph45JUv9iWsRYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrbhpTBuTsdSOO+mgA/uZ0LY/mOZNm/jm6cQ4SQ5L5eSE/m+IuqIt5b3u4G3n2srQc67twvsj3AcJjvzojW5jXg/tgPF/IjiDZgOIO1h7mYEkWnzNcAzYbE2o1Lg42G8Q24BYoruiEgalLieZgCBL5Zqgp/PWM7UGYfwf+ZNmk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtIusaXW; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtIusaXW"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc11a30a259so510659a12.3
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787276090; cv=none;
        d=google.com; s=arc-20260327;
        b=gmm65GbMpK/TQzr3vC+wGFqx5ddcWhXAPMNJWTnaMciscmkEhO4uk2uNfmT+bo226S
         TlPb/S1PH6Xe19G9/BBnujGsOQLs/Va7lZuBwx0mB5+hpZa7GyN3AuoaVm3wDH6+5P1z
         b77Y3I0MNUayuKY+hN4DwdNzEOF4PyPhIr87VYnNr1+Osy503NuGVSZ1JmxOLPWQXPjJ
         RzvDuD56gn4zTU2v/QI3veixJvfK6PikgdBaH3tFgdocGlRfPmEyi63poKYmLC0i2hIt
         8jwl0kcsjw8umNBfuB2xBGgxNxCzDMQmm6Ou+7xJmr/whuUtDtBbM3ulLXQ/HUTVQVZ0
         t74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tRjMr8Z9LADn4qfCevJir9Kj4//t0MN4odINKyKdXnI=;
        fh=+xaYQlC2PTXeSdVoW4K1KC8AIGTJeLd9XshXcoEuEmM=;
        b=lRVe68IH/9bUcL0iGCeGoJROHJNUMFXpOPTiF8DJ+Fz1vXm8cZYE4AsfqY8p++P3wg
         B6xtZw6wsSzFJJ7dVcMwJZMHtm/poV1MqQusKBNhDP1URDwJVBVnBLXoY8QZkFgcaNkO
         KH4WDA40ccSZ12HsP+WOTYfCKHa9CpsL8B0FW1VTQ9/V+slcVNz4Yss5SJ52smUblr+1
         yMp5ZpOpDizytBroZMqHCXhSjK3DHKTf3iv7ZYYCI2FqOZ2doGfgS2PULGHKcwp3Xulm
         rkSobIgxgP3HWpBm/7dKvu2uo72c/JIidRju5/8Ljbe5qL4/CuZWhRN4fxDLDjvXP0TK
         5Zxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276090; x=1787880890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tRjMr8Z9LADn4qfCevJir9Kj4//t0MN4odINKyKdXnI=;
        b=TtIusaXW17GD8lp98a9a243R2HMsFyTJITFkoE0AE0/JiXrcHO6GE8W34VZ9IHaNcN
         JWKp0YYGCkp564ekFt8Jj6+5fbID2xJWRs2lpLbksFwSde2BXEYVohfUfiHHAvGgC7Ov
         L0o9lPUlVMw3QczDFlnt3iKqb2urUZd5AvCjwzu0Bb3IaP6Mbfjpek9HnoO1Qzz+1Uv8
         CnMiyACOU0uJAfrgiz4zLmS7GZpZt+Pn6vM6rCcVkdc9LvxfdY4KTJSv3Ch1DOfi1brd
         oQ2iRVNWiLIRIKmVj7EcG0vpSb19s8Ztd1wybw3ELaKkiQdtVaqrc05yl89JaASwOJ43
         59sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276090; x=1787880890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tRjMr8Z9LADn4qfCevJir9Kj4//t0MN4odINKyKdXnI=;
        b=Ix6yOXgxsKsIicIYTu6GUzQbHIglrD6NeCniROhheFe3wrKRaaO2EKWnqD7nWm6UkQ
         O8LUNDSfPcML1GPXGDxOl6eAVA+j4Hx5NUPSAi8+SbojqJy571TFPJpeY4ywfUrDHF0N
         K8xaRcnygMAXC10dpjrf9QOU4Il1lqSMmWO6eiAAxAwOX7HRWYhWix46y8aMyQXNcok0
         RLWiEbtiy2EuA6gm52zMeI5LSGs5Cdp+7hyb+IbWe922DOxZWB5HINOl0+5Gfnm96JdK
         zLjtVhoaIR5r8aYSsT6PL95rJv8+wvasNxq7BpdhL3d79dR3fcamCwg5oIrACG31B3aT
         zxMg==
X-Gm-Message-State: AOJu0YxZ0M1QQFrwk1pk1PSkRfysVJL8hSwK4iecIRcysZy7LykgwtRM
	SG+INczuo4AXuOZ4W/t7WKLu4HnVP7f8UAfYROOoWPjLd9tRjHPTpvxcdLXHH4t/EgUMW2lL1Xm
	yG4xk7m30Xqy04rujzLLZFsNl/xLAaVk=
X-Gm-Gg: AR+sD103vsafOGZmkXrCQfrYrejD0gqIzrynhV1x0HPMeyU6eZA91dwphw4TBe1TDTL
	kpeswHBPoyeY6JM91rITddNxrFcW7WWK2HFE03pZKnL+wZ2QsaNKFJPhQOHCVQPyS+jXgLJ/xAR
	Gfk4eGCc54hqGVweW8Jca/Ug0PL4A2VerCtvBiDt+WFrvRH0L4wftnvw2X4EvEZabqJiHAf7CEf
	GtHq87jk4vaTx5dFIvMyHtROoySWAG/sOXG1S0AaRqiMPwAi6TdmhSyxSUHdSkGRMZbIH+mYuTk
	qDkN6h0/v96GdWHb3eBjqx8NcpUm1T0MNLYA29HGh6mebrTyXmCF5BtC58neN6T4gmCBPl/Jtd0
	TrcAPVvQkOP7/nlwqetydW6hvsbgZ8jcp9AFNs7BhiBxcLbChyfcwbx3ycNwH6Uo=
X-Received: by 2002:a05:6a20:438e:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3cd2f9b4fbbmr5373593637.0.1787276089383; Thu, 20 Aug 2026
 18:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoen96RONJgf18E5@devvm7509.cco0.facebook.com>
In-Reply-To: <aoen96RONJgf18E5@devvm7509.cco0.facebook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 20 Aug 2026 18:34:38 -0700
X-Gm-Features: AcwNN1Uh2K6g0kYN1lc1brSJwvGvTq2xrJAbDDhhHWgdkYQ_a9pwszsQC5ZzaUM
Message-ID: <CAADnVQJ6h6btgOTdDT63gN7iN3dkAY3ZFFFmyyXot1Twr1x4Cg@mail.gmail.com>
Subject: Re: [ANN] bpf development stats for 7.3
To: Stanislav Fomichev <sdf.kernel@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 6:29=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> Developer rankings
> ------------------
>
> Top reviewers (cs):                  Top reviewers (msg):
>    1 ( +7) [7] Eduard Zingerman         1 ( +1) [34] Eduard Zingerman
>    2 ( +1) [6] Emil Tsalapatis          2 ( +3) [13] Andrii Nakryiko
>    3 ( +2) [6] Kumar Kartikeya Dwivedi    3 (   ) [13] Emil Tsalapatis
>    4 ( +5) [6] Andrii Nakryiko          4 ( +4) [12] Kumar Kartikeya Dwiv=
edi
>    5 ( -4) [5] Alexei Starovoitov       5 ( -4) [ 8] Alexei Starovoitov
>    6 ( -4) [3] Jakub Kicinski           6 (+22) [ 6] Ihor Solodrai
>    7 ( +7) [3] Leon Hwang               7 (+22) [ 5] Leon Hwang

I'm no longer first. Hooray! This is an excellent trend.
Thank you folks. Much appreciated.
