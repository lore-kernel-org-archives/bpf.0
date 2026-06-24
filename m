Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739E21638D
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334631; cv=none; b=lF6F002hHRnigo03j9rQ6BARO+MBxKx7SBGSAaWVS/TJHwTfuC/hkfZJkrX0HcDanORPLRsnXiiVBqQ0D1e3r7qQcYVPF4c1dhcYwdsk5TbM00BeflGXfEkFo8zjvQMPJs/whKRxC7XS2LEp9QMDOHzSwb7VdMeWmR5/EKbp91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334631; c=relaxed/simple;
	bh=E1kSn3zA/cIoJ7ipzjSb5l55z352jUSBjqBw1lqnOFI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YnBKBEmZw7Dlz3642BPN0sef8lA7/GmbabbEYlbXIiWvbTMdiQbJuytMPhOI0KuYvoD3E8pwEOvmUs/RC4YnWGALxVPJLUIubDiyc7gUfzse4QVQPbh1//vB7wP5pHu2RQqLZG+Um7qI5kxt8vWk4uEmdxBxXodDoLLKL1rbGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKBrZOQN; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKBrZOQN"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4414d76270cso1017198fac.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782334629; x=1782939429; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1kSn3zA/cIoJ7ipzjSb5l55z352jUSBjqBw1lqnOFI=;
        b=XKBrZOQNHHOUfyCUySLyjBci1OrA/cmKd+bvJNK0wZl7lsowOA2eQfjYEIibwwKEPC
         D/sBHnockiW9bRhIu+2+WigdCU3apn7/UUvZKC5n5rCKVG7axPNM2H5p/pnkyyxKmruO
         usw88e3C0wgOyq3KhdQN1UvSkOx7BAQXJbPeWGUWAfL1qe2GseV/isQUBeOtDb0BrpFW
         VHSpKvPO/yvjBtOjEFPJog7nCaOLBK5Tu7hPD666Z3Gxh2EVEb/mI8N4LhMQPT10CRI1
         +cCbouRt+ZEZdibi36xP2pLTEVpi7ljdezlc0/zma8F+gd00A7YDoD7wD24xq9e2/gqS
         o6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334629; x=1782939429;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1kSn3zA/cIoJ7ipzjSb5l55z352jUSBjqBw1lqnOFI=;
        b=Lt4JnwYtXIzVh8nZNxCo7miZAFqL8zV1WMrKtEKso5KCVzuutSHtZ5mtarE+dHWVVz
         dVJN3qcamkDQZoeE5OPZEfSoCzein5lpLGxCZwHsNipiETde1n6ur+BHC+7UaBnqNOEb
         FpWJ3jte1/e/RRIuWe4dE+vA98CtVeu3Vdh1M19xmWjh1PPLi0+2nLx4b4oQ7FZcm6BA
         /ju3lzUTtm9Q5W5ve247OSiisR26IZm2Dqe7xK3aF5+YrIPiVJrmf6S8rrGugo7o9Mu+
         jl/cueFX2uU5WKw0lcuXPHMo0E53QAEchBxjEs05e3lLJoHo7ArqRDPc+UdNmMr5z+a+
         8x7A==
X-Forwarded-Encrypted: i=1; AFNElJ92UlRR/gsHUkWIBOeW0OArOj5HZDsRIfMX9Nxlw4K48bUGf4pEe0zhPwx0TqWV/li/0fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84jvjkB1R12cmxGQ0H4d5wBG9GdzLOywVNT7Xt6OFmjDslPzM
	TrAjzf+feEZbfexuqh3yV4IBbeBP8r5pYMZyS5PlvmgNEkVVAGXf7aAS
X-Gm-Gg: AfdE7cmbnrcwkGCH7DG4B0Y24eAfAky6LjeafW5A0dVsxEd0Ibri1UZCZAlVfXm2O4C
	np3VnN7e1UDyG2sbp1qC/mtEm2M6QnrKse+4EdCncO6tEkzypFtSTIJF1nI8eo5HZQCzTq5oA71
	iRbd5Cazu4hy7XZ33O/5N+N6Gf8s++yHJc8pTAQPUARJRmNZ3gqokz3uLP9vWnCaaT1RIoTuGH1
	yED26/mhUwQcqnIzmtRRVF8tWdTGmtF4fn7/iDgtd3m0m7ibwEHay9UDmjHaFgdyFfKTUOj1qfv
	mZlbOwQlx4ER74J/IVIjSrsnfFwhYhiqLmbV7S3nRNjeGm1l2UyXRQYCC1gCWJji/V9LTtcj2HG
	8f9x85U866+B007u+YUtHj09J8zzC3BNgIe1aboTaSKJAePyVagFStoeqxlQqeVrVqy6+PebC6L
	JWYSZAPA2ipaCUaFwI0KU+N9QDY8ncvWMXC0eG6ZxLEUR4UkfehgII/VeA3Lg4UN1VebUOM/T2g
	Z207xk=
X-Received: by 2002:a05:6871:c8cc:b0:43d:2efa:77ee with SMTP id 586e51a60fabf-447b5e1b862mr6429226fac.21.1782334629398;
        Wed, 24 Jun 2026 13:57:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f04236fsm10151743fac.14.2026.06.24.13.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 13:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 13:57:07 -0700
Message-Id: <DJHKW8E1F6PI.P3WUIG9DZE1K@gmail.com>
Cc: "Amery Hung" <ameryhung@gmail.com>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Network Development" <netdev@vger.kernel.org>, "kernel-team"
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Jakub Sitnicki"
 <jakub@cloudflare.com>
X-Mailer: aerc
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com> <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com> <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com> <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com> <87mrwlyqg4.fsf@cloudflare.com> <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com> <878q85yoy5.fsf@cloudflare.com> <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com> <a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>
In-Reply-To: <a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>

On Tue Jun 23, 2026 at 6:32 PM PDT, Jiayuan Chen wrote:
>
> Hi Alexei and Jakub,
>
> skmsg is actually still pretty useful for gateways.
> I started with bpf by integrating skmsg into nginx as a module and envoy=
=20
> has something similar.
> The usual setup is cgroup/sk for L4 bypass (reject SYN), and skmsg for=20
> L7, redirecting
> between local apps by looking at the payload. So there are real users.

...

> Agree, just like we remove skmsg from KTLS which is rarely used.

...

> Hope not have skmsg disabled by default.

I wasn't suggesting to delete the whole skmsg,
but to disable combinations that are causing issues.
Like what was done for skmsg and ktls.
I'd allow plain tcp and udp sockets only.
Allowing unix sockets was fishy. I think we should reject it too.
