Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689556;
	b=BCq0rbRDqrVcXWx9jGo0KKM5CYy0A7TmjnqMfHAoPbbXMufaFAV7T0SmVJsDeImRMDuQ
	 vDcMYQdS8MKtNkz2tYf5YItBeWtHrgXuo1oIa/mPfGm/Kqa3Bhlksg+5D/FJWKgI1FPdc
	 XsiKq2NHh5LD2KdrAakkx0Dkz7Rj1D2/slkSLF8AWWJXEiiFi6rIAQRod7hoI8GUs/lNQ
	 nYWT4XWXdA01LiYJBsR74hUiUeMxcwRSw7/XrymrKZiJ11xBsbV++zJLYM7kzlGBdmNCg
	 18nUL5UowSLIfd0E1rsk9ypiKNqxInU1zRmdugVXq9MphjewD9tWKOXuLHqvocRXnSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=y97/jaewEHbT2OW6StbmLAd/jwpSWkq1Rhi9mBatr9c=;
	b=gNVeKsZw01cm1PDJENYlkZAoTsJzKC6b5hbn7djeVmqHVEVCeWAsomjM1wGxxBNaHiwu
	 8GuSOxazaalqHbXEyEcD1m3tAruurBHewZfF//VhF7NAUre/XT/uAPzYneiEddSSANIn/
	 NhAjufBJttS1bnO5QGydYqtSF8P4N/FU1PJcfvWxY683WnZ7FxT0HqQ9/Ub6Ia7bsdae6
	 VAppRu1xZjz8vW6z3/BVD8tM2fexqEnXCPmcOLJJPnkF7EK8m55tt4GrMfWehfuK1qOz3
	 aJntEFZKRCow7D09h72id9ouG2tS9iE+g+sqIjA0wn7GGQRzJteSCbPjKZl3twnoQfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8M3CYVz;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF02B606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 10:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF02B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8M3CYVz
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso68420295e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795689554; x=1796294354; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y97/jaewEHbT2OW6StbmLAd/jwpSWkq1Rhi9mBatr9c=;
        b=n8M3CYVzCKvn9tyl2yeeNtnis3O/d+zxsopmHRJQ8nJ9crUq/TiXL3TbtI/UU7sqsP
         ilG3/Sh1+Mw7dlKLJIR/dN1sBrPW2eEk/V8qxt9xieaR6JTG9R1SZ44u2J1LWmhfrWYP
         uNKnVpfkIQIIPCSF/XWdljt93vPuP6gtkw5CRMyjuZ3It5MXFp7mTB6WgM8RA1I7uAYG
         kv65bs9BnYpLr4WlNTRIgo4wfWyTE+xeqz0k3F4Mr+EjHL4DgK58AjlIWTu9U3AdL8ab
         RvabepS2cEHSeNrUqSohSV04DuVFkJ7xjdoJCyu2PLMPm68lBzi311KCK0NzBJeDaFq6
         aXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795689554; x=1796294354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y97/jaewEHbT2OW6StbmLAd/jwpSWkq1Rhi9mBatr9c=;
        b=NOKloH298sqRADqA8g0qon7llpSrRWJMjHZ1UI1YdenVVCn6x44f1FEmWTfvqFatpW
         NB4a9ZgYwx0Hk4WoiUDgY97p1M1s+IHcETY3/q2mp2YSDg9BHov669V9zgn49ptAXXSv
         DP7RkoIfb1cQygDGMjiPeyb6Typfgx2Tm/0uzVOrvkFpkYyMGVUpnfSOESkfyz/JDlbF
         3UgyMj+a0XUkW4xb5pdI8JaiGYOWyuLZ1vs6dVwb2uASB3treho96FLpfliqB6gLuS3P
         V71H48Sp54DNcYdLaKdw0UOvt4EgUDWMGQFreZoSnfrPRJD+tH+4SGo96PHSv8XPC7yH
         aHtg==
X-Gm-Message-State: APuU4Z964JjYGqGDYzOSqoQXtQ33+SuVWN1fRWYtX4RWnYn2u3eWvX5J
	8hLMRbli0+eZxiSINsHuUuIjyXbsSCJnC+rsxZ2XaeyOj9u7QitQ5efcJCk8vA==
X-Gm-Gg: AZFdTZe4ieAcLO1Y38z2Haait2ORsB/KiyLhk64v3RGnna6lylHXidsNw99zzWzYUSg
	NJtdjLQDhaY4efV5wfP6BjURLoZtaVzt1N2UROCRo1663Ggonb1W3qlzojh3WHH62xoDEwwOUYv
	mw2IN56QFdBC5OVudGB0ueBrQe6vTN6dEwlTY/OYDW7m7gB0x+Qp5rgMAo4ocy2pHS/odutKBL3
	NvT1p0/ADcO3iy7oENVq+QAf7skAd2B5BrTuz5TS5CP3c9f8BVZxbbOm+0uzXiMr+T9m9JwXUuQ
	oD71C6AJqU9YfEvbbFVXjtNCMiGQXDaMZjcuCSvejAragMcb5IoAr6KERI3SFrq6uWHEVH+Kebq
	IqgAh3Arh2ipSjCUZqlSXUni4k9Tj886t9IZrQMpEtA9zjZsukqkGoQzgEkpKi8AowL4Qr916jV
	eSvlaLe4BpHoNbh4Rvko59tJ9unQBlVtBoOGmnvhxXYDMBkFFeo/0M+FBiX9MVSjRyE8o+duRYn
	XO81cOfRryvVxqKbHP4F8nYRCoekS3dtOKd/Q6goD1nmDfTK/de6p3sVv+k/kQvKJjIc88PMQXV
	suxXlGKadKhX8xM5WLcHDFCEcBGAr2asgh4T/g==
X-Received: by 2002:a05:600c:8905:b0:4bb:6816:127c with SMTP id 5b1f17b1804b1-4bb861468cdmr394543635e9.8.1795689553958;
        Thu, 26 Nov 2026 02:39:13 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2052c8sm40021061f8f.41.2026.11.26.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:39:13 -0800 (PST)
Date: Thu, 26 Nov 2026 10:50:50 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 1/5] resolve_btfids: Do not tag functions
 which work on BPF objects
Message-ID: <awgPCnuRzevgb60e@mail.gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com>
 <20261125212849.868523-2-a.s.protopopov@gmail.com>
 <sashiko-outbox-234173@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-234173@kernel.org>

On 26/11/25 09:25PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] resolve_btfids: missing Fixes trailer for fmodret_tag() BPF type
>   exclusion
> --
> 
> commit 36940d1b337a769c63009cfc2b22cfd69fcc61f9
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> > resolve_btfids: Do not tag functions which work on BPF objects
> >
> > A program on tracing_iter_filter() which returns -EACCES makes the
> > verifier miss that a global subprog throws. A function which takes or
> > returns a bpf_* or btf_* type, or struct btf, works for BPF itself:
> > for the verifier, a link or a map. Do not tag it.
> >
> > __sys_bpf() loses its tag. A program can still deny a bpf command on
> > the syscall, which is on the error injection list, or on a
> > security_bpf*() hook.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> [Severity: Low]
> This fixes a bug in the automatic fmod_ret tagging where internal BPF
> functions were left modifiable.  Should this include:
> 
>   Fixes: 4dd950adacad ("resolve_btfids: Tag the functions that return errors")

I didn't add any tags because I consider this as a follow up.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261125212849.868523-1-a.s.protopopov@gmail.com?part=1
