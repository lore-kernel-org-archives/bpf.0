Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621336;
	b=mZ8G/42lw7V8o0VIr59rVVC1HS1ifk5FU5uahT8s/zkcabQETogbl6FdH+nbCjXn7XeO
	 /79eZxikMG4MguGZrQERqdHMHUuj15YdACQMCJu/jnKnqrY+BpOXQCBLJLogEHv6ICe5c
	 5WisJE+NjQ1EKmR0NRoMv2+8t/zZLZOfojllxaOcwlmJ/ZqqUCVPzzHVwtAzZ5dLfiLff
	 Qec3K/MQc/mHbnuKQ1vp2VpNqaaHzLj/o15SJBwbkCGbRqF4SdHF5rnaFeT8+Acihq1Ff
	 AwcHRTsIQSvqn+W8wmCDV5uD6Zp+v4eDXPJgQ0rSsoW53L6gKKEcPGExBT5miDSidSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=X75+GQQC3IRkNRWLW1BMyclqkZ3rSaO7nDY2+I8QOqI=;
	b=cKTEzdZmFVTtepmrtd28G+9C4vMK9Cvgzw3SmmIqA1fBQfp4HobszchEasJ7E+F/TsRI
	 KOsdBok8YvDl6wpT8wmKQ0ZvR7P85HEuxPg9/FFZNelHfkeMWGVRQitCFUkp52jWnauGm
	 ItxVLgQNy9mjhBw0KLidQk/CSWXhiVY2NXxFRsJoa5qZxep2QYQep3m0m/sGbgW3ouaeZ
	 IdLS6JgfUUOUHSlGGriDdl2yBQfOe+dUo1FAUAdIBgVoEOh9XH8L1tDAiZvAHJbAsW1bw
	 ICjodEdh7PKGKNlDRWIMzZEZZlDFKEmC/koOWZSF6fp7O0M54Pc5bFqhmsCvz+olgQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kUW9NqIY;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0172606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0172606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kUW9NqIY
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e812e2b31bso6469835ad.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792621335; x=1793226135; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X75+GQQC3IRkNRWLW1BMyclqkZ3rSaO7nDY2+I8QOqI=;
        b=kUW9NqIYXe9NKEpB+oGbOkhxSvEXzL+rhtRUJGRhOHAZ0uF2IpBwxaX8NW41gHL83H
         fM+jnp2yTXL8Ul8OD8RTQvkcbzMjg6znrEnzeJKfhvJxjD5tQm+SGwcoVjpk3k3yd4bo
         zZ8GvkK/s90kh09KbtlCEaYU8WEnQYWg+l2VjZnhkwmvLy6+5LDJVWxu2aBSzqLvPoOr
         dwEnyTBanajGmM+tQY6qw23r3vt5u+aZx3N/uYMYQJK77XcSFCTgT1NJlGHDcf2Srqx3
         Byoykktm4+2dNmTljRHwXjXXO9faRDXPMUmckz4YAIhn7T/UOiHc94envEWb2SOEtuPp
         qElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792621335; x=1793226135;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X75+GQQC3IRkNRWLW1BMyclqkZ3rSaO7nDY2+I8QOqI=;
        b=t21A2NpHZ6vcttyfkSeOdP3uBGIiSJMoUbDSkj869fhQUzCo5gtAxOeuaeiljgV+I5
         tWS6aBsg7/TjHO1XgZaTV2XJoU9ckctP3keUlgkuvjCLBZsdWBRKXdSsZ8fIrIWpcpWh
         x5Km5IWDkcRvdQG2IoARta9fNfVvlInwdFy+xxygVZ2z6SP2S/lvc13x7lg+OvSyAORj
         ghXjdYoX2qgBELmf6qhtVfRxKuMzYdmcMDdNiPh1Hvte24/pfaaSP7Xr02Yf8F7fOOdN
         fl3K/pyB3pBFDHEYfx6p/KKxvmnclrp2gahcMTAJ+89UoaFsJZOBQPcGio554FyCd9LP
         /VRQ==
