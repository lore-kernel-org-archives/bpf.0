Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B51B946
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113099; cv=none; b=eGiDcOYeWEw/t+DwLHqniusw4NDteaLt5HAN6r+z7u9D4e66av89pHgJHIEGPCK4yxClHuBOYVHvuH84a3PW2pDxyHw8ugwLq0xQWY8qbN/BXNsfuyQcLrTKN+X+Tiysll03kuolW65qJvMfpKhftNnCtDjGNfNC8m/BPLDlWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113099; c=relaxed/simple;
	bh=yVDHwItCqvQ6h4Dh5f6TDY+D+90Zty5vzz/BeQm88YI=;
	h=From:Mime-Version:Message-Id:Date:To:Subject:Content-Type; b=ZBIv8HPBganeo0N3CJC9QHdI0U8/ESzqqaPReP73e56L0v4krg/dncqT8bg+xs82XOJwTksghEsU6pMCsnSGzPIkGkB1dBLWVXVXndXZMZiTboRSNSnQozNsURWg9QNgNT4aNqJRgyBI4X5Hldt2bTk35ZISDuo6FMIc8pxQ7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=CP384dJY; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=CP384dJY; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCG5OS9P reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CP384dJY";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CP384dJY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCG5OS9P"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 269BDC151536
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 19:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712112620; bh=yVDHwItCqvQ6h4Dh5f6TDY+D+90Zty5vzz/BeQm88YI=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=CP384dJYCGm2rRA1odBqBwE/lptcfmg6UGKvGXVecojbHIPuPkipoAKffXtpV3Zwr
	 SDsm7khudMf/J2V1T3XqcLwOecVh/JUgMEJWUgY4B2AYMFJ1cufhIt1t3Yka9VDnD9
	 j1hWamW7VQ+Nv4ifwaTRGgXT1CFXyL6ug0dm0Gd4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Apr  2 19:50:20 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 04D6EC14F703;
	Tue,  2 Apr 2024 19:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712112620; bh=yVDHwItCqvQ6h4Dh5f6TDY+D+90Zty5vzz/BeQm88YI=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=CP384dJYCGm2rRA1odBqBwE/lptcfmg6UGKvGXVecojbHIPuPkipoAKffXtpV3Zwr
	 SDsm7khudMf/J2V1T3XqcLwOecVh/JUgMEJWUgY4B2AYMFJ1cufhIt1t3Yka9VDnD9
	 j1hWamW7VQ+Nv4ifwaTRGgXT1CFXyL6ug0dm0Gd4=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 222A2C14F6F4
 for <bpf@ietfa.amsl.com>; Tue,  2 Apr 2024 19:50:19 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YoQ1bihIMaIY for <bpf@ietfa.amsl.com>;
 Tue,  2 Apr 2024 19:50:14 -0700 (PDT)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D5360C14F703
 for <bpf@ietf.org>; Tue,  2 Apr 2024 19:50:14 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-615038fc5baso22365477b3.3
 for <bpf@ietf.org>; Tue, 02 Apr 2024 19:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712112613; x=1712717413; darn=ietf.org;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=esQujNotzpB4+xsRiLk5kIgcIfES7Y96ccLY2u3mHDU=;
 b=iCG5OS9PkRkcabzTe/vyDaectIJO897vXboB1uQCntGzrJNZfI7m/jlFCnZwGflr+F
 08FmAmiu1auPFdZGTmpEky43D6aCC7wJ/Pce9F6dFBHpTl5rl6AR+4eR/TVtjk+wW7kZ
 TgtFcFKWvFFSlYru4P1xTnteb/EuH0RI4IdYTXSn7+VptQiS1pgsLthhSJYhXXtkqbdZ
 ymHWi9g8b8R8+jM596x5iDAIVBlf3K0uJN2FglKfJfcx2KOAg3jZ81R+T4nvl8tQ5rI/
 cmzYsbhA7NWOzan2rKqi4uGegovgEmKD4CJhwPfYVDeqYJgQ7QqEBILfa2agLO/Ji2MG
 56Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712112613; x=1712717413;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=esQujNotzpB4+xsRiLk5kIgcIfES7Y96ccLY2u3mHDU=;
 b=CuDBuEyP2PdY6mvnxm2l20Ga9yj1ZJ8y+KyaVuUlejfkJf/O6mI0yzpUwsc9WT2BaC
 G4iztUJheQuVZBPzM5oMTb1TVrRFDtGNWRS6AjoBBNnCf8fFyRzztAJ58iNUxBJHkdpS
 AufXiN3j8VGKAWejOO2JmHyyW56scTi0nwfEriZqWN78JF4+gGysWn7ws6PixnCUxqQv
 ag+FmSoSgTTSvg9k2AkHu8KZSO88hDGy9NfL0tTQkkHA8w3m77zvi/+QjFSmwpHImhiX
 L1FQYDA7nnZmlimByOfMq9nemYRxvh89V7G9Jl73lcIag/H+3XKT6AnH+35/G+x5G6Qm
 U28A==
X-Gm-Message-State: AOJu0YzoEllZpV1Rn5fjT3tsPYCjMUk1CtnQr5hRRxHQ5tmhXG+FP7TL
 L9170IUlX2YmfULelvQ6qS/jeXpp4c6CajnshT6dNmPRAaGQgtNN8OKWk1vc
X-Google-Smtp-Source: AGHT+IHkGRhGvl7332WDpIeqltIN/HxtoWtFo1Q82rZOK5S8YBpWI1IyY83BfJqK+4eh5RL9eSTquw==
X-Received: by 2002:a0d:f9c5:0:b0:611:278d:fb80 with SMTP id
 j188-20020a0df9c5000000b00611278dfb80mr13731273ywf.8.1712112613171; 
 Tue, 02 Apr 2024 19:50:13 -0700 (PDT)
Received: from smtpclient.apple (45-19-110-76.lightspeed.tukrga.sbcglobal.net.
 [45.19.110.76]) by smtp.gmail.com with ESMTPSA id
 t8-20020a0dea08000000b006145009cce6sm693712ywe.8.2024.04.02.19.50.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Apr 2024 19:50:12 -0700 (PDT)
From: Suresh Krishnan <suresh.krishnan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Message-ID: <89A0EA46-36E7-4E01-BC91-D07307A2291C@gmail.com>
Date: Tue, 2 Apr 2024 22:50:02 -0400
To: bpf@ietf.org,
 bpf <bpf@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/9VIPvmEpNYBrNN8ef2UMsKp2n1Q>
Subject: [Bpf] Provisional registration procedure
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
Message-ID: <20240403025002.BkmUUPmWXIKrN85gz5ZIT0Ac4lLD1IKjlYE6kFWdt7A@z>

Hi all,
  At the recently concluded IETF119 bpf WG meeting, I had asked a question to Dave about the Provisional registrations for BPF instruction conformance groups. Section 5.1 of draft-ietf-bpf-isa-01 talks about Provisional registrations, but does not elaborate further. Specifically, I think it would be good to cover the following cases

* Do we allow conversions from Provisional to Permanent? If so how?
* Do Provisional registrations timeout after a while if they are not made Permanent?
* How do we remove Provisional registrations? Are the codepoints freed up?

I have opened an issue on the issue tracker for this at https://github.com/ietf-wg-bpf/ebpf-docs/issues/113 . Comments are welcome and greatly appreciated.

Thanks
Suresh
-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf
