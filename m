Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3233368B6
	for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773575777; cv=none; b=NgGjsb8btnIdcC6R4oWHVUU97eCY2jeYbr4CJn9Gna/Uz3hjJmZVSnqNK++c+swtHfTuTa+ehm2374v6mJ1T6mkVyRdpRjTyJfsQBF7MT5vyj+xj8onFkPy6+ySkA7+ZP3QCnnX7oxw2FRpJJpQNtf4rA9LNoMLSDU3kvFKcZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773575777; c=relaxed/simple;
	bh=GDx0ZiJB2n2LoNNv8l4fq8GpK/w3fGpovnPZQD9xtj4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=b3r4l086GyanrQeI1XZXEWdu5jvt8CtiF6KxZmu/doV1r4Gw54TvB+n30ivDjyIFOu9xyEuK7yXMU69NhcWbXz9pDgxyDPITy1Qz/YDTUyo7oJfoORq1SWGPvsqdROaeFwDLhghvATYpX2XHqoFuDemWuABDmFAsdvLZvyAMW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67bf2b7267cso16572216eaf.0
        for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 04:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773575775; x=1774180575;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6q5MOwfxK+9oQUDNClOqqLxHNMS21gAMY/eb1iaCezY=;
        b=c5btFkmjrupRm653QtiwSDXhPsEFM87ZuIJ7zbuZbdS2urGzgJnmGAFRdsuol8W6+p
         +zH2Sy9f+FurEHMsh2dpTOCoOCWrBvRu3DtWcuUji7nENoz2pakfZ83fnOn+JdQ2hINt
         mlgEfxQ1RZUIJ4/b+eHs0/A0asEEEXIyt1bvpOWqSYgFaKwhaOuLoCUSEB+Ra7FTUsFP
         zagIRzFZ3gV1e0ebl9NaJHHIe9ZZ6x/Lr6BPAx6MF4xQWpXyuc1pXC7vfu2I/HbsWVg6
         46mQuGcH2h9LOfaReVHIzbgU18vZI8dXnC527olIWdYltdVaBRIy3e/rtCG200o5P5pM
         5k+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRJyNYAqQuvnVfBojO50W0DKW5gzIX0UdyvWk+tMfu3lmnHZivV7X6ipIsV42Yz0j6Vp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLIVtKNPRdPrIZSr9nMSWA9ooPvDp2TPNA77noh+zZJpqx83jU
	ijyVpS/3f99Q2FeBia6MP6B5ldhtiKPFk+NVCWCGb+PemIObrK4mSaPIQcuQwz9qpH0JWEj9w3w
	8r/BjdLDJ5vOvYKdwReK3pTTAuHRhRLbrg1AdupagI2BoeE4YLmP1qCQ/9YA=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b15:b0:67a:4fe9:a4ba with SMTP id
 006d021491bc7-67bdaa6adafmr5885530eaf.63.1773575774909; Sun, 15 Mar 2026
 04:56:14 -0700 (PDT)
Date: Sun, 15 Mar 2026 04:56:14 -0700
In-Reply-To: <20260314210810.67348-1-ebiggers@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b69e5e.050a0220.248e02.00f9.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Remove inclusions of crypto/sha1.h
From: syzbot ci <syzbot+ci46064f472908848f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, ebiggers@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] bpf: Remove inclusions of crypto/sha1.h
https://lore.kernel.org/all/20260314210810.67348-1-ebiggers@kernel.org
* [PATCH bpf-next v2] bpf: Remove inclusions of crypto/sha1.h

and found the following issue:
kernel build error

Full report is available here:
https://ci.syzbot.org/series/38f41420-5e88-492b-9239-7c260178aa25

***

kernel build error

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      1c9982b4961334c1edb0745a04cabd34bc2de675
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/b5327796-0a46-46fc-a192-f0dbd20d9047/config

net/ipv6/addrconf.c:3341:25: error: variable has incomplete type 'struct sha1_ctx'
net/ipv6/addrconf.c:3344:13: error: use of undeclared identifier 'SHA1_BLOCK_SIZE'
net/ipv6/addrconf.c:3369:2: error: call to undeclared function 'sha1_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
net/ipv6/addrconf.c:3378:2: error: call to undeclared function 'sha1_update'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.
