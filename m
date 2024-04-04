Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D65647E
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215186; cv=none; b=XYG2YMo6OQlFa2Hxdb16/Xf+xA5joMm0bgbHfvp9VBbWxUBPmZfMH1HbNYBnqtwYrDBDKIB91vbcmOwQqZGtlgy4SPZJIKOV0T7/uCSkYDb9T1hiKL0/YGsmOpaVhGJNFgqAMVsOCZKBwq8R7fB6XIvS+uWPsyQ6nfpGfy1d/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215186; c=relaxed/simple;
	bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcsCtYVcog8Gv/9gLdpxJeszCrvo5rErAKd18bsGSsL4Cufe09l+oodARIGdOi7NGDiRu1HmzhNzmVCUJ8B8OjoKZEt1TwB/7lmpocrnpMBvrfTuWRHdGFbUSTyhOUEEZIBLxZT/JG0ytfCoOBBS/dTQpDrVakA9dLs5aJRfKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Hi4CzWSM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hi4CzWSM"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29c14800a7fso452295a91.2
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712215184; x=1712819984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
        b=Hi4CzWSMouNbTxluuPyfv2/tC/xpCNV0SFYOlnCMwfbIGtjvNIsNVJfTLhdeFEyRpZ
         +aMpsQaeXZBcAMcJWJyvRjW0tAWNvkZWkzDG2CQa4lwOwfLsuOi+MSL/wIuSRWWWiiWi
         ay4wtPx7r2eyexSZ94W5eCLjc8jLgZ63mJua3BVrHM1Nc3Zj6FcVWhfJ4qug+kKOA2Eu
         vBALYewB7BsTYI6CV1wkWq3XwCl+WRPN5WmBrvWO9kyaoDF/RLybvN3l7+Lcb/hOxTyZ
         B+K474R72OzhlDTPDnWOwm8cu6bHeewVlXbQt/qsAq/vjsM+XNPRChQDcTQ2b/83JgEq
         mdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215184; x=1712819984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
        b=KU5uHKjI4PWiVWP2sYuTOBF7/wY+vRbAtWbxyL3PrXdrOlF+Pnw/4RCZce3Hqcfbg4
         Biw7lZ1FsJAJRQmXsfS0uvoiTxKqqcne2zMKc8IsGzgcds6UGrBkHvFHZz0UTaGAOMqI
         V97cX++BgbKxTraoNv/7heZK+Q8bFdoxhE+3Xw3+9XnRabX/FklyBZeVUj2AuX/+Vz7k
         3DodxE7QH3L/jYQc5p4q6W/D78wkcyww8unrzyA0e0K0/ijG2uGaA1xhh6yI2hwmeotr
         A+pvu9wvrVhTJKUc/no28BPRH7ZySG1v0W0ocAE4Eb/dHS+39tkztWB2JKfyiml0F+Wp
         C7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCU2t7MsKME2Y6bH1xichHGJ/Z7GTqiDY9gxPokAs3K0TqUFW7Dr65Uf5eCUIpCEt5UGdv6VC1oq1zH0osW4y7Po27G2
X-Gm-Message-State: AOJu0YzaBZ3E6DQ5MEvuXPiyK2pyhsjBwYJf0UbcG6XC7GOgm85inUAx
	28iPsITbSafDy0VqLhOw6Sx10bx1JaUDS2LiLAd/82pdP6MoK21MOO7TKjCqpWaxxxkdvm7oudu
	ndd/bAxSnfXcI7uNUf49XpCzMDbUvyQj7odZb9g==
X-Google-Smtp-Source: AGHT+IE7hLc0KU41lfeyZ5mhDd+vhkeCDZ3N7EoxWcq+wVQbO1BvLZF5gwDyuYi3X5t/OVuCi8+zSSgKaqcO4KrwP94=
X-Received: by 2002:a17:90b:b07:b0:29d:fb03:48b0 with SMTP id
 bf7-20020a17090b0b0700b0029dfb0348b0mr1548139pjb.44.1712215184061; Thu, 04
 Apr 2024 00:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008fc7ca06153d5d30@google.com>
In-Reply-To: <0000000000008fc7ca06153d5d30@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 4 Apr 2024 09:19:32 +0200
Message-ID: <CAGn+7TWFGTrhwRfoPWdd52eZgym8+K-moLq5r0ubWDj_HxdHWg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in pit_timer_fn
To: syzbot <syzbot+2cd91b51c468ad5df25b@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem
