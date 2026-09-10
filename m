Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF155D888
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062436; cv=none; b=Xp01+PU6SXaOlYc36aZnQINQ/e03tHna73PABHhmTX33DAVI1ZFikrvpCgxIkmQRs6IpQnBJhOk2G+rpBrPixAMv30qYhpgF3pElBHFt24yqXmogs3ghvR63FPiUwn7IXZoDFo6/w5BwZV0AWzodrQXmmP+wUA0gupDdmtWDRek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062436; c=relaxed/simple;
	bh=ggmWy378Fm8XbzIqsmoiDfWqgCWV7miSo+Loys+qS6I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IaoXaHlR9yWOh2oBBLZCtFelll37AfHRctHgoH9ZLG3+lwemjMNwkKzgtk+cRk7Cg2aGdbeCEVgV+jisGHne7wyhBQKPg5d78iNIR4kOTxUtq+n9rdNaZy2h2mzX3XDI2CcwSC0S/tQeXWtbdSj8AvMVa2gEMElgioCiypdlto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HUHwSk7O; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="HUHwSk7O"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso9418354a91.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789062427; x=1789667227; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HAvA87Et5zN/g6j7vdy1Ap87pfUn9R+X0a3IzOHRO74=;
        b=HUHwSk7OVdy7wpzNCyqFSt0yxKwOynRRXEBnkyUtOGsGl5Si3uamMpwuqIA5trg7Hs
         Mr85LLXnSJseku++pvzOVjuvnNBC2p2FsAZgMm/a9thop2FTNDBpsLdrClIDHuW9NKzd
         l9dPe+TT6zH4vRn/x44lWIMCXqvLpV7iiTBwaoIHZQd489fvGazRkxRek3cZveM+l0p8
         1GSlRPDslRjkUgIQ8umUr/fPzSDkjjnioCpgJxzcjSoibPc8DJQ3Rt/yVqWq2bzeuaiE
         HxFEZ3gTH+AprS3kP66SXQjGF5dcGm6bID2iGSzoMAMpmhUstuPzLeDPfiaEWPtOEhQa
         +FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062427; x=1789667227;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAvA87Et5zN/g6j7vdy1Ap87pfUn9R+X0a3IzOHRO74=;
        b=QV1D+jxcCIxM8w7yFVNKANTTVt7Pke351QeiDWYCjsQBNwA0r/Nzesd5r8HtvC1s2d
         fp5bY0+e4lCuI4Ffc1C1NMQqFW5TrpTb83Utt6nkv5m+em24GVaaF+TewWt8xZFIozuS
         jaSoEVw4c9YZETKzCjrzfdGqLpG651xHruMgN2imHbYYhuwii12gwg7Ucjw6MTMM0LiE
         HRC1c88wEdLJgHvZySrqslS3QoOsEmjaT0rL0sUmIynDfZ8fhaX2tUczuI+2LIMUeIrC
         RpA15pJbNFuoUCOZ0G/nyP2smWoB9MyIUeu4aOUbef/i1i0h7tLWyN35UnlYIUhJoE27
         ruoA==
X-Forwarded-Encrypted: i=1; AKwUvBwJ/5ka2ypJFyrR/1gUQ6lyey3l3Tg47OAZmxJ+ZeRyfD9z933ZhxjCtbp9YhkIcl4uiUo=@vger.kernel.org
X-Gm-Message-State: AFuF++m58TeSNIGTNNhO2NMTqpRFg5xUtyQtwC4xdrDRES2RWvpK7lkw
	y8P1bjkfxsR3Ce9iQYbMCE2p4hpBTk5xmz+Ev3VHyzVjU1vQuBI1OjlvGTD9YxLgizM=
