Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE0E2DCF70
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958058; cv=pass; b=subdCtHtbJWcqNJ+MhyMWrb6eZyj5V4UgD/wfMFPsIZaW9z56K0PXjmFIDXmMgD5R9rRKI0Pm4Q8cGFZL/IPrCGf2uUGwJGFM9P+p9gpbS5QYNVxeFeHzoTHoCrJqLnccXlyNoRxlsYKHJbrXIKpA1DxgVQRX2aTjBRbm7paiME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958058; c=relaxed/simple;
	bh=HeaWGXV3gxD5s+jdkCghVV6coJiNHhN2zm2jJT8sxdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7yEoDJHuZYUZFWgJxgPzCLIRmoel03h+pGsGLoZBJ20MQUlpFLyE71KhQoQh0O38dCWeMTTJco07ikQPvEY0smos87GLXUbhthmzeQRWUGpQeLR0bj7QsZcEQvFyQkj9dRaLCOKKNyS0ChBWmS3o085EKMyo+qvpIGcizg+4BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUZqukme; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUZqukme"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso3117015e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768958055; cv=none;
        d=google.com; s=arc-20240605;
        b=jufXI/ARiRN89iB7jVw3IIQPgPTxsGPk5nDG8b3s2Go9ltATaZyg8WttnkwStTWe6Z
         C1cC4UeqSGt3FDyAbvQ7xZ9AqydVeehLK9D5RNbEk5jLONz8HzIKJZsrafDn4DFaVGpd
         aK/wjPjUVjbVzEnTiDhRkcQCQchO+8YL/SrJGlYdAsaG6Wo6SWKgtmP09R/m/W85W22R
         DcINLVzz8n/8EINsMUXwUML3Za9RdQ9nplbBudOlm3MrU2HzTt6qwo5TkJMNEEjRZliw
         RHHEVPoxvbH2ZZ5p6kK1OOIK3PR7yfgjy6XteRv1kKX4L2EI3OHZ0ZZgKfy1B51XtV3r
         9c4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HeaWGXV3gxD5s+jdkCghVV6coJiNHhN2zm2jJT8sxdk=;
        fh=BA2AQJd9Ab+cwwKk0uBFCoY7t3RhWBEVQDh1ME0HFG8=;
        b=ikJSCTvfKY1Jp1dZ203Ztu1WW/2qG44Jz2LQT5P6k8mcC5v95yFUsbnA8Fih+BMJHE
         Alis2dLUOSnn2hDgAzlhtRcJWuzCXVvKeGpOmzwlwg0Cf63bdlrFzUH2q4DSiBRJWJXK
         cBakPFIkGKqeTqmtCXFk99MsrUoB5Z8hVBHcplJrnbldyfIJGSEZBgaS7xFR7GRPGuG3
         CWmtVzZuOX09Ooihws+QhnscJIB57xSfQk+7wPQ2nv4iNa8DK6FwEti3LHQtNBRCuWDF
         q8ggTPnjf9nPSpqgbuOJURG3ymLWIuNjjEEQw5r+1rJAJl/4Wr7PT+kGI4PL9ETaLYTv
         rwWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768958055; x=1769562855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeaWGXV3gxD5s+jdkCghVV6coJiNHhN2zm2jJT8sxdk=;
        b=WUZqukme4WywrCqWrVVPnqxm8TjwMLTGxGyEmkq+E9Ral9N5IZfh2MMfh6UvNaf8kZ
         8eGnG5poJDnTGjj6bLXvxIJQr3mrePou+vk++pm4D7iX4mWV60ETC2eGZA4e6UtzhOX1
         DKeujmluYsMPVetybr5/yFIsDw/PwYNR8gGGke4Ivk3IkFz8W52/dUN0TJeShdvmfKGo
         Dfyzi/V5Gyx/8QctV/1EMNRi+i+FKpwor1H+MtKXy4YoE4ZZD1zCvqjJVVIMp5i7okjP
         +VvzE6H/gfEyyJEXvoDtTXKdhTJVh6uufSw1yndiQxtTWvlTkT5OIqbxgo4OFu+exXTt
         rSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768958055; x=1769562855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HeaWGXV3gxD5s+jdkCghVV6coJiNHhN2zm2jJT8sxdk=;
        b=by5JjJYPaCuSApusWxPJR37fnKZFIEeAlE8ULKvJCf16i2O7EJv5BckVscB1g+D4vx
         4xIwotnQi2KlUbvEoT1yzZjA6YgHDSAy5Nsf28kGlATo/uGIutI29KTSnD1smaahABYu
         vb1tSC7FIqH/cJgABjENFkkQM8YaLEKMdz459lkTQHe+j7ItxdyvHdHYNh1Zg/GxU9mp
         Lc9kGhhHWb6wkDV3JY7gzTNJyTOgOrKoSFWbQj61gxMyFNN956WYnSFm4CrQonA3h3E9
         0tF88L3psDngPmv+4TUcmy5c1dlk/6gZKoHzBXo9Ym6TTjfAGUgH866O0TL2rNkU85Xt
         6m1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrikeN4t/gjLkii/MU3+YNF2r+KuEwVLWFFFbDuxH8awjXUaVeOF6FU5Tp+gduQ3CHFgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/YqlDYYPhrDoR5hStoOFqWr5N5d4C459xNHODKRwanNW9IIo
	NLrjylK7INyO1VH3iN/aEvoMPwSM7Vla5vS9eCZPlVCRWueaqiGcoEeg7xfmmi/uNJxAr7kKJr+
	g3c/WFF+JzuUDtaUXD8KmbegsJasKEb4=
