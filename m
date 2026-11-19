Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795117043;
	b=kEUpACiFaGyJCHDiIE2ABujOdiMUkoNTqQoQJMqGj6R2Bn+jzMk0lC30t3FZcAHgz4H5
	 B3sDQR/gR4w1o0zoA7ZJt6fkKnKVXVA9Newy24OehP4EqH7fZeBCGbEu7YFzCPS8jAo9a
	 kJZSLetVjbJMdaCnJgecsS1z3vrms9CAFG5tu2/b6dw4rOxlaIlzurSZfK/U+8s/bf6qr
	 DTFWIFJaHRfjFxkpf9rPzIieduwDA9ke+bGht6aOWRngr1GidDvsWd2xfGlVpKSs0F1+d
	 v/KtznZ2SKopR0JvonPg5qvKmGDq/9tQraG1k2TyiVejDc8+BOb7/RLrP3Tdm2lnDUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ki7N7oUyczI7L7J7QNsuIKVYOIpUcziCfllCfxy/ZJM=;
	b=nvcW8WVZ1i6OTiTryFLGJQqcjHsGKRdBy9ZO3jFBdtWtobIJZkIwZW+Looq3qaIch8Qv
	 O9Cwy5agkvelYq120u6k2vbEJFeqrlngz4Y7kJR9yON6QsILkeenSiOxt+4vgC6wsH5Ci
	 LuQFwQTIiQ3xezCW+ELwai8DQ1YRO1Rie6xETMBQxTef8xP2shuWNtwcdnku+JUgYJvBp
	 KUiV9EDx6O3XF51cc5LXcaRRYy76/A7ChSlCjlzBL4zQbbpCFatSQATSYoAwaz/Bsmwjl
	 oNVjj4iw11EHsSvFYBrQIRd+iRI+/QGDtODjdgI6l1rGbfeMeL+A2qGLt83+eW3us3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XodjmMdN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB7606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 19:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCB7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XodjmMdN
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso98251a91.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795117042; cv=none;
        d=google.com; s=arc-20260327;
        b=l6EQoI2EYy8C1clNNzzibDKuJMik5LzmQZkk6yiyZjVpRqSc/dOBBKpIgRr+ajLDj0
         N/7WerIUE4bpwCWfBS5tcvJMQX2VQCzH4UKm59SYU2hUObyuqntOT38yJUu0P+7/yFTC
         iLWCXP6nLmxt2XOILa9cKGT36B8V/QxQ0qZKLevTjD4kxB4hu4/DuF1ZZAAZiG9MaNm1
         4dW8txIvFVhP83NI1g6AD40qzQ4fPtQBEBhz10pRce9emIM4e+3J54CEDxUkvwU421NV
         WzcmIFZ+RwfFE4R6/jjIVpqxUP5ywcnKAk2DJzTeMxmXHRaabte5A+qsbjfV2dwMPLjg
         mgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ki7N7oUyczI7L7J7QNsuIKVYOIpUcziCfllCfxy/ZJM=;
        fh=yBnd25xPzoptXt8cKxg04hRiQ2n61JfD3ME91He8AiA=;
        b=XH8aDgJuKTNih8pPXk/+dDchX+0z9udgu89z+JpNB8Y2s72t0yMoPy/iWwxWi38YaP
         vmTPa9N450iTWbOXjGpLaZBQ/3t8jRy0DFaNZqc44uPGJ+RNdJoePKVq543aNj/6dodY
         U/ACKTj0yKrKgZCD7MyZbKuchYoBxUlkPh6VEbRbPBDzm1Jnc/g+41lGS8564VCEvER8
         FkUSfV/Q/TQ6N4tDZqkl1YqOWxSTlXo7KgrWVBKth8JZDjGbmasZac7iHPlFnCCDIDfE
         ndlbKJTfZSvoOc3W7pdSlsBIMpJWZMaLCFG39eiKRGUgTQlYin4WeTeOy91iErGk3H8/
         gIMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795117042; x=1795721842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ki7N7oUyczI7L7J7QNsuIKVYOIpUcziCfllCfxy/ZJM=;
        b=XodjmMdNd66sSQHPxgX0Iw77xrzUpXmpUh6FvrO/B/Hk8c1K7J/ubNP1xulYRVIUn7
         0zNyz12Ie31a/acpAaE2JdzOyVZ1FIPVGXO2gq3/Xb7Bd1z8v8sJz+XnGPwAxvBt8xIt
         nRTm2fO0Elbyrfw7YtQ+JmWuR1ealDi/ibMo7Imi71oY+hqZsiiaQQ9dG+C12cSBrwK/
         yX57pzVy1ZeFaPnMkTQAWdMaSdjisCW3A9pZcG19vKHgRG7aioh+XHJFJMVZ6Bw9H536
         yCz7GWX5rzmqjUzUXrTu98st6r2v67k8vlpr+1E/DOMY+/p5qBpWJAVdWcPbbrF9cIW6
         mN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795117042; x=1795721842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ki7N7oUyczI7L7J7QNsuIKVYOIpUcziCfllCfxy/ZJM=;
        b=aHmeutswMloT1FM8ZqdWveDHAFtvDygWnGJZAliefLjynyZ/vGaK4H01svGMXdEybf
         KtALdzV6QVi9ur6lzd2V8z95ZNz8B0y5xQryIKA8SelGoWhT63vDwzmB1ba9nShrN/L5
         Y4FtTlSlsK+EdNafZLs/PAsXciIul1etrPYGe2iTiyG8RHkq2ly09TpRkPhNqGSZUbnw
         TxIFv+48t0M1/HgLZshVjt+BlEtNUGNWhYlXncAjfwql06tgriO973dPndhOq0mRJMoM
         80e53rNBxCuTT/+Rm2SgBxmYcYLN70uKpzlhOhis3OA4Zu8y7wu9Xv+IZ6TiwEnJ8LiW
         mzbg==
