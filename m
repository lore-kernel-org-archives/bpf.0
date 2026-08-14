Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DFA3624CC
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746283; cv=none; b=ss6rcmlqDGAFj7ZslSHE4NQtQfTavHw19ZFB/RH9yPCT5ry1bq139DhDIkYxoJShfdfjS74esBgPepI6ZEqOsJV0Rl5vOgwjwhyPLwOP8utOXGrv3HM7m7afZvfx0V8zB8PWgwbigMNcbUeLGYidd4aNF30GYZ7vJ/KRuVje8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746283; c=relaxed/simple;
	bh=dhpjWZ2Tycp1HuZXZeKui9ccCFITazEi3l3AANhY1tc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZx6/JmOLsEgEEyWa1Eg/nEJNV6XVoy9CpfL3odV5K6PkuqNUIorycoXqFLUypvDTsOs/6Ot9SIN9jdqQ8wKUPBR881CC+JGF64TmLDLUylowYZempq5Ugok8erWzYOAMLj9oIpvvgXxD2tKHLxi1l/1LEr8pJcsQzAOSXrjJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klYvvVwI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klYvvVwI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1046570a91.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746281; x=1787351081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dhpjWZ2Tycp1HuZXZeKui9ccCFITazEi3l3AANhY1tc=;
        b=klYvvVwIEcPu9gKJBSbE9vWR+cTscF+YUUaXjpmIXFeNKXvLarcgy5oM/Pm6MLTbV6
         WSw+fLv6b0nhIC77mjea9UtERLa0yQqxUmzp9ZhJIeL6tHR3GYqR8DPooG6WUlxyIuzw
         2pYcnSGeTuTZFLTpLdsnpeTSAu4pU4UsLS2YZ8iTxM0wHboJrvAHGvBW9uy/AI/fvHhb
         lBpKWogudlbnxGRBhoSQ4fLPuV2CQcItYmxCV5EsfmLt+kJbKnShTWsHr890euEVL0sI
         4v9u1QkN8vEL658EWu0hFV4Qs2TJu+eVxFsYIZqlKdIdEzfmP+Exe/cuOUg4iVqng2mc
         EIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746281; x=1787351081;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dhpjWZ2Tycp1HuZXZeKui9ccCFITazEi3l3AANhY1tc=;
        b=Koyczzrq3h7imFILanE6PP2xC8x93rOsBLxzirjNTNs7nFgWYq6DRGF3YBmxoae7NI
         Vpx9chydNCm8zJNlRAWh2DJM50TFyYOoThFuipW+3QepodAROJwPBPEnOOQZ7S1xI5Hx
         69NiRTS5MBvSQxffx8KrHF3EqWI5yKyAov9zZAcn7cWA7nAHCX0KEVXEEI/OKfmf9+TO
         JLIvzpw7JkYvq4ZqXBevPQpIg3O5K9jEuklzIopJ4gM4XL0cyk/SKIuUJ3ZEkJQdwDqc
         HutLYKQ8cIjF2U656Tm5JxdBEf6GrL5PxrZ38YTYU9yjQcn9sv4E4HVeOg9mTd8TyIiv
         4dQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzvDuUaRg/gu9+efda2OYBdiDHmN4fqtSGWgwOnc1w7IGY58HuaD2XhNC3sndFecjwPJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOfHOVOBp523Tf6Wug/46PAE5RjBoKdjIwyPlxQ8V2KSU/kKs
	Eqguez4LPgzbHT+kHLzRfmfKb4WxeRgRNNU8zY8ZTE6dm5hEIQRh5QINE3guvASl
X-Gm-Gg: AR+sD13gKkG/886+WoRm5X8eQVkwp2p7uzmYUR4hRJSs84cYTRsN15YQdLlZJh1I5Vo
	bmyJxOP+nEDHv5u20SQTu85hKS59uKEeO+VcsYuYbyDoZAdA1lqC31uBG8R9W7pYWPLiRBVZeV1
	XZx5eEdNoVKvGHkUN2yVDnvZ2ZC85AcZ3hxDR+bE0miay3PlDsdpynuGvmdHNCY/oDI4oeRjhOq
	GU7HnljhQ64BaN64hZhFLxvaqsIoQ+nYC15EzppRHIVckDDcjfQ0NY50PHDAWHGusUeYe9ERlyg
	XkK1kAOz5ANCsukZv9E1Q5uwAr4MPZbBVxPn7n6DQjax9A9UcvI/Y2cqOqBS8wVdypdcd3bIHXf
	NZjM0rkElLYjFpadVXv18gSSvLY7qcs80oi0Bgc47BtY2OpTx4i8KGI5Zh+/l2KPhxIqKdwGcxA
	+KwFIcnZyJLlLwPMBLSXTf0yJJm3OXzDDecZzHRrwvX+5wvSNajdJIkPlrCOJzaeWOyZAKJvHOB
	UMV7p1owPq7PYlb8TWARJ4LTHmwtqxEpBID8KyfazN+
X-Received: by 2002:a17:90b:54c3:b0:387:d9cc:7dc3 with SMTP id 98e67ed59e1d1-3931f61cca5mr12877503a91.21.1786746281036;
        Fri, 14 Aug 2026 15:24:41 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141388b2554sm18518227c88.14.2026.08.14.15.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:24:40 -0700 (PDT)
Message-ID: <94765f6dd63a1834793a32965ea3e0ec6e4eb567.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 01/11] bpf: Factor
 check_global_ret_scalar_reg() out of the global return check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Fri, 14 Aug 2026 15:24:38 -0700
In-Reply-To: <20260813200215.1993264-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
	 <20260813200215.1993264-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 13:02 -0700, Yonghong Song wrote:
> check_global_subprog_return_code() verifies that a global subprogram
> returns void, an arena pointer, or register R0 holding a scalar value.
> Later patches in this series add 16-byte aggregate return support, whose
> second half is returned in R2 and needs the same validation.
>=20
> Factor the per-register check into check_global_ret_scalar_reg(env, regno=
)
> so that it can be reused for R2. No functional change.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
