Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1BE3A7F71
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097593; cv=none; b=bGKhjyrGLUZlsIxFFvooA7z+4Q1esEs5n84z4/NUTw4j+CdYma+3ywG99QtShTuo8AOVUiLFaoQHmbfZZMy7GvqtvDl648z2WvcTJvR4nTPjorXU/j8sbdqFc/4vRO235p+tfMQ+lfyu1fDehT6LnQxNzUv1UPfhXU3dbwiDP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097593; c=relaxed/simple;
	bh=21aQJOFhI2LonnkW8Si/oPqv9ibWWLorXm2DMoEwoMQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tuF54WJT2QfuddpFo6xJ3+3gguOwR+QnqmCNdakldJvu7aH9V7XAZ/LoL2FqABWnvas12aS0crVPlt11hWMHVSXPVKh6oicGH86p6WFBlNeeYWHRlmWLzQIfLONXXRqkRFVvSot+0ckXF1YxVTveHVjDmKn8RPZ8JyRareTKxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d75b6b8500so2794579a34.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 16:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097591; x=1773702391;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=435H/3739RNFxfTuBVP7Isv8yqfcwocdWd+oqIvQCxo=;
        b=mEgErUlCcN+Mbk6AG+wfQmdjtUOpmU2R15lOGJ9PTnLn74PG0JLqcw3MaoAdZ1DrjK
         17G/ju0etJjJTSYMKNEEvmZZa2cJRCS80bUnw5yB4rkeRQ6T4rjIhUzfjO/ml8DNOsaH
         /eRJP+JkQK5w4HuZOHHf5Jq8568mXLnSkHHH85IyN0EAD0mfvjMssxQfzLub10HEuweW
         9lRnZ5QmY5p9GwxdEXbkLc2iEl4Cn3WX20/Df6eEAjJRJ0RPzKuzOwuV9C6JkEwHybg3
         Al2WwAbrj+/PlDNh0ib/jEPUbvb7xsK2lyw5G8E+cri5uiU5Np10QAHNu1jol5g3qAlu
         oqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr240ZI7TPNkq4kQFurSKzKM5fxD1UmKjLUhMw75pskT9LjsfRfq9e6OgrOwQsrncnllQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtBKcHbNRWXN17ho6IMMePAvrMbazRM8/vQA3oTfWdmWboAEW
	xCEkiD0jEemer0uvkJXbdd5zDCoCr3RroCfL1PDo7IBLuAEZSkYoG0oAwRd9Grg7x6VyNy+t7aq
	mIqkXKQk6GPtiq/V/hd0G2XENEZmmb+JWJ/T2jzyUaj8vvsjLrLc2uaZW5dA=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168a:b0:67b:bc25:2661 with SMTP id
 006d021491bc7-67bbc2532c7mr1048906eaf.27.1773097591114; Mon, 09 Mar 2026
 16:06:31 -0700 (PDT)
Date: Mon, 09 Mar 2026 16:06:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69af5277.a00a0220.b130.0019.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Mar 2026)
From: syzbot <syzbot+liste2c3cfac8f434c3230cd@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 3 new issues were detected and 5 were fixed.
In total, 25 issues are still open and 323 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 19578   Yes   WARNING in reg_bounds_sanity_check (2)
                  https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
<2> 2433    Yes   WARNING in trace_suspend_resume
                  https://syzkaller.appspot.com/bug?extid=99d4fec338b62b703891
<3> 241     No    KMSAN: uninit-value in handle_bug
                  https://syzkaller.appspot.com/bug?extid=ba80855313e6fa65717a
<4> 216     Yes   inconsistent lock state in bpf_lru_push_free
                  https://syzkaller.appspot.com/bug?extid=c69a0a2c816716f1e0d5
<5> 102     No    INFO: task hung in dev_map_free (3)
                  https://syzkaller.appspot.com/bug?extid=9bb2e1829da8582dcffa
<6> 44      Yes   KASAN: slab-use-after-free Read in bpf_trace_run2 (3)
                  https://syzkaller.appspot.com/bug?extid=59701a78e84b0bccfe1b
<7> 1       Yes   possible deadlock in bpf_lru_push_free (2)
                  https://syzkaller.appspot.com/bug?extid=18b26edb69b2e19f3b33

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