X-Forwarded-Encrypted: i=1; AKwUvByxFQgto6rh3URC9+bDZI0e+X9RBhRoQYO9XMBaFXRcbj7VjLez3oFIrTZwWxYW+a/Bbug=@vger.kernel.org
X-Gm-Message-State: AFq9FYJawfU+tRQJuYqBx7pKsNItFCtQ8T95zJdcDNLiHPVcp36u67vo
	DhVMYQewI6zTjaaPXmQjHD7a5a2KdeMkSat9Eiq3mCKh6o+obVF4ZbtchCmD0w==
X-Gm-Gg: AYBFou3OKquPjSm99YkmazCm/SwW3gPk/Fp1e3XI0SQXNOQZf+6Sc4ZnPw8i5OqSLNn
	NzfN+DgtxycUmdE7ruJInsDM180o/JVrEssqlpV679Ny4vaA6v3vYIAEd45fc2ByQyzXwAyC+wN
	cdYDvCy2kCElxlnMPNMcIC/q38KcRNePh0hwiR9wsGfno4p2XB1GAeE70QNYNGuFDmQlbfbGPkF
	VDHksnwT/0u90rPe+dwyCebQDRkU/gEq6uleJiyp0dZ4KonecW64R3gT5MudkDl/F2ThI8mNoPB
	c3m1P/tjKPzh1HMpNlXSJFGtkll+ONq04LgAKoPN/WyYiggF08zBVMmZM/OviNsjD++BE4WCfVh
	rHI4JK+/V9P/vgaRONNpwyqPvjiEqp918loeHCChJ6rr7F1uVSZXWEprT82rEdVat+fWJ+KFF4L
	mule3jZ8/zbme1szArqWFYlwPkMV+XF27Pd8SFiDJh1MjLmx2HEZ+3bMwycx0BAefhd8qOOQ78A
	gNoG9TU86zcOsbfxaFNjJdXpNxL7aLxY962dF3JpvV333VVY8SeoJ0pwBpRA2kdt9BirhpY8ZX8
	SCO9fcM5/T/32alSPM+6R+lF48yqcfnowOWJ7X7vzdPnVx3ZingbVh6YmKVZ
X-Received: by 2002:a17:90b:4b92:b0:3ab:ab5a:ef06 with SMTP id 98e67ed59e1d1-3ad86ccd949mr2940108a91.12.1792621334751;
        Wed, 21 Oct 2026 15:22:14 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4890bb2sm1201645a91.1.2026.10.21.15.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:22:14 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 22:22:13 +0000
Message-Id: <DMAV87WUFF7M.1PU3M3CCZJDQJ@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject pointer operands for 32-bit
 recurrences/latches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <kernel-team@fb.com>, <yonghong.song@linux.dev>,
 <memxor@gmail.com>
In-Reply-To: <20261021185609.607075-1-eddyz87@gmail.com>
References: <20261021185609.607075-1-eddyz87@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 11:56 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> Fixes: df4761bd441c ("bpf: Support 32-bit linear scalar evolution")

sorry, few commits were dropped from bpf-next.
It's 32e962577d2d now.

> +			/* 32-bit ALU operations on pointers convert them to scalars */
> +			if (coefs.zext32 && reg->type != SCALAR_VALUE)
> +				goto cant_widen;

le64 does the same without zext32.

     r7 = map_value, r1 = 0
  l: r7 = le64 r7
     if r7 < 100 goto out
     if r7 > 1000 goto out
     r7 += 8
     r1 += 1
     if r1 != 4 goto l

On little endian transfer() treats le64 as a nop, so r7 at the header
is (linear r7 8), while check_alu_op() makes it an unknown scalar.
At the backedge r7 is a scalar 108..1008 and bpf_clamp_scev_regs()
intersects it with 0..24, the offsets of map_value at the loop entry:
  verifier bug: scev clamp produced empty range for r7

Should bpf_clamp_scev_regs() skip the reg when
	entry_reg->type != reg->type
?
