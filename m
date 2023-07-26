Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB61DA3F;
	Wed, 26 Jul 2023 15:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51687C433C8;
	Wed, 26 Jul 2023 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690384993;
	bh=oC0eTTq4WytvUZB2KcVKqBozq5IBKTLRL8iBHm0r3F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OuXJb/EgmZaLAAaej2KcRStR7pVRlBD2dcRGeXpXjMz4oeNvpYhqMGqe5+26AJTyf
	 8khmLayEaQSud57scWhtQeLKtj16EAsw8hfh8NQtPyGONuf0XjPqnvU1ygWJH+lJET
	 fHpheeTlUxbntNn9qGMN/S272GtyQQBc9XIoL9GbwQAEqptoGCOBrtDInYSM1+64SH
	 GKjbhiEnsUryPr72fsMBPO+5zxWZgEWAvvYMmoLDXITeNyBzCiN7vwY2rLEo+QGkfB
	 IDbc9OLrOZc+z+GQlZ4TagMDoZ/UZeuou7dcIEomODgnuZotOWfNjJIt3Q0v1xzLXH
	 5XK7LEWizP/xA==
Date: Wed, 26 Jul 2023 08:23:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yhs@fb.com, Gal Pressman <gal@nvidia.com>
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
Message-ID: <20230726082312.1600053e@kernel.org>
In-Reply-To: <20230726071254.GA1380402@unreal>
References: <000000000000ee69e80600ec7cc7@google.com>
	<91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>
	<20230726071254.GA1380402@unreal>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 10:12:54 +0300 Leon Romanovsky wrote:
> > Thanks, I'll take a look this evening.  
> 
> Did anybody post a fix for that?
> 
> We are experiencing the following kernel panic in netdev commit
> b57e0d48b300 (net-next/main) Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue

Not that I know, looks like this is with Daniel's previous fix already
present, and syzbot is hitting it, too :(
