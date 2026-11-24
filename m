Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552168;
	b=P+Nx86ODol/m0/SjzLzKTG8CqCjgao9BNU07Ly5KWpe/o2PLhVWJoYr4TuBAk7tFCdCb
	 4ixMd7pAQKOKTrYCDFoo9SydsDJWnABbFxmvNodIzetfUj0GV+hifuXWMOYeA2eMEpk4m
	 YeATEwkFdRCZOxInRB/2N7ZCICB22Xj3Uiz5u4qmOllV0O/tlTVDH/gWOG2VCPxvHsnoU
	 Azd9Ta81ItQHrMaTxdGN6KUM4FsiCfg6ewR6t8gczIh9Dz3mjZ7sEWhihLxAhv4lAkBDj
	 iodlJ0Yz8RKN3SEY1txK9UD74PO58ISlfgOdBfPILvE9wOzl/lyCOdvvrcFpu1BZddw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=C3HV32h/nzJ/HO0KCnWYYz1pnwdnCDCq2Tq04usC3zg=;
	b=AJW97DNEzu/YAhbwMjod6Y8WHeLbU+eEF7KTeNCKcrPCfbJfs6RIy64+4SXCFUtaUpKu
	 mf3YWyDY7rBgOwVr36RqnKKwMU9DJc1skeUZa1OmxAxTXoEDY1wfYA7wcoR05j9iOH/bH
	 q5fPs1O/SceKeEfgozfUZ97k4A6Gx6WCujFz7S0h2zdSBwws5skBKAQ5/kr6x0pUHS4mV
	 +2540Gd/7sDJgHydKmlPiH4us62lOc13/WopSZW+eIjfuxYzgY0GcA4SA/0exLYBK+RjC
	 ZTszfmG49ZpWYCyaaS8zghWTtjvuey9kzpXJcxFDv7sABlgLoGFy6gNwS0xhv9pEBnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5P5MBUo;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4D606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28A4D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5P5MBUo
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so3340610a91.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552167; x=1796156967; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C3HV32h/nzJ/HO0KCnWYYz1pnwdnCDCq2Tq04usC3zg=;
        b=q5P5MBUoQ2u5uAv2QQKhX4lON/ENs8MT9JMtBOTlmzOwFEg3C2gtuRUGsiJPjuOnmE
         CViVtedEvVbEx3tJhWmvK+Z/13K2IwMxH31Nh/xhtIgVj6UkxstTvE/ZSeNlX/MkACg2
         /KiYW3+8IvV+R+VfvzFVj5119ke2ZO6GqAEPIw087pR/5DnF5sehY6EGmk6vQTr5q2Tx
         Uqy2LhBRlsVWVlBXyRWBf8EDBH98rRIzBGwDBeSPNpD7s3vGntqyjN7JcM4jn501ZdFU
         aGsqCOWDR1ZH/YPz47gglTj0YEO2H5S9bqTnof4aj0NWQM2hvqiwexVaOQswjPA45tQe
         qCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552167; x=1796156967;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C3HV32h/nzJ/HO0KCnWYYz1pnwdnCDCq2Tq04usC3zg=;
        b=G3pQkqcxNvwfzPgDUGpu6LGFguHbrx+ELJdiuOE7FNwSU1TnOfqxIJ5I2yW+FWA7c4
         IfvkTHdEBQ+HRYsm6lM9yd4SFyb0UfxwlRLv4SvIogEAWVhczrjn3Qb9OecNekeZsz98
         LtNB9ayCJTyjrW2W6I1Atb9KGqKpVtFvaWSPnHzrmVgA0kB9YIHCnO//vO2J0FMsCnkC
         U21JhJhhkReLWL08Y9izQzwfUGLXfyfadrHLp+wEmTtv4DUtp+xGCXrns47f7BvSKdIc
         VYKWJQU1nAJBm6FWTSXgfWd5s/s2V3D4rDhpxk4fKkZF/okwt+PMXW9RPHGWLrKvux9t
         CVFA==
