Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361E46D089
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658349; cv=none; b=RSfEBVXefBNSKtZlxcyPLgG9TwNbGjBkpOfR6zEX7FYQkPClV+ftjiP/tS/1uQ1hIAyxonSdZXDgGGoAm/gKFIlZvHo4VisfqGS+WlfVBYDD3Mmvj91wMIPLjmrHVFtWbQNruKa4s+Em3g5c8FEumA/UtGsoGJ4WHL2h73tGrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658349; c=relaxed/simple;
	bh=SeQQtojGt29p0HQnBgMK6DLzlAvRjRZawe7OxD4XFCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Wb2xjN5J1taBPTRGvNV/tmW7ALIKL2dQlKV9O5Jje7z6M4dvF5CQgqjQaNENdz17phJ0AxmlGwoFbpzgxdFHHKew1jgeuSysdZMHYIQLizqcVTL1TwQCxLv1mzkTn16Y2+mcrlOT8p0gI+GhvnWo+rqHDOv3Na9JtR9grlqa4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFvXHKer; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFvXHKer"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-49550b004f9so11885325e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784658346; x=1785263146; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SeQQtojGt29p0HQnBgMK6DLzlAvRjRZawe7OxD4XFCc=;
        b=AFvXHKerCAFkaYisw7yGc94qEDH6/A2Bh2V/dWp5TxLKPqYDP0AGdvYjdyshWYkO6l
         ukenp2NkLDNeT+Mxkva4XTKb90lZahmlQx1ITYW3OCt/E6pHRmeF9cFtwBBG/3czuzG1
         /lkpbiDYsxIsTyjmgIVRsrjjKBNCVepmRpD5OEJkLZcBqyLWJ2ZBI/B/w9ApwaLJCpPU
         NdCLhryLxwcsdaJoHi6mKutf4aqXCf917lJWO27+Vf1dtSVngKN8k03s0umiuinNaNYw
         alQyatme830+BdB551wiGYmbFfdFbkEcsatUQ5My213FbWKnaP9ewWNAoimJpq/EGcCp
         D+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658346; x=1785263146;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SeQQtojGt29p0HQnBgMK6DLzlAvRjRZawe7OxD4XFCc=;
        b=HHCnypnIwAcMiOXuVjBRgHdVDCBxs1JW85nqzn9ksg5wiQcfDgr3q1KjJcpQQhNC+Y
         ko2pbnbOPUSbMk0ah4OoTUGAijeag/P7OMFU493/AjuSLcM6+FNQ5KgHOp17Cm+a+xHU
         J+V1I8ocAZKCNOdDak43OaS74ANAmLM8j/2Kao88IFHujdaB8bg8OBdSf3sPShpYYAVl
         oh0Ke5f+mc2H0BPVl1wwFnzeMfleTSf2jeazP06z8T9oy9/vXNR52lkXvNmoX8h2dxd4
         GfQ0hczeJ7fcv+5jRNG0YmmcQ87NSMnfONw/HUnMGWU/qrTS4vjHQh8DuIBIhHRa97B8
         R9Fw==
X-Forwarded-Encrypted: i=1; AHgh+RqSuQvjlcF3KM7DLoijtLW8yTOrLnCLxmtY39Bsw7eQ18MO3f7J2Dp4MC1BiSQYOb+R3Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTglCgbG4muWojRVRFzFV4q0dlBIyT5AAaR1/C+iJMYBClJ1l8
	fQqvEwHYRPp2yWXQK0OViMy4ICBpA5Kl4J6vO2147x/6OH5L9/yaZjWR
X-Gm-Gg: AfdE7cne20mxw6+ctpLOYdOaoUMsYH9kQl5t9/7nhjev+D7RpRiUAyfeiO+geahYkgU
	EXsyuFimJoqCd1jVzP7SwS4QoKrZV8J93QGwAyQenNKCJ+fPc+NTOpFDg5TwK/ty6OhezsL7uXE
	U0yV/uHAarF+8mgQSqJh6nXIp7Ysl1WkUo8JyadeVBKJ2FAfqIGiHS+FM4bOf8apLhH0mcMz7rV
	wmUtapCJHhUNxXtDYrMe9++W4ZPWj0bKATvcUUAtOAkn6jzP/jxrFFWvEPQhKsgx4CGUGthZqfN
	fTk7zF+T0aaqPd26N0isu8Mp915gezpFPq79eqBaN5jC+OelbOr9/DHc1p1bcd078a78CaJnz1f
	W2vHe1L4BRMp1JwMgMDLa07uM1/4LXQBmbGxT5R5x2+Wm6E2+f7q+g1yHpRuaxzLQVmcqb8i2JA
	/5TG655MmQ8/wkFszo8wC5JPCalJ9SYwLhxJmUjyHKlvFAc7Th0X1QJouJVK5lm7GFj4lod7SSu
	Hgk53q7hk1akFkmE/zKkGxtW6BCf62SJk1nAPR8a3FQ
X-Received: by 2002:a05:600c:48aa:b0:495:4589:cea6 with SMTP id 5b1f17b1804b1-4954a516530mr139259715e9.34.1784658345726;
        Tue, 21 Jul 2026 11:25:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e496ffsm40416461f8f.3.2026.07.21.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 20:25:44 +0200
Message-Id: <DK4GL1CICEHY.10XAOFWAEHJCJ@gmail.com>
Cc: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] bpf, riscv: fix extable handling for arena
 load_acquire
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Feng Jiang"
 <jiangfeng@kylinos.cn>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Pu Lehui" <pulehui@huawei.com>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>
X-Mailer: aerc 0.21.0
References: <20260720-bpf-riscv-fix-extable-v3-1-e9a603882309@kylinos.cn>
 <87h5lsurzn.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87h5lsurzn.fsf@all.your.base.are.belong.to.us>

On Tue Jul 21, 2026 at 8:17 PM CEST, Bj=C3=B6rn T=C3=B6pel wrote:
> Feng Jiang <jiangfeng@kylinos.cn> writes:
>
>> emit_atomic_ld_st() returns 1 to have build_body() skip the zext after
>> a sub-word load_acquire. The caller does "ret =3D ret ?:
>> add_exception_handler(...)", which skips add_exception_handler() on any
>> non-zero ret, so the extable entry is missing and a faulting
>> PROBE_ATOMIC load_acquire oopses.
>>
>> REG_DONT_CLEAR_MARKER leaves rd stale on fault, and the verifier still
>> thinks the load overwrote it, so a program can leak it through a map.
>>
>> Check ret >=3D 0 before calling add_exception_handler(), and pass rd for
>> LOAD_ACQ so the fault zeroes rd like a PROBE_MEM load. Return ret
>> unchanged for the zext skip.
>>
>> Fixes: fb7cefabae81 ("riscv, bpf: Add support arena atomics for RV64")
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>
> Thank you for spinning a new version!
>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

There was an identical v4 resend. I applied the acks there and pushed.
Thanks.
