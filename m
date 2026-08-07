Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A7153BE9
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096271; cv=none; b=aOWCf1G7zMh/MIxjK1bnkx5DtdsQcz9pczf4B3URIWvmjYcXNKtDfiJOzzh1vb+aT97W8KRZOYZAGnZ5tBdGYNXcW9UVeHl07IcRJzWieciXocSdhimB57gSh0ea65xwhfvGPovt4ivyk/I7dVsgBpI1jLbGz25yYlqxNP7eZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096271; c=relaxed/simple;
	bh=kLIJ7ESzSbgSa7C7U7LBT9Ad+YF0VtcMzSfWUdwBSsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcvIETMfta7VqUP05J/bbisjEFM33gdHoBJPFG+WSPC+0HwbJpqwhbk6aTjhktGeOYvVpFXzWGnZzK45N24TZO/WuyJyt0OsOJLAKsLZ5tU2GSslCWeZSjuL1EsmWsf/WXirKm3S5M0CLo8DAxL1ut+TAek/IES15Vyz4pb5/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r79zyM5J; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r79zyM5J"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954dff6536so23156535e9.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096268; x=1786701068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CK5aAlE2gXWUQMLhZXJtBxJFs/yXRK0ivXNCpOMa24I=;
        b=r79zyM5JQ2IYlFzg++2oapCcw694JrZSBpghxHSyd70xbL5LmQHxtvfAC+1bOUi3FJ
         9bNGYpvH1ViQiR4zYULRKXlSgtTwnpZTBtnaf5AkOLdyMDI6dCoKFE0MZHhssjt/n5ir
         Ja9AGChwbDtTYGxXNLtM/gxCdmatW17pejVM5EWqk6DaANuFLyTlfQBPqi+efs7+YzLv
         /3hnwz+CRK9ERucw3b23Uq+VsYXDuRAqL0Qub68eXSm8GDaYzkdmPEIF27XlyGw/sv7v
         JFThhCDX/ixs2Hapk6Rftk4/m1JdxBwEzN6CggyIRnRvwQqu7Pl2FMF+ufPVrfkXjyzT
         11pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096268; x=1786701068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CK5aAlE2gXWUQMLhZXJtBxJFs/yXRK0ivXNCpOMa24I=;
        b=AVav9hif5vSIoO0gpOrUu746HKtdti0lKRezIzFXm7STaQ69dbXd0k64HErGxCxQph
         Yqa1m6OmI+l4wtyXqTOO5qo1h9wbFjfL8ElvK/mTEuXzVC+YYzl7TDh6Pd8WRHVv1+al
         8xAZWKwI/i05vAkskmqEGfJnKbESA2X7xb0k2bPUmEZbn+Vry5xVnIadp2QI5aWUHGDF
         bweY2KNPVun6pP0Ab0ZNOC3y6okBsvoEP5118rWQGqvDTYBBY9r1BHArBl31r13npsO2
         VodhzyqyLLfU04Ny2nJ2EdKBWfbIWfKw2hX3F1n1FrQ4MqYL66t9V1jmvzf9/7zZDjcP
         4/XQ==
X-Gm-Message-State: AOJu0YyoAvOK7MVU/pT3wT+F4MzLwxuq13feTnnMSlBI9kCMjjuKecwR
	kMCPYwk+kF/WLt2kE1Zhdb0kDJbJ7Hc2GhFUdEDHfD9x2qOYhU05oyGI
X-Gm-Gg: AR+sD121bXsyWMjd9Xlx4IO++sUGycC7oHjA5N6Qy6owEGq3F6khWS3pf8VSLL5pJeJ
	y8jd2SFTgXEjSuCBn2fisktzX+M/VIrRP58BUEVNLORNX5MjSMr+uvrUWBPlTBvnEQHhrh4KR5Z
	P6zsr6QjL4RcsXmGhw0IUzZDeHE0tg3WN3cjEbXzYFyHOPoQ5qkaRQNM2s6gL642W2p8AFzvtBh
	3iFa0X2FEn8bmIhAUEMhwGj56HSkl1Ix7KbfLC/8j4BTxZBf2afgJUAqzx/OMisTd04NBrQ/PGJ
	IYe6mrpCGm302G3fcr8uxfiaQuxMBmE72YQSNmKNoTaDNTgquVgMkqkrCVaG4II/KDVbqQy9AoR
	eR1zyimS8YzGXQsm2WjuLxIBbijL2Qojhittn80nakoVXAFm0XTT283zOEDtXecLzPygfjQ92Y7
	EAdV4QwNoDyDwpoJH7095Q0HnqRf+S9IDPWUUYgxhw4XwffTcF1KdfOhZJKPc/UB6Czi3mD7aEQ
	cneUHs35Zky9o65khDI
X-Received: by 2002:a05:600c:a47:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-49959e2eb00mr98245435e9.9.1786096268249;
        Fri, 07 Aug 2026 02:51:08 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea27b29sm31138585e9.11.2026.08.07.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:51:07 -0700 (PDT)
Date: Fri, 7 Aug 2026 11:51:05 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next v4 1/5] net: Add connect_socket() helper
Message-ID: <anWqiWgSNWARKBRi@gmail.com>
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
 <20260806182234.380833-2-mahe.tardy@gmail.com>
 <05084a53-a1a4-4e60-bdd7-6fd16ef6a029@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05084a53-a1a4-4e60-bdd7-6fd16ef6a029@linux.dev>

On Fri, Aug 07, 2026 at 09:53:51AM +0800, Jiayuan Chen wrote:
> 
> On 8/7/26 2:22 AM, Mahe Tardy wrote:
> > Add a helper that connects an existing socket while invoking the LSM
> > hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> > logic. Other socket operations have equivalent helpers that trigger the
> > appropriate LSM hooks that can be reused, this one was the only one
> > missing.
> > 
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> >   include/linux/socket.h |  2 ++
> >   net/socket.c           | 32 ++++++++++++++++++--------------
> >   2 files changed, 20 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > index 2a8d7b14f1d1..8964528e3823 100644
> > --- a/include/linux/socket.h
> > +++ b/include/linux/socket.h
> > @@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
> >   extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
> >   extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
> >   			     int addrlen);
> > +extern int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
> > +				int addrlen, int flags);
> >   extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
> >   			      int addrlen, int file_flags);
> >   extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> > diff --git a/net/socket.c b/net/socket.c
> > index 63c69a0fa74e..126a674f534d 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
> >   	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
> >   }
> > 
> > +int connect_socket(struct socket *sock, struct sockaddr_storage *address,
> > +			 int addrlen, int flags)
> > +{
> 
> 
> Please fix the checkpatch warning if revise
> 
> CHECK: extern prototypes should be avoided in .h files
> #27: FILE: include/linux/socket.h:464:
> +extern int connect_socket(struct socket *sock, struct sockaddr_storage
> *addr,
> 
> CHECK: Alignment should match open parenthesis
> #28: FILE: include/linux/socket.h:465:
> +extern int connect_socket(struct socket *sock, struct sockaddr_storage
> *addr,
> +                int addrlen, int flags);
> 
> CHECK: Alignment should match open parenthesis
> #41: FILE: net/socket.c:2107:
> +int connect_socket(struct socket *sock, struct sockaddr_storage *address,
> +             int addrlen, int flags)
> 

Yep fixed for next revision, thanks.