X-Gm-Gg: AZuq6aIya8z8Kf4ekqWjZfE3qqKBxtVrPiaSzZi3hiupKccP9im9QA9zD56FOZRnDfS
	d34EyLAXld8Q5XOj0p/+0QsVPAhbIm+WhNlmFFJQKxsrSaj0/HeAJNjpZCH5V9qrO7xTOsBc30v
	cAsLChcRlFFplxnTr871CFrswCWD3btB6piImgJmzRU486wfAeth23oLV2uURZCQb//TC31Qg0g
	LtX9A2hZ+VaKdqG4s64fBB0fnF2jzxT36jFmtwlHAyCHRt6JXN2GQP3UxKqkCrmMLRzotPj/Ao/
	pYWR9oRF6mniyoAG8lc6+YaamLM+OcSatRxL4bRXF6GHQjf35eJkf3wpCGKzqHryRjspZ3uzPiG
	D8rRnI/PXdHuCJw==
X-Received: by 2002:a05:600c:1c25:b0:47f:1332:e5f with SMTP id
 5b1f17b1804b1-47f428f6d4bmr215986395e9.12.1768958054914; Tue, 20 Jan 2026
 17:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113083949.2502978-2-mattbobrowski@google.com>
 <87y0lyxilp.fsf@linux.dev> <aWnu-b0dlm0xZFDS@google.com> <CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
 <CAADnVQ+45MorO=pODKOEVXhpY1skVy1tPkkABPAxDJGx4vOijg@mail.gmail.com>
 <878qdx6yut.fsf@linux.dev> <CAADnVQ+iKDvHxg_bEd6Knp3dNb9cr+FiemFSCR=NBnyt1UdYig@mail.gmail.com>
 <877btbu6ds.fsf@linux.dev>
In-Reply-To: <877btbu6ds.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 17:14:04 -0800
X-Gm-Features: AZwV_QgY-BA3-qBYTOTS6XtWPDLlbnnKRu9OEmuzMwnXYBZDS7FpiCHt65Y4KG0
Message-ID: <CAADnVQ+6d1Lj4dteAv8u62d7kj3Ze5io6bqM0xeQd-UPk9ZgJQ@mail.gmail.com>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 5:00=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
>
> >
> > Matt,
> > please come with a way to fix a selftest. Introduce test kfunc or
> > something.

Applied the tweak for selftest.

Matt,
please send a patch to go back to acquire behavior and summarize
this thread in the commit log.
