Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD7364049
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789201502; cv=none; b=HUaWymClaSztlp/pHqKHOFgkkNJQTZk0coqfLfz94Ftb28weXl/F/EEx8zFOiEqvAG25pRNYSdt7K0sCWJURCdc778qoj7HXbqG778CY8O68FvbPAQCRbOqwxl+7NHOI2uzVZjpz9nkQ6cBuuGTSzHtXfYr7R2hyoDhw2/OSfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789201502; c=relaxed/simple;
	bh=HePa01BSQ8UnENgYJL7VILabP+Y5JdzS304wrdimaTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lh4i6BHNkWDv4W72Zj/gV/OoqgDXRgPMBttx6EaOzMIo8dCgd0BToOfGIVZWoJJ2V1v6Y5SyfKY0bSXy0aolQdFqujeboerfpEoiKaeYB+eywkV4NH5EFFEX5F9XRNLBLktHjFcipCD/LDrWMhPh7RwKUUc1y2/npZdnRF3UYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLGNlXVG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioVs3Y+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLGNlXVG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioVs3Y+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789201499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HePa01BSQ8UnENgYJL7VILabP+Y5JdzS304wrdimaTY=;
	b=hLGNlXVGQAdzLb6mMPiuYXCpd+R8U4+pW2fp2Oe8xrgCjwMC3rP3ZFnKiof/6Hy/CuV4U0
	5KTDibaBWtdNwhGR9viLsCqjbzjn7yuvRGaLZEBuEziCaiVaZ31LRV3M2egTmqdKOCfN1p
	DVfZZW+HJ+5PMXtciP+qr7qJhDlVQN8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-blcxpeG0O1KPpeM2JxNxkA-1; Sat, 12 Sep 2026 04:24:54 -0400
X-MC-Unique: blcxpeG0O1KPpeM2JxNxkA-1
X-Mimecast-MFC-AGG-ID: blcxpeG0O1KPpeM2JxNxkA_1789201493
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cced8309bso14829235e9.3
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789201493; x=1789806293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HePa01BSQ8UnENgYJL7VILabP+Y5JdzS304wrdimaTY=;
        b=ioVs3Y+XCC+Byvzir4hoXBWUBihBXvhWzkkUAy8y1n980pODPmdq7HkiLdkjfJXuZp
         5Dw3SXA5IiJK+l/g0piqVITaRv3bRC4EbROcDfpiv5Sq8GN5NNJhFjhYqAsKBMm06yJj
         8jsHWZyPZWYSVUdFMZFJ4bSyHOywF7iyaaJnLcp961EEk4ZI8i7A99f4FaC6/J2aXoir
         dt0APTKMFiaNNNML8Qw5zdi79j0QgEY3d6wxvgA6tFeQmVOBpVmDcXyCTyvFl3HLp+U4
         4IK7iULa8qFHYwcq1gkAYL8fak1YuFW7255WEsQDrpdDWDcXBWH8C/uf2q09bB0zkZSe
         9tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789201493; x=1789806293;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HePa01BSQ8UnENgYJL7VILabP+Y5JdzS304wrdimaTY=;
        b=FS3gCKtcxbJW/laJe/sDfHdO2SDmZwqjqv1VLezhkXyv+ZtWu3o0/vUD3XdjMfwJNo
         cukG5QDGeSFzrLW+ex6jun93dYoyyRCMN3q1y/CYBEhH0tlvPIqkkFhlrXCDDXYWzQtL
         uCh2JUXhPKZ3Zn46dsnE8i9viY6HQvmE81Q3Cw8b41wB9r+AedQblA+VRn6F2Y9R1owG
         jJTjwpDJqYFf3lK2ElvLnXPCgpnKOn5ypph8UVCWHvQnaXjizON0yIH3LarjBKMpzDro
         Zfs1KjgHj1D9m6DGnljOzUOY6v7z3qIGmaiy6Zxy6jrqGjo/C+StVIAyenIHa/s5aDU2
         0mHw==
