Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA140DB35
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233375; cv=none; b=OEpuh9vXN6ZVdY5bjvDXEs6ghC/eEQFZzOWREIO0gN2IX5h2m4nSHA9YuctEjPeu3OkaDdDvjnRdaSHEnGRJ+LRteDKP6fHRzOOLq1qm5KbvSA/RaEk6Hj0Pld4lbkgJpdCOvGh0X1kbSU/j2M8wxaA7XiJs89uI6KXU4OqU2yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233375; c=relaxed/simple;
	bh=Q5+GsaZ/ZU5/DziVjngnmUXhgEXeJl16XfiKEm74qEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b7IUS5SD9/pummBwaJGzimxHpiZRvAw5+2vSf1yIQKMwtDcvYA+c7LmopB1PToPY0L0uGoilqwtQTJUXgZYNUdGSOTMI9gSL9D2n922oW7kSJGJ5AqAMsRt26o6sjvn4pU2OCP8xm/8T+BNdvRkp8P55wMl7YlOAs6YlD+s+xMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSkQVBds; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSkQVBds"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f6so8088865ad.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233364; x=1790838164; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q5+GsaZ/ZU5/DziVjngnmUXhgEXeJl16XfiKEm74qEg=;
        b=XSkQVBdsfKAk/sa+LnSR27FpqKNQsO8uH7Bd3ikMBlYmot3fRnDTUpMOB4f9Q6w8cU
         R4DdEM1wOXJwaeNY1oXtblD4rdbUKC1oxOsM8ZU+MsupxYhaZGYA41fpJ3zPI20iKYq0
         1Hb3umt5nYbKs/myiJ+swDK0O/019MsR7ZZMjoFdVQLCEfD8x1XTSKxHM350G04Jej/F
         qlIeQfzVoBHbGn4kGRiI5LFXzW9YadlmaeX5/YCD18EZF2luKJujerxqGtvLh/eJrSoI
         /ttnq/qemqPp0pGu/yb/tISl6iTwJy2rn34/TRt+4OrI1ntSKEbYA6aw3eSV+4ukrqR3
         M66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233364; x=1790838164;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5+GsaZ/ZU5/DziVjngnmUXhgEXeJl16XfiKEm74qEg=;
        b=I4d2KwPOXgtvKGynyxHjAwBnrHDRX/bXwrpdQb8x4rSb5MVeouufbxUb79X1qBYsKg
         ie94Fm4A2Tq7agDjA/Y/HB8wEvH4MPuUS5VEF18JBUS9gViRvtKLQP2JL/NucLxtpMwW
         KWkx8Ch7PA+SberPJkQnmbe60WEn5SIm69gPwNdaekD6HbwLGV9EdBFfz3MGQlzDxhGM
         FO3L1MgfcvmRZ9Yhr7TcAGUv292mt/6M3MmEQ5rdhSCKND06uTf2Gj79gY3Nago/WfP8
         WCXhPKs57yOyQbu50KcEOxbROYOTmh2wyICszWoozrSu6DXKRmmwXY3Hm/fcBOujkVLg
         3/Dg==
X-Forwarded-Encrypted: i=1; AKwUvBw5/r4wSMJ2Cde9mfxp9KQJqRlpOhkqPhxTNSDJW2+IDATUYV/oug7MOPhpIDlMFXnXUlc=@vger.kernel.org
X-Gm-Message-State: AFuF++kBcx4sC0G1L+DV5Qrr+r8NS/EDZpqGDJ5Vqi/55eZI6Mtbw+ut
	IQJmVHUCO7jYfLHQDfyM9C6xvKNlhsn426S2F+RkcsAe+5sLfTEn2K4v
X-Gm-Gg: AYBFou2h3575HRWFDhlOqbgl0HhSR8ojT0IDYlFwPcTY/E0o/qYJdbIEglvn8QwZBpK
	IUCNe4L/KbCwa/NbsV814TT4rFG8cRoYadSr1nbsTMwetwoUfB+WigRrovZVv2bVgFDQtt6dbDk
	ct2+FgfBADPsBBCPHuVYSGv9r1CO9TKUPna4LZq/2UsBRIdam6Iyv//gC6zX+E7YXIWt3j2A774
	Pw/pFbOGKjSmdQmxWZSlTEj0vk7GcKsnb6C2xiqnWcZeNXEApqcVBEsTQ+MzQJtOfX5grIcWBSW
	lYgfgvnrmLPbsr7NvkJQ7Y/Ux1fh5CVkfgvetq97ZBPK3r1OV7OQRaH3kHY0bUtDxn2l7CYKqBV
	Bmo9PigYvWpfASkSN3i/AgWeH9y5nm90unC69ImsoFnvYY5T3W0YAw0onRkjB6eP/EtSIYh1IQH
	mQeTvvjCoyjOVEnJHpEVsKAsqQUTrGAY3qtFhtz67MJO6kDsUmPXPjCFa698IvC6XGX9Uzw+WpK
	OCUMUzZYzvFFoxVe8bswEFc9cM=
X-Received: by 2002:a17:903:19cb:b0:2dd:c0ff:e724 with SMTP id d9443c01a7336-2df7dfd60fcmr13079315ad.54.1790233363547;
        Thu, 24 Sep 2026 00:02:43 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a60c674sm21646605ad.81.2026.09.24.00.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:02:42 -0700 (PDT)
Message-ID: <c789160b6ad2e8405c6cf2d7e016fb0f6b77548f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] bpf: Scope callback arguments to their
 frame
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai
	 <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,  Nicholas Carlini	
 <npc@anthropic.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Date: Thu, 24 Sep 2026 00:02:39 -0700
In-Reply-To: <CAEf4BzY4LQ7TDCpxuVDwCzLZDr6gDYP44UwLEjqtcdRBj+bT_g@mail.gmail.com>
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
	 <DLLGYV7DI406.JRNDNAZ4S29I@gmail.com>
	 <ddb3c0eb-2a95-4af8-a9b9-a0624d38a7bc@linux.dev>
	 <CAEf4BzY4LQ7TDCpxuVDwCzLZDr6gDYP44UwLEjqtcdRBj+bT_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 15:41 -0700, Andrii Nakryiko wrote:

...

> It does seem like we miss a reference representing single frame
> lifetime which we can then use as a parent for all things that
> shouldn't survive past the current frame. There is a separate fix
> right now to invalidate dynptr created in subprog's frame. Seems like
> that one should be expressible the same way: local dynptr's parent is
> "frame lifetime" reference.
>=20
> We can even relax this "cannot spill pointers to stack into stack
> frame of the caller" error, potentially, by just turning that
> PTR_TO_STACK into SCALAR at exit from current frame and let program
> verification go, no harm.
>=20
> So for me it seems like a necessary and useful addition.

I shared some feedback about unnecessary bit mask manipulation with
Ihor off list, but overall I think that this series makes sense.
