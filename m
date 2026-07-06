Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2630FF30
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368060; cv=none; b=eBl0FfBCKb9qRS6oO5T5uFmnzGEoCX4BIuJl6VnXDPO4VuvL3T/rPWmbkK8Cy4qNgzXf4MmeOyIhDwxua3+e7TAlSayej2s1uAx9/maKUQjfQLTcxLxEFbsfWdh3mi+OWJz3Vayhd5nlKhoHm8jRYitIOSo6jdJIVJwxLiMBWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368060; c=relaxed/simple;
	bh=Bn4Wn0GSYZIZgIEZ5ntKigY1VQrjvtTEoGxji+iVLx8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ofI0rKpgXdC/7ZNJkoLHqDOWgU8afTDv9SV3eT81nt+XHyaht9AzdoOQwH1axLX+bwxUJzv9gbm7nNJMKNeCIBHwjdfcSFMvFMeK/hnbSZseztsNnDsF7Q7ZJhCA1STt8XNsvmNOZ/AGGHfULMcf86lUYfAUIA52Pf5fOi/1BfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiSwyHYX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiSwyHYX"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3811e59df58so2096443a91.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783368058; x=1783972858; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VIf+zohqeDaZywcmZWeYMtyc4MEDifAz/egCRkrh6AM=;
        b=HiSwyHYXuXpCTq21Ed9uLQF2gfbf80+jtXt78BOXXvwjEWDjx6ulzU1zCNWvT3Pkut
         Y2na8agDKhmivMiVJa8MdV2BDLdW1wfBHmwuGNh/K49HVPvBdiVX5xuFhbIJCON7jM/P
         PH5J+TN7sD2UJSGqjcVlB0/hLN6VyfFHZ5NeBu6J3IGW6D2o7us0DAnHTZn+qRqztdQh
         nAZKcwglPbcQZSO95lZW4zlFIj4eG4Z1RcYvNjcQNhfoyHhVlUkA4aln1omwu00MH3Cm
         iIs5H2YKZvt3T2fEe2mCywK1m/eD2aIGEPnKt3pw3KuPebIrX2A4jqlSl8ouzaK30nLR
         pCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368058; x=1783972858;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIf+zohqeDaZywcmZWeYMtyc4MEDifAz/egCRkrh6AM=;
        b=R9j411P63ySrauBRMgMoRP0D16idNwNfyMvs8kNgpy+kHAv87lQV4t+jYObp73uXmI
         CZnhkLCrpVv00Y1ziwZ8pnosnnhYuFburXG2RyqI6Z8scrtecmfO/CxOEE5r/AyR0Obb
         s4sLcxEcmT4PdzD8EcnAuPfmljysLHEWNHSwoDT2SG41LS0Q/k2dAQUQ84IbbusnkUzG
         TLQz1GwGYeZl97uOY+GKxpgSB+7WZCH5oAU4TpsFcL5GcCauv6Qluf+cC/xYqs7CUF3I
         w5IsfmYAtF2qCosbzWIZPc9G9R9QbsrOl/KbZ4WA5X1a31h7t2jtcnnzt6mDhVurITCZ
         Ch2w==
X-Forwarded-Encrypted: i=1; AHgh+RrZ9KRscQrJaoEMOjlk76UKSkiR0MxkcaBL17ux5dUqlAB2NQ2cWSng2nc21fPXUvahRro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jIVQSNXNTrBJ2tLzjnYviY/03Qi+RFbYaPPvvFWZ63hU1mfz
	N2V7jwwV6D43NOcBRCwKzeTnYe2a3ZZbgNR3BAsiwyHPN2U7C151J/ga
X-Gm-Gg: AfdE7clUGmkftNKMW+8MRBzyh8yLzB5Vkqj1BTAnCYZBAKiBniT4cKrKUPjyAsUmbb4
	tOSWznRyqS2t3hpV3ogCky9v/z1O3zmrTc2/N1jhNzviswU4jTM/SUGl7qu1mN+/XjolsDCLe/9
	6ST9OuiuKJxp2eiAbdI8MJry4V2j/MTThotukdcMias1wNzuQEvY6wp/WI2KI2lE8cDtURH37T+
	an1PgVGX8Wu4eGFeLMfDWeueqElXlx9UUHriekTFwFR0hqajzbb634sIe0yXLXVwq4baNx37hD4
	448Ghs82QC5jetl0oLWoSEZIsIrlxXEz7RopxZNX+m8icL8OjEzMMyFmO5o0nzCDcxAi81Ex0aI
	hfYmCoDgceEk1dKSS528jFd1z1fPJIiKz7DBuoCSZUSkd7IpZYHCbIQ7MrkgUk9JuU1pV6jZ9h7
	zP90sOG9u7igmQbIgiy/CIvlqUpstL1LWZLn2iUbkRL2Enx7zz/SNIQjlrie7Drxe1Xl7qLA==
X-Received: by 2002:a17:90b:1d43:b0:380:540:d499 with SMTP id 98e67ed59e1d1-38754ea7328mr2054607a91.6.1783368058145;
        Mon, 06 Jul 2026 13:00:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:612f:7084:be32:532a? ([2620:10d:c090:500::1:55b9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311561dd3a1sm19197214eec.22.2026.07.06.13.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 13:00:57 -0700 (PDT)
Message-ID: <559673fc207097ecd08f1d7e9f684fe1e9f2a581.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject negative const offsets for buffer
 pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, 	mmullins@fb.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Mon, 06 Jul 2026 13:00:54 -0700
In-Reply-To: <20260703035137.109608-1-sun.jian.kdev@gmail.com>
References: <20260703035137.109608-1-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-02 at 20:51 -0700, Sun Jian wrote:
> The verifier rejects variable offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
> accesses, but it currently accepts a constant negative offset produced by
> pointer arithmetic.
>
> For example, a raw tracepoint writable program can load ctx[0] as a
> PTR_TO_TP_BUFFER, move it by -8, and then read from the adjusted pointer.
> The register is still tracked as tp_buffer(imm=3D-8), but the access is
> before the tracepoint writable buffer base and should be rejected.
>
> Check the signed effective buffer offset before updating max_tp_access or
> other buffer max access accounting. Reject negative effective offsets and
> use the checked end offset for max access accounting.
>
> Add a verifier test that rejects a raw tracepoint writable program using =
a
> negative constant offset.
>
> Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---

The commit 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
delays the tracepoint buffer access to the attach time:

    int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp=
_link *link)
    {
            ...
            if (prog->aux->max_tp_access > btp->writable_size)
                    return -EINVAL;   =20
            ...
    }

Called from syscall.c:bpf_raw_tp_link_attach().
Please modify the test case such that it exercises the attachment logic.

Also, please keep selftests in a separate patch and make use of the
full 100 characters line width limit.

pw-bot: cr.
