Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834A370D65
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568529; cv=none; b=gjjyVPkp6IF9q99r6gKAM+iNjrwURz5tSeiAjnCPWWa1MyQmmMOwhOmPZJ2f/DDdmcCu7UaSuHbCXAGUfMXc5dT44tMk93toISl/ljHxtH8x+KdURT1K0g7qTVvYO7DGDrjX0PxIK5bDHdU1yZqzyu/7n4v88rFsQ0bENiB4owY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568529; c=relaxed/simple;
	bh=ISEtte2YRGcmWkrcUHpDS6PMfMZOWkZs5vlInnwzUbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csHtuJ/ORPvT5KgwQ/8n2Vw0F92X05PQTwT9IvndGvjDgmLIQdRWeXtnNtmnd69oBNZhv+WBnkyQYS1qBIb/Pk1cYBaSZYykLOFmc777aK6MCy1M+oUrkbKSQ2gCMFmBlGAPqkkQU9wMUE4VwZLKnhgkSnPqzHsAr7DeWZV9LOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJkcv25a; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJkcv25a"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1274204434bso4670378c88.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 12:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772568528; x=1773173328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9yF/aUyo6FiFRr8w9SYSbT1Zd6hZOeTGHVjT13l1hoE=;
        b=HJkcv25afmCkUv3iLfkgKqnRrPxiIGQbc8eY35jXJy2JamiAwn6n+/2NrnoDWeeH+F
         Ip89KJrdxqwG/DdWvI8V+oGBpiPYQgGPHrcvJ4PZy7kVhgCUs83bPytcLGrLM9OWpT16
         BAutvlZgJ/+dH1cy6mMst6RE0mYgTyIZe/tSWqMgHN6xJ177tc0c2fD39iYPWN4kAPEm
         H0ZEpGSZI39jS1xfKxgKF7PTe6cKc1h0egdst2bOgB7VLoQ6MjFbNKX9x/hg7KuhPOVl
         qeOqm6/OtPMb0BO24N/AkfeJAClt91AgJjl5Rhi5zQDBsqApA++M+hql2kY9r9JvOPDE
         aNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772568528; x=1773173328;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yF/aUyo6FiFRr8w9SYSbT1Zd6hZOeTGHVjT13l1hoE=;
        b=Xu4apYx+foOCNxRYMy68LF3IzbovLFy2B2ek9QUEejOaJZboSOwPhAiDvwf47OJHf6
         efGsZtWBCFbK7TN+0X+c4HNMvqD7PURwUWpS7lsYkBtCUa+J85xIRC1ApfrvkmDF62dS
         0op5w8Xj7y4LFpSFRD+7lDBOUhHxxqPEgWz92qvChc3VfmbSbR0Cap3OcmIgYAHDEyUx
         OEYaoywuUOEcrzlfozgHusylfvUjy01yAiAr+AOmUh145KnHF9u986AfxwYLw7FsYjhE
         3LLaoyIDt4gj367gV9jdAAaD2YVUGqBMoMNIWUgJ0h8uwOCWLclz84BM83dMs2ehShBE
         CQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpszKKHaD8nc70mbcAohok4cbDFxUvBqMs0Osb6BL/y17IDAPjWFu9155QFXU/CJ5ye5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfgSl82Nf5lLMdxY4JSVm+2gYrz6Elg8gX5dV5bLfAXeEHc6Io
	JJEpBtIuOoNX9FMBLgTw5ro4mO23lAwjeBxzTOR/a+a8CvetVtPoeuao
X-Gm-Gg: ATEYQzyUK7S55d7c50f1lm2GTGqu1NZOI7+SUiXLctfNmT7srP6kzZdLo4c+ilbhuB9
	8CcEPWOw4G+GjEuctzhBBDr2oVjT87H4eYrHdAnJDrcFMiEnJMiP/fF6V55GFFF5bexUjgADDzb
	ZQKZVSzLs81IB7bP0ln/rq2R6aRGY2FGb7A+93+i/heL0clos0Y7bXvlCbQTjPS1FmTQm0juNJn
	iZqPMCdIAra1gF0/6k4zSBefDMommhkpaj0fv7k2WslKvahdDfW5RvvwxDA5bKahBX9uaphAv/i
	usSokvjPXPjjADlLP7jbiE7+PA07eeDCscI2dTlPRMLFV+0/fi0+c1aUv+mXqCoOfIH2SQC8drY
	WM6JjM+cCg8AuMQZFj0VLzMJpsYIjxPhznVxUG21xQmSoEVx8Jea3z9rGm+onoqLlrmIbju0aa0
	sN03o0dIGnFOwxfGe9/zSAk2BMNuL2vtsvtXcM2QvfUsSqEHCcS94TUKQ7OaGctVvr9Zrdr9nW+
	MQrkCER
X-Received: by 2002:a05:7022:7a3:b0:127:9432:485f with SMTP id a92af1059eb24-128b0ce47b5mr1159115c88.5.1772568527731;
        Tue, 03 Mar 2026 12:08:47 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32633sm20160083c88.9.2026.03.03.12.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:08:47 -0800 (PST)
Message-ID: <24dceff5bf15b6c3e204c69617ac249de497b034.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add trampolines single
 and multi-level pointer params test coverage
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, 	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-open-source@crowdstrike.com
Date: Tue, 03 Mar 2026 12:08:44 -0800
In-Reply-To: <20260303095427.38981-3-slava.imameev@crowdstrike.com>
References: <20260303095427.38981-1-slava.imameev@crowdstrike.com>
	 <20260303095427.38981-3-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 20:54 +1100, Slava Imameev wrote:
> Single and multi-level pointer params and return value test coverage
> for BPF trampolines:
> - fentry/fexit programs covering struct and void double/triple
>   pointer parameters and return values
> - verifier context tests covering pointers as parameters, these
>   tests cover single and double pointers to int, enum 32 and 64,
>   void, function, and double pointers to struct, triple pointers
>   for void
> - verifier context tests covering single and double pointers to
>   float, to check proper error is returned as pointers to float
>   are not supported
> - verifier context tests covering pointers as return values
> - verifier context tests for lsm to check trusted parameters
>   handling
> - verifier context tests covering out-of-bound access after cast
> - verifier BPF helper tests to validate no change in verifier
>   behavior
>=20
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> ---

Again, I probably miss a point, but with current implementation it
seems sufficient in verifier_ctx_ptr_param() to add one or two
tests accessing void** or similar and checking verification log
to validate that parameter has expected type scalar().
Why so many tests are necessary?

[...]
