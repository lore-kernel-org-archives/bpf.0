Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0B1534E4
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571525; cv=none; b=k1ZSPQyTmqz9u+0GnCaMPOuiU6kJFHelPDKFw+Igq2Mk9bIL7Gok3ILAUTvTtO5DsSLOAunIyg/wpZUKlkzuRUyZokkInm052lkW+2MzPVvgsQ10VxpAhoQ4tEh6dyxfRy1/f74gqe1s4f1/I9hhgE4vZz3pygUyrHLsRqs9MO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571525; c=relaxed/simple;
	bh=nRwlE/hA+5kIdWWS/56V+tZqn6E78CxeZd1m1w7AwQ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NUY4uuF0lEdO8fVCjiGETWHWrZHZOYCxNFenEISyGoH2qdbl/zoqbO5CjCy6wNhgbW5DHm0J3NFRMrCMtc4x60+u+RzK3tvvG+HsFzu6q9lrCQfrlrJxatIiG7EJka+J3OXvWFZRkTQvAboqJ3MAfgZnC8L4dmAUlYD6DExhmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c88a694b46so20704539f.1
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 13:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711571523; x=1712176323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrIQKBS2v/d7YU14An08GRjqL5ZRUdHZeXnpNFfQdUk=;
        b=ZoSt/RmC2L7tCXTwytyTeW33V6zX1VY3Ll+FvneFeGCrSMqyE+0sOAN/P57VOnpbqF
         miXI5ZjHYQbtV9D6T4QNnpyfl/f5+yMCSgSkONPFwNt3vF1fhmuwoGM9iTUxUJX0OYl9
         w4S0tG+NIYZ/7MTlb4eEaqTbtXmhLIxAIcTEm3sM0jT7Hw7Bu6Z7KWZ62VATPMM+43Vb
         tg1VfQk1uAgVvZpuU4b+gDIWXF3ENNUHngpOkFRpUwHhEHL7+a7UYYlRimenAsbI00AC
         9/DyWtYGZD7YbPq044PbpB3/NS9qpwvpLHiob5JHp0OC9txuGRsCor+NZDTsuHuAPHD/
         HxHA==
X-Forwarded-Encrypted: i=1; AJvYcCUDh3CiKJKXaSZr5vKh4u86VBhKPAne2Spq9SMHVAikAKYIKTUeIzsP97ey2B/KTx5plwpSw5OdWH1B099H/UAcRNAf
X-Gm-Message-State: AOJu0Yw+mLWxnYMQ+lz1orC7VL+Q7uZ7oS3hmXVnyK6+IWEB5uZKffhy
	ua2PPcb0dSks/0sSJh4grgMYI+WQ9HW0rV49fEarSDHBFGjN9nxuG8Fr8CMKECD2+tCL1F3LnDU
	e9o0w+sZBIreqkLoBzLQyHQRmiqOKrI96OAhYc9pszQ8jL3zYzHr4v0o=
X-Google-Smtp-Source: AGHT+IEv1GS0F1bIQIoueTKC7US/um1YmwFLw785Q/O0DHu40YUikpwnw4dFaz1J6Vc+zuxa3ZZur/MOvmSybjnXmQSPHjqMWXYb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d81:b0:7c8:c7ec:2b71 with SMTP id
 k1-20020a0566022d8100b007c8c7ec2b71mr4702iow.3.1711571523139; Wed, 27 Mar
 2024 13:32:03 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:32:03 -0700
In-Reply-To: <87le63bfuf.fsf@cloudflare.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a50cbd0614aa4ceb@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
From: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d4066896495db380182e@syzkaller.appspotmail.com

Tested on:

commit:         4dd65107 bpf: update BPF LSM designated reviewer list
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=116d23e6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5826764df8e788a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d4066896495db380182e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1593c145180000

Note: testing is done by a robot and is best-effort only.
