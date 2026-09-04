Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE063AFD19
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 04:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497126; cv=pass; b=MQC9QSqiJbRq1BA9tsg7id+nz+PSZAu7QW2e1lzQ37Lv2MST0Sik6dHg+uAzofhj65psTOQIqVg0AX73gOx82o+cVJPKv9JOi1JsZ2FrsHH6bpPSx9nKZZhsNm5QcsFOqfzpXS4XwYFo+niRRKADQG+2pwf0QPO1eTWtxXqj1WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497126; c=relaxed/simple;
	bh=E3k++/Y7hon97B89/Wv1QdpQa/DXB2XjjW8GX1yrf5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc2sjOdTpueoNko2hVXdjYv6ooBt31nOim//YlVwEmE7XMGbmho2pwXZvGLRyru56vL5GjF6kD2CmqzJJHIxoQRj2M1hbM+0p3qlNLRHt26M4QYWanmfixtKnli/tcBmKBQU1HfMMwUptaPGp+09duM55wBAulMd68X8cuFtKRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr1rWIUH; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr1rWIUH"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso670820a12.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 21:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788497125; cv=none;
        d=google.com; s=arc-20260327;
        b=XBPQdzRqSMh786R4zAF0dOofGME/dKrTmaeiZV07JkCiuBhvKSda4IAuQWUallt+n4
         O7uXdpPgnFEFTKLtb03sSeI4FE3ktUQ4B3D6S6bUcqJq0cYsjISblGrJhI9PG6pvOLjD
         W2wIj60GdO4ESYKYx8NCEBUSzA3VkZl9BLa+jjO4vZ0IiuSkyBgtSprfAb+ahzH2y4gr
         Ty7zQlxfQvPxu/F0lK2fVb7ZNCq16SH++nTLjFewCy3io48TRhs84G+T+QisMjYe2Rxe
         peNz4Ko5i97qg+r7j20gVFohdYOi1nx2zmlV265GAY3VsrMcjcCVfhSRxHEctSi51rIa
         NzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E3k++/Y7hon97B89/Wv1QdpQa/DXB2XjjW8GX1yrf5o=;
        fh=wDvGHEHgzRuAYklTKgWuHHhs4kgTUxuOkw6vjoAGSsQ=;
        b=SOAn+D0Xzh4/Pfqh6NSx+PEx8QUdjVy3T+h0pmfZ9tKRAUWFxXoPMNclERdBHefwn2
         5XlIbuEvys0WEixV9s12qic5eJDL8sFdEAsrI/yDHqspHqu3NhfaSU01x3zMHwJkfr7N
         te+f9rxB+aywtLURC8o/KCQIzTojb77LBs8p65rqcc4PNeXhVBcGzSFsJdJwQmPkuh8j
         GmarKscahxHQulT1dCUzPuMGan0sa0Wi8DUu9YS+RKUfZUSvlOxx3XHfSKAObIfYuGt+
         PVlk/AFdvpfTXXQJEM695Eswy1EOvAvkyp+p0MD1XwG99ajW1U/hPCBAbojKZTkLJ5LL
         5ySg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788497125; x=1789101925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E3k++/Y7hon97B89/Wv1QdpQa/DXB2XjjW8GX1yrf5o=;
        b=Fr1rWIUHdDVmJsyiTa0VPyczQDI95lz/RQh7qsA5WLVaautJGJuzLLVhjhe4mMwSvX
         de+bNdsgE5c795kns7Ytngy2iliZIiloRk/dUKtRrHhFLNyksB1Nmz+Ec/i5ie3ZRQM9
         +Xqtc3FV0ZLMDPhDcw9DNHZxmi7NLQRcQfV/7nJlHlEcp5IO7Z0LlbsKMKp+Z+lETElg
         zfluXCH5kHbuLGw0KMsl4HSIWZKcmySfKI1TPLuiJcRmyLrZ7GRpPl6Rs8hFcnNGA5wY
         BGVjtuM8e3I9JW+NefZpzXU0XVYxEhgqPCDemXiHM+uurGQjL7tjFp2aGhUMTMZC9+/p
         WwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788497125; x=1789101925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3k++/Y7hon97B89/Wv1QdpQa/DXB2XjjW8GX1yrf5o=;
        b=TgJVIv4Rg09n/KlKoLKnYr/AshkGUhA1mJ00ZNh+cB8N5R5LtaN1ODVhuaVCUVFCXD
         Ot9osNwRSe3oec5mpk+SXTaQSLXXP159WT+vIJMqfO2E1lkgfJTPsnEtSnieXSOErYU2
         99EcuGb9lUlMG6+6k+5X51qDE2dWMbdtRtd8d4DSv354bZcwoiP87g9h4hTfAvastZCZ
         mwBvYsuY4sY0KyUqWDXT5E3s2EzwH+AkapGRPjwajxHb11QQduEuqxesasWOLXTNawyr
         CkleH0EE4IoB3vx2WDAdbi3QXtrDw269GOw169RzwYnWRvih/BKfDxUu43eIZ0nTkYs5
         sFiw==
