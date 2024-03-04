Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE021E487
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570743; cv=none; b=KeMyK4xZCN4880lugvgKfcyF5kWsEcbNcP0VmYAD+7ma+oHEcxO6IYKrhMvsI1gEHuEUTsMZPFzZGXFNQzR1ytzaszSpTXzVH8MYpVlvS1WUem2DpMB5U6BVmaYgm96jscc8zbW9n7nRgMk+qpomalnxdVGSAnmQOuAPsUPkftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570743; c=relaxed/simple;
	bh=3rtWwzOhsfjc0w8KgfhSL4rEZRGO5Ok0n+hzfwWwBwg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qo+2dNw0o3d+9yMBAOu2un+DZxv9nmxYVIfJ/M3sfUSpEILrT2MxY+mo2OuYq+BwVlZler599DJu0QbrzROExLX5XtVoGyTGdluYXxu1SB29MZDmGPPQR+0TfDvJDj1CNN/sqrRcMw7uUdR9sWNrPYnV+JwCJtzAVfx0XWSx+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZTQgPFRR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZTQgPFRR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dca160163dso45431025ad.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1709570741; x=1710175541; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AY/5+NRl0HgmzZtWxTsevOYhftjaeTdyYmJie74+MAI=;
        b=ZTQgPFRRgtIqdGNDVStFaG7KtXbHpoocMPm9+SGuaMTWgnQz+kObJbZ6mkfWIwoCO1
         SHGhVBejv2nIBes3tgQYxH/lfBZfNCB2k9ZJ4rBGEvFtHO+3ls/P4ikPKmtA7qk31sJZ
         nyvm+4X3Y1j38FpKA6CantC8DFIfJBWoQoa5U6lDFrjZPNTRi1yBfMIaRc22MY9mWbhu
         43x48KFmy+12tZjseYgFCMZ1Hr3g1vun8ojkirICuDUDOZbnpmOCKc7Gt220MhaPwj8I
         pyISSlGmebsYPeqg9kp45/dC9k+Chg2cS8NPohYYN0STMDXpIg4bmRJ9uWg8gTh7o5+v
         XqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570741; x=1710175541;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AY/5+NRl0HgmzZtWxTsevOYhftjaeTdyYmJie74+MAI=;
        b=mASNjLZZVTmouTjYjmo85xRu0jvaimcyjJ72pRdIU2DAS1Y0G8S/bmlZAmnu/PQPPV
         QsmycxNc2AQj1M/q1eTa0ieSXzb/beE8fE5zyFRv2QJ3A1Bja4X8SZt7LXP8/KHOpQxZ
         wmU18AYfQk6acFZ1FyJyjMI7sRBXT6yxnSGDJ5crDfm5Upkg8tO98uurxidGroA/OQLN
         83BXswsZPa8bTtgSRkqzj6kUZxILBjj7pJcD6oZe0X+93M5gVwTE9ZZfIkgDeycw7v2P
         v5AuziKBiIozK8TJo2+r5g89uHaokiRGYrO0Ipqx2YMKgH14pjD9wDpqOpRcVZIqoa4U
         EJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCVbXHiNpuwUZ6sTCeeEn21tBjhpx0iX/BI3qlH5zTi/yYXAXJYUFPvxHm3Vb8hC7Vb4pCPcvmQN9FXVY+LS/u5TWqfd
X-Gm-Message-State: AOJu0YwbITe6w/K0egAu60VVi3o0/L2zw39Vhbuo+ZfXXWPx47CIOGJm
	9BTn663Ms0md3Qwm8qeCoitOc96k691buboMVOV8SvAbQgTpR3yPXXa6CaCTAcM=
X-Google-Smtp-Source: AGHT+IFwawskSsv6Jh5u8pbNybwWMPTyi+5u1PnxadDvQasybSWmSwyhOTU/vbjAZzY4sNJxTo1wZA==
X-Received: by 2002:a17:902:ec90:b0:1dd:911:19b1 with SMTP id x16-20020a170902ec9000b001dd091119b1mr6811682plg.19.1709570741457;
        Mon, 04 Mar 2024 08:45:41 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001dcb063349csm8742837plg.150.2024.03.04.08.45.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:45:41 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	<bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>,
	<andrii@kernel.org>,
	<martin.lau@kernel.org>,
	<memxor@gmail.com>,
	<eddyz87@gmail.com>,
	<john.fastabend@gmail.com>,
	<kernel-team@fb.com>,
	<bpf@ietf.org>
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
Subject: RE: [PATCH v4 bpf-next 0/4] bpf: Introduce may_goto and cond_break
Date: Mon, 4 Mar 2024 08:45:38 -0800
Message-ID: <270f01da6e53$63e93620$2bbba260$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIrhzy5buaETn6lYveEMKT6QgkFX7CFl/Dg
Content-Language: en-us

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
[...]
> Alexei Starovoitov (4):
>   bpf: Introduce may_goto instruction
>   bpf: Recognize that two registers are safe when their ranges match
>   bpf: Add cond_break macro
>   selftests/bpf: Test may_goto
> 
>  include/linux/bpf_verifier.h                  |   2 +
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/core.c                             |   1 +
>  kernel/bpf/disasm.c                           |   3 +
>  kernel/bpf/verifier.c                         | 280 +++++++++++++-----
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../testing/selftests/bpf/bpf_experimental.h  |  12 +
> .../bpf/progs/verifier_iterating_callbacks.c  | 103 ++++++-
>  9 files changed, 330 insertions(+), 74 deletions(-)

Don't we also need to add may_goto to instruction-set.rst?

Dave

