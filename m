Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB93A6B65
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378203; cv=pass; b=UNtJYeEQBk2CXpESRI2RxX4lwrUO//TPPuewdhSXZzoRiAp7isLz1gqIamOdEq6liqw6n0otsGKKBwPGZUiACuoyzMzLE1P6au/EvAO/lDn1i0ETcXY5S0cCHcwcpqHfedyut6z6vQu2xxLE1Sv1vLKnS4g8+lWUyDmtifRnpCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378203; c=relaxed/simple;
	bh=v13IBvJ3Cs5k45Op8zhzzynqZs/Da4H7F6eGXP4EZOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpgkZK5j532E1R2nhdyfMMZaGHW4qNHLWJU/BTmCbI8hKbkdJATe7eHgIOuTC9BDZAxnJ8+ihUIxCbNE59cTDQ4s9fd+4LK4HS8CI7mhZOgeYCtP+Dk9EkGAa7hLs2F6hgJOcusQ/fwyCP5LpMj76GEeILVAyi2q4CtsQHQLeBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aYFA5tCO; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aYFA5tCO"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-853c07a76adso1785582b3a.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 12:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788378196; cv=none;
        d=google.com; s=arc-20260327;
        b=go2zFof0eH4iZzIRKbqx5rqxRShEuIBPrrsTIqEwEY6kydbhhNOoOUiqhEqmTJsSrs
         rRncRcnQq2HchgVJm3B92lkASUEA7GMLWuhDKlCLYeiN0e9cKDvPhvqFcwjgItfk4D5q
         ON39j6b8CSbyKK0Kz4rHeZy3Rlf0T4B8N37DaB0X+Q2QvHFQfrqEYkxntlW1b4ozDcl9
         HXJufbHZMgBpmoJsoX5yijBAiJnB0jwAdLzsQDxPvr00Ty3ZPsxCB/JhOg2cHzL0IfM+
         9BtOT0rJAENB6o3GiAM7Vn8ZzqGonr3s1bL9UW7iBFBsnb9L0E685yJFeb/lqGj613cq
         cH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HZzgWfQ/86NrxOY8y/QdFfPZVfg39pEM5TlwSWapW24=;
        fh=zZgm+55jvLHwN908yMwEUUGRupBb+3+nawYljEcwKVk=;
        b=VJVKBHOTwFSQlzjoUH/WNPQqAg1pesK2lBmZuc+6uBQtk4sIUPWBhX0eCEJIvKWWjK
         pBmZpFbPSiEIR8NK1c9D8qxGJEMp5Kcq8Lpz0eYFR8GnCrPSfWXFW1EKv92TLEUwAvVB
         EP9FT75s535RKhcmVf200DdmdL2eqa+vVmp8CBwcSTABy9IxhLMAw6f1cj0knVWLPf0N
         TLut5M/WRCH0q86g8WLHdyUQv3T2jMO+VwKQ3NS2BSqQpB6zvYX+eVUzkvAWbksrH+OG
         M/XCbIunbIw61QYI+CxD7QSmrpPzURThupOMTJNHDvLIqBshqFxbNKgamVXJlG+TuhHJ
         BCcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788378196; x=1788982996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZzgWfQ/86NrxOY8y/QdFfPZVfg39pEM5TlwSWapW24=;
        b=aYFA5tCOZ5UjOiabbKf+4Li2QUBDULtgqc0UtYdMcN42FuRj6wzgCLFhAKAaI60NZg
         7u1Eli49zAV6MQy2b78QDrhXqwsAAyzcu0FxEVwk7WavXov/6rxM2LcwYoEZz+y3+VJW
         UPE1ELzTJgWxSva8X0e2e1NXkBo3cCfyVB0GIATavl2RU2ZDH7e8KvDWAqlS6L4lRWc7
         K6dMtF07P92DD6er/SfN4xho3HHF40di7hzQcuudBqZKdhG7XH6aiNRsVxtH3VbzeKgV
         MtP22v903BOORWOseI5xsYPMTLbzRrrQg9QhGLpbqq1N/BcLGnPT4dTtTl6qp/VcSKPD
         sBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378196; x=1788982996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZzgWfQ/86NrxOY8y/QdFfPZVfg39pEM5TlwSWapW24=;
        b=BnGUqPSOxEws6KCqOcB+57BmKIgKMLrZr8pij37jxOopSvlAzhUYkzTOBuk6qBVcKo
         2aN/aSm9bE2PscOHFX/DL1i2qwJU8qyItlN8XxRlOeVElI9SjnV7MJq4Rivat13Y+ri1
         2+nyHLaxF5Nm8rvgnkMekpPaRfRJuoL7zKRXiksOSAnC2fCModWfMEb6MLJs+tdzB5s4
         EiFckP2mILHc55Fis1eAXcxXexWvxvwhaOUX1/VPKdPpND4+I7IpMLw8Oge9EywSwR7d
         5zJO3/6p1SV4sGlqlnXCuj7TYxQen9Kpb/0ZH7X/jYcQl1lOSqhqA4zeezJMFflRcApp
         zHzw==
