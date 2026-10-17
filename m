Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064635F162
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198964; cv=none; b=VrO+FL44u9OmCljDoktpXhEqg4y54b1ZOQB+6AKTDjfTrm6sHj5Mc6eNAcM5HAV9ThyL3FJceR2Mgc7M6+d4pGMDwTGKPip8zb4jdm4f5gZzdzMAPrH2HlPvhsYhlxmuYiMO9Y9AyzD4BAk8H5YRTfJdEhqspbRD6Ts3RXfXdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198964; c=relaxed/simple;
	bh=dzEr3osBLfRb6demh+Mb+Xhthwdtfv/YBDFQk6e8JIY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=gMJ3ZeGJsCD+mFrmH+1Dmp8e/vm7gh5qiRfJUcHoDj2FOhX6BiXh7rWD/NqAvyHHwPZdfsQ0KQLk/OrreXpXC12/wG50QjWWqn5LgxvIpUpPY2l54Wt9nK/nX3KFfFTh6ZLy6zxQRlHIrJDQM7EexuxTdtAHQWOqiJx5ETa89RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkIIOwlb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkIIOwlb"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so258959a91.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792198963; x=1792803763; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FDPknGg5ZBDcxMmM/1N7ggpAZ9FP1SU1Vl3EerUriAk=;
        b=IkIIOwlbuOeh6h+EQEtP3S/Ct5YPS5fHNwfPWibYiMlS038iGsYDs/Gmhtq6jFJv/M
         YgxmkV8VUlJKm8b3vm0WSS9Z6lGiAlcdSjejhswyyGsQUOqnAs+ffNQhPjC2pI56eMQ0
         f2V8ZfemWqldTikC9RF2UbdD9k5LDhQh/vXUWMwj3pJKgDuxXoatxRSuRnPP1OL51SKo
         ExfDIwoKflxp5pHQmtydZGo9THe01Vaa8Kumho4y8sR33GIydTYmJeJrQJH7awNGDSla
         WL4//XyBPTmcaaLbdwpFUdlDTxY/QmOm6UeEmFr2rXaFyPOIctPsYVKChG5tF+H47AW7
         GDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792198963; x=1792803763;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FDPknGg5ZBDcxMmM/1N7ggpAZ9FP1SU1Vl3EerUriAk=;
        b=bGc4oDUcXMnnVVBW8wg5vdvpAs2Hvy4DvEvuhjzzQMtgzB20N16Ln7CE0HJ3XcqRuT
         81YEy5Sxuccr8L0dZXE0Bd3lVY/F8m7y+TSBc2V/RM+oHb3fOzbdIEC/a5mkiEQfO0oq
         eitqzC2rIqETHoaM3rElUyIU2oXbt/bR0aB098YVmAL858aF9tUz01Q6/jqNZq8HjNOw
         m8HvYkDZPKAYV4TOcBIeg96UNwEnd+ZNTOwlx1BWpE6B1crbnIc57bp3Mju1gKopIEds
         NWkEHV3E18kTyIPOMBfGq78Rpac0ziOT1wNg9sVDRy2PcOM6JHSNCmMhrTnegcqjNUjz
         0dHg==
X-Forwarded-Encrypted: i=1; AKwUvBxrVztzJts/NsRpsS5BdgnQCVPcNwpaYKtbBEm5wJbUzgxtpPpQmlRymfcQc1qpH8OzTnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIa1VQqywZeaDXkvrP5KFUO57oc6jsy3tV+942Qp6PSVPLNT0LQ
	tX1bF1dZ8aYeCGtHyon9AnyVW2R294kTmyaoHrPxe7GUvty8BTDoDrAv
