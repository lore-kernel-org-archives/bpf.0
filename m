Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCBE38AC8D
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349250; cv=none; b=TbqGx8Io2YGMLrEFaB/PHtCACkvV85zmEknz16p+tS9zYIIpfNiyLfX7fBp2rRQMGQCWs8HdrSCAwBFPN4GVGs6YpKj2C72/2TGSrRX9AqUqXknIWP+LytWtEzfHV3MvMrg76FmdjK4AjsAgRWGWQkYy9nkCsql98GwKOpHwpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349250; c=relaxed/simple;
	bh=Cm8X8oO+StodaQugrkcl+CurhzUmHXJeAFJKFpKiE6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emD/LgQfG1AUr7mStuAOyufAz/KMRiAMCdnb8JbvyiIKeoGdZ733fInyv5IAB/pSf8lHFJYFcS8tL4Ig1PrSwHNg/eroJJ6MXLbxiblLgrFsFJ+aG9zWNjQU1iKVIoltedUkaa6vZFmnv8nxy3YTyN1B2ZeQ6k7Tptj7KwioTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvh24WSp; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvh24WSp"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-842307472d4so743063b3a.0
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781349249; x=1781954049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4vnBYb28y9NHXRF9QIW7nvIND43NIMgNnFPioFGvEQ=;
        b=Uvh24WSprj6yxlbQgnE7xnbNVzWspQd+eI900ZGJVAc640K+gWmnGOk03N/ksMkBMX
         tZLaBAQsYyFPzl/tHW015bNI0K2Bxoh4n5u5L30PlN0TVTR30GKGNADkGhb86vojQnOb
         5H0pXfchsEXQ8YG0iguIG0VQX+MzHZX3yiOdZfuYmncilPvpIBaSN5JW6Q86F1iMzUok
         vsVCFCw8ROe0ttrI2grRMiIlBtSaKUP2AvcEPF/yPSQGw82sszHaEX3QY5SE2gFGnEzz
         rb1ypdZak9gud6t+m0iRj02VlKOPmKdkx4qBim9feCUmEbFrcNEvdMarglZ1Rgd4hx8S
         +0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781349249; x=1781954049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X4vnBYb28y9NHXRF9QIW7nvIND43NIMgNnFPioFGvEQ=;
        b=LjDY6zV8uVLruawj27SqpQioepF02vcr/1tAhQxEkGdjJCsSdp+WPGwTxFIfYU7u/2
         CO7H9dLpc0M7EUaKE4fP82NwbgEJiDldvS7lwesLPavwyAcf1AlHcSETQW03Yb5E5bNe
         tpmx7FVmJXuwqzndsDqg27BrBjqSVqgN6PdjdtMRSVhMMm0/eq3SyMgIp1kz3mXeN8Zc
         /Ze2TD51wU49Pi+1hswSXlBh5X2NbFUL37zOOLWyr+ZhbeaIecodT+zlzLc7acpQQVVf
         BTaIg277idpcqftOeav1xrREQzvvvVqs2JRYrt5W2d6ZMGdZav3LG196UM3BZQh+BQOU
         vYHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gLTSe9qYM99xCyR8wqe5Y0RsHPw2J3tWve9Df6GD8c3ZBe07i+CTySNq5pUHcihWeCqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFasoej9TesyIuSxvQhN/aa4ReFsly91ifovJTQ5ffyo3ZsNud
	be8O2md7XcXLR3tZcm7sh0Wv/wu2qxLUiQKV6hOJXZcp5oslguWSvlEpwcB3CHaL
X-Gm-Gg: Acq92OEl9IKrZSERfNOWMWrUag5cpiJJqwwbr4pE8bYv9XUk+oGaNPAvxD8KlfAcLBL
	GW97uHR3CLGuTCaFjze+F1a354+nDyJneJe4gXZyOoSNQz0afzxoWo9b676LT7Cosbbf9VCwOM7
	pYUipcD0DymE6Ye2xqnQkp+LlsD34msNQfHN876mrVhNMLU1Y20A9aTTYuhlom6C/rQBC8OGkwO
	ZuaXsPEj/GuYTnQ/Lbmpj+mJ4ZUfmCObEViwhqIfdmgHYIJdGUw4pbiTCFX59xdNb4uT2Ir/1+M
	I3DxtriiecGAjpdX5KkdMsWcU5BSfERrsb4z4e/PvJ7iA/iekDH50SZbODeGabvGnc6gPn11J4z
	/XkB4Ny/QALdUzYro/lyGDONgttwWUQeZ+cEm+CsnWwRVFCeUZolLJGDYKxami9O+O9pzKrb2bc
	eJgxCJFOri1IN13qX+Sw==
X-Received: by 2002:a05:6a00:12c5:b0:83e:3050:d0b with SMTP id d2e1a72fcca58-8434ce50ddbmr7210978b3a.1.1781349248972;
        Sat, 13 Jun 2026 04:14:08 -0700 (PDT)
Received: from laptop ([175.204.13.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b048496sm5129411b3a.54.2026.06.13.04.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 04:14:08 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Track spilled zero scalars for var-off stack reads
Date: Sat, 13 Jun 2026 20:14:04 +0900
Message-ID: <20260613111404.272232-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1e223d73e52d06361de599d588bd53b01dbc6f78.camel@gmail.com>
References: <1e223d73e52d06361de599d588bd53b01dbc6f78.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 12, 2026 at 05:13:05PM -0700, Eduard Zingerman wrote:
> Nit: Instead of looping over the mask here, I'd extend the `bpf_bt_*` api
>      with something like `btf_set_frame_mask(&env->bt, ptr_state->frameno, zero_spill_mask)`.

Thanks, done in v2 with bpf_bt_set_frame_slot_mask().

> I tested this change against a big corpus of BPF programs
> (selftests, sched_ext, Meta internal, cilium) and see no veristat regressions,
> despite this mark_chain_precision_batch() call.

Thanks a lot for checking this against the larger corpus.

> Please add some __msg() here to verify that `r3` read from stack is
> considered to be zero and mark_precise trail. (In other tests as well).

Added __msg() checks for R3=0 and the mark_precise stack trail.

>          Why additional spaces?

Cleaned up the inline asm formatting.

> Please add a test cases demonstrating the behavior when spill size is
> less than 8 bytes, with neighboring slots being STACK_ZERO + spill or
> STACK_MISC + spill.

Added both cases in v2: a sub-8-byte spill with neighbouring STACK_ZERO
bytes that should preserve the zero result, and a sub-8-byte spill with
neighbouring STACK_MISC bytes that must not be promoted to zero.

> > +	"if r6 != 0 goto "
> > +	"+"
> > +	"2; "
> > +	" *(u64 *)(r10 - 8) = r0; "
> > +	"goto "
> > +	"+"
> > +	"2; "
> 
> Huh?

Replaced this with local labels in v2.

Thanks,
Woojin