X-Forwarded-Encrypted: i=1; AL+hErHP9QQxpJPJdSQHvJFvvu7uNXEblgaaEyJGNil/BXUCmxY4a4vAs4S4vdLkpjDzzxxCln4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+t99/5JHtIWipa263XTWCdD7SIH5u/mgHjjy+O+HrvD5u+JAvE
	iSi7XZfQtYiXOEXtU0yTjclxzQAUH33UTAu88LFVgnBWKBjbM2rOC65YmOxrVlwKb9+E36zQ8Wr
	sjuc7fEDKaVZFb1kzDEtOgKRYZ+a9e8KmE2BdCKhu
X-Gm-Gg: AZFdTZdxeqOWstlaK28zbHCeZnxmEtjcgOjKzjlWTB1PMpOj2P4Dka2NpanEanDMeCk
	AeCMjglWf1kWi6maVehyrSzBp2fS4icMm2HsEOVxFz97Jk5wDY+PN9QOwJCRznNz1J2aepw2bdF
	scwRfoxNBXpGilL7EO54SU4pA09rHqn5jpAZ6wKi5Msul15qGdZ0Xl65MqzUgsPN9hGU4acK2N3
	VbMKopMPz8MhSaUV4i2i/EIezYBmVaFfx4fo6wfJgxnT/csv7SW7cqBYNkbtq7Z0f5I1EiAAAXQ
	pBKYdFeZ+AfNwDCuLm4aO2bbQvDV6Uvqv7W6cObW2y6bmlXH1/GWD5YutVOxUAsfDPQXuz2xx8O
	1Glfu/E03yfrBQZH6MoN3K/qSaEnP6X/kMjyjAYZnTki1aS3HYGUbilmaGnpSrR7HN1k++A==
X-Received: by 2002:a17:90b:4a48:b0:3ab:2d17:51c5 with SMTP id
 98e67ed59e1d1-3b41c7b60b5mr394543a91.6.1795117042197; Thu, 19 Nov 2026
 11:37:22 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
 <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com>
 <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
 <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com>
In-Reply-To: <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Nov 2026 14:37:06 -0500
X-Gm-Features: AclHuK8huO5hL8Cq37FykvhPQRmji6J0FCQEXOUl5eyoX-lYuZrqwKkD8osBd6E
Message-ID: <CAHC9VhSFvOiP5Tyt=rOFMwg=Ro1jRw+hfcw4AdCkEyftZJHQCQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Paul Mabileau <paul.mabileau@harfanglab.fr>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daan De Meyer <daan@amutable.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, roblabla <linux@roblab.la>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 12:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Nov 18, 2026 at 7:14=E2=80=AFAM Paul Mabileau
> <paul.mabileau@harfanglab.fr> wrote:
> >
> > Hello,
> >
> > On our end, we also have already merged code to adapt our eBPFs to the =
argument order change. However, we would still prefer if this easily-avoida=
ble breakage could be fixed by moving the argument to the end, even if it m=
eans having to revert our fix.
> >
> > This is motivated by the fact that such a change is not made in place o=
n our end because we ship our software to environments we don't control, me=
aning that any and potentially all versions ranging from 4.11 to the very l=
atest should be supported, so the change is made by compiling and shipping =
a new variant of the concerned eBPFs for the version interval it is valid f=
or (7.4+ in this case). And that has to be done every time there is an upst=
ream change like this, so the total installation size and overall complexit=
y grows accordingly.
> >
> > If we could avoid that, especially for such trivial root causes, it wou=
ld be nice.
> >
>
> I agree, and that's why I'm asking Paul to accept the patch reordering
> the newly added argument before 7.4 final is released.
>
> I do not think that the maintainer's personal preference for argument
> ordering beats real user pain.

As stated several times in the past, the problem lies not with the LSM
framework but with the lack of an abstraction layer in the BPF LSM
providing a stable API.  As far as I can tell the lack of an
abstraction layer in the BPF LSM is by design, and while that does
provide some advantages, one of the notable disadvantages is that the
API is unstable.  If you want to be upset at anyone, direct your
frustrations towards the design and current implementation of the BPF
LSM.

--=20
paul-moore.com
