Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00741A84
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844912; cv=none; b=lTEp8pkKcaJUEdg29YaEPxd8ODoaF435buB7f8ORASH7YFuJjl4xAgQYBgR+GlznZ1i0IT9eDtmbbgFLge8/mLMusxWVseiQ0NupssFJJ3xZekXZ0C8ta/O6GkVYImaS/YoG2gMO75x9pErQvgQAsFcsHYuKql1iSBRDfEO+9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844912; c=relaxed/simple;
	bh=ePq9OpmYUFpiffMlGcTl9k/IFFwfzPJ+1wBBYHm+O2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gy5xX/E1HdB/gb0Nq3iG3k9/nKS0VoZX0p6Mw8HfDrEJrxrdyoafPDBwCZpdsP0gnYS1WrZIApST9QKPoe6a1OTzqavQC3sL2F40nWxl8ztDmHM3SrDA9BBo41QppnXwQyUrPbCWvMymcISAmCj/umUA8tNBowDj9yLHqdrlSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDHuGzls; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDHuGzls"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso6199546a12.2
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710844909; x=1711449709; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ePq9OpmYUFpiffMlGcTl9k/IFFwfzPJ+1wBBYHm+O2E=;
        b=SDHuGzlsRItjuhYeHgfcxBExzEYENkMVuuuUp3m/iZJqJwhYtFwM78LxVihmqGra+b
         7Q2OfgObkLOTZgQ4Hss3Ji85Lycqd9ihvOYnOmazUqctnS/XNair85D6N942MhiaS+1E
         xoSn3V+gJW6QQ8huewj8B7g4m0PzCOwsFPvWNrMrsnwtH1xKnfIQlp7KZkrFQcX6NDd6
         /eCQQCrPAAsrbcspdUaWCgLApxOzL7pZj5nwA+Fc38WmT5Y0IPmwl4vAHtJy/hnbyQa4
         XJaL8GTCmSW7oofeVjCUu4GslZwJIVwpiYRGDQ6txCcJeflP5jY8WLWXFZPluxTh3BgQ
         76kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710844909; x=1711449709;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePq9OpmYUFpiffMlGcTl9k/IFFwfzPJ+1wBBYHm+O2E=;
        b=lL8ErxfaezrHpb1neemJo9btFEibN4pFuCvT/fwrVZijjZ/LyZpy/2TV7eMXQakgyY
         LJa+5q8PHE5cEjWFNNpn8o+IylOFWnwHF+a3/3H/+FibXmGoTxWSTZdadmaQBWfmGqbf
         S5n69onzSgOBYJ7ykm2eTPJjwhKT3cyMU6mkc0ifsc0HZNBQ/dvZZvuznvDplVUIvGfI
         Aub5oEn8uLba6joJdfBJ8W29Z1QT4rXRqOLEmH7/LJuVXxq9K3PMrsQ10syo7uxpAhUr
         W9eVq6okJxDSjyhobKUtMmMHPcDjTzdfFzqRjB9fz0UguR5b83m3kYuR4V/VGCtqateV
         Faug==
X-Forwarded-Encrypted: i=1; AJvYcCX7w1b+0HGGEtjh2I9Uzxxw92VfMsI2ExmoerISE+khYNrANjwHD1fVhXB9eYLaMfzf/7y5MVW56k/p6CfXHGlj8cyv
X-Gm-Message-State: AOJu0YwLp9p9fWaDf6/+qdaaHvqI6qVgEiKbZI4+01lee91qaTDMC0B5
	ykl4GH+9RVGrGAg7RLj4e2GgOemrSQ/yIZUpi9FDnvYnZszBM/Pt
X-Google-Smtp-Source: AGHT+IHyE1lgusKzflSOiQZNnXbCemrGfERMwRaWRgOZV2A2bfP+eGlgLySu/dqKLtembFYBK8y0jg==
X-Received: by 2002:a05:6402:28cf:b0:568:cdd8:cf60 with SMTP id ef15-20020a05640228cf00b00568cdd8cf60mr1844226edb.8.1710844908393;
        Tue, 19 Mar 2024 03:41:48 -0700 (PDT)
Received: from [192.168.6.255] ([5.1.5.0])
        by smtp.gmail.com with ESMTPSA id u22-20020aa7d556000000b0056b9ef8f020sm200134edr.71.2024.03.19.03.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:41:47 -0700 (PDT)
Message-ID: <2887bbf7ec08942ce15740044860aec9aa9870cd.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] libbpf: add support for BPF cookie for
 raw_tp/tp_btf programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Stanislav Fomichev <sdf@google.com>
Date: Tue, 19 Mar 2024 12:41:46 +0200
In-Reply-To: <20240318184037.3209242-5-andrii@kernel.org>
References: <20240318184037.3209242-1-andrii@kernel.org>
	 <20240318184037.3209242-5-andrii@kernel.org>
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

On Mon, 2024-03-18 at 11:40 -0700, Andrii Nakryiko wrote:
> Wire up BPF cookie passing or raw_tp and tp_btf programs, both in
> low-level and high-level APIs.
>=20
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

But I agree with Alexei regarding 'bpf_raw_tp_open' naming,
'bpf_raw_tracepoint_open_opts' is probably better.
