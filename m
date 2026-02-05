Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5D320A0C
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280203; cv=none; b=b9tGn8LVr0UsZg+XRbyI3m5fsV6k3Jrl71MnTdgB059OWbW/yRDxQ8CmrNrfLNRhZNZk2fKQk5NGB8UwtqaTaGr/4yL2dKII4lRziKuqkfeEjzmUMzoFznHL8xqCorfFRZWBLFUBiatSFj2DVJGxDV5BC0KLr9/QuoewVdV+J8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280203; c=relaxed/simple;
	bh=uMswa8QgyTDD4PSRzJyW7FHr5n7JVIst00rKkccJkbA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DjTJt2h9pcivB1UsoMRzQpvgInpHyCmoU/6j1jL9CZHbcg0Ycqz6Yf5mgODbU7Bb7dfDv9mbQ9cIlG09xgAkaRqRb8u7ByFP2Mc26KXcalHYMjX4GyTJJ0eRFLT8i/V8v4HNYatAsBEDtotj0FvRuR1Bg9sN1HfwnhC4G+XswcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4041710f90fso3095831fac.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 00:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770280202; x=1770885002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llRsHVUGZUWzlNHdbad61AK1n7j7FSs2B3eJju6Uw+Q=;
        b=YifdXQ7tq/ElPtgX1wPBajPMBVKfDLnKtrmEAwG7zNiSAxuGU5KEEJVQMNzUwtc9MZ
         UCUex87YAuniSk2A2OCeY+9IkyWNVET3Q+6Bm9FEe5JQaEtg0ieJchHb7izsrlSo6ln2
         J6YKuVFgwZVu8tQ8kRXbTSkQGaQ9AVUOACPmGKiO0hWDOwU8GCz8vXkqxIiNEj8wwAH6
         2i25TBa5xPT6ROeeRJkzJnLlJmgXw/QEk5/tO+H54CVUBHjEUr3Yx5ahanV44y9olGyo
         yNqxZXSsXdsu43ZvJ0VFU2AzpeuzkEdczXCdLKGEzxZUDyUaIA3SimVovkk569gqXBYs
         h0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWIQtlZuVBmZgkJoXG0oUobUAP+5RDt7VCGuncRwjDlTDFjRn+2C9Y4cwAE91sO99wcps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOZIQKcq9g/l1rxuIdo2HLPZ9jj8PrJV2vEiwXTEjGw5XG128
	vTlDMRY5K2eCJu574exQKfXjgDZZKE+lTaO0Pu3Zfpco7WEPkk9/JKuLnijlTosSx+vi7fD95wp
	knMwIsLVEVMy91YdE0Q9TCcPLgwZ1K62amRU1Q13GnUzfmvMEMXNJrG0xuOk=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1522:b0:663:f65:1c8b with SMTP id
 006d021491bc7-66a229794admr2711424eaf.51.1770280202384; Thu, 05 Feb 2026
 00:30:02 -0800 (PST)
Date: Thu, 05 Feb 2026 00:30:02 -0800
In-Reply-To: <CAGn_ityekaJpFNnaYHS==PcfDdeXY87w50s9VmeiN4r4EyD__g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6984550a.050a0220.3b3015.001b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: refcount bug in __add_used_btf
From: syzbot <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com>
To: a.s.protopopov@gmail.com, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com
Tested-by: syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com

Tested on:

commit:         ea7bf7f2 bpf: Fix a potential use-after-free
git tree:       https://github.com/aspsk/bpf-next.git fix-btf-refcount
console output: https://syzkaller.appspot.com/x/log.txt?x=150eda5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5a1ee0109784fc2
dashboard link: https://syzkaller.appspot.com/bug?extid=5a0f1995634f7c1dadbf
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
