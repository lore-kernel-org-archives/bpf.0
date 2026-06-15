Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803F3D3329
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543945; cv=none; b=lgho1Gw6B4aETA3U0IcbI0oJppX//M0he4PYy5ovNhF5KjyhdMdSBQWelBKpCWNfDIN5bA0gQPk/QN3tINnZvIfkLS8zwGHCCZpfJb+jwHNTrRMIhBwLj5MD+ZZErc7IVgAHilr1SY+4nbN9jhpEnW2zYsm/kMaXULJX2HiHqjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543945; c=relaxed/simple;
	bh=4Hgp1eZaIIZlXcpvtWbU1jde9U+H0EE4XG+fFfe/s4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D+Xhwjlq7o5Af1VGKxnXC12JiyS8CmEsG0a2THk69t+stIsTkgmHJ2+ZzChDZWoX8K/bb8gPAxdZzsj6NwdvqDSy9KKGUCYe18KsB0TGc44k2IB1yhIYQO+W6ZzWQSXVjTyx92zPCXQG6ZcHRhKqbf+hZCJZbRHh2h5jY20jWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDc7Eo95; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDc7Eo95"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30807ba471bso10234517eec.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543944; x=1782148744; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Hgp1eZaIIZlXcpvtWbU1jde9U+H0EE4XG+fFfe/s4c=;
        b=YDc7Eo95BuA3dlU1r6uzobdiuf2W9zURfIY1sFRgMQn08GN2PUN6WeJGHyyNE/MHwL
         DpmowI0NxeBYjCwxZeMP+Kj1sQprhKfeCLjrRlTDHuldebH3bxs/3wx3Go39gxbxhtOf
         uBjjW2FeRKmcap13WuqCvdWP+jfgopO1Wbsa0F2XyVoqo+SIZc9Hc6uudozT2AZ0d7ey
         30DVNrVstJIRdnA521f2c1GyHXOYm3j1loKHq3VbTT9Ls99rTLp0+70vK70b4MDFjK5q
         sPHOygKelhWlfhfc0IEBbyVsusRnMazk1L+sszNofO9V08UMbnuZKlGB6a0XRvSG/gvm
         Pr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543944; x=1782148744;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hgp1eZaIIZlXcpvtWbU1jde9U+H0EE4XG+fFfe/s4c=;
        b=Y9uyu59UTc+9l8ptktYj/NfWNcthskDx/2ISAX+rBSl699v8yrUPGVJizT9FiipAaL
         aZujRDv34eBmxeaItP2GFtLpHx0gOPm+PkZy1zdTB86BOFU1ARIIXacw5IuCdpMZRdue
         wlIFssdsmylDeVB3tOiAGDnMNm38uq1fBmJkAc02MqSwr2QoYCg7wAogRFrTqXsBluVa
         PY6MgvPGfRyEwTnb45Dy9nz97Sndlbx6O1dgCFqr9upWFUwnqQI+1GH9HfH46484RrVp
         zPqbDV4KKYRduZdFzxNmW3SH0j1Vflcpsbwlm31Orrcu6sGaj615F7uLHM/qCDYpihqO
         iUPw==
X-Gm-Message-State: AOJu0Yynqbkk0Uy/zr+Rz29k7eo2/4vWelgWBK36U7MvbdEu/TSeaO+k
	wY0mC5nCvqlNzAZitmOAVX296afHw1i8NeZLKRTyDDd0aHsQF3xUCj22
X-Gm-Gg: Acq92OHLaB17k8lpKgq5Wrjp6BT0plKI31WJVhEsTe4XHL8OqFHVKkQZgaUGMCjJNK/
	oS3MkcTR13qwF4KFvt8Nm/PnBBaOCBrnQ7xOYfiu8/lNJ7va85+NMDtJfIr0tF0GX33KfH8k06+
	VNE7ZSOxHGZcXtzQzX9112vR9oBus+8HvAG8FBoIDzbnju2oRbExppMBWtYaW2Ji13j724+GxH/
	z6vW0thgtD2q7zV7oucrY8zzDMM7zmbkkePCNrZVc/gyqIj8oPzDFtF8UtC5PJ8bPDOcqvG4h49
	74w5y9h238diLb68Yiv+udcdXd38ujyxUOqn+k6hf9nOtUOEGcz+oBVOE80YdEOCWJ70iP9wuUd
	fhh/nEzSdWgUwRxMm7+8BmrGEi4UwnSyN0FMP0gmT3N466Zt7efdmyAWJFRel5iT3qCxZG5M9az
	2cY7C6/EvXFyI3urEqXdWJwPHcHY7OJjhDEg8/jeKXIgjZJYnHSxo483zTEAWVYm7VW20C4c6Zb
	P4RbhE=
X-Received: by 2002:a05:7300:fe07:b0:2ef:9961:27fa with SMTP id 5a478bee46e88-30ba5f669c6mr65053eec.18.1781543943688;
        Mon, 15 Jun 2026 10:19:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:755:4880:8bc0:de02? ([2620:10d:c090:500::3:317a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm16010175eec.3.2026.06.15.10.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:19:02 -0700 (PDT)
Message-ID: <56e68303368c8057227e6f35f839bf6426db9ede.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve pointer spill metadata
 during half-slot cleanup
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa	 <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Shuah Khan	 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 15 Jun 2026 10:19:00 -0700
In-Reply-To: <20260615-f01-06-half-slot-pointer-spill-v1-1-47f1c18a8965@mails.tsinghua.edu.cn>
References: 
	<20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn>
	 <20260615-f01-06-half-slot-pointer-spill-v1-1-47f1c18a8965@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-15 at 16:09 +0800, Nuoqi Gui wrote:
> __clean_func_state() cleans dead stack slots in 4-byte halves. When the
> high half of a STACK_SPILL slot is dead and the low half remains live,
> cleanup converts the live low half to STACK_MISC or STACK_ZERO and clears
> the saved spilled_ptr metadata.
>=20
> That conversion is safe only for scalar spills. For a pointer spill, this
> metadata clear lets a later 32-bit fill from the still-live half avoid th=
e
> normal non-scalar register-fill check and be treated as an ordinary scala=
r
> stack read.
>=20
> Leave non-scalar spill slots intact in this half-live shape. This is
> conservative for pruning and preserves the existing
> check_stack_read_fixed_off() rejection path for partial fills from pointe=
r
> spills.
>=20
> Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
