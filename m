Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03FC13959D
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711692; cv=none; b=HtcWMGPC170RI1xl/FESSA31tl+DomSKaZcVKozjUTctndlRQZ7zIwCY9C6uyqkdM0QplxWRrr/B6KJM4erWCQitWPJnKbwgp/MSNNJM1Y02f7N5jZHCyWqw5LZOFG706L55aytAjR6pn6AEPt4LSEqsiJAnJkniUT/zC/MrPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711692; c=relaxed/simple;
	bh=WtXAi5RJatKrDGY8usv+xbl/BxL4Ec/inwwGRn6Illg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqDeS9VZJV9NxXQROmQJGAewC7Nw3iNh1hzWTHbjnw2KPtwWsCQITsXkMsh/wtrlmiB3yXbRRykTkXO94JzNqCwxhG3IJVtMKNF3+eTsVgWh0w0aL3+oKafXRev/tXorzKBgQdgoqh87ScXbKUJRw+06MIYMhL9xy7wgfnNvnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtRFKkiu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtRFKkiu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a2ea96930cso9647825ad.2
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 10:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769711690; x=1770316490; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WtXAi5RJatKrDGY8usv+xbl/BxL4Ec/inwwGRn6Illg=;
        b=XtRFKkiuY9eNFY3FLp5U9v9bZvIMUxcN2YOKmItdEJgEdoPoJ5ewW2kq9j0i5L7Scg
         dXYpv4qELpWQ2Z/5OWH2jfSt074vQNW/grSCw2mI0uFXi7LoFEibvjZ4c5WUaUR3cuis
         h3FCwFAQGM3H+fGXwjUhF52sKBCErzqI5WG9VwzsYB1nbRDo0rkM0+4wNeyS5A9PIPh2
         UFWuEsuV4gvyYlOdsGktcg730TNg0Q8JTqM0YM1ZN5ygdFRoTgBHtx5IcaXVB7Fwv6Zz
         74qYNY6+YnLv1tIMaitSJJ6TtkrGJbAIobT3ZbnxASOgaxsf1DBz3SaWLjvY0YMKTYlW
         M0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769711690; x=1770316490;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtXAi5RJatKrDGY8usv+xbl/BxL4Ec/inwwGRn6Illg=;
        b=p0uWJEEPDwxHnT9CiWwLRlozdKLM8ZHtbZo7AKagMol5GfL8fpnlYnTUeEdrnPAnwR
         /Qbtu/gBR+HjKRXtDTH+5H9IjBfdQ48x8RLLGLFxI52BJwwrYmSdHeFVR/gHb2uw5po/
         it8ecOcudjwa+dZKO95ivgrCgyXk3LhEk4We0M6IK59a1AbFAQTUdMbuSxYxvtjZVE3J
         jl4Hit0XHHO01sbUJdMc6dEKvyjJ1NGb7B/LASsDy7d+MSjbLNQrzIcbWU5uq683mM/k
         8oxvOAClGR8Z4I5ojWqRj8CHrugqKKQ1/bEuUoeaU+p79cPKZhnhauLEj5a2rRkpVwpQ
         9+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXVpSOroTY5um/yRE83/K9GEVAdbzGGjJtNnlyZEsH8nYWjL9u7XBq0nl5ja/sXTVtvw7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHIpdzak7XJLJ1dsTFPL+nkToLu1pn2koCuxDsrNCLnIXNqky
	rMQ2aw3iMVUCx6vKykDfGyqVc8VQDI8AuurkUOdCqaOD1RilQ7ilj93h
X-Gm-Gg: AZuq6aIuSOuXuFWvBMpaFJpLMgA1zSMGcBoY4JYf42LvB5QqNHtyQxIgDgjykQQZ5SB
	JmEUxNI6uDvSqVy1cBtl43rY/oMSvYDT0CqZ6nkQiQDFHN9oK/Z5BBNhWpM1ArYPn9PpnOL4W1V
	gmf5eT/r8swRgPrycvivbLCTSD6EllJSmmKZcrDCthmRvl2BhyeQ9vmjCEovwJSWwNkoe7i65At
	9+FmNYE+naTg8Ssa1/1lxaU9CDBpyDesxPs4eIJA1U/9Q4fjtUgYmpqMUpzZ9Ki8gfNVscG4f7M
	Zwv074+0QG594n1TP+n3yLqtTx1wFXz9nLnpy6RPjKwcWKz8FSvdqaAk0VFkLoNx5dkoN+OFnom
	1au/zzXmpuTQzXkdgGA/W1cK2a5v62E/rmvN1h5ukwk/U8N7xUmZ/GNGr/waPwYta/m2F/0SoNV
	SyYz+P0fUuAqomeJO6s3JSTbJ9TaOTXuYDizqYB3f+
X-Received: by 2002:a17:903:1a27:b0:2a7:3dae:de9b with SMTP id d9443c01a7336-2a8d994a48bmr1401175ad.44.1769711690170;
        Thu, 29 Jan 2026 10:34:50 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4153e4sm59180395ad.39.2026.01.29.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:34:49 -0800 (PST)
Message-ID: <49e21fb23bae370f314211828bcca39745f4cf08.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Consolidate special map field
 validation in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, ameryhung@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 29 Jan 2026 10:34:46 -0800
In-Reply-To: <20260129-verif_special_fields-v1-2-d310b7f146c8@meta.com>
References: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com>
	 <20260129-verif_special_fields-v1-2-d310b7f146c8@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-29 at 17:38 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Consolidate all logic for verifying special map fields in the single
> function check_map_field_pointer().
> ---

Signed off by is missing.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