X-Gm-Gg: AYBFou13FbdWYTDekBgERGzdT5iSFQOE7hF4ko7pQrMiRNxJ/UNWxwvdXosf/9+Zxxw
	6hPmilzlDsBhnvxSTZMIr6ox+aP0LwbRj4z22jyLMR31hiB6Pg2F8lLogykMh0xrUKXsJBEo8Pv
	HpvDnIQ2WxgvlgHAirvxCXrwYMAUNHJtx1ZRNafLPS1Xal9CIbqW0DS8OdARIh3gd8LucD2aCYE
	5uYUnIZLjFDo93CMAilIjpmdPt6PI+2M1y1R9AN+lKuPSXuFbCCgERmrJTrHFvNaEW6org5/isT
	zQNNKRb9hHPFWL4XQEVhfbgCZp62Ghx2owxh6sSvkxnFo6ACZxfI5nyKNi4QdEf+Dy+k0hgk/uv
	cADqip/+SbprJwsTl05Q2ZBtXOhC2hk9fA5cBeItpOLFnU5d9K/hwE2Y1emo33/h6Q9HVZDCgo2
	e25fMTvsPY5HsW6CmA83HNv7OvobrRoKTT6rw6mBuAE9IPsACrYcGjtPJaaoRiSPCm0edFnNK6R
	a5QiDAw6c0+kj/VAiMGTrRYfo/LDXrWsufqgd1cZAd9LIDQ11SWO/hUAzoY/P2NqENj+wa1FYCE
	tLHZ
X-Received: by 2002:a17:90b:582f:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3acee98d90emr1287962a91.8.1792198962718;
        Fri, 16 Oct 2026 18:02:42 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd093380dsm2979093a91.3.2026.10.16.18.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 18:02:41 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 01:02:40 +0000
Message-Id: <DM6PICFFAU5Z.14KOZT5YJO7MA@gmail.com>
Subject: Re: [PATCH bpf-next v1 00/11] fs: unified VFS ancestor walk for
 Landlock and BPF
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, "Christian Brauner"
 <brauner@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan
 Kara" <jack@suse.cz>, "NeilBrown" <neil@brown.name>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Song Liu"
 <song@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein"
 <amir73il@gmail.com>, "Mateusz Guzik" <mjguzik@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>, "Tingmao Wang" <m@maowtm.org>
In-Reply-To: <20261013164800.2906577-1-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 12:47 PM Justin Suess <utilityemal77@gmail.com> wrote:
> The structure is unchanged from the RFC [2]: a stepwise engine private
> to namei.c, a callback front-end for in-kernel callers (Landlock
> is converted, fixing the follow_up() race Al reported, hence the
> Fixes: tag on patch 3), and open-coded BPF iterators over the engine in
> referenced and rcu flavors, with bpf_path_ancestors_legitimize()
> escalating from the latter to the former mid-walk.  Patch 1 is carried
> from Song's series.  See the RFC cover for the full background and API
> listing.

Song's series stopped at
"It is a conceptual dead-end to expose these two modes via separate APIs
and leak this implementation detail into non-core code. It will not
happen as far as I'm concerned."
VFS_WALK_RCU, -ECHILD to the caller, two bpf iterators and the
legitimize kfunc are that leak.
Landlock still passes flags == 0, so nothing in the kernel walks in
rcu mode.
Patches 1-3 fix a real race and don't need bpf.
Send them to Christian, Al and Mickael on their own.

> Verifier fixes propagating the RCU-ness to trusted fields can be done,
> but it's best as a separate series where the idea can be examined more
> closely.  Then marking the dentry as trusted will allow you to use the
> dentry xattr kfuncs.  Nothing in this series strictly depends on having
> a trusted dentry, nor will marking it trusted require changes in this
> API.  See my follow up [4].

Then what can a prog do with a position?
pos->dentry is untrusted now.
Marking it trusted will require changes.
d = pos->dentry is not linked to pos. It will stay trusted after
bpf_path_put(pos).
pos of the rcu iterator points into bpf stack.
MEM_RCU propagation fixes neither.
What next() should return depends on how the verifier tracks it.
Let's do the verifier part first.

pw-bot: cr
