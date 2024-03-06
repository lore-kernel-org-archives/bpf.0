Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D51B94D
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764685; cv=none; b=BhqamMOz/RYo4w8D70DOVmAnI/cel9iP5zOPaQEcA5TsE6L9s8IVhSHqDVCOiRPp7MHYZbeFvgilBOvNSWy2rD1MOZIuKHwj2qsMT7Fmw0hz/J5OGX9g2eS3j3SYLfrwpQnSGbCo2tbDj1Z4dEkl5B+uA5t0BFr3zvmNxu9axZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764685; c=relaxed/simple;
	bh=aONfvMBLi+nGa8z5RQpjQsVQe9F1v8fIwL3IxZQZEyI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FZniR6yFuXjR9Bjy4qlsiO3WQ9+Ie1t5aGgoe7ooE4pt8tM4B6hGOe0agJzXjMRwUmC0Chs/4nDQs8P0OsLzhhOgx85D7QQ0FI3XC+r6PY3Ovwd9McYVsXm5o24F4atkz6q0LeZUfSeiJ2Blf/Y2wA7yKr6hRF7XRLbywFyhdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c83c53216bso32467639f.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 14:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764682; x=1710369482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQx8oyVkoBQfTgwpCDc5Joc1fA/0UhEcaF4wgBQJJZ8=;
        b=Lzep1/mvLPo3YNoVefHM35zgS//eIC3j0qwGo4VgFPXQ7t7uGW7WJwXurhsob4Lntc
         GCxKHRqKuIngKR6j0tZfZ/MjeAGDE1jfmhPYVyWh5z3C76Dipa73mMOZxo0l1b4OdH5X
         mbEh9FuI6nMcBX+JzqCx3VZChpXdHzBxe2RsFXPRRtJRAnHgh6Z8VINef5VTibc6jIJK
         cm5DGWgcBbszcldaTDlgelSKeMP27s/BCVyLMJAcw1Z3iPi7wkSnrIRbLNRN5/T4w+zm
         TKpwTFbTuilyYDhLh/PM2Pt++qCLuO8v3A3DxZXdbBApLMuxk0pqspVJ/sxffE/Xf4GO
         t7Uw==
X-Gm-Message-State: AOJu0YwU8eRoUaT9QbXEZtAv5aM57DPLtxtt1zt5faSeD4E1Kt/Nr/nV
	1i6oMfDsZe+9atEgW9b71naqcQST4hZ9U1NtSu/mKuZjf5AsMCuLrPdZvblMl5vbTOku6E5EmYi
	feOcITYsVxcLqpKLJGUT8PZJmpJA+9JS7F4fBSPPUB+TEV99KosCT+VmeOQ==
X-Google-Smtp-Source: AGHT+IGUeFlmZ563e7wj+Rf7wOdbVjqxtWnT0cqDf2LCScDa5TAdV8QLnpmJdPdM1DX82HvmD30tfAYPKrbIiXL+LIblSWlVilKs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2181:b0:474:c5e2:384c with SMTP id
 s1-20020a056638218100b00474c5e2384cmr727865jaj.4.1709764682541; Wed, 06 Mar
 2024 14:38:02 -0800 (PST)
Date: Wed, 06 Mar 2024 14:38:02 -0800
In-Reply-To: <0000000000000c439a05daa527cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d7cfe0613059c97@google.com>
Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in gc_worker (3)
From: syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, coreteam@netfilter.org, davem@davemloft.net, 
	dvyukov@google.com, edumazet@google.com, fw@strlen.de, gautamramk@gmail.com, 
	hdanton@sina.com, jhs@mojatatu.com, jiri@resnulli.us, kadlec@netfilter.org, 
	kuba@kernel.org, lesliemonis@gmail.com, linux-kernel@vger.kernel.org, 
	michal.kubiak@intel.com, mohitbhasi1998@gmail.com, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	paulmck@kernel.org, sdp.sachin@gmail.com, syzkaller-bugs@googlegroups.com, 
	tahiliani@nitk.edu.in, tglx@linutronix.de, vsaicharan1998@gmail.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 8c21ab1bae945686c602c5bfa4e3f3352c2452c5
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Aug 29 12:35:41 2023 +0000

    net/sched: fq_pie: avoid stalls in fq_pie_timer()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1338df0e180000
start commit:   d4a7ce642100 igc: Fix Kernel Panic during ndo_tx_timeout c..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1504b511a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bf931a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fq_pie: avoid stalls in fq_pie_timer()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
