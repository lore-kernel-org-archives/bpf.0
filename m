Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718062C234A;
	Tue,  2 Jun 2026 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369870; cv=none; b=iguDeh4rNg2dwP8g/BzyXFdyk0ytCIDXigxba2McPkYdF/Nd5ZDSbkN8r3n6GaTyVxUyz9mTP8ON/SPepjzNGg5pUxZF9iHhDJBlL5Yq5upFjIK+YOReFV3dsET3WeS/4Nk+zqw7aKqqTdKirUa/7LxO3MhRnM+dqSmsOetHxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369870; c=relaxed/simple;
	bh=hdnRAWc2zCd/FhNgIgkUCXjsBdseqPeMUsX3g2GyR0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9Ou2K6EUt7hRgUmMvNaZuf7+fCyNVCF6PS1uNGTM/VM2gfzx5IjAXmnLqbvPfX9sqYNCg0cLAHuXTMWbe6plEZdMhNUsr6Mzg5oRLtH3FJMPaLmSzyRoINQ8PvPMA6/l4COqOj7IHrZEMPI704DFWhkmbXux0mlsx/OKISHFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GVFhgWiH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GVFhgWiH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JntJA09TUm74iV4yNsmq42r+rYhOYnuAkX8O1xHHW6I=; b=GVFhgWiHhasdYtdYVyReHUeNXQ
	rZWp2MfuE00R2nDrCnq/Mg3ltsxnWur33GOqPr0pLhFziucsqJTM63hro/0vnpewkAjncxqpZjYcg
	oosWH7WMiLwnfyEd5qryrkaDr4ESPEp41ry0FA9pw/wtQdmuH7oudx7p9fKZegDoT3qPFjD8p6i9Y
	+BHki8eGBop8MeGKfHDTszG/wwjUzZM3YIEb9UiKliHO/yGVw1hmmiPmFV8yUuqOMpR9xvYXoucFz
	6GX749s0XSiFT8xmBks/sYmJwXdyQKI0P8l/dDLwqTCWkN2YHKFjvJs/YzPcasoqXvcwwN7ceNYOk
	ygN1epkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUFWs-00000005gI0-31z0;
	Tue, 02 Jun 2026 03:10:58 +0000
Date: Tue, 2 Jun 2026 04:10:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, KaFai Wan <kafai.wan@linux.dev>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] bpf: fix UAF by restoring RCU-delayed inode freeing
 in bpffs
Message-ID: <20260602031058.GQ2636677@ZenIV>
References: <20260602025249.113828-1-kartikey406@gmail.com>
 <CAADnVQ+TAm1Mow5sHej5wUGz7j+BLSxw9gGwgP6rP1cw8cRXPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+TAm1Mow5sHej5wUGz7j+BLSxw9gGwgP6rP1cw8cRXPA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 01, 2026 at 07:54:35PM -0700, Alexei Starovoitov wrote:

> > Fixes: 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning htab with internal structs")
> > Reported-by: syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=36e50496c8ac4bcde3f9
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/all/20260423043906.GN3518998@ZenIV/
> > Link: https://lore.kernel.org/all/20260602002607.110866-1-kartikey406@gmail.com/T/ [v1]
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> > Changes in v2:
> >   - NAK on v1 fix in fs/namei.c (pick_link) by Al Viro
> >   - v1 was papering over the symptom not fixing root cause
> >   - real fix is in kernel/bpf/inode.c as suggested by Al Viro

> Al,
> please ack.

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

My apologies - should've followed up on that myself after your
reply in the original thread, but that has fallen through the
cracks ;-/
