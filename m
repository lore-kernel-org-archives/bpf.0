Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2C4A35
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140354; cv=none; b=fwb/xNw4N8wkC/71CrdpkgdA8OuvBytvrOlkN5+iEc+nUPX8uzUgtOyzPzRnVf8ouCWzWs61N1vD9/oOhH1DH/8kuasX/uxc434hCF7sguWNDwO0JPfkeItv4O18lNQjWlkBW5bkbr145cRreu03v6fiCECRkvQEX4iSP3cKI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140354; c=relaxed/simple;
	bh=zz2BOXGQVwZ7z9v5NRwn0D9fvME6fyJbFS2LGYZGRXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=MtmuNywGgyjs7HyBIgOPCFWZyE/xtUnoa+z+uPsm2zfynaKNNX6lUirGxs2j/GXnuL2F7aC6osXzanlwaGxr0NybekoSAtDTX386TJjFqE3AmP+JBmFawxd8Gljf9xMyoptpIU53tMYP85LVvdYQw2LCupaRTVkJy034SDH75w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=EI8gyQPJ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="EI8gyQPJ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8946e32e534so69128546d6.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770140352; x=1770745152; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10Uj/i001J9jcXRPzi+AGMxqhyNWLDxiLBcVfHHsMDk=;
        b=EI8gyQPJ7IVAfuhGnq5eGKtu3Utsj8mafOimh0KykxezpwnkqHvE8yujewb+25AL0v
         m9oPLbxCGf6/+e5C51LnB8R2wHwJYmPrQWBOm0L0dlMzGESEfjoY8KFV0LLvcKz6ug9c
         sTiH7QWzvR8ZKUiye5m8Bv1E9eiOnjOd8OTeBCvZekmpxxcM/DMtIcqFxkMPo61v8cMA
         Pw9BPZzcnF66+CdWWYK907RQwwYN2NBOCfUFhVWsCt+JDzST0Ve4J8VQUf5qOUICn4mf
         Zjrrj1DEh1wqKVy9gBeDgVDGdnes+rzmCabXdLNQQ9joiJwsRGCcw4l+l+YkVVAb5wUH
         MupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140352; x=1770745152;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10Uj/i001J9jcXRPzi+AGMxqhyNWLDxiLBcVfHHsMDk=;
        b=b4yBqcNM0MTbFcCoEVoTmUTaO62y4+SfI/KykYa6P5UrkWtYwM63HueowiGCcEhHMa
         Ag6t8tluj78vCMoFYkf9fVJB6INRJdUSM4GFY2DuiPEC3v8p+YX45L0t86v78jtEI1RD
         BUPipFaR36LhB5My2xE7uQq34SAIPWQGZdJRJ0ep5EajKjNY8uCHdEe5NszX+omRKlPc
         QyOp5X2ACE7kf0nb2LuhvjZ7MSG2iFD+ce6nT7TMln24jWeesa7s3Tj3V/yzNG5FqJeY
         eqfbzBn1RC7Hw+tahsLcXpdO3KctabKFsfhoZQosMTFq84tmzeQOnmORnjsyMhKawyR1
         eOoA==
X-Gm-Message-State: AOJu0YxPLaQwbmyGUf/XMv9pLEatlQ1eIwTTJLQKC8lM2bLXZdKk3p8r
	41ivffGgsz0ef5ldDOMP2AG4MzMsHOgQU1oKmFH/Aecimm0D3mD2Fbdzq+LnexxaKWs=
X-Gm-Gg: AZuq6aJSF0PkYX6JgOu261/1e6qGPObjl7daxQHdPntQKcl850eLx9q1aGvh0/v1Wmf
	gyosTwo7svJ+UBlmYQn/vKd05awsgvp4PYje/AFzR2GkuGTn1aKU6co8fDvoHTS2v5E/ktK6Gv+
	n8w+z5zRnNEt1gSCEnl+9EmF2o2M784brZnLUG5WSVHEhDZBbREcZU5g8/wm1pQpD/CvOIiy42z
	eY+A7iybh5EKvHpIuh5+BTe6doL74pNcH0TKOBAJ6qzN8O6i1AlxjI9gTeAq3r0g3/Xq4Qpqx6e
	nRBxlImmIU0/euf+GKx87UL1U/Ujtxbl4MckwTu18RoAGa0xQ0gZPWyEtB1NbEvqjZSs7g2murh
	7GYugIXQDYzr+Isv0aVoxIbedtZGrwb2wEXdwydzGRgLyisUXzCfJ7EAnqqiqSFCZt606Ygd4cx
	5sX9RXOZSDQSw=
X-Received: by 2002:a05:6214:5092:b0:882:79dc:71a with SMTP id 6a1803df08f44-895221afd33mr3020186d6.46.1770140351793;
        Tue, 03 Feb 2026 09:39:11 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521cf76d7sm1892396d6.27.2026.02.03.09.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 09:39:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 12:39:10 -0500
Message-Id: <DG5IDUP6WWR5.KXIF3NUVPUM3@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard" <eddyz87@gmail.com>, "Martin KaFai Lau"
 <martin.lau@kernel.org>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Emil Tsalapatis" <etsal@meta.com>
Subject: Re: [PATCH 1/4] bpf: Add bpf_stream_print_stack stack dumping kfunc
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260202193311.446717-1-emil@etsalapatis.com>
 <20260202193311.446717-2-emil@etsalapatis.com>
 <CAADnVQJLE_vpO48Mzh5btkPuvFYH3EFsvBzH6+m1EuGs1p-48g@mail.gmail.com>
In-Reply-To: <CAADnVQJLE_vpO48Mzh5btkPuvFYH3EFsvBzH6+m1EuGs1p-48g@mail.gmail.com>

On Tue Feb 3, 2026 at 12:30 PM EST, Alexei Starovoitov wrote:
> On Mon, Feb 2, 2026 at 11:33=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
>>
>> From: Emil Tsalapatis <etsal@meta.com>
>>
>> Add a new kfunc called bpf_stream_print_stack to be used by programs
>> that need to print out their current BPF stack. The kfunc is essentially
>> a wrapper around the existing bpf_stream_dump_stack functionality used
>> to generate stack traces for error events like may_goto violations and
>> BPF-side arena page faults.
>>
>> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
>
> Pls respin, since it fails check:
>
> Commit 69310da6192e ("bpf: Add bpf_stream_print_stack stack dumping kfunc=
")
>     author Signed-off-by missing
>     author email:    etsal@meta.com
>     committer email: ast@kernel.org
>     Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Author: must be the same as SOB:

Will do, sorry about that. I will also update the Signed-off-by for consist=
ency.

>
> pw-bot: cr

