Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E64778E
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048551; cv=none; b=JefrP7Y3HqxwBXKy9AZa//QigFQ4AXUaVoJW71rbB/VwqJQDrwYRkOO98Mcywc6U3Pbb6TwiiCiY/UzP9k9oECACoxG3eSa0JoaEJgAGXab+1AVQfRANTZ/DQjygf4WRnRlRw2QhT1x99dIa0LeD0gy+yIezRHWi8QednouZqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048551; c=relaxed/simple;
	bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okQC32HFCIgy1erzRXV/t9wgIj9l8BuAmkLbZAKj9TCxk6KT7FKqA80ZAui1jWFV3mRfYp1Mb/26UhC/6wUktuRndQfab33e63YYdXoXu3B1DPSgcDkwi6Hv9+p1poCXbKJ2pUi5lxOtSSOQG2PaWdz7zUkKY482TgrGX7d8lts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d3NshYrw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d3NshYrw"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ead4093f85so4560661b3a.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712048549; x=1712653349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=d3NshYrwWuE0PPBewoeqmyKsTKuz/7d2vAO8xjWkq/yE0Tep03KSNkVTWEYiJ1gGPM
         R1m5iWzmckxDpCVZ6vkOzLlA75uaiQRajozDUX1SL/Gveon6Zx+unDQNOKKajxUwL6M6
         KFxyA7kMizAfxGx6YCo+x9m1a5TSxBBDKuw4wRU9MhUFaDvzERp96hqsX6pja2LYflbJ
         FtyiKmSKPEkbKAfZKPo6r3ehWhnYnbO8J9xqVhp6H+QkAIA5LrPt/38yl3ovjA9CbrPS
         t8N1iC8EpjJLEN6F+efTQt6NKlsUlCgS7GOvRRaRgDnlTtqtKwioXxvUE6/7TTIEbkLI
         rTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048549; x=1712653349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=hOTvVBcBWlprgdP9/Z/tVxdD3WzZXQfJlJVk5CSqir1+x0AVKnQReRh8g+6Ai772Ot
         ERodYUBYuP9K5ofEyCJU8vnZMfKeZFTVqqpT2Pw8kHPwaS5PuSXkyPe/l/s6m0wPNuQV
         AxVRQ0X2kYokkAA/zPNpm9BgzO9aOSLgiUj2+fqzLboqbok0ZSrth/+zJmub+rTsVh4c
         VoyGwL16HB2U4ETQ+7CJtyVzkVBxn/IJED+CDZyK2gv/DD4RRmZ8FQP5tdQf7HulvvWj
         VJy6v+5PqvIrbzQnlNAs0TP66Q98IRmNc1lfDwuKKSrpAdjr6cx8VF83NVNfCaDLOeHz
         hjCA==
X-Forwarded-Encrypted: i=1; AJvYcCWR6691mZGxQYj7O84a8mpp6VmKYoVLMqY83zUz/yVAEi7+l9Y/z68V+M6yoBlhXHbwNQoAO2SHvlLQ/OSEtcUzbZH0
X-Gm-Message-State: AOJu0Yy90uFEyJFpokuozygCZrs73ezUYfYvtXQv1bSYRH5WKbZNGzpW
	80+SzaMQOS4D+VmJkCyhYNZbnFTg+TwmghBsr8rt5CMjwaVQ71hY8RQ3hsvnMJ8vmFmiL4PgAse
	YeQHYo1pT8r2l7YyFtYjEsNbBX94Y26nTkwFL3A==
X-Google-Smtp-Source: AGHT+IGNSFtfd8t/rR4qshARGm+Nq9SLa4tWyMVyEN+9NXoW3WAZd8KkusAbyE4DFMdzARx0uQPrKEhTyc7mssup7Aw=
X-Received: by 2002:a05:6a20:8417:b0:1a5:6abb:7503 with SMTP id
 c23-20020a056a20841700b001a56abb7503mr11175022pzd.49.1712048549313; Tue, 02
 Apr 2024 02:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004fbc7a0614cc4eb9@google.com>
In-Reply-To: <0000000000004fbc7a0614cc4eb9@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 2 Apr 2024 11:02:18 +0200
Message-ID: <CAGn+7TUcN9bw-iOM-idzoV43u+GHSRW1t3HuQkOEdv5Tt+TiNw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in tick_setup_sched_timer
To: syzbot <syzbot+e4374f6c021d422de3d1@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
