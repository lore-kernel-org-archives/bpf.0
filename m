Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163E385D72
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381832; cv=none; b=MqH5T+CsKkc9gyFtXtzPP1oYzzFA/Mbpc2s6wypRsEytxecgYVCJZRK63CNhcBkivUuk/QY8q3DiUUswtCGghYmmV4VOjkmdgMPSN48OjDtofBZx3P/9rY9voox6xNlnMbGZHevnPanO3GKmpMecBSmwiJGkD/PL6B2+7/14J2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381832; c=relaxed/simple;
	bh=WZVCnLY1cE5XYblVwUdunCHHkhznNVXI/0jU1H/hIRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhyjMAcrnT1WGV67uX0T0pelgNNf6opLbHe4fh9SjjlVqRNhpy8lioU/AdueUirKJ1jOrUMxWY4eAjm0/LdTpU43uLDeaGmhDvTbQeMUp7YBTrq8et9h5OfByzH6uRA21n4lWjtmwppiDd7GmyQuXOkvKyasPcUyXUO5Amu1KKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STXLtwnl; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STXLtwnl"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e347638adso2377591a91.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786381830; x=1786986630; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wSOG3j5HXgoPseZzXzVE0dJPGLXtK8DifWnFpKi+6pE=;
        b=STXLtwnlABreMeWSOqbn+4ftv4OOkYWNcXjK7jrdDcadDZGmJsxXdUfcWahuVdtg+O
         BQMW2MdN8KROWoAKoCq+6IayfuZ6GfMmuWDOaG0hEHnv2l+3czRZreeTltRlc0pn+B9r
         nTAW8uil06NL1VmUhdkRpH05DOxeEfckpNXTF4gM9u6WLiXMPYr5c2uZ7j3X4BFeved4
         RviJEY/j65TEB8wNcSK5n1B+YsnVW7zw/PVGzuiOhsjvZHkJ3kduPZn+CYv2qIepjA4N
         LVri05Bu6utWJ5bsml3MWLc2JArCGM/IVEFO5SfrW00AbQFsVKHmLcVD732mhD5mPIYg
         CH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381830; x=1786986630;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wSOG3j5HXgoPseZzXzVE0dJPGLXtK8DifWnFpKi+6pE=;
        b=pNH4cI+NDD8W3Q/Nk4iq4WtP9YoymrVS/IwyhuKSzJPIk6EtbN3o0EiAQGon4jNR8m
         GtD6ZBTTXYoenaEnEO4SnFkHEdvBzdttt3mLYCQas89/mmqDBaN8FkwnOYYeO/0oaykh
         9Gk9koqMGKgybpIGjxUbZmMj3MwfbwyxhNQz04qOiDrP6g7EOnkCc0sfSYqBIg3Tgu4M
         0zilIK7hjZPZCM74DiNBNyM1X+bde19LiLFPDxWO/TiHxA0vrj2HXDwXjbyJT7SG7Jkg
         JBiX9xU1iwh+1MPKw5/dmWHBSvoQbqsUJJheKHdrMO+jWIaJ1XQGZpywFawDKTcgcHUZ
         RJew==
X-Forwarded-Encrypted: i=1; AHgh+RoSZuQu/7twwjaQYUKUCEi1T9HVAWKczsVPhr++nK/bEvDUNHdWxbLchZ2dEncJ/vEeEZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/W5mOInLi7YQoPZO8VOHqlH5dUKK8iiiFERctw3HhJ36qkPY
	dqE4FS/ISQU46NLiuW58uY/CHl+Offb94y0tPsw70DS4HHKCZvQmnki+
X-Gm-Gg: AR+sD11inPdrq5MO1V6DlgGA+1exEjwvWtWTkYJHjj5FipuwUu0U+eY11TGGk6j3kzK
	e8SiE3p7is2MA9eNmu6yCW2hG5GuYtVj/4j3FEk8YnNqHgoCYkudGhFwNrElujxZxYFhyym/++b
	uHNmXvzBtQxHmfR9M4F4W3FEaIp+LLpQHFw+5+NiN5be1Shtz9ECCrjjh+n4ZZPDX0AM7erA5py
	kAg4yopWibzw2XhuVp8Hr71eUUEREgF+YsVwgyXw3exliVSwaftTsuxQOFMXvaMp9ojqzyCxqzY
	uVfq8VKIPX/6YxnNKkXreFrVFryn7dPDAyOGf2RdFTPjzFwXfmNEGgqNWAM9KQkEiK49qw/yGje
	P0HJx3NMUbpxPBW0UixQH+PDYZS2LBps6C+L/+E0VfQgA5X9UUKDpBvlfFmHoEQAjozOwwYpT9B
	TFeGqrGCN5ka8JrXQoWv9+OaCamQvqjE+0Hveqh1aszEK9xOeHpkXro4kBc7GbYN7NW5eJTkezP
	q9q5nwUniHHCoF5
X-Received: by 2002:a17:90b:2507:b0:38f:57f3:4dc6 with SMTP id 98e67ed59e1d1-392c068d70emr5228487a91.21.1786381830130;
        Mon, 10 Aug 2026 10:10:30 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d537d905sm273926a91.14.2026.08.10.10.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:10:29 -0700 (PDT)
Message-ID: <704b266e251c6b7e503ba489bf87a92039369c09.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Derive the atomic load register in
 one place
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, bpf@vger.kernel.org
Date: Mon, 10 Aug 2026 10:10:26 -0700
In-Reply-To: <20260810134346.466004-1-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 15:43 +0200, Daniel Borkmann wrote:

...

> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -414,6 +414,30 @@ static inline bool bpf_atomic_is_load_acq(const stru=
ct bpf_insn *insn)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insn->imm =3D=3D BPF_LOAD_ACQ=
;
> =C2=A0}
> =C2=A0
> +/*
> + * Given an instruction @insn, return the number of the BPF register tha=
t a
> + * BPF_ATOMIC reads the value at its memory operand into, or -1 if there=
 is
> + * no such register. That is the register a BPF_PROBE_ATOMIC has to clea=
r when
> + * the access faults. Like bpf_atomic_is_load_acq(), @insn is not assume=
d to
> + * be a BPF_ATOMIC here.
> + */
> +static inline int bpf_atomic_load_reg(const struct bpf_insn *insn)
> +{
> +	if (BPF_CLASS(insn->code) !=3D BPF_STX ||
> +	=C2=A0=C2=A0=C2=A0 (BPF_MODE(insn->code) !=3D BPF_ATOMIC &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0 BPF_MODE(insn->code) !=3D BPF_PROBE_ATOMIC))
> +		return -1;
> +
> +	switch (insn->imm) {
> +	case BPF_LOAD_ACQ:
> +		return insn->dst_reg;
> +	case BPF_CMPXCHG:
> +		return BPF_REG_0;
> +	default:
> +		return (insn->imm & BPF_FETCH) ? insn->src_reg : -1;
> +	}
> +}
> +

Hi Daniel,

Note that there is already a very similar fixups.c:insn_def_regno().
Should we try to avoid duplication?

...
