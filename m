Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C03B47F5
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774001; cv=none; b=Z8Yxsy1dyf5szXvM6J9heME+xpGs0i9ULpew2pOD4Q4wV+1dYCK2IjFBos2XrasjnFkGf1HkcPhMxgzjBxC2n6kwiikfWXG+VFR1MqMjhoGYCxdbrxTPQeUewsr/uknNOsaQ7eG5E03WC6QTFLcH3CJkvP+yst1e/EKO/Qn/hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774001; c=relaxed/simple;
	bh=18ku8zJSegtuNeFkydPWttYoVDG0vlcQI6O1iN5ADdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uU7NQW2bfNgDoOQYNzzk4AeO9MfgcXYz9pZnbx9FJyfMAl2vBF39DXX3VA1iRscCFO0uTukeK5d87+MLM5dibJddsXlfNVgug682MU3N3aCkNXNplqM59VIBcyr2fyHs17sZCUuHoAxGrcEQAzSTHUYyctWqYwY0cVGd1tiYG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOczt6wB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9hVX4pq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOczt6wB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9hVX4pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781773997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YF07RUa16RTBhVnigCSc1VoV/EXhQAbPj8MDNoWvZX8=;
	b=NOczt6wBosWHFGbHYZdQEt/1w9dsVGFoz6pCZck5pqQlT0Ckyn9GXAVNIMAIxvRUSn70oA
	Wo6YDkHHoZGEY3ZSQMscM6MnkZNswE0H2ZnQdRA6v4A5SkyrkVrvlpUhAGW2sX0qiwljka
	eKzIC55JFWxq9zfjVNjAXFMEXoLjIvc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-G2UN2CJoPWqE9BfcPJyFoA-1; Thu, 18 Jun 2026 05:13:16 -0400
X-MC-Unique: G2UN2CJoPWqE9BfcPJyFoA-1
X-Mimecast-MFC-AGG-ID: G2UN2CJoPWqE9BfcPJyFoA_1781773995
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ae461f8dso4635905e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781773995; x=1782378795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF07RUa16RTBhVnigCSc1VoV/EXhQAbPj8MDNoWvZX8=;
        b=G9hVX4pqjDPbNsQdVVGJG2pFDmQAYtUpaOKGmE9q//6T+QU6rfK7esaWKXTdEtJUgT
         HLFZDSJ3BZMYVzHoEN+jvicAN6Yxb7voOoPdA3AUZW94yHJsMmfoLE68HjN4PvGR+4oB
         kY7OUabRM8YNmJDLBKDntTT7niiTWLkVJxbX0nFS5oAGv5t3Mo0G4HBO2v/rtPejDLT9
         3FndENg4z8xpmgbLrNq3uRKWyLW3AnYtY8wpA0bpPpiFJWqMek8Y0OI7/2flpkHAMqN2
         Y9/sTjfyAi9btrSH/WQ9irmUZApyKeBsWC4WxomV6BoRO4ABZYpQreL+8xBVsrSQaOZG
         Dx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781773995; x=1782378795;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YF07RUa16RTBhVnigCSc1VoV/EXhQAbPj8MDNoWvZX8=;
        b=m4ugtmQ9GWVjYXSK6FNG9+PzeFuo/nBJDuU/jF9Z4XN7//fMTR9IqP7albr3mVyR72
         mEqBdFOhuA+SyHPabsQlpZtBm+LK9uKGl937WN+eULc1zhMvrdYXRa+luxr2Ke8iTKgH
         cEIWj39hXfmVy/3Q1VVkiS93rzVwDq95kiSMdXAPcu7gNxQ1juGs2tA1sAE0qLUcZr6B
         2Ad0ZRQAMrmn3DxpCmWLy0jV/qVph5viZ/sFXzO8rhqDHw0AjSrxhp6jJGT2V4ZAEMvf
         0hmZspLmpZ3L++sygWvJMic91ozd1GDb0hQ2SKbtMi2dGxRctLQven6G56tVbAwvmtAZ
         grDw==