X-Gm-Message-State: AFuF++keudmyl7v1Nras5hvCpHMTtFH5VuABKeP52EOh3uBLPCpxQ8fB
	hiY8/XD7QPYkGnb4cTjbRtL2W0v0/M0wYb13Vf3wzbfp3wmxE4ZFyzG0OyTgG94/m30URXsjPnM
	oCeJaCctsO76KdmX1KZbbcfhH8UCuFpY=
X-Gm-Gg: AYBFou3EmKWVUli8TodB13WYYQxRL0jzmQqqOfJsqPsYhifxUi0L0XA1X6EluqlDUWc
	19H6sv56pkWdkMkcmt97kZ4cbWHSLw3ciD/jyeqIoemT5HFN/OkrvNZUYz9LRfd40sP4vasOnMv
	YX7nUVbkmDODe7TCTqNEm6KRN8vn+zEM0MMiIph47uz+H70Z3PGtllXwrZtf73pJ5MzG5I/A1zD
	cyLoUIDewEoGUUH4d6faodQ8U2MH9HiWH6g8WcAKx6pQ57PLUmDsoEVrMnNrjf8lNhIvabESxST
	sXFZ6xJOiicELDqHHRikwSRPA0O8XbzSePBLQ715UTiiaZ3X9q1hlWmn1mxFYlEGMk2dGazwUM4
	+8GV/Or3a0Ulrs00SP7cfIwMNdvVTJdCyjahiZtEDeg==
X-Received: by 2002:a05:6a20:d502:b0:3d3:aec2:4dca with SMTP id
 adf61e73a8af0-3da3a0fd024mr5688749637.22.1788497124584; Thu, 03 Sep 2026
 21:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902204439.287888-1-maghasi@disroot.org> <20260903082734.623904-1-maghasi@disroot.org>
In-Reply-To: <20260903082734.623904-1-maghasi@disroot.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Sep 2026 21:45:12 -0700
X-Gm-Features: AcwNN1VHd7vpTcPc80LAtePf6bHNLoVU720IXyLkDoErsUGPcWQJAD9-SH_6r8Q
Message-ID: <CAADnVQLX5bjLTPm8Ch0wNuojHrKw6R5iJDBRsMJwrWMSupVwew@mail.gmail.com>
Subject: Re: [PATCH v3] bpf: Fix u32 overflow issue in map batch operations
To: Masoud Aghasi <maghasi@disroot.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 1:28=E2=80=AFAM Masoud Aghasi <maghasi@disroot.org> =
wrote:
>
> Several map batch operation implementations such as
> generic_map_lookup_batch() use calculations in the form of
> "values + cp * map->value_size" to compute the desired userspace memory
> address for reading or writing. This can overflow the u32 type
> (the result of "cp * map->value_size") when the map size exceeds 4GB.
>
> generic_map_lookup_batch() may corrupt values for some keys in
> userspace memory, and in some cases it mismatches values for some keys
> while still reporting success.

without selftest I have to assume that this is AI hallucination.

pw-bot: cr
