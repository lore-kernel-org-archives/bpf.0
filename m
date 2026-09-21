Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4A51615B
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026941; cv=none; b=U41dwHmPD9qJ223P7wDbURbOrhnmNYXRPIeZIAIz6UvLKm+3RoSKNLeYdoByg5/uI5CODWnAiEKXQjWtLKykU8pbqllxTK4EaWFngrfPbEI+UZtjO0uTj9ZfK5ZQh7DLVv4pcWhNiHDlER+iltYGnoTHCUDmWnQjKZ8WmWTGPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026941; c=relaxed/simple;
	bh=S0F59O00IfudgmumFPj+8WjSRuyfC/75f3Pd4lPfDxg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=KKnm4A6aWnDXTgBUmfg+x5hPR0sLTOnHqlTdfmWKBzqc9CXYCJ72M4LYmm16XuxXVuWn82JrS6mUHOm1P3oV22TH0ysGASXSqy1DLCG6SynMkd+ZFVwFMGKEOq0MNJstl+Aqc04GKjtlvgb0DRROfPsJ6zjFwksiiQWuhBra5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNk1vVLv; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNk1vVLv"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso2700401a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790026940; x=1790631740; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S0F59O00IfudgmumFPj+8WjSRuyfC/75f3Pd4lPfDxg=;
        b=gNk1vVLv5a52+Z3Uh1/tiWwAS3QtjG52Zn+lC0xQd/EGBiwwEUyV3IpZPUOoN8+I8L
         stCzQYnbtOehg4r++Bl6Gl8cM3tYuLCLCWXDEMYzKJVdfjBtwD/C/ODG/mdOBnx99y2F
         OCtiREtVFDn+oQts1L1li0UILk83745P48oab8Kz7lCiB9Xn6/Q1TeuxPdcvxjArKUf1
         tVizfrkNHQt2cOZvwOFurYQNfmpMPGSPCPxsz9Of57fDzb1Z5bEQs/p8YD9M+JD/Fn5Z
         uazoO6yzXO2fYC7RRlQ9j6+aeT+5pdutaHXzBNCRs49cRrk9s7G1UPlS7c/AD93mWeXs
         K0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026940; x=1790631740;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0F59O00IfudgmumFPj+8WjSRuyfC/75f3Pd4lPfDxg=;
        b=Jv3g74j05x/47za1wBFqy8VtHdQ58BcilscDposAzLD4v6JaaE3zOSNBvO28pf1bph
         M5wNh7++LYCeoKO1ZS3jWBzV+wvGS1snuPBvMj/zY4AJPUmXBc8/aA4jQseQFqT+pWud
         vqtS8vLVc/oAsrVwAp77gRQh8IALV+Rip25kk5ac2JcfTA3h54xH4Vy1wZhS3FiLUsj0
         NEgH//JokZm1pyhiGOgsOFxf6FQ005ZeZs8jJK7BLguZed2eIKvTj10TOzFI5T3YbH/v
         QUqKxniY+FVxkDfXC3C33byk+7MKCKSV4bEEvy/SmzaGY/lj+ProgkWmY4IcrkReYrg6
         1Efg==
X-Gm-Message-State: AFuF++l6yFIFBr5OT6mDB50Ozm9Ktrtd/HDmkhYEypyBTnwR2diUCZpt
	GGJ5JlVXWSEap+zo1ipMdrumySOXnIemLHATzoupnKAcgaBJRFWQoStJ
X-Gm-Gg: AYBFou0T4K95WeFCc9cnSdsmMtlkEgZN1eRad+Nt78t+wMEvdKuVzpNKEXX/6Hp3Vs/
	eKwOSSwFTQeQZwFmjEAzS5Jsp+CrZCW7z7zmNOUMnf9BvF3wmvFT4SkBH4PfFmjEWFRpjAKE80t
	nD7sK0m+TwLSgRIvRATDDEBLT+xnGxSoeaQu+sERb3jDR2ZV6rj76SPYe748bO1HRJERx+7y3Y2
	ufh2GiVpBVoFX6ke6fVDG2wrCQfKleGXPhOzFdEBu+aLOC0MIUvEWp0ZNEZ53td/TVi/wip9b54
	UfvS8WDSBjXPpJTdMU6L62vTML94aZAkJ/dF3odVtfhiblCQb1j9GyzZaOyJF9I+QAeYhTSB4sV
	kDMlP+XJ8U6NpOrzXe809De9g3TiKoAp1fd3HFNUP+nzxswNU3MswrTYLUUKobzuJCd6pW5FtT+
	cOVtWKqIGDu1vDPF+vychutkCewmLIbM+XBha6Q+NkMzb2kwTssln6jj7eAm2RbDTRhp4+9BNOd
	DmvFADuj22Ll/dzAgt2/tdEX8XotwQdMXe+PUEBvbTU5CYTvvUfuBqhV8i/as4dCgkW1wwPJfac
	6CA=
X-Received: by 2002:a17:90b:4ace:b0:3a0:4023:bb00 with SMTP id 98e67ed59e1d1-3a04023bca4mr6180002a91.46.1790026939659;
        Mon, 21 Sep 2026 14:42:19 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a03bcecdd2sm4134180a91.1.2026.09.21.14.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 14:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 21:42:18 +0000
Message-Id: <DLLBLB8VWMGJ.1YXGT94V6NJ5G@gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: Fixes for out-of-tree builds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Nico Pache (Red Hat)"
 <nico.pache@linux.dev>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?=
 <ricardo@marliere.net>, <ihor.solodrai@linux.dev>,
 <nickolay.lysenko@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>
X-Mailer: aerc 0.17.0
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
 <6f95ec90-194a-4304-9673-c7bb50065223@linux.dev>
 <d3a251acf5131bea732e23bbd135a5fdebec9ad6.camel@gmail.com>
In-Reply-To: <d3a251acf5131bea732e23bbd135a5fdebec9ad6.camel@gmail.com>

On Mon Sep 21, 2026 at 9:04 PM UTC, Eduard Zingerman wrote:
> The "PERMISSIVE" change done enough damage already.

Pls do a partial revert of it.

