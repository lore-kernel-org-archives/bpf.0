Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794537715;
	b=t+xK3SRxrW0u8QbsJ52OS1FdDWwh0QTrvYyXoP7tkhV2UEmFOFU9PWt0YD2f+KnIcxhe
	 Pje9/D78PtLdFaDvSUiRWybFpuY9aVLomBiA7PeLu/CKykPbaVCukJIm079iYNlRdhXFQ
	 5zE9ZNasy2VuA7wePbZBWGY2HUJtH+x/FammTJGdkb5IXIdyFmM68TN+JhbmuW8jj4a6Y
	 FFgVEFGHuFRLrPSCJLTODhnjZU+iUUmjyRHtxUttkh8KuSjPvi1dyl1Bmq05i+a6bIwx8
	 F5EBtdsuV1iArVe1nToolzMPuDtY7LwMXadxKEB8QciPjafFUEpJmtP64/abJMjMnmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jAKaL6ziK4SU3uYWDKIwk2j64mElGB9GfkW4ERNhraA=;
	b=iswuDyUD9ffaGr13vhMKEms+0yEQ1016SiBMV8Xnhok7p1w0OIUCrvkYnsXhPdjuYk86
	 cegr0U0CyOIxpSzAoWBLKDI8J0/0CdPUtvZQWl1sr1Rylzh1GnKscqsyZgrfDY0fYFzpO
	 cwE3dyQ9bDNd+722Tkr8h0KPb/HXMrlHZIyU0gmFKu7xf4fcWQBD+dYlUAnUqjRvvpbKV
	 iZJ47zYPAwVU488fuRvjWmZc1h+/5qunenvajWdK5UyX7icPA9yNpjwZXnSLaQlMkitG0
	 BW5t7PyihqX6ulGbz84ktktBYF+VZ/+T9PnYKMKYMzDqHbSsqFXXZuugB59bzIpb/dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XHLr4Ebq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1B60A381F
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF1B60A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XHLr4Ebq
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9d7791b00so6384505ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794537714; cv=none;
        d=google.com; s=arc-20260327;
        b=dwgNwI3u0J5yB7oNjnkj0zitKIp5niI2ylRiCX8vem3LjOrmXhl19MC4uj26EtlUTR
         nH4N2zBMh/EXyO0TAm7fF9fMQSd3xqGMUNzLI5Gk61kGLn0YD7wLIxdKLXYFpJnqGypj
         +KsWyxQTVwRyUU0qhOtKipF5ZLxydGnQHXDJpSbrWPh0CxCUihFqUI6quvp/rmojYT38
         6ETUM54kLoX5J6Atcz3kdrGWNRWSJv1TvZWXALah2KqChCyCWBS5zJ8tNUG7RfCzVGqV
         QkgyJ8j9lE/WY+p0dP6GoN0KBsZnG/kdMuIghw4SDypAC7JVllcg4mpKWJlxmXpnFGe8
         LhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jAKaL6ziK4SU3uYWDKIwk2j64mElGB9GfkW4ERNhraA=;
        fh=U7rCeKUq1gIR94U7U8nuOUDr+SAZp2rmX5LW3AsCUeI=;
        b=Pq5OtJBT94GgM5xxo5wgCAwA8OLJ5IIjPyIjxcc0I2mGWGvpK27rWqks9GGdB33yhR
         bruL2diWITm0g3bD33TJuq1fcMKO+gthiASxAxnZhAZth9iLpb/wm8DPEPHfQDqvojnx
         ghezFNv2v7yLEW4fcS4bOstVftHR4zFZeZmaMwtSbp/xrbVa8ers6xEdEweI7YV5Keav
         070OScnAm4tDDYvtSBKnwD5vzAaKeVNvOH4VNVTVUC8KmJPMucMVNFLIHDfvUkDbyfWJ
         vgWQOWhLpO1yCJC8TS0BF70J+j6f200skF04R1uHsRMHpFJP+KMnfkUrIw2AJVSBmvK+
         5BmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794537714; x=1795142514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jAKaL6ziK4SU3uYWDKIwk2j64mElGB9GfkW4ERNhraA=;
        b=XHLr4Ebq5HLkuLIfnhLPMx5ugv3Xsm/b9CrFFdTNc381Y+3R1DG4UnRb4SMJPUQX/n
         ngfxcKauznwrSl+fiVyaM3bmGu310q4x/AW/f3Lc1H3erul5CeL3GkUWaKn1XIzycPHJ
         /AuCnAKHKKJm2CvanqMb5+0vOCUszWF6CrEtpPEplUMnkh91rwbKa9ydV64YPao7WsjL
         SFpGXGF2hfax3ktt0+wm6KLqAKWnlYXyAi4lW1tH5XZfmWzxV87bVyx0dLaLu+5DcBTq
         26XqL/EzUksAUVuk8gtZa5J5uFcJwdPTdamZ50XBjhuQzM5fBCo9EFZzKbEa9ANC05eT
         SfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537714; x=1795142514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAKaL6ziK4SU3uYWDKIwk2j64mElGB9GfkW4ERNhraA=;
        b=Cpn5cO+oLUx8Y76tI+IKlppy3cwW/mXTsf1rQQvyovA2SV1WODT5pW7TEB7qmC8lB7
         namrqMQBkkJmQSEFRTIwCaCT2HCLxL96k9sVdm9CGrjTTzVeU/S9CUU5kAPhBPI2MsS2
         Y10mOwAxOyPfSQLVrDUEndJ+Ryo86SY9JbW75yWCvq7VkyOyjG5b/0ldlcOcKqmQADtS
         JU5MLxeh1YR/jgqLwYx4+OH4O8aBGXl5elEBeolYllGrxVomvzoG7zfwLB7PBuLhL8sx
         28aIhGsNbDWh5cI8g7SkX6RHsQMIhiI7FAZJvSZ9VMSnGjk3H4p5vpYCLoPdRcoc/WsD
         E4FA==
