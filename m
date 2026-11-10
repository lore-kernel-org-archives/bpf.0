Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305680;
	b=rwJtQUAzRqA7Z3ETvARG7thO9EQx1tMeyMW5+U+HWtsaMKGcckbyDYnX2F6c3+Om28Ot
	 hcAsPF8SFpc4i7h1bPvFuu5ySgol0gFlK8Ai42gaVhNt3rXt6zP5eXOyLhOQrDz2Aw1Sz
	 Suex9m5ySK1QYnLp3BN6cZva/a7y8a6o/aA2EIMZduhS9kqQ9Jm1HKnONxFIuocy+aHrJ
	 mXJJoXEfqd07EEAc7Sz1hhkh7TzVzgOmxuSzp04tfKDLBb+CM+jJSxOAS+qRfXG4Vht/Z
	 2Qn5Jh+upnmFRdQfwTjcGjSSjLyC7B4IWT2KydbkJnB1mtd77kCjjDh+CFTx9rBeUAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
	b=Yt+g+6GF8kfIjYXkEIUYRcER6bC/fPjKXguab+bVnymk0GiyTbzuz+gbSDgvdITmdW7H
	 edbtaoDQJfn8HBU8M2kJkm5fZ4nDa+qStimNIY4XISjcqtufL4c4WfI0tnunY3KmNbZhk
	 djCYwTixiQsdfYOlr/zImos30h0jOCfh/toKV+Bvq8CwvM75wgeUb99/XeoVXHFm1W+yK
	 /7aKzc1Jbc/OU659VJeoUWRYBXMkwsHsRbhepkQXMkrhF9bThilPemA5fqhZ36HWbCEah
	 mr1kVuyGoDYtv0ZMPQpTLQhjTqc5V15c+WsNMOem4wZ/jhDRjcJ5/Zd2/AwtGpOGk6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173F606AA47
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 10:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9173F606AA47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b56bbf8330so2383290a12.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794305678; x=1794910478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=DrlQYRb4d+FJBQLFk4gip1vdMb9pZcbFm0QRoW/O9nsnnIGk5B/dcI7komCKzkv/uM
         Uz0TTkL3EB0XOLA2v0TTxwYvqDOvah1wiwbB4uUsiRRXfj1OcdvtnHWnMQS6yfKTNN5Y
         2S+sbZpFj/oUd6OIfB1K+t4luOgmpm8MRta8dNUBz+XdEb16ui6jztHrAySR2QYDDBtW
         UcH7ksMk3kyTCuhLg24n4RSbgP43bR1MD63YWBBHbNHKba+s6Adtgd3r0iiTavTYgvkx
         vCBmyxhjfzRfUpjuhY0K7x1CK/3uUIf/0FzbTbFW5bHu/k5G1xko0Cr6O3LrrObY61iA
         y+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794305678; x=1794910478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=kt0Ze3gWPfBrRoFPa4wX0HoZhazbey7XQgbUT+sNNxSwzFWUpxEp81b9yHuLDIf4/a
         rg5YKxGsSCA5wxTGCW9bLmogXNE4ynVITUpwqb2EAB9o+RwImiwFJYQYCUuYZ46QWjGL
         +HeVsPz2BadxXwvMCT7QAdApdPXJto7tnqdgIxR1+KrdGtJREiKNlQeONPtwStNx8JEE
         e8sMBfL8yNStd/GsVDDbKY/tm4urkHlnbpq3lT3f8pHLeqtKoXh9M2MzIp5GwMhMlC+N
         pKdLQiabjEP/J+XPbGPFm/SnB6mcNkEioTG+5VBs33DtYGhOpBO9lmz9/hQRaq6Dr2BT
         ljEQ==
X-Forwarded-Encrypted: i=1; AL+hErFB0DE6mtjABo4rGVP9l09kO7lklS+me9VijHHuoN9TO7K+P3zBUgr6oomG/STgvlnyg9s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8465xNIUKX9KwOPIKudo32nQeA9szu9UcPIp++p5oSCbVuTikQ
	Dq5+O3KOyt+/zKV5bU57z6ew7OXwr2hkIC7Hfnz21pXzgC4wOxK+g5Mm
X-Gm-Gg: AYBFou2HuZ5XmuC5bbJTsFDWTkAyi1Vu2ZSywpxUGoW5WmGp8RVmVr1MQ+jqvnNnsbL
	W7Ur2Ie5kY77yJzP/T0vB34+H0HD1KRAA8/cg2DIChy2yLGz/ft0d5Dn+T4Cc3kRLKFQLfTAEeT
	adYAkJXl+FrOpkfBKN66uWSILf1BxDx/k7qzCv2MyfD30eKx2KZ2H7rmPI22okS58DXHqejO31U
	WXI3IFTRLJVC0VPritl7TgPF6TIj3LS9HEKM6pxfL1en/XT6HJ+v8yTmP2i+tPQVLOGI6Ra04yC
	YqNnZaKyJU1qrYHCEpmpr3xcMjkbkswQ/BNXxzpidOHAzwyWNUInub0bLfNupGCINYp9CGkYBly
	25vyhUSjXKDX4Syn9Rcq6wl6AWoqlZnJZIrUB6d801kZpPxcopf0fGw+e2TTSL6lPsVJo5XEWc6
	XgGtFxDRIZK/QPxb5Xv0LB4P/HFdtqNbry4jGx2MdnK0pyAdv3T6SLk/mTCAw8uscoy0uq3u3Ub
	dHT++l+kzWrZvV3HpmItpf1fZFvXemZslu0WsP71GmJ+DfdUSaFmy9Y+7iGR1U1+RCaRjXYYar2
	PlR+gseKITnq4KzBy/ThbGlRawMgrbBDdRvMxXZfT23Xgr0T3FOv4uh9BiwWPGYKBAsLu7R6UJH
	2NsfGK8ES7/A+
X-Received: by 2002:a17:907:944d:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c504963ce05mr189793966b.44.1794305677695;
        Tue, 10 Nov 2026 02:14:37 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593eacsm90433466b.36.2026.11.10.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:14:36 -0800 (PST)
Date: Tue, 10 Nov 2026 11:14:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avLui6Mpf8GbKbtc@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>

On Tue, Nov 10, 2026 at 10:14:54AM +0100, Christian Brauner wrote:
> The fuse server can register any regular file as a backing file. procfs
> and binfmt_misc files are already refused by the stacking depth check as
> both set s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH. sysfs and the
> other pseudo filesystems aren't. Reads and writes of the fuse file would
> then be done on the pseudo file with the fuse server's credentials.
> Refuse files on pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fuse/backing.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 8c21a8a74efb..4e4fb810ddaa 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -147,6 +147,9 @@ static int fuse_backing_open_file(struct fuse_conn *fc, struct fuse_backing *fb,
>  		if (inode->i_sb->s_stack_depth >= fc->max_stack_depth)
>  			return -ELOOP;
>  
> +		if (file_is_pseudo(file))
> +			return -EINVAL;
> +
>  		fb->type = FUSE_BACKING_PATH;
>  		fb->path = file->f_path;
>  		path_get(&fb->path);
> 
> -- 
> 2.53.0
> 

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

