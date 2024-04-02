Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F9224D6
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048517; cv=none; b=L6/iA4GIrBdIF20IPLOnx7y2gTT4naMAX3mTL0H4egXxCPLr7makFIY0GnDVP9Rtf1TikR//E7uP/bIpkfKST7uLsQhcRY2N7vDTRetLzfM7K9PfWMn5jAExw5m3AnEJEE3TcUuuFYDdQYGaimgO6h6bAZuUj1tkVQvrJn79mPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048517; c=relaxed/simple;
	bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUgM3HagOX8oE+7bhAkvOp4cc0EPzTTGdVIoV5lV8FGcUCtzGhWeGmAIjDG9xdPWQi0jeOTa7ceMkK82ZE0JmQPDXoxRVnuf9pyXvESISOs4ZxXDDcUDQmnSDkrGbMJ293yogquuyIoPX6UZy8plH9rVCUHnfbaxfL7MNfh6LYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Bk19R7NC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Bk19R7NC"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso4553846b3a.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712048515; x=1712653315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=Bk19R7NCRilf8WwJf6SywRpuAyZDEFpDBtBCK5rekyy0uuleQ5WMQcRhZ8fBsDXwY2
         eN6WCyBETWAT6OGyu1TgAuwh1WgwEAxqXfKwwQy0fG7vm6REIaF21C3fo+tiMQKJlz4/
         pXsjkjWcoVvHTsnLaEi3noMjKvgfVlFgCOHZgQKoIIw4CTva74HZm2PeSeLLtDJ3k1tF
         9wqdzXtib6rEVcz9XCKDpCzimC0Due/nC1nskaXO7i7bWSVL9GRVA0uIv8ZiPauooHDm
         fGnP5w4RiAOz+0lPjdBZm0wotuxuPRVk5Voq4qpj1doXn2hrplSGn1P/GZilokAqMLal
         pE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048515; x=1712653315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=TfjllR1dA3TY+jdGZg2m0I4+On8/3YByJjkV6nVyaKAz0WIKjrJMVmRdscrqzE9Jpm
         wFCgn4sAnev2UBpo4SFGncPf6Vf7zJzxCpJgYrwh/dWkJHQJdKUCviY/U9u4dM5jvkUr
         t/63gyztNA+QKw8xphI+8kbdDJsTTmJtOzzpIzOkPn3co/2QaLvkx0Sj379l/e37LH6b
         fJDzl9NWEznFuQ065izrwifdmnur+vxUE9btU8c89FZsdhlmmzRiAVxBbUPZoSXW59hu
         /HPrORK/aD71Gni4z3ZWh4oGUjWYozBkrWoGyyWwAK8P5hj04eCA98coYSZA33plTCWi
         51fA==
X-Forwarded-Encrypted: i=1; AJvYcCUWLzpn2jQ3gMJdM591S/tMQR4dWt8ahLmI5WFS6+ClWguUZpzCfGkGNeQOf0Xg/qswJBNoESChNu740lpA9XvmVIv/
X-Gm-Message-State: AOJu0Yz4yTwknmGBGQnhyZrFJ61GpnwK8wTO5XtOsmXzICoLbFxlaxQE
	MkO7+vGO/jo4plcH02fbCjwYLZbU1W5pspLDF2uPiiF3aUD0m21z8VqRyzfPd+UE/ds+tnrorMG
	6aGONnUiFWFz6piKYnKEP+i06/xI5EwGRdUco+A==
X-Google-Smtp-Source: AGHT+IE115Sfhw75rH/JpVYlQIiEI1B1wUChGJ0wfRlxcJzODhoGWe53bZKJEIgJGp2HAJPfhytgtQBkvg8e1LvxiSw=
X-Received: by 2002:a05:6a20:8f05:b0:1a3:d515:ff2e with SMTP id
 b5-20020a056a208f0500b001a3d515ff2emr10978527pzk.37.1712048514640; Tue, 02
 Apr 2024 02:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a803d606150e375c@google.com>
In-Reply-To: <000000000000a803d606150e375c@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 2 Apr 2024 11:01:43 +0200
Message-ID: <CAGn+7TWYLnYRRNJfPPRtrNL3E7DDkf0X6RBAxszYfMKx1=EeoQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sched_tick
To: syzbot <syzbot+a1d7495c905fa16bea17@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
