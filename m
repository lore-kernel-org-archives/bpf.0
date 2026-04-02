Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F5355803
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156458; cv=pass; b=tZAiTEKZyJX9I8ujsxnWQyft/eO7k63oe4ahWb1Tf1LaFmUcP2t3kZzXyzoMcWZD8thR8jfReXHiiivLd4Ft19Zw6ZXkBXspb8sGD8KGMPcMKBEbVpRQG5sIVehw2IV0qTgJtvYJkCOEZLc87Cuj0mRXJb0m3BS+R7TN3cP6VXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156458; c=relaxed/simple;
	bh=mfCXHPfyJE7rsMWxnCOZRsZO40EI9mm2n1glpcGdnBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHfegX5HRNG8qyKQ0JkZ/nZ2MLRj+TFv4SIhUUNRUD7n8xFjB5sb++mlwVYeaYPrW1ih2SiWVHT0F61bTDSVq1yIyDaSWJbo1wTNNZPlXf6hecj1Z7Up8XU2441UtmBoElrpP3dRYLeWWxWKVU8gKYkxX+q7gFZMRpeOQwhUkfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbaWmFof; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbaWmFof"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so9666905e9.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 12:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775156455; cv=none;
        d=google.com; s=arc-20240605;
        b=hHucLChbBQuLGuR0Rcbk41A6H/rBWZHXgxAXkOCE+QUOoWz8zgn1KULRa3F96dDtWd
         oDsb3I0NWPBtXASX21UrhkB1ck2AH9SvLr3aqxHirIaRwfKE9SkFKWbitWY9jVotRs8W
         e3d3DJll4c3/URETeUpsE7s08KU9kPSgt7LCwufC9Ug9cEHz7HiIlxuSYvv4Ksc/FdS6
         s8R3dM6AanO8adYrlicWFchTKvs3WxCvB7deEKbddj0IyIJR5Mi70s/MrLe5FYOGYbA6
         Y89lToFInaYTWBAsN143XWWcKOjGfXiXXwLHfMXYK8no85G5J0nKiSrNleUP6LgwBorL
         aHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IKKor9aRa/34zMLn+oytjdzLeOoao6whtFszvOwFTAI=;
        fh=nK1sKfOAOlKgx9LOXsQrEFK5C3aJSpECzQWLF+tENHY=;
        b=lPBpEUndBblQ1ARoTmfcZi0HTkAhaLMerKUPU31kMpiu5uwDxK983LVUovyQMYRnt9
         PFkUv/JL8Dj7bpT0JIn2x1DliaOqxqvThQ08ZJk4Ku2ejz1DXMgpWgcFVotcD0r5yJes
         anFnYWwvYW3xeSRVBfJGYpTc7K3fWPC60arEKWYAwmWpTQ3/kypVoh2bbsRkOf8J+KjH
         7dU24DBwkGRo1bF+UoWkEaBZYuPs8xAvMdaLU4MRPKsg4MuHYEGBnqPWuyIeSk1+o0n7
         RcbDq6vhlCl3GsYJHhGczJ6S8urD9YHnbxXDOapVkV0DEbt7jZBNzE87REtgTuq4SYgy
         Wd/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775156455; x=1775761255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKKor9aRa/34zMLn+oytjdzLeOoao6whtFszvOwFTAI=;
        b=BbaWmFofoZQ8ucgYz3KgqGVcySwicc4armjcBzETQ6DwxSFHlfJZTSR/AYX2Bd9DSw
         oxYt2a9ZtvYO028EHhwLe74yG8Y13Eyn0inE8uTdfBWHrwuZNabpRy9UZjsQRsAZOR4I
         xar13CCWx0q8rQmT6mcbeFor6AM4ojNOeDCsxe/c+IMlE42bDCJVcj6TbApb6T0adIb5
         qCgPozpdtyygsXClStl27srfjppY6v5+YcSCoiOr8k/YoBSG8DLZK4OnlaAr3HrLBQVq
         Q7icqZKmF2Gqnqmf2CQ37rNta82AiDuF8sMADe4DsPDhInmll2g+BIkMRSqE+YdUZwBv
         scjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775156455; x=1775761255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKKor9aRa/34zMLn+oytjdzLeOoao6whtFszvOwFTAI=;
        b=h04qNmiwTJ6uvofs+tVhtw3yzoc0plEnZib7mJjnkDNAVG/1HXe9bXnOAT1JVcutzY
         fUV/Fl5Cwo3pYAI0P5ZKd45BgaFZUsgUhI/zmxr8Gmb1qOemW15cqIR2LGkXeklsC9Sm
         rzAJh0pDG20MSZ3uubTO7fT5ZiHrIwrVDgdGdFN2gzIWUIWpohXyUC4ni0MG2dqLtyo+
         /ZgZuPdo75cF/5zUTs5nT/DTQeCOYmTk3TSNoZHfBNCrrlJx2FtHKXVwHvnYIlZzLZrG
         JerNKhNFj0tgE3ciS+1OOrKf613992D1awP9s+5wIuZ2qaBpZKGUBIMVs0kwt/JYv6vK
         9kdA==
