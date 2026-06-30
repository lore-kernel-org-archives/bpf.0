Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF9358369
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811430; cv=none; b=KUTOwsSY0DCM9GHL7bNeej0eIieNuxC9QFwIEJFbpm65EQi17IEcfC61HBaXJUs92LDFRnZpwBhuUwwl1E9nnm93A+BSvacztT1yt4jhL66AG7E3ZreWLSPt9cLyb2fUvZ1pTpwS6jC+eA5CmPSaHXzHBhbxj5WeTmfSwgErIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811430; c=relaxed/simple;
	bh=aqczyMpEG5BbZ598I8o/Wi9L5s+QEPdes93UA6gNdPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=excW8e55upPyGkBH5PQ0jQWjQ4JyrHnxikxA223nbD4FUJkjINI4MDEeyqkkrXWx0oGx66ZrouVgPcWrNI9tAop+WvA3h4+qQPhsrB6WQI56r32PKkm3A+H9nNebGjBj4GAVkUy+aTh94M2l4T8NephALCPO2LOmD3UiqxDb/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-48f0c5d20c6so7262249b6e.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 02:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782811428; x=1783416228;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t34TSfkiH4ytfaQmHSXYPoxFCM5arp0uf4f1vQVJqI0=;
        b=WSiBnG8mQTOleLoF3vVuNMymamS8PA0zXPaG4mgvfURCFZu117rvXqR5cyIUD3EqZX
         yUkOkq4I8cRkCSdNeFsPLnX4C7jqwAcn2APircVqpe2COsg77JRjSXrxsPzIzCoqTnDm
         kiXrbv+S8T5h73Fdb2CpdrcAkxEvZH2KhTlyLGIEn12oJIgeVNPfnOTex2GDPfIpTw3X
         ClTnYwU3C5qHn1MlgAtpyaXL21ctW9aE1PgMT7qI0F03hr2zqIZVnW/PuG5bnz4Dw7MK
         uqwLdL7+ARefg7qxFGLv+szSCp12I3/epdCQPYPvqWM2jMcR4HDmdTwzmgu/tifw/rmD
         d88w==
X-Forwarded-Encrypted: i=1; AFNElJ/wJoMY3dJDqpE7TWBx+ZIHsl/XHq+VekRFUkv6AyOmLwsBMA+3U00KT0hjCrvR5uZu7S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR44rbidNERx0B1NSJTe5xBOpggd/hG8brXkv1wjkIvbvXwtBI
	Le6/gbLVU7ktTxRu7w3FqjcQXlJQGfX/mZM949Q0Ftv1k4+2Rf8P/hTAhoFntmxw1sR7fjmU4ZU
	w4Xozlw+3LdMk/wX9uASvZMoD4yxtyzRaTymqYgsRjbD25B8yyvZfURf6qz4=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fe0:b0:490:9b13:e9cd with SMTP id
 5614622812f47-495eaf31d75mr2574075b6e.24.1782811428183; Tue, 30 Jun 2026
 02:23:48 -0700 (PDT)
Date: Tue, 30 Jun 2026 02:23:48 -0700
In-Reply-To: <20260630023443.3026627-2-sanghyun.park.cnu@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a438b24.6124255a.dd83.0009.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Fix use-after-free on mm_struct in bpf_find_vma()
From: syzbot ci <syzbot+cid1a625374f9dbb34@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	memxor@gmail.com, puranjay@kernel.org, sanghyun.park.cnu@gmail.com, 
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v5] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
https://lore.kernel.org/all/20260630023443.3026627-2-sanghyun.park.cnu@gmail.com
* [PATCH bpf-next v5] bpf: Fix use-after-free on mm_struct in bpf_find_vma()

and found the following issue:
kernel build error

Full report is available here:
https://ci.syzbot.org/series/f0ce67c9-2c09-418c-bbe2-c698246e9c7f

***

kernel build error

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      53435562a725962e4de0c29653223129ba11643a
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/a434cf48-2810-46a3-bb75-064be88b96be/config

kernel/bpf/task_iter.c:1017:3: error: call to undeclared function 'bpf_iter_mmput_async'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
