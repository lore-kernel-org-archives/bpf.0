Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539A37E30D
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 04:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597166; cv=none; b=MgPrTt0ll6WMxwReQe84SHyiVbmlsYaru/0/yLM/xLtokUSAKOsDHueX6SujXteR0wAuxQq1t8mJ/es6d4qXkztVww4akdspEV9nDVwNukCCAahKxALkzfCjXUHTrqromq1PjG/xCs+tCxz/PSX78+AiLw5TD/5JLGfQqZNjOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597166; c=relaxed/simple;
	bh=E3yOXFpHFMVo1rQzne+t2fIYKkJ6q3EsFjm9i4zgg9Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O2VZzUVPHy8R8K1N5nyrGf9jEr8HFUxK+jBpkJLb/qA8SIqrvbKEKMm5tzN7qSZlPh1TpInt8ar/WKTdiyG5vMEIahJp0SeVKzLWk9k6OpPv6oZ5z+XjLWRtamDs+WCD/+w3EKnrwr7+cLwzsZRujVsq1pGYIGbaQzlVGIrm2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679862e4413so107690618eaf.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 20:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772597164; x=1773201964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojGB38lgnWdZk41nYibXtYMqngkgjRaH3FwY1gAyu8g=;
        b=lxfM5NlBcHtKO8hbazMXwLK6LionPJGfrhKgC7FyE9fal+w3VpD6uCXrfqpIdAAkxp
         jfClI5lNn5Y2U2xa/KJsmADPRslBKig+9WAD0Tk5r9nRpMXHXYDczAud9d1ivmcmU90R
         W7NBUrc9CQ4DitPA+BRTEw+nJqiAktdTT8g8+bkbOh0RK5Z1B6RJffctxsVc/0Yc7Vk2
         cMtg0PDB+Y+kEvtfEI3KKQ9x2kxBK+FMK7IZTfGp1+BE4sJ+1LZ1dQX4PZI9QqlTdYg2
         PNU/P9U83hdnxFb+lGbnUxxqtzb6R4VX5egvJO+czVbPJlIqIKeXnd43VCBB7Gi3uwAI
         kXtA==
X-Forwarded-Encrypted: i=1; AJvYcCXmCikzp/MvlG3zHDw0ePE+GCxAG97gpAxqocnfdUEA8kpHrh8L8cJ+70NMPgPub3rciuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3S33LD8JL40vwX/L+d82N0wli3TSJmXHaRPjbhi3TxGEEFAak
	khFXcX3WYe4OQQ0/ss7TICzlTjwx46w3kRKxe9hVWPy1iYrbhJ8yhjtfGYzSmk9TcHKf3+tC5C0
	NqIv5xEY2DUBTaKJ/rwJFN5HOaEsNaZWdcjutP/A5CfDxtsfJdZe21m6D7BI=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1795:b0:679:9873:5e86 with SMTP id
 006d021491bc7-67b1e90f718mr518319eaf.61.1772597164625; Tue, 03 Mar 2026
 20:06:04 -0800 (PST)
Date: Tue, 03 Mar 2026 20:06:04 -0800
In-Reply-To: <20260304033822.107697-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a7afac.a70a0220.135158.000f.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run9
From: syzbot <syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	wangqing7171@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
Tested-by: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com

Tested on:

commit:         0031c068 Merge tag 'cgroup-for-7.0-rc2-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1434f0ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=b4c5ad098c821bf8d8bc
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e5bb5a580000

Note: testing is done by a robot and is best-effort only.
