Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323278;
	b=LITf58PKH0ONXYtej6CLPi5JZVWavRVJJjgHDJzd5cAPQZu9/x9xCLydhL2jjyF3Hr+S
	 W2ugViPYcvTnqQQCtfau6kSCdUCC5W6b1kZSIbMeoxSK9BoW1eqH2/8NK9ebSLkkQMCWP
	 EvO+rM6x6J6OIVjxmGG9ztgSEKpxiBfOsHNY2h93r1OxYsJzWg2rLIz/PSq335qy+WcB2
	 kp74ULfy2BopLRohVzGSrk3IISy+EcbCIXGoYfc2f+QjvIfUgkfbjmwtZBb3woSoiv6IG
	 nUnFFgiHftN7eMfrjdoSMHMuznOV2xooTCFcvLojMg9W9cA4/QIE6S/kTi8v5cY5XWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
	b=GRj1dd4Rep8u07BR0FSc1vZoT2wj2ZnWMsgxlPaelpjlNkhjzT4kltxXHCCVWkGaA9EA
	 Y+aBneSw5NFEGGDihNPgjMLIJrisYQgNl9XIl+DbZlVO+TvjhNf0CRTzEds3oNgOWmD3S
	 osy92zRwS5wtQDdWXR3/qUadmjoPz0qXtVpoHmDrtTEUiKbyFRsdZes6apODzpGwmXprC
	 BwV1tGXByxQ8diJgal0Oo874WoVgjX3LYAXK6WeN9ufAcWemxsOkvEHnjHrPWyBJUi2aq
	 fh30+CMiKuGpXO2OaNOmfWl3ImlGgzEHwYxzagqqYa6vA5IoRUcqfksRu6L1A8153rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1631B60A261B
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 15:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1631B60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso12775845ad.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323277; x=1794928077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=LHozpx7ZkQyIUBsAkv4C311vzxfheFN2pzrL9Y/FTHkEXQzaVUkMAz9U9wFUejAOr8
         YATASi40x9WcOvyF4dkS6SJQ2bBJHO0yE68WsOT8oewufPXMhMYT6O7d4/5H33a+EMHR
         jjCu1KqktdAA/9c8ZIpbjFjA/3BLyNbgEZc3fS3F9+PTZ5y3jCgkJQ9rhGft5ONP+cJO
         aTEF5vn9sQP8UWqDXO8UszNcV0yZFTKvtrsUk25y1Sz/3h5njQt9uj1PBQLO+FuWPgpB
         LsGoLTWDE/iFYFuKD+GJLya2PXFipxPXM8zYDthkWkjgd0549O004Xgoom3qc/ylK84T
         vykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323277; x=1794928077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=hDxqfPoxla4z+FzUIi8bCjL/7DSaW/GtL+2PTm6MdL9rSGtDuGVjwZmtDyUfY9Vgyo
         M2ti+S/CSw+9ovM1K1FmHTOf8LJqJkdNWff/9pHim1++jr3qJRtEz1UFvmf4F80rSBib
         5bi0Cp8r+IJQ8SGYL3/ixE3SF77MI4qOPss/jwKntUREipHDPnBU0ZwetUJiL64kcTeC
         q2l8cExgyyUVivZWLHfsgiu0xuMUJd6Ndd/LZQpgIUhDvxaYSgtPlR0+c/cIKZWvaSb1
         x2GnRb7kcC7UPLwtg75Mp8djqC3UhnqaeEATzwYJMRhmhEVhWAEz30axnB/TCckemjTj
         V6lw==
X-Forwarded-Encrypted: i=1; AL+hErHIxrF0WcfOFdzKCUXCG1qePaD+79qIbqR9s/W3lDWBImukyHhIdI3jhYKlr8wY7tVbxkA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4bqnWfupJ+EnWZabUZz0k2aTqiCn5coQxUPCqyQ2G9jN8SfZ2
	4pRn9cGLpKmb5OazOp8G2aZONgY9uMmH0SXAoRYM8fqxO1x7QrQzjFx7
X-Gm-Gg: AYBFou3SXVKOxUhN14K81/OdPWidC+OoYo7WZvgCc7yhsaJRzo/MTiBNKhx2EzZbKrd
	vm3bUaG1LKEgtY7qT2yzZ8wWkdu8ncRHi6R8BbfPmZWFLzeCnRkWrQRwVRuWvRZSMjbAHWJVw3N
	M40Yi8d16n/qbMCHBfnmASRQVrtjZE2dFIPAj+nbPmwY3YcCfZBrUOM78DH+xF0jtoCUP/MWVBh
	lSrrXpbSsd/W+XzcAyjZEq6GOrfUlORd/bP7P5AI1MDQ6fcxdIpD/iGijI4f3OC+dVYt9CVDgda
	6x2+ugAZr2Zg0ejKR2rNQytGw/JVb4pie/HfwA8K5VnP+B8sJwKtnAIiG3dLpJSAhOfldolRDpj
	0XIGMEgknX/NGA4CT711+IphERQk0VWK53l59cmi/HRtC1ZyxOf29AKInuD/4YQURJVcQKpBlRC
	zQOMPfkyqKMBMb4/ZsKPFB0PtHx2SLjHa77/BBULeF03i9n2J3WNLgn0FgsJZzrXrIPH6BBMuod
	A6ZZzQhLuBvpN3XcFQI0SyYiA6c26jcf1Tvc3BHL7LFpA0tK9UVoaMisv/OIRqJPSR5t2b0vOff
	dBhcm0cPHzmo1f0+9jsbeBP71J6C2+xexUzlp/jCCg2pmy6yYyfCDF22uL0w9FGgmDPpY8xkB8W
	EiCmtj6J5jok=
X-Received: by 2002:a17:902:d481:b0:2ed:1ef3:9ec with SMTP id d9443c01a7336-2edb9172a2dmr26826345ad.14.1794323276968;
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Received: from [192.168.2.6] ([27.75.101.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d78dbcsm10397575ad.27.2026.11.10.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Message-ID: <71f76e5e-ce24-4a71-863a-169ad262c510@gmail.com>
Date: Tue, 10 Nov 2026 22:07:46 +0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 36/41] nvmet: refuse files on pseudo filesystems as
 namespace backing files
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Language: en-US
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 4:14 PM, Christian Brauner wrote:
> The file backend takes any path that isn't a block device. With
> buffered_io=1 that includes files on procfs or sysfs which then get read
> and written by a kernel worker on behalf of the host. Refuse files on
> pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  drivers/nvme/target/io-cmd-file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index dfa8aa46188c..71c69bac5394 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -52,6 +52,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  		goto err;
>  	}
>  
> +	if (file_is_pseudo(ns->file)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
>  	nvmet_file_ns_revalidate(ns);
>  
>  	/*
> 

I noticed patch 41/41 doesn't include a test for nvmet. Would it make
sense to add one with buffered_io=1? The test would need a pseudo file
that can be opened with O_RDWR and supports both read_iter and
write_iter. Otherwise, it could pass without ever reaching the new
file_is_pseudo() check.

Thanks.
