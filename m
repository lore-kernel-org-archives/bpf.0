Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B241F5EA
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400919; cv=none; b=DdUcREuqF6zLimWvPUwQVKTTENwZ48lFA2fGA4lCCeBC6JmAoK84svuYBOdvvPT1q0/xBTx7uvPttGmb3n0J8N3LyroHEIlS18+2EYhnI9CxwIMNbbBHDQA0HRpw0bvbzn+9/PRxkgPJ+9HzU9gUilFNbCQ0isomzJbOis30A24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400919; c=relaxed/simple;
	bh=C/BPMUie5BD4Jvkxs5HGQaycGen1h7/YnzVKpvjZL8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=axL9l8nN1I62pQka2aIr4ud0k8nHrr1ucmwwrsxWs2WVfCsI/cF5rVjW7k40/MYawnmprKwv/tFpr3c8hqKYjK4OHvwS1dwadriG+ZAVS9mBZEaZ73IUIQ1q1Wqk+6g5uaSwh38f/gv6oL7eo8thjl51lOEVLFuJt1I9WtwNx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=pass smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=L7WjJwTD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="L7WjJwTD"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c80d215169so40795ad.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1782400917; x=1783005717; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/BPMUie5BD4Jvkxs5HGQaycGen1h7/YnzVKpvjZL8k=;
        b=L7WjJwTDlUjMQOcHixoH+B08Qc3HsQmuqIVPtHlJADRyXoldQ2nlZfDYDPO7xsLtlN
         qKai8qMhUshLRcv3mG7YY2mm0PKTxdj6UPumfIrlaiE+NJTiJ59CMT2yAuOEjIIlJgEz
         0q23cBG/e25SOeV5TsPG06b0zeEafQWbs1EEoOkhhtV2HuegMQFE+ELPR+Qryc4qp6P8
         61cbigM2yo9iT2hQyjx6V/A+ry9ugDPfXan15XSdjdxM8RRseoJ+kQHI7lSafWNe3eqC
         oarM3S3XgD8vuHlee2gA0PPUsU3tElZRexCsbFpkyNgNLB9sXekrifFRNe50+3OUEGbT
         4TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782400917; x=1783005717;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/BPMUie5BD4Jvkxs5HGQaycGen1h7/YnzVKpvjZL8k=;
        b=KXEKeiKD307bbOM3koEQVswH5q5455lI0DDHYRgCWNbWNnNs0e8ZpB9KyRs5RCtHrK
         ZdeLGN3bBuTLwzz3+sEiHptlIdR/DJMtOcKnGaDhjTsJOjcuxJTNPJfcq4gnrt0dJ2M3
         B3kob/2i9WqAD7BKvEuxIyUMJJFeZEywXj+/FRPhnYay02Z6rDnBXRI2GrYCf2JNYGA9
         2KM3rmdF7hnmoOnBrRPIi5ptmMLpun5h9Wcd6kxGrJSptIwee4bbJfd+hnYvRFfiED0o
         JzxHFJSvKKpnA/Y5UzjxbeHYGUInCQx42kDO3G5f/ge+bU2VgRhXpyAt4wFytxHSKjP5
         800g==
X-Gm-Message-State: AOJu0YzPTvGgUozuQUM1ipXJH3pJ47oTQUQiiwhdAnB4YtkFDhtQNysR
	Pm9zae2ERW5Pwwj4wEms2PJUVTh7HM/F84ccpXiAn3t2tOrcu+wTtoqguo2t71fDXMQW8d84pLv
	kbe2LeJa6oMo=