X-Gm-Message-State: AFuF++khVp1yqRUaCfdTknCph9jzqcJEV/gUl6v/vYo8Z01YlCnYIYbB
	2aKVll1Bp9mLLb+d+lRpnmJsqLIAS6xl65BQCaLd6Rj8dPw+wlvHQfmJUnFJyYqWkNXp1B0zW+Y
	ZAvD9jAo6xgT0L9u7FAILWPzTRb4ZDzFrG5Gc6Ysch2GUZF3TXGRPAg==
X-Gm-Gg: AYBFou0BGwbC+A7ekJY9aSRF25n+HHpUl19jfhM3feM3Dx18BPxnceXqICfEm3yB+ds
	X30oY+qP7OIgUMRTgzfafPcTbsbOpdMGbrZYwBNahS/qo/2ft7F5Fa8DMk9qdDAFZPNtA91Yzbg
	nIlLW9q43WT9C+D1OBYJQJ90YRY129mLCa+5OVGY2+H++5jpKG6yyhpPorFwgLyZcwpAunhs0tO
	46dBNAO5CCGvsAnxe+C0SCWWurmmhhM43/fMtmv+aAOtQaAFsOOVhfsttNgGzXC2hLHl+ON87ic
	2h6TWWHJgM1UqRDd1DRtzFQexmLzDhcAsTFoDyOBG42m
X-Received: by 2002:a05:6a21:2d04:b0:3d1:8876:fb1e with SMTP id
 adf61e73a8af0-3d9a9695714mr11592712637.0.1788378196405; Wed, 02 Sep 2026
 12:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831110934.241898-2-a.s.protopopov@gmail.com> <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
 <apbU8-fpioNIwUA8@mail.gmail.com> <CAHC9VhQbWPqEz5g1rVcMyJgrzzd4cQuwi7cddgJQK1H3ugMz7A@mail.gmail.com>
 <aphBNqQK0JeVy5Sm@mail.gmail.com>
In-Reply-To: <aphBNqQK0JeVy5Sm@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Sep 2026 15:43:04 -0400
X-Gm-Features: AcwNN1XYNCXydNpNM6ZU2Rnek6l8sLmm3paMheXeGevlLusJ85KkWm2it_ZUJS0
Message-ID: <CAHC9VhREB2krVp9XkV6Psp4PWhYT14281+1TQUZL7o+GTo1cXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:20=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> On 26/09/01 06:15PM, Paul Moore wrote:

...

> > The core issue has little to do with BPF, it has everything to do with
> > in-tree vs out-of-tree code.  The BPF LSM is explicitly mentioned as a
> > "pass through" because some have argued that the BPF LSM is in-tree,
> > and while the basic BPF enablement is in-tree, the actual LSM code
> > that is executed has thus far always been out-of-tree.
>
> Yes, the actual code isn't, but all the building blocks are.
> The BPF is just a sophisticated policy language, in which,
> given, say, ethtool hooks are present, one can say "block
> all ethtool ETHTOOL_TEST_CMD calls for the XXX driver" or so.
>
> Is there any way into turning BPF first-class citizen from LSMs
> point of view?

As I said earlier, the important part is in-tree vs out-of-tree code.
We are not going to add new LSM hooks only for code that lives outside
the kernel sources, regardless of whether that code is written in C,
Rust, or BPF.

--=20
paul-moore.com
