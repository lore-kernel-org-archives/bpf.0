Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91B35AC1C
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340775; cv=none; b=tmHJG+dMaANzEzOwklv42EOShMXqCaKncqIIgGsKIJSzYUWzasn5pfXo5BPXfHdEth+b+Cdl8vxsDrmfvkvu5Gm6pLffUEb+y0PO2GkX+QbB0X4cAS1yo4DtosTSvyOXZkuoEBAOARAMc51Qv5LNnbdiFxoQemw6Z0qPJtRC0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340775; c=relaxed/simple;
	bh=4mRR/bBtoAJ5F79UUHa1OtQbOreQiACde/HSQARvrPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2Fuf0hPqaUT2tcrkV9xR1p0pNqbpTm3Lq3NudXcb5oKTKQwE9bjrIp3og+yYWPudhdpiIgZCrDkSnCJ2UzRkM5oO5HRvpLV0ycPykj4PUjF9PYPzdVfv0SCCewd1pgql6fUgNyJkvm0s4js32Q9JF+G2Xn8facDxBf5QYcYh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIKpf+MV; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIKpf+MV"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304c520fe9aso11178612eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340774; x=1780945574; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4mRR/bBtoAJ5F79UUHa1OtQbOreQiACde/HSQARvrPs=;
        b=YIKpf+MVqKgvoe7Hz+xuvwc7bUm6z5wKXLCmtCIQ0A50dn0SlZtBb+KfYlKsq/9Ls5
         ZHzfeNPz8WPLfCk5EdJV3IFftD6Rrrd6xgQ9t+japjLMVkVJxdQCo0SqiRUPSY8k+KH3
         /FCIJwVWYtRk1zJ7DPKZxQRLTOVAHBy5xJ0xhaeKpqwb7kY102ciiyas28jMGrsqImuu
         GlvgD/JEkYmNhCT4Ulp4FyNWRr+ll951dPq2533mOpq6HZR5qo/UjLcpdG4o3tew9adC
         15OhXodOVtAHVD7xERl4HSVukpn7mowuN/LNdoRXyxlmpubUHM/rQNbrN1SDNTJsE1AV
         O4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340774; x=1780945574;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mRR/bBtoAJ5F79UUHa1OtQbOreQiACde/HSQARvrPs=;
        b=i1NEIBSWpcoQ5Mll2rqupbn08KZmWn19NI/+4hdBcQoEdjKaZviNJFpotBMDpFgAJQ
         YmOzOxa+5JAsFpAxImdtMwO5/qfWYTVxvaqCXffjfoFIYcASAfRlR1PixV2+gKsTHd3u
         UwIW9DDANeY+ID1guMX52XnUEoAPCaX1ylnFAdVa3quBE//g1a3PUcngoGw3zw0U9jv0
         0GsUSIV+gL25+jCh6tvC4HGZs+kwGGZ+DTr+Oxhwarip59O6yX/Dend7KGfIcCx5zxe3
         xWhS+RPo1XT1Yzg8On5Sug4L2uTAvHNuojQyxP17yE6Gmlq/ImIiPBcpdqPfbThqJBW+
         1+AA==
X-Forwarded-Encrypted: i=1; AFNElJ8uMdovH/41RN36ZN9PaUWVX6YQTDh5dE1kDSpTnOt8mZUIWRsoAJJlxdYpmvTDahq1rb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2u7JwcfVH6J7bDxIkhpyzjdQ/ymfR7YVHRdt8eX0+Uj8R05gN
	MivfwuWsawDjaofKER68zBCXMZI8gK6IYiG6F0SYkniXmv72Ugj/FG9i
X-Gm-Gg: Acq92OE/S7Po0KjnxVQb9xHYOqPt93uj7WSWVA3HDu3a80eonO/F45C1mRK2orqcsJ4
	R6uhap6FqxjzSQ9kkOuitQu8bOOBsNBo/qWBN2JVbPZzalmVIf8olYololf4joIi3+3yIvV8A/M
	CA/pUZ5dlNvHNc27PVRhky2cVXci36DRPD4Kuuk9UxnJRv926XzzBYDnTp72czSQ6Yqa6to0i7R
	1ad+sHVoPSIFn68JuqfwoYDgq7N+yJGIvz6UQSErXzcH0ILyVlagK2vx00PjJ34L/rrVervZ2IO
	VTYBt7JxT2oJN5UFxSNnJwd/zTPUUibY4zMlR0ImqOCks0wN5VXB55boaK/0hqyH1EY+7cErTPG
	UXVU9IMLE/DSnPEtrK1A1L2C9dOmyNdK9cKbUj9TYEG0QAxE9ZPM6W2GVGD6t+SKozH2WMZ8U+i
	DD03QXlPKgkCyIE5nuMWjLjfsT/jp3qHfdCr/8yY36sB3V9jV4KWJrWhA3EkubC/FDOMKYdMlNm
	/tXvOgZNtkYZQ==
X-Received: by 2002:a05:7300:3723:b0:2df:7fe3:96a with SMTP id 5a478bee46e88-304fa2f730dmr6667924eec.0.1780340773833;
        Mon, 01 Jun 2026 12:06:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed30fffesm9240522eec.11.2026.06.01.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:06:13 -0700 (PDT)
Message-ID: <c2115949da23680fa7f424cfcf86e1b96e117071.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: Remove __arg_arena from
 the codebase
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, 	song@kernel.org, mattbobrowski@google.com
Date: Mon, 01 Jun 2026 12:06:11 -0700
In-Reply-To: <20260530002259.4505-5-emil@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
	 <20260530002259.4505-5-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 20:22 -0400, Emil Tsalapatis wrote:
> Now that BPF __arg_arena has been subsumed by __arena, remove
> __arg_arena from the codebase. This way the user has one fewer
> annotation to worry about.
>=20
> To remove __arg_arena we remove the typedefs we were previously
> using to minimize __arena annotations. This is because __arena
> now also includes a BTF type tag, which is ignored for non-pointer
> types. As a result, we cannot capture the whole __arena annotation
> inside a typedef and need to directly annotate the pointer type when
> declaring the variable.
>=20
> The extra verbosity is worth it because the use of the __arena tag
> is intuitive to the programmer and removes the __arg_arena tag that
> has been a consistent source of confusion for users. The typedefs
> can be reintroduced later (without __arg_arena) once compilers start
> supporting BTF type tags for non-pointer types.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Do we want to add a dedicated test in verifier_arena_globals1.c?

[...]

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