X-Gm-Message-State: AOJu0YzCgwNhQyGmQjRASWoO4yuFum50meVipqFp+jqytgDTjnE5suVW
	mS+AUoR5Cy1LvWFPhQn74TpjdW3Ov3WP2s8pYhu5+GAMa+xKfCyB77X9hf++TubWH3/YrEVITTc
	yqKKtwZabJQU5ZEMdJ3d8qeTSJdLw5GY=
X-Gm-Gg: ATEYQzy+h1VU3mAeqMddV/nfGtOMBKcYlK5VrqWZ2uKrGiRgGMl3rE91dzz990Ak96B
	q5LBbfJpSVhTlecONqm582aU4HoGAx5kVqMn4ppAk8ZmkCq/Kd4qhqcey07J8kYmoax4nYFGsQK
	SBd8W9OYJ36Epz4tvNTqUV2lwGP3B/6xGcVEMM+pfLO9mLRuMckVVdOVzn08qEpcn3JHzpb7RyU
	bkhBCDcc4y/Ja2En3osW8DYJLFzlOfum2/UmhdpLheke1rn3CahQbxp0mAqJ7SW/HQUdPWTkLzL
	plCIDDyqC7gpHyO+xyN6PMzAvwaF0JudYme4rUp/7KIDPdu1PM4zcpEbZFPEBjtrPr2K8+hNmQ4
	qVTOSgonoiyU5OAFc5Ch9aX+rNg==
X-Received: by 2002:a05:600c:8b52:b0:486:f9d0:aac8 with SMTP id
 5b1f17b1804b1-4889978140bmr2225775e9.18.1775156454896; Thu, 02 Apr 2026
 12:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402184647.988132-1-a.s.protopopov@gmail.com> <20260402184647.988132-2-a.s.protopopov@gmail.com>
In-Reply-To: <20260402184647.988132-2-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 12:00:43 -0700
X-Gm-Features: AQROBzBsfT5u6zD_ReUVgNkvTRzGU4TH-JWudtwqkbpZ-zXbAn19lOD1hb82Ft8
Message-ID: <CAADnVQKUJYsPJa8HP9E-pguQeuShXfuaEs4Z_zJAVYWeEUvHBg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Do not ignore offsets for loads from insn_arrays
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiyong Yang <ksur673@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:38=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> When a pointer to PTR_TO_INSN is dereferenced it is possible to
> specify an offset inside the load instruction. This is a bug,
> because while the verifier ignores the field, JITs are not.
> So, patch the verifier to not ignore this field.

This is too terse to understand.
In 2nd patch you're saying:

   r1 =3D &map + offset1
   r1 +=3D offset2
   r1 =3D *(r1 + offset3)
   gotox r1

Here offset3 is, normally, equal to zero; but this is not guaranteed.

What is this 'offset3'? Where did it come from?
What do you mean JIT handles it?

can llvm ever generate such code?
if not, reject it early ?
