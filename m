Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B41381D1
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917408; cv=none; b=T+KbiqVoUEJaincUZtufTkqFI1BqPHnjEVpZEPKWgRUf91a2u4SfqgaxKoT2MdmJ+NIfPjtAvcvMUoRkTMV9OZ4zY7V37gXFk/rxr+o3O4wCXIlJD9pw+YtYIq0JecxZnLoZFYRZznnmutAJkuvdiIFpr+mo+zUK06EcRwuPR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917408; c=relaxed/simple;
	bh=//3zWgFy2AqLTSr3DwKo1CdcWGf1L3AS2nPoVmnAlh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=bq6JXiWYVVsZJcm9X2m6newniiI85ejI+aDft+veaUZY+nxRM/0cZpNVEAeLDehmqxG9JKCljk4D16+VJo0vFwJ19FH2DttR4w3zkngs1CjkzBmEbrY3mnT6Oulhyg+Vs/ewiohX3rPKFbJyGmtX5jA55csDIGVoWqhe92VCme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42K6o3G8097265;
	Wed, 20 Mar 2024 15:50:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Wed, 20 Mar 2024 15:50:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42K6o2pu097261
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 20 Mar 2024 15:50:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
Date: Wed, 20 Mar 2024 15:50:02 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
Content-Language: en-US
To: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness
 <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <000000000000e40a2906072e9567@google.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000e40a2906072e9567@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, bpf developers.

syzbot is reporting circular locking dependency because bpf program is hitting
printk() path. To avoid this dependency, something like
https://syzkaller.appspot.com/text?tag=Patch&x=121c92fe180000 is needed.

Is it possible to call printk_deferred_{enter,exit}() from the bpf side (e.g.
bpf_prog_run()) so that we don't need to add overhead on the scheduler side
when bpf programs are not registered?

printk_deferred_{enter,exit}() requires that printk_deferred_exit() is called
on a CPU which printk_deferred_enter() was called, for percpu counter is used.
Is migrate_{disable,enable}() also needed around printk_deferred_{enter,exit}() ?

On 2023/10/08 15:28, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=172d36e9680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f532286be4fff4b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

