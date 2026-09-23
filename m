Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145956511C
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190986; cv=none; b=ShnUbLWAlK0GX/FkXNZaucpCWBediv0pQHeQFjPpaEk/PQeEVVV9SHeodJCkNVU6hv7jpm4NjFQJ6ATZZTLaBYkPzGoqvqzO+HzeX0I6kxfor3INN4aMtYe1gEbUl3dlBLH/SEHZmmNGlGZ3kG2FsWzaYkcdLA5hZ9aTyIyXHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190986; c=relaxed/simple;
	bh=pPVSrbmMX/z6rBAvPxjmQT1flVcbmQxE/TKYaMzf7tA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FpG2RI/DaQmCqn3bEI1sTwEX1zLW5ZBwHykpk+QRyEBqRN7myTwQMCP7sp3fBUx8TRBw2hAqYgCHIN9gHMdOFGB6Ls63qFUI4w7tegKq7Y96QXzg4Wls5ZLV72KLcSagbQ9HA/AAOr09N4APVpBwoxWCm7CcJKbG6bQoNV+iEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmGl9K6n; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmGl9K6n"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04f7f2so1497007c88.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190984; x=1790795784; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pPVSrbmMX/z6rBAvPxjmQT1flVcbmQxE/TKYaMzf7tA=;
        b=XmGl9K6n/GqLYzTQhXZOfPoTdL7fnVb0zicfd+JLtR/zA4VyoJej4oaSo1lq0Egejd
         0U0l9/uf2x2YwPB8LnKHEPaRB+JtBRqy8rWEm9GZEKedYBx5+W+nGDXCALAL5x9ovbrS
         TbHRvVl8jPI5/TAlWRhHSRZDbhFGsVitPmJyKyPWcRBiS8iZYg1nw6rvHgScIV6gTpLJ
         LoHLHxYhPKjYIafkVg8242m5O1C2hFi2wZ8GNctUlkiH/gT3i7CnKOTBxBXOT3bhzcHp
         KjGbSZLRkV5w31JrtEEdmdA4h7yt2YBgrr9fbn7c6s4kY/IuiG1064WUEHb0xEte1E62
         2hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190984; x=1790795784;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPVSrbmMX/z6rBAvPxjmQT1flVcbmQxE/TKYaMzf7tA=;
        b=yF3DE2RflqkeuHBTfttcwv4YtBEddMDJK7E9KFL6vGlQGgt1jhOtTo/KKCQWUG6X4X
         4KF4oetTPoTprrhgNAfhmJZGmOq7QsA6fy506w/4JMj/ngiGPyp75nPd9aycgJvPTkvD
         oRbUqpnr6Ort3hido6NSHSusZVIAR31jEcB7FtAT56/kaTyze6Upf8lIjhfHSq3nsUpZ
         lN7lpR9o6Pj4jrmk+HZvmj1kgzK3/u49yLgBFM9Ac4vhLkSCreVEjNB1HIkILUuf7obj
         mAFVg4eBBdXYxwhaiIPpleo+zD6bYcYejUcMZPRNL5EMCXX7QFWL7x+a07tkPXE+YbYL
         MpZw==
X-Forwarded-Encrypted: i=1; AKwUvByVv1/H/HX5OTJiCctPLvk1grZ4TgGfJQteq27K2BYdEWvBuLV5pmJhRP462jhJNC3o3zU=@vger.kernel.org
X-Gm-Message-State: AFuF++kZSaEdPEbRy8IUEYvxQhVD11KAl3RynI/93XDb4cfoz2lgPTl7
	oiYQ1LfaxQnG4NTU9fF61lk1kbyunSpTD43AYloNci1Z9VuUoXzUyKBQ
X-Gm-Gg: AYBFou2Y6dP6c6HCOxJ9EB2hX7rQwuoudDDH5TJJlPYWIFxuKunMSR45IvfuUmJe+8I
	0qZZg7WIdp8eUBZeSVReOmQ4dBry8zj8F9yOw1FhGYUM392C/ejncP7uswIkRHhEbqgClzLDDuN
	h0aXZdztyih8tCtHAnAGkd7u0Fy/7fHb7r0tFNXFC1SYvqhOLqaGkVAu3m92+ZfQIzQRniHDG5W
	gqHwr/wpJKuPm2OMz9LiT6jDEzvDO4Zw48oMJaze34CNWlXA6TxBdtyC1pH9TD8oTw3JfRE0FUT
	yF5A/haTcPOrHoZbIFes2L6h2DDuqBiLIe2RKvkAV26XyzfbOVjDEdnYYlFn2UnIuARQR/Jpvw+
	Jvo495vlsQSGOCXPkpFmS4Qquamzumi20PZ4t+zyCP10niF02GFk0ziMfKCknpr3Z1vYeWvcZ8n
	jNNTiaYWlRtDh+/7NaQ5eSMDfEirdJzXTDTKLtyKeVLowrmxACDaf58MA76+6OfDw0aNVvZE0jh
	Av8gL8NTmpDo7HQHHTHEnHoeZt+akcm2FfhOoCVRW8xH3dY90PlI5GAQg==
X-Received: by 2002:a05:701b:4507:10b0:144:ff51:2d5f with SMTP id a92af1059eb24-14503fd76e3mr90215c88.33.1790190983757;
        Wed, 23 Sep 2026 12:16:23 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:179a:a128:9d0d:40be? ([2620:10d:c090:500::5:48f8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98ca0edsm6986921c88.15.2026.09.23.12.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:16:23 -0700 (PDT)
Message-ID: <1418327970d80e6f59205136cf304d97897bfd9d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 01/21] bpf: Pack bpf_insn_aux_data flags
 into bit fields
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 23 Sep 2026 12:16:22 -0700
In-Reply-To: <20260923045851.2415163-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
	 <20260923045851.2415163-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 21:58 -0700, Yonghong Song wrote:
> struct bpf_insn_aux_data spreads its flags over three places: seven bools=
 a
> byte each, a u8 carrying three bit fields, and a u32 group with 25 of its
> 32 bits spare. Put them all in one u64 word, alu_state with them, and mov=
e
> orig_idx below it. The structure goes from 144 bytes to 128 with no holes=
,

The bot is right, it's 136 on master and 144 when v4 of this series is appl=
ied.

> and 34 bits are left for later flags.
>=20
> No functional change: a one-bit unsigned field holds 0 and 1 the way the
> bool did, and nothing takes the address of any of them.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


...
