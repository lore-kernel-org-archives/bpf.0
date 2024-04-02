Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1E81AB2
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063935; cv=none; b=lHz8yagLtIY/S/gDGJOEjwPHQWw81ovDCVc0vkTkWK6q8l6zsLh7TSZ3GT3+pvmXgdSlSkg4jhXSuCA42wvVFpS7eA025Rt82oE//Pzm8YK92DW665boDEGr6q+I2foiNJ5obKqEji7d+3Umla7fH9RP7W/WZKnHeOm/jWqEsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063935; c=relaxed/simple;
	bh=lqear4WJi6bhGxtFENaGQtpNWQIfLrurF81DTqA21YY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zr93dbkc5BCMb6TLh5VcOr7AsTNWwtB+So8i9vsgDArVlvVjV7+E6gee7gITewPBqwCVO3HTVhON6CyyghigHIyqjp1J62p8LvZc+kBdRJCvgL8FFAn/2Cws7flNi1u3TSWCXONnrJ/217vX4W174fE4LKJtSpUyCEJ1Mk1V0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmYFtFMx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmYFtFMx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso682402266b.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063931; x=1712668731; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lqear4WJi6bhGxtFENaGQtpNWQIfLrurF81DTqA21YY=;
        b=bmYFtFMxemc14+ukEw8XHJuSfZaK5B6A9BLcBfe48DD3C4XeavwG6CcbHTZSzIOCHu
         4kmyG+03DU/5kxg8fEqhgKoaOnM8w2OeK413jrxyiTLm+lryXYR7jUEyXZUTj+ObBin1
         aYoNHZhRPwShMtKeEcXmPaO0XOCUrDmgw/CM1LfH1Y8u8TgSAREJk3DLsEzOegnSPMhh
         QsyRTG2KCtZx96SgedkIZqQ/wMZuiNOHs5XCFkWn8MXRNuYwDTMHaZz2MKUgzHcZz/R9
         cPm6hA7NJ8EtSK97MtaP5mlFkvVtsPrsWh/yWhyepmezEmBs/ksYfZt/u4Ino1DUXvAP
         ADRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063931; x=1712668731;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqear4WJi6bhGxtFENaGQtpNWQIfLrurF81DTqA21YY=;
        b=rpJEeqpI3e0GBIZY6paJxcBpAlBh3bF43VSOtC2KMloXQ23cWTIQXRdFIC4YIxjd2l
         x+yfiwtcDBaOfwqhS/K0ScqJCfrQvQDRvUyCXmAM0aQdLXounwNT1AZOgShSHFeeUO6Q
         DhAtitQSorPsQvz3++OzGh2hwsdym86Skx9unMqR03kvnqTUFCqktAxeE7AqVqEmcRd3
         LfmmSPLQE5MgeOLISfrssRadtHHFTnZ09nzE/LKAnDR0XB7lobQ0/iAEtSQxdK/S+AWX
         sEusPOcbQ8QHeP4pZnKBtUBZfd0WvXOrVfoZzLv7xYTJFtUtAqyJU0lOwWsMoDuI1ASH
         Sfcw==
X-Forwarded-Encrypted: i=1; AJvYcCVQIJCyGI0gxVnylAlEMwhD6/BbA91Srkboew/xActjl0APA2V0fFW7qZY7rm58CQDxDYpSSI+0wFIcZcDOexkRNKSk
X-Gm-Message-State: AOJu0YzL16ykArhO9QJ9gVjEHswt42l0RJ4n7J5lT/neIZWYy+sMzFxr
	cmHIO7ZQ9beAuH0cl4L+WJapBp54C0jsEkfQRqCG1PV4Vz9vYH3t
X-Google-Smtp-Source: AGHT+IEIyfbXM3uToy4CACi8TOi5PzaaidbEuYsi+H55AQ41jKmX+obwGMpZu93wnR65FFGbnNfm3g==
X-Received: by 2002:a17:906:48c2:b0:a4e:26dd:4d22 with SMTP id d2-20020a17090648c200b00a4e26dd4d22mr7225829ejt.11.1712063931503;
        Tue, 02 Apr 2024 06:18:51 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id bj9-20020a17090736c900b00a4e28cacbddsm6026819ejc.57.2024.04.02.06.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:18:51 -0700 (PDT)
Message-ID: <d151b8e3cdfb927d7c7509d69577e8f860ccba99.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] libbpf: Add bpf_link support for
 BPF_PROG_TYPE_SOCKMAP
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Jakub
 Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Tue, 02 Apr 2024 16:18:49 +0300
In-Reply-To: <20240326022203.656793-1-yonghong.song@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
	 <20240326022203.656793-1-yonghong.song@linux.dev>
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

On Mon, 2024-03-25 at 19:22 -0700, Yonghong Song wrote:
> Introduce a libbpf API function bpf_program__attach_sockmap()
> which allow user to get a bpf_link for their corresponding programs.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
