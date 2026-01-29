Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FF621ABB9
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711777; cv=none; b=t0eFUSGSj8D6uHeQfEdmAivghTDUBAW1yO7IsgIVCkuYxPxFv61SVsUOAhzsF4gEyDGiU/3awL8OpXZx+aEQmcQLaV1kP5BJDLxfdiSpyWVmxUKeLWcqpTOdJ8xlMh6HiYdXbgm8gkKe6PxvjZXBNE4G6IcMqll2aAZ754qGIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711777; c=relaxed/simple;
	bh=pTxgR2AZDMQU5sv2e9lUe7PIAQqq+1wcwS1jF6mHTlM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pdoeu395qL+aiH4feUIqzWOGdkjVy8oCrRR/cZyCnPnDM2wwCrHzwIs5DqUV1DZ1NqgPqWbOMAYxrtcgqLV6/bpjR4iUm814ChyLT2w99tXPWdbNX60iWMC1qmp3GjymUh3u0zXL82yvbu37VLGp1wOwZSDiuoWTM1GDnt1+1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2/Bckxl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2/Bckxl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7786d7895so9542205ad.1
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769711776; x=1770316576; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eMuKGQSJII2vcPwpHadcYi1Mi4lXyW0o8gzKAZXa/gs=;
        b=Q2/BckxlQUIxySIrEuTr7396L/hEkO1EktIazmZqQow3ka7AmnkbSPdsmG85mMmoR5
         ZnoBzLNVh8E41DHR3YctfFqWPh705wZ9WGfHgfLo9+afmKak1X/DfWH5Z//9it2mQ6zo
         TSNmysXxqqDiPQQ18D0Jq3CiA2+ir2yZHFv/PMcFav9qkqBTJ8fOKi9j6005Jf94SVDL
         RDSHRJO1b575YiiR7hyI/UZBh0UTCVxBVHiB3VYENvIjQ6XGce4gJfBt5kJNo1nZK8jb
         swzw7KQzdH899k3iPNwOPCEtqhT+h5l2zIwDziqErDSFsWlEHz1i65AcVi6IoLkWtHYZ
         0n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769711776; x=1770316576;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMuKGQSJII2vcPwpHadcYi1Mi4lXyW0o8gzKAZXa/gs=;
        b=uciC6BzGIKIJyh3SXJp3CoBCZiPpr6TTX7IVe3UxOqCMyprI8eQRd0kM3f7budgqBv
         kXQKrUG+uw9pxBMUNyigzNumWsV6v1aub1+vGY/oQMykfnRwq0gb7kNlr8sZ4oaubcav
         gA+YB3EvJgNFWM+c8AztZ9nWLqkfT78hY4Y7zE3tTAN3aS2loTusSON9daYxr8buoc1s
         fVvGvAdgT9aQ2piWNR/RIHgAfABrR7tRceHST4jA6CYJjFlm1mMUrSeDRIh8nW/Cmuci
         +iMmSS9XTGebnagpdYqCjV2RSc5/VfDATa9SI5w1wyR9yPo8cv0G8I5UBBqc8G9qCGM7
         CISw==
X-Forwarded-Encrypted: i=1; AJvYcCVn96u2ApUqE/TUAXbChMG3Zg13pcQFkoWawHXxLej7+MUd7PAoXMZ+J05G2yQFKJRGJAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/uPl1opTgwwdN3Vnt3yERefx+EeJPRpPkl5HPEVeSW7Fz5D7
	jsxktvpLkGr7eAiuRBMmlUhI9htX5SQTu5FlaCB28EjjL1ZPTIJJux8g
X-Gm-Gg: AZuq6aInPPj77WjIAC/UhJKpDHzGlSNItFP8jjDyNX1BprkFbsda28pyo1N0vIPWuyu
	bhJSdPV5g9wVLcH8EybBF/iKXNzNyd+JW9xvzdX4p78V7fsTKGNCGRMhUPNlV/KM+scGg+jP7p5
	bAS5OrQQ9Zh0LRMQ6Y4OarxbH5qHeBgPKohl3zXm5diM4SITddD9tqeR5aBxp+3Ib0ru7kJMBNJ
	tPXIG13WbR+1YRD4Syzwi6qISMxqE91MR8EYLBJ/YJPorKi0Owpvrjss77mR3KfJ3UGTV839kz3
	IEHbd1idM0DsredubCTkymOsuFIIX/BACAhZlSTudN82PoDrpYI40wNSF5Uwwb5mYcQ/Gj2dIdw
	/1WH1ACkm4squv4XzjiZIYkAOEwOTjBCr6k3Ndob3ZB28lMOcBm7Z4OljucMplbX/ViVNKpJaI9
	b09/5ihc5yEiMkJdgn389Tn9P3JcjCslLGHCNcj+EK
X-Received: by 2002:a17:903:2342:b0:295:5668:2f27 with SMTP id d9443c01a7336-2a8d959006bmr843775ad.9.1769711775669;
        Thu, 29 Jan 2026 10:36:15 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9e25sm57383085ad.80.2026.01.29.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:36:15 -0800 (PST)
Message-ID: <073acdfedcc2181f0eb343cb16efcd4c244cd1ce.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce struct bpf_map_desc in
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, ameryhung@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 29 Jan 2026 10:36:12 -0800
In-Reply-To: <20260129-verif_special_fields-v1-1-d310b7f146c8@meta.com>
References: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com>
	 <20260129-verif_special_fields-v1-1-d310b7f146c8@meta.com>
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
> Introduce struct bpf_map_desc to hold bpf_map pointer and map uid. Use
> this struct in both bpf_call_arg_meta and bpf_kfunc_call_arg_meta
> instead of having different representations:
>  - bpf_call_arg_meta had separate map_ptr and map_uid fields
>  - bpf_kfunc_call_arg_meta had an anonymous inline struct
>=20
> This unifies the map fields layout across both metadata structures,
> making the code more consistent and preparing for further refactoring of
> map field pointer validation.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
