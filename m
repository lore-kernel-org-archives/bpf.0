Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46A1DE8AE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228564; cv=none; b=tCqhcLiQSG83pnT6RdfUeEnC0pPyQP6zzEppgF0Qu7+h72S5lHr4jLvkbgzAGuOV/d2HRqv58SDhP+yFAswvD/UM4JHDvO60ID69CC8IJU0D7fUWKNvt8dwdq2zCOF5aXI9xrmT9jg2skzYKJO6cafoD9Wu867CyLZbGqDbiMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228564; c=relaxed/simple;
	bh=bCVFMhgOOXFTeYShzJB8HEgDjjN1lQXL/f8tD6g8gBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tu8Gj5oN3NYd+cOgx2QX0rAbHifpCU6jh4thRW9miC8Vljq1TZXB+0w4xi955F3AGFZ4haJhalvUhl2ODiScjUYN7HEpaN6VAx2OhFa1MMUDhPkoH9QqcEkOj96MgtrBSMvMTbFfwCwJpgbrSpBi2YPaQ3uGyCexn5e61V4I3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0BDNYa+; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0BDNYa+"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2d747ec6185so7583225ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790228562; x=1790833362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bCVFMhgOOXFTeYShzJB8HEgDjjN1lQXL/f8tD6g8gBY=;
        b=i0BDNYa++7hjZ3Nlsl++ZRtOzfb2Zbk1fumKUH53hN2ld8D2j1qMsmZ1zw+TTV8K2p
         hCbnSg22nHsxUi9tvbx4T8pKW6UeChKrn5cz4OA/4xBb1KDDFTXE4Br/oyVoYpy6Qat4
         JQWE676pdcDQ9l+8K/EjjMJdYrwKGxoeI7jcxDsgvBRGhYROC1NkoTdDz2u8v1mcp0W+
         SABr1htoY73bLlW00WdHy8ZZH6sKRriP8ICll7ajZaCWDCK7BouAe2V31wi88JsbCrhl
         EEn76lwo1KTL+XLCokInwso41UF8FF6gqoP4lce/dfZeV0ewxCOh7WvWbPGVPT6JGsXm
         97Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228562; x=1790833362;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bCVFMhgOOXFTeYShzJB8HEgDjjN1lQXL/f8tD6g8gBY=;
        b=YlqZNXqySWJ6JB7puruke8fnTovHC00QWrwQ8+K/GQcpJz8mRJaYZPjzOaIEDGJuWP
         lbowIiD8nOeQqA+xkuRJ1A5MUsRhf4y/23xgMvHx0mCUuAkM6qYTDea8Mi0x4YIUVmRK
         VvmykVVLPlXE5gTeqyeJi6svyL8ose2f4t/R8GT+2HVJ4xt6xvoOKktawnrRQIHaHhV3
         GAoQ/HYevdK7sld4m8Crp74Fvwq78E2DQcFCAuYj7Ycsl/1bJ40TXMMJwPOPAXFUZ5hi
         aNSWJPCLkbsraSL83voqlny76vL6WkmzrN6E6k43IiL87MVz/9VeJ6MAECeOHe5wkK9F
         U3/g==
X-Forwarded-Encrypted: i=1; AKwUvBzw7Ay0SDE/R3oy0yfcqoL9DrVLnv6vDCUPShs+oRMy9MJPdrlRFmWqvALsgr21qHCCDDI=@vger.kernel.org
X-Gm-Message-State: AFuF++lzbYcgoc4d2vbf8YkYAiRymzFAjAV6SMnVVStx4aTGqvZO4Jn1
	5orjwSKjeAkHF6+Ck/r7/6Lf4si4eDcdA/T3/1PQnjEjQLSeMqe3VJ/K
X-Gm-Gg: AYBFou2JrL/u+DqNjlPq4WWX8IjrK6PRKb3dRIf6GzKsGc+Vkfqxhdor6QW9xfw0Kfe
	xmhLDMURKsxREcYlsvZCCEJJ95GlTj0yg+DahcvEKVV4RDQl6pw5leP5t1JzkcBgHbGxSAXp0oq
	zb+eRW2oImkRlE+A34f37klY3MGYRCo9Hg1j4qm1g1Yy849mzvnxvC8Cuzaf2FLfDrHBM4NOBMt
	5F6PkezV++Cftyl1cGj3J7obDs2bEGACpzwLoqFx4RNcoITkykcVCJPCsmMqY6iBCEQdaam0Bj3
	CEEYS+XHcpxb+JCI3o7GQYR52rQhnlEXcFxMxaxYmnPCvFXxI2neKDGgTWucsMu9ibDK63aa3kh
	C40Dh5lI88Zderqe5lBAqWkEPSVAcwxpbqs7eyJBGT3rLlPmE+TECVkCmPCOjbxC2xUKbaS19R/
	JYDobsmxCSXyfICV9Exx0zkGSrx8pE3H5//l6q4oF/ibniNakF6NsC3kICURDFhwDBYdpzvXAWl
	ZAyEER38TD+lI7oKCiPY27H7afQ1GGqHanhpQ==
X-Received: by 2002:a17:903:b43:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2df7dd77b49mr10818645ad.9.1790228561994;
        Wed, 23 Sep 2026 22:42:41 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c316bsm20478795ad.37.2026.09.23.22.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:42:41 -0700 (PDT)
Message-ID: <f9fd073ee704908e3ac1afca3a5a998402b78f5c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/17] bpf: Discover subprogs described by
 func_info
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Wed, 23 Sep 2026 22:42:38 -0700
In-Reply-To: <20260924031042.1690890-10-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
	 <20260924031042.1690890-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-24 at 03:10 +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> add_subprogs() finds subprogs by scanning insns for calls and ld_imm64
> BPF_PSEUDO_FUNC. A function that is called via callx through a pointer
> in data only, e.g. a vtable, is not referenced by any insn, but it must
> be known before check_cfg() and the main pass.
>=20
> func_info describes all functions of the program and libbpf provides it
> for every function it puts into the prog. bpf_prepare_btf_info() reads
> it before add_subprogs(). Register every function from func_info as
> a subprog.
>=20
> func_info had to match the subprogs found in insns exactly, so existing
> programs are not affected. A function that is listed in func_info and
> not referenced by anything is still rejected by check_cfg() as
> unreachable.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
