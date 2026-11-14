Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686759;
	b=rhVZAyG1BGbBYqAZXIeBAEm6lLq7R97QjxBEzYwlEhMYXyheUUJNPH8z/Qp/Xn30Uhvx
	 ih9Tvq37iTV09R3I0CmhdGyCA94jyCLBlAz6vryW7qt1qUNw/7BmX4O1d9n8baOAjFfIf
	 7WisFJWW3N9HnmG479vle76Kxw5x6cRnXOSdtBSwGdI9lUmncaZJNv6W7gft9Tfy0up4x
	 Dbt6SmcGlL2ouRTgynZvslvlHMitofNHe0DLKzbT/BWpX90DQ4IZDTvQTVZZPzR/2qD6N
	 +AUzt4wKtE/JQ38z89+hJo6bGj4To0mp4fq3U63mETQZ6k9IbjOVWA7eY7v3HMA1kYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
	b=GxB5WtRDRdfAWhQucl5PEdAFUnNZr0/ZAgsMHoTFEcEkBMKgXpUxOuqeFmcpU6cm/PhZ
	 OOzDSo1koPfHsDp78ZPGKU5Iyzk4UZBJym3sETQBHIDdsGoHRIxdESRZpD0F0+RSG9DTB
	 7cwyprhBAY3Ys8AhAr8aHhTjZcn9l4I9qxHHXXhcrqRbcyHLxDtXh74sgWlsHjp+x5ulI
	 pxA+QaYOe12cn2gq3GgaOtLpapWirzGIItvMp87QqKfDv1lmK8uAmBCHKEEEuItCW2RCs
	 ZmaR+X//kNGQPrtqh2pQHaF+CIO4UXg21Bc1qnr1vwEqIfhtHqveXF0/KFQF3ZlEd4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42A606A8BB
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 20:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D42A606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso835205a12.2
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686758; x=1795291558; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=t4xxtvlP4RAICjpBIWPIkESb6EJJVOcRd9+LEytv251d1ZQsfD2pYblwETMOf/zroc
         BDzAo5elUgpAiRA0oYEfExHYSjjGywxztBxThvGs665InMbo4S8LytfXKr2B4Cw2IX6x
         hCl30XcWjOl3zGKKK0Vny1KN9lt2zjyLiPz3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686758; x=1795291558;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=KUahd/RPyrwuTYBRAY/RSqmXeXesF7hKZKPQf7M0rJWPUcQ5yKXQ+2BAEi39K/JsKi
         YRU1MsweFIsrMY1rIJdOEILnce+MeP1lJkwJSjHph+yl+Z8+KHtfNK9XoGHu63P14DfI
         HK72sic6nlQ1DcTvMKd4vfTikG6uzzsN8TBRx+DL0Ytxkc7qYs0ctVoi8aueilrHwpXy
         jq0v+yWgZqPKCHz6ht5lx1LO1NSQUQqmcqfuVOmVjOvAs7PEF4Meq0awycjMY62Xzm7j
         B7zpmPU4VP/SFMxgMp/ik6p+BHgNTKXM6Eysd8YQUi4xKZPXS99LjSqEU1AE6gJbVaMP
         HAvg==
X-Forwarded-Encrypted: i=1; AL+hErFn1YHR3wFXC7eTAfzgz4bvdK4YFA5FWV66tfYN9cMD0cuQc+4is/zYgvZJiPG1ZCi7WvM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DPtXQ+dHHNHgLuzt+m1GthIUFfUKQXCc1VDmaObb8/4bLyOF2
	9LyEfPhizK7egI1vVe9LiGEhsIN4k+Loizgev5YbDMZ4xhxTH+uVsh2spTOLVL1kybU=
X-Gm-Gg: AYBFou1CNvFDxkBRxSUOKc1kJUqNTAxoKDUGzoQOwXIS01DaJvYaUkb+85DKtiJO3YZ
	Ns93dlZDVdowTcqxdGVj2H21w9gOa4/v8uFkzlAfIvxYsGpEPDV/rkCL6tnac20vdlF/KZ3zbR9
	6uyDHvAKvyF7h1mSSOTsxJ7/HOXuBf+LSoeLsgzcoasIEC4sOcZ3s0uvlUFCLFHk/ksfpyGRE13
	D6LqL12zG0SdWzQYJtxUHxD5TYmzJWWrTxR9wRlIicB2myCTil3aLpbcFR/GM0s8fUS3ihNyrr1
	G+Jrzqpa+JbVrn1gU8y0G3Xro2dDec6bxs6THZMGwSQC8+yI8jTymj4QJ3mAJvGyhqJgpu4qzlD
	wIwu719rzvBPz13h7Eoq9mXTUknyC28WpgNdamCzL+Zvb23GjS6U4/ce/0Am+b4fb/QTiNbtyJK
	L34Cu+ka6QaUcWvdJqq1U2RWkfBWEsR2jpW2wxcwPwyYcOP2UF37koyrIJT+M6t+BWUgyYBKvoN
	CAUVNzngp/2dQUhbONtwzkGGwnzx007sxs5M1pbdcxyQwbNkm5t+Z+NMQH1cLwLrpUVV/0tfg8m
	yNbLDmNWxa+DZvgRE7q9+/JNH2kj0bWFC4l/k65e+jSeTpEZYicGef/05mb5vQqtE5m1Bxf0X9Z
	SyWd4kkIs5mA0MZu5glj5Y3PG0bsMKh2tTndcvkTdwPpdE9rwDkO7flZib53MGbdUF/JtJQbQ4L
	sq5UO+cbG6Xy8qTyxl4fAynhnaSkHJNxfsl8KWcOYImhYuonPk0gU+QVTQ
X-Received: by 2002:a17:90b:3b8a:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b1b0b5f2c1mr6192503a91.52.1794686758572;
        Sat, 14 Nov 2026 12:05:58 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm4654869a91.1.2026.11.14.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:57 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:55 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>AppArmor puts a .null device node into securityfs but only ever opens
>it via dentry_open() which doesn't care about SB_I_NODEV.

Not a big deal, but userspace can see that node too, as
/sys/kernel/security/apparmor/.null. Opening it by path works in current
kernels and fails with EACCES after this patch. Now, I don't know of
anything that does that, but selinuxfs gets SB_I_NODEV cleared again in
the next patch for the same kind of node, so I think we should do the
same thing here. If not, it would be good to have a line in the
changelog saying that opening it by path is meant to stop working.

Once that's fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>
