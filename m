Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8F307AF4
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785708018; cv=none; b=Tv7pO1CxXloA/K5bJR1By9qI4Gp+gtdi347G2aQ4FKaWizGxieDfqTmpTVuzqUBdU9Di1rMbjh4Wm7wVCI/lDVhl3/1i2GR4hMrsgu3sDQWE9T1eLyd6Y8gA/ZKnpp50KGgsjXkhdRwjq6S4gQ9S2+8j/9Lhd/xGF7jj++j524g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785708018; c=relaxed/simple;
	bh=1zcLU+Iewt1FnYMDCJu8XMEHS7Kf5vwnh+yOzMllePk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Dkb8y0V62ou+o3IU18xsFHVcYwpPDoPlGc/bpWni1+MaNzXnUhew697IS0F0PF2v22Y6nXPi81absDwdktsvPzBs+v+or9Y4jm3Pe2UKWejAYa6ec0SGREeydJltNOF8qEBu6k1U11nTk2ebfQI0opyVS8mwNo2OQkgZMDV0Yf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyLdtUA/; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyLdtUA/"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so1240366f8f.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 15:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785708015; x=1786312815; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VWobpscA0yFgmrD2IpfusXH6GAKaeXPJip3GuRN+QL8=;
        b=YyLdtUA/YEsnK1k/MRvavE0sX0i1fycF3SNXe/PUx6mBaLq7i+tzE9BTZ89Hxs6eY6
         AH/qOo1fgn6Xamu2wlMi3CIAnnq9ZpcbilIladdcgV40HJX+jqhZ/tt2GKOdYFpqFVib
         5zQl81zz4J1Bl3dVNDbTUQ3jsjqmHFXEKZH/gRCh1H8D9IRA1yjC/Yl5bhgofN/QbEoh
         qudAlESmmBxRyu92SGj5b6tdblhDPgRHKYmVWxiGpf3uXRZ3rGRTRDAOmwjAAVKWGbbj
         K87yjcGneB0EqvwLbGqjA2gCk4CdvQFA5NnKeaziF5iRHLrTEmFTBcSIvWYt6B5LhreT
         VCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785708015; x=1786312815;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWobpscA0yFgmrD2IpfusXH6GAKaeXPJip3GuRN+QL8=;
        b=Sncv9bRWRNrIoxpizuscDVssPF3a+ghKHT8xZu276tDvMtGkaMFSPgFEd2OvjlzmZ2
         t105owaas6Vz6e/BY9/TE0puKWxcr0G8uYlRyLbh58f33gI9PFhFK0D+wZymVOTpbw3d
         aUOEXNrvWTOQLffozdj/UnDnL2f6GAxSUzYnNGJAf2ZTXBxzxFlqaMJ3DG2cTFPA8lmY
         RRrogtKqNxPjA2l/k6oHwrpOHYUi777ixeQjifvxNKg1h+DAMaIdFvJheZatZrNKmpKB
         bZrmvkzThZqjiPGj7TnrQ0NwBPuLLjRA1KbHWpw3jfQBjsY03tCXn7tlbEBuItJZBtai
         f97w==
X-Forwarded-Encrypted: i=1; AHgh+Ro8q29934Fcfr7jeYnj2u+gBbnVetgEJ6e+mEO0mCwQq/sEd0kQcdEAAOVKawlT0RfNRuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlrpQkZOZkVz1wYOwXDktqdomE7CaLtw3JnJYFQ0gV8NLp3rf
	4dGO/oUe0z9Qv4TtIlmpRe0NFgPJatSEf9nKm0wxZ7hIG6PdS5TtMrcB
X-Gm-Gg: AR+sD13MyEbNli95WtPvPExDMD5Cib5mAxKHTnOZ9o9XWCTBHsTFRGV7Q6UunuA6+yo
	UZSfHmmmKJbDLZWNPCeQBN01SAuV1NltGyl6FwlffD5tvOIviO+wmtX0I23dalmUQXemSZuhQmY
	EcuXG1C9AncXyc4IH43gBbZIYQID1CVpfGXETBftN++j2lfFLQzikcO4fZMXkk6Rr8HLZCuzNKl
	9iaehU9BmZvOrXBVwB6wQ3Vf++NCJnNzg3yIwHbWAoiYTZ/2YWEmmeOUgey/6twM3JAfvByb3/V
	zS+IWx28Ef4BoifspoO2mSgyGnfCIDTQgF39zsnGSxLVzK+neH5PwigR8npcCRW5JTIwg2uwCDt
	jeF22YlPhIvXydjvi8zL8cEpZAtR7l6/8ARp8dj4u68OYo6fwDyfdq6h7fDX+RlbVYmfJ3vT+W4
	Ug8+2ZsqenfS7eulHhMCeiKwSoKyEP9/rfaGUznO7OspcObBGcdq/3ORn2xkT3mkdRS2BPUsmRU
	LeSmQx77TuNxeKv0BpAgUuQjr+xmDXEZYpIMFAs5stXyDH1S1qvoz47vWSeffaK3ElmwBUgeMBd
	sfcdOZgKrMi/5hzpEttkrs+2vc8=
X-Received: by 2002:a05:6000:2a8a:b0:47f:96e3:530e with SMTP id ffacd0b85a97d-47fd729fd00mr16769902f8f.8.1785708015400;
        Sun, 02 Aug 2026 15:00:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1240sm25783734f8f.36.2026.08.02.15.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 00:00:14 +0200
Message-Id: <DKESNSW1G34U.OZA4WQKHKQ5W@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Test stack depth stats
 without BTF subprog names
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260801230400.850271-1-memxor@gmail.com>
 <20260801230400.850271-4-memxor@gmail.com>
 <adaaec551f6623758ddc1e31dc5ccab0afdd90ec.camel@gmail.com>
In-Reply-To: <adaaec551f6623758ddc1e31dc5ccab0afdd90ec.camel@gmail.com>

On Sun Aug 2, 2026 at 11:54 PM CEST, Eduard Zingerman wrote:
> On Sun, 2026-08-02 at 01:03 +0200, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
>> @@ -1559,7 +1560,9 @@ static void do_test_single(struct bpf_test *test, =
bool unpriv,
>> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test->errstr_unpriv : test-=
>errstr;
>> =C2=A0
>> =C2=A0	opts.expected_attach_type =3D test->expected_attach_type;
>> -	if (expected_ret =3D=3D VERBOSE_ACCEPT)
>> +	if (test->log_level)
>> +		opts.log_level =3D test->log_level;
>> +	else if (expected_ret =3D=3D VERBOSE_ACCEPT)
>> =C2=A0		opts.log_level =3D 2;
>
> I did this:
>
>           else if (expected_ret =3D=3D VERBOSE_ACCEPT)
>   -               opts.log_level =3D 2;
>   +               opts.log_level =3D 2 | 4;
>
> And all test_verifier tests passed.
> There is no need to a new option.
>

Ack.

>> =C2=A0	else if (verbose)
>> =C2=A0		opts.log_level =3D verif_log_level | 4; /* force stats */
>
> ...

