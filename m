Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E727F4F5
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349244; cv=none; b=KXwL1ELY3cYBa/Ozd0AuczH+CSer3SpvUja9sklQ7LecFD1psVXaGnfp4R+tYPBXWAKDDoEQxBEvB7mjtIt0T0YpfSYUzccrGA+TX/bSlNBKitcvVJrDZyXi/MgNUpVg8bCxkJkk4MzLLC64/FoVmaiVR24OK4UH3ElgdB+rxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349244; c=relaxed/simple;
	bh=FGccconlS/lqLJQtEwD7wIomPE1kfVOSxWGYcx0WB2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdumhAojIKyd+desMQiL3U+ic3n8z8ubwMP5EVS+gsRozKY6vsXj12lv1uG0h5kuAU80D35lER9oFHxyEET0KJ7qpkMN6cr27pkylkm5ulUIZzlZLcxwOIACx4SE/LMd4GQeWUJ2Sztot6beYSCSuCfV+b+0U+Q3iDeMjheG9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJIUt1XD; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJIUt1XD"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-842848fd613so1750101b3a.3
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781349242; x=1781954042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGccconlS/lqLJQtEwD7wIomPE1kfVOSxWGYcx0WB2s=;
        b=fJIUt1XDAAQSS9StLxp32lv7gp7d1jMsILimhPi0x9/7JKwGNjqHBu9liv2OTOliKB
         bIaqo6bwEBppCSshY2pGddWCOt6zeN60in+z3O2dGE7Q9Y2ps8XeaxeecJ97XB0Ig8bA
         pRPI6LNujK051/Hz+EUpoVAz4x0Xquww9i+lpJmJfSDUZLxUAtU8kl0FyO8wBBjP6jjL
         NJO4Ml35+rddAa0ih0KW4/bpHp7onPKneHjoKin6fRTyDHgA4bWedXg1RcrqWMNiKiiC
         NFo0O/izc+iWniaONTPXGFeXi4+44bawYcbDJO16X+mDrNeOrWxpmbCaRBp2yo4TFHu1
         LLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781349242; x=1781954042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FGccconlS/lqLJQtEwD7wIomPE1kfVOSxWGYcx0WB2s=;
        b=qIe4dffl9NJOjioeA4Fqk6MW/AamTRIhNTbNCxe+DxduYrpEFMATle0p/rwiBMaojT
         WB9kBRxem2ReoTJDSfDzDkbuTGIzu83dlaQq0s737Wtkq5lttS9n7TIyohYV/rdr9Kul
         G06Xn+Va5K2JIJgJvrCfs6B9hESpAwa39OzWRITD5reBXs7/JJlMXl1+t5SmEmf/3Con
         iwlGUuJYvxFM+69PLRc/qz2AAjyrbvyLka6UEWrUm+JNxbCmqQjk7ew33t9fu5EBCEDY
         4NLFm72HCO3d+V4I+5jG0hmoOxmk3NIBazZSoSmwjpy3jg+6WCWCIUwUyYUR7JuRGLfk
         BLxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nZR06mQKt+O+KOdEdrcioFVX7NoVYJ9fi2DC8WxdFhM2vrzTCBaDrJaCXADqgy4U3RHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxthBHkjRT9HARdKRMmewCRNKMCV/0x/uVjM0aZGR9mgXWiDWyK
	iJM6tGAQrWpSVaPNGBB/exfurOfUI1ukzkWp0MfPDfSsBvnNVvz5XOGp
X-Gm-Gg: Acq92OFMbxHrGUD9RtOmArxY6EOIJjVxypKmLW/s5Lxd8jll6W0/rA3nkPEQj3kc0ZF
	sdisYNBghYk3aoDqBTPJZMx2EqyAZGM+xhJ/VeiQ8lifNsDs0gOEsv3L1ZhX7mwKKE3GVZyX+ww
	gDmeTONXmdaMpXcCECrCRUPolbEmYjfMg3F55jI/KNSvVajsGTwCM4VUyIZn1v91rnOR8yo4cfK
	8ZM49OpcZqukuFDqs3Xc++DvSff7Q7Hx/pd3I7G+9g+rDp/h/NUu0faSro3fB9y7LiEV0EfTw0d
	3gVS+OdfaISGld4Ioz+0HdikNUwEWG3EbJX89fUOQbHL7XXz3ImA3oNG/yF6Kqulx6v3woHMnKp
	AdSqXhv/4q/JVrRmH1adUxXqlwmZN7aC+DER8YbbInqRKHLajpjSmmcRZR0R2TG7qzECPI1JfS9
	HLzlfeC/WCdnG4mL+Gng==
X-Received: by 2002:a05:6a00:9514:b0:842:6fce:6171 with SMTP id d2e1a72fcca58-8434ce50e1amr6839535b3a.3.1781349242409;
        Sat, 13 Jun 2026 04:14:02 -0700 (PDT)
Received: from laptop ([175.204.13.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd100esm5663874b3a.34.2026.06.13.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 04:14:01 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Track spilled zero scalars for var-off stack reads
Date: Sat, 13 Jun 2026 20:13:58 +0900
Message-ID: <20260613111358.272079-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <76cf1da72418d905cfd52dc9e0efa7c37cf8ba76.camel@gmail.com>
References: <76cf1da72418d905cfd52dc9e0efa7c37cf8ba76.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 12, 2026 at 03:27:42PM -0700, Eduard Zingerman wrote:
> On Thu, 2026-06-11 at 19:11 +0900, Woojin Ji wrote:
> > mark_reg_stack_read() currently treats a variable-offset stack read as
> > known-zero only when every byte in the read range has STACK_ZERO type.

Thanks, I rebased the series onto the current bpf-next and split the
selftests into a separate second patch for v2.

Thanks,
Woojin
