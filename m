Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202871A681B
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777773999; cv=none; b=TCmaOFD1k+nBhoutkr5rGBLecE1zbWcm39Ar/+QH+CRanBl3YOGH91Kzu5kUKG4/KJ1OCwcdD9+z/pG4VbKfJ8RDBM9jNi7tAsQrpesl/ODRvpZBb+E8oTkAKIDLRmbeaPfTU5tGvbHsu1KK2XUGAAJblNE0xSZNu/+bJGvSqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777773999; c=relaxed/simple;
	bh=qSG0sZNcjOSchIbQqXWGt3+PH22qMGXJjEvLkAzwfr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojpU99stiw5Icjd4FKQ8BCNZt/gEFvgL1H7OctKr3F6JlTQuOVK2JtVCeRx1zlZmmzKO2wfUgbXsbP7BMJxUMHp9pbpj6jLC0VPhFQy5vvJ7g4n7oZ0qZRTE1HftGQwXtXb2Z0ss4mCCXtFbmtX4DiUGubf18ETqiJzwC2QmwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=btbRK1G5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="btbRK1G5"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8acb856a674so41141636d6.0
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 19:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777773997; x=1778378797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnVCaxNshzzHjwMMq5W7gN5QUApxgL+R58MdQlfO6d0=;
        b=btbRK1G5RFZ+SyUUfNLzRaZPSzJ9/mretRVTMuZqtyEjAHFRiP+elmVpqzKdwFaqZS
         K1JQ7VMuUx2eE/ACxjiOd+YQB4fYAaK9PnDYGMlwiGUrDK6iKy16aM7glSDXlcsYCWOZ
         pdbtAygj+OTRinuD4hOOpFFclJKItdPC3RSTp00eokz7QCw22sM+tDNGcxoBaZLAOhtK
         eqj3Xts+60lWyE4slvV5QZpOBupe5XgNG+mc8HgCjbk6Yr2dQSKb2kIxW1cJXnOmA5Ju
         KhhQFLAWheKe2R6mmsZjG0MV4EgsW40uo6+MK7clHHb50WVAqb6OEut8vo3Se8+IXAUi
         540w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777773997; x=1778378797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnVCaxNshzzHjwMMq5W7gN5QUApxgL+R58MdQlfO6d0=;
        b=fXz4ttQ8BWbhxe4nsLvQHcmCrR24+tMDSG3MLuwpIBHotxuzHhwLTmzg5vls3DbxLo
         9vgwrnSzEg/tUsb+oBOPXPfaZnztnHZEk1/ipEiKqyK/hqPe5cLanNZG6wTzdxTNy/60
         /WnJXlScRBSwVy//7CR3hJEcwjw3ga9V5pShwyFhIA07yK9c2W2RegrmSerW1kjUADkj
         E6KjbG5tdVjyM0wCXet0GBL/zU+tAVjhAAogJsOBpcsHam90iwgh3DXESY57O5Tjm73+
         8jbf3MDyO3g+RVBHl43rD4XfMpHa5Ajen2od/Ln8q3ipeR+WQsgUvBY9KLbhzIc+PAO8
         ennw==
X-Forwarded-Encrypted: i=1; AFNElJ+lok9vZ1c+Ctwqw6XfIGbWWR/duG10RCO7yp8tCFVDvarVIZlQ3TrRr7uBZ/hpZnzJnws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6z0IY5F7g13IWpoI4L+Z+RuNCi+6CobKaG7nDhJ3rWHXtYBP
	hH77I12q7uqP7GKfNY1jGxA0aa8KK44JO4qHAjwgP85iaTHm0mTH4WjEJKI7qFHqCT8=
X-Gm-Gg: AeBDiet/VILobsgBU9FIJfzXs2hFwDowJXhkPrzTHv3bT+IFyTyB8Y0bMrs4+auqOXf
	osMAHL1GqoY1lrFDSOJM1aggjJQKN9qIRdN9ejrw81nzQ9yDo3GvJdC9ODsa2BgDGhZJAQEK1Uw
	3TT7HqvBZP0dZSEobyf3Kkz+5n3B390nJrsEmiyc48+1t84rXK6qAjNmRoZYpGKpm1lCkgsJP2b
	x+LH0RlPblPHoLBPtM2TZJtsD3LsTonl+H/1NIbd5Kzj83Sm+S556fco+r6IrDVoCfr5JEvM7Fd
	Uzn54pwH8fZ9TwzrDl6gb4QBsGLiUp+mmZdzO+Bcjh0ATh7MEBdQb5ovODAJ6E5FZPKwz1hYxPL
	R90+wHVXOAm5HTpJGDN0a0cCQBl4lk3Qy/ONaG1giyEAWHvmsNsywiNIY4MBEZVgolso7vazC2E
	KIEHzU9qGY8JGrv+CMetlyLt2JOvaHz1MqJenAGE8JXCvwgo0WF9Z0Q68HI/NEhl5i3B69pGBIf
	Q==
X-Received: by 2002:a05:6214:610d:b0:89c:8a3c:e34f with SMTP id 6a1803df08f44-8b667b79753mr56665696d6.12.1777773997147;
        Sat, 02 May 2026 19:06:37 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831ac7sm72634806d6.49.2026.05.02.19.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 19:06:36 -0700 (PDT)
Message-ID: <649428a4-9505-4a1a-bbbe-bd90be9b8155@riscstar.com>
Date: Sat, 2 May 2026 21:06:33 -0500
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
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502094559.15c3f479@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 11:45 AM, Jakub Kicinski wrote:
> On Fri,  1 May 2026 10:54:19 -0500 Alex Elder wrote:
>> The Toshiba TC956x is an Ethernet AVB/TSN bridge,  and is
>> essentially a small and highly-specialized SoC.  It implements
>> a number of internal functions, including a GPIO controller,
>> control registers managing internal reset and clock control
>> signals, a PCIe switch and internal endpoint, and mapping
>> hardware that translates between PCIe and internal addressing.
> 
> drivers/misc/tc956x_pci.c:541:17: error: call to undeclared function 'u32_get_bits'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    541 |         chip->rev_id = u32_get_bits(val, NCID_REV_ID_MASK);
>        |                        ^

Yeah I think I noticed an error like that shows up with 32-bit builds?
In any case we didn't see it during development, and we'll make sure
<linux/bitfield.h> gets included.

Thanks.

					-Alex