X-Gm-Gg: AYBFou1LlN8U3g0hD9wEhMGX3OBcPaueviP+XjQ172oBA/scDWty1yV9H39F3WwJt0I
	G+Uc2Kq+55TTvYqvg5CCDzkYi63JUfyWsxHNOCAm+ojy3ZbzJmHsN6Z96uCjCV8Ytm5l/YeWEGg
	IKHaxln4EPSW8t/5Q8u0UjzGBJ3xehmDoZ3gpxjEvRNWO4ukfglfXaVEwHy4cINDzuEzzGXqsCn
	l/hHT7FV9bRTurqhqVw6IzpJ1DofAW9PT6nWkb5vTASl/+nOKFY/p8RqlcrGKgZMHvKBazXfCly
	D+okVjG0J8uG2kz90+1+cFEOdD/NcIACO2qE5d8YQW/V1dMX+4Uzr/etc7iKFRkgGIQdV34iEAF
	3EXhyPpSFeU0UTJ75iq5YtFwpiwYmRNzgoVtDEY/MzW1f8jEKGXGQ3ql4Ay6wP3rtsZmQ9Ke22q
	wmRMnBJJespQrqxLl/IZqoVWjzGb7Nwz+duWm0YkLI00numEK1q+G/qBVpLeHZhjsO+BBJKvKoN
	sJM5vfjk/2Z7bi7Yva7TXtpg/Hn
X-Received: by 2002:a17:90b:274e:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-39b2610fe62mr64208964a91.9.1789062426873;
        Thu, 10 Sep 2026 10:47:06 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e60484sm263339a91.4.2026.09.10.10.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 10:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 13:46:56 -0400
Message-Id: <DLBTP43WDS59.3HN832U7195TZ@etsalapatis.com>
Cc: "Emil Tsalapatis" <linux-lists@etsalapatis.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <horms@kernel.org>,
 <dsahern@gmail.com>, <hawk@kernel.org>, <razor@blackwall.org>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nikhil Ludder" <nikhilljatt@gmail.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
 <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
 <178898653497.1776876.10402414041023036972@gmail.com>
 <7f3e237e-ac5c-46af-ae21-8b437a099fe3@linux.dev>
 <178903991209.1916825.3991149870565892141@gmail.com>
In-Reply-To: <178903991209.1916825.3991149870565892141@gmail.com>

On Thu Sep 10, 2026 at 7:31 AM EDT, Nikhil Ludder wrote:
> On 9/10/26 12:59 PM, Jiayuan Chen wrote:
>> Yes, no deadlock.
>
> Thanks for confirming.

The explanation makes sense, hadn't considered where this is written
from. No need to adjust.

>
>> BTW, if an IPoIB device can show up here, dmac is already truncated
>> today and the packet can't be forwarded anyway.
>> Shouldn't we just reject addr_len !=3D ETH_ALEN instead of open-coding
>> the copy? Then you can use the native function instead.
>
> You are right, and it is worse than just dmac: the line immediately
> below copies dev->dev_addr into params->smac with a fixed ETH_ALEN and
> no addr_len check either, so both addresses are already truncated for
> such a device.  struct bpf_fib_lookup declares smac[6] and dmac[6], so
> the helper is ethernet-only by contract and a non-ethernet nexthop is
> already outside it.
>
> I would rather not fold that into this patch though.  This one is a
> race fix with Cc: stable and no behaviour change, whereas rejecting a
> device that today returns a (garbage) success is uapi visible and does
> not belong in a stable backport.  Would you be happy with the seqlock
> fix as it stands, and a follow-up for bpf-next that rejects
> addr_len !=3D ETH_ALEN and covers smac as well?  I am happy to write it.
>

I think this split makes sense, even if there's the churn of adding the
fix then removing it to use the pre-existing helper. It's just a couple
lines of temporary duplication. @Jiayuan wdyt?

> If so, which return code would you want for that?  None of the existing
> BPF_FIB_LKUP_RET_* really fits: NO_NEIGH is untrue since the neighbour
> is there, NOT_FWDED is vague, and adding a new BPF_FIB_LKUP_RET_* is
> uapi, which is another reason to keep it out of this patch.
>
> Thanks,
> Nikhil

