Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992151AFC7
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113130; cv=none; b=S12vittqpa99fnI1gm06Vr+qLJOcq0rYrk4E44oV3sa36AeFeYHyYI3YciVGaY7SgzfK7yHs4+iqj6+N8nTpKJmCMRXIT9+GSjIYHaH7KBNi0b2dB5we1e2o6y7watGcu86CXyQxDcTAOp3X+LfLXHwMq3DN47P+sjZ26rYqBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113130; c=relaxed/simple;
	bh=sEzwiL9ijNoFviis3wWKQNUlmaFi6MOipKmS7nyL6Jg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gbn4x/lzVu/LLSRoOIlEGJrMHAAsaT4AHlfnqApXxbTsPsGSCsLJefrnl72j3LYDozXNEsrPDlV2huDQZ+VRUB0ts1qKZvnh0kqyRC/OMVg3VUqstKJ7jIVHhF5ZJOxObWerZa2LAE5lb9XaitXQHw2ZRvgP9ScQhDs4lbW6xfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnRdtMJg; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnRdtMJg"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32dec843c37so407565eec.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790113112; x=1790717912; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OoV1Bkn5lvK7PC/TmI/cpzEDObeSFvAM0R+kouQ+wT4=;
        b=FnRdtMJgyF/SFVRZ9oRqZfcgxuajT2iGks8WM46GjiORgedOrc4SmOqeaUIHL7cXPr
         ZFhwVYDmX9DMzQKSQ55qobT/fQNO7RnhkTg0iN9Uah0TrTs/XBSnoEg8SUdyvJusrXPC
         Ot+yXdldORUKRZsgvJsdlAuVKVOp54cUPqX7ba9OkgFPyl21F7bmOkFMT+aURfuOI0bA
         zhimbAHk1TStQa6LKC3xg/8j4fFg3zI7XTWuEOygCbw1dKsD7E/9ith2K6ELGIgkOr3U
         2NniYL4Duaid/hEotNdK0+GNXOu+f/fL46AXMnJtFPEzSGCFUl3Bk+X220rtDjvQp+WA
         aErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790113112; x=1790717912;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OoV1Bkn5lvK7PC/TmI/cpzEDObeSFvAM0R+kouQ+wT4=;
        b=ybcDu54WbL2fiUAoSyh5fz0WQzhms6oZ/5/XnpZF1pXu3SCSyzVlM/d1JqxYo9X7Uz
         OCGDHDgsjgEM5SFxaE0S3XZl0dI8ET3PwjWZ8zHu8iwQDQNo9FkvQVl8X0Kq6HLCQkaj
         jEk5J+USifJer8zurKuZuPezVz4uG/slBWs/dM6ycoRxw9Ii0fV3dg8Km5Br2qC7xUSa
         aUOpLpKONgR5OyktkJUqY67glakDKlYDnSurAfLn1qBqX1d7KEACSDaQb/lG6GDCST3r
         lms7SyEXach1nkxJ28REjlNJn1LdfFomvvoGeFN3tWQsqBJET3mEfnJz0zW5m1PpQTSH
         6phw==
X-Forwarded-Encrypted: i=1; AKwUvBzqs8gRzR8A6z6sHugoDVZq52lagXaKwhWNbDRHzRyO9VqcnvDx22vW7KcHX+VFT0lSRyg=@vger.kernel.org
X-Gm-Message-State: AFuF++nLrH43yiSnCVuFR/QtoOT9O+aByjh9Tfdl/HCiravUrSlms7pU
	qvaXIy+nJUAXKhj4NqS+VxyaJRDDq7D0LN0EVYhUxPIF4HJuzMKu1TyOU05CXCo8
X-Gm-Gg: AYBFou0mCpHiDOLCmd4CFMnZMcvbEADT26W3wHA9rgJIhSqmDzLVyJ5oW/iGRaFN25X
	kAkMiNqVAKfik9BYTOk3KAd2YoK8PQf+loqPl8eYrS+LxzfPsT+R3J4ypy3V2eQFEFmTBBjgwJw
	kj9DmO7QqE1+Lb/lmWY45tL2f1/RBbmEDeTtBPNmwaUj0HLWK24gNwmq/y0DK8ZYY1N5f7nZogI
	7HemZcpqBeKeTnAVhJpjRZ4/joTioZ592d2M8fKivGoLKeQZVAxSwnMLkvT10mILZ2B1dT+SUmm
	bRq9zwy5UW20x8bsxHdVMDYd28+mcgGAoLjHPWwx89wSwWKbvovP5yMiJQOu6sAVClCK/DLcDqv
	vYu+5GjD2xFjTr4humlLmZ7vrWWNWUq+RlOVskFXOTxgXjp37zQbBmLIPxhaHMZq/tE59Md56VE
	6NxquiCFWz2rqpqw5i1GtC6Vxw2Dy6VGCsWJIVRiRkcKW+UlMn23mVHXJlJ6EvXR1OBNx4zPH/C
	ESGAkAQQjPtCfYeTFBH3X+MnseqhWrCABV9m47CLQL7cxS5jVFhrGC/8A==
X-Received: by 2002:a05:7300:59a1:b0:33b:e842:d272 with SMTP id 5a478bee46e88-33e8be6c06bmr666263eec.5.1790113111683;
        Tue, 22 Sep 2026 14:38:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f4d5:5623:3480:5143? ([2620:10d:c090:500::7:fbb7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9bea11b8sm890323eec.7.2026.09.22.14.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:38:31 -0700 (PDT)
Message-ID: <19302dc5c59170ec4980d2757a1c2aa91bed07e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 10/20] bpf: Dispatch exception cleanup pads
 from bpf_throw()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 22 Sep 2026 14:38:29 -0700
In-Reply-To: <20260921210124.1720888-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <20260921210124.1720888-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 14:01 -0700, Yonghong Song wrote:

...

> +static int cleanup_pad_body_for_subprog(struct bpf_verifier_env *env, st=
ruct bpf_prog *sub,
> +					u32 start, u32 end)
> +{

pad_body{,_bits} are redundant, jits have access to insn_aux_data.
all this machinery can be dropped.

> +	unsigned long *bits;
> +	u32 i, cnt =3D 0;
> +
> +	for (i =3D start; i < end; i++)
> +		if (env->insn_aux_data[i].in_cleanup_pad)
> +			cnt++;
> +	if (!cnt)
> +		return 0;
> +
> +	bits =3D bitmap_zalloc(end - start, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +	if (!bits)
> +		return -ENOMEM;
> +
> +	for (i =3D start; i < end; i++)
> +		if (env->insn_aux_data[i].in_cleanup_pad)
> +			__set_bit(i - start, bits);
> +
> +	sub->aux->exc->pad_body =3D bits;
> +	sub->aux->exc->pad_body_bits =3D end - start;
> +	return 0;
> +}
