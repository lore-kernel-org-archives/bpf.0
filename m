Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565562;
	b=4++bzlYEfhdRoDgCCvqqI5y7BgSE0LLFpACIZ8qlqM8XpCRnpMZh4MlnNh1U52ttdEu/
	 YCogkCzWuOOiReuR44g/hk3wBDkFxcS9v+x/DxY72CctNcBvMusjv9QeiE4z06RdJ7SIz
	 FTEtvwUCl6DpW+T7v5hDtg0Asi78iv/26BTk1nlwKaMyudI2vEuZgzSbhr6zwa3Ixf6NX
	 lwg7KN4T3LNTHT/v3cK3G/q+b1DyJ1ke4El3NJFxGCaZMeezLzdHqNIgl/8iRXBiHEz56
	 RU64keBeSD/OjboNfzQBmb0zcSJZys9T2FAisaCFuYzgTAZKJRJGaIkvqWOzuIsaw/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
	b=ucbAdBssVqjajY7mNgis59WLFYULqOvARoUD3heP3vTbQ/tCkP/Df4/mHBMfmfT+2dg/
	 JEkCKnIAXFVdDcF865NJBQdarb4MEVK/ia51lHxJ7+FeYCSB0GNHYU2EcypQX+YAZQooP
	 TMVFmgTwj9wIwmXmMzLmJqRRE7nDyiElbci2A/p2/LBZROWNWPeE0mkbZrYZvdDGalB1k
	 uN7ZiUjxA0UjWAhOaBV6B+0B/7KkXkE//43Ua5toVtnvTDUchyM/pRgvrg5+ppCZGVw3G
	 BwhvY+PFQ38v87jLkRGEdpONM7rAGQbOzNVsV7wXFfsVZLVWkjtLatI5T5B5EAi9zLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FF606A889
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C93FF606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso1224255e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565560; x=1795170360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=EhCy1rjVxVdFrlqlBXdnWdhZOgju6UqPO7MHP0T5eDQlLH3bu4fGnJjBmSeu+X4e2W
         fqknndYp9WUsPcSw+hMOJQKeOCVQ26f4CApHOuaHiz0ZnrEcpw06GAGjRX2e/v0KskXR
         kPbczhlJA2JL/E3RYwJYZ55bjMsTqV1bcwrFG/iNBMGzSlTlhWz25UxyOw6nI4axYZSB
         u0krz81cE8qJBpZN+Gj0XIkGJFuZa0vCttP7+3dXPKfvLd7fzcQdMwTNK/JaleYs6P1m
         dJAReh6EvrYwFB4nFlJdvgjX0mrHV5c8k7KozarvFnbaOIXtcKdLHY5nOcL1YTJjLQtf
         x2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565560; x=1795170360;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=yrv6vfydxBbKfmyhx8o9//1PilRo8mGiFh9dXIs+PVtHVRkG98ZmAF0V+WfATtqCaN
         80YD44++uUKRaNHU8kKcRBPhivG6T2AQaMyh109W8+yN0+xgwd0KK0rSS95B+FqEJ9ut
         yQZ10ieG0mLnpXmIPr3tlfVMp4bqU2nbY3TmH0JG6/qiXo3F6z/pfR1IjAC25u8T3GiT
         6T5Vdm5cOCpW4v+7CW+wtjyy8T1C6hHyBYxY4rGuUip1seMFkh9eWz08FvDNfaMnki32
         VwCw30n3ae3AsdCKpy4GlAQImpzHxZQCtxmUV8p9s0Z7sT9X9vCyY+/4Lj7WQk99Ot0n
         WKiQ==
X-Forwarded-Encrypted: i=1; AL+hErHMKEpuDDNcNS2HY/V0nwIxLzw5qLgFIQAjacQl2aU3xyqU5XYGFoTiiNyD3nan9eG9z0Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9arfgLTUNK8SjcfDg/MIOOGQfOsruoCDiq2KSAY6HNXtoPaka7
	d581pIiwow8dbA8Z5Hc/a+SA+7bjCWQFT/qchTj9F6NRc0PROV/HVlr0Qfp780YiDoOu
X-Gm-Gg: AYBFou0IumGeRbFqWudSgEd9jOxvvY7b0I2UrV81oXk6RpqLemQSl53aa7CzCDVTVEV
	2ejrmG+DGH7j3j9T6UWpsoqhOG2xbErhXxqFH5v36aO3eWeclKvZbstPvIcIB0twYc0LxFeAZz6
	D2ulHjc/YT18Dc+m1VokJ2wmbWhjm22O05BvesNgr9Rl/ct0iR3OYaXOwLFJ8zKsyMLu3Ec31QP
	QAWDjvIxWp5ghyrUDJAdfYCYHQZnbdT7Wzwr8HINbLUVvHPu3zqnSgWeMOwhP288DZ2M6Xx+GIn
	A6LxTXZurvbJoGkBi/GG6UBYCRUiOqQ2TWS8UrpJOYW/JGDUEMjeH+kzxdRAD2dn4HYSfWzB9su
	n4S5xXSFqCLpPdthmwgu5FeTNkY2mBJO25ooxMlhyjZtITI/HftRrLA9PDBWTavjA9G0uLw71W2
	w6nS+EgSEhMnmhjU/gEVg5x3qCftX/8JMC7uZvTBRI+A3bPmwXHOKLSf2tFUZFR4qQDFr7UIwtS
	TRom6N6eOqY0BC9rCbMJA9cpLNEmOseTzl4l4+bDGeGqlInnys3QuGXoDoDLBs+1Sz5sz3g5j7J
	bbVnpwKrM2FEtqskVrg+oXdncQVY26j3GKLZd+2XDEFfgnRPj+j6+B3gmguLj5A=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr38995625e9.33.1794565560090;
        Fri, 13 Nov 2026 02:26:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm244439965e9.1.2026.11.13.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:25:59 -0800 (PST)
Message-ID: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Chris Mason
	 <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:25:57 +0100
In-Reply-To: <20261111151202.GA11391@lst.de>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
	 <20261111151202.GA11391@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Christoph,

On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> I've seen setups where people use fuse to mediate access to sysfs
> sysfs in odd ways.=C2=A0 No idea if that's still around, but if so, this
> patch will break it.


Oh, that's painful. Do they use backing files for that?
It's a relatively new feature in FUSE...

Kind regards,
Alex
