Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18F2580E1
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473153; cv=none; b=vAIOhiCKKMtAupl28v9QOQTb2ar3/DIGZHqaAkZWG270Qx2dz0Iv5XQdFAnp9SuFlUQisZPJWKnQXXgb9TRsnSouhph0MVgE5vHlp5O+ppMdGAbW7BBtTT/JgvCObBps37RkR1hE3UgrA1lzugqw4Ful94iOyv7tVt3hAs2cDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473153; c=relaxed/simple;
	bh=fbdigxQumNfX0PKqBopq6vWR2YRTWxKM8HuJ2xjqgiY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6pCMGr6Chdr4hMwsyairY4UJ7LuzKZexEvLlBpNRkbc02eREQwz5SxBktL59D3qzzfI03l/kRcH7ZCmfxp7x0hpumbsvGCNTNJup8AGYtlQA9yiUCddPzf3JjZprnwb3l8DGMB5MHgL+rqG6eiMF0hL1bERfXfpSa/vYE1QVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvJ7MHNm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvJ7MHNm"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0afa0210bso5944755ad.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776473151; x=1777077951; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fbdigxQumNfX0PKqBopq6vWR2YRTWxKM8HuJ2xjqgiY=;
        b=hvJ7MHNmjyJbPlIJcdz5psMPs8+Tz9xNXtzhI66FyLDKx7YC4fSqzcTtpE+1AXBq9d
         wsvHgEEsjlEQJFkGdpOi8GmsGzsungHRpiaYM/pUj/qbKo1UqBlhei1zmtSF9XyzWJZ0
         wd3WCPgNd8m8mEKa/KguXA+wtKagT6A3sZVjQ94z+AK94ygdZl66e+PhTLvfAhvjP1f3
         9AXRFSyrxZ9q3FIuoE32RzaQq1l3Hi1kdzbX5md8KI8Ye/DO62jvpK0e/K7vcecdJ2of
         aXf7+Dhl67IfvAkvzqTyCK/jCZJLQdmF9MCSdNkfP0jsLU6+KuEfY9OkPX7AAEMp79cl
         Q4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776473151; x=1777077951;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbdigxQumNfX0PKqBopq6vWR2YRTWxKM8HuJ2xjqgiY=;
        b=F/MnrVyideMYsVMvqp9Yg+D3hx6ApoI4GGzp2vO6KICMecBXhHTHszrWgoSVpdgfmx
         lUM1dV7N3iv3qM9lFdpzphVaPOMO/TTJPrNmbx8y1UDNSAPZlsizYyJQx2nzrcg+Quh/
         ghR3xNiIgng1rAcvrGq9q9j+q6d5lp+0TgyocXqMWFPYSN9Z91bnvkBmgkBu7Fg64KZa
         MsAtRsiG0hXHrxSIbkXUWKFex53NE7InuAgJBqWflWa1nNLa1YJFI3IeVWnnzKJOILyO
         9XUb8mulIcDdaSK/KuvZ4HU70MPv3H2A/bIAqbUlQurOs83k/RkkXYtzjG3GFaS0mAQU
         5C0Q==
X-Gm-Message-State: AOJu0YzrU3950+2aoIfjnAKaf1vBMEEhvRtg3SAUoPe/iRt+OsSuBcwO
	Fp7+7j5Vg1rfd2jaTvvIPfYsHZcX3fOM8NWc8Pl/4GWM9ppt3cnETC7DWO3kBg==
X-Gm-Gg: AeBDieuvq8vqlrQsXmWsBimkNDFPP2zd+Agxpj6EEx0WlRuvxNBzGSpx8DZgGB1Nall
	SMSsJcLiXk/rXSHVsOQbR/voZ5ChvD3JSFXzKU11zI2cuwHudVXXWNECDCitMmXF6jo6wwmVLiw
	2asKYh9rh6FYQIojw3e5dmDaJKuixW1l1jWNdVdaC3H/+bGy6jfAJxOFlp0tOAwjxJcm8bBx2IZ
	KB6EXxWwsL7EZ2kPTA9P9Vcxy41SoYsKFDAIzppVgiu4cC1X/pkwU8SHv195a6jbMZxgGWDLNoJ
	P5E+9EXsCfDxhAkudGb/NMROV5W8sqsB75MypXmYY/xLqaGxpnn6sj4e/6t76MBOVZwB3IjuPPs
	BcPFyEd0xYhfvG1Z38bIm1+mase6a/njrbv++mVAgve7cJBHcqH1KEmBLeXD3iaVxwy9R3/qFTN
	S/ZXMz/UsLcTGq7Vsdc1/SkLO24mc054lyca+mm2165bEYTqbK09U0LvSi2kr9tOE=
X-Received: by 2002:a17:902:b689:b0:2b4:6080:d4d0 with SMTP id d9443c01a7336-2b5f9f3ca81mr38637375ad.22.1776473151372;
        Fri, 17 Apr 2026 17:45:51 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa17632sm32598535ad.24.2026.04.17.17.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:45:51 -0700 (PDT)
Message-ID: <aa9704461f816bb90e2648d7ed2ed40268d63215.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Paul
 Chaignon	 <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Fri, 17 Apr 2026 17:45:48 -0700
In-Reply-To: <CAM=Ch04tB7sXD_qmK-5NZ-aQZutJ6bYmciU+hzZZ8yJx-hbwLg@mail.gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
	 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
	 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
	 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
	 <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
	 <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com>
	 <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com>
	 <ea37be7028d20e962816ff10631da383b5910c57.camel@gmail.com>
	 <CAM=Ch04tB7sXD_qmK-5NZ-aQZutJ6bYmciU+hzZZ8yJx-hbwLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-17 at 20:38 -0400, Harishankar Vishwanathan wrote:
> On Fri, Apr 17, 2026 at 7:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2026-04-17 at 14:17 -0700, Eduard Zingerman wrote:
> > > On Fri, 2026-04-17 at 01:34 -0400, Harishankar Vishwanathan wrote:
> > >=20
> [...]
> >=20
> > Pushed complete find_witness() implementation in [1].
> > cbmc verification passes.
>=20
> Just saw this. I shared my complete implementation in another email reply
> as well.
>=20
> > In any case, please let me know what you think.
>=20
> I think the ideas are essentially similar. We can decide which one to
> proceed with.

Thank you for sharing the code. Indeed very similar logic.
I was under impression that you don't like the witness idea hence
proceeded on my own. Would have deferred to you if not for that.
Tbh, my version looks a bit shorter/simpler.

> Alternatively, might we also consider continuing with the pairwise
> intersection?

Since we have the complete intersection logic now and it is about the
same size as pairwise, I think we should use the complete intersection
version.
