Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6823A564
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782416943; cv=none; b=qBh6SPM8MRllEuEL9R8tiNVQ4Pl28M+0F7lHIEyBHuCEZF61GlysMGUvNAY/sN5CUzwjmpAnk2etswf6lxWJCgQs8bzYoDBR/ZfW7ibaFgSMLmHLCKFevlSi8DVOAt5rbGh4OSGGIY1ZUeVoSrNJuTkYxnJ7DWyHcqXyksshKy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782416943; c=relaxed/simple;
	bh=16ZLkJ2LztQODTbG3O2U0cAW7v8gP6qg4h47Ihq6PP0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MM5V6nhghGCyYOP5StOTklQj3DZbu2cmsJ+u/lx3JcqmqpiQQbH3gZDPGJZ6f2gbvP8CdWDmTIFDnublj1Ntp380K6wEbKRmKQNeyVUL/oPSqLaHykFtfXG0UKtkCSJKdTUMa0GZqol7oqQvWu4RUZWUQSfV5Fwu7ZxcLpf3WD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjZ/qhRj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjZ/qhRj"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845b6f34873so106421b3a.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782416941; x=1783021741; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=16ZLkJ2LztQODTbG3O2U0cAW7v8gP6qg4h47Ihq6PP0=;
        b=kjZ/qhRjCDq2eVygGbatzeojqVIKKjjOJ+lzfw0PuA6RMnKVWu5k8GWJVB+xZGGRs3
         vsGtYnCAxUJuwkt+Mk7uMu6i5IVjpXUuvdyFJVJX2zqe2FO1/ddR5Odp7OCXC9GbjCGo
         ekakoqx2Tua5B/mj2j0hBqCV5w/3o+/hzmssU1OtrSQw3M5Pfc/iUYME5mPShc18Yt1d
         r9jQOKLA7PTCmbmucZisYUn4h0k/0elh/0MjeGTm7TXubC4GOFVAluocah7x8B1thjd4
         P598ahrQxy2iCdaUlGFYf+J7d8E9/4epQyS5NqVlg90r9DzYIf03jcteidHH5KcDkjNW
         0HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782416941; x=1783021741;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16ZLkJ2LztQODTbG3O2U0cAW7v8gP6qg4h47Ihq6PP0=;
        b=YFvNL+BEPhvAC8N5q2tTvqUjLSurwtvWq8XicZ45QFS8YhGRRPrmziRTIdVaXHS6eD
         H2J3v7WqDXmciGsIpwdjNdrVt8odCHGf9k5zTklnivGuGwzy8yA8TlllVLF1selTJwx0
         dOJAhZaUxffWEBChDEB0FGJ1SHsC1PJ1qJ8M6hdMvHs5crDjS0b27L6NzZhLnhjAaq2O
         e4H1cAcUzqoPP8A5YetXW9tjeZIA0xclrnoEdGYvO8iwAY46hxemCinsp36UVJGUnOGY
         R6Zxdi0PjSsBl2IaD4qUmz1RuxA3ZgXiA4c504hkBmy4vdCPknALCKigA6TKpQQocexy
         XNyw==
X-Forwarded-Encrypted: i=1; AHgh+RqmydSdoKHWoKih/YxwpTZ/fVPXQ0oMrCPT5u4lzRKXkW1c6ch7EeTJYvBhxFCGYL9ieYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbF1Gk4PEtR7xwB6YJW49gRR67D8lcPSurkh+/dr7YRX2Sjrs3
	jEKHXrj/SdcHH2odGlAkSgpkrq+V8C/gV/1JKVWVQzqgcYHbfO51HRVG
X-Gm-Gg: AfdE7cm88n3/qpqYPHg+6/vJkEMh3EIgSf710PpiQJzIrENxdmjKMa5FDIqx1X6iu0W
	AlVvhELpfpxbuUQWBpAlhgOy7uyMiPm58clW+Pat6xVWfBs7YQF4JGpU+xAY1l6KLI87sjLE1Dd
	hOLk1BBXvjv7jNjiuo/N7CceK458X9bTkuF/Eq55FyUCrmGso6IWGgRkMXDBv4cUz/Wlcw407Fw
	mVl0LNLFX+tgygoMlYmO26GlhwJ07qkU+mCGvDMFGXui2Q+RmNlJrdWAPTnNph/LoBTwazeY5ZN
	xRCYUMRCZWHqejiHrZSjSCreZTICxw3OoGpQ6d5KEOGK5nQOpTwA731yXzHLoaL/ERYWWxGoXcD
	PuPXQHIVrheKliL4U4QmxZLBV+LjRoVOMVB/YG9j0t7AiEd5WkP6p7OEYQFO4zMTz5+8bJWUTcj
	eLh45bnfpDFXSkGIobcxh8Sg9RgP7c2GP8HZ8FIxV9Ig==
X-Received: by 2002:a05:6a00:94e8:b0:842:2ddb:e303 with SMTP id d2e1a72fcca58-845b39d43aemr4839725b3a.12.1782416941271;
        Thu, 25 Jun 2026 12:49:01 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413d2aasm5840852b3a.59.2026.06.25.12.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 12:49:00 -0700 (PDT)
Message-ID: <bc649ab9876ef71618d47fbfd581396c27a236c7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add kfunc set test to
 resolve_btfids
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 25 Jun 2026 12:48:50 -0700
In-Reply-To: <20260624005546.1818483-5-ihor.solodrai@linux.dev>
References: <20260624005546.1818483-1-ihor.solodrai@linux.dev>
	 <20260624005546.1818483-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-23 at 17:55 -0700, Ihor Solodrai wrote:
> Extend the resolve_btfids selftest to cover kfunc sets defined with
> BTF_KFUNCS_START/BTF_KFUNCS_END.
>=20
> The test verifies that resolve_btfids correctly processes BTF_ID_FLAGS,
> resolves function IDs, and checks the kfunc set is sorted.
>=20
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
