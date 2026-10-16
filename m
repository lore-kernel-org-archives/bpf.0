Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC92EB874
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114031; cv=none; b=njSdMdS6opHGPbRl0dtNM+ME9WBtTOTWXkY9VtROSLkDKUe8xDnBxatf2NgA5D+YlQqLR0zWAkRSPrbZ34pO/Ca6ZmIwPCmdgAAbxJHRxo8qGUMBqbj3TGqqAB1q/ekb9lFuPOlKtUNbihDDDGjpV7sbUR3LIOdqlHkyJ8Y4OF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114031; c=relaxed/simple;
	bh=J972KDhbbTy2zNDzky5003CLr9yJJeWm2LhAZ07hOYY=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=gDrsdUlGMGpdiisxx2mv06oo/C73T5NuSAltXq+S1oVKF5024G3yuL6Ay09BpVjyEHEJnu1kfOE0NpVCcsRt+l0lCRNSrkWrRVzOoeoAPPf8DBNHsWM1BKpyZlb2tRoVTpKbTn4guHt3phspv4G/+Y+bIcQ1Vb0KzvXx6ykl4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2a5pVEc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2a5pVEc"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd3310348d2so274779a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792114029; x=1792718829; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xKziCSQLqHC+pDQ3qT0rVAPt5cNYp4e0Gr2EJpf0ZLo=;
        b=H2a5pVEcDy1Mg9/CLFUu3aJkdUPOeV+AKAehZfn9ttRO58rnQ5wubI1G04EVxQLlRP
         7KqWa+0NHTd9N6ujNzq492Hlzrk0Mo2l1DGj16BskQH4viPo37ppXxK/l1LO1W30ZU+G
         ENtxXwubB1vH86yv+mXdYqqWq24u8WCl0rx9a/VBM1vThuT4huFo5BmgX35d/MclbDtt
         oT6+ySNOljWpdUrkbNRWFETgL1W3Gw/+tcebZ1Sdy6muaUA5TWYaB1Zcc9bmiBb7Icgb
         7mJ1p6mBE3VbnFkKo7vJjmbdrA/osktSgiItHqXD2JbFMIKox0MuIuHt2irbJElfJB42
         p4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792114029; x=1792718829;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKziCSQLqHC+pDQ3qT0rVAPt5cNYp4e0Gr2EJpf0ZLo=;
        b=L37TTQu8FytvGNlKXVi5voNNhKLTAtqHEbJ1EvjxZPxQtjbaXCi1FMGSgUFt0O5/99
         bQUw+Ju8vqQiK3CVduMyyCOUm96Q6pFwi7VnX2iR3GLlUEh0RjD3YvbbSRjdrSbJ8iTG
         H7Sdr2GMk6BA+wUlkdTaPsAGKMBfENQRuME+oo58ETezd9lgijZSLQTH+gZL4BiMCWo/
         OXfDTJ++FtCu7yxXlrEAHLCuWHuD7/H9+Py6lSYkoCQsoD/CusZbJnkkWMReU8mR9zBX
         64Fcr2WzGiTDLRWGn1lRm5gda4MNBh976yGv/4vr7BMPoHWRt3gp5dPCc/Nba09yhbXB
         Js6Q==
X-Gm-Message-State: AFq9FYK33+6kkKT/Zl6SFWUEfe6Qa4Aqse01yDCcRVx58WiHaVAbrnEX
	4wrzA6dIX13LfSHzg0VZeBfeLFKHj20R4Z6IZtFTv4brmNrpZxyEOrmJ
X-Gm-Gg: AYBFou2e6Ej0A8VYZmANHyZEvIc6NaV3x9z4vgq3wwO2USYRJGwq8rBQFJ+ZLDlRdpE
	h07M1SlTeXIUaXT/tFoHOsYzLBMByVYpTZBMqCdR3sfSfFhhl0Pbcknr/z1U3xns1oTMKf96Eoc
	5VXu2Efu3bebqul2o2rtniak8XThQzXf9lHcIUZXkqruqUy5n5z0vAfp4bwwe3gHK/Q+PkXlx6H
	SJjCHYxOZddM6mJDz4vMIe3HoLTr0RwAR+1+lc06U2ApXKKAYIMqaPXOEpYE8MdBZGpqPa5etCg
	pUcKMRyStbAFKQU6w/XgTMqt8sb+CO9ugwjf4HtU0XK1KI0SHo1E3HXp1Mn0D0gFvxk6frS2SUw
	LGt/P9HVqCiCyzGMtaW2Hlf158b7aEvp/kq2plTiALgO6ecyBa+i5mx4MZWgo7MfJsnlsexywDs
	kX0mB2772hVAHhQwYsFrZCXnIHbYf76GkPzI+7zQ1JnpIp+Vl1HaXixIpKVpAWXrBNxboFCubxv
	utZCWBNCzmeA6wJJT/4JxYtkr8/DLjMYbdrxX1aXpv37dJ8sDjjOQ3Yxb/cHEsbDSqOXUxWdWmW
	XRw=
X-Received: by 2002:a17:90b:4d8e:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3acbb8bf8cfmr1194929a91.37.1792114029604;
        Thu, 15 Oct 2026 18:27:09 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ebe40sm1580061a91.6.2026.10.15.18.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 18:27:09 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 01:27:08 +0000
Message-Id: <DM5VEJ802JZJ.2Y2NI0GZNVXMD@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Quentin Monnet" <qmo@kernel.org>
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Cupertino Miranda" <cupertino.miranda@oracle.com>, "David Faust"
 <david.faust@oracle.com>, "Ian Rogers" <irogers@google.com>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, "Vineet Gupta"
 <vineet.gupta@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v1 5/8] bpftool: Emit __bpf_core_pso on
 verifier-rewritten context types
In-Reply-To: <20261016000012.2232059-6-ihor.solodrai@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev> <20261016000012.2232059-6-ihor.solodrai@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 15, 2026 at 05:00 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> Clang 18 through 23 crash on __builtin_preserve_field_info over a PSO
> record, including bpf_core_field_*() and the CO-RE bitfield helpers.
> -D__bpf_core_pso= can disable PSO for affected programs.

ouch. anyone working on fixing llvm ?
hopefully people don't do
bpf_core_field_exists(skb->tstamp_type) 
when skb is __sk_buff.

since nobody will know about -D__bpf_core_pso= workaround.

Name is also not great.
"bpf_context" ?
