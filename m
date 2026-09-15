Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891B221F39
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439784; cv=none; b=o0HjMXhh29U/zPJDrg88zclqJRO9SSHq+WtKLmWeZdCzJzcgVWrQxy7Qo974nmJ9KnRJZaFSnAvvsv1+OsTOEwW3t2dJyB/y660TxueIWwoBcYB03FaS4HsP0rSBy+eQEDIBpEg1hS8t+t/+YklBz2LeiRfPdvw+5KERxl1t/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439784; c=relaxed/simple;
	bh=dR12M53iqXwgU/9QZ19+TCsBIvW+wlfibPwsPSBE30Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRaEavIQi8L0JRMJ7AjbnAPuzIM8wa6NbO/qKbHdiHWx6mTfCe1WEZnzRTC3p/nTxbG3cKLxTTl8RCZrJIQDPTdLBbpKPVyqFWfikSO4pEiY50osUfJF+ntirt6eY1zTK9oS4YabggCwZil2xWPE6QB6aaRF3769SRChvjnQGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkjTkno+; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkjTkno+"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25400so2137683b3a.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 19:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789439783; x=1790044583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dR12M53iqXwgU/9QZ19+TCsBIvW+wlfibPwsPSBE30Q=;
        b=WkjTkno+H4JXWYf17EzlJnZeOwA+mGDV7sIMrF/XwmLFUkT2FhiOgswVRmrYTEFhKo
         TKKZ9UndZ03dbq0vGMNZ0A7sc5S0/nFx7JzCWV/ym6yZCFVoU/qK77cE4yn7qoNdmkhA
         rwl1Lo6LvB6RbYxVStpGYejECBpEc87pC7x0DDCq4YLyyRtLLn8+faKc1VWudaXdLf3u
         SMmn4eGSq6N1RuTUXv9etXzqLv2+8mFTpCdkuBHeldN2vKM9WJsJqtcpQXI762qFods0
         +quv4h0W1autnrA9CgMhlbgNEsdpFOJK6HxG+E63Dpf0RVvfnzJjkLWUsyE3Gn9ladY5
         N1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789439783; x=1790044583;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dR12M53iqXwgU/9QZ19+TCsBIvW+wlfibPwsPSBE30Q=;
        b=Pf3sc5MmLWt6tnDQu71ey13mBC/AnFtL8SZBjlXdqosy4DI8pR3E4jyjZEs2QgXGzr
         vRwKYqUWrbblYEgqkjhgk6TOuVkcG/2COnPj7MmkzkhnA5GvkEHDE6LFxwJNNcKHz5Qv
         sahPhd7o0ilDSDt/x1EDZFumKDMla9GyLL+xuLTwWcB2Oa70KJ7olQtCLBczYZ8skmDq
         /XXYyeFA55dtVt/Mk+r2VHqnVyl0pqECreU+muWyetzmvA25qpuP5KGifFzb/ZtkNq+v
         h8tyT8VNPMNFq6e+JFMavOYCZWFjKJXs/sjMQkP+YV0zKZI1vFXojFTcjKmn8RPMx46k
         dTsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJYrmE+CtYygvVtpNIL2N9gBkz7rMmcHsQzAuAPxifenZZq9lqEV7nxvhJJRxMdWqJHj0=@vger.kernel.org
X-Gm-Message-State: AFuF++mXbNY03BWyHwbiO/XEa36xdKPK06wWFSECO01pViGmF4epHaeX
	pXj0LYkFjoEOfdW+GP8Hqd+s8w9JuVs30ugyS4TXstYMesfx1TxVEusA
X-Gm-Gg: AYBFou2vJImoVLyL2GzegUOiu7/6rMccCbyR5qmkfij6lsrkQcp9deMKEtOgcrNgRXG
	PdVkprjuON99TN1nvEAKoJ3enNLEIIftCKSDsr4t2UcsLJ41NTjURz6BkxTryrZtUBLVT4Bh3gD
	aBDZ+tE4QMIMPuZjrFsZmBUGHpb3B3j+kybb6ebEOC0UVnzl9250X3cEjJIF0kKwfrgGOHEJ3Hi
	Ov+7uOl5ugC7/3yTFKtchEsbJn2yyNDYlMJElQ0TlZ+yYutG2sB8yNbCCQv/Ngxb4BtAzaC+5uj
	wltxklpRy9KTVL4tS9neHZE8NStlgfcEGTjxBOXHSSbaFX3sBnSsAO0GQ1GATrp1zweyJYyvoLp
	W4XBA992tcOCascfApzCOcFuVXjOYP5oTWUnM7y+v45hMj00oYF99veF/DOyKpX07zF6DKTLTIH
	k9DrafOxxq/yzX4mIiQAGeoReMf2a/6q4IDxcoeiu7CqID2d7h6R4KwzwSx0PW2lWnsyDUg+T0c
	kq+tMRbhvA9vTLbP8sjFeiWlvs=
X-Received: by 2002:a05:6a00:a115:b0:847:83bc:d2a4 with SMTP id d2e1a72fcca58-86f83152fd9mr11627889b3a.2.1789439782834;
        Mon, 14 Sep 2026 19:36:22 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b290cb1efsm5319637b3a.29.2026.09.14.19.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:36:22 -0700 (PDT)
Message-ID: <8addaeedd955cde6942bf2375347e1f7480a1da5.camel@gmail.com>
Subject: Re: [PATCH bpf v2 10/11] selftests/bpf: Add tests for gotox nop
 targets and insn array reuse
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, a.s.protopopov@gmail.com, info@starlabs.sg, 
	bpf@vger.kernel.org
Date: Mon, 14 Sep 2026 19:36:18 -0700
In-Reply-To: <20260914170326.249953-11-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
	 <20260914170326.249953-11-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 19:03 +0200, Daniel Borkmann wrote:
> Add two tests to the bpf_insn_array suite which excercise gotox target
> which is a ja +0, and the insn array reuse which initially fails the
> post-JIT stage.
>=20
> =C2=A0 # LDLIBS=3D-static PKG_CONFIG=3D'pkg-config --static' ./vmtest.sh =
-- ./test_progs -t bpf_insn_array
> =C2=A0 [...]
> =C2=A0 #24/21=C2=A0=C2=A0 bpf_insn_array/gotox-target-nop:OK
> =C2=A0 #24/22=C2=A0=C2=A0 bpf_insn_array/insn-array-stale-reuse:OK
> =C2=A0 #24=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_insn_array:OK
> =C2=A0 Summary: 1/22 PASSED, 0 SKIPPED, 0/0 FAILED
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Tbh, having a full stale ips issure repro seem to be an overkill.
I'd move the first test to inline assembly with __xlated or __jited
matcher and drop the insn-array-stale-reuse. =C2=AF\_(=E3=83=84)_/=C2=AF

...
