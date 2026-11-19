Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048899;
	b=ywEujBVDr4Y7yuMSO06Dy1FtjSHEsopxSDX4/sTbHvq4/JPUCNlsrQRfgqL2lv0S5dmX
	 h0YCZYXNUgSdnJo9+VAsH/LTEv3c2kpoko541wUFxYiRf5TjswFan2scU018KA9mO7TKo
	 EQxcRWMbUNl787OItXlyhZqJi/DjmtjqBLC3qi1OJq35f1dV8OSTIyM52QzctmAOPrQDA
	 s36zMj990VHYqRHeQrne684B5EttrdnYkBm/IUt0Gb+4ZZlL8CUeDOGLar+M5t6nVlXsD
	 5c9hyIuLC/SAZsYp0jBK2TaHJ/GAHPR+RwBrktjlKFN3vVAxoxCmnPi+LhqCqn5pZlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hvBatQBYMyCCrwFYx6ixL2SoWI3yMG92pdP59Av2nhY=;
	b=UJA8LnVhKhuR5Lf6C+aAs8B3S7fU949qJ9Cndhe918qcGhf/+qXnI/fLOMgDXaRNArOl
	 LwK74twGSC1pFH2c6bSnkWPLvDF70peUNOM0OSneIJ4k0dBE3lM4gx3ggrT2bbRnGJpg6
	 TLri5LqXuhKiRsu+35Zqis2tDpwRro4hpV4heqAWGZkfOTCNyZorZC5vdC0vVr6+LLBD1
	 B2kFbLI0hl76Q8LYq//O95RCWMTiRCLR/1OrRCd5s32l8Se3eHQbsnM4PpRI6XAO2GNl2
	 DICJz+sp+rfRwYxXoSae1beLg2DIEVCQW2ceBO7szhuFVnklgGAOSPRA7HQP8Ttiw7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOb+xqyL;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E10606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 00:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E10606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOb+xqyL
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c505a0acbc1so37955066b.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048897; x=1795653697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hvBatQBYMyCCrwFYx6ixL2SoWI3yMG92pdP59Av2nhY=;
        b=GOb+xqyLz68ulwX34svmLuibUnhYeJMs1CyRXVUiqptI/WC/pbUF7RIT3eSlVHgdVx
         bboW1nx1d1MzTPJLg8vDngDHQ+uH48Z46LoaHcNovFnEGEFip+CUPxlOzcZERklA2/OL
         nXE/VultkctCKfo21K2EbImQT6/aamY0EuvGAnk6Bjt9YVRE1Aq+v3FJyl+tgbUOB85o
         voyZUA9FKUClvOI9597Kux2e+uN/ghvWdtZTbb8pS7NulrYMpcAtY36GF3Y/ZbfSw3KL
         6rG4gSASL+/We76JNOwN4vn8qlzKOeE3Qu03obXV4OfaOeVrY99ts9oxYJfEJUzdO66a
         LsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048897; x=1795653697;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hvBatQBYMyCCrwFYx6ixL2SoWI3yMG92pdP59Av2nhY=;
        b=m5KSV8Msf/SwOVSE0tv0h3VeuR0W58gmcIqOdGLxOsPS3UsllcjSJLXLC4VXeID7z7
         WVOohUJx5JH9RAHBsu8QlAkAFXnI6z/UW0aCHQIPE9dsSalYNeXyUfeCp8GqhLLKUPb2
         I0tYnlNFvIjNRs97Iqaa7sZFzWfGNUUcEesdLT+6uYt8EgIpmS+2XxF0M+ocniJ4OOQx
         mqvoJCMAHvjpLd5BVnzcKLHtZZObpT0ZGjVp0C/n7Cn5j6D7c5LLVrv+KeRZk82oAlaN
         RBg8a/azZcyV6RHEFfHi/OH43VB07Z2iAVy+r8yqea3FuJZ7nwR5GCkBkDYgyTXOLeH+
         T8fw==
X-Forwarded-Encrypted: i=1; AL+hErGqB1z1BQ0FkJ4N1IVcYxuG3gR9x36jLQfqIb3vxFWOA0kUW2vus2XbA/MIpXPmCyfZZzk=@vger.kernel.org
X-Gm-Message-State: APuU4Z80JiI2u0dBc2nIUzFB6daYOfBISw8FquDPOnZCppb1T0wW3Vbi
	kil75kOlAhXEenNQAKY1CE2KinSlUP6idOrtJDMTSy0R+22xxuZcV5Hr
X-Gm-Gg: AYBFou1h07ZPfu9QHVr0slEDAb0QIfxclGt36n2OkR1Zn9EP6EdeN8u59orAxNXcTH3
	RSW/p7jnRlzmkkCMUs1WdMKCn12HQA3HmAS1aDDdu3HgMTQzgh3o2e+Jqa/q+wgTsfX5xbWkK0I
	wd6kicdx9jPb59a79/pcKvBSbN1VOqRyHf4+RpAKhQffnaNue+FWmUUp3KNyP0nvW3ARPhOqJ8f
	rV3kSlilgtrPIa3DdWTQxUaiyXuPkn72GEI7Ll73/4US6E9PZ+sw0nfHxSdvq6/GmxYPk3G5KrY
	p7VLmCffy1ZvDn11iCaOk6p8B0IUWOYAfadoQercAdkUT/iTgKhjDdHmCtT60OoN8N/oVK4Dh0y
	YpM0Wu1Y85VDa2VxWiSlnIBE8ynmZ7sEuW5wDY+/S+U0ZnfBH60LZ3UONGIeCRN5aPOrOmWaxSl
	Clbx2u8uHXwoLaefTqqEuF8gve1SCEE8houWvLyESBqmmUCabe1BMsyKYgz91Ggj6RSb7qh2wE9
	pW+uAUEV2D8gzg8di5jmBjPXM4QX+hloJ87JeKUY32KCpowdPzidTqxeC99qzBGOYKCWVLqNTyx
	y01KfTuVKx27ZEZpODHCN/PJLh5qu7l1WB1yjkW1jDsJhcAE2HM=
X-Received: by 2002:a17:906:2a12:b0:c51:269e:5c7b with SMTP id a640c23a62f3a-c51269e6306mr85283766b.4.1795048896973;
        Wed, 18 Nov 2026 16:41:36 -0800 (PST)
Received: from Nuel20.localdomain ([105.118.74.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51234d2159sm52803766b.78.2026.11.18.16.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:41:36 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org,
	tianyi@cloudflare.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	emmaonana18@gmail.com
Subject: Re: [PATCH net v2] selftests: net: veth: propagate channel-check failures to exit status
Date: Thu, 19 Nov 2026 01:40:56 +0100
Message-ID: <20261119004117.41043-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179486580141.3136.15559598598860423821@kernel.org>
References: <179486580141.3136.15559598598860423821@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

On Mon, 16 Nov 2026 21:50:01 +0000 netdev-bot+sashiko wrote:
> - [High] The fix is incomplete.

Legitimate, and already addressed: the three bad-setting checks
gained ret=1 in v3 [2/2] (also spotted by Tianyi during review),
restyled to if/else in v4 [2/2].

> - [Medium] Because chk_channels() now sets ret=1, the "setting
>   invalid channels nr" check at
>   tools/testing/selftests/net/veth.sh:467-468…

Good catch. Fixed by [3/3] in v4,
which attempts max_tx + 1 from the kernel-reported maximum
instead of nproc + 1.

pw-bot: cr
