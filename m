Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57E38C42F
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786867607; cv=none; b=ZJvY0gYb8IvynsWeVn1VkQFlbwd89TTM3/TtlMeveV8YZqfOaW6oHW0VMWa2/fnSyju0KbDDRXJXHHRL3ydYcWgenc6o/A56E7TSdUjojdRBt1VpPyoll7WHpDo7x6BHgaFaeyGJU2BoyDY5EAY6hOz9rLeOOKei53WW08klh48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786867607; c=relaxed/simple;
	bh=Enl4qlGarnj3oVlA3n6vmIXCwFtrLXr140Sfsn8p1jk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNZLbifyG50W7LZPGD00WWZCgOs+rC7YvdsL0yx+yvZ/U1NlYdMf+5qKyNxeJWBfcXPPon0PA+AZnLLXVEQowY29wu6q1CGXUDw8qWNCJel/m4kpl5wOn3uBjXK61zn+c+B9+73ozWJcSncCeM55xvQJ1AhyKNIciosrq/Z0LkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBTHNOgO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBTHNOgO"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84847482584so1652497b3a.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786867605; x=1787472405; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Enl4qlGarnj3oVlA3n6vmIXCwFtrLXr140Sfsn8p1jk=;
        b=GBTHNOgOR6ejctXIm5cwHi9Z4tDSANyKwr87UDoMwpSKdR9z9/N9+txssge01lvnAz
         T/s96r0+sY1DcmkZc780Clctkj1TnZMeEiYZyURZM5Fs//1y9Hxynshrb8y3DtpZ4q0A
         sqWNnXtxstIxKwaRRtZWgFDlwme5PqEEgv52AkSlIdUPQak2qwRTv4cf9A7tKlhpD/I7
         /pPksBJ8wmOfQtSIbkLO6DlKbpHl7C27f132UqaopyALG3/zMG95HB9HZsTkIQntQ9Nn
         b6ll/6GCoqo+hrj0HmaCprS+66+4WoHxOUY30D5G2/4MqIR1YfNojjZxwBK8sUR0E2rp
         wn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786867605; x=1787472405;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Enl4qlGarnj3oVlA3n6vmIXCwFtrLXr140Sfsn8p1jk=;
        b=MKAdHSJuz2TfJlT5yBv9jleXxkXMHs87Zv4yDzfUgoTiJN6kLuOoV8Aun5LxmPclOK
         Nwth6HSKrsIUkyhF02WMe2xcUaqHyvyQxQW64bjrMbIDPNSZqsYPaYRlFFTehGfJWdV5
         8iIAWxPwSxius/ZI5o+2CkYH2MlGwPqLrTr+SblFQZUMwZP6e4sZuTZFxjTRlPN3DZps
         gB7bJ/aqcDwkzoeUNJbH0SjS8RMGjUMlpkhEY92ROC4bzLpBE6ADiglMi+sHVQRVvRcH
         e9ocwYbSM89SNCooNQ6+moyWLUDZ7tYqFzggaiO4nI3S6hQqnqc9rqS4Cu3xCTlxUVBK
         0caw==
X-Forwarded-Encrypted: i=1; AHgh+RoIbMHNpZp2yXIfKq8hPMbaG2Qn5E8z6kiODIh6S9YhrYbioKED7SB5aAHwWZP51FhIZ6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnLh2w9sSH57QH/wqZy0oQxMI+Uu41VWzlAukV0Jg9xtGwKai
	rKCizp3gqqMi567MtDLJOcYiRwy9sTP92tRUb/4PNHk+rtBgEMcZ1/Yt
X-Gm-Gg: AR+sD13CO133FgHxyWoqN80Uj3qhqk5uFTgR1qKWHNqOkI8vdurwXqQADTWanY/fY4i
	KOH3yYMzavuwRzOG5Eo9bRcC3JFrHbpuvLmmEHBFArlR0IOAEe4gk+VeW+iWb/HCN631C4TdVoq
	BxDUbC8qBU0dfIceDEqWuqtUXmGQ5VEj66dommw9VHRKq70JbHVGJBo1p3t36aB9vSYAHQX9EoI
	UA5lhYfmHxlUWf7Dunn4gIKjyZsuV7FrQ1GCkFvXtTRjxNGCsHhpWTLQAikpZcED+2YEVXDN4oG
	0jafYHP9tQYqnRWOJ0D4DSOFyBRdSl2pQVJC4Yctyg2KVjwTx5niyF21BdAkNJ26c/DgAnEWVlo
	Gs71REhVZ2BbQ8DVFJINL3ANdjyOPBPgP0l8WSrrzlMTG5t39a0aFLOiLtN8IX+Kl/nBewwTEUo
	TD4SFxacxwXo6FQOxz1d5TgKKM7hxSCGR8NxSz7zBQUFGDN73+9iTaouMWdxrL8Vbn+Q5oDv2od
	5DV6ffn2lFDxnnOHs2XnQ==
X-Received: by 2002:a05:6a00:808a:b0:848:2a69:97be with SMTP id d2e1a72fcca58-84fdc77ab7dmr13325335b3a.10.1786867605122;
        Sun, 16 Aug 2026 01:06:45 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517cfeb39esm1779300b3a.4.2026.08.16.01.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 01:06:44 -0700 (PDT)
Message-ID: <9985a0858192282921de335359db85ab1e7db1ab.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 12/14] selftests/bpf: Test Program Structure
 diagnostic context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 16 Aug 2026 01:06:42 -0700
In-Reply-To: <20260816015746.2632990-13-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-13-memxor@gmail.com>
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
> Exercise each corrected Program Structure report. Place a missing-table g=
otox
> after another instruction so its attribution differs from the subprogram
> start, and assert that the recursive-call reason names both ends of the e=
dge.
>=20
> Add malformed subprogram layouts for a branch crossing a subprogram bound=
ary
> and a subprogram that falls through its end. Both cases carry BTF line re=
cords
> and assert that their structured reports include the corresponding source
> function and file.
>=20
> Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539=
640ee5c03384e5d77bcfb5686@mail.kernel.org/
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
