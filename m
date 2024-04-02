Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158F57305
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048471; cv=none; b=fvYpyCw/SB5nM9JkTOXbVl1VpZ5RhElxwhiad3qQZcIRfujmu5+5+onxWRpw2+8BTjtGjCFCEHDsh1UUc39JL4qOIh2ljzmEfSXErJDgHLkQoy/LXjTz47vEuFfIAUb1iN4Pmebxv9I5eMTf0w38V/alTnq6rwkjRNKo9L47E8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048471; c=relaxed/simple;
	bh=pKFwtZTaqrc8nj4olYRMlSYneEQsyW5GpRxBrsnGAMc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=F7CSLxon2qktu8urYL+fAEVoPO8sUWH1HosOhSS0On+sed/wn9YLcngPtxVDTO6UxUPVL6IkK1J38GTK7RI0VP12pSApiuhcNFcYTO1AVYePKe+bTwa42K4IfUGuUPS9+PYa6zw3zRiTTZWIwJJbYeAgOq7ZhOmI0pA8nNg4rCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf092a502so521029639f.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 02:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048469; x=1712653269;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKFwtZTaqrc8nj4olYRMlSYneEQsyW5GpRxBrsnGAMc=;
        b=Akm1TKOWAabNK7B6YI2W/cQHk1vfIhGq7cbdkvDUzq62OmIP2rV9/U5K6PVZjNgM4s
         X+4ISkH1RTy5FxgMFlsZDoXPAuz4NFj10BE2V31mnDF85It+VoHUYdJ3RrIFYZJSfeAG
         7+PiRg9vjF5tA3cw3ew0gu2FpQRkxZKW/tLCKhWA0sB9Dj5SUHgtR/7isg57nxZFGDfk
         xyD+xjJtHNGRdTnWMs3Qe7slnd4IBO1srdP9u/AzicW25O0o+QLost7IjK7BGKTYQrR9
         7SESA+H2AMs4PW6xvWTCzkWSOtw3Qxuu2Lwq2MHoWT1HFwATe/jo6lPd04N40Cr5+c3Q
         MVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmiBGntb4UWZPl3MtKCdbw2FQQEB+/wGlMLZaqbt5WU/AOZoz4vmYtc1FoR4G3Tc1aX3qbKL/3E09mP2oMy52GGx65
X-Gm-Message-State: AOJu0YxCSFEoDJrLc6ekWqp+1DuS+41JlQsqj8U/WaqsurXpzBGkaJla
	BKs9r138KMptfcMM6q32sXmEVmKz5yqm3ZrNuYm4Dkm57cRlE/azJCY1a5pnLnFtBPLy6WHdj7P
	IOuMlgu+VMmBZ82wMLlOaYq68lKrg3OTKYcropCv9Ab9O+yx28zyb+p8=
X-Google-Smtp-Source: AGHT+IF8E3F4FXRMTBFfB6xAfwhi7CTp7Nr5gYOuq0JjZ2Z7aLBhtOaUiHvu9/q2yRiyU1L6TrbYLDtBs5pPYp8fhgcrHdH2nEc2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2109:b0:47e:c145:c770 with SMTP id
 n9-20020a056638210900b0047ec145c770mr816747jaj.6.1712048469733; Tue, 02 Apr
 2024 02:01:09 -0700 (PDT)
Date: Tue, 02 Apr 2024 02:01:09 -0700
In-Reply-To: <CAGn+7TXh4gzeQ3EktnYQ=TXO_LutRU8iSQ=VbBpPpVX=Cr_UEA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e086c706151958eb@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
From: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
To: jakub@cloudflare.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr

Can't dup bug to itself.

