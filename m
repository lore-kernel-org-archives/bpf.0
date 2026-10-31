Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793430442;
	b=lKCIzoLAD1IJFS59tX5iDPdNLnUhZTj9e44A/muYKKzifkvKR9Vy2DChnZXKF03qEWsb
	 GEIEgtxXnAwwhlMLXMGVxcnIlvFOsGitfX0qfW7hXhxi5QaC0LO+nqJUrJfHZQVlR7Yxy
	 Jj/JYvCLlt3gfvVoSjz0j7NR9NAvM9YgRyvYIhR1fP0+VilR6+2+ugSlFh4RkI8ybxVfv
	 4galpvBnNfLDbMEEyAwcA95qmQlJU5JBb0KJI3XDYfiXena+L0QddF4/yk2Mkzyn6Xgce
	 agnNVChIZtft/obcExR5U2jpqVMMqKts+aSQ1pc0uD3xGOG7GdyjVZv7lq9LDFKe4Ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
	b=oIOoT2Gtt5dq3dd4p6S8t30HGZiFXWL4QJ0CcH/VKb479yAGrMrhISdnAJ+eHhC/DSJX
	 q0FOMff1cREBnq3b6t0q1q3SAZOpNSEXnauzb54qn9705T6pgNxDyiMuOEQ1KXuxUDu4b
	 1GWGJ0FXCb98qHKp+tXqYlEVnXSVYJnK+iIPm1HztZdk2EbDq063Hmitd/UQPkZDMXCxk
	 bC33MQJojXftKL9FL8mOihH57PIZJHsrgsBi/XN+OwaY7GRUX+fhNZE96Ao0/Uuu1kHLZ
	 mSIivSXP2R4799T/9AxRxR464h7odaoxdvba9ubURqvPh5L6T7uisq4RCou2v40sR1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mUC/ZNRG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6C606A31E
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 07:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76E6C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mUC/ZNRG
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be416e603cso1013262e87.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 00:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793430441; cv=none;
        d=google.com; s=arc-20260327;
        b=XoniS2hHjnmbrS2HrdF6Yr9anfPc7ws30vfLYLStvCrMAHhMvgKMWtDXl5qrUPWyaf
         u3YlScRYLtclzX6eeNTllXn6CMTzYBjIvFN9dRtZJe218tb2K3lFFz8rGEa425+SDHD/
         Qnjz9VB0IP6QJLtxULSCAzMW/59yE+k8w7NnltZowGF1GcOKzxJrXMI4vijUfjUUMHSW
         dk1fW71cWaXDWECW8xb1HwrfUp2kFFKg9RnPpIT4J3fBJVaIAxXFJlUg+hsgsJP0uo9z
         o/7EBPvvLkNn1WQRDtWjzRo0bvNvvgLzTuzJH2LJyxqMtQbvHudbC+6kF/B35r320mfu
         7f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
        fh=WGWjWZoOxV7TgGS2edlD4Eyh/co5FN5m640+q9VkGuw=;
        b=Ya0s5A8h7qiiJuZqB2t0f7vd4k4kfCe31eHdpGZT1lMq7j5+lic4/k1ngQ8GUhnuHj
         z6v7XcAJOfdfy0qU7UjjMFoVO2T8V0sb11cZjxKBJ0cZ4mz6kAUPsYXw06riTRQFJD33
         nIXoZnKn9jfggbGEbjnrCLiK8FxbMp0hdi2TbPKdw13CRl2VDy+QcgR1G918DU6oou3c
         lcWEUwrlHeCRImab25KV6pBwTCXTgAkOVNW+seKMs+tNjE9VajPlT0RFnL6jt1eYHYGH
         /MDVo6cCaEOPUeoV2aHzBWpZb239zYEw79WSLc20KZhRo5xqP+OCFL5hbpCkCt2KEfHm
         M8NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793430441; x=1794035241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
        b=mUC/ZNRGxHvMseEtdOEJmWVOL8SEcrnIyl+LO+rOY+pCywr6fgr+KDK2CIyE8lIsuz
         yQ1Np9gk8b8jKxaAfhEqP2bROPaNrhie/nknplsY5izO+GtjCMaTsnSI4wdjbSEFbJ2A
         v1V+FQHw3oxr+3yAX12D/DT/sUQ9qKE4G+uooZlPDxfs/u+oPXzxb9TRBVUps5TvUVPa
         1zS0+tldYvPBypmRuTh5upf+mvaRVO/3IMi4ZTkryxZGkOjq3yCeaf6+X5a4ylvGgOOQ
         lKmC7vQgmHoRcJHX40cgu4raIzql04uewGD2ZHWOa8sSFvfRTprZZlnZaInECB72XWYU
         O0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793430441; x=1794035241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
        b=fBATnq4ipNUnt8MFdoajhMdrSEM6gi8ZtiK4slWjldG0qlllzI2Anl0GBO0eYSn32G
         tREahV5u3vyv3FlteA6fGEkv92uVsCa+Jt8WGQmGe9PW+xM+45Nn+fkPxXFq8gx02w6s
         S34yku9sigjogY3nL+6FQNHiL5BqopSArNT4fQuyhdxhZw4/peAvSsyWuCcCy6PWtuPV
         sB6z16mkHDl58hY/XwF1Jk17RO9PoWbG71398havkuEEC5OYpQmmAxJgx9cF1SWd9GSM
         lVaY6tmbZrBwOUbkL5A+P7LjJOXxKo+gSMG7HzY6YZOMtHrMTyOjX9ZZYf+1pp+JEIkg
         VXFw==
