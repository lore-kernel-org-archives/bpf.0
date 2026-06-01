Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977673233E8
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343070; cv=none; b=KsBQtEHYW0YTPQctXnnoZUX2a4wTAWw1kaPzT2B+s5UG8gqDBQjpfSGcg0vDg3ycfcz73PkbCi0W4oU4zFQEzjK78MG1jBeLHzBZdOk0MhWA6lFamOD1mqfYahisxqirxDwDiEjNHuUeVR9bvtdZZRtZSXKxVUmcLYPfzmPX7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343070; c=relaxed/simple;
	bh=lu2Ce8qeXqRQbCsOUOLHyfTclDkQg4q8fzZgq8iC+yo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKVStoXmKfgb3dCHtivQtRCWyovuPZFY2uakelmV2MV6w/Um4yYkPtGjibAchSQkK+s2pCzuzUV90DOxTG+f29o+IH8GbQ+Wq5wRhNWajiSiuUFDi9qPFsZz4BFmlOjPS44YCYKqrngTCQsNl22HLh7QxEpltpoP+uSUZS/byKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhroYC3d; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhroYC3d"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304ffa40c5dso5961631eec.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780343069; x=1780947869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6UVd4bSkyySwkNxwcPgfgAZei2HE821SUnP2NyNyCAY=;
        b=LhroYC3d69G1eR3Cyu0EVUIKOcc+aix/D8ldhuqeDqXCYXNMJXwru/UMTCzKIKRyfM
         CE8h/JuLc1QHkvcY58txvawcPyMXHJfN0lKIabpLhMGGOWjrUf9zqtgJkLkVIbanhGN7
         B+PMbe7LFo8JkLjPPkGAn5wfxgi04Kpxv1PM1N76iEOy6xBp28mb7F/xwxeQraPx+4nS
         S+7IEZTlM5CJ5pOGXflripwGmysJmC//nQdPGONa9WzKng6U1D190FFF7TenI7xkxXnd
         olI6CPXL+zRk56j5ya2KLDaWJj8y85YmpYfc/Hq6NFMkag0SqjQMj0bo8KVM9AkGM3AS
         ihgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780343069; x=1780947869;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UVd4bSkyySwkNxwcPgfgAZei2HE821SUnP2NyNyCAY=;
        b=XgNqrRsPCK0QeFIVXDlOoms2DzYLVa2kIdC34dII4DXVI1l8eZZfpRiHrP2j3C/pBg
         LJwovutF4K4NI5/gWu1FQha1lySLeLNPqC8a+EA9uqckggYMbhbn2LFemth8APCFVFGJ
         OKHbNRDTjHm35XCVbyHFBJRCuutRmGF/ozKrEYM0s5+xAv5wwrD/ewbm8C2ga6/3xZwf
         OZyMe8KzvD1oqfM2CZr2ptQ6RyzSyc8vcaVvCryQiuMHzjvCxROZXXhfIWkaVCOfBSYF
         0Kgy4ckV/RzUek/37EimO75HIvYFNy2SGjUCj9acINskqrTc7h0EcjtA5sLz4YRaAF8n
         dNgA==
X-Forwarded-Encrypted: i=1; AFNElJ9Qf+ZpkDhCovaxsPmQi+IFe84FxhqccItp/BrHqNEIAJS/jazTBd69lr7KkUaDy2b/MRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRw5Qt5YOf1aE5x48R8m/dcul5XPHD8G+N6Waf78/mJcPFSIyk
	6LODm0JnijMXOYrNCfOMER0RcQ3IlQDVNVB9dTt0iRPkDdmdnjz93qbu
X-Gm-Gg: Acq92OF7tbuUWzpTrxBMv/5Y2RhEDwyupCUpkWLFDFcoMHZ8ehzxNO+EJCMBA/YdvRl
	KcEzhUdNJnlkmD94UKwsf5TsRqOUJn1kKn+PYsrT9mitQk2SrfZc4tzvO7x4ODhZ+kIyFNZj3ql
	0sTWgX0C5nBTaNWVzwuNyFMj4anHX7WSWiPflgbmoI3bs0X2dcb2r8qS7ycMb9lR/ERlHYf9e16
	B8Dirmw15Wwj/+1N01g3NLJaDjcomfegHQAXSprN7Odpgf/eUM8qUULmP/Dw9hzpP9AuQcjrf/+
	arm37Acj0f+N5vD4+JUg9uGPGbYEV6pWB9WBTdFXv9vIJ+euO9w1m0uKnWbNs6B2KC+IpJi+6dk
	CGJYJU/jEmM49mSOolCnzBUoA67szcCyd+zBQ8oXQDWiaGKV7eG2Tf67T6x3yone+pTF956er2h
	B+LcpoVIi7c6Kh30MkHAt8KNMZU7yORMaTs/Ya9r/6ikkIVid8cDbqL6ZWWOLN1WV9oWG1csU1d
	5O3FajOAMjJHQ==
X-Received: by 2002:a05:7300:2201:b0:2f1:6252:f8ef with SMTP id 5a478bee46e88-304fa49ce0dmr6595310eec.1.1780343068695;
        Mon, 01 Jun 2026 12:44:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c120csm9845949eec.4.2026.06.01.12.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:44:28 -0700 (PDT)
Message-ID: <ca241c0e979d4d5f4d9305f38b9058453cf07c7f.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 3/6] selftests/bpf: test cases for loop
 hierarchy computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Mon, 01 Jun 2026 12:44:26 -0700
In-Reply-To: <DIXYSJ50VKHJ.1FN2K7SFU8N1Y@etsalapatis.com>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
	 <20260527-better-1m-reporting-v3-3-b3ede0588a75@gmail.com>
	 <DIXYSJ50VKHJ.1FN2K7SFU8N1Y@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 15:37 -0400, Emil Tsalapatis wrote:
> On Wed May 27, 2026 at 3:29 AM EDT, Eduard Zingerman wrote:
> > Test cases covering the following branches in bpf_compute_loops():
> > - Case B: simple backedge creating a loop (loop_single)
> > - Case B: two independent loops (loop_two_independent)
> > - Case B + D: nested loops where inner header's loop_header points to
> >   outer (loop_nested)
> > - Case C: diamond CFG with no loops (fwd_edges_no_loop)
> > - Case D: sibling inner loops within one outer loop
> >   (loop_nested_siblings)
> > - Three levels of loop nesting (loop_three_levels)
> > - Loop with if-else body containing forward branches
> >   (loop_with_if_else)
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>=20
> I was debating if it's worth adding the edge case where the instruction i=
s
> its own loop header. It is so obviously wrong that the only issue would
> be the verifier handling it gracefully, and we can probably skip it.

I'll add the this test case, just to make sure that the algorithm
behaves correctly.

[...]
