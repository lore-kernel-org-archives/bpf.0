Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0947A53
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048784; cv=none; b=FjqeuCqZKC3vqxa0zgGFU7KsftYFu16inT3uyFFRtane10gxY9VHnigd1ztPZSZS5NZZVvhuAR8g+cZOFWHy7WYt0B0lZ8RW3NUyJ/iI0TIGTVSF2L/F5XESUNgIybj44GCoDyi/AZlR+XBZ+Re4+waFzrO6Je8WdJT+c8Sy76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048784; c=relaxed/simple;
	bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ss7xUe3SLBDS3vWcXFsa5cgcvrotN2Gi/kpX+5cLPd3GOmUtLRYTxHX5alEQ7NWkFsG/GQvLQYJxdY/j3r1k+MyUgqiyTVI9TWX0SwM3R/6oD9ZiakpyD7bs0ygVI4E+GkgDz3v6dQJr7z801mKyBZwfplZAdL44UkRz4qThonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cF8WCMtg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cF8WCMtg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eafbcc5392so2018167b3a.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712048782; x=1712653582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=cF8WCMtgumQtL2EDQCU9C80+oJhPTjV+fG7QYYdutUD+YquBzHhsyn6YaGV1DEgUfY
         aGfaA+bTaw27DUeLcZ27OTsulyA1oB20fkcf8X+rqhZYJE9wzTHa6zdwCLzNkwrZApUo
         rmtk4MkjHMYItADokvuBW/s2hgwRkeqwxPFpZ9cOlwlm4YP4EucYbLFNBSpCqFSQu20E
         g3oc3UYS6zf3ko6Sheg8dn4d79WHVub6H1pj6Hy3eXUfdQgYsC7d8nMOLB4W2YTh9eWb
         3H+UVFqLXgmomhNcZyS1EfoZDz/8fkaY4NAjWi4FGCVe66yPnMxXc0FR0hxKFfP7rgTn
         /ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048782; x=1712653582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=lcC0dqy86k5N+IOo/ejzwanCybfIS1VxZO/kmg3NBwqMunZPNDwHGZ3y6NGpx2yjPT
         RNWOqaz2lUtSJ1pdhzAC6bg6UYR+f+eFB87SmowWit5Cit8yQTdReysXJSvoEjE0Bgad
         cd8b8XCLhvRaOoHDD/nLGon7hE1E8x63A6QtXxG3zwNTyN6TFxBzonsmQm+79o3i0cOn
         sHAJxAg/12M1nix7jvDB6FzWn7Hv3uF9EpizxYycdem+LUVm6XS22Pp7HahI+4mxW1B8
         MFW2jRQnvaklcn19TFVpVR7YdiuIVsnIwR6qdurrKTVV4YmBSVzm4SonBBUKkKYZURYc
         ScIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQM4fD2qohTtcwDam4s9AJi7lcgbyMM3J31yh+OKlvRyb6/1l16PL/bB33grju4qWo26xtYtTz5jIFaC1oPlP63LV2
X-Gm-Message-State: AOJu0YzNZ1Fn1ifE+M982oJEFetM482AeBSWmhQvk+PmXvqbWvJxxbyr
	iDgzwPfmn3j4ehKG9Pcy64atBjvdNiKwsd0G9f79Gw96MPTwjAgQe5uFA8NH7KthA5OdL5VCN6C
	1TDq4vvWzafISkgSHvXbZwtZ2WDXMrK5baavHtg==
X-Google-Smtp-Source: AGHT+IF06xagbN5sKJ9EvpgsDV85tb7LWZ5CreUjfXa0X50ku8Pvfe0kXvoKUXz76ondFzi9g5ymjQfN8l2M+t8uJp0=
X-Received: by 2002:a05:6a21:394c:b0:1a6:fe92:ed5b with SMTP id
 ac12-20020a056a21394c00b001a6fe92ed5bmr9413194pzc.23.1712048782167; Tue, 02
 Apr 2024 02:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d8fd6b06141e73a4@google.com>
In-Reply-To: <000000000000d8fd6b06141e73a4@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 2 Apr 2024 11:06:10 +0200
Message-ID: <CAGn+7TUvamrV8Ap_O0_mnHo0ZgS=0e=HmVWqwqsEYcg95nGT5A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in wq_worker_tick
To: syzbot <syzbot+8627369462e8429d7cd6@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
