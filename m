Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052985;
	b=HSxTsJoGo1yG8pTueH1YPjz11mPtes/7QesTsK8LwLVT4E3lWnkzbJTlJuk+Vpr9tfdK
	 vXtSHf50bH2pWMyxNo1boxkRHPTsEj9KM4iUHzoXjvF6YkyAYQFYRwLpLfe2/CiBQbP4X
	 LUGBeRhGbPUYUke9m6hfNNukKHDtYWYTci1PmYWhQkdrH8wu/XmYBReve3j2+7KakHUgZ
	 Idt4vchkoACHb1JkoK3vFy/7KWa8ukSRlVSfx56qNvxnntroXG1qhJ8e1GZPjR1VAjMUN
	 e/L+ovc05lcLPl2t0EK1awlEwwB2UvtII3h508jlTLhPE/cqoPDBmpXSwa1sOfuUWpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aiglJxDqvtN3JZZazny7hBMc8RmhFlbOGLZo5lpc8JU=;
	b=fE6pgZKloSNy51VgSKEzlKpXueU6FEmnJcCL5sk+G/f50nhjyZPaiEMZYAMMj8LjRsyI
	 sjnUfQCWXpMguAAfiKv9DdM+u004KMOsWAQizuAg+0XFX3xoK15P6DqOonY6FTVSEmeJw
	 yj6JXYN2sKHVDnfnSzJbiXOmsU9dgucxf0U22tjjGZen3McDqrGcditcbSoOAY8g3LHWM
	 7ax6we33vZmiupbe13LrM0AjMtfHr8gS87xpDUElKGqSA3++1PXz/U7eOxgE4vcN3TWZ+
	 7tY7GVn3arK3UFnfBl0zatxGj8Bp3IPZU3qBEgN48RHjbKhX0EqZTwNWawC9cJ53iFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vkiu6mw9;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572BA606A32C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 572BA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vkiu6mw9
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b904d10882so737650b3a.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795052985; x=1795657785; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aiglJxDqvtN3JZZazny7hBMc8RmhFlbOGLZo5lpc8JU=;
        b=vkiu6mw9bHVOs37FCJLumqFwCBMUFudfxWFKeBHS6X6Dyz6H5ynzoOVFfqe8Xt1Y0j
         P42Ia4rK/NnOtIsF/aNmriOf3tGhPIymHDUquSIex7eO8X8CfNXTYbF6I0vbohKRiP61
         emfv+1tHk9xvYlzvDeeSlLHFUEaO66flClBplwx88Y1CRuFUnYcK+TKNi/Lhd8GN17wQ
         DObXZfXz4qK6KcVg8aHLfxktgP9dr0Av3paXsq4VFjriLhg0ZSMS4TmSMnZfhtwy43+z
         0en+kQK1el1wSIzXfeKFloxq7PEN2FocAZ0E5QTGCq6wn4qTcNMt272rZvsaOAK4tdKp
         LyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052985; x=1795657785;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aiglJxDqvtN3JZZazny7hBMc8RmhFlbOGLZo5lpc8JU=;
        b=BIV2kGj878CP2lZIY8SCbWozH5W4v3kK2RVFrD58wedpElF9nk7aoXibaml6VdcMbt
         RF7+2EoAyB1vVz7uKJNSxdC5HXUHs1LtRr1dytZUJR5RxfC+X/DDaq70N5sTci63Yusv
         I7SqD2O2ROVX7F24Vx7ycQoeigNAQQGYnjLXeS8DTDXcLMIVeCQ7WfbDUwRQvDfp4LWB
         Lw+G60sZfxjYRIuVp0Vc3IL9llJVnMGTNN9eYRwZFlo8cE3Q7D2up+3l6agLttfqQmK4
         1zgBwIbPxh45ZdwnN/6tMe4IzRokuu+XjI93tVsK4uqxoegV5weadzpWrh6/YEJ2yTI1
         hkjg==
X-Gm-Message-State: APuU4Z9g9uypEGGNhWNVABQQQMBLcEx9sQvlcx0nhDx59N7FORQnlRpi
	SLK/9I/rXmoVK44sUe6w6DvzEaODqixqcrfserBjzSnV8CbcyX0+3J3N
X-Gm-Gg: AYBFou1apIeW0z1Lj3q5AcyVHVd0odm3tktlM2PS7zRG2HenwFlo07WkfrHhc7ejRyX
	5P9kRO84Nh2InsrLdmd3Z6Ruu+l5yChZ+W5t96aIILikOkqve99MfCLeAX7/aRSFyZIdAzq6r8n
	5NHyw7ZUXU2/AXqh0jirJzdzubV+RUAJhcspquo0Mm8STD4O2LA2YyWpYzAWZVWVeP4FnKBSb/G
	jjjXNN08mk0OMoL2aVIv32wZrBIQchHhPQv3Ev6+P4CjPFQW82vJ+cA8vMLGasvWSBZQu9n9CUr
	Od8hevyGnZNz+duGnFdIZj2FeeyyjLm7CWRXxm08qMaLfO7OgHM5ztDZI7xcp98vFco7TV/piSp
	cWthV/cDxLtFrdivienAWFqC8rQpZV5vh9BaP8/0zn8jqEPW7+JFMazrQW6mv6e+J4R+GPvsDWC
	PzdOXWUoFvT+Wdg8UFVoAADApE3gmo7+po9wKMPZw4EclrlBMBYXtRXmds5JDVwvhRAsepBH0/z
	YRKR98/p8GxeWyXKAK8Z1LT8ANu8pMMfp0/5HY7bU/Ei3iJRV6RT62Jrtv+pb80Wlkd0aks0IJz
	pu+a/hHNL1M+VlgsNWhMF8YFENu8SY5ghv2ra5xg9GhAhYb78mxGSr6aGZVwC7eTRHUcCm2qnCd
	eA4iIA1Qk3Az7Y9aoJ1m8ooixChPGflxqw1QXPDKXUyM/KnX/NDir/oY=
X-Received: by 2002:a05:6a21:2d43:b0:3e0:ba43:3d3d with SMTP id adf61e73a8af0-3fe86ecfa2dmr4525393637.9.1795052984493;
        Wed, 18 Nov 2026 17:49:44 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca7aa769sm1951632b3a.18.2026.11.18.17.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:49:44 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:49:43 +0000
Message-Id: <DMYT6CELPKLL.3IH95CNKKXFUP@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Run all summarization freplace
 cases
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yun Lu" <luyun_611@163.com>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <daniel@iogearbox.net>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <shuah@kernel.org>
In-Reply-To: <20261118073309.125424-1-luyun_611@163.com>
References: <20261118073309.125424-1-luyun_611@163.com>
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

On Tue, Nov 17, 2026 at 11:33 PM Yun Lu <luyun_611@163.com> wrote:
> derive the group count from mains. This restores four packet-data
> cases and enables four sleepable-program cases.

The four sleepable cases will fail on arm64 and s390x.
Their targets have no __arg_ctx:

  int main_might_sleep(struct pt_regs *ctx)
  int main_does_not_sleep(struct pt_regs *ctx)

pw-bot: cr