X-Forwarded-Encrypted: i=1; AL+hErFBM7R0oWOTl+omUewSXmQS7YByE+bBGvlRGNxQF5LxRbhCy4MZIE/DUbmdh0VnZDl3cmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+MkAr8hY5oSH/EDC26yvyjykJ2/EDymSLmiiBNGB2cv/GDli0
	WqGSkCHLusfMZMtxckfvBZ/ka2z+ZLHCgWhbZQeMTGUOJHvxZHNfqstW
X-Gm-Gg: AZFdTZfUxMsl70KZpDAvZ//H4ulnwXScyntX28ssbypzs13yHzJg0IWZXClSjO1Wzmp
	WrBnuq0HmAq0HEOGnEZFyRQPL+jLG+lRMZAqAr3YkDpn0Ru9n4DgeBwiZ21hJApdpa6eOj6FpFZ
	ek2lNSfZkr58poUvghp3hA3NzxNhgIsLBdUwh7mKIn8FX1HiljIJPHPsPlC6ivwAJE1uudvVubK
	3C9TlO+wKKtv452t5hSv9qYrmKEJ3ldg5zX0Z56DZU9ZnhF0ln0BojdhXO3j0Akh80LJe9UbnYS
	uclnGPwKkDw4IWfJoShhd0tg09e+oXPorzgqj+48bZ2oqAEnjN1h3wd1l3BFbUdtn/IRA+dSpBD
	CBIk8pqtPsltYgQjdQEG38d9+CoK/ij++vZCXzmkIYKrH8jxVX2v7RbUq7JTMbScz7w73w/TZT8
	Lt4gIaaUsIL+qYihJT1wRJPlLStCUiXKjVTRnMrmA1/EK8Ck8biCIYED8T3UbSE493U3iwRk7SD
	wn0trrUTMQoJihlU24fc27lXMzKM3d9jcN+ZJvvANocIHUr7IODQLOknaOgEO4nw1bkwtA1bf9c
	G4hepFWtaHiIbcO7XZbBXOZEVUdY4te9TOFkOq0WMr6NWGm/qpBpC+iKT79la2JzkTdD6E0RrXY
	GmosxCasZsrXzVxf9gE1jCVZ2FE2HVxL02Q==
X-Received: by 2002:a17:90b:4d10:b0:3ac:9669:846b with SMTP id 98e67ed59e1d1-3b41c852826mr14406212a91.9.1795552167442;
        Tue, 24 Nov 2026 12:29:27 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40a878d50sm26492190a91.11.2026.11.24.12.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:29:27 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 20:29:26 +0000
Message-Id: <DN3Q4DUI8GEF.PX8U99J6LKA4@gmail.com>
Cc: "Chen Pei" <cp0613@linux.alibaba.com>, <memxor@gmail.com>,
 <bjorn@kernel.org>, <puranjay@kernel.org>, <eddyz87@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 <alex@ghiti.fr>, <luke.r.nels@gmail.com>, <xi.wang@gmail.com>,
 <shuah@kernel.org>, <rgbi3307@gmail.com>, <guoren@kernel.org>,
 <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 0/3] riscv: bpf: Add BPF private stack
 support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Pu Lehui" <pulehui@huawei.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>
In-Reply-To: <6f594d21-f5c5-4224-b4ff-04ba3183a414@huawei.com>
References: <20261106181558.1564-1-cp0613@linux.alibaba.com> <6f594d21-f5c5-4224-b4ff-04ba3183a414@huawei.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 22, 2026 at 11:46 PM Pu Lehui <pulehui@huawei.com> wrote:
> Gentle ping on this series -- it looks good to me and bpf selftests pass
> on RV64. Some upcoming patches will conflict with these changes, so it
> would be helpful to get this applied first.

Sorry for delay,
please rebase and resend.
