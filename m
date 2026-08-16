Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99672EC0A4
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863236; cv=none; b=ghg19+VYHW7MokvnX04AQgrIIh83noA6Rjz697vQjUdmoM25mbtzEcKNdkE7XODbIzLbvcNriO3A4FOrcsPSyh+aiS3hYlbzwgLi/f9CkyPHXb/5u33KThak28AsunEEAzHVIAhoN3pcq8ixdHWxN+84UqKzoJDGzuWIoXdt7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863236; c=relaxed/simple;
	bh=aGBPqOz9HXItPF8ApH2x43uEyrrQOLH2q1ZWs0sh3QE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyPuPbUoBLRFIaP3/uL2o3rA3gt7VSB4TdLRts1T82da3NRtVrjVQ0p06yS+ddbY2af7aRL4g7iFidf552Rs9cYq0qoLwndvEkr6FOedO5GuJQMcnOqV9zAFjAVOrzGqzW0PKqG/jKSk9av0L4VTHy1110COa9K+UQ2Y9U6DdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xwq8NcKH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwq8NcKH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d530328efbso17402315ad.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786863234; x=1787468034; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aGBPqOz9HXItPF8ApH2x43uEyrrQOLH2q1ZWs0sh3QE=;
        b=Xwq8NcKHY6D1Fo1cFP5vt+/+P8UymtgJFCftEV3AegDlp14WuA++sZfdvQ2y1av04U
         CXhcP3rtk0jPWU2DgRmKEXAJbDhTeo4jZllRntM1p/tNBHppjWL7mvWUDJkc9vwym5IF
         zvf1vrJwGdlrAsSxQ5yu8wYcUs746/UHy3ZMJxE2jUtzlFVTsuqmZfCCBTJRlMYJP3Po
         lsmHgM2ZMx9KJBDl0h52CdwI6BZFMrOOxVbgN00CPF364jjlGDo5mVhBG3McSVOjOl6O
         onD/lkhoZDWM0cGkQsoNPHLzezQ1IsSo5QKr4c+6A2EusH2BdpH5dfNktMZ0SbHFldhw
         bhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786863234; x=1787468034;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aGBPqOz9HXItPF8ApH2x43uEyrrQOLH2q1ZWs0sh3QE=;
        b=LDTOpzm37ql8ujRyf2/eFQX9gSVxiGfRH8mhF29oa1FVwWJoKR+3PssJQCZHeNNl2w
         yTETVzi5mXna61+pCfXKJIPCb9YhSFafKYx4K77VqhFeZ1sNUxdY+XyG1wfNwMDVHVoX
         8NtIdXTuia+bYQRnwo/7RFMm0yJqb4EtardbBtAl36qcoXD2Pnv8CSHBvZhQovLKdE2I
         l9xJZNzQtr7Rhk1ZkZvqgAN6lBBLS0DW/Rc5ikFQWk5yjnMKWXe71p8vTkb0L0w4xMef
         kdrkbJYAFgELUleol4+Eh39/vD06NtV6DC4HTjig46XdLxQ0KggmiSfhHJC6nwosWnYL
         NrYw==
X-Forwarded-Encrypted: i=1; AHgh+RoDYRILL/kxisntTEiRkNyLUh8atK23YuhBVk4kVYvEVHFABnHt843m+tWmDlFKcyYgAFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkkOzj4RcF82G49dEXn3yE9q0AkzFSkG5XMjlhB5bQv9sFLx4
	ZA3lBpmcnZ0tZdULl2qEQWTeu0nl27rJX3GVnwrmKJH7vUwLKJutuSvu
X-Gm-Gg: AR+sD11L0LzMaNezN0AGbAd56JY3jLpMyVZiuvR6VoJFhtpjzgXSdZTGZg4m1aXGPdn
	ry9hmj4omIj6619Xb2SgPDCFfzuVpfKyNShGpp1hWOEn1kQWCrAm/LHrlRl2bT3ZoHNKmiuy6dx
	kZEdcMCIr7xz1TkMnSTbssIIHJFuATIlOQ/C4s82VbcrqM3rOmchko/PvLQEV9jU2qOvig5S4g7
	CjCYugrSM7zbw7ZQnX48+z/4sBJoUJUPyIHTwjHeClalErG8mzqo7h4nX0IBdqDMwVTy/v7OXFL
	B4goBIAZsRu2ExIW2eaNohXge/XbNhhRtqpc5BoHgA4sZV987s0K+AkUQ0xqejAUVZH0K7JcKFM
	ePNhmzQyKB6GKDRPQpZuTsVsKsuR7ewPfOBoOw/KghBIw6jID+A1J6FqRvXCulwDGfXMI+mGJ3z
	aawVZ6772XB6VHHNKaDbzMlK+cHAQts/cS5qWuWzVkHD+NjF4Qghe9SM+zLKb6+IVzboQlKjwkx
	cJmUOJmOBXRMDxZ
X-Received: by 2002:a17:902:cf09:b0:2ca:d151:383a with SMTP id d9443c01a7336-2d3b0cde910mr210160515ad.20.1786863234193;
        Sat, 15 Aug 2026 23:53:54 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb8869asm23886135ad.60.2026.08.15.23.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:53:53 -0700 (PDT)
Message-ID: <559874775f5f750b250624a40bedf399d0f7d197.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 07/14] selftests/bpf: Test kfunc argument
 diagnostics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sat, 15 Aug 2026 23:53:51 -0700
In-Reply-To: <20260816015746.2632990-8-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-8-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:
> Extend existing negative kfunc programs to assert that BTF void is render=
ed
> as void and that variable __szk arguments receive a structured constant-s=
ize
> diagnostic.
>=20
> Also pass a context pointer to bpf_refcount_acquire() and verify that the
> report describes the generic refcounted-object contract and the actual
> argument type. Retain the legacy verbose-message assertions.
>=20
> Link: https://lore.kernel.org/bpf/3eda33675965763aa9b2e6a5784f32b34a6a839=
88a55fbea98b0dbd0cf3b088d@mail.kernel.org/
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
