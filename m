Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08F45958
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944407; cv=none; b=ehMPRhVrbnL79526VdPci5S0a+KsoRbC8PIR7Vl279dyBu6EE/EkxSMQKlO+Su68nLtMjS8z0MuoMMXMDHYldWp5VaosmWB32KzytXOHvtcU2ITss623Oevf2T5ICRR6XxP5DKuZ06hzME0oNzIe/3jVq7unDFJxlXOW/hdTFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944407; c=relaxed/simple;
	bh=U4PenDBB1njw1+W+z24TpzT7efnUyBjddFGh7Ku/DCs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dzy2juY3kuhA72FUgOkQVxvU9CoBdZBCRfRxOx/lNo/2r7iZLew1sB8ObK1pkPPHVlu3YYEjsq8cHc7hqECRKNIGQzGIsstcTj9dv5dHOGd8Kth+yDw+k8F5fFZV4BXe5wjjnwxR0xWyJMpBnS3MPlqzwZTgAJ6PHtInTnjY6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so2922139f.1
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 07:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710944405; x=1711549205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1IUsR6kV07MDW8I1wx0WoXxXZKs91pAq00W+bBUR6M=;
        b=loK3okhfKKRbQyx+599Ow24kx1WbP9wCTAwsCDKDZGnQ2Y4wclXzsp2O1V1NO4VE5q
         RzKUxW2zelM0UigAWvHBxh4xd4+oXcsUZrgLohM91TxM+JRkjHT+1g8QgQtY7NEiIsdm
         H6HseUhbYXFQ/U/PuPBDOHWvD9ihz5sa2peQILzguDLRo1egmPxWORJayko2eEKLUeB3
         JNMaqdydXBInqhwkFn/BKJo0IExL8X0jynusw6O4ZkPowgR4EANfh1B+Rv+uyClhQmcZ
         WuxbYsxHbzfPd3R+56PpNAaw8GgFzRtXeaVv+nMER4m0pKSwNwj9nZlGrSADkrNdfY/t
         qvcA==
X-Forwarded-Encrypted: i=1; AJvYcCUuBriWqVcQOZZCdFuE2kNtJvPBgTnijy2+GdOW3xtJcQ57VSFNyczB3Dnnnfp89e0XRpXmb2vdBdr03Jppra0cZhVK
X-Gm-Message-State: AOJu0Yzsm/P2XsPaHy6TUUHQDRD/YkrEdm9xpfNVdpY3jcKJ/hrEIOGY
	6aRuLgHsGuOfyaa0sBK+RETOkWcKBuXETu+F4jWlZmGDtMigYADRSASyyQ+trxkfT+jr94cROzV
	AT7ow9cb6cgyoei38JcgN9O973DcARA1kHdqyVs0YPtfizW9cct2H12g=
X-Google-Smtp-Source: AGHT+IEWPHrTc59k7P2wQWzcYopFmKG07JD0uCDKZoWRP8x0fTDj3ZrpQ0kLcy4ldIilE+R1PHKeJuAl3t17ypSJCNHgW+khmHGo
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1482:b0:7cc:66b1:fa95 with SMTP id
 a2-20020a056602148200b007cc66b1fa95mr325628iow.3.1710944404652; Wed, 20 Mar
 2024 07:20:04 -0700 (PDT)
Date: Wed, 20 Mar 2024 07:20:04 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007866bb0614184925@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, elic@nvidia.com, haoluo@google.com, 
	hdanton@sina.com, jasowang@redhat.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, mst@redhat.com, 
	netdev@vger.kernel.org, parav@nvidia.com, sdf@google.com, song@kernel.org, 
	songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1626def1180000
start commit:   f6e922365faf xsk: Don't assume metadata is always requeste..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1526def1180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1126def1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14115c6e180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124fd231180000

Reported-by: syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
