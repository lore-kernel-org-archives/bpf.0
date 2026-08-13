Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B8401A14
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651157; cv=none; b=D4rNOz4IF0LMtcmXKNqKdV1SHIoTu2ephHSF1H3Ivl6raH9ji/V/Rwqt3+lI7Zv/+MPwGpEE+gdWomKicopSewiVlfdeWMtr5Bu7RmB7PlOscrCDXr/kRRQ6BF/eae+1Rh3YrCCJQuMy27xBvUIqxUoRkLKc30KUEshryU45Nrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651157; c=relaxed/simple;
	bh=vCe340irRwUrQ3jVKZtVcY0yLwsMzZxJz5j0sXvHMhE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CyciTLVeBYgVTFTWXizKmemR2lU7gZcPmJDJNHZgI3HWVyu4O3Dq6IYiuyQtgwulFIsGtDCj2+TDt24xgfFk/Dse/xLRHHL51uv43CZ8ZsS+hZXeuGYrdkduCLoeOmpK1sIfTC9PtitrU+/dHVyf5YaeCmVnF7we4qY1TxAXPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga6g7tWq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga6g7tWq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caced6038eso2711685ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651155; x=1787255955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fXJaTFfzEpWs5At4fpNnGeQO5AVpz3/kTgcXBbsWTDg=;
        b=ga6g7tWq4jRTxQz+ECfen3P0rv/+Iu1ydxXFwOymB1n+ibbSpE+siE8mkWSL+4IolJ
         vQyt3hyoxi+xmxz+LATrisQaRv2HAdS0sUe5reMCwra7jZcYRNgzJaCmYw9wuviHtr4c
         Zq9QWWhpH1BcVy8VdEkoiOtnRlTG8TZLVNvHoz5bcl8OtM7Ifn63P1Wdj3dLc8uBdp+K
         ijZuUIAZZ5JTfaWOeHL2IYAb8BdwddK4j0pV6/K5p/jUZCEir7oKGGXJqnKxpKZYQwKO
         K2GIG5mNZNoQi5P3EVJ2ET7V1I95K7OfbEYooxJ2oEg9GJ8RiNQUxlFQrZ1idStqQvM4
         R5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651155; x=1787255955;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXJaTFfzEpWs5At4fpNnGeQO5AVpz3/kTgcXBbsWTDg=;
        b=G6XSGzgdXKu8gs5fnK9LQjVc6z/ItJRLiq6098abfOQupMIAkS0h2wZJmr5fsPUwvS
         N6ouPONZLGjzeJU2dwfBQfWd8LslGKBBw5sutgIJ3XBQe0XN1eUx9W6C9Cyzm4wGev+K
         HNVMTbOcYyDS08uBOtik1w/o2evIqNwrKPuXXG1S1F+tCXi7KF9NRuqdRUApQ3f5nhLN
         n92XYd1qCPxD6/xEsuk5vhaMuQgyiU4mLAZ7AXY1wqz1h7xukltIApK0aTJ14FYhJxR5
         Lfp0g9yAWTlfx6f739RdcL50XUZuI1oWOTsqD1pe1ORstnf2C3ao7zfnzZQVm4J5Qw6o
         62Zw==
X-Forwarded-Encrypted: i=1; AHgh+RqWl5zKBGA1rHO2uhCnpuUUlyf0Vy0G/Gd1WHhhAEVkwSbPuNjAn+l+lQmRcVc4JLEQhsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6hZIJdVWhLGHpFyDZ6SwLdH8IBgD6t2TT8LF0wPBD/pJT6sV
	VBz4nCXV9dph/qsf4JpOj39xv/T0cQEhdo9KXn5aPFM7tMpi9USz1c61
X-Gm-Gg: AR+sD12DJiJW9jo9PlfeIyrrEl0E4dOMotJEjPQzOPi+1ACQuwWA9/cbxPINAzL6La0
	r1Hj94QvkYvt1N8x9GqVSorg0xzh8NT486f8w8OxSlX5IyouNX2fW9SPaG3MtLOHEjHsT2MDG8A
	y98Kxr6BLkjIVRNfc9CfGKn/EaaHXgO2NtsGtu8/gOv1ufsKenunEIx7Dq01W/lTDvSTqdP+ew0
	GaxNT6xRh/G8C/voUNB8JDh0FzWcxbphxse5VnK5Um6FAD9veiZCqT4tcNw2Awyk4PVLj6p3m54
	Bzb4LhTb4Xf2s2AEEspS6P+LRs2Zen3U5GR7q/nKGgWawX7E3E3iIyKU0S6FrjM1dLOv/j2vV80
	ryMrQmgTC1/eEi57tB/nCxR5u+moY1uF1Tj+SrUVspySstwOEvNI83AnMFVx2wZ6WixdAgH55qW
	0y0NmXkBKSlzU1M3Q93WdkD/9RMcmb8LHut7gtLE4EsWoDaNwm91OimwFaAwOQvjMjeKldTnYjn
	DXVroopOFbOdS1Q1UookFa+CH4IokPoYcs4vO1WG72+Hw==
X-Received: by 2002:a17:902:cecf:b0:2cf:7ea3:7cf1 with SMTP id d9443c01a7336-2d37f62b91emr94898875ad.5.1786651155511;
        Thu, 13 Aug 2026 12:59:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc75d891sm10884953eec.5.2026.08.13.12.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:59:15 -0700 (PDT)
Message-ID: <f5d12962604311c26aaf7fdf7ac5d394d0896258.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 10/16] bpf: Report Resource Lifetime
 reference leaks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 12:59:13 -0700
In-Reply-To: <20260812233326.3575958-11-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
	 <20260812233326.3575958-11-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:
> Augment selected Resource Lifetime Safety failures with structured diagno=
stics
> while preserving the existing verifier messages.
>=20
> Report unreleased references from check_reference_leak() using
> reference-scoped diagnostic history, and add state reports for dynptr,
> iterator, lock, and IRQ-flag lifetime misuse.
>=20
> IRQ restore mismatch and out-of-order diagnostics use IRQ context-scoped
> history when an IRQ-disabled region is active, so retained save/restore c=
ontext
> is still visible after per-state history removal.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 080c6b893fb0..24ae3cb38f6d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -7136,11 +7158,13 @@ enum {
>   * env->cur_state->active_locks remembers which map value element or all=
ocated
>   * object got locked and clears it after bpf_spin_unlock.
>   */
> -static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg, argno_t argno, int flags)
> +static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg, argno_t argno,
> +			     int flags)

Nit: churn.

...