X-Forwarded-Encrypted: i=1; AKwUvBy1k6zz8bOYhP1ydBfgMActYaHKceIEs1w+RRkyEzDBwUjb/AALui14kS6Vt/bZEMJuq3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBnDzj/RRyF4QRlXEkHdePmWUNHr1o4S+Z3rSCbQjwmkfHOEaY
	LhdwRYsy/mgNqaMeTrzg5u20cP7rXA4ylPfDwlDRivYWK/pOe/RfDpWjz6PgUEOGuO8R7CxZBBA
	MapA/zkH8v6Ba0ePc/wEbzY5iiRNw0lg=
X-Gm-Gg: AYBFou0re2+j6OavT0SG5gWZRNeRzVcDkuNXRKW7Gou3/VdO8ejZSDGis/LNrNnqh/3
	hgCWRfINnnGBKuQCfCc7cBX28qTkLX2cywAtSnEMybvBMZS89CE0GcLQD1FQi4zZccXyxkW9mxC
	+0KgHbisE9gb8LZO+I1CT85FgQoLJNCQLa8q8EewklHOkc8ii+7NX/KT17WM01WIFL7XxRZ/HCg
	unzUYDLoNeOLmLnY24lTzOyxpeXiyDOS25/8qIF42mabu3P/XRixa+LKD1pVaogXmn+ugguA8jK
	LPsxS5/1Ijebhl4eHA6NXGqVlIaJru0sj3ivgUGGmq8mlEfxhe18QAAKB3vLWkb6WbBEPyMt5xU
	Grtvoq4TX9Iz95bW+yGhHGdP+u8EjcP1eqjGc8frHvMxXVwFI3ql8HmCn1tC2rJBm0och4M5kBK
	b+6yIbv99E34zXPgRfCHxjaUV81lpDIACDoaYEX4vLvrang9f+8nX43YDpjaKiBW8q7SkwaWigj
	3O4Ao+ZZYY=
X-Received: by 2002:a05:6512:1393:b0:5bf:cfc6:edb2 with SMTP id
 2adb3069b0e04-5bfd951d540mr1610800e87.1.1793430440393; Sat, 31 Oct 2026
 00:07:20 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com>
 <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
 <20261030084017.16202-1-testwrzwrz@gmail.com> <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
 <20261030094633.27910-1-testwrzwrz@gmail.com> <auSF/bDmOW0Y7T4D@boxer>
In-Reply-To: <auSF/bDmOW0Y7T4D@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 31 Oct 2026 15:06:42 +0800
X-Gm-Features: AclHuK-0fsS0Xg_Rkxrpa9yorygM-pSbQySVfqzZJZ8DT6_AjEHZacGUrZv2dts
Message-ID: <CAL+tcoC+bwVdf2N+Ku92+ifPOQMvak8KMYM9RvMpv6hkdpMt2w@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Rongzheng Wang <testwrzwrz@gmail.com>, netdev@vger.kernel.org, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 7:57=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Oct 30, 2026 at 05:46:33PM +0800, Rongzheng Wang wrote:
> > Hi Jason,
> >
> > Makes sense, thanks. I'll wait for their feedback on the selftest patch
> > before sending v5, and fold it in together with the rest.
>
> Can you stop removing all the previous conversations and rather reply
> inline to related paragraphs?
>
> I don't think v5 is necessary. And as Jason said you received 3 review/ac=
k
> tags and none of them got included in v4.

Given it's his first contribution, I suggest sending a v5 with our
tags and that change (removing else), so you don't need to re-add the
tags one by one :) And then Jakub can easily pick it up with auto
tagging.

Thanks,
Jason

>
> >
> > Thanks,
> > Rongzheng
