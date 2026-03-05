Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9B3A6402
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718870; cv=pass; b=NGA1gHXvKTrbvcIdoHE7PrngxBuXV+gN0BLBBWLRbt1YmUhRdGIBDu/p0ENudw1Mg5cdVSW/hNND5VreQ/9fuNjoGy6aLEkbY4LCtxDqHo670g3m9xTvMr1PBKIebL3VLVxKI8YwF3N1DH/GP2MSXRj3J4T6/kMeDzIKnrFfcHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718870; c=relaxed/simple;
	bh=7bIubE/tWXR/VKCSVoYtj0rwX7vNIEiCqb0WR0Q+uZw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QebwxlV7dMmSpJxUCSRtGBu1ym5H84KQSovx+IYvEfDpOY8rKND3N3n4/K8Xt2pCPXBzUKSXXH16VOtMSJ91eR/k4pyH1pIenyBn6OrctigtM31KgLb/RrAV4pwdbfM51OVN2LlgptePgZx2g2116RtnxjsyblnjqxlcPbdEBUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2SUC2i/; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2SUC2i/"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a1627a09so47097461cf.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 05:54:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772718868; cv=none;
        d=google.com; s=arc-20240605;
        b=OBBiWEO2m5t+6Hr0DSsqrZEMDZ6uQjOO6hxtAdCh9tkLknNAVtP/tJ9P1lbRpmYwIH
         vUlvjROQnV7q+e2qWiYvZI8zpLwTqHAdumMJB5Wa29+TgeKCGyLYthYNodezvfSgzh6v
         ilMt3zBAdMrEvP78n9WQCITPdiFFEfiyOJl6J7QoSPd/mtss7Nk3GYg2F2+1f1u03bUV
         b4S9VfYzZSWrhfubdX/b4KNA3KDhtD15DtLO8619FhzkzKJypkUNdAwJcZIMpGm7odcr
         NTvzqjGIPCUNM3THAnrppe1n7rL+HXJ8FLgEeQenThmnTtliUh1jD3ouIxM6F/Gll8xI
         U1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hWtEQgLWe2dUk4REriFzk67sFGYEf2GENq1G5qE0B/M=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=UEKk7t+kXg5J+Bcq4Sc4A7KrMfUqW9VQAnew5qh/wx+hyWAkpSW4HRC12sv2TkQuwN
         M4MvbVkzz8bWbdUY2hqFBf9QK3Ll6kvLNlancZsSsYIj16QPVjd0jV63uofqUaGvIm2u
         yQWzdsgAIV/13WdZKIcaF1OjH1GatePkle/lrnmn2pKj1I8ZH0EnZYqLzu8/h8Hseevt
         OvQfMJEwnT5Zv7/5oTSn5H20A4uSUlM6S11FFUbEoXOLDkotNsAiZ+YO/xN8q6hIyR5B
         z2LaDfjxFYG8i0fYRYJotTkQenfvQaoPZmVdMQdmJxZXxjXfBgDMeBFF7R55jNsGvr6J
         8LJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772718868; x=1773323668; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hWtEQgLWe2dUk4REriFzk67sFGYEf2GENq1G5qE0B/M=;
        b=F2SUC2i/V16Vnp0MQMsxG2ZaKVVj4fG1NPo2qMXt5qZ4/6pSn+oJI0Q3J+Cn7zuoLw
         qBVoaICHwVrYEV6cn5l4o3JdqFqCyVFuNnQM1IOczXGFRiwsTX4BGnrmv1KZSBPARmM4
         zmTeoEU1vXcSjqEJ4dIBb8roZ/Y44Xi6vLEWBYY7WNd40hRiBH2cxtzi4KX2VzAOP6qg
         E0WELiWAfBtsORYNYsCLfSlrF501H1Bm0ZZAvoxJ9ioH80zW9IzwPiKIlnAa8oWQJnXY
         yv6rOD43hDhhYnVy/BdJu5vrag7tIGPa1TBOSC323B7MkzMaAGjfL1xjsoaYHl+NieN/
         yWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772718868; x=1773323668;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWtEQgLWe2dUk4REriFzk67sFGYEf2GENq1G5qE0B/M=;
        b=isCspbjKFHvbM1NEBffx42V2CVCKZvPj6cFVBm/DPQ32s24WZT5OdBiGpU+0MIk/YA
         H3JkpBMd3RGGVbZNAStGyvzNPcglqEmX94fowOH3/p1xkPF7tp9G7MEUj/tuBbVSb9l7
         alBL5kjjM9crrzhYk9QerqRP15T1qKNlbWqeX6oPIDzMUxwD+0UEtRyaFH96aFaWvz6A
         5JKJvsBA/zgoxPvJhbBtVRmb58fOfzI24UXOM9cDdjbtw5qZZlvSnBeruihqTHoAtOHF
         K5T+rzGaDUEvyfXjrePLJrWDe5ylafdP0ZrTSlMNyXm7OAc9kRB2D6kIVqmxXBvC825w
         gelg==
X-Gm-Message-State: AOJu0Yxl7AdVx8f3/ytZpRniBxJ/j9nAbPLqYSI8x0kKz/A8EGhTjyhq
	HxcQyNrJpczo+POI69bqlZNqTi5YsrtQ53C7qsszj1plXC5LWDvLNCxE75QyAVrsvNjA1rhQttX
	mN4v9Qqijn78lJzFCievx/MekqsBQL8YmUM+S
X-Gm-Gg: ATEYQzxDsf9szs5AOoVxCG98TiKkTj6eSzOTOkvnYZCwTBITDotDSWpcuTfKAy1ukxa
	1/RUC8GPjcxaWtVeM866q0f6M6E3vUCNdX/jBqPs21/WAP6vPLsH23Do2BUVPmwmFfjawS3xoye
	NBlIHgRTKaonAMSwg30JttYdDxePsBM8pjQQV1sMBUYqiBZCcvzJOxfNhC8qWko8s/cUa+6K+Is
	aGFdhnh44HyhzmQS9/4s9u35MwipXbLsJ5jw4JNAhoQCSRJIGrPeh8MX2WGBkMajT5Q51c28q22
	mjF5obmR
X-Received: by 2002:ac8:7f83:0:b0:4ee:42e6:a5 with SMTP id d75a77b69052e-508db392109mr70969881cf.57.1772718868570;
 Thu, 05 Mar 2026 05:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farbod Shahinfar <fshahinfar1@gmail.com>
Date: Thu, 5 Mar 2026 14:54:17 +0100
X-Gm-Features: AaiRm529Uye6H4IP_gKYPjWFs-i2uzpDk-zwfzgw61Xj8kF8ZRvLmqg-395MJ_g
Message-ID: <CA+WLDByd8qeUpVBijKooyZkBRB1iwGT8fjUEUKXgQEFAZ_pzHA@mail.gmail.com>
Subject: bpftool generated jited has unpreventable jump addresses
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I want to prepare a CFG for a jited eBPF program. The output of
`bpftool prog dump jited id xx` reports jumps with kernel memory
address (e.g., `ja      0xffffffffc013ad2a`) and it seems impossible
to infer where the destination of the jump is. I thought maybe by
knowing the base address of the program, I can manually convert jump
destinations to relative addresses, but the base address is not known
by bpftool (As far as I understood looking at the code).

My questions are:
1. Is this a real problem or am I missing something (I might be
because the bpftool already reports CFG for xlated version)
2. If it is a limitation, how do you suggest to address the problem
(if it is of interest to others of course). My initial guess is to
return the load address of the program in the `bpf_prog_info` when
doing `bpf_prog_get_info_by_fd`

Sincerely
Farbod
