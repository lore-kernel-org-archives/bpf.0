Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102B26159E
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388238; cv=none; b=LWZaSunumFzuVD/jZ2CR8bCX7VIYkVqksoQdcmfdsqHXIsC0zNSqCTkj4tpynqb4kHtXfmnGdv+hWyJRV+gD5KHtsHnlCIZetem6+dP6noJ6Z8fsBuEznZ6kpumSrgFJzW42H/u2TONKyF7lAOBKNYxJtVZ5+vtppiDXONIjkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388238; c=relaxed/simple;
	bh=SZQibCQFzDu6+R4DAdXUKMWgRhCRqvrvnThoiwsKPpM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fy249sC3pVlov2IS+8ttUacfkyxOHW0b90j6xAxEKLRwLQ6oICdtvF9+D44PvffidUoafAxQjqin6vxailtAaZ89QZC3Un3O/eiPO8dHW8RYmYE+D9SKEJ4DkxHaZfJhdtQc/MgWLSzPnFGm3DADg5DUm9jMZG6ygu75NtBAvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6630d586952so1107246eaf.3
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 06:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770388237; x=1770993037;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLTg7YHbi1N1AN2BWUe7JjPeDZ5Z4RE3xpX2/P/yxSA=;
        b=MPGgIlbH/nRkKkuC2g4ZV/VJ0M/m4IXOTNVGSNxFB5LotnAvbYbBMteGjglMB7V7wI
         UM1AZ7LaqugRUwfmPkFJmR9kWdQWDIV4EapAmVzRjLJpepLphnvexZuc3x4o5A82y0X5
         VCVgEbVvOKrg7X/++90WxrpotuBb0dqSGt4mZtThKrotUN5u258KxUsIW35ZrDazzCxp
         Zk3YkonNwbyRC925scQL6vDxCb96X7efqK+5KBXIibYJydB7+udbOvKHdnJS8Zv3TkTZ
         g3RgW6KnzLreVbojkJU3b2NSUeRGikvhLdkKYjZ7m8c9dXGbH7lrl6Zj+LbKGyFH8K4/
         l/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB+HGQD3JbZ4qZWoKY4e+2weEeNif0dJD9HLdP6g5P8IDsH4rXElHY4i2pVTYAM1oEdNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcoQJwroquVyOycVNPAsAngfaCtiJ/ZFG6ptshHpNurLh4dDV0
	XTzFhBSFyC/eW5oqtRBnnej6L48iYxLymh6eud6oSYLQaD0x3RKoZ+/JRIukCUHSRVdJ9J8bYyB
	HJ/N5YJoyjj71hxy1o3MpEvmGz4uY5AnRiu62GEEtAg1tGVIHh5QDpaAlxqY=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3093:b0:664:8644:8853 with SMTP id
 006d021491bc7-66d0d2f9e56mr1402230eaf.78.1770388236544; Fri, 06 Feb 2026
 06:30:36 -0800 (PST)
Date: Fri, 06 Feb 2026 06:30:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6985fb0c.a00a0220.34fa92.002f.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Feb 2026)
From: syzbot <syzbot+list85f939fc7e5f454b1c1f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 2 new issues were detected and 1 were fixed.
In total, 25 issues are still open and 318 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 16793   Yes   WARNING in reg_bounds_sanity_check (2)
                  https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
<2> 2297    Yes   WARNING in trace_suspend_resume
                  https://syzkaller.appspot.com/bug?extid=99d4fec338b62b703891
<3> 102     No    INFO: rcu detected stall in sys_sendmmsg (7)
                  https://syzkaller.appspot.com/bug?extid=53e660acb94e444b9d63
<4> 59      Yes   inconsistent lock state in bpf_lru_push_free
                  https://syzkaller.appspot.com/bug?extid=c69a0a2c816716f1e0d5
<5> 45      No    KMSAN: uninit-value in handle_bug
                  https://syzkaller.appspot.com/bug?extid=ba80855313e6fa65717a
<6> 22      Yes   INFO: rcu detected stall in task_numa_work (2)
                  https://syzkaller.appspot.com/bug?extid=06d48cbf3e767907cec2
<7> 7       Yes   KASAN: stack-out-of-bounds Write in __bpf_get_stack
                  https://syzkaller.appspot.com/bug?extid=d1b7fa1092def3628bd7
<8> 1       Yes   INFO: rcu detected stall in vma_merge_new_range (3)
                  https://syzkaller.appspot.com/bug?extid=316c0070a0341d2661a2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
