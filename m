Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B93314AC
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786650737; cv=none; b=lYw+BqiEpEkbppDEHRHVsIE2YpB8MVnN1Q5MQes+3DVHXfwShAfL8SmquByExjasDL6zeOZq31RRmryMRGBzX/Sg/O74w9aDsxrenWk4JlR5Latjt7TmO6bBNYESbcfJA0Zk0jqwkKT8vCassqCt1kCVcNcT6ze5PamQdN/DP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786650737; c=relaxed/simple;
	bh=rhuKj3/qUT3uvavH4c4KwZN92fPd6H5Fa3q8tVtm2bA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOru5sLRbelPgS36GPa5t5wyDD3Vkhs79MdNyZ8h7lAaL/ArbRdz3sRF8b3sAwwb/NEcCz3MUKMa1ffB7YoroRdQajhldP8cthiZueWRbS1djpmY7WdiIbP/DY535wk8d4rWNkRmSNAPt9kka1IxcBxb1QDstejC6RWV0QJOFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP0lYyA1; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP0lYyA1"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso179013a34.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786650734; x=1787255534; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rhuKj3/qUT3uvavH4c4KwZN92fPd6H5Fa3q8tVtm2bA=;
        b=RP0lYyA1jwHXvYvnp4vin2iBHiVvQZZj+oYcrXgKqyZ10PY+5WJ5cTBVwT8DfcFQVw
         LWju3NABWxPgVnH2drzR7e2W/+C7aHe1MwuHfVHpKLHufyHxxTKyecmKE2pjsqnrNLsq
         4DEUDGDMlwJb1mjWc6ZMXJMty4dcA9xI8RmmQ6i8qwLajwWwc8idf4S6F9zAd/x83F1/
         d6Gn4/UxeJVDeVwrmo5OviD8FuFosMMBIeathY5lO5/tEYqUtbTw0ZcA8o2RLC/a29sy
         PYVZ+YuURU0IpXcNXQPkYaRoWwLRirlRcg2vCFLOThH4DWSG4TU8ezaP1bQ0dA8/jaut
         4hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786650734; x=1787255534;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhuKj3/qUT3uvavH4c4KwZN92fPd6H5Fa3q8tVtm2bA=;
        b=FSIERH9C7quVqWg7LMtyhqtBObHfUATBYatbZG7t7zdBThmX1Bc0s21pGZon3iGsQ+
         pAQXeYr2aDkSHRhyEgl3s+h2/sQStJCrBnANf/2WL3/PgV3tzgqT2S99UIHdLb3GCNTm
         A39nkBbjgHt76G9cWaQdxoVBCGOvpTufaC45kctyT3HUjPHU1o2s5+zYEYDZ1m6xnByy
         BVsanVGqbHWZ/vFfEM7PMYXb9dsKHGDkQbMgrkdWo6EtA+MHouhG5EaSY9e65xzqMrRA
         UzSaKW0uFVNsn3xkX493W22DJvhYIytAFCpNvfScbBw0yuDr4GoKzii6GHAMTH1aaSD2
         XYZA==
X-Forwarded-Encrypted: i=1; AHgh+RpO6iWzjOBKqMk1GnMo7O/4khcbnighzuaZ/Lz39sQnr9orHzrweJI2hVWg9nH1R4rMIus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFy42FBBSrWeEtMUvc4Y3c+O9ItkcaFaU7u7ikZ+hFgnLoHNDb
	FuZJAV4Ng1Pevz1GTL/REqDDmr1BZgmRPq226rLYOuYkNk0JkigysA52
X-Gm-Gg: AR+sD12D+UUcAMhN2CCGAwWRHJbuhI+a2jJUsPGUR4j3INIiGV8KlvFePctSso4iNjc
	7AienrhayWC5tWpBYRRtUOf/gme9hH49a6JTCQDLMekC9iz2Cpq4B6/kd5wRIRtgsQmObmdcS3h
	22tgYSx3EDPZJ4wFG+H81d4TgChhgCnnK86/VW5w5uZURKbXqV+NtYUve7b4LRpSb5KG+4VZvwL
	Odoq0UX+SM6kCYjzMJIra/Fy5esfe5w/NYw9ZpCxHjTmYUsuUC8QWj17KVeGWl/5/NiLm/JNLTe
	5btYICn5McFTAkcRJMcMPOM78tIeFOWbWmyOIf38sw6conEVlF3gq4WCwGgqNsjCVD7Ehrqn1JK
	AvMfGCdOX2NvBveaPMUJ9cCM+RG7fn9FiujyEoO6RgDeQZJkGjvmWYZxzO7t+60tGSt1HdSV3zp
	F81gzjLZiaGfVMGuRS3MPO2RuEoK1i377FbYiDKyhx/MFwlxEUFlnvNsCdofXZ0bntwhxY86x3R
	a7hRL+fsRzfizWTGFfTatL25NguOVP8shLNBL+cnva97Q==
X-Received: by 2002:a05:6830:6b0f:b0:7e6:6f9f:7455 with SMTP id 46e09a7af769-7f3de6223f5mr190598a34.10.1786650734497;
        Thu, 13 Aug 2026 12:52:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3c974c65esm2958910a34.0.2026.08.13.12.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:52:13 -0700 (PDT)
Message-ID: <5956c0dcda31c57cac7849abb44be1e50a3efe1a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 09/16] bpf: Report Memory Safety bounds
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 12:52:11 -0700
In-Reply-To: <20260812233326.3575958-10-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
	 <20260812233326.3575958-10-memxor@gmail.com>
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
> Augment selected memory-range verifier failures with Memory Safety report=
s
> while preserving the existing terse verifier messages for compatibility.
>=20
> Cover stack spill corruption, uninitialized stack reads, variable stack h=
elper
> accesses, and check_mem_region_access() range-proof failures. The bounds =
report
> spells out the required offset + access_size <=3D object_size proof with =
concrete
> values and uses scoped diagnostic history for causal context.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

The `const char *fmt =3D ...` is still ugly, though.

...
