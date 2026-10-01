Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7352F272
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869047; cv=none; b=A2cghM0N7F9PKyRbicAw18vzFvvXkce1KDmBq/th9lZxZLXIZ+z2r7l97vB77DSs0Js32uM6jU1p4tkVt0kQ5TJYwFB3FUFqxFhMNMaWYKh+9EkkC3oOAp+CS1dm5Tqsp66udf7PIzWqZaa/ekL+NlE4s8zICfyqR9nbj+6muaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869047; c=relaxed/simple;
	bh=KbJb+zWj7bG1bYw/1KYSOO7HgAF4YpTcsUDAPaTcPxs=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=MstuiXD0vx9Uio0UZsOhFhkfQuFS4ngwYxZzMCd087Hrc0suzQJcVVosxrbfvP7+PieH9IFV7Kx4+Zk7exbexYNLpWaLVkE8d7QgTRbqNFUegKbhnVkHoPgqqBSgmxoHDB+0ZwH0tWa35xCO18x1vhRpWEGmaG41SLqo2xxSFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYgB2bhD; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYgB2bhD"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2e2bfc2540cso16487695ad.3
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869045; x=1791473845; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qvdlHafwL1IrC5R244EdcYMq16pDpvJN9bMBAEmPhs0=;
        b=pYgB2bhDY6/NQGe98zsr177m4lRValKfBWRiWxZgPGy8WoqtFUfH6yuaK9HfGdmF34
         p1ZqwZN/6DDLH8z9ka71giKuPTanY784iFUG1dCk0H8UeyJznRAeAf+Zb8G97uwYu6xM
         nm2GSWR6u07ZbKMjLxzeeLnxbGxSCQZNnIEeGcbx3K1Do01r+zo2bJ41qhryEivDLlSn
         +PfEOwGmAZvHR/WegxVz1Kz7lTLA0yXPrcWZeBtiyba7uJxpP+Nz/VYrYKggfvH7jvVV
         670vj0gEtF2OVYr3D40pQ7MUvTJtrVfbEKk55jUp7ahHh41TQHBt9Ry/fcojdQFLjD06
         1Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869045; x=1791473845;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qvdlHafwL1IrC5R244EdcYMq16pDpvJN9bMBAEmPhs0=;
        b=07sKm1Z1G0BEvMc6+1NVcZRuWcPrVIvf1CpmgyDFwWF8qp/96HoUgYDXb3twibv5Qr
         rg1YqRinIqsDHefbvx9SwnhKLoCvFrJTs68y3kSaeTIqjZu9lbjhcH5XeEhUEI2MPC0n
         7v1jjg7VJvkrXHHGDvqHVq7PTZPz84WSGrhWuqh7X7H3udPG1uz0KNbetNGCBlpmmyFE
         RvEbBWOO+ZqaVskksq4ipK9mU83sp7lqxVDjH/7gLiU6lkDCFt7fF8H9hL3LHZQkwE+A
         k8+01IibMQPOSZJmxeC0qquzyTKKYTEHIvQo0Hn9XkY3Sx/6wZFlM3DT4Joq0iQjl/+W
         1cTg==
X-Forwarded-Encrypted: i=1; AKwUvBxXjSWxALtPnegnom0up+3GN5zsx+ctzbzqtJ94OecHULLJdPBTzlnpkAg/IsS19S+qqjk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6+6vOA0D54WounloRZ5dXmuO2MGIH6zZdO9gtcuASPKReRbbW
	k26kMf3CqIBT59lvBca7HfpdwXrrc4I2PDMXBaapD9OXas4U9fK/cX1H
X-Gm-Gg: AYBFou1JHcdKtRJDlFLMbONEA1hYEgMiV8ioHMVB/+j/3+igEWzSIUu/fg8irCweiBx
	0JvAj4/1NHu6jlxb4Ua6p6nS26pEutOf08HWcc4FhPCZ5zuW1FqmQQ+/WJwPN4rdHC39EWaAW3g
	h7xXrqm2kFBDmApCxrHVX9UUCOEoOB+Jkt/hW6fJgQAlxs70k9DgZTYigH5d5PkZ7z6vnih3s7m
	5EtvqxwFHr/8iXNsgdXFVb9DyrMXRQeLuVYPs5Acm36HZFC8y3ZQdnXindZ2fQWURPTpMrB6/Lr
	Uiyj1rRi77MXA7p3+ON+Jbd+58HUXAazKvkWgXEvhoBIFOEafcWvdobopdjI4yP1ujCRZzOL89P
	SUqqvw96EMcFjPZcL0rcO8H/wZBoPp5Q5ODEB8mayHBD/Yj2gk7z1Y7QP1TrUu4C8Ej/5DME/BB
	bhVuPNEf4H21Li2DOMg5r5NVCQ602yc9ercb9nYyXsul+gor2dX8Tk+GwvZd9MbhiInOV9kKh1d
	rCwusxsHHaZf02384R6Z1iMhrUOCkVZ+trOUawLaORf8egB3CDIrWYncwvGiPl4yKa3jKSJC1uK
	g+P7x/3jfb1ddu4=
X-Received: by 2002:a17:903:1503:b0:2e4:9081:79e4 with SMTP id d9443c01a7336-2e490817c06mr4369245ad.25.1790869044835;
        Thu, 01 Oct 2026 08:37:24 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b45567sm12760055ad.65.2026.10.01.08.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 08:37:24 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 15:37:23 +0000
Message-Id: <DLTM3D36ENNF.3IH79JXEGYZAX@gmail.com>
To: "Masoud Aghasi" <maghasi@disroot.org>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <daniel@iogearbox.net>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <leon.hwang@linux.dev>
Subject: Re: [PATCH v2 2/2] selftests/bpf: add test for percpu map flags
 combination
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260930135753.1063495-3-maghasi@disroot.org>
References: <20260930135753.1063495-1-maghasi@disroot.org> <20260930135753.1063495-3-maghasi@disroot.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 02:57 PM Masoud Aghasi <maghasi@disroot.org> wrote:
> +	flags = BPF_F_CPU | BPF_EXIST;
> +	err = bpf_map_update_elem(map_fd, &key, &val, flags);
> +	ASSERT_EQ(err, -ENOENT, "bpf_map_update_elem flags_combo");

The map is empty, so lru_percpu_hash test passes without
the __htab_lru_percpu_map_update_elem() hunk that v2 added to patch 1.
The check_flags() change alone is enough to get -ENOENT.
Insert the key first and then update it with BPF_F_CPU | BPF_EXIST.
With max_entries == 1 prealloc_lru_pop() evicts that key and
the update fails with -ENOENT without that hunk.

percpu_array changes are not tested at all.
Not even BPF_F_ALL_CPUS | BPF_EXIST from the commit log of patch 1.

pw-bot: cr
