Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412A79DF
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711868044; cv=none; b=rD5jWQpKb8laCugWJ4LPK987l4k3EPcIosn1FUlGwIPJlVc1fGM5OHHVH92STDgNCDgYc7A1LSVHf77AAYh+PMf4QY7A5DOPBgihxt6mhBxxfgrTj917GqY0TwiNnVmil9FWLejSX6tNVERc42uHGn+OguTOTlvEWdQIv7v1YHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711868044; c=relaxed/simple;
	bh=gAeHeDqDZlzLCVDs5UhPpbAlE8XS5q/x/XmievfiMQc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Od5getjjkCUD0luUTG1OVTs55Sz74MeU1K0Z0VhOMi5xE1XPe8zktO1DAqe9zf7IwpGbo0zkTLJegOvceis6/hJrMrNqckY+zWoWmIs7cYJlSZ2YDVOMMSZlpq/MUCY4oa2YkwhonX7/2hvXx5ralSmH/bikmquyaTsUmOUtjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-368a9314612so26428505ab.3
        for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 23:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711868042; x=1712472842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/c71aCLeNuSVucPluIJTLhL57W85nwTQ5r36sQit2EE=;
        b=q2NcMZUUMDjtltuY4AsWwCZEL/A/H7EFkejlE39VV9nBjTqqvmNFeUVNXOJo6SJaXw
         rKtEqRzuJD+jJEjZB30C6N+0sL1P1sWYKLFug319D6ABqGdLgrd4hq98x7g0wcr0mWZY
         kZDiXyGlQVXIEkxYpqWY+KkF/aAaKXqw0QMjz+glBLIMz8xZ/DiBlVIPYODmClWWnh6l
         79ycGwXEMsHnxKDCrfxlOXGqxjAglsVf6k3R3ogJ0c3A0vrYnRTJleg9TMmrP5YoIuwI
         +8H/26Y5NFZZqMq67u8gifIMKhclfMeM6N/NV6/7RxJwKzyEdUlWbtij20SSKmnRRHGQ
         m5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU7W+aHhjzFbyuzGsOx59wwe3FlrISisdVu8rAo0ewyughypw4YDUaRhzO3l4MWMniWRGzSTYM/8JxxbjPAI4uE4CTd
X-Gm-Message-State: AOJu0Yz84Gb/6SMDCCvWIX0o8MKE//VCcMsl494codpg0n6j9Wa+56us
	HEn+ULUhYEP11012A9s7PMu1OBTPDnXS8BkuD9JK3xRW5TUIiA21Wtkv8Zt0Zj+xPzZtG9U88+x
	lGmZo0kiZdA157GojkRtrnjhCWzL21a110XhUfifALDEffr/Re0mWOo8=
X-Google-Smtp-Source: AGHT+IHxEwKuH1DJmvaA6Sg9RrDUxGjxzJUVxMSc7LhNGfi59hnaBEgnkPN0IJT3LeUx0UnTNfMGs3HNY/FgPAl034VJ4Mxk85Vz
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe3:b0:369:98a3:6f9d with SMTP id
 dt3-20020a056e021fe300b0036998a36f9dmr100831ilb.4.1711868042346; Sat, 30 Mar
 2024 23:54:02 -0700 (PDT)
Date: Sat, 30 Mar 2024 23:54:02 -0700
In-Reply-To: <ZgkChGTru7cc3Nsv@pc636>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009116390614ef561f@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
From: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, urezki@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/rcu/tree.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7033999e Merge tag 'printk-for-6.9-rc2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa663a2100308ab6eab
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1406ae29180000

