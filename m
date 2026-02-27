Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7845B2798E5
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174104; cv=none; b=P50PdJum6gcJ4BGifTi3jlz4hE4hT4Pv0JsG4z9eNB/zBbzMJckY4pxyqE16zm2OL+6xvIzgbh9qORI13BtJzpOqXQcDaQ0z7dAg4+U0PHUN4E2UhsEeW6aY7WrRQYrKzUfYDYHOE2B1r/AMrFis2M2qT7H6l6qux3g/Khu5SAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174104; c=relaxed/simple;
	bh=QbBr3T2VQUA3HHZ2LwPcLmmPuGaEyaZBuNW4ygJx+IM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jjC8U41BOHRbBLj03IfTItWDEtEM0j5aF9zaExroQEA50H7veilaYgBjmqhxmcbkg2iew/zYQu6GV2BolwuMlVHvEH3zYw897agTkG+o6wDCPFsSV6j+SIoXc8FbPg13XRvoi/wWkog90VK0ZOg27Vw/s5IAa2WYd81QoLc4R9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-672c40f3873so35372497eaf.2
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 22:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772174102; x=1772778902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXTA2zqOAstIeMEAVIOcvwyKQP9PlV3vwMKXGuZAb4w=;
        b=xO2el4v+hK0gvcsElE3hLy1wzeTIERAG6B5i+12shPF0HBiAGfP7+B+brXc3kaoUx0
         qS8dLZDXU40f3ZBfJunPnsSKUp952bhnVWvSAcZvxhDDoXoLjQq+fn/R2/EzknwFd8m/
         9m/dRN9ll5SsSW1X3GGcZPwWqu3Q6yAmqX03F7id5gKKPETRLiTPtAzox4JaFAosCa7T
         0wBhi2OamD86qT7vSfWQtCVI4pohZNn5Fnj0Oo/QyiNucRJEthmyQGU+RLG4lehempZ6
         5Ar6lPl7PnLJud/xi67VAGXY++UR0mYi4BiJpFeLjSgxkMHiJcgG0wF958zyyUzYeYBm
         uqeg==
X-Forwarded-Encrypted: i=1; AJvYcCWj5X07N2vpeayEug5cnkIRHNp6AGViqCLGtHS90VjJMQCnSgWdSuQtzRJsh2202sLFDrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEhDptYCgGxg5YID4Aex1QItp3wlBkDhGKEuCg4VY8ovqW8F2
	LaE7CnAewDkK8kKedx24L+oCHjsdYwvyTJbnM4qzmbQsZ+iOKlQRzyngtx3rYyYQScu8HjMvpx8
	+ffPzJC8nQHj9Ob2l1lMJfSsSRuYghJhuO2LjMMmngIIvE3AxnV78zhkUs70=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2293:b0:679:a9:9447 with SMTP id
 006d021491bc7-679fae16f08mr1309686eaf.27.1772174102529; Thu, 26 Feb 2026
 22:35:02 -0800 (PST)
Date: Thu, 26 Feb 2026 22:35:02 -0800
In-Reply-To: <20260227061759.1126681-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a13b16.050a0220.305b49.009c.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in
 bpf_trace_run3 (2)
From: syzbot <syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	wangqing7171@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         a75cb869 Merge tag 'v7.0-rc1-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e650ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56150637ffd942dd
dashboard link: https://syzkaller.appspot.com/bug?extid=9ea7c90be2b24e189592
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1476755a580000