X-Gm-Gg: AfdE7ckF+KBSjpKscrchifez07Z8N0nh5w30rmzLBUUo8ZZnA7Vl/NoRN1kW2eJTJ5K
	uqzx8nPRgGG/xJESPjfGlZiHBkqU20dzk+XVRI/FfueUyJYzmw48cmQSb9AOFeccWKamoL2ZBo3
	SxPafvQFhHBvvmJ9yWMq1yKJc6kM2g/HXDj5WV2oCa61qnld6xQ+Aa93s68DZsVV2ltM1w7PdSA
	2dr+QCILwiTlN11qRVpGeP3VbBapyOB8hbsEYjt7v+LprbpEWxVjJGLxXzAlDIVfIpnioFZ2YCb
	g6AA0PkHaPpTOo7lbsLzrDMbQaZqRz0wWr0xs61RXKfUiXn+lTQivT8NlWrNeZ8irj4PQ1t17OG
	GDbqU/k0h7iNv5/G/MNb5FdnyzN9czOj4xhqv1AZGXf49jWAf8Jz0DD5GC5N41XD+yKnNA2304j
	IGpUMes2RHgXbI5L0DH8hL4AHUoDOn4vjYm2IR2JpbzPaFbe+HvJr9/I19fJ8e5r72qFbMUXOhz
	Dtlfzy6odh4DN6eCmTmoJw08B68NhNLKXNalkmxtQw=
X-Received: by 2002:a17:903:3b88:b0:2c6:9d3d:dfbd with SMTP id d9443c01a7336-2c7fc6785b1mr33272005ad.16.1782400917080;
        Thu, 25 Jun 2026 08:21:57 -0700 (PDT)
Received: from 3.1.168.192.in-addr.arpa ([2401:4900:1c07:46d8:d43a:b840:9e14:dade])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac897bsm23079455ad.5.2026.06.25.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:21:55 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com
Subject: Re: [PATCH] libbpf: bounds-check float size in btf_dump_float_data()
Date: Thu, 25 Jun 2026 20:51:49 +0530
Message-ID: <178240090908.83660.15272286240854949135@digiscrypt.com>
In-Reply-To:
 <CAEf4BzZMfPBgN5j_qW7MsyyXp7Mt12j21+qvH53086CULqU6kA@mail.gmail.com>
References:
 <CAEf4BzZMfPBgN5j_qW7MsyyXp7Mt12j21+qvH53086CULqU6kA@mail.gmail.com>
X-CodeOps-Marker: 1deed4631a2e438fa0befcd3133062c6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks for the review. Both of these are pre-existing and orthogonal to the
stack overflow this patch fixes, so I'd rather not pull them into this change,
but to answer the questions directly:

> could a malicious BTF bypass size checks here by defining a FLOAT or PTR
> member with a bitfield size? ... we unconditionally read t->size bytes from
> data via memcpy above, which could lead to an out-of-bounds heap read

This patch bounds the copy to <= sizeof(buf) (16), so it strictly reduces that
exposure rather than introducing it: the old code memcpy'd an unbounded
t->size, the new code copies at most 16 bytes. The remaining concern is the
bit_sz short-circuit in btf_dump_type_data_check_overflow(), which validates
nr_bytes derived from bit_sz instead of t->size on the source side. That check
is independent of the float buffer and predates this change. A FLOAT/PTR member
carrying a non-zero bitfield is malformed BTF to begin with; tightening
check_overflow() to reject it is worth doing, but as a separate patch rather
than widening the scope of this one.

> could this cause an unaligned memory access crash ... If the host
> architecture requires 16-byte alignment for a 16-byte long double, and the
> data pointer is only 8-byte aligned

Also pre-existing, and this patch doesn't make it worse. btf__align_of()
returns min(ptr_sz, t->size) for a float, so ptr_is_aligned() does cap at the
target pointer size (8 on 64-bit). The case described is the *aligned* path,
where flp->ld is read in place; that direct cast is unchanged here and is
shared with the int/ptr/enum paths, so it should be hardened separately if
needed. The *unaligned* path this patch touches now copies into a buffer
declared __attribute__((aligned(16))), which is strictly better than the old
union float_data fl that only had natural alignment.
