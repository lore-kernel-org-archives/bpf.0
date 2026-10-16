Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A583546DE
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163916; cv=none; b=muIDq7UmuxaKjbPowUDScCznXVMXgBmRi4LSDRMCOGsTXGIHD/VZRefLfQedenRIAbvCmu1YBf64+rvXAGfIwIZVW65nQh8AVSaxImNID2MOc1m7nmOIDWI3ExjlzTAOAURmdkBUYEwJaf/met+pLR79DahsU1HG7Lv8qT3+Xwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163916; c=relaxed/simple;
	bh=O2RzggFs1bjfXctsFTnmjze2UQnPIPO+HIGT6FFRaHE=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=IE0+eB7g4GRPBaLyqZn8475TWGdsD83oF4pCvhw5CCTI5FWTPoShGnq5OiH2EealXEyR6AKSA6K9yQun9Jji0c99mmuDl7qVmIggopsiCTTMoQXrchQqGxV0wvN5yPczYxZFYI7iXxoqDR3AsIBt01YJb01GOXuBc/WCZLaYzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUs9YMzp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUs9YMzp"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso48401a12.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792163915; x=1792768715; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2RzggFs1bjfXctsFTnmjze2UQnPIPO+HIGT6FFRaHE=;
        b=UUs9YMzpTMxJGRaAfWa3CFRnVugUED4ewzMEYAs+15Pf7d71gdu9iah62xjNMquUKn
         Jva0nXHGi2nIfX9DG6u7hNZePma7dJc1emBTS9apc6vNpApbi90hEyrIlNn3MiYxo9Fc
         pEZdHxZtXaMXl/O+/EP9fjMQpcpe8jaDWpP7/mXAyVdvqNef/cVNHTtaQ5XMFuHcwzED
         dUneqJtM4MYFrDqMlPuOoDYo3h66T+pR+f52Gy21IoWyfJgnl99672s2GJNn5Q6CAl2l
         Q6nserenSMSc+UEpCP3n4JBlVwLVsRdfsW0H3W197X1C+kHO8I5k2PCaT5g0VnJxzxbO
         DBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163915; x=1792768715;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2RzggFs1bjfXctsFTnmjze2UQnPIPO+HIGT6FFRaHE=;
        b=F65jlJZfhZmQl3IjhfhkJOdNkiCQrUzxa8Kk3x3OD2twPsKtbSBw6kkqrxGES29M9O
         3m3l1wreIVLUKJuS/DI3DOGvvOvyblOiKAk352KULsZUh0KZhP9cPMzfGSeh9jndmMMk
         QBDKrv3ZiQKnUw1blhIiYyLzq7AZ5Xsn4jsCkJH5wRVpMr8YuLbajUDiljuGBHDW0FJM
         SNofukBUCV/UVD/EkmjZuiOiBV8+pSLJbosplhPXpZhlQ9T2J65+ZNgckhaG8pHAB+wP
         wMwa22RzmgMBEEFFBEmdezd5bFf5W4KjFUuCuqgY2D8wXvpEoOcm49ewpzJ6NTpPyFOZ
         8ndg==
X-Forwarded-Encrypted: i=1; AKwUvBxGaA8y1pQp8KHtkImgP4wbqKswPfF6UMX0NHYrFqhxrCsp27QLWLEGxWjdfOJIrcre5lA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHHzufqEQW7yRWbmJXyLf+c0BIq2xHeeMAjNoO5oWxoDk5v2Jm
	IUTeTiQZPj1RPPIre9q7H7UdYfGWBSu0q43+HSkNTneK3LiTwCI1CdIJ
X-Gm-Gg: AYBFou0lt2z9cCp6rU3P49g9sKyBI3CruK45bZbfMX7+KPTF7CW0UbFb575QjVE3Yjt
	zD+rp68khSQYV3PiFN+4e0GEFpbFcltxMxzWUugcKJIa4FeB3H1eWiH/Y7C0skWPWR7udLEuTeo
	F324q4wFTig9Lk+rxB4xPS8tYPkBJYxXFYDpHDPhWHxFcaf2LOFsojoOPJmau9t8QEHh1ikEBuP
	i20zW7b4EL42sNxgytOi/M4s/9gDayyfxa9WkuH5J42okbVfPXARr7+WtcAX+pQs/Lj7kBYlH3z
	mYr/EtGPMGoXmD8MRowtbSdD6q4+bQZHZLDC7fi2HosLgSWHpKE4Yayr1dxOUwanXJFf5op8Ngw
	t1jnNhcPKd2tXv2MVyNsrFK6lePhSyaWd4LnUkb61wXC0/zJ1FZVxrcNEELZizSbFfcbmxsq2q/
	hFu3H1mxrlyh0/XDnAk9074LCuJXNbOux5MvdgUmyZPZuBaM8MECBTRPNYvRLELrOqEPLOLvIoH
	8PD23EHtiUbEshAmALIK6a8E0uQLNT5z8noAJshgIfmo4AtQ42HPywlvd1pNcCX/meElbw8W60I
	xK4=
X-Received: by 2002:a17:90b:3889:b0:3ac:95d7:2fa5 with SMTP id 98e67ed59e1d1-3acef1545d3mr137430a91.44.1792163914509;
        Fri, 16 Oct 2026 08:18:34 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd403c212sm1472146a91.4.2026.10.16.08.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 08:18:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 15:18:33 +0000
Message-Id: <DM6D33SL63BR.HOFSY6JUHO44@gmail.com>
Subject: Re: [PATCH v3 3/3] LoongArch: BPF: Optimize 32-bit operations using
 native instructions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Huacai Chen"
 <chenhuacai@kernel.org>, "Hengqi Chen" <hengqi.chen@gmail.com>
Cc: <loongarch@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261016081006.26069-4-yangtiezhu@loongson.cn>
References: <20261016081006.26069-1-yangtiezhu@loongson.cn> <20261016081006.26069-4-yangtiezhu@loongson.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 04:10 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> All of the testcases of test_bpf passed on Loongson-3A6000 (with DIV32)
> and Loongson-3A5000 (without DIV32), here are the test results:

fyi test_bpf is gone. See
commit 4532e525b286 ("selftests/bpf: Remove the old test_bpf module").
Pls run test_progs
