Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3E3A168E
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713309; cv=none; b=O508ZtAAf9N6D2Rk4KWU4Leji1M+nb7bAfvXr2iggEhxo4iFh1CQtYpNF8zmkneQp7oo4KWZOjzJvL6SYq+n843xa8ecmCjeSe4fDY95NIZNsf1wJEVNLHpgO9tD8T0z9TmecllZ7+kEe5uxprkUjs1hjtWyT9botiq6ZWMWlSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713309; c=relaxed/simple;
	bh=lMzKnAgmBmcJ4GYSzOW/Z+r5p493XcZdckXqRh0flFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FeEqqqZ9kh/62f/vv4AGOkoz060uUVnZfhbbM5E37hBrBA574Ktn7N090yuf/Jn0tneQg/xd9VrTDbheDMj0x/uKw/yep3MYcYdAwZIMZv654KYebiJaeToB0jkfbW6mlm5DDNi1BPlSDCQen6n2FvCSCS39eL5yryqEJ6zNU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ove/ZwkH; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ove/ZwkH"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3428f70d7e7so2721634eec.3
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790713307; x=1791318107; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lMzKnAgmBmcJ4GYSzOW/Z+r5p493XcZdckXqRh0flFM=;
        b=ove/ZwkHVi0pO7KcyjSC/w/wW54be2rs5fwrTgDixkZXXSJpu8EzPSFU+8GNlqQ6n5
         IPYxei1kSU2LceJsLMNu5dDXVgbYxOqvCp/hgPqkVGn2U6tQAGHlD0G3rlTpEEuqtcZG
         NDmURWNipgQIzP9riIeThGaOd/7kzeoakYWtjtzbb7/Po9tiaH2sTiKw45k7X+WLcUd/
         AaPLbT6J4fgsm+Xq40Stl1IFY3z3jwLyd7h2DqFgjsuTcTzAF/boyu4q2PK9vmgwssiA
         ewwSprJUat/Pa1jbbi1QiBHeCZJa+OcLqIlRgPyhkVBlzXkiKwqq1+4d1a6kZEE+IBlh
         AbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790713307; x=1791318107;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lMzKnAgmBmcJ4GYSzOW/Z+r5p493XcZdckXqRh0flFM=;
        b=stYzlAJmzSYP/d0RR9+QvFMTaCS/xdlF/Vz9KAonuVNm6QkOIwH6ZrxC/uDxtFmU2a
         mAGFa/EJ3lFURBTfbrFbk3I9c2U8KTm0EXH6WagVa5vWaISHnW97SlLNQB++UXRSZD2y
         4005NFXGycnrXmZJmbOElOSOpSdHbmXxPjS3U8GY5EbPN2xsTFSNb0zSL2NIbFn+yfmz
         TxG+zNGHVEkK7irn6eD8K1GoryrbnjGHY3wcRKVnF/6dUh3hXVpIvyLgx3TNkpHTe0Gk
         ytR6tm/TQgU0nqH4jxPbVPuy1BquzSYuA0zIdRemnWz4o08I1DcF5LDM9u3JJN2QaDbW
         gYgg==
X-Forwarded-Encrypted: i=1; AKwUvByhIswk+TYDhwRkEBCZMk78uWrfQ2328+NLy+dbnjbvXKkJA1Osu471k23b/E4bOAfzGYQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4dNi+IEVjSuY6o9NU+be5FzjdX8eaA5qL6OSVLHqUYI8H+BT0
	bn4sdPHP6M6D882uxMc4WoTI9pWumVBfnoHx6SWrq8rEwVzleDVcDBinb5y99S6r
X-Gm-Gg: AYBFou1sttT6yFOcAVWbN36TLD7/eHgKbZ88+zvlN77LjgTP3HOUDqQC+K49XrOupXK
	bPqOfmFP8yQKlykKUQUWd4nBVSUAIoDPRgh1ZzM9eG7moRL779Kx9GFXCse880xsBNPEAlxK7aR
	KjPnmcOsfEaMR8F2/I6+JiQx4ovldnCeWPtfJY/PE0pSjCFph6MypfFIBGElbBzT+FXRT/o93BB
	IBqCb+Vlr50teSRhfNa67o1qRVMrjBvyA2qkCiDpsao04kJ2IMNsmu8Sj5cvpmtEzU7Ls7bzGv2
	9xfYBD0Krt84PD5vBpkB5lGYGOUeOFIAAKueWrnNFU4u0naFoDdJpHJ9l2lN/f+ihS8/NOkNySb
	x6DpUjUQxkDrW9oaxMUlOBtBpG/yfODq4t0a5Efm0SPlKxp2MA/l/cwL5y6DawJUxmrY81nfB4n
	773qJF8DGgQFKuBiKwAa7uuODAU8e/1gTTa3alkJDJR+ss5739ZXxxdQZ/h8+gA8I0r8ghDoWsf
	e3BTvY2Vlnt8yT2mbrs3RCSrTps8l1nT2YOBzNn3U3NzGQdwIF8SqaD
X-Received: by 2002:a05:7301:9a8a:b0:34b:3230:5cda with SMTP id 5a478bee46e88-34c639fd460mr497960eec.26.1790713307134;
        Tue, 29 Sep 2026 13:21:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:abbd:bfa5:f574:cca3? ([2620:10d:c090:500::7:dfd3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c38fe2bfesm1235531eec.27.2026.09.29.13.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:21:46 -0700 (PDT)
Message-ID: <5986bdd3811c1f6fb6e3f66c0ca7c55a6e67ce2c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/36] bpf: summarize regs that may hold a
 frame pointer in insn_aux_data
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, martin.lau@kernel.org,
 mason@kernel.org, 	ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 13:21:44 -0700
In-Reply-To: <d5eed8a76106def474e99ba47cc8d71becf6e5c623e498c1359b147d864abe7b@mail.kernel.org>
References: <20260926-scev-minimal-rebase-v1-4-c8e5ab5ba79f@gmail.com>
	 <d5eed8a76106def474e99ba47cc8d71becf6e5c623e498c1359b147d864abe7b@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 20:27 +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: summarize regs that may hold a frame pointer in insn_aux_data
> >=20
> > SCEV needs to know which registers might be stack pointers at a
> > particular instruction. This information is used to invalidate SCEV
> > expressions for slots that might be overwritten by indirect writes.
> >=20
> > liveness.c:compute_may_write_masks() already tracks this information.
> > This commit modifies it to save the information in insn_aux_data for
> > further usage.
>=20
> Are these two claims accurate?

Commit message needs to be fixed.

...