X-Forwarded-Encrypted: i=1; AKwUvBwk26LQ5pXwwNDg9Ap3kq6w8kQ159IoXczZfHY6jx1iw9lS699n2Gt944cLNc6JoaGzqY8=@vger.kernel.org
X-Gm-Message-State: AFuF++lSMAWDSRA+6huAxm0qBC9onddOzQ/Fd5CbAvyx3zDngFgGLhrh
	LOKjxwWbXnm3CeNLJfz3x4hiCOsaA+zmJ+JWrJYHHv/V2PnsvlTtNqoYWR2wZkCGYvWiKNBjLlo
	8bPsz8eFPtvKd9OASqR+OzizWJ+vKDMc5KHm4TpwFxSQ/rrgkLx6ucg==
X-Gm-Gg: AYBFou0uL5pytSgJojApTUeg1/gawxCKF8ERv/QvLVRK+gNYUab0aP5ecw+mM7Ng8OM
	/vtkVHleBQdPL6cr7STONwcejESo/RGWf9y322+e2bBdh5lOJirkSmMkAEhA4sDLHX8esmqu8ac
	jH8w9QMXRWQIP/bvioWeQn5DF73qtAeMBMsSIsWi6m3qerqAzN4ZJgtvlkIFFJ857D3xtZlMEG+
	ETqlYs+Nk8WepZ67qPOwG+XiNaQcU/jRGGmvbUESgOFoVFC497YUCCOtxO02GXZ49fcxyMx5Qsf
	hy/rULXB6RSevPfO7inJqJpu4hq678I1Kq4CSDLAG6ZwTjhz4kqxPJqPEGGf4QXO+ERor2YjytB
	6CCzoGKqWDtsNDUDKhHUN6FXS
X-Received: by 2002:a05:600c:4743:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49e619bbccfmr86068095e9.20.1789201493215;
        Sat, 12 Sep 2026 01:24:53 -0700 (PDT)
X-Received: by 2002:a05:600c:4743:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49e619bbccfmr86067825e9.20.1789201492882;
        Sat, 12 Sep 2026 01:24:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm201614725e9.14.2026.09.12.01.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:24:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 596029B9A94; Sat, 12 Sep 2026 10:24:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah
 Khan <shuah@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Adopt
 bpf_program__add_flags() helper
In-Reply-To: <CAEf4BzbToKWpKwkYNovhOrB-ZvXXyMr71BBaTQN9DsM7KrFzPQ@mail.gmail.com>
References: <20260910183222.307208-1-toke@redhat.com>
 <20260910183222.307208-3-toke@redhat.com>
 <0e8f9a9c-6295-49ad-b29b-84613dfbfd65@linux.dev> <871pb0dshe.fsf@toke.dk>
 <CAEf4BzbToKWpKwkYNovhOrB-ZvXXyMr71BBaTQN9DsM7KrFzPQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 12 Sep 2026 10:24:51 +0200
Message-ID: <87bja2dgh8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Sep 11, 2026 at 2:53=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Jiayuan Chen <jiayuan.chen@linux.dev> writes:
>>
>> > On 9/11/26 2:32 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> Adopt the newly added bpf_program__add_flags() helper everywhere the
>> >> selftests non-destructively modifies program flags (which turns out to
>> >> be every use of bpf_program__set_flags() in the tests).
>> >>
>> >> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >
>> >
>> > Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> >
>> >
>> > =E2=80=8CAI pays excessive attention to wording.
>> >
>> > maybe just delete whole parenthetical notes=E2=80=8C "(which turns out=
 ...)"
>>
>> Well, the two instances the bot is complaining about turns out to have
>> been added after I wrote that commit message; I didn't re-run the 'git
>> grep' after rebasing for v2, so I didn't notice this.
>>
>> I'm not sure if those two are candidates for conversion as well, TBH. I
>> can respin with your suggested change to the commit message, or just
>> convert those two as well. Or just leave it as-is, I suppose. What do
>> the maintainers think? :)
>>
>
> let's replace, you'll need another revision anyways, thanks!

ACK, will do :)

-Toke

