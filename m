Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85E33C51A
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119957; cv=none; b=ix4Gcijbqe3YCtZTovf+zfS5j1TwkziLsKr6EQoTD3iCa/Y7+RKQ8OqDyQAXGkGyrQ+Jfri+mP/ZY+eXto5aWy33QIaW9LoQjbi+4TnhlacwZuA5IhWOTpYfJXNz7+iBgv21Mlu6dZR/AOVTpw15eHIIym3T1vVvvsf/gljgfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119957; c=relaxed/simple;
	bh=4mH1J8yDq7pAZhiLqmVMilOTDwa9qdnXQcYCSq/3Yf4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auWeuSsFIoEGv8z6y5hDrcUr2e1KGZsmpnJhUrX0Y68mDkEZHnrV2g/RJlaPIkltaoubVzNNEdJnhJyFCHMydPCo2SWOI/Ws9FQxC3AkKxlvMoHoUcPNiPAWHihrWeE5ZQ/pEhRzBNZVybefar3PIasBF+DYJHJFugqGuxg6wGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjeQm3ug; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjeQm3ug"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so4356892a91.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776119955; x=1776724755; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4mH1J8yDq7pAZhiLqmVMilOTDwa9qdnXQcYCSq/3Yf4=;
        b=cjeQm3ughFrkK6E3X1IKHWdj1ei0nr1wtEmm1u5NEYwxa/Og920857L7uc1qDXoDoX
         OO9w0kfqqJ6xa1tzVtv1YGIKzNLFZo6Z1ckDdHQIvlRBSnSSavBzp/ntZQ/QVcA9Fh6Y
         ZxzOytQTzF2dtNsnIRobSajnNNptLVdV1TC2tHwiB0FlRYXGRCQn77Z8uegB3l9F+362
         FgwgFtFnjgRbJvxRPMHyMUt9cMe+IljDPiuH7VhzDQT6qZjyZ9BaOXhP4aVOb2Cpdyv9
         Jlvac127tzImecN83kz5UipzfTc9I3A379PIaKFhzuW/hTSPRiNMd2yC5rb3RFolKT3r
         Czsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776119955; x=1776724755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mH1J8yDq7pAZhiLqmVMilOTDwa9qdnXQcYCSq/3Yf4=;
        b=FZzG0Mi3m5TfqDcPJdeFQnjePToQxIHCf+a3j03G0hV+E6QbgUWQOMm/6GVb1I8T+N
         VJH/pOckrc1osKqyqFBh3KDSxxfHN2CFYUNSYrN9nRHWbcKBukDVIm3tZ0mLHeL4Fkia
         u5zD3oY3dtO038gpimo0/6DZAM6yS+O3ndugfGF70MzD3+FL9HpYDL9VqamzL4hWez03
         jFo6zpIVA8rqtAVRiI3GK3BFadPTVjPgInG9+t/eH3eqxJAKBxBmz8wJ2KynB9O6uDt5
         lQcn7beGwjtpuekQGaIxCqHqiybkwc3LOCvztSBxSeP2Zp9/nqRFbwps0q4vvFSdSpnt
         8ZNg==
X-Forwarded-Encrypted: i=1; AFNElJ/VCVTQZgImrksi4R5a4voYit0iSNGFxA1smwg/a4heFQOle9fxdwkJwhvPz9aGOWXgJc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxsDKwBJA5qnwCVdQSMkRQwXGHPUGqFpTf87ZFx4S2HTaqEu+G
	P6VGfvYRtDBtjqPFcvFkFjHCkJASdn/v270zhuWoWHdLYnE3Z1ZNGkVO
X-Gm-Gg: AeBDiev8PujdVf6LAG4yeViEMx3+3xpQ8SbbIPrLUJBKoaFU/m+CGpwUYYwUcrVbkgZ
	UsiufUirke0dzXgbZ++V4LIjOVpKqUVdJmn68UafkdOtYE+GoINnAzNp8m4szD3BPghE653q76h
	kRh4GK3JMEcs94mTQQgGMMSMxHfLJJfB5nqJwBJ4s3MJypvNsvU2h8rC0Vr2+HtFSXDYOhUDzn9
	x8EDCoojYwz7djCT6wFpZBqXnmYALlgepeX2fjitKn+mlEpFAHXdAGX710/+pEo1ooRIZTpIkvp
	uqQ+D79l6ddq/bjSwjpDWr1hLUcqhVkJqV1jZFz8SdREsl/4cOtjh/C3duFiRzqgZQv7ZaYIW4P
	KvJ/x21d+fl7e1x91pWthZF3tKeMnlEsn+BhSqDMuWRnajW+29OykNV97FJqibw7migfYsgJtS1
	2gvZ1U9tVq0bfzEDpt4YiWeZ7LMMDoPvTdCQVniBQ/UsGTwHaxAXiw
X-Received: by 2002:a17:90a:d40f:b0:35f:b2fe:75d7 with SMTP id 98e67ed59e1d1-35fb2fe7eddmr6301925a91.28.1776119955605;
        Mon, 13 Apr 2026 15:39:15 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3afebsm126413965ad.72.2026.04.13.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:39:15 -0700 (PDT)
Message-ID: <5a9da69b323a8282edac4149e36bc0a56b91fcde.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: fix arg tracking for
 imprecise/multi-offset BPF_ST/STX
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Mon, 13 Apr 2026 15:39:12 -0700
In-Reply-To: <e5aaee29c55b7c801c713abe8977d42618df38ee605a25a4f8631d926f88b830@mail.kernel.org>
References: <20260413-stacklive-fixes-v2-1-ff91c4f8d273@gmail.com>
	 <e5aaee29c55b7c801c713abe8977d42618df38ee605a25a4f8631d926f88b830@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-04-13 at 22:35 +0000, bot+bpf-ci@kernel.org wrote:
> commit 944d3bf7ec135889f575f3b8ae4612684896737f
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: fix arg tracking for imprecise/multi-offset BPF_ST/STX
>=20
> This commit fixes the arg tracking dataflow analysis to use weak
> updates (join) instead of strong updates (overwrite) when storing
> through imprecise or multi-offset pointers, and extends dst_is_local_fp
> to recognize ARG_IMPRECISE destinations for BPF_STX and BPF_ST.
>=20
> This appears to fix bugs introduced in bf0c571f7feb ("bpf: introduce
> forward arg-tracking dataflow analysis"). Should this commit include a
> Fixes: tag?
>=20
> Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analys=
is")

Suggested fixes tag is correct.

[...]
