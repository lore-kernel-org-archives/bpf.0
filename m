Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72F43CEC4
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132424; cv=none; b=QKHF9gEMasrooDmVRTKIE7UJI3nfWA9YznMS/6TpbZR3vHqcdqsYonEZG20BI/peYA5cAuNt0kbmlYGlTq5hdSPpo8F1xx1sTrbDh9C5FduX4jkkmAasdbtSN/IufEOEACaAmQALbfENr/VbM7AWMmVuo/bh3VNY4LTXvUYp+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132424; c=relaxed/simple;
	bh=FRs+FMhFA6Qm83w4P86kWYPWmbIIPfB6uSu7tErkGiM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bvi3EolIrlFwDjAsfSsPnC5zpQ/MUYuwrb5vxksFvl1EBlT53NeLIikJY48apcOVluDuCfj733zLND2T/gTbCUtmRlCDW7rrbMscNH9tBfcXLvDWST6X7HjWf85LZIaaoGdmPwpju75KeXbdkqxyDVlIrj/fDnx50N0B/NpXckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp1C+gzh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp1C+gzh"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6f306faaffso454283a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 11:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772132421; x=1772737221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRs+FMhFA6Qm83w4P86kWYPWmbIIPfB6uSu7tErkGiM=;
        b=Zp1C+gzhLKxEKVTub0PFThMoPn5NUkIYqHvHuImNFn0mf4TfTBPqVJ4dqbdGfxR+nL
         ha1goH+Vk3hglsCwnIaVnYxnWTvCFUVYPw78CwzOYy19FV5hG8X17sJLO222OFTUjLUh
         StA8zjiTOctj6//HZge6Qqly+3nujLvUSAtvIiTmXJh0UkPU4milbD5O28uZ+wR4Geer
         aihN/c+gQTPHgzcMt3Fk697MRHdYRX2Xtkk9yl5HS+SKID6SgMU1s464IPTUlFJh/2mO
         QP6ZTdTWZ7/c0ydSVQD1itpKQRrys9dODfQtGFTEskn8KXS2eoTn5TF5BMJoo95vc2+w
         F+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132421; x=1772737221;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRs+FMhFA6Qm83w4P86kWYPWmbIIPfB6uSu7tErkGiM=;
        b=uXNs7NYnGoomk57dfmS+Pnsk4DBMDSOvT0he8mRSvj9oaqHbp7PH9maWyC6nrLnSM3
         R8EH0+EEo82fotxDgjp2e+h+nZCPDWcOpXzeWqfCl+0lJS7arWoUSHkAwoPL/5ucVq0I
         Jo+EgRNmE5VrOTqwke4lV5iM5oQ/a7/zXSLtP02F68SGKTxG3zTp65ysMLQj+/a7rGnw
         kr4NAelKS71NtcyRjl7+vLDhhNCNKtFLQ8WMbzRqEry2ODMS5vceQdTxtj9orlAH8fFA
         hApCdRfbrO+QL+jpEnElJPoXlxyxNbnjzLMI9a++B2ydD57ZfHdwIEeWJ2D4pJywnUMP
         2JRw==
X-Forwarded-Encrypted: i=1; AJvYcCWHMSG2sBFK68Gkpm8F4wNrKkx0ixupVfo9g8NrHeFMMnuwDCml8utM3585hxTRnTuNQUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wGAppmiEigSK3R5AbXj6g+hLy68mPWQ2G7J0W9Xpu2WBBSMO
	2wjLYF7wFxom+z3JfJIE1LB+RTtOYN0jOfcWkUFtDig6M3o/K0PVBL4E
X-Gm-Gg: ATEYQzz2O/gCQWjt+W58HB5Gykxqxrt6HumrcU5iBncjvSO+13uMXduk/2crr3EKBo2
	U5GEaZ6IR779VOmoN/qG6+ABCc0+Eo9wngvWBUERJt5TDF9R53hhuGWvoUpeqk6avl2LKFgQEvC
	cmFOza6Yg2DP0aGf0AdJnrWcpMI1otHdwNPF94cdXk5kVROaWg3EqPVudpuAPuEA9cpGjDpJYhy
	zrvkHZd+nTUXgyrHcO7IXlp2y0HLRdYXBf2T8y+/npl4Z5pBjK5S2Za2tWCrAl8NGkVkgmVF47I
	4TAvmg5YIust5sn37iNpMfVOljyKJaOTQIRKC/baHHzK4w1731thuurfK2OCn6Vl1eN1HpF1vyb
	fTgCLq2eAA4FAgTAOQGH43y/M6yuWuUquprV+eOrnz6trAr5ZsmY2WCGqdDhwIUyPWECUAzjfaj
	didYGi59j3InagX1gDynR+CNDGN/69/hL1AfEDXOpGB4k2gJV3s2I=
X-Received: by 2002:a17:903:2303:b0:2aa:e570:6e6d with SMTP id d9443c01a7336-2ade9a85338mr50979555ad.40.1772132421279;
        Thu, 26 Feb 2026 11:00:21 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dde70sm32181945ad.38.2026.02.26.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:00:20 -0800 (PST)
Message-ID: <2c7d7b8b58beacfab2557533994664b4344b51ee.camel@gmail.com>
Subject: Re: [PATCH bpf v5 4/8] bpf: consolidate sleepable checks in
 check_func_call()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Thu, 26 Feb 2026 11:00:18 -0800
In-Reply-To: <20260226161500.775715-5-puranjay@kernel.org>
References: <20260226161500.775715-1-puranjay@kernel.org>
	 <20260226161500.775715-5-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-26 at 08:14 -0800, Puranjay Mohan wrote:
> The sleepable context check for global function calls in
> check_func_call() open-codes the same checks that in_sleepable_context()
> already performs. Replace the open-coded check with a call to
> in_sleepable_context() and use non_sleepable_context_description() for
> the error message, consistent with check_helper_call() and
> check_kfunc_call().
>=20
> Note that in_sleepable_context() also checks active_locks, which
> overlaps with the existing active_locks check above it. However, the two
> checks serve different purposes: the active_locks check rejects all
> global function calls while holding a lock (not just sleepable ones), so
> it must remain as a separate guard.
>=20
> Update the expected error messages in the irq and preempt_lock selftests
> to match.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