X-Forwarded-Encrypted: i=1; AL+hErHbh98IaJx1Ohvj78o/4PNNTGz9MZptAsX7YPd4P1XRm/+Aeymdp9YdvOCubhI+GMDNRSc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zzQrdVwG1bMut/R8T5EJ6XdWEiinxJSKosbWWHIHWYog7Xfbo
	MS9DoL1BWrSUWhtPhOIL04zfxiY9MtBEAiShvW5gBm9LS3HBdg9spJsYUZxQBifNC+egStQh72Q
	ezf2PSJnSVDOt4L1gwbQXDOQqxHe35w1W3iB8jGiy
X-Gm-Gg: AYBFou2/7l7c6ZvlUsiv2t6qmjrLPFfkcVazTfgTXtCjC2nuCn4XLg6TzvUfXk2MqwD
	CVVU3xnJOvI53d6l/z2wITJd9T8RQJ/VmsJSPNUGuWNEo/2sKJkmIp1YtGca+OQRIQ6Xkmbec45
	iLchMm9W/V5MCXPFFnsBL6ajrcCwvZSD7l8ZpRh2yxmFKVkkEiYYm71NNnbXcXENBP8nbTZyKne
	OfzM3v+UaGnOsfXYt555LWbxYxmP0xoCkBP3YvYCIdcLPd+U8XYOM/1qPnpfU2GL9UDj9HwU/6/
	cXZf0Ityi0JGXAQcyW1aETG6dVVSQeqfg2ScC9mP5jheEJ6XinrUir5XQzPif2ttkM8jquCWzTX
	ybKkloo2DyEckLq84OduZE31ATuV1/bq3sW6VDv7DJSYNaZzhHipHt8Uj1mVKg2Rca3XJ
X-Received: by 2002:a17:902:d58a:b0:2e9:9a19:c43 with SMTP id
 d9443c01a7336-2ee0dc92381mr10406915ad.15.1794537714397; Thu, 12 Nov 2026
 18:41:54 -0800 (PST)
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
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Nov 2026 21:41:41 -0500
X-Gm-Features: AclHuK_hptpm5wmZcDCZpYaTcjHynA9uzBvoUM-dSQMe8mTEMVFigRMkrd49BmM
Message-ID: <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, roblabla <linux@roblab.la>
Cc: Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:00=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> wrote:
> >
> > Hi,
> >
> > Thanks for the replies!
> >
> > > LSMs that need to provide a stable API must provide an abstraction
> > > layer between the LSM hook callbacks and their stable API.  The LSM
> > > framework is not responsible for the stability of individual LSM APIs=
.
> >
> > Understood, that lines up with my expectations. I think the biggest
> > thing here would not necessarily be stability guarantees, but rather to
> > make sure that the eBPFs fail to load when the compatibility is broken.
> > But that's probably a problem for the eBPF side, and not LSM, I assume.
> >
> > > So, in short, would it be possible to send a follow up to Daan's
> > > commit and move `struct mnt_idmap *idmap` to the end of LSM argument
> > > list?
> >
> > If this is possible, that'd be nice so that we avoid this breakage in
> > the short term, since the change isn't in a released kernel yet.
>
> can you please send a patch proposing that and we can continue
> discussion there? please cc me so I can follow along

Considering the original patch was submitted, reviewed, and merged
with the BPF LSM being the only user (none of the existing in-tree
LSMs use the idmap parameter at present), I'm a little surprised this
wasn't brought up earlier.

Beyond that, from a style perspective, I think I prefer the idmap at
the front of the parameter list in most (all?) of the hooks where it
was added.  I'm not interested in moving it at this point in time.

--=20
paul-moore.com
