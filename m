Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9247A74
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988940; cv=none; b=XChQLSr1V20rpft3BvN25YnlSEbq7xTXIR+8G3WQCphjbwT0KXoSMPySf7TeK5onlcNMw4QDfotAWpB1TcdHaHczuStGBAhGuE7sMaf4JuBn5olUVoMHgl7bSOs/x7ToB311+kpqXEW/APk5DXPBXJ6ak0zcm1bV4NhyZuGc28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988940; c=relaxed/simple;
	bh=SU++947sBd/Af2hmdh3NJzIugtlKzhQM68m6dXAGaI8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRGhW6c7ph/S5j6MzEcGO4Q+wG/VxxVpEeUVzMHW3I8XLq5xDtjqRKiTVBwX1VzOJCWoMCriFeKnqvXpNV7Zx4RjsUJ6vw/OMfdJuqc6q4KLBwG60WcCDK7C/+SgAokNzbuDl86q1zdXHxy93uXwKs+BbviepGOry43oKpQYzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h13fHe/3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h13fHe/3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso4009260a12.3
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711988937; x=1712593737; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SU++947sBd/Af2hmdh3NJzIugtlKzhQM68m6dXAGaI8=;
        b=h13fHe/3aXtohl8EyN4T9H9w5P18Kry7AuDG5XMi9/JsOzYdGIEQjudgVOUmQxn7zi
         dLW1dAxW5YEeD4GlXH6VLXzWhVA9CZQqwXhKGJ4jrAXnAe/aK+oWppoe8SpMZZf4Vq00
         zYX2BDsGjlNRG8e+8BAfSTkMrHcAiPZNFSb3tFY8HgkcwrsvLq1dtk8DrE+AgToTjycy
         MWh4Lcd6/YDfhHvbz7eSrVU01Zd1Ctt6CVxHtxPs2LJZbXPLCvzl5PCIEAPttAFK8XtZ
         +s0Vw0FD8Apew/p0P9QB2v8RsMWqFVphSqPQKhhr6dJQpG3UI/tFW79bpOKUESEziWtv
         TfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711988937; x=1712593737;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SU++947sBd/Af2hmdh3NJzIugtlKzhQM68m6dXAGaI8=;
        b=PLhSRGg0EmP2dcPmW1Wz+05atPpThDBSfwfixilZpnxgDAGaiJDxQ5Wi815CJGI6xy
         07CaoIM6Tg1Ig+ofJ3JDGQMIUCaS+fgy857YPlEDHMLRQGEllJIr2MkYQXNJ05eXxj4O
         YFgelaw6zsuw4KJJJ9a7G2uIX1s/eLDLm8uy1dxER//PdnskXllweisiolonrD8pgfVJ
         gZPNmbkeprlwTcrcUbRbBFyPdaTc/ado0DbagxeRXsCPfKEtf7YAsgYr6ULySmBTdfbU
         odJiZcubRh9M7k4yR6eayW6bbG9pFM+++ZwUBomBolTwrRdjelxuSqyFA5KnxcuntUhg
         568w==
X-Forwarded-Encrypted: i=1; AJvYcCViuvHGRTuBFEQNpw7leXi6awPpE4+8erA/USZ/XVaC06mWdDEPrZm07CkIeXXpbsLJHQOlKuDs2fJeNajOEQpVl9oZ
X-Gm-Message-State: AOJu0Yw2er9BePCVMMzyJz0pTowIf4rygiuEH5Cg+J4PxQ9ikjYhJxI2
	F7pwUgk4jUUKGnyqyou6K+5MFV6nw0dx6FTTLr/qYQ/Im3N/AIHQFAeSDIdOTcA=
X-Google-Smtp-Source: AGHT+IEyi3E2+sn2fWAkU2em2ApkmsyFGCN+RI2rMTO3i1FZ0DPBzTIs+Tb1qVBhKzOPiKTovALb3g==
X-Received: by 2002:a05:6402:518b:b0:56a:e8e4:9aef with SMTP id q11-20020a056402518b00b0056ae8e49aefmr9144834edd.7.1711988936501;
        Mon, 01 Apr 2024 09:28:56 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7c24b000000b0056bdec673c3sm5765369edo.38.2024.04.01.09.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 09:28:56 -0700 (PDT)
Message-ID: <e0426944e09d865946876f9bbd8acb7cf23d8705.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Add internal-only BPF per-CPU instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Mon, 01 Apr 2024 19:28:54 +0300
In-Reply-To: <20240329184740.4084786-1-andrii@kernel.org>
References: <20240329184740.4084786-1-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-29 at 11:47 -0700, Andrii Nakryiko wrote:
> Add two new BPF instructions for dealing with per-CPU memory.
>=20
> One, BPF_LDX | BPF_ADDR_PERCPU | BPF_DW (where BPF_ADD_PERCPU is unused
> 0xe0 opcode), resolved provided per-CPU address (offset) to an absolute
> address where per-CPU data resides for "this" CPU. This is the most unive=
rsal,
> and, strictly speaking, the only per-CPU BPF instruction necessary.
>=20
> I also added BPF_LDX | BPF_MEM_PERCPU | BPF_{B,H,W,DW} (BPF_MEM_PERCPU us=
ing
> another unused 0xc0 opcode), which can be considered an optimization
> instruction, which allows to *read* per-CPU data up to 8 bytes in one
> instruction, without having to first resolve the address and then
> dereferencing the memory. This one is used in inlining of
> bpf_get_smp_processor_id(), but it would be fine to implement the latter =
with
> BPF_ADD_PERCPU, followed by normal BPF_LDX | BPF_MEM, so I'm fine droppin=
g
> this one, if requested.

Hi Andrii,

I've read through the series and it looks good
(modulo architecture related issues reported by CI).

Thanks,
Eduard
