Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465014AB7
	for <bpf@vger.kernel.org>; Sun, 24 Mar 2024 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711269424; cv=none; b=p7U3d0jbxyjlSqDVlHcmxDOyjSf3t2uAlcPoVJ0kvVImUinJHCM4lwQd9TKijBQ/LprjfbPp19MlybfOPUOO5RXXgQzua5SKsEfpB/NtPD7Xse62JqEVJMnEJJSJzwgWhmhrlE2+UXDkC9JVvh1s9k7xDZJcn5MF4Tt1cB0j5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711269424; c=relaxed/simple;
	bh=14tYmPQEs3CyHiGchvoFwUfgmSdjXsja0blVcdmRCBw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QWkW4w2u6Gw0wVKKCR2zTeipWldsm6utIkM5bYzyfAyO+DNZLwcy7KRmRReGEuEGVhN/v9Fr5w7UVNjVyLxKYqDW0+l57iGPR97u2IJFI8ms6Izb/SkGkPtT0l17C2ia0VKgvDCghSlOzusjmZSnhAzbzWftFtXFo6SiRZ0HozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a930922so421695539f.2
        for <bpf@vger.kernel.org>; Sun, 24 Mar 2024 01:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711269422; x=1711874222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHc+uNAqG9Tf2XkO9MeTOtdp6u8g7/un/HgEhAdVl8E=;
        b=M4fURUGHXAubrA0jZKWQs05UBwbuE89w7kkiSrcUKAx0Ot6WvviMwP9KYBwx4zpKLw
         Hku1X3CY29MrI3h7OE3dOusswhCKiRT6bSjGv74xbL/NSU4174Jo6vjJCQgAyiiw1Q2j
         GPNfjZxxExwWY1LAxBFvFgQBe8OkbcX1Zjm+rQ0SKPQiD0+A24RNQn1BsUa83njkT20l
         +u03krgZBQKFbM56wDGHmBFFfnAEFKxJPFZt9JBIqZ/zqvnWpKK/bI+3S8HTXl/zk8TQ
         f7wD9uAfk5NXvmnimjqppTNrYjPUeStiu4lLNyl+CQ4xftRjIy06keev+3Qj/+6iboJm
         UY6A==
X-Forwarded-Encrypted: i=1; AJvYcCUiAo30BNsrPLYKRqQ19wZ/6Us0VUjV+51xKQa6IUnE5C3CPkMvyJrfyhkvZRbogAuaT9dWjZ0p9bR66xarAPd+3vrV
X-Gm-Message-State: AOJu0YzqhsZDsiyYpqtaLLaxe9Ym1PVA/g23Cc3OA47+8lLnWWiQlNqv
	f9eRMC2SlWOgVCUp3l2Yev8BIfWQS5NfNl92+OIWcFPyXswIok002W1T8AKtvMvpoSkXbLhJu2/
	jX62v2uri9yjxX5MYAVVnwTWgVzctFFIBOUSlBvTZ7qSs7LLq3I+TTCY=
X-Google-Smtp-Source: AGHT+IFS5mwHGgQBIEGBw1W4MY+ckTv6PfgXdkx4mzY4libLgoQiChHN4YGf1+hVLBjB3Jvx9K+U+q4SkRzhqg6qe1socyn3uzBq
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:348b:b0:47b:fd8e:c03 with SMTP id
 t11-20020a056638348b00b0047bfd8e0c03mr206118jal.1.1711269422262; Sun, 24 Mar
 2024 01:37:02 -0700 (PDT)
Date: Sun, 24 Mar 2024 01:37:02 -0700
In-Reply-To: <0000000000007628d60614449e5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000077c22061463f6f5@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_check (2)
From: syzbot <syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	olsajiri@gmail.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 6082b6c328b5486da2b356eae94b8b83c98b5565
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Fri Mar 8 01:08:03 2024 +0000

    bpf: Recognize addr_space_cast instruction in the verifier.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101f5ac9180000
start commit:   ddb2ffdc474a libbpf: Define MFD_CLOEXEC if not available
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121f5ac9180000
console output: https://syzkaller.appspot.com/x/log.txt?x=141f5ac9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=ba82760c63ba37799f70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115671f1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f14e31180000

Reported-by: syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com
Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