X-Gm-Message-State: AOJu0Ywu9yxUmYCfid2WeBsrlqIbriHzyxXRwe9ZlH05DiIcATTOJgJD
	i6KI4Tn7nmzZKYa9rB1F92CNVYUg4FymqV+mViEPnJ5zFvuUjFdJAy0DdFVPNxTd02V99nD8Iv7
	zRGQPZwtOX2iY4H1q0DihXs+BeJ4cDfzW1F1mWHLOD09iSckSFf1aNw==
X-Gm-Gg: Acq92OGiTz3IZ08AaaFQwrGMx4WTdWlhpVnQExtuLTIhWJNfjdI6wOXg399eNq6JIHS
	MV9yE9kZcKK/sqMpiwY5WlnAfyNl+YlyjjLpzvspIt5mSuaeJ5KBsEAQFJiMmJI4MUB/MciPph9
	eCRQzZFzwMvDcouMFQc2LGdEBUciuN3qP8KelKvjpxMDKsF/Rd2jsC43AkNOK79wS+FVVjw8v6y
	fcD/RbOzQKMvyhhP/Rb+k5P7CocDMpiq1NmIN6NMtsoRs5JjpHBq1Hf+7jO+Pkh2Nhb5ORc4H8h
	57Bq6dUwBd4u80hCoek/ilk7Ie2ctjIj8i5eE7Q3s1MItieJVY1OLWF+nHHw0xyA6nJ79F4qD3K
	MteApMxsVWgZ1GmLlW7F6MtWpxPNwVbQBBYPSZg==
X-Received: by 2002:a05:600c:3595:b0:490:a964:14f8 with SMTP id 5b1f17b1804b1-492381e1c96mr57598805e9.8.1781773992684;
        Thu, 18 Jun 2026 02:13:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3595:b0:490:a964:14f8 with SMTP id 5b1f17b1804b1-492381e1c96mr57593655e9.8.1781773990369;
        Thu, 18 Jun 2026 02:13:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47ce3sm253587265e9.6.2026.06.18.02.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:13:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E9E7A807837; Thu, 18 Jun 2026 11:13:08 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 eddyz87@gmail.com, edumazet@google.com, emil@etsalapatis.com,
 horms@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH bpf] bpf: zero-initialize the fib lookup flow struct
In-Reply-To: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
References: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 18 Jun 2026 11:13:08 +0200
Message-ID: <87y0gcfbyz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() build the flow key on
> the stack with a bare "struct flowi4 fl4;" / "struct flowi6 fl6;" and
> fill it field by field, but never set flowi4_l3mdev / flowi6_l3mdev.
>
> On the non-DIRECT path the lookup goes through the fib rules whenever the
> netns has custom rules, which a VRF installs:
>
> 	bpf_ipv4_fib_lookup() -> fib_lookup() -> __fib_lookup()
> 	  -> l3mdev_update_flow()   reads !fl->flowi_l3mdev
> 	  -> fib_rules_lookup() -> fib_rule_match()
> 	       -> l3mdev_fib_rule_match()   uses fl->flowi_l3mdev
>
> l3mdev_update_flow() resolves the l3mdev master from the ingress device
> only while the field is still zero. Left at a nonzero stack value the
> resolution is skipped, and l3mdev_fib_rule_match() then tests that value
> as an ifindex, so the VRF master is not resolved and the rule fails to
> match: an ingress enslaved to a VRF can fail to select its table. FIB
> rules matching on an L3 master device (l3mdev_fib_rule_iif_match()/
> _oif_match()) read the same value, so an "ip rule iif/oif <vrf>"
> mismatches the same way.
>
> Zero-initialize the whole flow struct rather than adding one more
> field assignment, so any flowi field added later is covered too.
> ip_route_input_slow() likewise zeroes the field before its input lookup.
>
> CONFIG_INIT_STACK_ALL_ZERO masks this by default, but it depends on
> compiler support (CC_HAS_AUTO_VAR_INIT_ZERO), so INIT_STACK_NONE builds,
> including older toolchains that fall back to it, are exposed. Built with
> INIT_STACK_ALL_PATTERN, a plain bpf_fib_lookup (no VLAN, no DIRECT) over a
> VRF slave whose destination is routed only in the VRF table returns
> BPF_FIB_LKUP_RET_NOT_FWDED, and resolves with this patch. On the default
> config the lookup succeeds either way, so ordinary testing does not catch
> the bug.
>
> Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif =
reset for port devices")
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

