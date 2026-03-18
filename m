Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F019F135
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796573; cv=pass; b=QZksMFqcIHUzo844OoRNcfjjy89/pWldFX/zARNTVtbzG5biwRc4FMCR+l3vEb9pD09PpvkN3phgpX3GFphWAjhrujV1R9S47NX9xeGXHxUw4ROsfycLYDsXtvoa7zQLYoKxCCtVURuWkA6H7mNPpg5ChN/PKN815piRilhYdvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796573; c=relaxed/simple;
	bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tE+58aaWGIlP2b6BURleueyqv+Yz6PHo1noE9JSbxa3SPf2V0pBd/x/KEJxXp1rKUy6GAsSY97ki0kuR2RKIAk/A7GhhW8XafPOBr6uv1U6xNFSRmBus5s7p3OAUe647E3BoGu4gfraV8yTFaFm7oT79KUF/fddYEKNGIweL6Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwNbXNsF; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwNbXNsF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so18232265e9.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 18:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773796570; cv=none;
        d=google.com; s=arc-20240605;
        b=SbXs5KXtEY+35DEM+cJZxxSVAlPdNYNFt/rNK7CRY8alTcli2RWZWPATaO91Z+ox8R
         IPXD2p71fhhP8A4hPnX2bGFZfAfcPqqCWQulJpjfjHyjpNdla7DNPCy7SmTRGKEWY3qt
         4UJJ9LLiGWIcmwExX9EeYT5jof6ZYMsVEo7gDfDZOPTmLJtA3aD9Ccm8iFM586CHn9JF
         pcIq/zOeFXuJDX64Qr6JpPKwfp/ZML6E5O194xd1HDwB7nxWkoPJqwxF7G25tyhxw/x1
         bIzpCfEU2mBBVxv3PPAruRaZ0BYKsZe+Swra48emusEIRK8tgL/C2kfbf2C9Gx5s/ngp
         uTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
        fh=8GTjlGmSogMfBHduoIHHGPB9q9b2LKbDS+dRTbAGgrU=;
        b=dEo6Moh5/91ySzp+j5bdeWSyQtFQM55q88ja4BRkf0jXfBSw5phRE+28fm1268nzy+
         rFkQd4Xc3Gc+wkhcBL2eWpGcZbKeIPtmiRZXcE7w+u853Px08dEv2xG9NJJFI3Umbq7U
         4vZ8TT3vSQXiMLRr0tX7uE6hrb2EI2cnu2Yx2DuRbgvN+p0Mzqa3uyNeIfnwumwnUFHu
         cd+nOZ7gEEsPI8TDLXqD6Jb8WTAcmHCtziQpWnlZtNXYeXwsW8VYdTFbDo+9JRAwgGyQ
         ABt961e+Xkqpv3HxuS2tLw2c4k3mNlJtXEm/jklMv/NHHCp6zAW83UZ/Aq4bTLlruh3G
         3INQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773796570; x=1774401370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
        b=gwNbXNsFjJ5I/rKMUtQV0RcE8uzPvaeiGNXV9yRrfF3jsU2WqReVgITC+rdJf4VWId
         2Q3Wqy/4mb4oFtqwNXgTNf7ZTX0ty08lzY2QTNj9GK/iIt66kbgevofTQrx5LqnOnkUF
         xtfRftDGYI3Gg1HBpFa7CDJNx61668vS20asflQgQydFp8SGyRylv6mASjCoxy8RqG4T
         cFRESowjz2A+czTkSOlFp/Z2hFQ5LEQoRrBwq6oP7W8iHZY6AnCybUmUCY4uS3N3mUzQ
         rg7nSjsC+DpBj5jWYS+4EENc7UWuqQPT+Xqxn0jJF8r6mqjyRoLCS1SaWpIAEc49hKCA
         AQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773796570; x=1774401370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
        b=Qva4m7u7q69kjcPUd45hy1IIPMlndfy88AbksVItE4YwchBTiY8m6wyiDMnRpAJRcQ
         U+PecFwGHCSndoAwKpgY6DBOzYkW8+TX0Ggz6+dQWnZsHJGI2mmG4h0Tl4JKR/FChACa
         QjSwZfU7FtQe1y16CZzxgy8L2R9P2mvvysboiMdkk8C63mE/4au+DbgVa2pJGHPC3Oto
         mBA3P/sLXdXGG11+HzzDFofW0rmN8fG1Qj4DDavzqSRQA6weoAhSJbP7MrTnKN1J/qdK
         jXrR++ZjbMYtml+qAXUTiV19qcHHBWxMshD/y6/VzJDwWMo6VOsmWzjQR0JHEgz++JoE
         DBfw==
X-Forwarded-Encrypted: i=1; AJvYcCUWdSQLSBkFLhvPkjsj2cu4ABJEd7E6IJPRqcPpHIChQY8BZCclyVvaisa3S6cq+a6tXTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR5uwmyIgCFHxtpQCSJ9YVdcyw5DdTf9YEmJS9bPPIF9BOaBTg
	uCfuxbzZsk33Do9IQU5isXT7gqXTrIyq0gdGNK78U6hpRwK+DzhkAp/vjvNnG0IPSkH0GwBnn+0
	zuFvMySSpdZQ4POIrURK2Pz1nlgZ1S3Y=
X-Gm-Gg: ATEYQzyD8VOKJRIHmRP+TxJySsN1U2EOQCoGpYG9EeVz51qd4btBMtWnNmIXVBz+m25
	JLxz8BCYsdsjFYvIA/KfvAdwToA7OgaOEL/FqiN/gOyoCIAoHwhwvBc8IgShayk19IRd3U5V4hu
	UM3pvKu/QXDpCTr3jXexw5rwoBtP+mnTTX85LkOM5if0amdc3JkCAu6jnQuj+JpQg/NWgkKj31x
	QCY8rExsT8vMJmFU1Sj5lMh5MbpvR6R1OqWI0ADRpUxpOwm57Pvbf+VVPUdDDqTi53NjCZNuYLU
	54GhDD8Aj5SteNg+S2R6uZn9LP5ucD2TZeqObayNRkud5m2hoKwC8G/1Qi+S2M6zy/Ry1dUDwUR
	JQdykf8F+mCYGU4igoCGm/loYGw==
X-Received: by 2002:a05:600c:8683:b0:485:f1d1:8f3d with SMTP id
 5b1f17b1804b1-486f442e6e5mr18435595e9.6.1773796570321; Tue, 17 Mar 2026
 18:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
In-Reply-To: <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 18:15:59 -0700
X-Gm-Features: AaiRm52ZhrulSIFyNHNiIzRvMopWhhEYRIriCdPJwA716TKmoKnUrKQyqpBcyns
Message-ID: <CAADnVQJCJaLjGCwjCX9VtT615c4kn7v5bxviUmGFVj=uTtUHMg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 7:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> wrot=
e:
> >
> > The motivation behind the change is to give BPF LSM developers the
> > ability to report accesses via the audit subsystem much like how LSMs
> > operate today.

Sure, but bpf lsm-s don't need to follow such conventions.
audit is nothing but a message passing from kernel to user space
and done in a very inefficient way by wrapping strings into skb/netlink.
bpf progs can do this message passing already via various ways:
perfbuf, ringbuf, streams.
Teach your user space to consume one of them.
