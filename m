Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8A221FB6
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774041; cv=none; b=WsLgV9stzmSPxcGDqVvapEBYOxX+PSJ/L+GnxhgIBmfIA7+H9TLfu2ukfnABPNpTtB5Grtv8pwt3bjCb2GJQsVSQ6qKYs60xnur7BzYhi+i2rylyFIpgip7jI54MFqFczVkcXKRYmAzND9J79hK8Mn3wWjc+AkH+wuZ9KYWAfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774041; c=relaxed/simple;
	bh=2Kcr2lEJRIS+Yq6aDi8qN9XogTTh/ToNZ+21H2cfJJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmDqm5RY2slqy+Wzp76zUs8ERKtpZC9+1G6R0GVRFD36lhoxTEhi/wZnaX00mGCVnD/QceX+8Qcq1nz6KgeoUm2bdBAOYmjKsoeFpG/vh8nJTldhD/Q9TQrNcXbfkTPtiCyEPYqHh3ZobDKzkOU7Oah5OCe6H3OKkfCFi633aB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=f1VSA8dB; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="f1VSA8dB"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ef5776530bso351556785a.0
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777774039; x=1778378839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2F3DN6wiiB7iU2Xt5hwtqlQ5YfweZqx1JbBrqimlAs8=;
        b=f1VSA8dBwfFLwd/ytqc4l7vH+LqReYyAbTzJ1V2uQJj1H2372Zs1uj8leoGjOU3JV7
         +tvSdh0VmDnjGmYvmqYt6Tsv/neN3j4vWkuwcWooMG/dJW4qYE9ToH6R1MUIYRzgJu5y
         FEHbwM9A2CbcPDTLuVPA1l1r9si4z7kHrr+lVGZGGCbFYo3j4QPL2bc4YJNtWqjlVj5m
         O5EtKayL6IOmnNNGmMEm5v0ehOb4rz01yJThPnVsQ9supN3X5s/JIk93uX8IGEF9BTD/
         NAhxY+hY8Q4cp/31nTPYQYIJHdfbzytiuoO18w0Tc1eUz04Z6CexblhuXv1ZK17/IY4i
         cHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777774039; x=1778378839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2F3DN6wiiB7iU2Xt5hwtqlQ5YfweZqx1JbBrqimlAs8=;
        b=BpAvMgjwM1RWwr7km2Vxqtl+CXoMUpZ0KWDUzZcdKzyowIm3d/5G7pSuCXmRIHwj87
         IrCu1AqjNPKqRhc6wz9MNPWd7gTKGCEPIdSc4Rgm21/j1gEkeh9zOXHCgKr9z+mZicNV
         QFb3c4cz2uj4OFwXDsTTPA0DskC3248vI3TF3MrkGdqT7Mk3NzSNr1RqRbVVk6mq7O9J
         M9/RvKqevd8FTfe6aFnanRdMB4KAL6pRPkdPyoCMEK8YLDK7dJcY6SG/yHuuZitys/lK
         YBfzps6RQ02aGvVHawq6Ks59rOikd1H7d07qAf7oExjcecX7pTfL8g+RaCd9m8E9J9TY
         M3xA==
X-Forwarded-Encrypted: i=1; AFNElJ+idSVSd+lCXXP3asKgrmgzcM3uyYoUBrOLHikZ7rM4XU/AVA9ygx5+B1WP/nhb/lF8HkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yP7pCLsKqG2hGDu6rd8zTGr9h9ZyoiyicyLC44pg0mn/ofMk
	zkani9c3Ee8bBUS+3dH97iYS7XjZ0eno8HMlnVWBvwRrb7qGlUw+s/kRraybbicpUmw=
X-Gm-Gg: AeBDieuvmLIClwdlUOoDvDyvN6i7qqW8jx/UwyTByV0riA9CBqs3pu5XMt81PGSZ3Pn
	hyCnPyFYYiDWoGGJo0wCwxAJ00FCuzAkJmb3MnJNYfC6YmClm5YhegxMSwqYcpJAFkFbaZZauRv
	bzy6pBM27sWtwmLT3e+l/piqCukkNRmrWqrFQ/XuDHF3JYkeLCaV/SBhs7Aui2JTWpUt6kkjjKk
	stLr6U9oy6B31GUzQdFhhNITzT6uWKcRMhLU9h0RicPind/UV3NTQxCpZTa8MCjW9kew9suHX5t
	krNXbBUR/i26ZMzOyLkFL4WV4ayuXVSFvHJzycnhO3PFhuBzhCZD3JpnU63nu1a/5kIg0VAH0Xj
	EOw+6EJKdUG21xxjR3Vw16ZBT68UPBz/9r2V65fuvDniwHe7O0cIRE8PKANILSQAhQLUxZaG6Wj
	wUMwBY1/Nt6jj3v1D790KyIm4NZ/eUXeqm4sVt9EC+yduw9x4bQFW/0DjkDEeFWfk8lBNA6cLxj
	nLEEDwh6JPb
X-Received: by 2002:a05:620a:6914:b0:8ee:cbf0:8311 with SMTP id af79cd13be357-8fd18337fcamr755624485a.54.1777774038660;
        Sat, 02 May 2026 19:07:18 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29889603sm636397485a.11.2026.05.02.19.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 19:07:18 -0700 (PDT)
Message-ID: <e39b710e-c742-4485-8798-7e27bf15e0ac@riscstar.com>
Date: Sat, 2 May 2026 21:07:14 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/12] net: enable TC956x support
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com,
 chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com,
 john.fastabend@gmail.com, julianbraha@gmail.com, livelycarpet87@gmail.com,
 matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260502094712.69b29dc8@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502094712.69b29dc8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 11:47 AM, Jakub Kicinski wrote:
> On Fri,  1 May 2026 10:54:08 -0500 Alex Elder wrote:
>>   create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>>   create mode 100644 drivers/gpio/gpio-tc956x.c
>>   create mode 100644 drivers/misc/tc956x_pci.c
>>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>>   create mode 100644 drivers/net/pcs/pcs-xpcs-regmap.c
>>   create mode 100644 include/linux/pcs/pcs-xpcs-regmap.h
>>   create mode 100644 include/soc/toshiba/tc956x-dwmac.h
> 
> Please add an entry to MAITNAINERS for tx956x stuff?

OK, I'll do that for the next version of the series.  Thanks.

					-Alex
