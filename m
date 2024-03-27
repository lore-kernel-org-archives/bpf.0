Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706F12F376
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549525; cv=none; b=MXjntAco9l9naQbW6u3+GUQPXigTMlO10cpMRSD6ouOtQlks9qMAwgJbj1VXpa+fBGl0ndEbv1avyVTfnosXKlgaao21BRZmdTVLelvHSFHATvlalcch+I7L2eqSelQbGAtdQiBjX7u0kvVifCdktsrIi12qTTDmTRnWhBdb6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549525; c=relaxed/simple;
	bh=tc99LQ8/bN2jng+sFvmWcqITHA+NqPWXNfa4bVPy7O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qt0mRgboWRadzMdNf10JlK2Texm1M3mQeqU8vzxBoZ4uBQle4zhmU7qCWR6y8FKGp1kAVNMD6S/ZzFYTt+IY3mxuDTi1KyjGqcYM60YonK/lyF6iwy2jGGNU6d4pv2pzkzR/W9L5v445ajNNYOjnM6u7xmNccqYQynBFtFgZUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42REPEUa015043;
	Wed, 27 Mar 2024 23:25:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Wed, 27 Mar 2024 23:25:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42REPEED015040
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 23:25:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <895193c7-1339-45b3-99fa-6fc804040a3c@I-love.SAKURA.ne.jp>
Date: Wed, 27 Mar 2024 23:25:14 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <000000000000e40a2906072e9567@google.com>
 <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
 <CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com>
 <596aad11-ee69-4ef1-b945-7b67a9fb22d7@I-love.SAKURA.ne.jp>
 <CAADnVQL6Q3k0+-5X3Xjov7W_xESxkmVXcsCxQRWitQvhTBsf7A@mail.gmail.com>
 <dd264bf7-821b-4cf4-802b-60ae3c7b83bd@I-love.SAKURA.ne.jp>
 <CAADnVQJt+aP=Zo4edCu4iQEmdQjiruR1pJn0qyZZboNym+zd0w@mail.gmail.com>
 <87o7b0szno.fsf@jogness.linutronix.de>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87o7b0szno.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/27 20:05, John Ogness wrote:
> The printk rework (which is not yet fully mainline) will correctly
> handle this context.
> 
> As to the patch [0] you suggested, it would be more appropriate to
> perform deferred_enter/_exit *within* the locked critical section. But
> we really only want these whack-a-mole workarounds for cases that can
> occur in a non-bug situation. IMHO this is not such a case and falls
> into the category of "known problem, the rework will handle it".
> 
> John Ogness
> 
> [0] https://syzkaller.appspot.com/text?tag=Patch&x=121c92fe180000
> 

Since the cause of current flood of lockdep reports is already explained
in https://syzkaller.appspot.com/bug?extid=c4f4d25859c2e5859988 , we don't
need [0] for now. But it is unfortunate that the message which explains
what went wrong cannot be reported due to reporting console_lock dependency.
Therefore, I intend [0] as a workaround for a bug situation. We can revert [0]
after the printk rework completed.

