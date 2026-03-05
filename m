Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE0364EAC
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751589; cv=none; b=mHl7Shh2UAEZx0JjgJWjJT2fT5xQ5Agu3/e/+Y0182VG3rYAL31npGPX2O81Dhuq7trjLPj24n4yH/N8GYZs2dIwDM+CSzfZp1xIs/p9IvzeeBlaRH9VUYK1TXAkb7v04N8OAQzWkgwRu71ckyASBn+uLpfH/eV9I8fxF/xLuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751589; c=relaxed/simple;
	bh=tW+vMksaTAuhxnjBPlTLjvKQVx2fBq6uNS5EYKa1wTE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nxe9B33bK9f4nb/tVXEXQi4Qf9/zBsQxQ/OtIU3orCBvbRhYDwaXjodNWBEkIv/Tj7Dr3dYA9fUYikDmtxEId96Zumr3EhQK86WcW9syVH/IcK618FFUOY1t029CLvfchI/2Dxgd2st7EepXpcU4i/naABECyUOMT3cEc1ZNOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg/Sx3mT; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg/Sx3mT"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb20bcff5aso840421685a.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 14:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772751587; x=1773356387; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=asknapzTOxBehK5ajrHiH8qMU/jE4vXvfenTMf38MTs=;
        b=Cg/Sx3mTaTQ0hSG7Af5tuBQpT1OTK5aoUspq4Z2q2kqJ2b+DzqKT0xUtnoPUv9GY99
         zPmADQuIr0jeEHPLmTNmo2hn3e9rHjFqlL+oLO5f7WEvJKdNqtq6BnYX0ydeXWEn6bFO
         7s924w8jMrJpZcLRJQ8E2/pt8KZZGlkDBJxUGgswmrQU8Hdo+hRNPXu+j7h5vIL+9Vbq
         vCIDTZ5F2+Mb379A/OcwX4Q+hm6AmXhM14sdFe1cwt3TPk1dJG/IO08r8cRw+gr5veeY
         le1GuN54PBIVnnzhB8Gb/i1stH67BymrTS5QGts61/Eg9ZgKspYykqC92gop+Phquytn
         wYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772751587; x=1773356387;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asknapzTOxBehK5ajrHiH8qMU/jE4vXvfenTMf38MTs=;
        b=lhFOMb72d4im+NHrUI0i/85ZAUG7AFQFAnwerEEFHfqwWpJp6MCFJuwBB6h5aw/rv1
         OSq9FdFSLA+hgUJZZRrvOaPjT8FsfpAM5xQkE8R6KQwUF/ZsGYKVdkLe4jYJ9xpmrKp9
         qRgMwB1VKLGuyTml9EyzVPRVNbG80u5ml2jbyIdFBeWmleHXnEbTGhsh+8uohYAMIoVc
         o9kmH9bA8m/l33mtq0PLOn2G5Kd1msU/hDA9J3dbzuJC50/6Hjf2yjPeyKBu+KaDL24m
         ByPEFBzeTLzp+Vsp6StJkr8K+2g26RlfTAENpQqza/hxcofQPZWwiXf6m/tlUmxKddgP
         X36A==
X-Gm-Message-State: AOJu0YzLpgWQPyzLRz5Mnule4GsD/4MH0+F7U3qrWfZp+40p5pWKX4P3
	7F/PISTj+n7GW8AAjBcEb3xC34y303TfdcoKLi539/s2w7fTo0a8BIUFsSDMYQ==
X-Gm-Gg: ATEYQzz67lXXHZIPIyMlvV8yo2QvA4w8idztyc7syNEO7BPVwziB/AL+DtJf5jFkdHe
	UeEZYoFvcL6CA+nFqObhmBiUAcHPSZISaUojVeFRCQCNE9DEg9uoU5EaA8vH0GdmaHhNCTMCU0Y
	k8awi1nNbDMCl3UbpMukRIVFrEBwJSb2msyA+8FdgXAQrlffuxgWrJIeT9WT74xiswyCZ1vwtho
	1SobgV68v0vGfX1ICVto7a+HfiMb20zOxSIDOusF7CvHNX5RL6gcWatLR0yhCNmldq98fRqROj9
	p7UsiJpaKDEjeqRnk4e0oRQhi4NUHofTkLca5HTbzaJ80T3R2hz9OF5oMTiWoZvT/9/LxzKRVeG
	8J6DkM8GNw4FoNy+w42bA2JKm3icOMWZTmjGEsrYSGHKvRhxfojceB2dqc15L3lKEMEDXKgpgYb
	Z60ZeLQgC38NvVEJZbv2s8FiMN+zYxMh1Q1PJ2NpJrpuk8JitQGXp0NEEcLpdjGAU=
X-Received: by 2002:a05:620a:319f:b0:8ca:4288:b16c with SMTP id af79cd13be357-8cd6d46b25amr26353885a.54.1772751586718;
        Thu, 05 Mar 2026 14:59:46 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf7175c6sm2013979785a.37.2026.03.05.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:59:46 -0800 (PST)
Message-ID: <5061a6cbf5858e3921f0f886abb21a10bc3fb457.camel@gmail.com>
Subject: Re: [PATCH bpf v2 0/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, emil@etsalapatis.com, arighi@nvidia.com, 
	shung-hsi.yu@suse.com
Date: Thu, 05 Mar 2026 14:59:42 -0800
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-05 at 11:48 -0800, Eduard Zingerman wrote:
> Cover the following cases in range refinement logic for 32-bit ranges:
> - s32 range crosses U32_MAX/0 boundary, positive part of the s32 range
>   overlaps with u32 range.
> - s32 range crosses U32_MAX/0 boundary, negative part of the s32 range
>   overlaps with u32 range.
>=20
> These cases are already handled for 64-bit range refinement.
>=20
> Changelog:
> - v1 -> v2:
>   - Extended commit message and comments (Emil)
>   - Targeting 'bpf' tree instead of bpf-next (Alexei)
>=20
> v1: https://lore.kernel.org/bpf/9a23fbacdc6d33ec8fcb3f6988395b5129f75369.=
camel@gmail.com/T
> ---

On the other hand cnum approach as in [1] might make sense,
as it "one shots" all s32 <-> u32 range inference.
Need to double-check if meaningful __reg{32,64}_deduce_bounds()
simplification is possible.

[1] https://github.com/eddyz87/bpf/tree/cnum-sync-bounds

[...]
