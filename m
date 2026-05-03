Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C134BA57
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777775026; cv=none; b=pf0zqrx/iyl+bbCNgqkR7hKPDOfVMz3RI3kArRMic2DfpVJOR6n10r5GFcTB8ODF9US6HZz5LQzJ5pm/gt8UTcuMjg12/x1AsAUxYcHrJteTaDp+6cbp8XfE722oFHIO8FQzS0B5TqIrTSySpL0oyyxeYTxPDmsoHekDbDns1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777775026; c=relaxed/simple;
	bh=Lg5HT63X6f+bfQfEb0j4Ta/UIv9kP8NkdsygInHEr8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3hP1Qajq/cHj+/wzn735zDRRyVWxQejXB6xEYYTuMds9tUGNA7m5meNcnKryr7hIJO6008vKcD7pQRgSJqyDdmi8dDzeTV2M03vRne3IooUTGquK2M3hVP+cx+r4CktO+trG6N6G0WGibHlOv7ukaKEq1De8ESmKhfuiAn8eoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ji7vaJUN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ji7vaJUN"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ef0ba61d46so344697585a.2
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 19:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777775021; x=1778379821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zleKM47mpduavdnaP2aBKf2rkXt6X2UG0Frna4ddag=;
        b=ji7vaJUNx8YA6RVhs3aqpTb63SpMMMPLRla8X/V3s+XeLyYphjnM0adNDT4UxthXTp
         MkUCfvMy5fLLgih1UjEJIxq76rmjCuA9grdaqcDs7TQjRziaGIwlXlw9S3NYoW1JbYUN
         WboMLBGy2zgG//HYSPoxzK/g8ZtbiegETnLHiaSFBKmCoCV4coD+n1ZD90NmRy2m9YSD
         P3v4YAd9CLAK5Yh9Cev86ckiGQSc0Rih+vHaZADNpEFMBlVDNchsh9KUPTW9iXbY3ujy
         yUVjoFhENNpwjeUUvmdSbj2Pu/R5ZQYlR2PZCx61FNTyX2sydH+RkzppPyF01a4eWOmO
         F68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777775021; x=1778379821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zleKM47mpduavdnaP2aBKf2rkXt6X2UG0Frna4ddag=;
        b=dEFnyAt4jQpgjsV5fWb5HzKHFmTdBUjZW54L0K+Iy6qKglQO1ElB21xWMqk9MRSdpp
         C8fGjFERtr6yARjkvd9rwvAadnP2pbPmK7Yep1carVFSUXG3lWOfTqzB0D5gEoc3KHga
         ECsDByC/PRyWTg2lMGrG+kbK9+kzpZGAijEXA7F0B67UPzBXqa4popxKtC3AJxTeyyvD
         KBakMY0PW3WBKnWIDc7IxSa4sbWgXF3o7t64RMPTpY3Ox9AkOZB9x2AMShrR7ulH6uFM
         lxgLN1wngVPapxSkUdty0eoZu772aEqU2JutERrKPTYPow1LZ0YsHVLajrSoC0+npcTT
         NFyg==
X-Forwarded-Encrypted: i=1; AFNElJ/9KZxuyI2xsUOdsc2yza2y8Vf2PbjoOk0jyO/SAQJAO7y43b1PqJ+67WKnraBGMZ7P5iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4/MRSxxPRvy2pljhrBm8upYXmqU9GfWY1v0OIFZFPgvI+7WT
	T6vU/bssdufMbxJegcraBVp8TspijYvBE7nMuMT3i3NMKwm4ZDTydHmUtQBciqYXs94=
X-Gm-Gg: AeBDieuIU4Zoxf8sP4wxDYSerNkbkZwMGj38jfTsp80iACHpLJYDb6/szVUSgVfoyXg
	mfCI7YM9bKxeITHrsapWtBQ028RuvA5ob5hY2O6OGwxdFkpvqgGP/zsR1BaFoPVlx1/H9w1UWQk
	i4AhqUn4retqE7fXRbWclSsiGXn8CLufBjJn15I3yI+O7adJmeFhT5grxoivz3NHzyOu49hWCYr
	S+YBXVDiqoIyB6vr9FUjm+jtQJ1Gpj3hTguZt6sg8Yh/gPwZY8lz+HJodYJ4v3jcu/wR7ARgY5q
	Or+wBTCSL4cl9P6RNu2m+SQg3RFJ3H3q9Oulxrqtp8ok6qaA/MBadeCq7ddiJ4xKF3ww5pk3gvC
	E41W8OqZrLMuXZad5QmD3sDcpT08tuIMH5QlYyqhe+vs/8XSM32SKo5AEoqGOI6HqardgdLZBjY
	RAjOYF0uxBcdkMLv9f4C11M/wl/3qQKUfEsmd0NYA+loqdVXGDHEa4SHh8VLXk2EmxkQR5II0q6
	g==
X-Received: by 2002:a05:620a:2a0f:b0:8cf:e946:bb56 with SMTP id af79cd13be357-8fd1833a52fmr796002985a.44.1777775021562;
        Sat, 02 May 2026 19:23:41 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c349572sm652634685a.28.2026.05.02.19.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 19:23:41 -0700 (PDT)
Message-ID: <5a8cde2d-2871-4f9a-be16-66c38005fd9e@riscstar.com>
Date: Sat, 2 May 2026 21:23:37 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] misc: tc956x_pci: add TC956x/QPS615
 support
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
 <20260501155421.3329862-12-elder@riscstar.com>
 <20260502094559.15c3f479@kernel.org>
 <649428a4-9505-4a1a-bbbe-bd90be9b8155@riscstar.com>
 <20260502191427.34048082@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502191427.34048082@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 9:14 PM, Jakub Kicinski wrote:
> On Sat, 2 May 2026 21:06:33 -0500 Alex Elder wrote:
>>> drivers/misc/tc956x_pci.c:541:17: error: call to undeclared function 'u32_get_bits'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>>     541 |         chip->rev_id = u32_get_bits(val, NCID_REV_ID_MASK);
>>>         |                        ^
>>
>> Yeah I think I noticed an error like that shows up with 32-bit builds?
>> In any case we didn't see it during development, and we'll make sure
>> <linux/bitfield.h> gets included.
> 
> on x86 it hits on all configs, I suspected you're building for ARM?

Yes.  I'll spend a little more time trying to build on other
architectures.  I normally like to add COMPILE_TEST.

					-Alex

