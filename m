Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA037165
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711681163; cv=none; b=n9ChgP+zxAKS7QEui/LHHJMbgL4x78Y1REqufJVKEoU4a6Ya/QK3KPXewWbZ6ClxLqaJeplVCEg6M4K8cmopdRlJlIKo8kf+ooc+HiL7Fs4z51JvZhO8QbBT+oI3vVkypPqPe3G1hygT4QBcd25xl45Zf55Jc4qjBEJkB0PeWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711681163; c=relaxed/simple;
	bh=dGtETsdt0QT/4xvEP76pejvB7FB1g2easUs9qA8vpVk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SW1KedaWfki4KavNoaAfmnVikO04cev/DhyoanX0eWK6uqMM0HQgkWGlBfYwlp/bKvArHtXNC5XcARKA0IYc9jqTA7BUd8oKAeifWgFteYi3GvUxCj7PzBHthHJU8yJc9J1Bqb+WsXwBQZa5v2rxO6T01Nuvx8yH5ERKkunooo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so167176039f.2
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 19:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711681161; x=1712285961;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6n7QmXOvYboAd7Cq7lfplGqLO69ROJHflHj1c62Ec4U=;
        b=puXx+sJrb+DrZ01mzD5kJS7IrndUKa5VM2/vFJouGdI5Hn/BmSsj/+r2YlwHcL9Ove
         FYrbTKZ1AEgb18fgdW8kmefhIRsfShmX76T1NBUFVR0Dal525Su5lqCFTWhYJ0CwPjGm
         B2zeuAlov36aHMDRIeLVf49Tk/xMIqplZ/DvauzWcDzEtFXyD55oE9UuCp5XNC3q+2fo
         Ieeihz9T6Vcs6VG9K4WhHQNjqfp200mwrOKSKRKphJ2ogeghCScCZanHrvi65jH+IFVq
         IDaRFwAAJ1RIaLct8ju9YkLLo67TQjWpT5wY+gb/vUdJFryWIgQTVUzJZ9W6ZNW1F4QQ
         vj/A==
X-Forwarded-Encrypted: i=1; AJvYcCXrzJad946dpGqhwu3ds8f9YYqpzEWsEbgPK2fezXs2O/0KljSRWh4M0Vi3Epx+mR+XJRUV7QLK0SnRdl4w4PB4vrsp
X-Gm-Message-State: AOJu0Yz2vSW8Tl7+3Z3umVniMPVGC8VcB9oCEuQfbaI6+3eIbda3KA3+
	qKi4J1YXChXqycrCyZV8X+jnaw0vf6MdPtHOKCdYwxTwQZzDEI68znPVG2+ds28FyP8sjdec0CI
	t7P0qEBff8mksn7Asp0ZXEkFndyYYpJ7MEwRnOx9tDbVtlOFmkOC2mHw=
X-Google-Smtp-Source: AGHT+IGolnO7oOOyMon/XNOqd2HDi6/YkPAAhYiO/AndRNtsW+20fOtvMU0XJp762Ja0wcdLnnnlR/MH80jR7+0s7mokZjDFOJb1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378d:b0:47e:d028:3eff with SMTP id
 w13-20020a056638378d00b0047ed0283effmr21880jal.2.1711681161467; Thu, 28 Mar
 2024 19:59:21 -0700 (PDT)
Date: Thu, 28 Mar 2024 19:59:21 -0700
In-Reply-To: <00000000000011b2f00614076749@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009925b60614c3d39d@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in __bpf_strtoull
From: syzbot <syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	samsun1006219@gmail.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8d025e2092e2 Merge tag 'erofs-for-6.9-rc2-fixes' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f2ffe6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=8ac8b7b2292ea867a162
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b3ac29180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160153c9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ccde1a19e22/disk-8d025e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45420817e7d9/vmlinux-8d025e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/354bdafd8c8f/bzImage-8d025e20.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
 __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
 __bpf_strtoll kernel/bpf/helpers.c:504 [inline]
 ____bpf_strtol kernel/bpf/helpers.c:525 [inline]
 bpf_strtol+0x7c/0x270 kernel/bpf/helpers.c:519
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run96+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423
 bpf_prog_test_run_xdp+0xeaa/0x1a40 net/bpf/test_run.c:1269
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Local variable stack created at:
 __bpf_prog_run96+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423

CPU: 1 PID: 5019 Comm: syz-executor335 Not tainted 6.9.0-rc1-syzkaller-00061-g8d025e2092e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
